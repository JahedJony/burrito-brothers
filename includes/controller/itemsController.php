<?php 
session_start();
include '../dbConnect.php';	
include("../dbClass.php");

$dbClass = new dbClass;	
extract($_POST);
/*
if($q=="insert_review"){
	$comments	 = htmlspecialchars($_POST['comment'],ENT_QUOTES);
	$review_name	 = htmlspecialchars($_POST['review_name'],ENT_QUOTES);	
	
	$columns_value = array(
		'product_id'=>$product_id_review,
		'review_details'=>$comments,
		'review_point'=>$rating_point,
		'review_by_name'=>$review_name,
		'review_by_email'=>$review_email
	);	
	$return = $dbClass->insert("product_review", $columns_value);	
	if($return) echo "1";
	else 	echo "0";	
}

if($q=="get_comments"){
	$sql = "select *, DATE_FORMAT(review_date, '%W %M %e %Y') r_date from product_review where product_id=$product_id order by id desc ";	
	//echo $sql;die;		
	$stmt = $conn->prepare($sql);
	$stmt->execute();
	$result = $stmt->fetchAll(PDO::FETCH_ASSOC);		
	foreach ($result as $row) {
		$data['records'][] = $row;
	}	
	//	var_dump($data);
	echo json_encode($data);	
}

if($q=="getOrder_status"){
	$sql = "select order_status,order_noticed, payment_status, ifnull(payment_method,3) payment_method from order_master where invoice_no='$order_tracking_number'";			
	$stmt = $conn->prepare($sql);
	$stmt->execute();
	$result = $stmt->fetchAll(PDO::FETCH_ASSOC);		
	foreach ($result as $row) {
		$data['records'][] = $row;
	}	
	//	var_dump($data);
	echo json_encode($data);	
}
*/


switch ($q){

    case "category_view":
        //echo 1; die;
        $data = array();
        $sql = 	"SELECT id, name, code, photo,  c.id, c.code, c.name, ifnull(c.photo,'') photo
					FROM category c	ORDER BY id desc";
        //	echo $sql;die;
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        foreach ($result as $row) {
            $data[] = $row;
        }
        //$dbClass->print_arrays($data);die;
        echo json_encode($data);
        break;


    case "menu_view":
        //echo $menu; die;
        $data = array();
        $sql = 	"SELECT i.item_id, i.name, CONCAT(LEFT(i.details,110),' . . . ') as details, i.price, ifnull(i.feature_image,'') photo 
            FROM items i
            LEFT JOIN category c ON c.id=i.category_id
            LEFT JOIN (
                SELECT item_id, MIN(rate) as rate, id as rate_id
                FROM item_rate
                GROUP BY item_id
                )r ON r.item_id = i.item_id
            LEFT JOIN item_image im ON i.item_id = im.item_id
            WHERE c.name= '$menu'
            ORDER BY i.item_id";
        //echo $sql;die;
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        foreach ($result as $row) {
            $data[] = $row;
        }
        //$dbClass->print_arrays($data);die;
        echo json_encode($data);
        break;

    case "single_menu_view":
        echo $menu; die;
        $data = array();
        $sql = 	"SELECT i.item_id, i.name, r.rate, ifnull(im.item_image,'') photo 
            FROM items i
            LEFT JOIN category c ON c.id=i.category_id
            LEFT JOIN (
                SELECT item_id, MIN(rate) as rate
                FROM item_rate
                GROUP BY item_id
                )r ON r.item_id = i.item_id
            LEFT JOIN item_image im ON i.item_id = im.item_id
            WHERE c.name= '$menu'
            ORDER BY i.item_id";
        //echo $sql;die;
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        foreach ($result as $row) {
            $data[] = $row;
        }
        //$dbClass->print_arrays($data);die;
        echo json_encode($data);
        break;

    case "getOrder_status":
            $sql = "select order_status,order_noticed, payment_status, ifnull(payment_method,3) payment_method from order_master where invoice_no='$order_tracking_number'";
            $stmt = $conn->prepare($sql);
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            foreach ($result as $row) {
                $data['records'][] = $row;
            }
            //	var_dump($data);
            echo json_encode($data);
    break;

    case "menu_options_view":
        //echo 1; die;
        $data = [];
        $item_id = $item_id;
        // get item details
        $sql = 	"Select i.item_id,i.price, i.name,is_combo, i.category_id, i.details from items i where i.item_id=$item_id";
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $data['item']=$result[0];

        //get options name and id
        $sql = 	"SELECT id as option_id, name as option_name,item_id, is_required, minimum_choice, maximum_choice 
                    FROM item_options 
                    where item_options.item_id=$item_id 
                    GROUP BY item_options.id";
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        //$data['item']=$result[0];
        $data['option']=$result;
        //var_dump($data['option'][0]['option_id']);die;
        //$tem_data = [];
        $i = 0;
        foreach ($result as $option){
            $data['option'][$i]['ingredient']=[];
            $option_id = $option['option_id'];
            $sql = 	"SELECT id, name, ingredient_id, price from options_items where option_id=$option_id";
            $stmt = $conn->prepare($sql);
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            array_push($data['option'][$i]['ingredient'], $result);
            $i+=1;
        }

        if($data['item']['is_combo']==1 || $side_item==0 || $data['item']['category_id']==45 || $data['item']['category_id']==6 ){
            echo json_encode($data); die;
        }

        $sql = 	"Select name from category where id=45";
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result_cat = $stmt->fetchAll(PDO::FETCH_ASSOC);
        //$data['side_item'][0]=$result;
    //var_dump($result_cat[0]['name']); die;
        $sql = 	"Select i.item_id,i.price, i.name, i.details from items i where i.category_id=45";
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $data['side_item'][$result_cat[0]['name']]=$result;

        $sql = 	"Select name from category where id=6";
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result_cat = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $sql = 	"Select i.item_id,i.price, i.name, i.details from items i where i.category_id=6";
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $data['side_item'][$result_cat[0]['name']]=$result;

        //$data['option']=$tem_data;
        echo json_encode($data);
     break;

}

?>
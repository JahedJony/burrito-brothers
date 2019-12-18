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



}

?>

<?php
session_start();
include '../includes/static_text.php';
include("../dbConnect.php");
include("../dbClass.php");
$dbClass = new dbClass;
$conn       = $dbClass->getDbConn();
$loggedUser = $dbClass->getUserId();
extract($_REQUEST);
switch ($q){
    case "insert_or_update":
        //echo '33'; die;
        if(isset($coupon_id) && $coupon_id == ""){
            //echo '33'; die;

            $check_coupon_name_availability = $dbClass->getSingleRow("select count(cupon_no) as no_of_coupon from cupons where cupon_no='$coupon_no'");
            if($check_coupon_name_availability['no_of_coupon']!=0) { echo 5; die;}

            $is_active = 0;
            if(isset($_POST['is_active'])){
                $is_active = 1;
            }
            if(!$customer_id)	$customer_id = NULL;
            //echo $customer_id; die;
            $columns_value = array(
                'cupon_no'=>$coupon_no,
                'customer_id'=>$customer_id,
                'entry_date'=>$entry_date,
                'start_date'=>$start_date,
                'end_date'=>$end_date,
                'c_type'=>$coupon_type,
                'amount'=>$amount,
                'status'=>$is_active,
                'min_order_amount'=>$min_order_amount
            );

            $return = $dbClass->insert("cupons", $columns_value);
			
			/****************              notification start       *********************/
		
			//insert_notification($order_id, details, notification_user_type, $notified_to, $notification_type) 
			//param: order_id (int), make it null for coupon
			//details (text), 
			//notification_user_type (int) : 0=customer, 1: admin, 
			//notified_to (int) : make notified_to null if notified target user type = admin	
			//notification_type (tinint) : 0: order_type, 1:cupon_type
			
			if($return){
				
				$coupon_details = $dbClass->getSingleRow("SELECT c.cupon_no, c.min_order_amount,
													CASE 
														WHEN c.c_type = 1 THEN concat(c.amount, ' TK')
														WHEN c.c_type = 2 THEN concat(c.amount,'%')
													END AS cupon_amount	  
													FROM cupons c
													WHERE c.`status` = 1 AND c.id = $return");
				
				$details = "We are offering ".$coupon_details['cupon_amount']." discount coupon no (".$coupon_details['cupon_no'].") which is valid from ".date($start_date)." to ".date($end_date)."";
				
				if($customer_id == NULL || $customer_id == ''){
					$customer_ids = $dbClass->getResultlist("SELECT customer_id FROM customer_infos");
					foreach($customer_ids as $id){
						$return_notifiction = $dbClass->insert_notification(NULL, $details, 0, $id['customer_id'], 1);	
					}	
				}else{
					$return_notifiction = $dbClass->insert_notification(NULL, $details, 0, $customer_id, 1);	
				}	
					
			}
			
			
			/****************              notification end       *********************/
			

            if($return){
                echo "1";
            }
            else{
                echo "0";
            }

        }
        else if(isset($coupon_id) && $coupon_id>0){
            //var_dump($_REQUEST);die;
            $check_coupon_name_availability = $dbClass->getSingleRow("select count(cupon_no) as no_of_coupon from cupons where cupon_no='$coupon_no' and id !=$coupon_id ");
            if($check_coupon_name_availability['no_of_coupon']!=0) { echo 5; die;}

            $is_active = 0;
            if(isset($_POST['is_active'])){
                $is_active = 1;
            }
            //echo gettype((int)$customer_id); die;
            if(!$customer_id || $customer_id == ""){
                $customer_id = NULL;
                //echo $customer_id; die;
            }

            $columns_value = array(
                'cupon_no'=>$coupon_no,
                'customer_id'=>$customer_id,
                'entry_date'=>$entry_date,
                'start_date'=>$start_date,
                'end_date'=>$end_date,
                'c_type'=>$coupon_type,
                'amount'=>$amount,
                'status'=>$is_active
            );
            //echo '33'; die;

            $condition_array = array(
                'id'=>$coupon_id
            );
            $return = $dbClass->update("cupons", $columns_value,$condition_array);
			
			/****************              notification start       *********************/
		
			//insert_notification($order_id, details, notification_user_type, $notified_to, $notification_type) 
			//param: order_id (int), make it null for coupon
			//details (text), 
			//notification_user_type (int) : 0=customer, 1: admin, 
			//notified_to (int) : make notified_to null if notified target user type = admin	
			//notification_type (tinint) : 0: order_type, 1:cupon_type
			
			if($return){
				
				$coupon_details = $dbClass->getSingleRow("SELECT c.cupon_no, c.min_order_amount,
													CASE 
														WHEN c.c_type = 1 THEN concat(c.amount, ' TK')
														WHEN c.c_type = 2 THEN concat(c.amount,'%')
													END AS cupon_amount	  
													FROM cupons c
													WHERE c.`status` = 1 AND c.id = $return");
				
				$details = "We are offering ".$coupon_details['cupon_amount']." discount coupon no (".$coupon_details['cupon_no'].") which is valid from ".date($start_date)." to ".date($end_date)."";
				
				if($customer_id == NULL || $customer_id == ''){
					$customer_ids = $dbClass->getResultlist("SELECT customer_id FROM customer_infos");
					foreach($customer_ids as $id){
						$return_notifiction = $dbClass->insert_notification(NULL, $details, 0, $id['customer_id'], 1);	
					}	
				}else{
					$return_notifiction = $dbClass->insert_notification(NULL, $details, 0, $customer_id, 1);	
				}	
					
			}
			
			
			/****************              notification end       *********************/
			
            if($return) echo "2";
            else        echo "0";
        }
        break;

    case "grid_data":
        $start = ($page_no*$limit)-$limit;
        $end   = $limit;
        $data = array();

        $entry_permission   	    = $dbClass->getUserGroupPermission(78);
        $delete_permission          = $dbClass->getUserGroupPermission(79);
        $update_permission          = $dbClass->getUserGroupPermission(80);

        $category_grid_permission   = $dbClass->getUserGroupPermission(81);

        $countsql = "SELECT count(id)
					FROM(
						SELECT id, cupon_no, c_type, start_date, end_date, entry_date, amount,`status`,
						CASE status WHEN 1 THEN 'Active' WHEN 0 THEN 'In-Active' END status_text 
						FROM cupons
						WHERE status=1
					)A
					WHERE CONCAT(id, cupon_no, start_date, end_date, status_text) LIKE '%$search_txt%'";
        //echo $countsql;die;
        $stmt = $conn->prepare($countsql);
        $stmt->execute();
        $total_records = $stmt->fetchColumn();
        $data['total_records'] = $total_records;
        $data['entry_status'] = $entry_permission;
        $total_pages = $total_records/$limit;
        $data['total_pages'] = ceil($total_pages);
        if($category_grid_permission==1){
            $sql = 	"SELECT id, cupon_no, c_type, c_type_name, start_date, end_date, entry_date, amount, status, status_text,
					$update_permission as update_status, $delete_permission as delete_status, customer_name, customer_id
					FROM(
						SELECT c.id, c.cupon_no, c.c_type, c.start_date, c.end_date, c.entry_date, c.amount, c.`status`,
						CASE c.`status` WHEN 1 THEN 'Active' WHEN 0 THEN 'In-Active' END status_text, 
						CASE c.c_type WHEN 1 THEN 'Flat Price' WHEN 2 THEN 'Percentage' END c_type_name,
						c.customer_id, ifnull(i.full_name,'') customer_name	
						FROM cupons c
						LEFT JOIN customer_infos i on c.customer_id = i.customer_id 
						WHERE c.`status` = 1
					)A
					WHERE CONCAT(id, cupon_no, start_date, end_date, status_text) LIKE '%$search_txt%'
					ORDER BY id desc
					LIMIT $start, $end";
            //echo $sql;die;
            $stmt = $conn->prepare($sql);
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            foreach ($result as $row) {
                $data['records'][] = $row;
            }
            echo json_encode($data);
        }
        break;

    case "get_coupon_details":
        $update_permission = $dbClass->getUserGroupPermission(80);
        if($update_permission==1){
            $sql = "SELECT c.id, c.cupon_no,c.min_order_amount, c.c_type, c.start_date, c.end_date, c.entry_date, c.amount,c.`status`,
					CASE c.`status` WHEN 1 THEN 'Active' WHEN 0 THEN 'In-Active' END status_text, 
					CASE c.c_type WHEN 1 THEN 'Flat Price' WHEN 2 THEN 'Percentage' END c_type_name,
					i.customer_id, ifnull(i.full_name,'') customer_name	
					FROM cupons c
					LEFT JOIN customer_infos i on c.customer_id = i.customer_id 
					WHERE c.`status`=1 and c.id = $coupon_id
					ORDER BY id";
            $stmt = $conn->prepare($sql);
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            /* $get_coupon_details = $dbClass->getSingleRow("SELECT distinct cupon_id FROM order_master m WHERE m.cupon_id = '".$result[0]['cupon_no']."'");
            $data['coupon_details'] = $get_coupon_details['cupon_id']; */

            foreach ($result as $row) {
                $data['records'][] = $row;
            }
            echo json_encode($data);
        }
        break;
    case "delete_coupon":
        $delete_permission = $dbClass->getUserGroupPermission(79);
        if($delete_permission==1){
            $columns_value = array(
                'status'=>0
            );

            $condition_array = array(
                'id'=>$coupon_id
            );

            $return = $dbClass->update("cupons", $columns_value,$condition_array);
        }
        if($return) echo "1";
        else 		echo "0";
        break;

    case "customerInfo":
        $sql_query = "SELECT customer_id, full_name FROM customer_infos	WHERE status = 1 ORDER BY customer_id";
        $stmt = $conn->prepare($sql_query);
        $stmt->execute();
        $json = array();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $count = $stmt->rowCount();
        if($count>0){
            foreach ($result as $row) {
                $json[] = array('id' => $row["customer_id"],'label' => $row["full_name"]);
            }
        } else {
            $json[] = array('id' => "0",'label' => "No Name Found !!!");
        }
        echo json_encode($json);
        break;
}
?>
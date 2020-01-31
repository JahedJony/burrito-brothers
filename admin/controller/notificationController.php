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
	
	case "insert_notification":		
		/* $stock_alert_product = $dbClass->getResultlist("SELECT r.id, r.stock_quantity, CONCAT(p.name,' >>',s.name) p_name 
														FROM product_rate r 
														LEFT JOIN products p ON p.product_id = r.product_id
														LEFT JOIN size s ON s.id = r.size_id
														WHERE p.sell_from_stock = 1 AND
														(
															SELECT ss.stock_alert_quantity 
															FROM settings ss 
															WHERE r.stock_quantity <= ss.stock_alert_quantity
														)");  
		
		foreach($stock_alert_product as $row){
			
			$unread_notification = $dbClass->getSingleRow("SELECT * FROM notification n WHERE n.`status` = 0 AND n.product_rate_id = '".$row['id']."'"); 
			//var_dump($unread_notification);die;
			if(empty($unread_notification)){
				$columns_value = array(
					'product_rate_id'=>$row['id'],
					'details'=>'Add <b>'.$row['p_name'].'</b> in Stock.'
				);			
				$return = $dbClass->insert("notification", $columns_value);		
			}
		} */
		
	break;
	
	case "load_notifications":
		$start = ($page_no*$limit)-$limit;
		$end   = $limit;		
		$total_unread_notification  = $dbClass->getSingleRow("SELECT count(id) unread FROM notification nt where nt.status=0");  
		$data['total_unread']       = $total_unread_notification['unread'];					
		$sql = "SELECT nt.id, nt.order_id, nt.status, nt.details, date_time
				FROM notification nt
				ORDER BY nt.status,nt.id DESC
				limit $start, $end";	
		//echo $sql;die;
		$stmt = $conn->prepare($sql);
		$stmt->execute();
		$result = $stmt->fetchAll(PDO::FETCH_ASSOC);		
		foreach ($result as $row) {					
			$data['records'][] = $row;
		}				
		echo json_encode($data);					
	break;
	
	case "load_notifications_no":
		$total_unread_notification  = $dbClass->getSingleRow("SELECT count(id) unread FROM notification nt where nt.status=0");  
		$data['total_unread']       = $total_unread_notification['unread'];	
		$data['nofication_details_message'] = "";
		if($data['total_unread']>0){
			$sql = "SELECT nt.id, nt.order_id, nt.status, nt.details, date_time
					FROM notification nt
					ORDER BY nt.status,nt.id DESC limit 1";	
			//echo $sql;die;
			$stmt = $conn->prepare($sql);
			$stmt->execute();
			$result = $stmt->fetchAll(PDO::FETCH_ASSOC);		
			foreach ($result as $row) {	
				$search_for = array("<b>", "</b>");
				$details_msg = str_replace($search_for, '', $row['details']); 					
				$data['nofication_details_message'] = $details_msg;
			}				
		}								
		echo json_encode($data);					
	break;
	
	case "update_notification_status":	
		$columns_value = array(
			'status'=>1
			// need to add view notification time here later @momit 26-07-2017
		);		 
		$condition_array = array(
			'id'=>$notification_id
		);
		$return = $dbClass->update("notification",$columns_value, $condition_array);		
		if($return==1)  echo "1";
		else 			echo "0";		
	break;
}



	



?>
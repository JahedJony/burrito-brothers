<?php
session_start();
include '../includes/static_text.php';
include("../dbConnect.php");
include("../dbClass.php");

$dbClass = new dbClass;
$conn       = $dbClass->getDbConn();
$loggedUser = $dbClass->getUserId();
$c_date = date('Y-m-d H:i:s');

extract($_REQUEST);

switch ($q){
    case "insert_or_update":
        if(isset($order_id) && $order_id == ""){
            //var_dump($_REQUEST);die;
            //------------ generate invoice no  -------------------
            $c_y_m = date('my');
            $last_invoice_no = $dbClass->getSingleRow("SELECT max(RIGHT(invoice_no,5)) as invoice_no FROM order_master");

            if($last_invoice_no == null){
                $inv_no = '00001';
            }
            else{
                $inv_no = $last_invoice_no['invoice_no']+1;
            }

            $str_length = 5;
            $str = substr("00000{$inv_no}", -$str_length);

            $invoice_no = "INV$c_y_m$str";

            //-----------------------------------------------------

            $remarks	 = htmlspecialchars($remarks,ENT_QUOTES);

            $columns_value = array(
                'customer_id'=>$customer_id,
                'delivery_date'=>$delivery_date,
                'delivery_type'=>$delivery_option,
                'delivery_charge_id'=>$delivery_option,
                'delivery_charge' =>$delivery_charge_amount,
                'address'=>$address,
                'remarks'=>$remarks,
                'payment_method'=>$payment_option,
                'order_status'=>$order_status_id,
                'payment_status'=>$payment_status,
                'payment_reference_no'=>$payment_referance_no,
                'discount_amount'=>$discounted_amount,
                'total_order_amt'=>$total_item_amount,
                'invoice_no'=>$invoice_no,
            );

            if($payment_status==2){
                $columns_value['total_paid_amount'] = $total_paid_amount;
                $columns_value['payment_time'] = $c_date;
            }

            if(isset($coupon_name) && $coupon_name != ""){
                $coupon = (explode(" >> ",$coupon_name));
                $columns_value['cupon_id'] = $coupon[0];
            }

            //var_dump($columns_value);die;
            $return_master = $dbClass->insert("order_master", $columns_value);
            //echo $return_master; die;
            //echo $item_id; die;

            if($return_master){
                foreach($item_id as $key=>$value){
                    $columns_value = array(
                        'order_id'=>$return_master,
                        'item_id'=>$item_id[$key],
                        'quantity'=>$quantity[$key],
                        'size_id'=>$size_id[$key],
                        'unit_id'=>$unit_id[$key],
                        'item_rate'=>$rate[$key]
                    );
                    $return_details = $dbClass->insert("order_details", $columns_value);
                }
            }

            if($return_details){
                echo "1";
            }
            else{
                echo "0";
            }
        }
        else if(isset($order_id) && $order_id>0){
            //var_dump($_REQUEST);die;
            $columns_value = array(
                'customer_id'=>$customer_id,
                'delivery_date'=>$delivery_date,
                'delivery_type'=>$delivery_option,
                'delivery_charge_id'=>$delivery_option,
                'delivery_charge' =>number_format($delivery_charge_amount,2),
                'address'=>$address,
                'remarks'=>$remarks,
                'payment_status'=>$payment_status,
                'payment_reference_no'=>$payment_referance_no,
                'discount_amount'=>$discounted_amount,
                'total_order_amt'=>$grand_total_amount,
                'total_paid_amount'=>$total_paid_amount,
                'payment_time'=>$c_date,

            );

            if(isset($outlet_option) && $outlet_option != 0){
                $columns_value['outlet_id'] = $outlet_option;
            }
            if(isset($payment_option) && $payment_option != 0){
                $columns_value['payment_method'] = $payment_option;
            }

            if(isset($coupon_name) && $coupon_name != ""){
                $coupon = (explode(" >> ",$coupon_name));
                if(isset($coupon_name)){
                    $coupon = (explode(" >> ",$coupon_name));
                    $columns_value['cupon_id'] 		 = $coupon[0];
                }
            }
            //var_dump($columns_value);die;
            $condition_array = array(
                'order_id'=>$order_id
            );

            $return_master = $dbClass->update("order_master", $columns_value,$condition_array);
            //echo $item_id; die;

            if($return_master){
                $condition_array = array(
                    'order_id'=>$order_id
                );
                $return_dlt = $dbClass->delete("order_details", $condition_array);

                if($return_dlt){
                    foreach($item_id as $key=>$value){
                        $item_rate_id = $dbClass->getSingleRow(' select r.id from item_rate r where r.size_id = '.$size_id[$key].' and r.discounted_rate = '.$rate[$key]);
                        //echo $item_rate_id['id']; die;
                        $columns_value = array(
                            'order_id'=>$order_id,
                            'item_id'=>$item_id[$key],
                            'quantity'=>$quantity[$key],
                            'item_rate_id'=>$item_rate_id['id'],
                            'unit_id'=>$unit_id[$key],
                            'item_rate'=>$rate[$key]
                        );
                        $condition_array = array(
                            'order_id'=>$order_id
                        );
                        $return_details = $dbClass->insert("order_details", $columns_value);
                    }
                }
            }

            if($return_details) echo "2";
            else                echo "0";
        }
    break;
    case "grid_data":
        $start = ($page_no*$limit)-$limit;
        $end   = $limit;
        $data = array();

        $entry_permission   	    = $dbClass->getUserGroupPermission(74);
        $delete_permission          = $dbClass->getUserGroupPermission(75);
        $update_permission          = $dbClass->getUserGroupPermission(76);

        $category_grid_permission   = $dbClass->getUserGroupPermission(77);

        $condition = "";
        //echo '1'; die;

        //# advance search for grid
        if($search_txt == "Print" || $search_txt == "Advance_search"){
            // for advance condition
            $search_txt = "";
            if($ad_item_id != '') 	 	$condition  .=" and item_id = $ad_item_id ";
            if($ad_order_date != '')  		$condition  .=" and date(order_date) ='$ad_order_date'";
            //if($ad_delivery_date != '') 	$condition  .=" and date(delivery_date) = '$ad_delivery_date'";
            if($ad_is_payment != 0)  		$condition  .=" and payment_status = $ad_is_payment";
            if($ad_is_order != 0)  			$condition  .=" and order_status = $ad_is_order";
            //$condition .=	"where s.name LIKE '%$std_name%' AND sch.name LIKE '%$sch_name%' AND s.class LIKE '%$std_class%'  AND s.address LIKE '%$std_address%'  AND s.upazilla LIKE '%$std_upazilla%' AND s.zilla LIKE '%$std_zilla%'  AND s.division LIKE '%$std_division%'";
        }
        // textfield search for grid
        /*else{
            $condition .=	" CONCAT(order_id, customer_name, p_name, item_rate) LIKE '%$search_txt%' ";
        }*/

        //echo '1'; die;


        $countsql = "SELECT count(order_id)
					FROM(
						   SELECT m.order_id, m.customer_id, c.full_name as customer_name, m.invoice_no,
						d.item_id,d.item_rate, d.item_rate_id,  d.ingredient_list, m.order_date, m.delivery_date, p.name as p_name,
						m.delivery_type, order_noticed,
						m.address, m.remarks, m.order_status, m.payment_status, m.payment_method, m.payment_reference_no
						FROM order_master m
						LEFT JOIN order_details d ON d.order_id = m.order_id
						LEFT JOIN customer_infos c ON c.customer_id = m.customer_id
						LEFT JOIN items p ON p.item_id = d.item_id
						WHERE d.status=1
						GROUP BY d.order_id
						ORDER BY m.order_id DESC
					)A
					WHERE CONCAT(invoice_no, order_id, customer_name, p_name, item_rate) LIKE '%$search_txt%' $condition";
        //echo $countsql;die;
        $stmt = $conn->prepare($countsql);
        $stmt->execute();
        $total_records = $stmt->fetchColumn();
        $data['total_records'] = $total_records;
        $data['entry_status'] = $entry_permission;
        $total_pages = $total_records/$limit;
        $data['total_pages'] = ceil($total_pages);
        if($category_grid_permission==1){
            $sql = 	"SELECT order_id, customer_id, customer_name, order_date,order_noticed,order_status,
					delivery_date, delivery_type, total_order_amt, remarks, payment_reference_no, invoice_no, 
					$update_permission as update_status, $delete_permission as delete_status,
					case order_status when 1 then 'Ordered' when 2 then 'Received' when 3 then 'Preparing' when 4 then 'Ready' else 'Delivered' end order_status,
					case payment_status when 1 then 'Not Paid' else 'Paid' end paid_status, payment_method
					FROM(
						 SELECT m.order_id, m.customer_id, c.full_name as customer_name, m.invoice_no,
						m.order_date, m.delivery_date,m.total_order_amt,
						m.delivery_type, order_noticed,
						m.address, m.remarks, m.order_status, m.payment_status, m.payment_reference_no,
						case m.payment_method when 1 then 'Cash' when 2 then 'Loyalty Point' when 3 then 'Card' else 'Gift Card'  end payment_method
						FROM order_master m
						LEFT JOIN customer_infos c ON c.customer_id = m.customer_id
						GROUP BY m.order_id
						ORDER BY m.order_id DESC
				
					)A
					WHERE CONCAT(invoice_no, order_id, customer_name) LIKE '%$search_txt%' $condition
					ORDER BY order_id desc
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

    case "get_order_details":
        $update_permission = $dbClass->getUserGroupPermission(76);
        if($update_permission==1){
            $sql = " 
                    SELECT m.order_id, m.customer_id, 
					c.full_name customer_name, d.item_id, c.contact_no customer_contact_no, c.address customer_address, 
					GROUP_CONCAT(ca.name,' >> ',ca.id,'#',ca.id,'#',p.name,' (',ca.name,' )','#',p.item_id,'#',d.item_rate,'#',d.quantity) order_info,
					m.order_date, m.delivery_date, m.delivery_type, m.discount_amount, m.total_paid_amount, m.delivery_charge,
					  m.address, m.delivery_charge_id, m.tax_amount,  ifnull(cu.cupon_no,'') cupon_no, ifnull(cu.amount,'') cu_amount, cu.c_type cu_type,  m.cupon_id,
					m.remarks, m.order_status, m.payment_status, m.payment_method as payment_method_id,  
					m.payment_reference_no, m.invoice_no, m.total_order_amt,
					case payment_status when payment_status=1 then 'Not Paid' else 'Paid' end paid_status, 
					case payment_method when payment_method=1 then 'bKash' when payment_method=2 then 'Rocket'  else 'Cash On Delivery'  end payment_method
					FROM order_master m
					LEFT JOIN order_details d ON d.order_id = m.order_id
					LEFT JOIN customer_infos c ON c.customer_id = m.customer_id
					LEFT JOIN items p ON p.item_id = d.item_id
					LEFT JOIN category ca ON ca.id = p.category_id
					LEFT JOIN cupons cu ON cu.cupon_no = m.cupon_id 
					WHERE m.order_id= $order_id  
					GROUP BY d.order_id
					ORDER BY m.order_id  ";
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


    case "set_order_notice_details":
        $prev_order_notice = $dbClass->getSingleRow("select order_noticed from order_master where order_id=$order_id");
        //echo $prev_order_notice ; die;
    //echo 1;die;

        if($prev_order_notice['order_noticed'] == 1){
            //echo '1'; die;

            $condition_array = array(
                'order_id'=>$order_id
            );
            $columns_value = array(
                'order_noticed'=>2,
                'order_noticed_time'=>$c_date
            );
            $return = $dbClass->update("order_master", $columns_value, $condition_array);
            echo $return;
        }

    break;

    case "delete_order":
        $delete_permission = $dbClass->getUserGroupPermission(75);
        if($delete_permission==1){
            $condition_array = array(
                'order_id'=>$order_id
            );
            $columns_value = array(
                'status'=>2
            );
            $return = $dbClass->update("order_details", $columns_value, $condition_array);
        }
        if($return) echo "1";
        else 		echo "0";
    break;

    case "view_outlets":
        $data = array();
        $details = $dbClass->getResultList("SELECT c.id, c.address FROM outlets c ORDER BY c.id");
        foreach ($details as $row) {
            $data['records'][] = $row;
        }
        echo json_encode($data);
    break;

    case "view_delivery_list":
        $dept_details = $dbClass->getResultList("select id, type, format(rate,2) rate from delivery_charge where status=1");
        foreach ($dept_details as $row) {
            $data['records'][] = $row;
        }
        echo json_encode($data);
    break;


    case "customer_info":
        $sql_query = "SELECT c.customer_id, c.full_name
					FROM customer_infos c";
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
            $json[] = array('id' => "0",'label' => "No item Found !!!");
        }
        echo json_encode($json);
    break;

    case "coupon_info":
        $sql_query = "SELECT id, c_type, amount, CONCAT(cupon_no,' >> ',t_amount) c_info FROM 
						(
							SELECT c.id, c.cupon_no, c.c_type, c.amount,
							CASE 
								WHEN c.c_type = 1 THEN c.amount 
								WHEN 2 THEN CONCAT(c.amount,' %') 
							END t_amount
							FROM cupons c WHERE c.`status`=1
						) A";
        $stmt = $conn->prepare($sql_query);
        $stmt->execute();
        $json = array();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $count = $stmt->rowCount();
        if($count>0){
            foreach ($result as $row) {
                $json[] = array('id' => $row["id"],'type' => $row["c_type"],'label' => $row["c_info"],'rate' => $row["amount"]);
            }
        } else {
            $json[] = array('id' => "0",'label' => "No Coupon Found !!!");
        }
        echo json_encode($json);
    break;

    case "item_info":
        $con = "WHERE CONCAT(p.name, p.item_id) LIKE '%$term%'";
        if(isset($category_id) && $category_id !=0){
            $con .= " AND  p.category_id = $category_id " ;
        }
        $sql_query = "SELECT p.item_id, concat(p.name,' (',c.name,')') p_name 
					FROM items p
					LEFT JOIN category c ON c.id = p.category_id
					$con
					ORDER BY p.item_id";
        //echo $sql_query;die;
        $stmt = $conn->prepare($sql_query);
        $stmt->execute();
        $json = array();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $count = $stmt->rowCount();
        if($count>0){
            foreach ($result as $row) {
                $json[] = array('id' => $row["item_id"],'label' => $row["p_name"]);
            }
        } else {
            $json[] = array('id' => "0",'label' => "No item Found !!!");
        }
        echo json_encode($json);
    break;

    case "ad_item_info":
        $sql_query = "SELECT p.item_id, p.name FROM items p WHERE CONCAT(name) LIKE '%$term%' ORDER BY p.item_id";
        $stmt = $conn->prepare($sql_query);
        $stmt->execute();
        $json = array();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $count = $stmt->rowCount();
        if($count>0){
            foreach ($result as $row) {
                $json[] = array('id' => $row["item_id"],'label' => $row["name"]);
            }
        } else {
            $json[] = array('id' => "0",'label' => "No item Found !!!");
        }
        echo json_encode($json);
    break;

    case "get_item_rate":
        //var_dump($_REQUEST);die;
        $sql_query ="SELECT discounted_rate 
					FROM item_rate r 
					WHERE r.item_id = $item_id and size_id=$size_id and unit_id=$unit_id";

        $stmt = $conn->prepare($sql_query);
        $stmt->execute();
        $json = array();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $count = $stmt->rowCount();
        if($count>0){
            foreach ($result as $row) {
                echo $row["discounted_rate"];
            }
        } else {
            echo  0;
        }
    break;

    case "category_info":
        $sql_query = "SELECT id, CONCAT(head_name,' >> ',code) category_name 
					FROM (
						SELECT c.id, c.code, 
						CASE WHEN c.parent_id IS NULL THEN c.name WHEN c.parent_id IS NOT NULL THEN CONCAT(ec.name,' >> ',c.name) END head_name
						FROM category c
						LEFT JOIN category ec ON c.parent_id = ec.id
						WHERE CONCAT(c.name, c.code) LIKE '%$term%'
						ORDER BY c.id						
					) A";
        $stmt = $conn->prepare($sql_query);
        $stmt->execute();
        $json = array();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $count = $stmt->rowCount();
        if($count>0){
            foreach ($result as $row) {
                $json[] = array('id' => $row["id"],'label' => $row["category_name"]);
            }
        } else {
            $json[] = array('id' => "0",'label' => "No item Found !!!");
        }
        echo json_encode($json);
    break;

    case "update_order_status":
	
        $condition_array = array(
            'order_id'=>$order_id
        );
        $columns_value = array(
            'order_status'=>$status_id
        );
        
		$return = $dbClass->update("order_master", $columns_value, $condition_array);
        
		if($return){
			
			$invoice_no = $dbClass->getSingleRow("SELECT invoice_no from order_master WHERE order_id = $order_id");
			extract($invoice_no);
			if($status_id == 6){
				$details = " Your Order (".$invoice_no.") Rejected/Canceled ";
			}
			else if($status_id == 2){
				$details = " Your Order (".$invoice_no.") Received by Admin ";
			}
			else if($status_id == 3){
				$details = " Your Order (".$invoice_no.") is Processing ";
			}
			else if($status_id == 4){
				$details = " Your Order (".$invoice_no.") is Ready ";
			}
			else if($status_id == 5){
				$details = " Your Order (".$invoice_no.") is Delivered ";
			}
			
			//insert_notification function 
			//param: order_id (int), details (text), notification_user_type (int) : 0=customer, 1: admin, notified_to (int)
			$return_notifiction = $dbClass->insert_notification($order_id, $details, 0, $customer_id);	
			
			if($return_notifiction) echo 1;
			else                    echo 0;
		}
		
    break;


    case "get_order_details_by_invoice":
        //echo $order_id; die;
        $group_order_id = $dbClass->getSingleRow("SELECT group_order_id FROM order_master WHERE order_id=$order_id");

        //var_dump($group_order_id);die;

        if($group_order_id['group_order_id']==0){
        $sql = "SELECT m.order_id, m.customer_id, c.full_name customer_name, d.item_id, c.contact_no customer_contact_no, c.address customer_address, m.order_id,
                GROUP_CONCAT(ca.name,' >> ',ca.id,'#',ca.id,'#',p.name,' (',ca.name,' )','#',p.item_id,'#',d.item_rate,'#',d.quantity,'#',d.ingredient_name,'..') order_info,
                m.order_date, m.delivery_date, m.delivery_type, m.discount_amount, m.total_paid_amount,
                m.address, m.delivery_charge_id, m.tax_amount,
                m.remarks, m.order_status, m.payment_status, m.payment_method, 
                m.payment_reference_no, m.invoice_no, m.total_order_amt,
                case payment_status when payment_status=1 then 'Not Paid' else 'Paid' end paid_status, 
                case payment_method when payment_method=1 then 'bKash' when payment_method=2 then 'Rocket'  else 'Cash On Delivery'  end payment_method
                FROM order_master m
                LEFT JOIN order_details d ON d.order_id = m.order_id
                LEFT JOIN customer_infos c ON c.customer_id = m.customer_id
                LEFT JOIN items p ON p.item_id = d.item_id
                LEFT JOIN category ca ON ca.id = p.category_id
                WHERE m.order_id= '$order_id'
                GROUP BY d.order_id
                ORDER BY m.order_id";
            //echo $sql;die;
            $stmt = $conn->prepare($sql);
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            foreach ($result as $row) {
                $data['records'][] = $row;
            }
            $data['type']='individual';

            echo json_encode($data);
        }
        else{
            $sql = " SELECT coalesce(oms.order_id, 'NAN') as order_id, god.id, coalesce(oms.order_info, '') as order_info, coalesce(oms.order_date, '') as order_date, coalesce(oms.total_order_amt, '0') as total_order_amt, coalesce(oms.order_status, '0') as order_status, gm.name, gm.email, god.id as group_order_details_id, god.order_key
               FROM group_order go
               LEFT JOIN group_order_details god ON god.group_order_id= go.order_id
               LEFT JOIN group_members gm ON gm.id=god.group_member_id
               LEFT JOIN(
               SELECT om.order_id, om.group_order_details_id,
                GROUP_CONCAT(ca.name,' >> ',ca.id,'#',ca.id,'#',p.name,' (',ca.name,' )','#',p.item_id,'#',d.item_rate,'#',d.quantity,'#',d.ingredient_name,'..') order_info,
                om.order_date, om.total_order_amt, om.order_status 
                FROM order_master om
                LEFT JOIN order_details d ON d.order_id = om.order_id
                LEFT JOIN items p ON p.item_id = d.item_id
                LEFT JOIN category ca ON ca.id = p.category_id
                GROUP BY d.order_id
                )oms ON oms.group_order_details_id= god.id
                WHERE go.order_id =".$group_order_id['group_order_id'];
            //echo $sql;die;
            $stmt = $conn->prepare($sql);
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);


            foreach ($result as $row) {
                $data['records'][] = $row;
            }

            $sql = "SELECT ci.full_name, ci.address as c_address, ci.contact_no as mobile, gi.name, go.order_id as group_order_id, go.order_date, go.delivery_date, go.total_order_amt, go.order_status as status, go.invoice_no,go.total_paid_amount
                                        from group_order go
                                        LEFT JOIN groups_info gi ON gi.id = go.group_id
                                        LEFT JOIN(
                                        SELECT full_name, address, contact_no,customer_id from customer_infos 
                                        )ci ON ci.customer_id=go.customer_id              
                                         WHERE go.order_id=".$group_order_id['group_order_id'];
            //echo $sql;die;
            $stmt = $conn->prepare($sql);
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $tax = $dbClass->getSingleRow("Select tax_type, tax_amount, tax_enable from general_settings where id=1");

            $data['order_details']=$result[0];
            $data['type']='group';
            echo json_encode($data);
        }
        break;


    case "get_group_order_details":
        //echo $order_id; die;

        $sql = " SELECT coalesce(oms.order_id, 'NAN') as order_id, god.id, coalesce(oms.order_info, '') as order_info, coalesce(oms.order_date, '') as order_date, coalesce(oms.total_order_amt, '0') as total_order_amt, coalesce(oms.order_status, '0') as order_status, gm.name, gm.email, god.id as group_order_details_id, god.order_key
               FROM group_order go
               LEFT JOIN group_order_details god ON god.group_order_id= go.order_id
               LEFT JOIN group_members gm ON gm.id=god.group_member_id
               LEFT JOIN(
               SELECT om.order_id, om.group_order_details_id,
                GROUP_CONCAT(ca.name,' >> ',ca.id,'#',ca.id,'#',p.name,' (',ca.name,' )','#',p.item_id,'#',d.item_rate,'#',d.quantity,'#',d.ingredient_name,'..') order_info,
                om.order_date, om.total_order_amt, om.order_status 
                FROM order_master om
                LEFT JOIN order_details d ON d.order_id = om.order_id
                LEFT JOIN items p ON p.item_id = d.item_id
                LEFT JOIN category ca ON ca.id = p.category_id
                GROUP BY d.order_id
                )oms ON oms.group_order_details_id= god.id
                WHERE go.order_id =$order_id";
        //echo $sql;die;
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);


        foreach ($result as $row) {
            $data['records'][] = $row;
        }
        $date = date("Y-m-d");


        $sql = "SELECT ci.full_name, ci.address as c_address, ci.contact_no as mobile, gi.name, go.order_id as group_order_id, go.order_date, go.delivery_date, go.total_order_amt, go.notification_time,  cp.c_type, cp.amount as cupon_amount, cp.min_order_amount, go.order_status as status, go.invoice_no,go.tips,go.total_paid_amount,
                                        case go.order_status when 2 then 'Invitation Sent' when 3 then 'Menu Selected' when 4 then 'Order Panding' when 5 then 'Order Approved' when 6 then 'Order Ready' else 'Order Initiate' end order_status, 
										case go. payment_status when 1 then 'Not Paid' else 'Paid' end payment_status, 
										case go.payment_method when 1 then 'Cash On Delivery' when 2 then 'Loyalty Payment' when 3 then 'Card' when 4 then 'Gift Card' else 'Not Defined' end payment_method
                                        from group_order go
                                        LEFT JOIN groups_info gi ON gi.id = go.group_id
                                        LEFT JOIN(
                                        SELECT id,c_type,amount,min_order_amount 
										FROM cupons 
										WHERE status=1 and (customer_id = 18 or customer_id is null) 
										AND (DATE_FORMAT(start_date, '%Y-%m-%d') <= '$date' 
										AND DATE_FORMAT(end_date, '%Y-%m-%d') >= '$date')
										)cp ON cp.id = go.cupon_id 
                                        LEFT JOIN(
                                        SELECT full_name, address, contact_no,customer_id from customer_infos 
                                        )ci ON ci.customer_id=go.customer_id              
                                         WHERE go.order_id=$order_id";
        //echo $sql;die;
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $tax = $dbClass->getSingleRow("Select tax_type, tax_amount, tax_enable from general_settings where id=1");

        $data['order_details']=$result[0];
        $data['tax']=$tax;
        echo json_encode($data);
        break;

}
?>
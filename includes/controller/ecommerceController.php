<?php 
session_start();
include '../dbConnect.php';	
include("../dbClass.php");

$dbClass = new dbClass;
$loggedUser = $dbClass->getUserId();

extract($_REQUEST);

switch ($q){
    case "addToCart":

        if(!isset($_SESSION['cart']) || empty($_SESSION['cart']))$cart = array();
        else $cart = $_SESSION['cart'];

        //var_dump($selected_item_list);
        $tem_cart = array();
        if(isset($selected_item_list)){
            foreach($selected_item_list as $item){
                foreach ($item as $single_item){
                    if($single_item=='side orders' || $single_item=='beverages	') continue;
                    if(!is_numeric((int)$single_item['item_id'])) continue;
                    $tem_cart[$single_item['item_id'].'_'.$single_item['price']]['item_name']=$single_item['name'];
                    $tem_cart[$single_item['item_id'].'_'.$single_item['price']]['cart_key']=$single_item['item_id'].'_'.$single_item['price'];
                    $tem_cart[$single_item['item_id'].'_'.$single_item['price']]['discounted_rate']=$single_item['price'];
                    $tem_cart[$single_item['item_id'].'_'.$single_item['price']]['item_id']=$single_item['item_id'];
                    $tem_cart[$single_item['item_id'].'_'.$single_item['price']]['quantity']=$single_item['quantity'];
                    $tem_cart[$single_item['item_id'].'_'.$single_item['price']]['item_image']=$single_item['image'];
                    $tem_cart[$single_item['item_id'].'_'.$single_item['price']]['item_total']=$single_item['quantity'];
                }
            }
            foreach ($tem_cart as $item){
                //var_dump($item);
                if (array_key_exists($item['cart_key'],$cart)){
                    $cart_key = $item['cart_key'];

                    $updatable_item = $cart[$cart_key];

                    if($quantity==0){
                        unset($cart[$item[$cart_key]]);
                    }
                    else{
                        $discounted_rate                      = $updatable_item['discounted_rate'];
                        $total_quantity                       = ($quantity+$updatable_item['quantity']);
                        $cart[$cart_key]['quantity']          = $total_quantity;
                        $total_amount                         = $total_quantity*$updatable_item['discounted_rate'];
                        $cart[$cart_key]['item_total']        = $total_amount;
                        $_SESSION['cart']                     = $cart;
                    }
                }
                else{
                    $cart[$item['cart_key']]=$item;
                    $_SESSION['cart'] = $cart;
                }
                //var_dump($item[cart_key]);
            }
        }

        //var_dump($tem_cart);die;

        $cart_key = $item_id.'_'.$discounted_rate;
        if (array_key_exists($cart_key,$cart)){

            $updatable_item = $cart[$cart_key];

            if($quantity==0){
                unset($cart[$cart_key]);
            }
            else{
                $discounted_rate                = $updatable_item['discounted_rate'];
                $total_quantity                 = ($quantity+$updatable_item['quantity']);
                $cart[$cart_key]['quantity']    = $total_quantity;
                $total_amount                    = $total_quantity*$updatable_item['discounted_rate'];
                $cart[$cart_key]['item_total']  = $total_amount;
                $_SESSION['cart']               = $cart;
            }
        }
        else{
            //echo 23; die;

            $selected_item = array();

            $selected_item['item_id'] = $item_id;
            $selected_item['cart_key'] = $cart_key;
            $selected_item['item_name'] = $item_name;
            $selected_item['unit_id'] = 1;
            $selected_item['item_image'] = $item_image;
            $selected_item['orignal_rate'] = $orignal_rate;
            $selected_item['discounted_rate'] = $discounted_rate;
            $selected_item['size'] = 1;
            $selected_item['quantity'] = $quantity;
            $selected_item['ingredient'] = $ingredient;
            $selected_item['special_instruction'] = $special_instruction;
            $selected_item['item_total'] = ($selected_item['discounted_rate']*$quantity);
            $cart[$cart_key]=$selected_item;
            $_SESSION['cart'] = $cart;
        }
        //$_SESSION['cart']='';
        $data['records'] = $cart;
        //echo 1;die;
    //var_dump($data);
        echo json_encode($data);
    break;


    case "viewCartSummery":
        //echo 1; die;
        if(!isset($_SESSION['cart']) || empty($_SESSION['cart']))$cart = array();
        else 													 $cart = $_SESSION['cart'];
        $data['records'] = $cart;
        echo json_encode($data);
    break;

    case "viewPriceSummery":
        $tax = $dbClass->getSingleRow("Select tax_type, tax_amount, tax_enable from general_settings where id=1");
        if(!isset($_SESSION['cart']) || empty($_SESSION['cart']))$cart = array();
        else 													 $cart = $_SESSION['cart'];
        $total_price=0;
        $data = [];
        foreach ($cart as $items){
            $total_price+=($items['discounted_rate']* $items['quantity']);
        }
        $data['total_price']= $total_price;

        if(isset($_SESSION['total_discounted_amount'])){

            if(isset($_SESSION['min_order_amount']) && $total_price>=$_SESSION['min_order_amount']){
                $data['discount'] = $_SESSION['total_discounted_amount'];
                $data['discounted_price'] = $total_price-$data['discount'];

            }
            else{
                $data['discounted_price']=$total_price;
                $data['discount'] = 0;
            }
        }
        else{
            $data['discounted_price']=$total_price;
            $data['discount'] = 0;
        }
        //echo $data['discount']; die;

        if ($tax['tax_enable']==1){
            if($tax['tax_type']==1){
                $data['tax_amount']= $tax['tax_amount'];
            }
            else{
                $data['tax_amount']= $data['discounted_price']*$tax['tax_amount']/100;
            }
            $data['discounted_price']=$data['discounted_price']+$data['tax_amount'];
        }
        else{
            $data['tax_amount']= 0;
        }
        echo  json_encode($data);
    break;

    case "removeFromCart":
        if(!isset($_SESSION['cart']) || empty($_SESSION['cart']))$cart = array();
        else 													 $cart = $_SESSION['cart'];


        if (array_key_exists($cart_key,$cart)){
            unset($cart[$cart_key]);
        }
        $_SESSION['cart']= $cart;
        $data['records'] = $cart;
        echo json_encode($data);
    break;


    case "update_cart":
        if(!isset($_SESSION['cart']) || empty($_SESSION['cart']))$cart = array();
        else{
            $cart = $_SESSION['cart'];

            foreach($cart_key as $key=>$cart_key){
                //echo $cart_key;die;

                if (array_key_exists($cart_key,$cart)){
                    $updatable_item = $cart[$cart_key];

                    if($quantity==0){
                        unset($cart[$cart_key]);
                    }
                    else{
                        //echo $updatable_item['discounted_rate'];die;
                        $discounted_rate = $updatable_item['discounted_rate'];
                        $cart[$cart_key]['quantity']  = $quantity[$key];
                        $toal_amount = $quantity[$key]*$updatable_item['discounted_rate'];
                        $cart[$cart_key]['item_total'] = $toal_amount;

                        $_SESSION['cart'] = $cart;

                    }
                }
            }
            echo json_encode($_SESSION['cart']);die;
            echo 1;
        }
    break;


    case "apply_cupon":
        //var_dump($_SESSION);die;
        if(!isset($_SESSION['cart']) || empty($_SESSION['cart']))$cart = array();
        else{
            $cart = $_SESSION['cart'];
            // get the total cart amount
            $total_cart_amount = 0;
            foreach($cart as $key=>$item){
                $total_cart_amount += $item['item_total'];
            }
            $cupon_amount = 0;
            $date = date("Y-m-d");
            //echo $date; die;
            if(isset($_SESSION['customer_id']) && $_SESSION['customer_id'] != ""){
                //echo("select c_type,amount from cupons where status=1 and ((cupon_no='$cupon_code' and customer_id = ".$_SESSION['customer_id'].") or cupon_no='$cupon_code' and customer_id is null) and (DATE_FORMAT(start_date, '%Y-%m-%d') <= '$date' AND DATE_FORMAT(end_date, '%Y-%m-%d') >= '$date')");die;

                $cupon_info = $dbClass->getSingleRow("select c_type,amount,min_order_amount from cupons where status=1 and ((cupon_no='$cupon_code' and customer_id = ".$_SESSION['customer_id'].") or cupon_no='$cupon_code' and customer_id is null) and (DATE_FORMAT(start_date, '%Y-%m-%d') <= '$date' AND DATE_FORMAT(end_date, '%Y-%m-%d') >= '$date')");
            }
            else{
               // echo ("select c_type,amount from cupons where status=1 and cupon_no='$cupon_code' and customer_id is null and(DATE_FORMAT(start_date, '%Y-%m-%d') <= '$date' AND DATE_FORMAT(end_date, '%Y-%m-%d') >= '$date')"); die;
                $cupon_info = $dbClass->getSingleRow("select c_type,amount,min_order_amount from cupons where status=1 and cupon_no='$cupon_code' and customer_id is null and(DATE_FORMAT(start_date, '%Y-%m-%d') <= '$date' AND DATE_FORMAT(end_date, '%Y-%m-%d') >= '$date')");
            }
            //echo($cupon_info);die;
            if($cupon_info){
                //echo 1;die;
                if($cupon_info['c_type']==1 && $cupon_info['min_order_amount']<=$total_cart_amount) {// flat amount
                    $cupon_amount = $cupon_info['amount'];
                    $min_order_amount = $cupon_info['min_order_amount'];
                }
                else if($cupon_info['c_type']==2 && $cupon_info['min_order_amount']<=$total_cart_amount){ // % amount
                    $cupon_percent = $cupon_info['amount'];
                    $cupon_amount = ($total_cart_amount*$cupon_percent)/100;
                    $min_order_amount = $cupon_info['min_order_amount'];
                }
                else{
                    $cupon_amount = 0;
                    $min_order_amount = $cupon_info['min_order_amount'];
                }
                //echo $total_cart_amount; die;
                $_SESSION['total_discounted_amount'] = $cupon_amount;
                $_SESSION['cupon_code'] = $cupon_code;
                $_SESSION['min_order_amount'] = $min_order_amount;
                //$data['total_discounted_amount'] = $cupon_amount;
                //echo json_encode($data);
                echo 1;
            }
            else{
                unset($_SESSION['total_discounted_amount']);
                unset($_SESSION['cupon_code']);
                echo 2; // invalid cupon
            }
        }

    break;


    case "checkout":
		//var_dump($_REQUEST);die;
			
		if(!isset($_SESSION['cart']) || empty($_SESSION['cart']) || empty($_SESSION['customer_id']) || $_SESSION['customer_id']=="" ){echo "0"; die;}
        else 	$cart = $_SESSION['cart'];

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
        //echo 333;die;

        $invoice_no = "BB$c_y_m$str";
        //-----------------------------------------------------


        if(isset($_SESSION['group_master'])){			
            $price = 0;
            foreach($cart as $key=>$item){
                $price+=(float)$item['discounted_rate']*(int)$item['quantity'];
            }
            //echo json_encode($cart); die;
            $columns_value = array(
                'customer_id'=>0,
                'delivery_date'=>$_SESSION['delivery_date'],
                'delivery_type'=>1,
                'remarks'=>'',
                'order_status'=>0,
                'invoice_no'=>$invoice_no,
                'payment_method' =>0,
                'payment_status' =>1,
                'total_order_amt'=>$price,
                'tax_amount'=>0,
                'tips'=>0,
                'total_paid_amount'=>0,
                'group_order_details_id'=>$_SESSION['group_order_details_id'],
                'loyalty_point'=>0

            );
        }
        else{
            $secial_notes	 = htmlspecialchars($secial_notes,ENT_QUOTES);
            if(!$tips){
                $tips=0;
            }

            $columns_value = array(
                'customer_id'=>$_SESSION['customer_id'],
                'delivery_date'=>$pickup_date_time,
                'delivery_type'=>1,
                'remarks'=>$secial_notes,
                'order_status'=>1,
                'invoice_no'=>$invoice_no,
                'payment_method' =>$payment_method,
                'total_order_amt'=>$total_order_amt,
                'tax_amount'=>$tax_amount,
                'total_paid_amount'=>$total_paid_amount,
                'tips'=>(float)$tips,
                'payment_status' =>1,
                'loyalty_point'=>$loyalty_point,
                'group_order_details_id'=>0
            );
        }
       
        if(isset($_SESSION['cupon_code']) || !empty($_SESSION['cupon_code'])){
            $columns_value['cupon_id'] 			= $_SESSION['cupon_code'];
            $columns_value['discount_amount']	= $_SESSION['total_discounted_amount'];
        }

        $paid = 0; // not paid
      
        if(!isset($_SESSION['group_master']) ) {
            if ($total_paid_amount) {

                $columns_value['payment_status'] = 2;
                $columns_value['payment_reference_no'] = 1;

            } else {
                $columns_value['payment_status'] = 1;
            }
        }
        $return_master = $dbClass->insert("order_master", $columns_value);

       //var_dump($return_master);
        if(isset($_SESSION['group_master']) ){
            //SET Notification for group order

        }else{
            $column_array = array(
                'order_id'=>$return_master,
                'details'=>'Order placed',
                'target_user'=>'admin',
                'user_id'=>$_SESSION['customer_id']
            );
            $dbClass->insert("notification", $column_array);
        }


        //echo $return_master; die;
        if($return_master){

			
			/* *********************************   notification Start       ************************* */
			
			//notification for group & single order			

			if(isset($_SESSION['group_master']) ){
				//SET Notification for group order
				//notfication to customer who created group order not admin
				// mr chaki select his items
                //

                $t_sql = "SELECT go.customer_id from  
                            group_order_details god
                            LEFT JOIN group_order go ON go.order_id = god.group_order_id
                            WHERE god.id = ".$_SESSION['group_order_details_id'];
                //echo $t_sql; die;


				$customer_id_group = $dbClass->getSingleRow($t_sql);
				//echo json_encode($customer_id_group);
                //die;

                //extract($customer_id_group);
                $c_sql ="SELECT full_name FROM customer_infos WHERE customer_id = ".$customer_id_group['customer_id'];
                //echo $c_sql; die;
				$group_customer_name = $dbClass->getSingleRow($c_sql);
				//extract($group_customer_name);
				//echo json_encode($group_customer_name);
				//die;
                //echo $group_customer_name['full_name']; die;
				$details = "".ucfirst($group_customer_name['full_name'])." select his items";
				$return_notifiction = $dbClass->insert_notification($return_master, $details, 0, $customer_id_group['customer_id']);
			}
			else{
				//set single notification details
				//$invoice_no = $dbClass->getSingleRow("SELECT invoice_no from order_master WHERE order_id = $return_master");
				$customer_name = $dbClass->getSingleRow("SELECT full_name FROM customer_infos WHERE customer_id = '".$_SESSION['customer_id']."'");
				//extract($invoice_no);
				$details = "".ucfirst($customer_name['full_name'])." Placed an Order (".$invoice_no.")";	
				$return_notifiction = $dbClass->insert_notification($return_master, $details, 1, NULL);	
			}
			
			//insert_notification function 
			//param: order_id (int), 
			//details (text), 
			//notification_user_type (int) : 0=customer, 1: admin, 
			//notified_to (int) : make notified_to null if notified target user type = admin	
			
			
			/* *********************************   notification END       ************************* */




            foreach($cart as $key=>$item){
                if(isset($item['ingredient']['id_list'])){

                    //var_dump($item['ingredient']['id_list']);

                    $ing_list= $item['ingredient']['id_list'];
                    $ingredient_name= $item['ingredient']['ingredient_name'];

                }
                else{
                    //var_dump('not found');
                    $ing_list= '';
                    $ingredient_name='';
                }

                if(isset($item['special_instruction'])){
                    $special_instruction=$item['special_instruction'];
                }else{
                    $special_instruction='';
                }

                $cart_key_arr = explode('_',$key);
                $item_size_rate_id = $cart_key_arr[1];
                //var_dump($item['discounted_rate'] .'-'.$item['item_id']);
                $columns_value = array(
                    'order_id'=>$return_master,
                    'item_id'=>$item['item_id'],
                    'quantity'=>$item['quantity'],
                    'ingredient_list'=>$ing_list,
                    'ingredient_name'=>$ingredient_name,
                    'item_rate_id'=>0,
                    'special_instruction'=>$special_instruction,
                    'item_rate'=>$item['discounted_rate']
                );
                $return_details = $dbClass->insert("order_details", $columns_value);
                //var_dump($return_details);

            }
            //echo 123;

            //var_dump($_SESSION['cart'] );
            if($return_details){
                if(!isset($_SESSION['group_master'])){
                    $customer_loyalty_point=  $dbClass->getSingleRow("SELECT loyalty_points from customer_infos where customer_id=".$_SESSION['customer_id']);
                    //echo $customer_loyalty_point; die;
                    $new_loyalty_point=$customer_loyalty_point['loyalty_points']-$loyalty_deduct+$loyalty_point;
                    $value_ar= array(
                        'loyalty_points'=>$new_loyalty_point
                    );
                    $condition_ar= array(
                        'customer_id'=>$_SESSION['customer_id']
                    );
                    $customer_loyalty_update=  $dbClass->update("customer_infos",$value_ar,$condition_ar);

                }
                else{
                    $value_ar=array(
                        'order_master_id'=>$return_master,
                        'status'=>1

                    );
                    $condition_ar = array(
                        'id'=>$_SESSION['group_order_details_id']
                    );
                    $dbClass->update("group_order_details",$value_ar,$condition_ar);

                }


                //echo 11;

                $cart = array();

                $_SESSION['cart'] = $cart;
                $_SESSION['latest_order_id'] = $return_master;
                $_SESSION['payment'] 		 = $paid;

                //echo 234;

                if(isset($_SESSION['group_master'])){
                    unset($_SESSION['group_master']);
                    unset($_SESSION['delivery_date']);
                    unset($_SESSION['group_order_details_id']);
                    if(isset($_SESSION['groupOrderId'])){
                        echo '222'; die;
                    }
                    else{
                        echo '111'; die;
                    }
                }
                else{
                    unset($_SESSION['total_discounted_amount']);
                    unset($_SESSION['cupon_code']);
                    unset($_SESSION['min_order_amount']);
                    $_SESSION['Last_invoice_no']=$invoice_no;
                }


                //echo $_SESSION['Last_invoice_no']; die;

                echo $invoice_no; die;


                // sending email will be here


                // send mail to customer account
                if(isset($_SESSION['customer_email'])){
                    $customer_email = $_SESSION['customer_email'];
                    if($customer_email){
                        $sql = "SELECT m.order_id, m.customer_id, 
                                c.full_name customer_name, d.item_id, c.contact_no customer_contact_no, 
                                c.address customer_address, 
                                GROUP_CONCAT(ca.name,' >> ',ca.id,'#',ca.id,'#',p.name,' (',ca.name,' )','#',p.item_id,'#',s.name,'#',d.item_rate_id,'#',d.item_rate,'#',d.quantity) order_info,
                                m.order_date, m.delivery_date, m.delivery_type,m.delivery_charge, m.discount_amount, m.total_paid_amount,
                                m.address, m.delivery_charge_id, m.tax_amount,
                                m.remarks, m.order_status, m.payment_status, m.payment_method, 
                                m.payment_reference_no, m.invoice_no, m.total_order_amt,
                                case payment_status when payment_status=1 then 'Not Paid' else 'Paid' end paid_status, 
                                case payment_method when payment_method=1 then 'bKash' when payment_method=2 then 'Rocket'  else 'Cash On Delivery'  end payment_method
                                FROM order_master m
                                LEFT JOIN order_details d ON d.order_id = m.order_id
                                LEFT JOIN customer_infos c ON c.customer_id = m.customer_id
                                LEFT JOIN items p ON p.item_id = d.item_id
                                LEFT JOIN item_rate r on r.id = d.item_rate_id
                                LEFT JOIN size s ON s.id = r.size_id
                                LEFT JOIN category ca ON ca.id = p.category_id
                                WHERE m.invoice_no='$invoice_no'
                                GROUP BY d.order_id
                                ORDER BY m.order_id";
                        //echo $sql; die;
                        $stmt = $conn->prepare($sql);
                        $stmt->execute();
                        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
                        foreach ($result as $row) {
                            extract($row);
                        }
                        //echo 55; die;

                        $to 	 = $customer_email;
                        $from 	 = 'admin@cakencookie.net';
                        $subject = "#$invoice_no Order Confirmation from Cakencookie";
                        $body 	 = '';

                        $headers = 'From: ' . $from . "\r\n" .
                                'Reply-To: ' . $from . "\r\n" .
                                'Content-type: text/html; charset=iso-8859-1' . "\r\n" .
                                'X-Mailer: PHP/' . phpversion();

                        $body .= "
                            <link rel='stylesheet' type='text/css' href='http://mbrotherssolution.com/CnC/plugin/bootstrap/bootstrap.css'>
                            <div id='order-div'>
                                <div class='title text-center'>
                                    <h3 class='text-coffee left'> <a href='index.php'><img src='http://mbrotherssolution.com/CnC/images/logo.png' alt=''></a></h3>
                                    <h4 class='text-coffee left'>Order No # <span id='ord_title_vw'>$invoice_no</span></h4>
                                </div>
                                <div class='done_registration '>							    
                                    <div class='doc_content'>
                                        <div class='col-md-12'>
                                            <h4>Order Details:</h4>				
                                            <div class='byline'>
                                                <span id='ord_date'>Ordered Time: $order_date</span><br/> 
                                                <span id='dlv_date'>Delivery Time $delivery_date</span> <br/> 
                                                <span id='dlv_date'>Payment Status : $paid_status</span> <br/> 
                                                <span id='dlv_date'>Payment Method : $payment_method</span>
                                            </div>	
    
    
                                            <h4>Customer Details:</h4> 								
                                            <address id='customer_detail_vw'>
                                            $customer_name
                                            <br/><b>Mobile:</b>$customer_contact_no
                                            <br/><b>Address:</b>$customer_address
                                            </address>
                                        </div>
                                        <div id='ord_detail_vw col-md-12'> 
                                            <table class='table table-bordered col-md-12' >
                                                <thead>
                                                    <tr>
                                                        <th align='center'>Product</th>
                                                        <th width='18%' align='center'>Size</th>
                                                        <th width='10%' align='center'>Quantity</th>
                                                        <th width='18%' style='text-align:right'>Rate</th>                           
                                                        <th width='18%'  style='text-align:right'>Total</th>
                                                    </tr>
                                                </thead>
                                                <tbody>";
                                            $order_info_arr = explode(',', $order_info);
                                            $order_total = 0;
                                            foreach($order_info_arr as $key=>$item_details){
                                                $item_details_arr = explode('#', $item_details);
                                                $total = ($item_details_arr[7]*$item_details_arr[6]);
                                                $body .= "<tr><td>".$item_details_arr[2]."</td><td align='left'>".$item_details_arr[4]."</td><td align='center'>".$item_details_arr[7]."</td><td align='right'>".$item_details_arr[6]."</td><td align='right'>".number_format($total,2)."</td></tr>";
                                                $order_total += $total;
                                            }

                                            $total_order_bill = $order_total-$discount_amount;
                                            $total_paid 	  = $total_paid_amount;
                                            $body .= '<tr><td colspan="4" align="right" ><b>Total Product Bill</b></td><td align="right"><b>'.number_format($order_total ,2).'</b></td></tr>';
                                            $body .= '<tr><td colspan="4" align="right" ><b>Discount Amount</b></td><td align="right"><b>'.number_format($discount_amount,2).'</b></td></tr>';
                                            $body .= '<tr><td colspan="4" align="right" ><b>Total Order Bill</b></td><td align="right"><b>'.number_format($total_order_bill,2).'</b></td></tr>';
                                            $body .= '<tr><td colspan="4" align="right" ><b>Delivery Charge</b></td><td align="right"><b>'.number_format($delivery_charge,2).'</b></td></tr>';
                                            $body .= '<tr><td colspan="4" align="right" ><b>Total Paid</b></td><td align="right"><b>'.number_format($total_paid,2).'</b></td></tr>';
                                            $body .= '<tr><td colspan="4" align="right" ><b>Balance</b></td><td align="right"><b>'.number_format((($total_order_bill+$delivery_charge)-$total_paid),2).'</b></td></tr>';

                                    $body .= "										
                                                </tbody>
                                            </table>
                                            <p>Note: <span id='note_vw'>$remarks</span></p>
                                            <p>Print Time :". date('Y-m-d h:m:s')."</p>
                                            <br />
                                            <p style='font-weight:bold; text-align:center'>Thank you. Hope we will see you soon </p>
                                        </div> 
                                    </div>									
                                </div>							
                            </div>
                        ";
                        //echo $body;die;
                        mail($to, $subject, $body, $headers);
                    }
                }

                //-------------------------------
                echo $invoice_no;
            }
        }
        else echo "0";
    break;

    case "placeGroupOrder":

        break;


    case "get_order_details_by_invoice":
        //echo 1; die;
        $sql = "SELECT m.order_id, m.customer_id, 
                c.full_name customer_name, d.item_id, c.contact_no customer_contact_no, c.address customer_address,  m.order_id,
                GROUP_CONCAT(ca.name,' >> ',ca.id,'#',ca.id,'#',p.name,' (',ca.name,' )','#',p.item_id,'#',d.item_rate,'#',d.quantity,'#',d.ingredient_name,'..') order_info,
                m.order_date, m.delivery_date, m.delivery_type, m.discount_amount, m.total_paid_amount,
                m.address, m.delivery_charge_id, m.tax_amount, m.tips,
                m.remarks, m.order_status, m.payment_status, m.payment_method, 
                m.payment_reference_no, m.invoice_no, m.total_order_amt,
                case payment_status when payment_status=1 then 'Not Paid' else 'Paid' end paid_status, 
                case payment_method when payment_method=1 then 'bKash' when payment_method=2 then 'Rocket'  else 'Cash On Delivery'  end payment_method
                FROM order_master m
                LEFT JOIN order_details d ON d.order_id = m.order_id
                LEFT JOIN customer_infos c ON c.customer_id = m.customer_id
                LEFT JOIN items p ON p.item_id = d.item_id
                LEFT JOIN category ca ON ca.id = p.category_id
                WHERE m.invoice_no= '$order_id'
                GROUP BY d.order_id
                ORDER BY m.order_id";
    	//echo $sql;die;
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        foreach ($result as $row) {
            $data['records'][] = $row;
        }
        echo json_encode($data);

    break;



    case "get_customer_details":
        //echo '1'; die;
        $customer_details = $dbClass->getResultList("SELECT c.customer_id, c.full_name, c.loyalty_points, c.contact_no, c.age, c.address,
                                                    c.`status`, c.photo, c.email, c.remarks,
                                                    (CASE c.`status` WHEN 1 THEN 'Active' WHEN  0 THEN 'Inactive' END) status_text
                                                    FROM customer_infos c
                                                    WHERE c.customer_id=".$_SESSION['customer_id']);
        //echo $customer_details; die;
        foreach ($customer_details as $row){
            $data['records'][] = $row;
        }
        echo json_encode($data);

    break;

    case "insert_or_update":
            if(isset($customer_id) && $customer_id != ""){
                $is_active=0;
                if(isset($_POST['is_active'])){
                    $is_active=1;
                }

                $columns_value = array(
                    'full_name'=>$customer_name,
                    'email'=>$email,
                    'address'=>$address,
                    'age'=>$age,
                    'contact_no'=>$contact_no,
                    'email'=>$email,
                    'status'=>$is_active
                );
                if($age != "" && $age != "0000-00-00"){
                    $dob = date("Y-m-d", strtotime($age));
                    $columns_value['age'] = $dob;
                }

                if(isset($_POST['remarks']))
                    $columns_value['remarks'] = $remarks;

                if(isset($_FILES['customer_image_upload']) && $_FILES['customer_image_upload']['name']!= ""){
                    $desired_dir = "../../admin/images/customer";
                    chmod( "../../admin/images/customer", 0777);
                    $file_name = $_FILES['customer_image_upload']['name'];
                    $file_size =$_FILES['customer_image_upload']['size'];
                    $file_tmp =$_FILES['customer_image_upload']['tmp_name'];
                    $file_type=$_FILES['customer_image_upload']['type'];
                    if($file_size < 5297152){
                        if(file_exists("$desired_dir/".$file_name)==false){
                            if(move_uploaded_file($file_tmp,"$desired_dir/".$file_name))
                                $photo = "$file_name";
                        }
                        else{//rename the file if another one exist
                            $new_dir="$desired_dir/".time().$file_name;
                            if(rename($file_tmp,$new_dir))
                                $photo =time()."$file_name";
                        }
                        $photo  = "/images/customer/".$photo;
                    }
                    else {
                        echo "Image size is too large!";die;
                    }
                    $columns_value['photo'] = $photo;
                }

                if($password != "" && $new_password != ""){
                    $old_password =  $dbClass->getResultList("SELECT password FROM customer_infos WHERE customer_id=$customer_id");
                    if(md5($password) == $old_password[0]){
                        $columns_value['password'] = md5($new_password);
                    }
                    else{
                        echo "3";die;
                    }
                }

            //	var_dump($columns_value);
            //	die;
                $condition_array = array(
                    'customer_id'=>$customer_id
                );
                $return = $dbClass->update("customer_infos", $columns_value, $condition_array);

                if($return) echo "2";
                else 	echo "0";
            }
            else
                echo "0";

        break;


	case "get_settings_details":
        //echo '1'; die;
        $general_settings = $dbClass->getResultList("SELECT *
												FROM general_settings s
												WHERE s.id='1'");
        //echo $customer_details; die;
        foreach ($general_settings as $row){
            $data['records'][] = $row;
        }
        echo json_encode($data);
    break;


//this portion will remove while final submission......
    case "db_update_all_items":
        $sql = "SELECT id,NAME, description, catitems  FROM btr_sellercats   WHERE  id IN(32,33,34,36,37,38,39,40,41,42,43,44,45,6,46)";
        //echo $sql;die;
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $categories = $stmt->fetchAll(PDO::FETCH_ASSOC);
        foreach ($categories as $category) {
            $items_id = explode(',',$category['catitems']);
            $columns_value['name'] = $category['NAME'];
            $columns_value['id'] = $category['id'];
            $columns_value['photo']='images/category/noFood.png';

            $category_id = $dbClass->insert("category", $columns_value);
            //var_dump($return_master);die;

            foreach ($items_id as $single_item){
                if ($single_item!=""){

                    //$sql = "SELECT id,1 as category_id, NAME, description, sideitems FROM btr_selleritems WHERE id = ".$single_item;

                    $sql = "SELECT p.price, s.id,".$category_id." as category_id, s.NAME, s.description, s.sideitems FROM btr_selleritems s 
                            LEFT JOIN( 
                            SELECT itemid,price from btr_selleritemprice  
                            )p 
                            on p.itemid= s.id
                            WHERE s.id = ".$single_item;

                    //echo $sql;die;
                    $stmt = $conn->prepare($sql);
                    $stmt->execute();
                    $items = $stmt->fetchAll(PDO::FETCH_ASSOC);

                    $option_list =  explode(',',$items[0]['sideitems']);

                    $i_columns_value['name']=$items[0]['NAME'];
                    $i_columns_value['price']=round($items[0]['price'],2);
                    $i_columns_value['details']=$items[0]['description'];
                    $i_columns_value['category_id']=$items[0]['category_id'];
                    $i_columns_value['feature_image']='images/category/noFood.png';
                    $i_item_id = $dbClass->insert("items", $i_columns_value);


                    //var_dump($i_item_id); die;
                    //$items[0]['NAME'] is item name $category['id'] is category id
                    //var_dump($category['id']);
                    //var_dump($category['id'].'->'.$items[0]['id']);
                    foreach ($option_list as $single_option) {
                        if ($single_option != "") {
                            //var_dump($single_option);die;
                            $sql = "SELECT id, name, type, checked_limit, min_checked_limit, is_required FROM btr_sellersides WHERE id = ".$single_option;
                            //echo $sql;die;
                            $stmt = $conn->prepare($sql);
                            $stmt->execute();
                            $ingredient_list = $stmt->fetchAll(PDO::FETCH_ASSOC);

                            //var_dump($ingredient_list); die;
                            if($ingredient_list[0]['is_required']=="") $ingredient_list[0]['is_required']=0;

                            $o_columns_value['name'] = $ingredient_list[0]['name'];
                            $o_columns_value['item_id'] = $i_item_id;
                            $o_columns_value['is_required'] = $ingredient_list[0]['is_required'];
                            $o_columns_value['minimum_choice'] = $ingredient_list[0]['min_checked_limit'];
                            $o_columns_value['maximum_choice'] = $ingredient_list[0]['checked_limit'];
                            $o_columns_value['type'] = $ingredient_list[0]['type'];

                            $option_id = $dbClass->insert("item_options", $o_columns_value);

                            //var_dump($ingredient_list[0]['id']);die;

                            $sql = "SELECT id,name,price,listid FROM btr_sellersideitems WHERE sid=".$ingredient_list[0]['id'];
                            $stmt = $conn->prepare($sql);
                            $stmt->execute();
                            $option_items_list = $stmt->fetchAll(PDO::FETCH_ASSOC);




                            //var_dump($option_item_id);
                            //$option_list =  explode(',',$items[0]['sideitems']);
                            foreach ($option_items_list as $single_option_items_list){
                                $ov_column_value['option_id']=$option_id;
                                $ov_column_value['ingredient_id']=$single_option_items_list['listid'];
                                $ov_column_value['name']=$single_option_items_list['name'];
                                $ov_column_value['price']=$single_option_items_list['price'];

                                $option_item_id = $dbClass->insert("options_items", $ov_column_value);
                                var_dump($option_item_id);
                            }
                            //var_dump($items[0]['id']);
                            //var_dump($ingredient_list);
                        }
                    }

                    //var_dump($items);
                }
            }
            //$data['records'][] = $row;




        }
    //echo json_encode($items_id); die;
        break;



    case "db_update_ingredient_add":
        echo 'done'; die;
        $sql = "INSERT INTO ingredient (id, name, price) SELECT id, side as name, cost as price FROM btr_sellersides_lists";
        //echo $sql;die;
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        //$return_master = $dbClass->insert("ingredient", $result);

        $dbClass->print_arrays($result[0]['id']);

        foreach ($result as $row) {
            $data['records'][] = $row;
        }
        echo json_encode($data['records'][0]);
    break;

}






?>
<?php
session_start();
include '../dbConnect.php';
include("../dbClass.php");

$dbClass = new dbClass;
extract($_REQUEST);

switch ($q) {
    case "initiate_group_order":

        //echo $id_group; die;
        $count=0;
        $group_order_details_id='';
        $order_key='';
        foreach ($memberName as $users){
            $count++;
        }
        $customer_info = $dbClass->getSingleRow("SELECT full_name, email from customer_infos WHERE customer_id=" . $_SESSION['customer_id']);


        if($id_group!='0' && $id_group!=''){
            //var_dump($id_group); die;
            $group_info = $dbClass->getSingleRow("SELECT name, members from groups_info WHERE id= $id_group AND name='$group_name'");

        }
        else
        {
            $group_info=boolval(false);
        }

        //var_dump($id_group); die;



        if($group_info){
            //var_dump($group_info); die;

            $columns_value = array(
                    'customer_id' => $_SESSION['customer_id'],
                    'group_id' => $id_group,
                    'delivery_date' => $pickup_date_time,
                    'notification_time' => $notification_date_time,
                    'order_status' => 1,
                );
                $group_order_id = $dbClass->insert("group_order", $columns_value);
                $i=0;

                while ($i < ($count)) {
                    // var_dump("SELECT id FROM group_members WHERE group_id=$id_group AND name = $memberName[$i] AND email= ".$memberEmail[$i]);
                    $sql = "SELECT id FROM group_members WHERE group_id=$id_group AND name = '$memberName[$i]' AND email=  '$memberEmail[$i]' ";
                    $members_id = $dbClass->getSingleRow($sql);
                    //var_dump( $members_id);
                    if ($members_id == '') {
                        $member_array = array(
                            'name' => $memberName[$i],
                            'email' => $memberEmail[$i],
                            'group_id' => $id_group
                        );
                        $group_member_id = $dbClass->insert("group_members", $member_array);
                        //var_dump($group_member_id);
                    } else {
                        $group_member_id = (int)$members_id['id'];
                    }
                    $original_string = array_merge(range(0,9), range('a','z'), range('A', 'Z'));
                    $original_string = implode("", $original_string);
                    $order_key= substr(str_shuffle($original_string), 0, 20);

                    $order_member_array = array(
                        'group_member_id' => $group_member_id,
                        'status' => 0,
                        'group_order_id' => $group_order_id,
                        'order_key'=>$order_key

                    );
                    $group_order_details_id = $dbClass->insert("group_order_details", $order_member_array);
                    $i++;
                }
                echo "index.php?groupmaster=".$group_order_details_id."&".$order_key;

            }
        else{
            $columns_value = array(
                'user_id' => $_SESSION['customer_id'],
                'name' => $group_name,
                'members' => $count
            );
            $group_id = $dbClass->insert("groups_info", $columns_value);

            $columns_value = array(
                'customer_id' => $_SESSION['customer_id'],
                'group_id' => $group_id,
                'delivery_date' => $pickup_date_time,
                'notification_time' => $notification_date_time,
                'order_status' => 1,
            );
            $group_order_id = $dbClass->insert("group_order", $columns_value);
            $i=0;

            while ($i < ($count)) {
                $member_array = array(
                    'name' => $memberName[$i],
                    'email' => $memberEmail[$i],
                    'group_id' => $group_id
                );
                $group_member_id = $dbClass->insert("group_members", $member_array);

                $original_string = array_merge(range(0,9), range('a','z'), range('A', 'Z'));
                $original_string = implode("", $original_string);
                $order_key= substr(str_shuffle($original_string), 0, 20);

                $order_member_array = array(
                    'group_member_id' => $group_member_id,
                    'status' => 0,
                    'group_order_id' => $group_order_id,
                    'order_key'=>$order_key
                );
                $group_order_details_id = $dbClass->insert("group_order_details", $order_member_array);

                //Send Email to all member to select their menu
                //http://burritobrothers.test/index.php?group=$group_order_details_id&order_key

                $i++;
            }
            echo "index.php?groupmaster=".$group_order_details_id."&".$order_key;

        }
        //echo json_encode("http://burritobrothers.test/index.php?group=$group_order_details_id&$order_key");

        //echo '$count';
        break;

    case "groups":
        $sql = "SELECT * FROM groups_info WHERE user_id=$customer_id order by id desc";
        //echo $sql;die;
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        if($result==null){
            echo 0;
        }
        else{
            foreach ($result as $row) {
                $data['records'][] = $row;
            }
            echo json_encode($data);
        }
    break;

    case "group_details_by_name":
        $sql = "SELECT gi.id
            FROM groups_info gi
            WHERE gi.name='$group_name' AND gi.user_id=".$_SESSION['customer_id'];
        $result = $group_name=  $dbClass->getSingleRow($sql);

        if(isset($result['id']))
            echo json_encode($result);
        else
            echo 1;

        break;

    case "group_details":
        //echo $group_id;
        $sql = "SELECT name, email FROM group_members where group_id=".$group_id;
        //echo $sql;die;
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        if($result==null){
            echo 0;
        }
        else{
            $group_name=  $dbClass->getSingleRow("SELECT name from groups_info WHERE id=".$group_id);


            foreach ($result as $row) {
                $data['records'][] = $row;
            }
            $data['name']=$group_name['name'];
            //$data['id']=$group_name['name'];

            echo json_encode($data);
        }
        //var_dump($data);
    break;

    case "insert_or_update":


        if(isset($customer_id) && $customer_id != "") {
            $columns_value = array(
                'user_id'=>$customer_id,
                'name'=>$group_name,
                'members'=>$members,
            );
            $return_master = $dbClass->insert("groups_info", $columns_value);

            $user_info=  $dbClass->getSingleRow("SELECT full_name as name , email from customer_infos WHERE customer_id=".$customer_id);
            $user_info['group_id']=$return_master;
            $dbClass->insert("group_members", $user_info);


            while ($members>0){
                $columns_value = array(
                    'group_id'=>$return_master,
                    'name'=>$name[$members-1],
                    'email'=>$email[$members-1],
                );
                $dbClass->insert("group_members", $columns_value);
                $members--;
            }

            echo 1;

        }


        break;

    case "check_cart":
        $_SESSION['cart']=[];

        echo 1;
        break;

    case "group_member_order":


        $sql = "SELECT god.group_order_id, god.order_master_id, ci.full_name, gs.delivery_date from group_order_details god
            LEFT JOIN group_order gs ON gs.order_id=god.group_order_id
            LEFT JOIN customer_infos ci ON ci.customer_id=gs.customer_id
            WHERE god.id = $group_order_details_id AND god.order_key = '$order_key' AND god.status=0";
        //echo $sql;
        $group_order_info_members = $dbClass->getSingleRow($sql);
        //var_dump($group_order_info_members);
        if($group_order_info_members){
            $_SESSION['group_master'] = $group_order_info_members['full_name'];
            $_SESSION['delivery_date'] = $group_order_info_members['delivery_date'];
            $_SESSION['group_order_details_id'] = $group_order_details_id;
            echo 1;
        }
        else
        {
            echo 0;
        }
        break;

    case "set_session_group_order":
        //echo $order_id; die;
        $_SESSION['groupOrderId']= $order_id;
        $_SESSION['returnPage']= 'groupOrderDetails';
        echo 1;
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
                WHERE go.order_id ='$order_id' OR go.invoice_no = '$order_id'";
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
                                         WHERE go.order_id ='$order_id' OR go.invoice_no = '$order_id'";
        //echo $sql;die;
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $tax = $dbClass->getSingleRow("Select tax_type, tax_amount, tax_enable from general_settings where id=1");

        $data['order_details']=$result[0];
        $data['tax']=$tax;
        echo json_encode($data);
        break;

    case "apply_coupon":
        //echo $group_order_id; die;

        //echo $coupon_code; die;

        $coupon_amount = 0;
        $date = date("Y-m-d");

        $coupon_info = $dbClass->getSingleRow("select id,c_type,amount,min_order_amount from cupons where status=1 and ((cupon_no='$coupon_code' and customer_id = ".$_SESSION['customer_id'].") or cupon_no='$coupon_code' and customer_id is null) and (DATE_FORMAT(start_date, '%Y-%m-%d') <= '$date' AND DATE_FORMAT(end_date, '%Y-%m-%d') >= '$date')");

        //var_dump("select id,c_type,amount,min_order_amount from cupons where status=1 and ((cupon_no='$cupon_code' and customer_id = ".$_SESSION['customer_id'].") or cupon_no='$cupon_code' and customer_id is null) and (DATE_FORMAT(start_date, '%Y-%m-%d') <= '$date' AND DATE_FORMAT(end_date, '%Y-%m-%d') >= '$date')");
//die;

       // echo($coupon_info);die;
        $order_info = $dbClass->getSingleRow("select total_order_amt from group_order where order_id=$group_order_id");


        if($coupon_info['id'] && $order_info['total_order_amt']>=$coupon_info['min_order_amount']){
            $condition_array = array(
                'order_id'=>$group_order_id
            );
            $columns_value = array(
                'cupon_id'=>$coupon_info['id']
            );
            $return = $dbClass->update("group_order", $columns_value, $condition_array);
            echo 1;

        }
        else echo 2;

        break;

    case "add_tips":
        $condition_array = array(
            'order_id'=>$group_order_id
        );
        $columns_value = array(
            'tips'=>$tips
        );
        $return = $dbClass->update("group_order", $columns_value, $condition_array);
        echo 1;
        break;

    case "viewCartSummery":
        $tax = $dbClass->getSingleRow("Select tax_type, tax_amount, tax_enable from general_settings where id=1");


        $sql = "SELECT coalesce(oms.order_id, 'NAN') as order_id, god.id, coalesce(oms.total_order_amt, '0') as total_order_amt, coalesce(oms.order_status, '0') as order_status, gm.name, gm.email, god.id as group_order_details_id, god.order_key
               FROM group_order go
               LEFT JOIN group_order_details god ON god.group_order_id= go.order_id
               LEFT JOIN group_members gm ON gm.id=god.group_member_id
               LEFT JOIN(
               SELECT om.order_id, om.group_order_details_id,
                 om.total_order_amt, om.order_status 
                FROM order_master om
                LEFT JOIN order_details d ON d.order_id = om.order_id
                LEFT JOIN items p ON p.item_id = d.item_id
                LEFT JOIN category ca ON ca.id = p.category_id
                GROUP BY d.order_id
                )oms ON oms.group_order_details_id= god.id
                WHERE go.order_id =$group_order_id";
        //echo $sql;die;
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $total_order_amount=0;
        //var_dump($result);

        foreach ($result as $row) {
            $total_order_amount+=$row['total_order_amt'];
            $data['records'][] = $row;
        }
        //echo($total_order_amount);die;
        $date = date("Y-m-d");
        $cupon_sql ="SELECT cu.amount, cu.min_order_amount, cu.c_type FROM group_order go                  
                    LEFT JOIN(
                    select id,c_type,amount,min_order_amount 
                    from cupons 
                    where status=1 AND (DATE_FORMAT(start_date, '%Y-%m-%d') <= '2020-01-28' 
                    AND DATE_FORMAT(end_date, '%Y-%m-%d') >= '2020-01-28')      
                    ) cu ON cu.id= go.cupon_id
                    WHERE go.order_id=$group_order_id";


        $cupon_info = $dbClass->getSingleRow($cupon_sql);
        //var_dump($cupon_sql);
        $discount = 0;
        if($cupon_info){
            if($total_order_amount>=$cupon_info['min_order_amount']){
                if($cupon_info['c_type']==1){
                    $discount = $cupon_info['amount'];
                }
                else{
                    $discount = ($total_order_amount*$cupon_info['amount'])/100;
                }
                //var_dump( $cupon_info);die;

            }
        }
        $tax_amt = 0;
        if($tax['tax_enable']==1){
            if($tax['tax_type']==0){
                $tax_amt = ($total_order_amount-$discount)*$tax['tax_amount']/100;
            }
            else
                $tax_amt = $tax['tax_amount'];
        }

        $condition_array = array(
            'order_id'=>$group_order_id
        );
        $columns_value = array(
            'discount_amount'=>$discount,
            'total_order_amt'=>$total_order_amount,
            'tax_amount'=>$tax_amt
        );
        $return = $dbClass->update("group_order", $columns_value, $condition_array);

        //var_dump($total_order_amount);

        $sql = "  SELECT ci.full_name, gi.name, go.order_id as group_order_id, go.discount_amount, go.tax_amount, go.total_order_amt, go.total_order_amt, go.cupon_id, go.tips,
                                        case go.order_status when 2 then 'Invitation Sent' when 3 then 'Menu Selected' when 4 then 'Order Panding' when 5 then 'Order Approved' when 6 then 'Order Ready' else 'Order Initiate' end order_status, 
										case go. payment_status when 1 then 'Not Paid' else 'Paid' end payment_status, 
										case go.payment_method when 1 then 'Cash On Delivary' when 2 then 'Loyalty Payment' when 3 then 'Card' when 4 then 'Gift Card' else 'Not Defined' end payment_method
                                        from group_order go
                                        LEFT JOIN groups_info gi ON gi.id = go.group_id
                                        LEFT JOIN(
                                        SELECT full_name, address, contact_no,customer_id from customer_infos 
                                        )ci ON ci.customer_id=go.customer_id              
                                         WHERE go.order_id=$group_order_id";
        //echo $sql;die;
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $data['order_details']=$result[0];
        echo json_encode($data);

        break;

    case "checkout":

        //------------ generate invoice no  -------------------
        $c_y_m = date('my');
        $last_invoice_no = $dbClass->getSingleRow("SELECT max(RIGHT(invoice_no,5)) as invoice_no FROM group_order");

        if($last_invoice_no == null){
            $inv_no = '00001';
        }
        else{
            $inv_no = $last_invoice_no['invoice_no']+1;
        }

        $str_length = 5;
        $str = substr("00000{$inv_no}", -$str_length);
        //echo 333;die;

        $invoice_no = "BBGO$c_y_m$str";
        //-----------------------------------------------------

    $columns_value = array(
        'invoice_no'=>$invoice_no,
        'payment_status'=>2,
        'payment_method'=>$payment_method,
        'loyalty_point'=>$loyalty_point,
        'total_paid_amount'=>$total_paid_amount,
        'order_status'=>4,
    );
    $condition_array = array(
        'order_id'=>$group_order_id
    );

    $return_master = $dbClass->update("group_order", $columns_value, $condition_array);

        $order_details = $dbClass->getSingleRow("SELECT * FROM group_order where invoice_no='$invoice_no' ");
        $c_loyalty_points = $dbClass->getSingleRow('SELECT loyalty_points from customer_infos where customer_id='.$_SESSION["customer_id"]);

        $columns_value = array(
            'customer_id'=>$order_details['customer_id'],
            'delivery_date'=>$order_details['delivery_date'],
            'delivery_type'=>1,
            'remarks'=>$order_details['remarks'],
            'order_status'=>1,
            'invoice_no'=>$order_details['invoice_no'],
            'payment_method' =>$order_details['payment_method'],
            'total_order_amt'=>$order_details['total_order_amt'],
            'tax_amount'=>$order_details['tax_amount'],
            'total_paid_amount'=>$order_details['total_paid_amount'],
            'tips'=>$order_details['tips'],
            'payment_status' =>$order_details['payment_status'],
            'loyalty_point'=>$order_details['loyalty_point'],
            'group_order_details_id'=>0,
            'group_order_id'=>$order_details['order_id'],
            'discount_amount'=>$order_details['discount_amount']
        );

        //var_dump($columns_value);
        //var_dump($order_details);

        $dbClass->insert("order_master", $columns_value);


        //var_dump($c_loyalty_points['loyalty_points']);

        if($return_master){
            $columns_value = array(
                'loyalty_points' =>$c_loyalty_points['loyalty_points']+$loyalty_point-$loyalty_deduct
            );
            $condition_array = array(
                'customer_id'=>$_SESSION['customer_id']

            );
            $return_master = $dbClass->update("customer_infos", $columns_value, $condition_array);


            $_SESSION['Last_invoice_no']=$invoice_no;

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
        else echo "0";
        break;




}
?>
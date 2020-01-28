<?php
session_start();
include("../includes/dbConnect.php");
include("../includes/dbClass.php");
$dbClass = new dbClass;
$is_logged_in_customer = "";
$website_url  = $dbClass->getDescription('website_url');
$logo         =$website_url."admin/".$dbClass->getDescription('company_logo');


if(!isset($_SESSION['customer_id']) && $_SESSION['customer_id']!=""){ ob_start(); header("Location:index.php"); exit();}
else $is_logged_in_customer = 1;
$customer_id = $_SESSION['customer_id'];
$orders_info = $dbClass->getResultList("SELECT count(god.id) as members, gi.name, go.order_id, go.order_date, go.delivery_date, go.total_order_amt, go.notification_time,
                                        case go.order_status when order_status=2 then 'Invitation Sent' when order_status=3 then 'Menu Selected' when order_status=4 then 'Order Panding' when order_status=5 then 'Order Approved' when order_status=6 then 'Order Ready' else 'Order Initiate' end order_status 
                                        from group_order go 
                                        LEFT JOIN (
                                        SELECT name, id FROM groups_info
                                        ) gi ON gi.id=go.group_id
                                        INNER JOIN (
                                        SELECT id, group_order_id  from group_order_details 
                                        ) god on god.group_order_id = go.order_id 
                                        WHERE go.customer_id=$customer_id  GROUP BY god.group_order_id 
                                        ORDER BY god.group_order_id desc 
										");
if(empty($orders_info)){
    echo "<h6 class='center'>Your have no orders </h6>";
}
else{

    ?>
    <h6 class="center" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">Your Order List </h6>
    <hr>
    <section class="home-icon shop-cart bg-skeen" style="padding-top: 20px">
        <div class="container" style="max-width:100%" id="oredrs_div">
            <table class="table table-bordered table-hover" id="table_big" style="display: none; background-color: white">
                <thead>
                <tr style="background-color: #e4b95b; alignment: center">

                    <th>Group Name</th>
                    <th>Order Date</th>
                    <th>Delivery date</th>
                    <th>Final Notification Time</th>
                    <th>Members</th>
                    <th>Amount</th>
                    <th>Status</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <?php
                    foreach($orders_info as $order){
                        $order_no = '"'.$order['order_id'].'"';
                        echo
                            "<tr>
							 <td style='font-weight: bold' onclick='view_order(".$order_no.")'><button style='background: none; border: none'>".$order['name']."</button></td>
							  <td>".$order['order_date']."</td>
							  <td>".$order['delivery_date']."</td>
							  <td>".$order['notification_time']."</td>
							  <td>".$order['members']."</td>
							  <td>".$order['total_order_amt']."</td>
							  <td>".$order['order_status']."</td>                                        
							  <td><button class='btn btn-block'><i class='fa fa-search-plus pointer' onclick='view_order(".$order_no.")'></i></button></td>
						  </tr>
						";
                    }
                    ?>
                </tr>
                </tbody>
            </table>
            <table class="table table-bordered table-hover" id="" style="display: none; width: 100%">
                <thead>
                <tr style="background-color: #e4b95b; alignment: center">
                    <th width="30%" style='font-size: 13px'>Order No</th>
                    <th  style='font-size: 13px'>Amount</th>
                    <th width="35%" style='font-size: 13px'>Status</th>
                    <th width="10%"></th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <?php
                    foreach($orders_info as $order){
                        $order_no = '"'.$order['order_id'].'"';
                        echo
                            "<tr>
							  <td style='font-s font-size: 11px'>".$order['name']."</td>
							  <td style='font-size: 11px'>".$order['total_order_amt']."</td>
							  <td style='font-size: 11px'>".$order['order_status']."</td>
							  <td style='background-color: #e4b95b'><i class='fa fa-search-plus pointer' onclick='view_order(".$order_no.")'></i></td>
						  </tr>
						";
                    }
                    ?>
                </tr>
                </tbody>
            </table>

            <table class="table table-bordered table-hover" id="table_small" style="display: none">
                <thead>
                <tr style="background-color: #e4b95b; alignment: center">
                    <th width="30%" style='font-size: 13px'>Group Name</th>
                    <th style='font-size: 13px'>Amount</th>
                    <th width="35%" style='font-size: 13px'>Status</th>
                    <th width="10%" ></th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <?php
                    foreach($orders_info as $order){
                        $order_no = '"'.$order['order_id'].'"';
                        echo
                            "<tr>
							  <td style='background-color: #e4b95b; font-size: 12px'>".$order['name']."</td>
							  <td style='font-size: 12px'>".$order['total_order_amt']."</td>
							  <td style='font-size: 12px'>".$order['order_status']."</td>
							  <td style='background-color: #e4b95b'><i class='fa fa-search-plus pointer' onclick='view_order(".$order_no.")'></i></td>
						  </tr>
						";
                    }
                    ?>
                </tr>
                </tbody>
            </table>
        </div>
    </section>
    <?php
}
?>


<!-- Start Order details -->
<div class="modal fade booktable" id="order_modal" tabindex="-2" role="dialog" aria-labelledby="booktable">
    <div class="modal-dialog" role="document" style="width:80% !important">
        <div class="modal-content">
            <div class="modal-body" style="margin-bottom: 50px">
                <div id="order-div" >
                    <div class="title text-center">
                        <h3 class="text-coffee left"> <a href="index.php"><img src="<?php echo ($logo); ?>" alt="" style="height: 100px; width: 100px"></a></h3>
                        <h4 class="text-coffee left">Order No # <span id="ord_title_vw"></span></h4>
                    </div>
                    <div class="done_registration ">
                        <div class="doc_content">
                            <div class="col-md-12" style="margin-left: 0px; padding: 0px; margin-bottom: 20px">
                                <div class="col-md-6" style="margin: 0px; padding: 0px">
                                    <h4>Order Details:</h4>
                                    <div class="byline">
                                        <span id="dlv_ps"></span> <br/>
                                        <span id="dlv_pm"></span><br/>
                                        <span id="order_status"></span><br/>
                                        <span id="ord_date"></span><br/>
                                        <span id="ntf_date"></span> <br/>
                                        <span id="dlv_date"></span> <br/>

                                    </div>
                                </div>
                                <div class="col-md-6" style="text-align:right">
                                    <h4>Customer Details:</h4>
                                    <address id="customer_detail_vw">
                                    </address>
                                </div>

                            </div>
                            <div id="ord_detail_vw">
                                <table class="table table-bordered" >
                                    <thead>
                                    <tr>
                                        <th align="center">Items</th>
                                        <th width="10%" align="center">Quantity</th>
                                        <th width="12%" style="text-align:right">Rate</th>
                                        <th width="12%"  style="text-align:right">Price</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                                <p>Note: <span id="note_vw"></span></p>
                                <p>Print Time : <?php echo date("Y-m-d h:m:s"); ?></p>
                                <br />

                                <p style="font-weight:bold; text-align:center" id="thankingNoted">Thank you. Hope we will see you soon </p>
                            </div>
                        </div>


                    </div>
                </div>
                <p class="text-danger text-left">*YOU CAN SELECT ITEMS FOR THE MEMBERS OR KEEP IT EMPTY</p>

                <div class="text-center">
                    <div class="cupon-part">
                        <input type="text" name="txt" id="coupon_code" placeholder="Cupon Code" style="border-radius: 5px">
                    </div>
                    <a href="#" class="btn-medium btn-dark-coffee" id="apply_cupon"  style="border-radius: 5px">Apply Coupon</a>

                </div>

                <div class="col-md-12 text-center" style="margin-bottom: 5px"> <span><input class="radio-inline text-center" type="checkbox" id="checkoutConirmation"></span><span style="padding-top: 5px"> Please confirm your submission</span></div>
                <div class="col-md-12 text-center" style="margin-bottom: 10px" ><button type="button" class="btn btn-primary"  data-dismiss="modal" aria-label="Close" onclick="checkout()">Proceed to Checkout</button></div>


                <div class="col-md-12" style="text-align: center"> <button type="button" class="btn btn-warning" id="order_print"><i class="fa fa-lg fa-print"></i></button></div>
            </div>
        </div>
    </div>
</div>
<!-- End order -->

<script>
    //alert('ok')
    var sWidth = window.screen.width;
    var print_module=''
    var group_id= ''
     //alert("sWidth is: " + sWidth);

    function checkout(){
        //alert('sfd')
        //$("#order_modal").modal('hide');
        window.location.href = "index.php?page=groupCheckout&id="+group_id
        //$('#account_contents').load('views/groupCheckout.php');


    }


    if(sWidth<801){
        $('#table_big').css('display', 'none')
        $('#table_small').css('display', 'block')
    }
    else {
        $('#table_big').css('display', 'block')
        $('#table_small').css('display', 'none')
    }

    selectItems =function selectItems(grouporder_id, key) {
        //alert('id:'+grouporder_id)
        //sessionStorage.setItem('returnPage','groupOrderDetails');

        $.ajax({
            url: "./includes/controller/groupController.php",
            type: 'POST',
            async: false,
            dataType: "json",
            data: {
                q: "set_session_group_order",
                order_id: grouporder_id
            },
            success: function (data) {
               // alert(data)
                window.location.href = project_url+'index.php?groupmaster='+key;

            }
        })

    }

    var view_order = function view_order(order_id){
        group_id = order_id;
        $('#ord_detail_vw>table>tbody').html('');
        $.ajax({
            url:"./includes/controller/groupController.php",
            type:'POST',
            async:false,
            dataType: "json",
            data:{
                q: "get_group_order_details",
                order_id:order_id
            },
            success: function(data){
                //alert(data)
                //console.log(data)
                if(!jQuery.isEmptyObject(data.order_details)) {

                        $('#ord_title_vw').html(data.order_details.name);
                        $('#ord_date').html("Ordered time: "+data.order_details.order_date);
                        $('#dlv_date').html("Delivery time: "+data.order_details.delivery_date);
                        $('#ntf_date').html("Notification time: "+data.order_details.notification_time);
                        $('#order_status').html("Order Status: "+data.order_details.order_status);

                        $('#dlv_ps').html("Payment Status: "+data.order_details.payment_status);
                        $('#dlv_pm').html("Payment Method: "+data.order_details.payment_method);
                        $('#customer_detail_vw').html(" "+data.order_details.full_name+"<br/><b>Mobile:</b> "+data.order_details.mobile+"<br/><b>Address:</b> "+data.order_details.c_address);
                        //$('#note_vw').html(data.remarks);
                    }

                    if(!jQuery.isEmptyObject(data.records)){
                        var sub_total=0;
                        $.each(data.records, function(i,data){
                            //console.log(data)
                            //alert(data['id'])

                            var order_tr = '';
                            var order_total = 0;
                            order_infos	 = data['order_info'];
                            //console.log(data['order_info'])
                            var order_arr = order_infos.split('..,');
//alert(data['group_order_details_id']+'&'+data['order_key'])
                            //console.log(order_arr[1])
                            order_tr+='<tr><td colspan="4" align="left"  ><b>'+data['name']+' </b> ('+data['email']+')</td>'
                            if(!order_arr[0]){
                                var tem = data['group_order_details_id']+'&'+data['order_key']
                                order_tr += '<tr><td class="text-capitalize">Not Selected<br><a href="#" onclick="selectItems('+order_id+','+"'"+data['group_order_details_id']+'&'+data['order_key']+"'"+')">Click here to Select item for <b>'+data['name']+'<b></a></td><td align="center"></td><td align="right"></td><td align="right">00</td></tr>';
                            }
                            else{
                                $.each(order_arr, function(i,orderInfo){
                                    //alert(orderInfo)
                                    var order_info_arr = orderInfo.split('#');
                                    var total = ((parseFloat(order_info_arr[4])*parseFloat(order_info_arr[5])));
                                    order_tr += '<tr><td class="text-capitalize">'+order_info_arr[2]+' <br>'+order_info_arr[6]+'</td><td align="center">'+order_info_arr[5]+'</td><td align="right">'+order_info_arr[4]+'</td><td align="right">'+total+'</td></tr>';
                                    order_total += total;
                                });
                                sub_total += order_total;
                                order_tr += '<tr><td colspan="3" align="right" ><b>Grand Total Amount</b></td><td align="right"><b>'+order_total.toFixed(2)+'</b></td></tr>';
                            }

                            $('#ord_detail_vw>table>tbody').append(order_tr);

                            //for small device

                        });
                        var order_tr='<tr align="right"><td colspan="3" ><b>Total Amount</b></td><td align="right">'+sub_total.toFixed(2)+'</td></tr>'

                        $('#ord_detail_vw>table>tbody').append(order_tr);
                    }
                }

        });
        $('#order_modal').modal();
    }
    $('#apply_cupon').click(function(){
        var cupon_code = $('#coupon_code').val();
        //alert(cupon_code)
        if(cupon_code !=""){
            $.ajax({
                url: "./includes/controller/groupController.php",
                type:'POST',
                async:false,
                data: {
                    q:'apply_cupon',
                    cupon_code:cupon_code,
                    group_order_id: group_id
                },
                success: function(data){
                    alert('Cupon has been added')

                }
            });
        }
    })


</script>

<?php

if(isset($_SESSION['groupOrderId'])){
    ?>
    <script>
        //alert(<?php echo $_SESSION['groupOrderId']; ?>)
        view_order(<?php echo $_SESSION['groupOrderId']; ?>)
    </script>
    <?php
    unset($_SESSION['groupOrderId']);
    unset($_SESSION['groupOrderDetails']);
}
?>


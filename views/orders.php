<?php
session_start();
include("../includes/dbConnect.php");
include("../includes/dbClass.php");
$dbClass = new dbClass;
$is_logged_in_customer = "";
$website_url  = $dbClass->getDescription('website_url');
$currency   = $dbClass->getDescription('currency_symbol');

$logo         =$website_url."admin/".$dbClass->getDescription('company_logo');


if(!isset($_SESSION['customer_id']) && $_SESSION['customer_id']!=""){ ob_start(); header("Location:index.php"); exit();}
else $is_logged_in_customer = 1;
$customer_id = $_SESSION['customer_id'];
$orders_info = $dbClass->getResultList("SELECT invoice_no order_no, order_id, order_date,delivery_date, 
										CASE delivery_type WHEN 1 THEN 'Takeout' WHEN 2 THEN 'Delivery' END delevery_type, 
										CASE order_status WHEN 1 THEN 'Ordered' WHEN 2 THEN 'Received' WHEN 3 THEN 'Preparing' WHEN 4 THEN 'Ready' WHEN 5 THEN 'Delivered'END order_status, 
										total_order_amt,total_paid_amount
										FROM order_master
										WHERE customer_id=$customer_id 
										order by order_id desc
										");
if(empty($orders_info)){
    echo "<h6 class='center'>Your have no orders </h6>";
}
else{


    ?>
    <h6 class="center">Your Order List </h6>
    <hr>
    <section class="home-icon shop-cart bg-skeen" style="padding-top: 20px">
        <div class="container" style="max-width:100%" id="oredrs_div">
            <table class="table table-bordered table-hover" id="table_big" style="display: none; background-color: white">
                <thead>
                <tr style="background-color: #e4b95b; alignment: center">
                    <th>Order No</th>
                    <th>Order Date</th>
                    <th>Delevery date</th>
                    <th>Type</th>
                    <th>Amount</th>
                    <th>Paid</th>
                    <th>Status</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <?php
                    foreach($orders_info as $order){
                        $order_no = '"'.$order['order_no'].'"';
                        echo
                            "<tr>
							  <td style='font-weight: bold' onclick='view_order(".$order_no.")'><button style='background: none; border: none'>".$order['order_no']."</button></td>
							  <td>".$order['order_date']."</td>
							  <td>".$order['delivery_date']."</td>
							  <td>".$order['delevery_type']."</td>
							  <td>".$currency."".$order['total_order_amt']."</td>
							  <td>".$currency."".$order['total_paid_amount']."</td>
							  <td>".$order['order_status']."</td>
							  <td><button class='btn btn-block'><i class='fa fa-search-plus pointer' onclick='view_order(".$order_no.")'></i></button></td>
						  </tr>
						";
                    }
                    ?>
                </tr>
                </tbody>
            </table>

            <table class="table table-bordered table-hover" id=""  width: 100%">
            <thead>
            <tr style="background-color: #e4b95b; alignment: center">
                <th style='font-size: 13px'>Order No</th>
                <th style='font-size: 13px'>Amount</th>
                <th style='font-size: 13px'>Status</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <?php
                foreach($orders_info as $order){
                    $order_no = '"'.$order['order_no'].'"';
                    echo
                        "<tr>
							  <td style='font-s font-size: 11px'>".$order['order_no']."</td>
							  <td style='font-size: 11px'>".$currency."".$order['total_order_amt']."</td>
							  <td style='font-size: 11px'>".$order['order_status']."</td>
							  <td style='background-color: #e4b95b'><i class='fa fa-search-plus pointer' onclick='view_order(".$order_no.")'></i></td>
						  </tr>
						";
                }
                ?>
            </tr>
            </tbody>
            </table>

            <table class="table table-bordered table-hover" id="table_small" >
                <thead>
                <tr style="background-color: #e4b95b; alignment: center">
                    <th style='font-size: 13px;width: 36%'>Order No</th>
                    <th style='font-size: 13px; width: 27%'>Amount</th>
                    <th style='font-size: 13px; width: 27%'>Status</th>
                    <th style="width: 10%"></th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <?php
                    foreach($orders_info as $order){
                        $order_no = '"'.$order['order_no'].'"';
                        echo
                            "<tr>
							  <td style='background-color: #e4b95b; font-size: 12px'>".$order['order_no']."</td>
							  <td style='font-size: 12px'>".$currency."".$order['total_order_amt']."</td>
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
<div class="modal fade booktable" id="order_modal" tabindex="-2" role="dialog" aria-labelledby="booktable">
    <div class="modal-dialog width_80_p" role="document" >
        <div class="modal-content">
            <div class="modal-body" style="margin-bottom: 50px">
                <div id="order-div" >
                    <div class="title text-center">
                        <h3 class="text-coffee left"> <a href="index.php"><img src="<?php echo ($logo); ?>" alt="" style="height: 100px; width: 100px"></a></h3>
                    </div>
                    <div class="done_registration ">
                        <div class="doc_content">
                            <div class="col-md-12 left-margin-0" style=" padding: 0px; margin-bottom: 20px">
                                <div class="col-md-6" style="margin: 0px; padding: 0px">
                                    <h4>Order Details:</h4>
                                    <div class="byline">
                                        <span class="after_order_initiate" id="inv_no"></span>
                                        <span id="order_status"></span><br/>
                                        <span id="ord_date"></span><br/>
                                        <span id="dlv_date"></span> <br/>

                                    </div>
                                </div>
                                <div class="col-md-6 text-right text-right-l left-margin-0  left-padding-0">
                                    <h4>Customer Details:</h4>
                                    <address id="customer_detail_vw">
                                    </address>
                                </div>

                            </div>

                            <div id="ord_detail_vw">
                                <table class="table table-bordered" id="ord_detail_vw_big" >
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
                                <table class="table table-bordered" id="ord_detail_vw_small" style="display: none" >
                                    <thead>
                                    <tr>
                                        <th align="center">Items</th>
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


                <div class="col-md-12" style="text-align: center"> <button type="button" class="btn btn-warning" id="order_print"><i class="fa fa-lg fa-print"></i></button></div>
            </div>
        </div>
    </div>
</div>



<!-- Start Order details -->


<!-- End order -->

<script>
    var sWidth = window.screen.width;
    var print_module=''
    //alert("sWidth is: " + sWidth);
    if(sWidth<801){
        $('#table_big').css('display', 'none')
        $('#table_small').css('display', 'block')
    }
    else {
        $('#table_big').css('display', 'block')
        $('#table_small').css('display', 'none')
    }

    var view_order = function view_order(order_id){
        //alert('ok')
        $('#ord_detail_vw>table>tbody').html('');

        if(!order_id.includes("BBG")){
            $.ajax({
                url:project_url+"includes/controller/ecommerceController.php",
                type:'POST',
                async:false,
                dataType: "json",
                data:{
                    q: "get_order_details_by_invoice",
                    order_id:order_id
                },
                success: function(data){
                    //alert(data.item_id)
                    console.log(data)
                    if(!jQuery.isEmptyObject(data.records)){
                        $.each(data.records, function(i,data){
                            //$('#ord_title_vw').html(data.invoice_no);
                            $('#inv_no').html("Invoice Number: "+data.invoice_no);
                            $('#ord_date').html("Ordered time: "+data.order_date);
                            $('#dlv_date').html("Delivery time: "+data.delivery_date);
                            $('#customer_detail_vw').html(" "+data.customer_name+"<br/><b>Mobile:</b> "+data.customer_contact_no+"<br/><b>Address:</b> "+data.customer_address);
                            $('#note_vw').html(data.remarks);

                            var order_tr = "";
                            var order_total = 0;
                            order_infos	 = data.order_info;
                            var order_arr = order_infos.split('..,');
                            $.each(order_arr, function(i,orderInfo){
                                //alert(orderInfo)
                                var order_info_arr = orderInfo.split('#');
                                var total = ((parseFloat(order_info_arr[4])*parseFloat(order_info_arr[5])));
                                order_tr += '<tr><td class="text-capitalize">'+order_info_arr[2]+' <br>'+order_info_arr[6].split('..')[0]+'</td><td align="center">'+order_info_arr[5]+'</td><td align="right">'+currency_symbol+''+order_info_arr[4]+'</td><td align="right">'+currency_symbol+''+total+'</td></tr>';
                                order_total += total;
                            });
                            var total_order_bill = ((parseFloat(order_total)+parseFloat(data.delivery_charge))-parseFloat(data.discount_amount));
                            var total_paid = data.total_paid_amount;
                            order_tr += '<tr><td colspan="3" align="right" ><b>Discount</b></td><td align="right"><b>'+currency_symbol+''+data.discount_amount+'</b></td></tr>';
                            order_tr += '<tr><td colspan="3" align="right" ><b>Tax</b></td><td align="right"><b>'+currency_symbol+''+data.tax_amount+'</b></td></tr>';
                            order_tr += '<tr><td colspan="3" align="right" ><b>Tips</b></td><td align="right"><b>'+currency_symbol+''+data.tips+'</b></td></tr>';
                            order_tr += '<tr><td colspan="3" align="right" ><b>Total Amount</b></td><td align="right"><b>'+currency_symbol+''+total_paid+'</b></td></tr>';
                            $('#ord_detail_vw>table>tbody').append(order_tr);



                            //for small device

                        });
                    }
                }
            });

        }
        else {
            $.ajax({
                url:project_url+"includes/controller/groupController.php",
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

                        //$('#ord_title_vw').html(data.order_details.name);
                        $('#inv_no').html("Invoice Number: "+data.order_details.invoice_no);
                        $('#ord_date').html("Ordered time: "+data.order_details.order_date);
                        $('#dlv_date').html("Delivery time: "+data.order_details.delivery_date);
                        $('#ntf_date').html("Notification time: "+data.order_details.notification_time);
                        $('#order_status').html("Order Status: "+data.order_details.order_status);
                        $('#customer_detail_vw').html(" "+data.order_details.full_name+"<br/><b>Mobile:</b> "+data.order_details.mobile+"<br/><b>Address:</b> "+data.order_details.c_address);
                        //$('#note_vw').html(data.remarks);
                    }
                    let order_status = parseInt(data['order_details']['status'])
                    if(order_status>3){
                        $('.before_order_initiate').css('display','none')
                        $('.after_order_initiate').css('display','block')

                    }

                    if(!jQuery.isEmptyObject(data.records)){
                        var sub_total=0;
                        $.each(data.records, function(i,data){
                            //console.log(data)
                            //alert(data['id'])

                            var order_tr = '';//for big screen
                            var order_total = 0;
                            var order_tr_small = ''; //for small screen

                            order_infos	 = data['order_info'];
                            var order_arr = order_infos.split('..,');
                            if(!order_arr[0] && order_status<4){
                                order_tr+='<tr><td colspan="4" align="left"  ><b>'+data['name']+' </b> ('+data['email']+')</td>'
                                order_tr_small+='<tr><td colspan="2" align="left"  ><b>'+data['name']+' </b> ('+data['email']+')</td>'
                                var tem = data['group_order_details_id']+'&'+data['order_key']
                                order_tr += '<tr><td class="text-capitalize">Not Selected<br><a href="#" onclick="selectItems('+order_id+','+"'"+data['group_order_details_id']+'&'+data['order_key']+"'"+')">Click here to Select item for <b>'+data['name']+'<b></a></td><td align="center"></td><td align="right"></td><td align="right">'+currency_symbol+''+'00'+'</td></tr>';
                                order_tr_small+='<tr><td class="text-capitalize">Not Selected<br><a href="#" onclick="selectItems('+order_id+','+"'"+data['group_order_details_id']+'&'+data['order_key']+"'"+')">Click here to Select item for <b>'+data['name']+'<b></a></td><td align="right">'+currency_symbol+''+'00'+'</td></tr>';

                            }
                            else if(order_arr[0]){
                                order_tr+='<tr><td colspan="4" align="left"  ><b>'+data['name']+' </b> ('+data['email']+')</td>'
                                order_tr_small+='<tr><td colspan="2" align="left"  ><b>'+data['name']+' </b> ('+data['email']+')</td>'
                                $.each(order_arr, function(i,orderInfo){
                                    //alert(orderInfo)
                                    var order_info_arr = orderInfo.split('#');
                                    var total = ((parseFloat(order_info_arr[4])*parseFloat(order_info_arr[5])));
                                    order_tr += '<tr><td class="text-capitalize">'+order_info_arr[2]+' <br>'+order_info_arr[6]+'</td><td align="center">'+order_info_arr[5]+'</td><td align="right">'+currency_symbol+''+order_info_arr[4]+'</td><td align="right">'+currency_symbol+''+total+'</td></tr>';
                                    order_tr_small+='<tr><td class="text-capitalize">'+order_info_arr[2]+':'+order_info_arr[5]+'X'+currency_symbol+''+order_info_arr[4]+'<br>'+order_info_arr[6]+'</td><td align="right">'+currency_symbol+''+total+'</td></tr>';

                                    order_total += total;
                                });
                                sub_total += order_total;
                                order_tr += '<tr><td colspan="3" align="right" ><b>Total Amount</b></td><td align="right"><b>'+currency_symbol+''+order_total.toFixed(2)+'</b></td></tr>';
                                order_tr_small += '<tr><td align="right" ><b>Total Amount</b></td><td align="right"><b>'+currency_symbol+''+order_total.toFixed(2)+'</b></td></tr>';

                            }

                            $('#ord_detail_vw_big>tbody').append(order_tr);
                            $('#ord_detail_vw_small>tbody').append(order_tr);


                            //for small device

                        });

                        var discount = 0;
                        var tax = 0;

                        if(data['order_details']['cupon_amount']!=null){
                            if(data['order_details']['c_type']==2){
                                discount =sub_total*data['order_details']['cupon_amount']/100
                            }
                            else  discount =data['order_details']['cupon_amount']
                        }

                        if(data['tax']['tax_enable']!=0){
                            if(data['tax']['tax_enable']==0){
                                tax=(sub_total-discount)*data['tax']['tax_amount']/100
                            }
                            else tax = data['tax']['tax_amount']
                        }


                        var order_tr='<tr align="right"><td colspan="3" ><b>Total Order Amount</b></td><td align="right"><b>'+currency_symbol+''+sub_total.toFixed(2)+'</b></td></tr>'
                        order_tr += '<trstyle="display: block><td colspan="3" align="right" ><b>Discount</b></td><td align="right"><b id="discount_amt">'+currency_symbol+''+discount.toFixed(2)+'</b></td></tr>';
                        order_tr += '<trstyle="display: block><td colspan="3" align="right" ><b>Tax</b></td><td align="right"><b id="tax_amt">'+currency_symbol+''+tax.toFixed(2)+'</b></td></tr>';
                        order_tr += '<trstyle="display: block><td colspan="3" align="right" ><b>Tips</b></td><td align="right"><b id="tax_amt">'+currency_symbol+''+data['order_details']['tips']+'</b></td></tr>';
                        order_tr += '<tr><td colspan="3" align="right" ><b>Grand Total Amount</b></td><td align="right"><b id="total_amt">'+currency_symbol+''+(sub_total-discount+tax+parseInt(data['order_details']['tips'])).toFixed(2)+'</b></td></tr>';


                        $('#ord_detail_vw>table>tbody').append(order_tr);
                    }
                }

            });

        }
        $('#order_modal').modal();
    }

</script>


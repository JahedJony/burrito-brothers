<?php
session_start();
include '../../includes/static_text.php';
include("../../dbConnect.php");
include("../../dbClass.php");
$dbClass = new dbClass;
$user_type = $_SESSION['user_type'];
if(!isset($_SESSION['user_id']) && $_SESSION['user_id'] == "") header("Location:".$site_url."../view/login.php");
else if($dbClass->getUserGroupPermission(77) != 1 ){
    ?>
    <div class="x_panel">
        <div class="alert alert-danger" align="center">You Don't Have permission of this Page.</div>
    </div>
    <?php
}
else{
    $user_name = $_SESSION['user_name'];
    $date = date("y-m-d");

    ?>

    <div class="x_panel">
        <div class="x_title">
            <h2>Order</h2>
            <ul class="nav navbar-right panel_toolbox">
                <li>
                    <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                </li>
            </ul>
            <div class="clearfix"></div>
        </div>
        <div class="x_content">
            <div id="page_notification_div" class="text-center" style="display:none"></div>

            <!-- Advance Search Div-->
            <div class="x_panel">
                <div class="row">
                    <ul class="nav navbar-right panel_toolbox">
                        <li>
                            <a class="collapse-link-adv" id="toggle_form_ad"><b><small class="text-primary">Advance Search & Report</small></b><i class="fa fa-chevron-down"></i></a>
                        </li>
                    </ul>
                </div>
                <div class="x_content adv_cl" id="iniial_collapse_adv">
                    <div class="row advance_search_div alert alert-warning">
                        <div class="row">
                            <label class="control-label col-md-1 col-sm-1 col-xs-6"></label>
                            <label class="control-label col-md-2 col-sm-2 col-xs-6" style="text-align:right">Product</label>
                            <div class="col-md-3 col-sm-3 col-xs-6">
                                <input class="form-control input-sm" type="text" name="ad_item_name" id="ad_item_name"/>
                                <input type="hidden" name="ad_item_id" id="ad_item_id"/>
                            </div>
                            <label class="control-label col-md-2 col-sm-2 col-xs-6" style="text-align:right">Order Date</label>
                            <div class="col-md-3 col-sm-3 col-xs-6">
                                <input class="form-control input-sm ad-item" type="text" name="ad_order_date" id="ad_order_date"  />
                            </div>
                            <label class="control-label col-md-1 col-sm-1 col-xs-6"></label>
                        </div><br/>
                        <div class="row">
                            <label class="control-label col-md-1 col-sm-1 col-xs-6"></label>
                            <label class="control-label col-md-2 col-sm-1 col-xs-6" style="text-align:right">Payment Status</label>
                            <div class="col-md-3 col-sm-3 col-xs-6">
                                <input type="radio" class="flat_radio" name="ad_is_payment" id="ad_is_payment" value="2"/> Paid
                                <input type="radio" class="flat_radio" name="ad_is_payment" id="ad_is_payment" value="1"/> Not paid
                                <input type="radio" class="flat_radio" name="ad_is_payment" id="ad_is_payment" value="0" checked="CHECKED"/> All
                            </div>
                            <label class="control-label col-md-2 col-sm-2 col-xs-6" style="text-align:right">Order Status</label>
                            <div class="col-md-4 col-sm-4 col-xs-8">
                                <input type="radio" class="flat_radio" name="ad_is_order" id="ad_is_order" value="1"/> Ordered
                                <input type="radio" class="flat_radio" name="ad_is_order" id="ad_is_order" value="2"/> Ready
                                <input type="radio" class="flat_radio" name="ad_is_order" id="ad_is_order" value="3"/> Picked
                                <input type="radio" class="flat_radio" name="ad_is_order" id="ad_is_order" value="0" checked="CHECKED"/> All
                            </div>
                        </div><br/>
                        <div style="text-align:center">
                            <div class="col-md-6 col-sm-6 col-xs-12" style="text-align:right">
                                <button type="button" class="btn btn-info" id="adv_search_button"><i class="fa fa-lg fa-search"></i></button>
                                <button type="button" class="btn btn-warning" id="adv_search_print"><i class="fa fa-lg fa-print"></i></button>
                            </div>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <div id="ad_form_submit_error" class="text-center" style="display:none"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Advance search end -->

            <div class="dataTables_length">
                <label>Show
                    <select size="1" style="width: 56px;padding: 6px;" id="order_Table_length" name="order_Table_length" aria-controls="order_Table">
                        <option value="50" selected="selected">50</option>
                        <option value="100">100</option>
                        <option value="200">200</option>
                    </select>
                    Post
                </label>
            </div>
            <div class="dataTables_filter" id="order_Table_filter">
                <div class="input-group">
                    <input class="form-control" id="search_order_field" style="" type="text">
                    <span class="input-group-btn">
                    <button type="button" class="btn btn-primary has-spinner" id="search_order_button">
                     <span class="spinner"><i class="fa fa-spinner fa-spin fa-fw "></i></span>
                     <i class="fa  fa-search "></i>
                    </button>
                </span>
                </div>
            </div>
            <div style="height:250px; width:100%; overflow-y:scroll">
                <table id="order_Table" name="table_records" class="table table-bordered  responsive-utilities jambo_table table-striped  table-scroll ">
                    <thead >
                    <th class="column-title" width="">Invoice No</th>
                    <th class="column-title" width="">Customer</th>
                    <th class="column-title" width="18%">Product</th>
                    <th class="column-title" width="8%">Order Date</th>
                    <th class="column-title" width="8%">Delivery Date</th>
                    <th class="column-title" width="8%">Payment Status</th>
                    <th class="column-title" width="8%">Order Status</th>
                    <th class="column-title" width="10%">Order Amount</th>
                    <th class="column-title no-link last" width="10%"><span class="nobr"></span></th>
                    </tr>
                    </thead>
                    <tbody id="order_table_body" class="scrollable">

                    </tbody>
                </table>
            </div>
            <div id="order_Table_div">
                <div class="dataTables_info" id="order_Table_info">Showing <span id="from_to_limit"></span> of  <span id="total_record"></span> entries</div>
                <div class="dataTables_paginate paging_full_numbers" id="order_Table_paginate">
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade booktable" id="order_modal" tabindex="-2" role="dialog" aria-labelledby="booktable">
        <div class="modal-dialog" role="document" style="width:80% !important">
            <div class="modal-content">
                <div class="modal-body">
                    <div id="order-div" style="margin-bottom: 30px">
                        <div class="title text-center">
                            <h3 class="text-coffee left"> <a href="index.php"><img src="<?php echo ($logo); ?>" alt="" style="height: 100px; width: 100px"></a></h3>
                            <h4 class="text-coffee left">Order No # <span id="ord_title_vw"></span></h4>
                        </div>
                        <div class="done_registration ">
                            <div class="doc_content">
                                <div class="col-md-12" style="margin-left: 0px; padding: 0px; margin-bottom: 20px">
                                    <div class="col-md-6" style="margin: 0px; padding: 0px">
                                        <h4>Order Details:</h4>
                                        <div class="">
                                            <span id="ord_date"></span><br/>
                                            <span id="dlv_date"></span> <br/>
                                            <span id="dlv_ps"></span> <br/>
                                            <span id="dlv_pm"></span><br/>
                                        </div>
                                    </div>
                                    <div class="col-md-6" style="text-align:right">

                                        <div class="col-md-10 col-sm-10 col-xs-6">

                                            <input type="hidden" id="order_status_id" name="order_status_id" value="1" />
                                            <input type="hidden" id="order_id_edit">
                                            <button class="btn btn-primary btn-lg dropdown-toggle" style="width:190px" type="button" id="dropdown_status" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">Change Status
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu" aria-labelledby="dropdown_status">
                                                <li id="order_received"><a href="javascript:void(0)" onclick="update_order_status(2)">Received</a></li>
                                                <li id="order_preparing"><a href="javascript:void(0)" onclick="update_order_status(3)">Preparing</a></li>
                                                <li id="order_ready"><a href="javascript:void(0)" onclick="update_order_status(4)">Ready</a></li>
                                                <li id="order_delivered"><a href="javascript:void(0)" onclick="update_order_status(5)">Delivered</a></li>
                                            </ul>
                                            <button id="order_status_option" type="button" style="min-width:60px" class="btn btn-success btn-lg disabled">Ordered</button>
                                        </div>

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
                                </div>
                            </div>
                            <div class="col-md-12 center"> <button type="button" class="btn btn-warning" id="order_print"><i class="fa fa-lg fa-print"></i></button></div>

                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>

    <?php

}
?>
<script src="js/customTable.js"></script>
<script src="js/autosuggest.js"></script>
<script>

    $('#show_invoice').hide();

        //$('#delivery_date').val('');

    $(document).ready(function () {

        update_order_status = function update_order_status(status_id){
            var order_id = $('#order_id_edit').val();
            //alert(order_id)
            //alert(status_id)
            var url = project_url+"controller/orderController.php";
            $.ajax({
                url: url,
                type:'POST',
                async:false,
                data:{
                    q: "update_order_status",
                    order_id:order_id,
                    status_id:status_id
                },
                success: function(data){
                    //console.log(data)

                    if(data==1){
                        if(status_id==2){
                            $('#order_status_option').html("Received");
                            $('#order_status_id').val(2);
                        }
                        else if(status_id==3){
                            $('#order_status_option').html("Preparing");
                            $('#order_status_id').val(3);
                        }
                        else if(status_id==4){
                            $('#order_status_option').html("Ready");
                            $('#order_status_id').val(4);
                        }
                        else if(status_id==5){
                            $('#order_status_option').html("Preparing");
                            $('#order_status_id').val(5);
                        }
                    }
                }
            });
            edit_order(order_id);
            load_order("")

        }

        var current_page_no=1;
        load_order = function load_order(search_txt){
            //alert('order')
            $("#search_order_button").toggleClass('active');
            var order_Table_length = parseInt($('#order_Table_length').val());
            var ad_product_name = $("#ad_product_name").val();
            var ad_order_date = $("#ad_order_date").val();
            //var ad_delivery_date = $("#ad_delivery_date").val();
            var ad_item_id = $("#ad_item_id").val();
            var ad_is_payment = $("input[name=ad_is_payment]:checked").val();
            var ad_is_order = $("input[name=ad_is_order]:checked").val();
            //alert('order2')

            $.ajax({
                url: project_url+"controller/orderController.php",
                dataType: "json",
                type: "post",
                async:false,
                data: {
                    q: "grid_data",
                    ad_order_date: ad_order_date,
                    //ad_delivery_date: ad_delivery_date,
                    ad_product_name: ad_product_name,
                    ad_item_id: ad_item_id,
                    ad_is_payment: ad_is_payment,
                    ad_is_order: ad_is_order,
                    search_txt: search_txt,
                    limit:order_Table_length,
                    page_no:current_page_no
                },
                success: function(data) {
                   // alert(data)
                    //console.log(data)
                    var todate = "<?php echo date("Y-m-d"); ?>";
                    var user_name =  "<?php echo $user_name; ?>";
                    var html = "";
                    if($.trim(search_txt) == "Print"){
                        var serach_areas= "";
                        if(ad_product_name != '')  	serach_areas += "Product Name: "+ad_product_name+" <br>";
                        if(ad_order_date != '')  	serach_areas += "Order Date: "+ad_order_date+" <br>";
                        //if(ad_delivery_date != '')  serach_areas += "Delivery Date: "+ad_delivery_date+" <br>";
                        if(ad_is_payment == 2)  	serach_areas += "Paid <br>";
                        if(ad_is_payment == 1)  	serach_areas += "Not Paid <br>";
                        if(ad_is_order == 1)    	serach_areas += "Ordered <br>";
                        if(ad_is_order == 2)  	    serach_areas += "Ready <br>";
                        if(ad_is_order == 3)  	    serach_areas += "Picked <br>";

                        /*<button class="no-print" onclick="window.print()">Print</button>*/

                        html +='<button class="no-print" onclick="window.print()">Print</button><div width="100%"  style="text-align:center"><img src="'+employee_import_url+'/images/logo.png" width="80"/></div><h2 style="text-align:center">Cakencookie</h2><h4 style="text-align:center">Order Information Report</h4><table width="100%"><tr><th width="60%" style="text-align:left"><small>'+serach_areas+'</small></th><th width="40%"  style="text-align:right"><small>Printed By: '+user_name+', Date:'+todate+'</small></th></tr></table>';

                        if(!jQuery.isEmptyObject(data.records)){

                            html +='<table width="100%" cellpadding="10" border="1px" style="margin-top:10px;border-collapse:collapse"><thead><tr><th style="text-align:center">Order No</th><th style="text-align:center">Customer</th><th style="text-align:center">Product</th><th style="text-align:center">Order Date</th><th style="text-align:center">Delivery Date</th><th style="text-align:center">Payment Status</th><th style="text-align:center">Order Status</th></tr></thead><tbody>';

                            $.each(data.records, function(i,data){
                                //alert(data)
                                html += "<tr>";
                                html +="<td style='text-align:left'>"+data.invoice_no+"</td>";
                                html +="<td style='text-align:left'>"+data.customer_name+"</td>";
                                var name = data.p_name;
                                var pname = name.replace(", ", "</br>");
                                html +="<td style='text-align:left'>"+pname+"</td>";
                                html +="<td style='text-align:left'>"+data.order_date+"</td>";
                                html +="<td style='text-align:left'>"+data.delivery_date+"</td>";
                                html +="<td style='text-align:center'>"+data.payment_status_text+"</td>";
                                html +="<td style='text-align:center'>"+data.order_status_text+"</td>";
                                html += '</tr>';
                            });
                            html +="</tbody></table>"
                        }
                        else{
                            html += "<table width='100%' border='1px' style='margin-top:10px;border-collapse:collapse'><tr><td><h4 style='text-align:center'>There is no data.</h4></td></tr></table>";
                        }
                        WinId = window.open("", "Order Report","width=1150,height=800,left=50,toolbar=no,menubar=YES,status=YES,resizable=YES,location=no,directories=no, scrollbars=YES");
                        WinId.document.open();
                        WinId.document.write(html);
                        WinId.document.close();
                    }
                    else{
                        if(data.entry_status==0){
                            $('.order_entry_cl').hide();
                        }
                        //for  showing grid's no of records from total no of records
                        show_record_no(current_page_no, order_Table_length, data.total_records )

                        var total_pages = data.total_pages;
                        var records_array = data.records;
                        $('#order_Table tbody tr').remove();
                        $("#search_order_button").toggleClass('active');
                        $.each(records_array, function (i, datas) {
                            //alert(i)
                                if(records_array[i]['order_status']==1){
                                    records_array[i]['order_status']='Ordered'
                                }
                                else if(records_array[i]['order_status']==2){
                                    records_array[i]['order_status']='Received'
                                }
                                else if(records_array[i]['order_status']==3){
                                    records_array[i]['order_status']='Preparing'
                                }
                                else if(records_array[i]['order_status']==4){
                                    records_array[i]['order_status']='Ready'
                                }
                                else if(records_array[i]['order_status']==5){
                                    records_array[i]['order_status']='Delivered'
                                }

                        })
                        if(!jQuery.isEmptyObject(records_array)){

                            //cnsole.log(total_order_amt)
                            //create and set grid table row
                            var colums_array=["order_id*identifier*hidden","invoice_no","customer_name","p_name","order_date","delivery_date","payment_method","order_status","total_order_amt"];
                            //first element is for view , edit condition, delete condition
                            //"all" will show /"no" will show nothing
                            var condition_array=["","","update_status", "1","",""];
                            //create_set_grid_table_row(records_array,colums_array,int_fields_array, condition_arraymodule_name,table/grid id, is_checkbox to select tr );
                            //cauton: not posssible to use multiple grid in same page
                            create_set_grid_table_row(records_array,colums_array,condition_array,"order","order_Table", 0);
                            //show the showing no of records and paging for records
                            $('#order_Table_div').show();
                            //code for dynamic pagination
                            paging(total_pages, current_page_no, "order_Table" );
                        }
                        //if the table has no records / no matching records
                        else{
                            grid_has_no_result("order_Table",10);
                        }
                    }

                }
            });
        }
        // load desire page on clik specific page no
        load_page = function load_page(page_no){
            if(page_no != 0){
                // every time current_page_no need to change if the user change page
                current_page_no=page_no;
                var search_txt = $("#search_order_field").val();
                load_order(search_txt)
            }
        }
        // function after click search button
        $('#search_order_button').click(function(){
            var search_txt = $("#search_order_field").val();
            // every time current_page_no need to set to "1" if the user search from search bar
            current_page_no=1;
            load_order(search_txt);
        });
        //function after press "enter" to search
        $('#search_order_field').keypress(function(event){
            var search_txt = $("#search_order_field").val();
            if(event.keyCode == 13){
                // every time current_page_no need to set to "1" if the user search from search bar
                current_page_no=1;
                load_order(search_txt)
            }
        })
        // load data initially on page load with paging
        load_order("");

        //advance search
        $('#adv_search_button').click(function(){
            load_order("Advance_search");
        });

        //print advance search data
        $('#adv_search_print').click(function(){
            load_order("Print");
        });

        //insert order


        $(document).on('click','#order_print', function(){
            var divContents = $("#order-div").html();
            var printWindow = window.open('', '', 'height=400,width=800');
            printWindow.document.write('<html><head><title>DIV Contents</title>');
            printWindow.document.write('</head><body style="padding:10px">');
            printWindow.document.write('<link href="../plugin/bootstrap/bootstrap.css" rel="stylesheet">');
            printWindow.document.write(divContents);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.print();
        });

        //edit order
        edit_order = function edit_order(order_id){
            //order noticed update
            $('#ord_detail_vw>table>tbody').html('');
            $.ajax({
                url: project_url+"controller/orderController.php",
                type:'POST',
                async:false,
                dataType: "json",
                data:{
                    q: "get_order_details_by_invoice",
                    order_id:order_id
                },
                success: function(data){
                    //console.log(data)
                    //alert(data.item_id)
                    //console.log(data)
                    if(!jQuery.isEmptyObject(data.records)){
                        $.each(data.records, function(i,data){
                            $('#order_id_edit').val(data.order_id);
                            $('#ord_title_vw').html(data.invoice_no);
                            $('#ord_date').html("Ordered time: "+data.order_date);
                            $('#dlv_date').html("Delivery time: "+data.delivery_date);
                            $('#dlv_ps').html("Payment Status: "+data.paid_status);
                            $('#dlv_pm').html("Payment Method: "+data.payment_method);
                            $('#customer_detail_vw').html(" "+data.customer_name+"<br/><b>Mobile:</b> "+data.customer_contact_no+"<br/><b>Address:</b> "+data.customer_address);
                            $('#note_vw').html(data.remarks);

                            var order_tr = "";
                            var order_total = 0;
                            order_infos	 = data.order_info;
                            var order_arr = order_infos.split(',');
                            $.each(order_arr, function(i,orderInfo){
                                var order_info_arr = orderInfo.split('#');
                                var total = ((parseFloat(order_info_arr[4])*parseFloat(order_info_arr[5])));
                                order_tr += '<tr><td class="text-capitalize">'+order_info_arr[2]+' <br>'+order_info_arr[6]+'</td><td align="center">'+order_info_arr[5]+'</td><td align="right">'+order_info_arr[4]+'</td><td align="right">'+total+'</td></tr>';
                                order_total += total;
                            });
                            var total_order_bill = ((parseFloat(order_total)+parseFloat(data.delivery_charge))-parseFloat(data.discount_amount));
                            var total_paid = data.total_paid_amount;
                            order_tr += '<tr><td colspan="3" align="right" ><b>Total Amount</b></td><td align="right"><b>'+total_paid+'</b></td></tr>';
                            $('#ord_detail_vw>table>tbody').append(order_tr);
                            if(data.order_status==2){
                                    $('#order_status_option').html("Received");
                                    $('#order_status_id').val(2);
                                }
                            else if(data.order_status==3){
                                    $('#order_status_option').html("Preparing");
                                    $('#order_status_id').val(3);
                                }
                            else if(data.order_status==4){
                                    $('#order_status_option').html("Ready");
                                    $('#order_status_id').val(4);
                                }
                            else if(data.order_status==5){
                                    $('#order_status_option').html("Preparing");
                                    $('#order_status_id').val(5);
                                }
                            else{
                                    $('#order_status_option').html("Ordered");
                                    $('#order_status_id').val(1);
                                }

                            //for small device

                        });
                    }
                }
            });
            $('#order_modal').modal();


            /*
            alert(order_id)
            $.ajax({
                url: project_url+"controller/orderController.php",
                type:'POST',
                async:false,
                dataType: "json",
                data:{
                    q: "set_order_notice_details",
                    order_id:order_id
                },
                success: function(data){
                    //alert(data)
                    //alert('Noticed Successfully');
                }
            });
            //alert('edit2')

            $('#delivery_address').hide();
            //$('#delivery_outlet').hide();
            $('#order_id').val(order_id);



            $('#orderTable > tbody').html("");
            //alert('edit3')


            $.ajax({
                url: project_url+"controller/orderController.php",
                dataType: "json",
                type: "post",
                async:false,
                data: {
                    q: "get_order_details",
                    order_id: order_id
                },
                success: function(data){
                    alert(data)
                    if(!jQuery.isEmptyObject(data.records)){
                        $.each(data.records, function(i,data){

                            total_product_amount 	= data.total_order_amt;
                            delivery_charge_amount 	= data.delivery_charge;
                            tax_amount 				= data.tax_amount;
                            coupon_amount 			= data.discount_amount;
                            coupon_name 			= data.cupon_id;
                            cu_amount 				= data.cu_amount;
                            total_paid_amount 		= data.total_paid_amount;
                            grand_total_amount 		= data.total_paid_amount;

                            if(coupon_name != ""){
                                if(data.cu_type ==1)		$('#coupon_name').val(coupon_name+">>"+cu_amount);
                                else if(data.cu_type ==2)	$('#coupon_name').val(coupon_name+">>"+cu_amount+"%");
                                $('#coupon_type').val(data.cu_type);
                                $('#coupon_amount').val(cu_amount);
                            }

                            if(data.order_status==1){
                                $('#order_status_option').html("Ordered");
                                $('#order_status_id').val(1);
                                $('#order_ready').show();
                                $('#order_picked').show();
                            }
                            if(data.order_status==2){
                                $('#order_status_option').html("Ready");
                                $('#order_status_id').val(2);
                                $('#order_ready').hide();
                            }
                            else if(data.order_status==3){
                                $('#order_status_option').html("Picked");
                                $('#order_status_id').val(3);
                                $('#order_ready').hide();
                                $('#order_picked').hide();
                                $('#save').attr('disabled','disabled');
                                $('#show_invoice').show();
                            }

                            $('#customer_name').val(data.customer_name);
                            $('#customer_id').val(data.customer_id);
                            $('#customer_id').val(data.customer_id);
                            $('#delivery_date').val(data.delivery_date);
                            $('#delivery_option').val(data.delivery_type);
                            $('#outlet_option').val(data.outlet_id);
                            var option_html = '';
                            //alert('edit4')

                            if(data.delivery_type == 1){
                                $('#delivery_outlet').show();
                                $('#delivery_address').hide();
                                $('#delivery_option_list').after().html('');
                                $('#delivery_option_list_div').hide();

                            }
                            else{
                                $('#delivery_outlet').hide();
                                $('#delivery_address').hide();
                            }

                            $('#remarks').val(data.remarks);
                            if(data.payment_method_id == 0 || data.payment_method_id == null){
                                $('#payment_option').val(0);
                            }
                            else{
                                $('#payment_option').val(data.payment_method_id);
                            }


                            $('#payment_referance_no').val(data.payment_reference_no);
                            $('#payment_status').val(data.payment_status);
                            $('#total_paid_amount').val(data.total_paid_amount);

                            alert(data.order_info)
                            order_infos	 = data.order_info;
                            var order_arr = order_infos.split(',');

                            $.each(order_arr, function(i,orderInfo){
                                var order_info_arr = orderInfo.split('#');
                                var total = ((parseFloat(order_info_arr[6])*parseFloat(order_info_arr[7])));
                                $('#orderTable > tbody').append("<tr><td><input type='text' readonly name='product_name[]' class='form-control col-lg-12 product_name' value='"+order_info_arr[2]+"'/><input type='hidden' name='item_id[]' class='item_id' value='"+order_info_arr[3]+"'/></td><td><input type='text' name='rate[]' readonly value='"+order_info_arr[4]+"' required class='form-control col-lg-12 text-right rate'/></td><td><input type='text' name='quantity[]' readonly class='form-control col-lg-12 quantity' value='"+order_info_arr[5]+"' /></td><td><input type='text' name='total[]' value='"+order_info_arr[5]*order_info_arr[4]+"' required class='form-control col-lg-12 text-right total' readonly='readonly'/></td><td><span class='input-group-btn'><button type='button' class='btn btn-danger btn-xs remove_row'><span class='glyphicon glyphicon-minus'></span></button></span></td></tr>");
                                //order_total += parseFloat(total);
                            });

                            var total_order_product_amount = 0;
                            $("#orderTable>tbody>tr").each(function(){
                                var total = $(this).find('.total').val();
                                total_order_product_amount += parseFloat(total);
                            })
                            total_product_amount = total_order_product_amount;
                            $('.remove_row').click(function(){
                                $(this).parent().parent().parent().remove();

                                var total_order_product_amount = 0;
                                $("#orderTable>tbody>tr").each(function(){
                                    var total = $(this).find('.total').val();
                                    total_order_product_amount += parseFloat(total);
                                })

                                total_product_amount = total_order_product_amount;


                            });


                        });
                    }

                    $('#save_order').html('Update');

                    // to open submit post section
                    if($.trim($('#toggle_form i').attr("class"))=="fa fa-chevron-down")
                        $( "#toggle_form" ).trigger( "click" );
                }
            });

            */
        }

        $('#show_invoice').click(function(){
            order_id = $('#order_id').val();
            view_order(order_id);
        });

        delete_order = function delete_order(order_id){
            if (confirm("Do you want to delete the record? ") == true) {
                $.ajax({
                    url: project_url+"controller/orderController.php",
                    type:'POST',
                    async:false,
                    data: "q=delete_order&order_id="+order_id,
                    success: function(data){
                        if($.trim(data) == 1){
                            success_or_error_msg('#page_notification_div',"success","Deleted Successfully");
                            load_order("");
                            clear_form();
                        }
                        else{
                            success_or_error_msg('#page_notification_div',"danger","Not Deleted...");
                        }
                    }
                });
            }
        }


    });


</script>
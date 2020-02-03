<?php
session_start();

if(!isset($_SESSION['customer_id']) && $_SESSION['customer_id']!="" && $_SESSION['latest_order_id']!=""){ ob_start(); header("Location:error.php"); exit();}
//var_dump($customer_info);

//var_dump( $_SESSION);die;
?>
<!-- Start Main -->

<section class="home-icon shop-cart bg-skeen wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
    <div class="icon-default icon-skeen">
                <img src="images/scroll-arrow.png" alt="">
            </div>
    <div class="container">
        <div class="checkout-wrap">
            <ul class="checkout-bar">
                <li class="done-proceed">Shopping Cart</li>
                <li class="done-proceed">Checkout</li>
                <li class="active done-proceed">Order Complete</li>
            </ul>
        </div>

            <div class="order-complete-box">
                <img src="images/complete-sign.png" alt="">
                <p >Thank you for ordering our food. You will receive a confirmation email shortly. your order referenced id #<b><?php echo $_SESSION['Last_invoice_no']; ?></b>
                    <br> Now check a Food Tracker progress with your order.</p>
                <a href="account.php" class="btn-medium btn-primary-gold btn-large">Go To Food Tracker</a>
                <br /><br />
                <button type="button" class="btn btn-warning"  onclick="view_order()" id=""><i class="fa fa-lg fa-print"> &nbsp; Print order #</i></button>
            </div>

    </div>
</section>

<script>
    //alert('sdf')
    order_id = "<?php echo $_SESSION['Last_invoice_no']; ?>";

    var view_order = function view_order(){
        //alert('ok')
        $('#ord_detail_vw>table>tbody').html('');
        $.ajax({
            url:"./includes/controller/ecommerceController.php",
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
                        order_tr += '<tr><td colspan="3" align="right" ><b>Total Amount</b></td><td align="right"><b>'+currency_symbol+''+total_paid+'</b></td></tr>';
                        $('#ord_detail_vw>table>tbody').append(order_tr);



                        //for small device

                    });
                }
            }
        });
        $('#order_modal').modal();
    }

</script>






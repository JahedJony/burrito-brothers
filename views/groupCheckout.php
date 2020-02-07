<?php
session_start();
include("../includes/dbConnect.php");
include("../includes/dbClass.php");
$dbClass = new dbClass;

if(isset($_SESSION['customer_id']) && $_SESSION['customer_id']!=""){
    $is_logged_in_customer = 1; // here will be the customer id that will come from session when the customer will login
    $customer_info = $dbClass->getSingleRow("select * from customer_infos where customer_id=".$_SESSION['customer_id']);
    $customer_id = $_SESSION['customer_id'];
}
else {
    ?>
    <script>
        window.location.href = "index.php";
    </script>
    <?php
}
?>

<section class="home-icon shop-cart bg-skeen" style="background-color: rgba(244,242,237,1)">
    <div class="icon-default icon-skeen">
        <img src="./images/scroll-arrow.png" alt="">
    </div>
    <div class="container">
          <div class="checkout-wrap wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
               <ul class="checkout-bar">
                        <li class="done-proceed"><a href="index.php?page=cart">Shopping Cart</a></li>
                        <li class="active"><a href="index.php?page=checkout">Checkout</a></li>
                        <li>Order Complete</li>
                    </ul>
          </div>
          <div class="row">
               <div class="col-md-12 col-sm-12 col-xs-12 wow fadeInDown  tab-content" data-wow-duration="1000ms" data-wow-delay="300ms" >
                   <ul class="nav nav-tabs" role="tablist" style="margin-right: 43%; margin-top: 20px; font-size: 20px; border-radius: 15px 15px 0px 0px">
                            <li role="presentation" onclick="take_out()" id="take_out_menu" style="background-color: #EAEAEA">
                                <a href="#reviews" aria-controls="pickUp" role="tab" data-toggle="tab">Take Out</a>
                            </li>
                            <li role="presentation" onclick="payments()" id="payments_menu" style="background-color: #EAEAEA">
                                <a href="#reviews" aria-controls="payments" role="tab" data-toggle="tab">Payments</a>
                            </li>
                        </ul>
                   <div class="col-md-7 col-sm-7 col-xs-12" style="background-color: white; border-radius: 0px 12px 12px 12px; padding-top: 25px; padding-bottom: 20px">
                            <div role="tabpanel" class="tab-pane" id="description">
                            <form method="post" name="checkout-form" id="checkout-form">

                            <div id="take_out" style="display: none">

                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <h5>Coupon and Tips</h5>
                                </div>
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <label style=" font-size: 18px"> Do you have any cupon code </label>
                                    <input type="text" name="coupon" id="coupon" placeholder="Enter The Coupon Code" class="input-fields" style="border-radius: 10px">
                                    <div id="coupon_error" class="text-center" style="display:none"></div>

                                </div>

                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <label style=" font-size: 18px"> Want to give some Tips </label>
                                    <input type="text" name="tips" id="tips" placeholder="Tips amount" class="input-fields" style="border-radius: 10px">
                                    <div id="tips_error" class="text-center" style="display:none"></div>

                                </div>


                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <h5>Takeout Details</h5>
                                </div>
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <br />
                                    <label style=" font-size: 20px"> Confirm TakeOut Location </label>
                                    <div class="payment-mode">
                                          <input type="checkbox" name="take_out_location" id="take_out_location"><label id="take_out_location_" style="padding-left: 10px; padding-top: 10px; font-size: 18px"></label>
                                    </div>
                                </div>
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <br />
                                    <label style=" font-size: 20px"> Please select date and time </label>
                                    <input type="text" name="pickup_date_time" id="pickup_date_time" placeholder="Date and Time" class="input-fields date-picker" required value="2020-01-07 12:00:00">
                                </div>

                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <label style=" font-size: 20px"> Order Notes </label>
                                    <textarea placeholder="Order Notes" name="secial_notes" id="secial_notes"></textarea>
                                </div>

                                <div class="checkout-button">
                                    <input class="button-default btn-large btn-primary-gold" type="button" value="PROCEED TO PAYMENT" onclick="payments()">
                                </div>

                            </div>
                            <div id="payments" style="display: none">
                                 <h4>Payment Methods</h4>
                                <input type="hidden"  id="grand_total">
                                <div class="payment_body" id="payment_body"></div>
                                <div id="payment_alert" class="text-center" style="display:none"></div>

                                <div class="checkout-terms">
                                    <input type="checkbox" name="tarm_condition" id="tarm_condition"><label style="padding-left: 10px; padding-top: 10px; font-size: 18px">I’ve read and accept the terms &amp; conditions *</label>
                                </div>
                                <input type="hidden" name="total_order_amt" id="total_order_amt">
                                 <input type="hidden" name="tax_amount" id="tax_amount">
                                 <input type="hidden" name="total_paid_amount" id="total_paid_amount">


                                <div class="checkout-button">
                                    <div id="logn_reg_error" class="text-center" style="display:none"></div>
                                    <input type="submit" name="submit" id="checkout_submit" class="button-default btn-large btn-primary-gold" value="PLACE ORDER">

                                </div>
                            </div>
                            </form>

                        </div>
                        </div>
                   <div class="col-md-5 col-sm-5 col-xs-12 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                            <div class="shop-checkout-right">
                                <div class="shop-checkout-box">
                                    <h5>YOUR ORDER</h5>
                                    <div class="shop-checkout-title">
                                        <h6>GROUP MEMBERS <span>ORDER</span></h6>
                                    </div>
                                    <div class="shop-checkout-row" id="cart_summary">

                                    </div>
                                    <div class="checkout-total">
                                        <h6>CART SUBTOTAL <small id="cart_total_"></small></h6>
                                    </div>
                                    <div class="checkout-total">
                                        <h6>DISCOUNT <small id="discount_"></small></h6>
                                    </div>
                                    <div class="checkout-total">
                                        <h6>TAX <small id="tax_"></small></h6>

                                    </div>
                                    <div class="checkout-total">
                                        <h6>TIPS <small id="tips_"></small></h6>
                                    </div>
                                    <div class="checkout-total">
                                        <h6>ORDER TOTAL <small class="price-big" id="total_amount_"></small></h6>
                                    </div>
                                </div>
                            </div>
                        </div>
               </div>
          </div>
    </div>
</section>

<script>
var group_order_id = location.search.split('&')[1].split('=')[1];
var customer_id = <?php echo $customer_id; ?>

var loyalty_points=0;
var loyalty_point_value=0;
var loyalty_reserve_value=0;
var total = 0;

$('#tips').on('change',function () {
alert('sdf')
    var tips = $('#tips').val();

        $.ajax({
            url: "./includes/controller/groupController.php",
            type:'POST',
            async:false,
            data: {
                q:'add_tips',
                tips:tips,
                group_order_id: group_order_id
            },
            success: function(data){
                if(data==1){
                    success_or_error_msg('#tips_error','success',"Thanks for the tips. ","#coupon");


                }else if(data==2){
                    success_or_error_msg('#tips_error','danger',"Tips is not added. ","#coupon");

                }
                //alert(data)

                order_summary()
                //location.reload();
            }
        });


    //$('#tips_').html(currency_symbol+''+$('#tips').val())

})

$('#coupon').on('change',function () {
    var coupon_code = $('#coupon').val();
    if(coupon_code !=""){
        $.ajax({
            url: "./includes/controller/groupController.php",
            type:'POST',
            async:false,
            data: {
                q:'apply_coupon',
                coupon_code:coupon_code,
                group_order_id: group_order_id
            },
            success: function(data){
                if(data==1){
                    success_or_error_msg('#coupon_error','success',"Coupon Code added. ","#coupon");


                }else if(data==2){
                    success_or_error_msg('#coupon_error','danger',"Coupon Code is not valid. ","#coupon");

                }
                //alert(data)

                order_summary()
                //location.reload();
            }
        });
    }
})


load_customer_profile = function load_customer_profile(id){
	$.ajax({
		url:"./includes/controller/ecommerceController.php",
		dataType: "json",
		type: "post",
		async:false,
		data: {
			q: "get_customer_details",
			customer_id: customer_id,
		},
		success: function(data){
			if(!jQuery.isEmptyObject(data.records)){
				$.each(data.records, function(i,data){
					loyalty_points = data.loyalty_points;
				});

			}
			//alert(loyalty_points)
		}
	});
}
display_div = function display_div(){
	$("#take_out").css("display", "none");
	$("#payments").css("display", "none");
	document.getElementById("take_out_menu").classList.remove('active');
	document.getElementById("payments_menu").classList.remove('active');
}

take_out = function take_out(){
    display_div()
    document.getElementById("take_out_menu").classList.add('active');
    $("#take_out").css("display", "block");
}

take_out()

payments = function payments(){
    display_div()
    document.getElementById("payments_menu").classList.add('active');
    $("#payments").css("display", "block");

    if(loyalty_points/loyalty_point_value<parseFloat($('#total_amount_').html().split('$')[1])){
        $('#loyalty_redio').attr('disabled',true);
    }
}

general_settings = function general_settings(){
    $.ajax({
        url:"./includes/controller/ecommerceController.php",
        dataType: "json",
        type: "post",
        async:false,
        data: {
            q: "get_settings_details",
        },
        success: function(data){
            html=''
            if(!jQuery.isEmptyObject(data.records)){
                $.each(data.records, function(i,data){
                    loyalty_point_value=data.redeem_value;
                    loyalty_reserve_value=data.point_reserve_value;
                    $('#take_out_location_').html(data.store_address);
                    if(data.cash_payment==1){
                        html+='<div class="payment-mode">\n' +
                            '       <input type="radio" name="payment_method" value="1" onclick="payment_check()"><label style="padding-left: 10px; padding-top: 10px; font-size: 18px">Cash on Delivery</label>\n' +
                            '  </div>'
                    }
                    if(data.loyelty_payment==1 ){
                        html+='<div class="payment-mode">\n' +
                            '      <input type="radio" name="payment_method" id="loyalty_redio" value="2"  onclick="payment_check()"><label style="padding-left: 10px; padding-top: 10px; font-size: 18px">Use Loyalty Point <span id="loyalty_spend"></span></label>\n' +
                            '  </div>'
                    }
                    if(data.card_payment==1){
                        html+='<div class="payment-mode">\n' +                      
                            '      <input type="radio" name="payment_method" value="3"  onclick="payment_check()"><label style="padding-left: 10px; padding-top: 10px; font-size: 18px">Credit Card</label>'
                        if(data.payment_card_visa==1){
                            html+='<img src="./images/payments/visa.png" style="height: 30px">'
                        }
                        if(data.payment_card_master==1){
                            html+='<img src="./images/payments/mastercard.png" style="height: 30px">'
                        }
                        if(data.payment_card_amex==1){
                            html+='<img src="./images/payments/amex.png" style="height: 30px">'
                        }
                        if(data.payment_card_discover==1){
                            html+='<img src="./images/payments/discover.png" style="height: 30px">'
                        }
                        html+='</div>'
                    }
                });

            }
            $('#payment_body').html(html);

        }
    });

}


order_summary = function order_summary(){
    //alert('sdf')
    $.ajax({
        url: "./includes/controller/groupController.php",
        dataType: "json",
        type: "post",
        async:false,
        data: {
            q: "viewCartSummery",
            group_order_id: group_order_id
        },
        success: function(data) {
            //alert(data)
            //return false;
            console.log(data)
            //alert(data);
            if(!jQuery.isEmptyObject(data.records)){
                var html = '';
                var total = 0;
                var sub_total = 0;
                var count =0
                $.each(data.records, function(i,datas){
                    sub_total += parseFloat(datas.total_order_amt);
                    html+='<p class="text-capitalize"><span>'+datas.name+'</span><small>'+ currency_symbol+''+datas.total_order_amt+'</small></p>\n'
                });
                $('#cart_summary').html(html);
                //alert(typeof data['order_details']['tips']))
                total= parseFloat(data['order_details']['total_order_amt'])+ parseFloat(data['order_details']['tax_amount'])+parseInt(data['order_details']['tips'])-parseFloat(data['order_details']['discount_amount'])
                $('#cart_total_').html(currency_symbol+''+data['order_details']['total_order_amt']);
                $('#discount_').html(currency_symbol+''+data['order_details']['discount_amount']);
                $('#tax_').html(currency_symbol+''+data['order_details']['tax_amount']);
                $('#tips_').html(currency_symbol+''+data['order_details']['tips']);
                $('#total_amount_').html(currency_symbol+''+total.toFixed(2));


                $('#total_order_amt').val(data['order_details']['total_order_amt'])
                $('#tax_amount').val(data['order_details']['tax_amount'])
                $('#total_paid_amount').val(data['order_details']['total_order_amt'])

                $('#loyalty_spend').html("("+Math.ceil(data['discounted_price']/loyalty_point_value)+" point will spend)")



            }


        }
    });

}

order_summary()
load_customer_profile()
general_settings()

payment_check = function payment_check(){
    //loyalty point deduction message will be here
    //alert(loyalty_point_value)
    //alert($('input[name=payment_method]:checked', '#checkout-form').val())
}


$('#checkout_submit').click(function(event){

    event.preventDefault();
    //$('#grand_total').val($('#total_amount_').html());
      //  alert($('#grand_total').val())
    var loyalty_value =Math.floor( parseFloat($('#total_amount_').html().split('$')[1])/loyalty_reserve_value);
    var loyalty_deduct = 0;
    if($('input[name=payment_method]:checked', '#checkout-form').val()==2){
        loyalty_deduct = Math.ceil(parseFloat($('#total_amount_').html().split('$')[1])*loyalty_point_value);
    }

    delevery_type = $("[name='delevery_type']:checked").val();
    payment_type  = $("[name='payment_type']:checked").val();
    var formData = new FormData($('#checkout-form')[0]);
    formData.append("q","checkout");
    formData.append("loyalty_point",loyalty_value);
    formData.append("loyalty_deduct",loyalty_deduct);
    formData.append("grand_total",$('#total_amount_').html());
    formData.append("total_paid_amount",parseFloat($('#total_amount_').html().split('$')[1]));
    formData.append("group_order_id",group_order_id);


    if($('input[name=payment_method]:checked', '#checkout-form').val()){
        formData.append("payment_method",$('input[name=payment_method]:checked', '#checkout-form').val());

    }


    //console.log(formData)

    if($.trim($('#islogged_in').val()) == "0"){
        success_or_error_msg('#logn_reg_error','danger',"You must have to login or register if you are new customer. ","#forget_email");
    }
    else if(!$('input[name=take_out_location]:checked', '#checkout-form').val()){
        success_or_error_msg('#logn_reg_error','danger',"You must confirm the takeout location. ","#pickup_date_time");
    }
    else if($.trim($('#pickup_date_time').val()) == ""){
        success_or_error_msg('#logn_reg_error','danger',"You must enter the delivery/pickup date time. ","#pickup_date_time");
    }
    else if( delevery_type== 2 && $('#delivery_address').val() == ""){
        success_or_error_msg('#logn_reg_error','danger',"You must enter the delivery address. ","#delivery_address");
    }
    else if(!$('input[name=payment_method]:checked', '#checkout-form').val()){
        success_or_error_msg('#logn_reg_error','danger',"You must select a payment method. ","#reference_no");
    }
    else if(!$('input[name=tarm_condition]:checked', '#checkout-form').val()){
        success_or_error_msg('#logn_reg_error','danger',"Please confirm the tarms and conditions ","#reference_no");
    }
    else{
        $.ajax({
            url: "includes/controller/groupController.php",
            type:'POST',
            data:formData,
            async:false,
            cache:false,
            contentType:false,processData:false,
            success: function(data){
                //alert(data)
                if(data==0){
                    success_or_error_msg('#logn_reg_error',"danger","Order Faild. please check your information properly","#checkout_submit" );
                }
                else{
                    //alert('done')
                    showCart()
                    $("#content").load("index.php?page=checkout_confirm",{'invoice':data});

                    //window.location = "completed.php?complete=success&order_id="+$.trim(data);
                }
            }
        });
    }
})



</script>








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
else $is_logged_in_customer = "";


//var_dump($customer_info)

$order_id = '';
if(isset($_GET['order_id']) && $_GET['order_id']!="") $order_id =  $_GET['order_id'];

//var_dump($customer_info);
if(!isset($_SESSION['cart']) || !count($_SESSION['cart'])>0) {
    echo'<script> window.location="index.php?page=categories"; </script> ';
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
                            <li role="presentation" onclick="user_details()" id="userDetails" style="background-color: #EAEAEA">
                                <a href="#description" aria-controls="account" role="tab" data-toggle="tab">Your Details</a>
                            </li>
                            <li role="presentation" onclick="take_out()" id="take_out_menu" style="background-color: #EAEAEA">
                                <a href="#reviews" aria-controls="pickUp" role="tab" data-toggle="tab">Take Out</a>
                            </li>
                            <li role="presentation" onclick="payments()" id="payments_menu" style="background-color: #EAEAEA">
                                <a href="#reviews" aria-controls="payments" role="tab" data-toggle="tab">Payments</a>
                            </li>
                        </ul>
                        <div class="col-md-7 col-sm-7 col-xs-12" style="background-color: white; border-radius: 0px 12px 12px 12px; padding-top: 25px; padding-bottom: 20px">
                        <div role="tabpanel" class="tab-pane" id="description">

                            <div id="login_div" style="padding-bottom: 20px">
                                <div id="done_login">
                                    <div class="title text-center">
                                        <h3 class="text-coffee">Login</h3>
                                    </div>
                                    <form class="login-form" method="post" name="login_form" id="login_form">
                                        <div class="row">
                                            <div >
                                                <div class="col-md-12 col-sm-12 col-xs-12">
                                                    <input type="text" name="username" id="username_" placeholder="Username or email address" class="input-fields" required >
                                                </div>
                                                <div class="col-md-12 col-sm-12 col-xs-12">
                                                    <input type="password" name="password" id="password_" placeholder="********" class="input-fields" required >
                                                </div>
                                                <div class="col-md-12 col-sm-12 col-xs-12">
                                                    <div class="row">
                                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                                            <label>
                                                                <input type="checkbox" name="chkbox">Remember me</label>
                                                        </div>
                                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                                            <a  onclick="forgetPass()" class="pull-right" id="send_password_"><i class="fa fa-user" aria-hidden="true"></i> Lost your password?</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <div id="loginerror_" class="text-center" style="display:none"></div>
                                                <input type="submit" name="submit" id="login" value="LOGIN" class="button-default button-default-submit">
                                            </div>
                                        </div>
                                    </form>
                                    <div class="divider-login">
                                        <hr>
                                        <span>Or</span>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12 col-sm-12 col-xs-12" >
                                            <a onclick="registration()" class="facebook-btn btn-change button-default " id="log_reg_"><i class="fa fa-user" aria-hidden="true"></i> Dont have an account? Register yourself</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12 col-sm-12 col-xs-12 center hide" 	id="done_login_msg" >
                                    <div class="alert alert-success alert-custom">
                                        <p>You have logged in successfully</p>
                                    </div>
                                    <a href="index.php?page=account" id="" class="facebook-btn btn-change button-default"><i class="fa fa-user"></i>Browse your account?</a>
                                </div>
                            </div>
                            <div id="register_div" style="display: none">
                                <div class="title text-center">
                                    <h3 class="text-coffee">Register</h3>
                                </div>
                                <div class="done_registration">
                                    <form class="register-form" method="post" name="register-form" id="register_form">
                                        <div class="row">
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" name="cust_name" id="cust_name_" placeholder="Name" class="input-fields" required>
                                            </div>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" name="cust_username" id="cust_username_" placeholder="User Name" class="input-fields" required>
                                                <div id="username_error" class="text-center" style="display:none"></div>
                                            </div>

                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="email" name="cust_email" id="cust_email_" placeholder="Email address" class="input-fields" required>
                                                <div id="email_error" class="text-center" style="display:none"></div>
                                            </div>

                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="password" name="cust_password" id="cust_password_" placeholder="Password" class="input-fields" required>
                                            </div>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="password" name="cust_conf_password" id="cust_conf_password_"  placeholder="Confirm Password" class="input-fields" required>
                                            </div>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="number" name="cust_contact" id="cust_contact_" pattern="[0-9]{11}" placeholder="Contact No" class="input-fields" required>
                                            </div>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="text" name="cust_address" id="cust_address_" placeholder="Address" class="input-fields" >
                                            </div>
                                            <div class="col-md-12 col-sm-12 col-xs-12">

                                                <div id="registration_submit_error_" class="text-center" style="display:none"></div>
                                                <input type="submit" name="submit" id="register_submit_" class="button-default button-default-submit" value="Register now">
                                            </div>
                                        </div>
                                    </form>
                                    <p>By clicking on <b>Register Now</b> button you are accepting the <a href="terms.php">Terms &amp; Conditions</a></p>
                                </div>
                                <div class="col-md-12 col-sm-12 col-xs-12 done_registration_msg center hide" >
                                    <div class="alert alert-success">
                                        <p>Your registration is completed. Please login with provided credentials</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-sm-12 col-xs-12" >
                                        <a onclick="login()" class="facebook-btn btn-change button-default " id="log_reg_"><i class="fa fa-user" aria-hidden="true"></i> Login Here</a>
                                    </div>
                                </div>

                            </div>
                            <div id="forget_pass_div" style="display: none">
                                <div class="title text-center">
                                    <h3 class="text-coffee">Enter email address</h3>
                                </div>
                                <form class="register-form" method="post" name="forget-pass-form" id="forget_pass_form">
                                    <div class="row">
                                        <div class="sent_password">
                                            <div class="col-md-12 col-sm-12 col-xs-12 ">
                                                <input type="email" name="forget_email" id="forget_email_" placeholder="Enter email address" class="input-fields">
                                            </div>
                                            <div class="col-md-12 col-sm-12 col-xs-12 ">
                                                <div id="foget_pass_submit_error_" class="text-center" style="display:none"></div>
                                                <input type="submit" name="submit" id="foget_pass_submit_"  class="button-default button-default-submit" value="Send Password">
                                            </div>
                                        </div>
                                        <div class="col-md-12 col-sm-12 col-xs-12 sent_password_msg center hide" >
                                            <div class="alert alert-success">
                                                <p>A new password has been sent to your provided email address. please check and login</p>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <div class="row">
                                    <div class="col-md-12 col-sm-12 col-xs-12" >
                                        <a onclick="login()" class="facebook-btn btn-change button-default " id="log_reg_"><i class="fa fa-user" aria-hidden="true"></i> Login Here</a>
                                    </div>
                                </div>
                            </div>
                            <div id="profile" style="display: none" class="team-single-right" >
                                <h3 id='customer_name'></h3>
                                <h6 >Customer Id # <span id='customer_id' ></span> </h6>
                                <h6 >Customer Status : <span id='customer_status' ></span> </h6>
                                <p>Contact No: <a href="#" id="contact_no"></a>
                                    <br> E-mail: <a href="#" id="email"></a></p>
                                <p > Address: <span id="address"></span></p>
                                <p > Loyalty Points: <span id="loyalty_points"></span></p>

                                <div class="checkout-button">
                                    <button class="button-default btn-large btn-primary-gold" name="proceed_payments" id="proceed_payments" onclick="take_out()">PROCEED TO TAKE-OUT</button>
                                </div>

                            </div>

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
                                </div>

                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <h5>Takeout Details</h5>
                                </div>
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <br />
                                    <label style=" font-size: 20px"> Confirm TakeOut Location </label>
                                    <div class="payment-mode" style="margin: auto">
                                        <span><input type="checkbox" name="take_out_location" id="take_out_location" ><label id="take_out_location_" style="padding-left: 10px; padding-top: 10px; font-size: 18px"></label></span>
                                    </div>
                                </div>

                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <br />
                                    <label style=" font-size: 20px"> Please select date and time </label>
                                    <input type="text" name="pickup_date_time" id="pickup_date_time" placeholder="Date and Time" class="input-fields date-picker" required value="2020-01-07 12:00:00" style="border-radius: 10px">
                                </div>

                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <label style=" font-size: 20px"> Order Notes </label>
                                    <textarea placeholder="Order Notes" name="secial_notes" id="secial_notes" style="border-radius: 10px"></textarea>
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
                                        <h6>PRODUCT <span>TOTAL</span></h6>
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
                                    <div class="" style=" background-color: #add8e6 ;" >
                                        <label id="loyalty_point_earn" style="text-align: center; margin: auto; padding: 8px; margin-left: 10px"></label>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>
          </div>
    </div>
</section>

<script>
var loyalty_points=0;
var loyalty_point_value=0;
var loyalty_reserve_value=0;



$('.date-picker').daterangepicker({
	singleDatePicker: true,
	/*autoUpdateInput: false,*/
	calender_style: "picker_2",
	timePicker:true,
	locale: {
		format: 'YYYY-MM-DD h:mm',
		separator: " - ",
	}
});



$('#cust_username_').on('change', function () {
    //alert($('#cust_username_').val())
    var username= $('#cust_username_').val();
    //alert(username)

    $.ajax({
        url: "./includes/controller/customerController.php",
        dataType: "json",
        type: "post",
        async: false,
        data: {
            q: "duplicate_id_check",
            userInfo: username,
            type: "username",
        },
        success: function(data){
            if(data==0){
                $('#cust_username_').focus();
                $('#cust_username_').css("background-color","FFCCCB");
                success_or_error_msg('#username_error','danger',"Username is not available","#emp_name");
            }
            else {
                $('#cust_username_').css("background-color","");
            }
        }
    });


})

$('#cust_email_').on('change', function () {
    var userMail= $('#cust_email_').val();
    $.ajax({
        url: "./includes/controller/customerController.php",
            dataType: "json",
            type: "post",
            async: false,
            data: {
                q: "duplicate_id_check",
                userInfo: userMail,
                type: "usermail",
            },
        success: function(data){
            //alert(data)
            if(data==0){
                $('#cust_email_').focus();
                $('#cust_email_').css("background-color","#FFCCCB");
                success_or_error_msg('#email_error','danger',"Email is already registered","#emp_name");
            }
            else {
                $('#cust_email_').css("background-color","");
            }
        }
    });




})

$('#tips').on('change',function () {
    $('#tips_').html(currency_symbol+''+$('#tips').val())

    total_amt = parseFloat($('#total_order_amt').val())+parseFloat($('#tips').val())
    //alert(total_amt)
    $('#total_amount_').html(currency_symbol+''+total_amt.toFixed(2))

    $('#total_paid_amount').val(total_amt.toFixed(2))


    //set loyalty point expense for this order
    $('#loyalty_spend').html("("+Math.ceil(total_amt/loyalty_point_value)+" point will spend)")
    $('#loyalty_point_earn').html(Math.floor(total_amt/loyalty_reserve_value)+' points will earn')

})

$('#coupon').on('change',function () {
    //alert('sdf')
    var coupon_code = $('#coupon').val();
    if(coupon_code !=""){
        $.ajax({
            url: "./includes/controller/ecommerceController.php",
            type:'POST',
            async:false,
            data: "q=apply_cupon&cupon_code="+coupon_code,
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
					$('#customer_id').html(data.customer_id);
					$('#customer_name').html(data.full_name);
					$('#contact_no').html(data.contact_no);
					$('#email').html(data.email);
					$('#address').html(data.address);
					$('#customer_status').html(data.status_text);
					$('#loyalty_points').html(data.loyalty_points);
					loyalty_points = data.loyalty_points;
					if(data.photo == ""){
						$('#customer_img').attr("src",'admin/images/no_image.png');
					}else{
						$('#customer_img').attr("src","admin/"+data.photo);
					}
					$('#customer_img').attr("width", "70%","height","70%");
				});

			}
			//alert(loyalty_points)
		}
	});
}

display_div = function display_div(){
	$("#login_div").css("display", "none");
	$("#register_div").css("display", "none");
	$("#forget_pass_div").css("display", "none");
	$("#profile").css("display", "none");
	$("#take_out").css("display", "none");
	$("#payments").css("display", "none");
	document.getElementById("userDetails").classList.remove('active');
	document.getElementById("take_out_menu").classList.remove('active');
	document.getElementById("payments_menu").classList.remove('active');
}

user_details = function user_details(){
	if(customer_id && customer_id>0){
		//alert(customer_id)
		display_div()
		//document.getElementById("userDetails").classList.add('active');
		//$("#profile").css("display", "block");
	}
	else {
		display_div()
		login()
	}
}
login = function login() {
	display_div()
	document.getElementById("userDetails").classList.add('active');
	$("#login_div").css("display", "block");
}
registration = function registration() {
	display_div()
	document.getElementById("userDetails").classList.add('active');
	$("#register_div").css("display", "block");
}
forgetPass = function forgetPass() {
	display_div()
	document.getElementById("userDetails").classList.add('active');
	$("#forget_pass_div").css("display", "block");
}

take_out = function take_out(){
    load_customer_profile()
    display_div()
    document.getElementById("take_out_menu").classList.add('active');
    $("#take_out").css("display", "block");
}

payments = function payments(){
    display_div()
    document.getElementById("payments_menu").classList.add('active');
    $("#payments").css("display", "block");

    if(loyalty_points/loyalty_point_value<$('#total_paid_amount').val()){
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
            //alert($('#total_paid_amount').val())
            //alert(loyalty_points)
            //alert(loyalty_point_value)
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
general_settings()


order_summary = function order_summary(){
    $.ajax({
        url: "./includes/controller/ecommerceController.php",
        dataType: "json",
        type: "post",
        async:false,
        data: {
            q: "viewCartSummery"
        },
        success: function(data) {
            //alert(data);
            if(!jQuery.isEmptyObject(data.records)){
                var html = '';
                var total = 0;
                var sub_total = 0;
                var count =0
                $.each(data.records, function(i,datas){
                    //alert(datas.quantity)

                    sub_total += parseFloat(datas.discounted_rate)*(datas.quantity);

                    html+='<p><span class="text-capitalize">'+datas.item_name+'</span> x'+datas.quantity+' <small>'+ currency_symbol+''+datas.discounted_rate * datas.quantity+'</small></p>\n'
                });
                $('#cart_summary').html(html);
            }
            $.ajax({
                url: "./includes/controller/ecommerceController.php",
                dataType: "json",
                type: "post",
                async:false,
                data: {
                    q: "viewPriceSummery"
                },
                success: function(data) {
                    if(data){
                        //alert(loyalty_reserve_value)
                        //$('#items_price').html(data['total_price'])
                        $('#cart_total_').html(currency_symbol+''+data['total_price'].toFixed(2));
                        $('#discount_').html(currency_symbol+''+data['discount'].toFixed(2))
                        $('#tax_').html(currency_symbol+''+data['tax_amount'].toFixed(2))
                        $('#total_amount_').html(currency_symbol+''+data['discounted_price'].toFixed(2))
                        $('#loyalty_point_earn').html(Math.floor(data['discounted_price']/loyalty_reserve_value)+' points will earn')
                        $('#total_order_amt').val(data['total_price'])
                        $('#tax_amount').val(data['tax_amount'])
                        $('#total_paid_amount').val(data['discounted_price'])


                        //set loyalty point expense for this order
                        $('#loyalty_spend').html("("+Math.ceil(data['discounted_price']/loyalty_point_value)+" point will spend)")


                    }   
                }
            });


        }
    });

}

order_summary()
//load_customer_profile()

$('#login').click(function(event){
	event.preventDefault();
	var formData = new FormData($('#login_form')[0]);
	formData.append("q","login_customer");
	if($.trim($('#username_').val()) == ""){
		success_or_error_msg('#loginerror_','danger',"Please type user name","#emp_name");
	}
	if($.trim($('#password_').val()) == ""){
		success_or_error_msg('#loginerror_','danger',"Please type password","#password");
	}
	else{
		$.ajax({
			url: "./includes/controller/customerController.php",
			type:'POST',
			data:formData,
			async:false,
			cache:false,
			contentType:false,processData:false,
			success: function(data){
				//alert(data)
				if($.isNumeric(data)==true && data==3){
					success_or_error_msg('#loginerror_',"danger","Invalid username","#user_name" );
				}
				else if($.isNumeric(data)==true && data==2){
					success_or_error_msg('#loginerror_',"danger","Invalid password","#password" );
				}
				else if($.isNumeric(data)==true && data==1){

					$('.language-menu').html('<a href="index.php?page=account" class="current-lang" id="my_acc"><i class="fa fa-user" aria-hidden="true" ></i> My Account</a>');
					if($('#islogged_in').length > 0 ){
						$('#islogged_in').val(1);
						$('.logged_in_already').addClass('hide');
					}
					window.location.href = project_url+ "checkout.php";



				}
			}
		});
	}
})

$('#foget_pass_submit_').click(function(event){
    event.preventDefault();
        var formData = new FormData($('#forget_pass_form')[0]);
        formData.append("q","forget_password");
        if($.trim($('#forget_email_').val()) == ""){
            success_or_error_msg('#foget_pass_submit_error','danger',"Please enter email address","#forget_email");
        }
        else{
            $.ajax({
                url: "./includes/controller/customerController.php",
                type:'POST',
                data:formData,
                async:false,
                cache:false,
                contentType:false,processData:false,
                success: function(data){
                    //alert(data)
                    if($.isNumeric(data)==true && data==2){
                        success_or_error_msg('#foget_pass_submit_error_',"danger","Please provide a valid email address","#forget_email" );
                    }
                    else if($.isNumeric(data)==true && data==1){

                        $('.sent_password').addClass("hide");
                        $('.sent_password_msg').removeClass("hide");
                        setTimeout(function() { login() }, 3000);
                    }
                                        }
            });
        }
    })
	
// send mail if forget password
$('#register_submit_').click(function(event){
    event.preventDefault();
    var formData = new FormData($('#register_form')[0]);
    formData.append("q","registration");
    if($.trim($('#cust_name_').val()) == ""){
        success_or_error_msg('#registration_submit_error_','danger',"Please enter name","#cust_name");
    }
    else if($.trim($('#cust_username_').val()) == ""){
        success_or_error_msg('#registration_submit_error_','danger',"Please enter username","#cust_username");
    }
    else if($.trim($('#cust_email_').val()) == ""){
        success_or_error_msg('#registration_submit_error_','danger',"Please enter email address","#cust_email");
    }
    else if($.trim($('#cust_password_').val()) == ""){
        success_or_error_msg('#registration_submit_error_','danger',"Please enter pasword","#cust_password");
    }
    else if($.trim($('#cust_conf_password_').val()) == ""){
        success_or_error_msg('#registration_submit_error_','danger',"Please confirm password ","#cust_conf_password");
    }
    else if($.trim($('#cust_password_').val()) != $.trim($('#cust_conf_password_').val())){
        success_or_error_msg('#registration_submit_error_','danger',"Please enter same password","#cust_conf_password");
    }
    else if($.trim($('#cust_contact_').val()) == ""){
        success_or_error_msg('#registration_submit_error_','danger',"Please enter valid contact no","#cust_contact");
    }
    else{
        $.ajax({
            url: "./includes/controller/customerController.php",
            type:'POST',
            data:formData,
            async:false,
            cache:false,
            contentType:false,processData:false,
            success: function(data){
                alert(data)
                if($.isNumeric(data)==true && data==2){
                    success_or_error_msg('#registration_submit_error_',"danger","Username is already exist, please try with another one","#cust_username" );
                }
                else if($.isNumeric(data)==true && data==3){
                    success_or_error_msg('#registration_submit_error_',"danger","Email is already exist, please try with another one","#cust_email" );
                }
                else if($.isNumeric(data)==true && data==1){
                    $('.done_registration').addClass("hide");
                    $('.done_registration_msg').removeClass("hide");
                    window.location.href = project_url+ "index.php?page=checkout";
                }
                else{
                    success_or_error_msg('#registration_submit_error_',"danger","Registration is not completed. please check your information again.","#cust_email" );
                }
            }
        });
    }
})

payment_check = function payment_check(){
    //loyalty point deduction message will be here
    //alert(loyalty_point_value)
    //alert($('input[name=payment_method]:checked', '#checkout-form').val())
}
$('#checkout_submit').click(function(event) {

    event.preventDefault();
    //$('#grand_total').val($('#total_amount_').html());
      //  alert($('#grand_total').val())
    var loyalty_value = Math.floor( $('#total_paid_amount').val()/loyalty_reserve_value);
    var loyalty_deduct = 0;
    if($('input[name=payment_method]:checked', '#checkout-form').val()==2){
        loyalty_deduct = Math.ceil($('#total_paid_amount').val()*loyalty_point_value);
    }
    //alert(loyalty_value)

    delevery_type = $("[name='delevery_type']:checked").val();
    payment_type  = $("[name='payment_type']:checked").val();
    var formData = new FormData($('#checkout-form')[0]);
    formData.append("q","checkout");
    formData.append("loyalty_point",loyalty_value);
    formData.append("loyalty_deduct",loyalty_deduct);
    formData.append("grand_total",$('#total_amount_').html());

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
            url: "includes/controller/ecommerceController.php",
            type:'POST',
            data:formData,
            async:false,
            cache:false,
            contentType:false,processData:false,
            success: function(data){
                //console.log(data)
                if(data==0){
                    success_or_error_msg('#logn_reg_error',"danger","Order Faild. please check your information properly","#checkout_submit" );
                }
                else{
                    //alert('done')
                    showCart()
                    alert(data)
                    $("#content").load("views/checkout_confirm.php");

                    //window.location = "completed.php?complete=success&order_id="+$.trim(data);
                }
            }
        });
    }
})

    <?php
    if($is_logged_in_customer != ""){
    ?>
    var customer_id = "<?php echo $customer_id; ?>";
    var order_id = "<?php echo $order_id; ?>";
    //user_details()
    take_out();
    $('#userDetails').css("display", "none");
    //alert('pro')

    <?php
    }
    else{
    ?>
    //alert('login')
    display_div()
    login()
    //$("#login_div").css("display", "block");
    //alert('ok3')

    <?php
    }?>
</script>








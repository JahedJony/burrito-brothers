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
?>

<main>
    <div class="main-part">
        <!-- Start Breadcrumb Part -->

        <!-- End Breadcrumb Part -->
        <section class="home-icon shop-cart bg-skeen">
            <div class="icon-default icon-skeen">
                <img src="../images/scroll-arrow.png" alt="">
            </div>
            <div class="container">
                <div class="checkout-wrap wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                    <ul class="checkout-bar">
                        <li class="done-proceed">Shopping Cart</li>
                        <li class="active">Checkout</li>
                        <li>Order Complete</li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12 wow fadeInDown  tab-content" data-wow-duration="1000ms" data-wow-delay="300ms">
                        <ul class="nav nav-tabs" role="tablist" style="margin-right: 43%; margin-left: 1%; margin-top: 20px; font-size: 20px; border-radius: 15px 15px 0px 0px"">
                            <li role="presentation" class="active" id="userDetails" style="border-radius: 15px 15px 0px 0px">
                                <a href="#description" aria-controls="account" role="tab" data-toggle="tab">Your Details</a>
                            </li>
                            <li role="presentation" id="pickup_info" style="border-radius: 15px 15px 0px 0px">
                                <a href="#reviews" aria-controls="pickUp" role="tab" data-toggle="tab">Pick Up Information</a>
                            </li>
                            <li role="presentation" id="payments" style="border-radius: 15px 15px 0px 0px">
                                <a href="#reviews" aria-controls="payments" role="tab" data-toggle="tab">Payments</a>
                            </li>
                        </ul>
                        <div class="col-md-7 col-sm-7 col-xs-12" style="background-color: white; border-radius: 12px; padding-top: 25px">

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
                                        <div class="col-md-12 col-sm-12 col-xs-12">
                                            <a onclick="registration()" class="facebook-btn btn-change button-default " id="log_reg_"><i class="fa fa-user" aria-hidden="true"></i> Dont have an account? Register yourself</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12 col-sm-12 col-xs-12 center hide" 	id="done_login_msg" >
                                    <div class="alert alert-success alert-custom">
                                        <p>You have logged in successfully</p>
                                    </div>
                                    <a href="account.php" id="" class="facebook-btn btn-change button-default"><i class="fa fa-user"></i>Browse your account?</a>
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
                                            </div>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <input type="email" name="cust_email" id="cust_email_" placeholder="Email address" class="input-fields" required>
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
                                    <a href="javascript:void(0)" onclick="active_modal(1)" class="facebook-btn btn-change button-default " data-toggle="modal" data-target="#loginModal" id="do_login"><i class="fa fa-user" aria-hidden="true"></i> Login</a>
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
                            </div>
                            <div id="profile" style="display: none" class="team-single-right">
                                <h3 id='customer_name'></h3>
                                <h6 >Customer Id # <span id='customer_id' ></span> </h6>
                                <h6 >Customer Status : <span id='customer_status' ></span> </h6>
                                <p>Contact No: <a href="#" id="contact_no"></a>
                                    <br> E-mail: <a href="#" id="email"></a></p>
                                <p > Address: <span id="address"></span></p>
                            </div>
                        </div>
                        <div role="tabpanel" style="display: none" class="tab-pane active" id="reviews">
                                    <div class="title text-center">
                                        <h3 class="text-coffee">2 Comment</h3>
                                    </div>
                                    <div class="comment-blog">
                                        <div class="comment-inner-list">
                                            <div class="comment-img">
                                                <img src="../images/comment-img1.png" alt="">
                                            </div>
                                            <div class="comment-info">
                                                <h5>Anna Taylor</h5>
                                                <span class="comment-date">AUGUST 9, 2016 10:57 AM</span>
                                                <p>Aqua Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                                            </div>
                                        </div>
                                        <div class="comment-inner-list">
                                            <div class="comment-img">
                                                <img src="../images/comment-img1.png" alt="">
                                            </div>
                                            <div class="comment-info">
                                                <h5>Anna Taylor</h5>
                                                <span class="comment-date">AUGUST 9, 2016 10:57 AM</span>
                                                <p>Aqua Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                       </div>
                        <div class="col-md-5 col-sm-5 col-xs-12 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                            <div class="shop-checkout-right">
                                <div class="shop-checkout-box">
                                    <h5>YOUR ORDER</h5>
                                    <div class="shop-checkout-title">
                                        <h6>PRODUCT <span>TOTAL</span></h6>
                                    </div>
                                    <div class="shop-checkout-row">
                                        <p><span>Rocha Sleeve Sweater</span> x1 <small>$140.00</small></p>
                                        <p><span>Mauris Tincidunt</span> x6 <small>$140.00</small></p>
                                    </div>
                                    <div class="checkout-total">
                                        <h6>CART SUBTOTAL <small>$140.00</small></h6>
                                    </div>
                                    <div class="checkout-total">
                                        <h6>SHIPPING <small>Free Shipping</small></h6>
                                    </div>
                                    <div class="checkout-total">
                                        <h6>ORDER TOTAL <small class="price-big">$140.00</small></h6>
                                    </div>
                                </div>
                                <div class="shop-checkout-box">
                                    <h5>PAYMENT METHODS</h5>
                                    <label>
                                        <input type="radio" name="radio">Direct Bank Transfer</label>
                                    <p>Make your payment directly into our bank account. Please use your cleared in our account.</p>
                                    <div class="payment-mode">
                                        <label>
                                            <input type="radio" name="radio">Check Payments</label>
                                    </div>
                                    <div class="payment-mode">
                                        <label>
                                            <input type="radio" name="radio">Cash on Delivery</label>
                                    </div>
                                    <div class="payment-mode">
                                        <label>
                                            <input type="radio" name="radio"> PayPal</label> <a href="#"><img src="../images/paycart.png" alt=""></a><a href="#">What is PayPal?</a>
                                    </div>
                                    <div class="checkout-terms">
                                        <label>
                                            <input type="checkbox" name="checkbox">I’ve read and accept the terms &amp; conditions *</label>
                                    </div>
                                    <div class="checkout-button">
                                        <button class="button-default btn-large btn-primary-gold">PROCEED TO PAYMENT</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </section>
    </div>
</main>

<script>



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
                            if(data.photo == ""){
                                $('#customer_img').attr("src",'admin/images/no_image.png');
                            }else{
                                $('#customer_img').attr("src","admin/"+data.photo);
                            }
                            $('#customer_img').attr("width", "70%","height","70%");
                        });

                    }
                }
            });
    }
    display_div = function display_div(){
        $("#login_div").css("display", "none");
        $("#register_div").css("display", "none");
        $("#forget_pass_div").css("display", "none");
        $("#profile").css("display", "none");
    }
    login = function login() {
        display_div()
        $("#login_div").css("display", "block");
    }
    registration = function registration() {
        display_div()
        $("#register_div").css("display", "block");
    }
    forgetPass = function forgetPass() {
        display_div()
        $("#forget_pass_div").css("display", "block");
    }

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

                        $('.language-menu').html('<a href="account.php" class="current-lang" id="my_acc"><i class="fa fa-user" aria-hidden="true" ></i> My Account</a>');
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
                        success_or_error_msg('#registration_submit_error',"danger","Username is already exist, please try with another one","#cust_username" );
                    }
                    else if($.isNumeric(data)==true && data==3){
                        success_or_error_msg('#registration_submit_error',"danger","Email is already exist, please try with another one","#cust_email" );
                    }
                    else if($.isNumeric(data)==true && data==1){
                        $('.done_registration').addClass("hide");
                        $('.done_registration_msg').removeClass("hide");
                        window.location.href = project_url+ "checkout.php";
                    }
                    else{
                        success_or_error_msg('#registration_submit_error',"danger","Registration is not completed. please check your information again.","#cust_email" );
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
        display_div()
        $("#profile").css("display", "block");
        load_customer_profile();
    <?php
    }
    else{
        ?>
    display_div()
        $("#login_div").css("display", "block");
    //alert('ok3')

    <?php
    }?>
</script>








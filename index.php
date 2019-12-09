<?php
session_start();
include("includes/dbConnect.php");
include("includes/dbClass.php");
$dbClass = new dbClass;

if(isset($_SESSION['customer_id']) && $_SESSION['customer_id']) $is_logged_in_customer = 1; // here will be the customer id that will come from session when the customer will login
else $is_logged_in_customer = "";

//$is_logged_in_customer = "";

//email, mobile, address, fearure, title, $subtitle, $facebook, $twitter, $instagram, $googleplus,

$email_info   = $dbClass->getDescription('web_admin_email');
$mobile_info  = $dbClass->getDescription('store_contact');
$about_us     = $dbClass->getDescriptionWithHtml(28);
$address      = $dbClass->getDescription('store_address');
$website_url  = $dbClass->getDescription('website_url');
$logo         =$website_url."admin/".$dbClass->getDescription('company_logo');
//$feature      = $dbClass->getDescription(47);
//$special_menu = $dbClass->getDescription(48);
//$subtitle     = $dbClass->getDescription(49);
//$why_we_best  = $dbClass->getDescription(50);


$facebook  = $dbClass->getDescription('fb_url');
$twitter  = $dbClass->getDescription('tweeter_url');
$instagram  = $dbClass->getDescription('instagram_url');
$yelp  = $dbClass->getDescription('yelp_url');





$search_text = "";
if(isset($_GET['search'])) $search_text = "";

?>


<!DOCTYPE html>
<html lang="en">


<!-- Mirrored from laboom.sk-web-solutions.com/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 08 Sep 2018 06:19:23 GMT -->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Burrito Brothers</title>
    <link href="plugin/bootstrap/bootstrap.css" rel="stylesheet">
    <link href="plugin/bootstrap/datepicker.css" rel="stylesheet">
    <link href="plugin/font-awesome/font-awesome.css" rel="stylesheet">
    <link href="plugin/form-field/jquery.formstyler.css" rel="stylesheet">
    <link href="plugin/revolution-plugin/extralayers.css" rel="stylesheet">
    <link href="plugin/revolution-plugin/settings.css" rel="stylesheet">
    <link href="plugin/owl-carousel/owl.carousel.css" rel="stylesheet">
    <link href="plugin/owl-carousel/owl.theme.default.css" rel="stylesheet">
    <link href="plugin/slick-slider/slick-theme.css" rel="stylesheet">
    <link href="plugin/magnific/magnific-popup.css" rel="stylesheet">
    <link href="plugin/scroll-bar/jquery.mCustomScrollbar.css" rel="stylesheet">
    <link href="plugin/animation/animate.min.css" rel="stylesheet">
    <link href="css/theme.css" rel="stylesheet">
    <link href="css/responsive.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<!-- Page pre loader -->
<div id="pre-loader">
    <div class="loader-holder">
        <div class="frame">
            <img src="images/Preloader.gif" alt="Laboom" />
        </div>
    </div>
</div>
<div class="wrapper">
    <!-- Start Header -->
    <header>
        <div class="header-part header-reduce sticky">
            <div class="header-top">
                <div class="container">
                    <div class="header-top-inner">
                        <div class="header-top-left">
                            <a href="Tel:<?php echo $mobile_info; ?>" class="top-cell"><img src="images/fon.png" alt=""> <span><?php echo $mobile_info; ?></span></a>
                            <a href="mailto:<?php echo $email_info; ?>" class="top-email"><span><?php echo $email_info; ?></span></a>
                        </div>
                        <div class="header-top-right">
                            <div class="social-top">
                                <ul>
                                    <li><a href="<?php echo $facebook; ?>"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                                    <li><a href="<?php echo $twitter; ?>"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                                    <li><a href="<?php echo $instagram; ?>"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
                                    <li><a href="<?php echo $yelp; ?>"><i class="fa fa-yelp" style="color:white"></i></a></li>
                                    <li class="language-menu">
                                        <?php
                                        if($is_logged_in_customer != "")
                                            echo '<a href="account.php" class="current-lang" id="my_acc"><i class="fa fa-user" aria-hidden="true" ></i> My Account</a>';
                                        else
                                            echo '<a href="#" onclick="active_modal(1)" data-toggle="modal" data-target="#loginModal" class="current-lang" id="log_reg"><i class="fa fa-user" aria-hidden="true"></i> Login / Register</a>';
                                        ?>
                                    </li>
                                </ul>

                            </div>
                        </div>
                     </div>
                </div>
            </div>

            <div class="header-bottom">
                <div class="container">
                    <div class="header-info">
                        <div class="header-info-inner">
                            <div class="book-table header-collect book-md">
                                <a href="#" data-toggle="modal" data-target="#booktable"><img src="images/icon-table.png" alt="">Book a Table</a>
                            </div>
                            <div class="shop-cart header-collect">
                                <a href="#"><img src="images/icon-basket.png" alt="">2 items - $ 20.89</a>
                                <div class="cart-wrap">
                                    <div class="cart-blog">
                                        <div class="cart-item">
                                            <div class="cart-item-left">
                                                <img src="images/img59.png" alt="">
                                            </div>
                                            <div class="cart-item-right">
                                                <h6>Caramel Chesse Cake</h6>
                                                <span>$ 14.00</span>
                                            </div>
                                            <span class="delete-icon"></span>
                                        </div>
                                        <div class="cart-item">
                                            <div class="cart-item-left">
                                                <img src="images/img60.png" alt="">
                                            </div>
                                            <div class="cart-item-right">
                                                <h6>Caramel Chesse Cake</h6>
                                                <span>$ 14.00</span>
                                            </div>
                                            <span class="delete-icon"></span>
                                        </div>
                                        <div class="subtotal">
                                            <div class="col-md-6 col-sm-6 col-xs-6">
                                                <h6>Subtotal :</h6>
                                            </div>
                                            <div class="col-md-6 col-sm-6 col-xs-6">
                                                <span>$ 140.00</span>
                                            </div>
                                        </div>
                                        <div class="cart-btn">
                                            <a href="#" class="btn-black view">VIEW ALL</a>
                                            <a href="#" class="btn-main checkout">CHECK OUT</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="search-part">
                                <a href="#"></a>
                                <div class="search-box">
                                    <input type="text" name="txt" placeholder="Search">
                                    <input type="submit" name="submit" value=" ">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="menu-icon">
                        <a href="#" class="hambarger">
                            <span class="bar-1"></span>
                            <span class="bar-2"></span>
                            <span class="bar-3"></span>
                        </a>
                    </div>
                    <div class="book-table header-collect book-sm">
                        <a href="#" data-toggle="modal" data-target="#booktable"><img src="images/icon-table.png" alt="">Book a Table</a>
                    </div>
                    <?php include("common_view/top_menu.php"); ?>

                    <div class="logo">
                        <a href="index.php"><img src="<?php echo $logo; ?>" alt=""></a>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- End Header -->
    <!-- Start Main -->

    <!-- Start login modal -->
    <div class="modal fade booktable" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="booktable">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <div id="login-div" class="">
                        <div id="done_login">
                            <div class="title text-center">
                                <h3 class="text-coffee">Login</h3>
                            </div>
                            <form class="login-form" method="post" name="login-form" id="login-form">
                                <div class="row">
                                    <div >
                                        <div class="col-md-12 col-sm-12 col-xs-12">
                                            <input type="text" name="username" id="username" placeholder="Username or email address" class="input-fields" required >
                                        </div>
                                        <div class="col-md-12 col-sm-12 col-xs-12">
                                            <input type="password" name="password" id="password" placeholder="********" class="input-fields" required >
                                        </div>
                                        <div class="col-md-12 col-sm-12 col-xs-12">
                                            <div class="row">
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <label>
                                                        <input type="checkbox" name="chkbox">Remember me</label>
                                                </div>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <a href="javascript:void(0)" onclick="active_modal(2)"class="pull-right" data-toggle="modal" data-target="#forget_passModal" id="send_password"><i class="fa fa-user" aria-hidden="true"></i> Lost your password?</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                        <div id="login_submit_error" class="text-center" style="display:none"></div>
                                        <input type="submit" name="submit" id="login_submit" value="LOGIN" class="button-default button-default-submit">
                                    </div>
                                </div>
                            </form>
                            <div class="divider-login">
                                <hr>
                                <span>Or</span>
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <a href="javascript:void(0)" onclick="active_modal(3)" class="facebook-btn btn-change button-default " id="log_reg"><i class="fa fa-user" aria-hidden="true"></i> Dont have an account? Register yourself</a>
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
                </div>
            </div>
        </div>
    </div>
    <!-- End login -->

    <!-- register modal -->
    <div class="modal fade booktable" id="registerModal" tabindex="-2" role="dialog" aria-labelledby="booktable">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <div id="register-div">
                        <div class="title text-center">
                            <h3 class="text-coffee">Register</h3>
                        </div>
                        <div class="done_registration">
                            <form class="register-form" method="post" name="register-form" id="register-form">
                                <div class="row">
                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                        <input type="text" name="cust_name" id="cust_name" placeholder="Name" class="input-fields" required>
                                    </div>
                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                        <input type="text" name="cust_username" id="cust_username" placeholder="User Name" class="input-fields" required>
                                    </div>
                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                        <input type="email" name="cust_email" id="cust_email" placeholder="Email address" class="input-fields" required>
                                    </div>
                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                        <input type="password" name="cust_password" id="cust_password" placeholder="Password" class="input-fields" required>
                                    </div>
                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                        <input type="password" name="cust_conf_password" id="cust_conf_password"  placeholder="Confirm Password" class="input-fields" required>
                                    </div>
                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                        <input type="number" name="cust_contact" id="cust_contact" pattern="[0-9]{11}" placeholder="Contact No" class="input-fields" required>
                                    </div>
                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                        <input type="text" name="cust_address" id="cust_address" placeholder="Address" class="input-fields" >
                                    </div>
                                    <div class="col-md-12 col-sm-12 col-xs-12">

                                        <div id="registration_submit_error" class="text-center" style="display:none"></div>
                                        <input type="submit" name="submit" id="register_submit" class="button-default button-default-submit" value="Register now">
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
                </div>
            </div>
        </div>
    </div>
    <!-- END REGISTER MODAL -->

    <!-- Start forgetr pass modal -->
    <div class="modal fade booktable" id="forget_passModal" tabindex="-1" role="dialog" aria-labelledby="booktable">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <div id="forget-pass-div">
                        <div class="title text-center">
                            <h3 class="text-coffee">Enter email address</h3>
                        </div>
                        <form class="register-form" method="post" name="forget-pass-form" id="forget-pass-form">
                            <div class="row">
                                <div class="sent_password">
                                    <div class="col-md-12 col-sm-12 col-xs-12 ">
                                        <input type="email" name="forget_email" id="forget_email" placeholder="Enter email address" class="input-fields">
                                    </div>
                                    <div class="col-md-12 col-sm-12 col-xs-12 ">
                                        <div id="foget_pass_submit_error" class="text-center" style="display:none"></div>
                                        <input type="submit" name="submit" id="foget_pass_submit"  class="button-default button-default-submit" value="Send Password">
                                    </div>
                                </div>
                                <div class="col-md-12 col-sm-12 col-xs-12 sent_password_msg center hide" >
                                    <div class="alert alert-success">
                                        <p>A new password has been sent to your provided email address. please check and login</p>
                                    </div>
                                    <a href="javascript:void(0)" onclick="active_modal(1)" class="facebook-btn btn-change button-default " data-toggle="modal" data-target="#loginModal" id="do_login"><i class="fa fa-user" aria-hidden="true"></i> Login</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End login -->








    <!-- End Header -->
    <!-- Start Main -->
    <div id="content" style="min-height: 600px">


</div>
    <!-- End Main -->
    <!-- Start Footer -->
    <footer>
        <div class="footer-part wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
            <div class="icon-default icon-dark">
                <img src="images/footer-logo.png" alt="">
            </div>
            <div class="container">
                <div class="footer-inner">
                    <div class="footer-info">
                        <h3>La boom Restaurant</h3>
                        <p>329 Queensberry Street, North Melbourne VIC 3051, Australia.</p>
                        <p><a href="#">123 456 7890</a></p>
                        <p><a href="#">support@laboom.com</a></p>
                    </div>
                </div>
                <div class="copy-right">
                    <div class="row">
                        <div class="col-md-6 col-sm-6 col-xs-12 copyright-before">
                            <span>Copyright © 2017 Polygon Theme. All rights reserved.</span>
                        </div>
                        <div class="col-md-6 col-sm-6 col-xs-12 copyright-after">
                            <div class="social-round">
                                <ul>
                                    <li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-dribbble" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-google" aria-hidden="true"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="icon-find">
                <a href="#">
                    <img src="images/location.png" alt="">
                    <span>Find us on Map</span>
                </a>
            </div>
            <div class="location-footer-map">
                <div class="icon-find-location">
                    <a href="#">
                        <img src="images/location.png" alt="">
                        <span>Find us on Map</span>
                    </a>
                </div>
                <div class="footer-map-outer">
                    <div id="footer-map"></div>
                </div>
            </div>
        </div>
    </footer>
    <!-- End Footer -->
    <!-- Start Book Table -->
    <div class="modal fade booktable" id="booktable" tabindex="-1" role="dialog" aria-labelledby="booktable">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <div class="table-title">
                        <h2>Reservation</h2>
                        <h6 class="heade-xs">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</h6>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <select class="select-dropbox">
                                <option>Hour</option>
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>
                        </div>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <select class="select-dropbox">
                                <option>Number of People</option>
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>
                        </div>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="text" name="txt" placeholder="Pick a Date" class="date-pick">
                        </div>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="text" name="txt" placeholder="Phone Number">
                        </div>
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <input type="email" name="email" placeholder="Email Address">
                        </div>
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <button class="btn-main btn-big">BOOK A TABLE</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Book Table -->
</div>
<!-- Back To Top Arrow -->
<a href="#" class="top-arrow"></a>
<script src="js/jquery.min.js"></script>



</body>


<!-- Mirrored from laboom.sk-web-solutions.com/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Sat, 08 Sep 2018 06:20:20 GMT -->
</html>
<script src="plugin/bootstrap/bootstrap.min.js"></script>
<script src="plugin/bootstrap/bootstrap-datepicker.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAf6My1Jfdi1Fmj-DUmX_CcNOZ6FLkQ4Os"></script>
<script src="plugin/form-field/jquery.formstyler.min.js"></script>
<script src="plugin/revolution-plugin/jquery.themepunch.plugins.min.js"></script>
<script src="plugin/revolution-plugin/jquery.themepunch.revolution.min.js"></script>
<script src="plugin/owl-carousel/owl.carousel.min.js"></script>
<script src="plugin/slick-slider/slick.min.js"></script>
<script src="plugin/isotop/isotop.js"></script>
<script src="plugin/isotop/packery-mode.pkgd.min.js"></script>
<script src="plugin/magnific/jquery.magnific-popup.min.js"></script>
<script src="plugin/scroll-bar/jquery.mCustomScrollbar.concat.min.js"></script>
<script src="plugin/animation/wow.min.js"></script>
<script src="plugin/parallax/jquery.stellar.js"></script>
<script src="js/app.js"></script>
<script src="js/script.js"></script>
<script>
    function loadPage(pageName) {
       // alert( "Load was performed." );

        $( "#content" ).load( "body/"+pageName+".php", function() {
            //alert( "Load was performed." );
        });
    }

    loadPage('body_view');


    function active_modal(type){
        if(type==1){
            $('#forget_passModal').modal('hide');
            $('#registerModal').modal('hide');
        }
        else if(type==2){
            $('#loginModal').modal('hide');
            $('#registerModal').modal('hide');
        }
        else if(type==3){
            $('#loginModal').modal('hide');
            setTimeout(function(){
                $('#registerModal').modal();
            }, 400);


        }
    }

    //login validation and complete login
    $('#login_submit').click(function(event){
        event.preventDefault();
        var formData = new FormData($('#login-form')[0]);
        formData.append("q","login_customer");
        if($.trim($('#username').val()) == ""){
            success_or_error_msg('#login_submit_error','danger',"Please type user name","#emp_name");
        }
        if($.trim($('#password').val()) == ""){
            success_or_error_msg('#login_submit_error','danger',"Please type password","#password");
        }
        else{
            $.ajax({
                url: "includes/controller/customerController.php",
                type:'POST',
                data:formData,
                async:false,
                cache:false,
                contentType:false,processData:false,
                success: function(data){
                    if($.isNumeric(data)==true && data==3){
                        success_or_error_msg('#login_submit_error',"danger","Invalid username","#user_name" );
                    }
                    else if($.isNumeric(data)==true && data==2){
                        success_or_error_msg('#login_submit_error',"danger","Invalid password","#password" );
                    }
                    else if($.isNumeric(data)==true && data==1){
                        $('#done_login').addClass("hide");
                        $('#done_login_msg').removeClass("hide");
                        $('.language-menu').html('<a href="account.php" class="current-lang" id="my_acc"><i class="fa fa-user" aria-hidden="true" ></i> My Account</a>');
                        if($('#islogged_in').length > 0 ){
                            $('#islogged_in').val(1);
                            $('.logged_in_already').addClass('hide');
                        }
                    }
                }
            });
        }
    })


</script>
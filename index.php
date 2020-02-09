<?php
session_start();
include("includes/dbConnect.php");
include("includes/dbClass.php");
$dbClass = new dbClass;

if(isset($_SESSION['customer_id']) && $_SESSION['customer_id']){
    $customer_id =$_SESSION['customer_id'];
    $is_logged_in_customer = 1;
}  // here will be the customer id that will come from session when the customer will login
else {
    $is_logged_in_customer = "";
    $customer_id = 0;
}



//$is_logged_in_customer = "";

//email, mobile, address, fearure, title, $subtitle, $facebook, $twitter, $instagram, $googleplus,

$email_info   = $dbClass->getDescription('web_admin_email');
$mobile_info  = $dbClass->getDescription('store_contact');
$about_us     = $dbClass->getDescriptionWithHtml(28);
$address      = $dbClass->getDescription('store_address');
$website_url  = $dbClass->getDescription('website_url');
$website_title=$dbClass->getDescription('website_title');
$store_address=$dbClass->getDescription('store_address');
$currency   = $dbClass->getDescription('currency_symbol');
$item_image_display=$dbClass->getDescription('item_image_display');
$ingredient_image_display=$dbClass->getDescription('ingredient_image_display');


$logo         = $website_url."admin/".$dbClass->getDescription('company_logo');
//$feature      = $dbClass->getDescription(47);
//$special_menu = $dbClass->getDescription(48);
//$subtitle     = $dbClass->getDescription(49);
//$why_we_best  = $dbClass->getDescription(50);
//echo $logo;die;

$facebook  = $dbClass->getDescription('fb_url');
$twitter  = $dbClass->getDescription('tweeter_url');
$instagram  = $dbClass->getDescription('instagram_url');
$yelp  = $dbClass->getDescription('yelp_url');




$search_text = "";
if(isset($_GET['search'])) $search_text = "";

?>


<!DOCTYPE html>
<html lang="en">


<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?php echo $website_title; ?></title>
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
	 <link href="plugin/daterangepicker/daterangepicker.css" rel="stylesheet">
	 
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Exo' rel='stylesheet'>

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
									
									<?php
										if($is_logged_in_customer == ""){
											echo '<li class="language-menu"><a href="#" onclick="active_modal(1)" data-toggle="modal" data-target="#loginModal" class="current-lang" id="log_reg"><i class="fa fa-user" aria-hidden="true"></i> Login / Register</a></li>';
										}
									?>
									
									
									<?php
										if($is_logged_in_customer != ""){
											echo '<li></li><li></li>	
												<li class="dropdown">
													<a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
														<i class="fa fa-bell-slash"></i>
														<span class="badge bg-red" id="unread_notifications"></span>
													</a>
													<ul id="notification_ul" class="dropdown-menu" role="menu">
														<li>
															<div class="text-left">
																<button class="btn btn-primary btn-xs has-spinner" id="load_more_not_button">
																	<span class="spinner"><i class="fa fa-spinner fa-spin fa-fw"></i></span>
																	Load More Notificatons?
																</button>
															</div>																
														</li>
													</ul>
												</li>';	
										}	
									?>
									
								</ul>
							</div>
							
							<?php
								if($is_logged_in_customer != ""){			
									echo '<div class="language-menu">
										<a href="#" class="current-lang">
											<img src="images/user.png" alt=""> <i class="fa fa-caret-down" aria-hidden="true"></i>
										</a>
										<ul>
											<li><a href="index.php?page=account"> My Account</a></li>
											<li><a href="index.php?page=logout"> Log Out <i class="fa fa-sign-out"></i></a></li>
										</ul>
									</div>';
								}
							?>
							
                        </div>
                    </div>
                </div>
            </div>

            <div class="header-bottom">
                <div class="container">
                    <div class="header-info">
                        <div class="header-info-inner">
                            <div class="book-table header-collect book-md">
                                <a href="#" data-toggle="modal" data-target="#booktable"><img src="images/icon-table.png" alt="">Open</a>
                            </div>
                            <div class="shop-cart header-collect">
                                <a href="<?php if(isset($_SESSION['cart'])){echo 'index.php?page=cart';} else {echo '#';}?>" ><img src="images/icon-basket.png" alt=""><span id="total_item_in_cart"></span> items</a>
                                <div class="cart-wrap">
                                    <div class="cart-blog" id="cart_div" style="max-width: 250px" >
                                    </div>
                                </div>
                            </div>
                            <div class="search-part" style="display: none">
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
    <div class="modal fade booktable" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="booktable" >
        <div class="modal-dialog" role="document">
            <div class="modal-content" id="login_modal_responsive">
                <div class="modal-body" >
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
                                                    <label><input type="checkbox" name="chkbox">Remember me</label>
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
                            <a href="index.php?page=account" id="" class="facebook-btn btn-change button-default"><i class="fa fa-user"></i>Browse your account?</a>
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
            <div class="modal-content" id="registration_modal_responsive">
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
            <div class="modal-content" id="passwore_recovary_modal_responsive">
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
    <div class="main-part" id="content" style="min-height: 600px;" >


    <!-- Start Slider Part -->
<section class="home-slider">
        <div class="tp-banner-container">
            <div class="tp-banner">
                <ul>
                    <li data-transition="zoomout" data-slotamount="2" data-masterspeed="1000" data-thumb="" data-saveperformance="on" data-title="Slide">
                        <img src="./images/dummy.png" alt="slidebg1" data-lazyload="./images/slider1.jpg" data-bgposition="center center" data-bgfit="cover" data-bgrepeat="no-repeat">
                        <!-- LAYERS -->
                        <div class="tp-caption very_large_text" data-x="center" data-hoffset="0" data-y="250" data-customin="x:0;y:0;z:0;rotationX:90;rotationY:0;rotationZ:0;scaleX:1;scaleY:1;skewX:0;skewY:0;opacity:0;transformPerspective:200;transformOrigin:50% 0%;" data-customout="x:0;y:0;z:0;rotationX:0;rotationY:0;rotationZ:0;scaleX:0.75;scaleY:0.75;skewX:0;skewY:0;opacity:0;transformPerspective:600;transformOrigin:50% 50%;" data-speed="1000" data-start="500" data-easing="Back.easeInOut" data-endspeed="300">WE’RE <span>Burrito Brothers</span> <i>Restaurant</i>
                        </div>
                        <!-- LAYERS -->
                        <div class="tp-caption medium_text" data-x="center" data-hoffset="0" data-y="340" data-customin="x:0;y:0;z:0;rotationX:90;rotationY:0;rotationZ:0;scaleX:1;scaleY:1;skewX:0;skewY:0;opacity:0;transformPerspective:200;transformOrigin:50% 0%;" data-customout="x:0;y:0;z:0;rotationX:0;rotationY:0;rotationZ:0;scaleX:0.75;scaleY:0.75;skewX:0;skewY:0;opacity:0;transformPerspective:600;transformOrigin:50% 50%;" data-speed="1000" data-start="500" data-easing="Back.easeInOut" data-endspeed="300">Traditional Maxican Delicacies Diches
                        </div>
                        <!-- LAYERS -->
                        <div class="tp-caption" data-x="center" data-hoffset="0" data-y="425" data-customin="x:0;y:0;z:0;rotationX:90;rotationY:0;rotationZ:0;scaleX:1;scaleY:1;skewX:0;skewY:0;opacity:0;transformPerspective:200;transformOrigin:50% 0%;" data-customout="x:0;y:0;z:0;rotationX:0;rotationY:0;rotationZ:0;scaleX:0.75;scaleY:0.75;skewX:0;skewY:0;opacity:0;transformPerspective:600;transformOrigin:50% 50%;" data-speed="1000" data-start="500" data-easing="Back.easeInOut" data-endspeed="300"><a href="index.php?page=categories" class="button-white">Explore NOW</a>
                        </div>
                    </li>
                    <li data-transition="zoomout" data-slotamount="2" data-masterspeed="1000" data-thumb="" data-saveperformance="on" data-title="Slide">
                        <img src="./images/dummy.png" alt="slidebg1" data-lazyload="./images/slider1.jpg" data-bgposition="center center" data-bgfit="cover" data-bgrepeat="no-repeat">
                        <!-- LAYERS -->
                        <div class="tp-caption very_large_text" data-x="center" data-hoffset="0" data-y="250" data-customin="x:0;y:0;z:0;rotationX:90;rotationY:0;rotationZ:0;scaleX:1;scaleY:1;skewX:0;skewY:0;opacity:0;transformPerspective:200;transformOrigin:50% 0%;" data-customout="x:0;y:0;z:0;rotationX:0;rotationY:0;rotationZ:0;scaleX:0.75;scaleY:0.75;skewX:0;skewY:0;opacity:0;transformPerspective:600;transformOrigin:50% 50%;" data-speed="1000" data-start="500" data-easing="Back.easeInOut" data-endspeed="300">WE’RE <span>Burrito Brothers</span> <i>Restaurant</i>
                        </div>
                        <!-- LAYERS -->
                        <div class="tp-caption medium_text" data-x="center" data-hoffset="0" data-y="340" data-customin="x:0;y:0;z:0;rotationX:90;rotationY:0;rotationZ:0;scaleX:1;scaleY:1;skewX:0;skewY:0;opacity:0;transformPerspective:200;transformOrigin:50% 0%;" data-customout="x:0;y:0;z:0;rotationX:0;rotationY:0;rotationZ:0;scaleX:0.75;scaleY:0.75;skewX:0;skewY:0;opacity:0;transformPerspective:600;transformOrigin:50% 50%;" data-speed="1000" data-start="500" data-easing="Back.easeInOut" data-endspeed="300">Traditional Maxican Delicacies Diches
                        </div>
                        <!-- LAYERS -->
                        <div class="tp-caption" data-x="center" data-hoffset="0" data-y="425" data-customin="x:0;y:0;z:0;rotationX:90;rotationY:0;rotationZ:0;scaleX:1;scaleY:1;skewX:0;skewY:0;opacity:0;transformPerspective:200;transformOrigin:50% 0%;" data-customout="x:0;y:0;z:0;rotationX:0;rotationY:0;rotationZ:0;scaleX:0.75;scaleY:0.75;skewX:0;skewY:0;opacity:0;transformPerspective:600;transformOrigin:50% 50%;" data-speed="1000" data-start="500" data-easing="Back.easeInOut" data-endspeed="300"><a  href="index.php?page=categories" class="button-white">Explore NOW</a>
                        </div>
                    </li>
                    <li data-transition="zoomout" data-slotamount="2" data-masterspeed="1000" data-thumb="" data-saveperformance="on" data-title="Slide">
                        <img src="./images/dummy.png" alt="slidebg1" data-lazyload="./images/slider1.jpg" data-bgposition="center center" data-bgfit="cover" data-bgrepeat="no-repeat">
                        <!-- LAYERS -->
                        <div class="tp-caption very_large_text" data-x="center" data-hoffset="0" data-y="250" data-customin="x:0;y:0;z:0;rotationX:90;rotationY:0;rotationZ:0;scaleX:1;scaleY:1;skewX:0;skewY:0;opacity:0;transformPerspective:200;transformOrigin:50% 0%;" data-customout="x:0;y:0;z:0;rotationX:0;rotationY:0;rotationZ:0;scaleX:0.75;scaleY:0.75;skewX:0;skewY:0;opacity:0;transformPerspective:600;transformOrigin:50% 50%;" data-speed="1000" data-start="500" data-easing="Back.easeInOut" data-endspeed="300">WE’RE <span>Burrito Brothers</span> <i>Restaurant</i>
                        </div>
                        <!-- LAYERS -->
                        <div class="tp-caption medium_text" data-x="center" data-hoffset="0" data-y="340" data-customin="x:0;y:0;z:0;rotationX:90;rotationY:0;rotationZ:0;scaleX:1;scaleY:1;skewX:0;skewY:0;opacity:0;transformPerspective:200;transformOrigin:50% 0%;" data-customout="x:0;y:0;z:0;rotationX:0;rotationY:0;rotationZ:0;scaleX:0.75;scaleY:0.75;skewX:0;skewY:0;opacity:0;transformPerspective:600;transformOrigin:50% 50%;" data-speed="1000" data-start="500" data-easing="Back.easeInOut" data-endspeed="300">Traditional Maxican Delicacies Diches
                        </div>
                        <!-- LAYERS -->
                        <div class="tp-caption" data-x="center" data-hoffset="0" data-y="425" data-customin="x:0;y:0;z:0;rotationX:90;rotationY:0;rotationZ:0;scaleX:1;scaleY:1;skewX:0;skewY:0;opacity:0;transformPerspective:200;transformOrigin:50% 0%;" data-customout="x:0;y:0;z:0;rotationX:0;rotationY:0;rotationZ:0;scaleX:0.75;scaleY:0.75;skewX:0;skewY:0;opacity:0;transformPerspective:600;transformOrigin:50% 50%;" data-speed="1000" data-start="500" data-easing="Back.easeInOut" data-endspeed="300"><a href="index.php?page=categories" class="button-white">Explore NOW</a>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </section>
    <!-- End Slider Part -->
    <!-- Start Welcome Part -->
<section id="reach-to" class="welcome-part home-icon">
        <div class="icon-default">
            <a href="#reach-to" class="scroll"><img src="./images/scroll-arrow.png" alt=""></a>
        </div>
        <div class="container">
            <div class="build-title">
                <h2>Welcome To The <?php echo $website_title; ?></h2>
                <h6>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</h6>
            </div>
            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-12 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                    <p class="text-justify" >Welcome. This is La Boom. Elegant &amp; sophisticated restaurant template. Royal plate offers different home page layouts with smart and unique design, showcasing beautifully designed elements every restaurant website should have. Smooth animations, fast loading and engaging user experience are just some of , the features this template offers. So, give it a try and dive into a world of La Boom restaurant websites.</p>
                    <p><img src="./images/signature.png" alt=""></p>
                    <!--<p><a href="#" class="btn-black">LEARN MORE</a></p>-->
                </div>
                <div class="col-md-6 col-sm-6 col-xs-12 wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
                    <img src="./images/img2.png" alt="">
                </div>
            </div>
        </div>
        <div class="float-main hidden-xs">
            <div class="icon-top-left">
                <img src="./images/icon1.png" alt="">
            </div>
            <div class="icon-bottom-left">
                <img src="./images/icon2.png" alt="">
            </div>
            <div class="icon-top-right">
                <img src="./images/icon3.png" alt="">
            </div>
            <div class="icon-bottom-right">
                <img src="./images/icon4.png" alt="">
            </div>
        </div>
    </section>
    <!-- End Welcome Part -->
    <!-- Start Hot Items -->
<section class="special-menu bg-skeen home-icon wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
        <div class="icon-default icon-skeen">
            <img src="./images/icon6.png" alt="">
        </div>
        <div class="container">
            <div class="build-title">
                <h2>Our Hot Items</h2>
                <h6>The role of a good cook ware in the preparation of a sumptuous meal cannot be over emphasized then one consider white bread</h6>
            </div>
            <div class="menu-wrapper">
                <div class="portfolioContainer row">
                    <div class="col-md-6 col-sm-6 col-xs-12 isotope-item breakfast">
						<a href="index.php?page=item&id=88">
						<div class="menu-list">
                                        <span class="menu-list-product">
                                            <img src="./images/img3.png" alt="">
                                        </span>
                            <h5 class="margin-bottom-0 padding-bottom-4"><a href="index.php?page=item&id=88">REGULAR BURRITO LUNCH COMBO </a> <span>$ 9.09</span></h5>
                            <p>Includes a 20 oz. fountain drink.</p>
                        </div>
						</a>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-12 isotope-item lunch">
                        <a href="index.php?page=item&id=90">
							<div class="menu-list">
								<span class="menu-list-product">
									<img src="./images/img4.png" alt="">
								</span>
								<h5 class="margin-bottom-0 padding-bottom-4"><a href="index.php?page=item&id=90"> TACO SALAD LUNCH COMBO </a><span>$ 15.50</span></h5>
								<p>Includes a 20 oz. fountain drink.</p>
							</div>
						</a>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-12 isotope-item dessert">
                        <a href="index.php?page=item&id=96">
						<div class="menu-list">
                                        <span class="menu-list-product">
                                            <img src="./images/img5.png" alt="">
                                        </span>
                            <h5 class="margin-bottom-0 padding-bottom-4"><a href="index.php?page=item&id=96">MIXED FAJITA PLATTER LUNCH COMBO </a><span>$ 16.00</span></h5>
                            <p>Bean and rice, grilled chicken and steak, green pepper, onions, lettuce...</p>
                        </div>
						</a>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-12 isotope-item dinner">
						<a href="index.php?page=item&id=97">
						<div class="menu-list">
							<span class="menu-list-product">
								<img src="./images/img6.png" alt="">
							</span>
                            <h5 class="margin-bottom-0 padding-bottom-4"><a href="index.php?page=item&id=97">FISH PLATTER LUNCH COMBO</a> <span>$ 17.00</span></h5>
                            <p>Beans, rice, lettuce. pico de gallo, guacamole or sliced avocadoIncludes a 20 oz. fountain drink.</p>
                        </div>
						</a>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-12 isotope-item freshfood">
                        <a href="index.php?page=item&id=71">
						<div class="menu-list">
                                        <span class="menu-list-product">
                                            <img src="./images/img7.png" alt="">
                                        </span>
                            <h5 class="margin-bottom-0 padding-bottom-4"><a href="index.php?page=item&id=71">NACHOS WITH MEAT</a> <span>$ 11.00</span></h5>
                            <p>Corn chips topped with shredded cheddar or cheese sauce, beans, pico de gallo and your choice of meat.</p>
                        </div>
						</a>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-12 isotope-item freshfood">
						<a href="index.php?page=item&id=47">
                        <div class="menu-list">
                                        <span class="menu-list-product">
                                            <img src="./images/img8.png" alt="">
                                        </span>
                            <h5 class="margin-bottom-0 padding-bottom-4"><a href="index.php?page=item&id=47">CALI BURRITO</a> <span>$ 10.00</span></h5>
                            <p>One size; Made on a flour tortilla with your choice of meat, french fries</p>
                        </div>
						</a>
                    </div>
                </div>
                <div class="btn-outer">
                    <a href="index.php?page=categories" class="btn-main btn-shadow">Explore Full Menu</a>
                </div>
            </div>
        </div>
        <div class="float-main hidden-xs">
            <div class="icon-top-left">
                <img src="./images/icon7.png" alt="">
            </div>
            <div class="icon-bottom-left">
                <img src="./images/icon8.png" alt="">
            </div>
            <div class="icon-top-right">
                <img src="./images/icon9.png" alt="">
            </div>
            <div class="icon-bottom-right">
                <img src="./images/icon10.png" alt="">
            </div>
        </div>
    </section>
    <!-- End Hot Items -->
    <!-- Start Services -->
<section class="bg-skeen home-icon wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms" style="background-color: rgba(244,242,237,1)">
        <div class="icon-default icon-skeen">
            <img src="./images/scroll-arrow.png" alt="">
        </div>
        <div class="container">
            <div class="service-track">
                <div class="row">
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <div class="service-track-inner btn-shadow" >
                            <div class="service-track-info">
                                <h3>Catering <span>Service</span></h3>
                            </div>
                            <div class="service-track-overlay banner-bg" data-background="images/hover-img1.png" onclick="catering()">
                                <img src="./images/img36.png" alt="">
                                <h3>Catering <span>Service</span></h3>
                                <!--<p>Aptent taciti sociosqu ad litora euismod atras vulputate iltricies etri elit class.</p>-->
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <div class="service-track-inner btn-shadow" id="groupOrder()">
                            <div class="service-track-info">
                                <h3>Group <span>Order</span></h3>
                            </div>
                            <div class="service-track-overlay banner-bg" onclick="group_order()" data-background="images/hover-img2.png">
                                <img src="./images/img36.png" alt="">
                                <h3>Group <span>Order</span></h3>
                              <!--  <p>Aptent taciti sociosqu ad litora euismod atras vulputate iltricies etri elit class.</p> -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End Services -->
    <!-- Start Feature list -->
<section class="bg-skeen feature-list text-center home-icon wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms" style="background-color: white;">
        <div class="icon-default icon-skeen" style="background-color: white">
            <img src="./images/icon22.png" alt="" style="background-color: white">
        </div>
        <div class="container">
            <div class="build-title">
                <h2>Features</h2>
                <h6>The role of a good cook ware in the preparation of a sumptuous meal cannot be <br> over emphasized then one consider white bread</h6>
            </div>
            <div class="row">
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="feature-list-icon">
                        <div class="feature-icon-table">
                            <img src="./images/img9.png" alt="">
                        </div>
                    </div>
                    <h5>Fresh Dishes</h5>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eius-</p>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="feature-list-icon">
                        <div class="feature-icon-table">
                            <img src="./images/img10.png" alt="">
                        </div>
                    </div>
                    <h5>Various Menu</h5>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eius-</p>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="feature-list-icon">
                        <div class="feature-icon-table">
                            <img src="./images/img11.png" alt="">
                        </div>
                    </div>
                    <h5>Well Service</h5>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eius-</p>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="feature-list-icon">
                        <div class="feature-icon-table">
                            <img src="./images/img12.png" alt="">
                        </div>
                    </div>
                    <h5>Fast Delivery</h5>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eius-</p>
                </div>
            </div>
        </div>
    </section>
    <!-- End Feature list -->
    <!-- Start Captures -->
	<section class="instagram-main home-icon wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
		<div class="icon-default">
			<img src="./images/icon23.png" alt="">
		</div>
		<div class="container">
			<div class="build-title">
				<h2>Captures</h2>
				<h6>Enjoyed your stay at La Boom? Share your moments with us. Follow us on Instagram and use</h6>
			</div>
		</div>
		<div class="gallery-slider">
			<div class="owl-carousel owl-theme" data-items="6" data-laptop="5" data-tablet="4" data-mobile="1" data-nav="true" data-dots="false" data-autoplay="true" data-speed="2000" data-autotime="3000">
				<div class="item">
					<a href="./images/gallery/gallery-big1.jpg" class="magnific-popup">
						<img src="./images/gallery/gallery1.png" alt="" class="animated">
						<div class="gallery-overlay">
							<div class="gallery-overlay-inner">
								<i class="fa fa-instagram" aria-hidden="true"></i>
							</div>
						</div>
					</a>
				</div>
				<div class="item">
					<a href="./images/gallery/gallery-big2.jpg" class="magnific-popup">
						<img src="./images/gallery/gallery2.png" alt="" class="animated">
						<div class="gallery-overlay">
							<div class="gallery-overlay-inner">
								<i class="fa fa-instagram" aria-hidden="true"></i>
							</div>
						</div>
					</a>
				</div>
				<div class="item">
					<a href="./images/gallery/gallery-big3.jpg" class="magnific-popup">
						<img src="./images/gallery/gallery3.png" alt="" class="animated">
						<div class="gallery-overlay">
							<div class="gallery-overlay-inner">
								<i class="fa fa-instagram" aria-hidden="true"></i>
							</div>
						</div>
					</a>
				</div>
				<div class="item">
					<a href="./images/gallery/gallery-big4.jpg" class="magnific-popup">
						<img src="./images/gallery/gallery4.png" alt="" class="animated">
						<div class="gallery-overlay">
							<div class="gallery-overlay-inner">
								<i class="fa fa-instagram" aria-hidden="true"></i>
							</div>
						</div>
					</a>
				</div>
				<div class="item">
					<a href="./images/gallery/gallery-big5.jpg" class="magnific-popup">
						<img src="./images/gallery/gallery5.png" alt="" class="animated">
						<div class="gallery-overlay">
							<div class="gallery-overlay-inner">
								<i class="fa fa-instagram" aria-hidden="true"></i>
							</div>
						</div>
					</a>
				</div>
				<div class="item">
					<a href="./images/gallery/gallery-big6.jpg" class="magnific-popup">
						<img src="./images/gallery/gallery6.png" alt="" class="animated">
						<div class="gallery-overlay">
							<div class="gallery-overlay-inner">
								<i class="fa fa-instagram" aria-hidden="true"></i>
							</div>
						</div>
					</a>
				</div>
				<div class="item">
					<a href="./images/gallery/gallery-big1.jpg" class="magnific-popup">
						<img src="./images/gallery/gallery1.png" alt="" class="animated">
						<div class="gallery-overlay">
							<div class="gallery-overlay-inner">
								<i class="fa fa-instagram" aria-hidden="true"></i>
							</div>
						</div>
					</a>
				</div>
				<div class="item">
					<a href="./images/gallery/gallery-big2.jpg" class="magnific-popup">
						<img src="./images/gallery/gallery2.png" alt="" class="animated">
						<div class="gallery-overlay">
							<div class="gallery-overlay-inner">
								<i class="fa fa-instagram" aria-hidden="true"></i>
							</div>
						</div>
					</a>
				</div>
				<div class="item">
					<a href="./images/gallery/gallery-big3.jpg" class="magnific-popup">
						<img src="./images/gallery/gallery3.png" alt="" class="animated">
						<div class="gallery-overlay">
							<div class="gallery-overlay-inner">
								<i class="fa fa-instagram" aria-hidden="true"></i>
							</div>
						</div>
					</a>
				</div>
				<div class="item">
					<a href="./images/gallery/gallery-big4.jpg" class="magnific-popup">
						<img src="./images/gallery/gallery4.png" alt="" class="animated">
						<div class="gallery-overlay">
							<div class="gallery-overlay-inner">
								<i class="fa fa-instagram" aria-hidden="true"></i>
							</div>
						</div>
					</a>
				</div>
				<div class="item">
					<a href="./images/gallery/gallery-big5.jpg" class="magnific-popup">
						<img src="./images/gallery/gallery5.png" alt="" class="animated">
						<div class="gallery-overlay">
							<div class="gallery-overlay-inner">
								<i class="fa fa-instagram" aria-hidden="true"></i>
							</div>
						</div>
					</a>
				</div>
				<div class="item">
					<a href="./images/gallery/gallery-big6.jpg" class="magnific-popup">
						<img src="./images/gallery/gallery6.png" alt="" class="animated">
						<div class="gallery-overlay">
							<div class="gallery-overlay-inner">
								<i class="fa fa-instagram" aria-hidden="true"></i>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>
	</section>





    </div>

    <!-- End Main -->
    <!-- Start Footer -->
    <footer>
        <div class="footer-part wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
            <div class="icon-default icon-dark">
                <img src="<?php echo $logo; ?>"  alt="">
            </div>
            <div class="container">
                <div class="footer-inner">
                    <div class="footer-info">
                        <h3><?php echo $website_title; ?></h3>
                        <p><?php echo $store_address; ?></p>
                        <p><a href="#"><?php echo $mobile_info; ?></a></p>
                        <p><a href="#"><?php echo $email_info; ?></a></p>
                    </div>
                </div>
                <div class="copy-right">
                    <div class="row">
                        <div class="col-md-6 col-sm-6 col-xs-12 copyright-before">
                            <span>Copyright © 2020 <?php echo $website_title; ?>. All rights reserved.</span>
                        </div>
                        <div class="col-md-6 col-sm-6 col-xs-12 copyright-after">
                            <div class="social-round">
                                <ul>

                                    <li><a href="<?php echo $facebook; ?>"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                                    <li><a href="<?php echo $twitter; ?>"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                                    <li><a href="<?php echo $instagram; ?>"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
                                    <li><a href="<?php echo $yelp; ?>"><i class="fa fa-yelp"></i></a></li>
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
                        <h2>Opening Hours</h2>
                        <ul class="time-list" >
                            <li> <span class="week-name" style="text-align: left">Monday</span> <span>10-12 PM</span></li>
                            <li><span class="week-name" style="text-align: left">Tuesday</span> <span>10-12 PM</span></li>
                            <li><span class="week-name" style="text-align: left">Wednesday</span> <span>10-12 PM</span></li>
                            <li><span class="week-name" style="text-align: left">Thursday</span> <span>10-12 PM</span></li>
                            <li><span class="week-name" style="text-align: left">Friday</span> <span>10-12 PM</span></li>
                            <li><span class="week-name" style="text-align: left">Saturday</span> <span>10-12 PM</span></li>
                            <li><span class="week-name" style="text-align: left">Sunday</span> <span>4-12 PM</span></li>
                        </ul>
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
<script type="text/javascript" src="admin/theme/js/moment/moment.min.js"></script>
<script type="text/javascript" src="admin/theme/js/datepicker/daterangepicker.js"></script>
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
<script src="js/url.js"></script>
<script src="js/static_text.js"></script>
<script src="js/common.js"></script>
<script src="js/cart.js"></script>


<script>

	// view images for category or not 
	var item_image_d="<?php echo $item_image_display; ?>";
	if(item_image_d==1){
		item_image_display="display: block"
	}else{
		item_image_display="display: none"
	}


	// view images for ingredienets or not
	var ingredient_image_d ="<?php echo $ingredient_image_display; ?>";
	if(ingredient_image_d==1){
		ingredient_image_display="display: block"
	}else{
		ingredient_image_display="display: none"
	}

    var customer_id = <?php echo $customer_id; ?>;
    showCart()

    function group_order(){
        localStorage.setItem("nexturl", "grouporder");
            //alert("IN group order")
        if(customer_id==0){
            //nextPage = 'group_order';
            //$('.nexturl').val('grouporder')
            $('#loginModal').modal();
        }
        else {
            window.location=project_url+'index.php?page=account'

        }

    }



    var sWidth = window.screen.width;
    //alert("sWidth is: " + sWidth);
    if(sWidth<801){
        $('#login_modal_responsive').css('width', sWidth-20+'px')
        $('#registration_modal_responsive').css('width',sWidth-20+'px')
        $('#passwore_recovary_modal_responsive').css('width', sWidth-20+'px')
    }

    //alert(item_image_display)
    function loadPage(pageName) {
        // alert( "Load was performed." );

        $( "#content" ).load( "body/"+pageName+".php", function() {
            //alert( "Load was performed." );
        });
    }

    //loadPage('body_view');

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
                        $('.language-menu').html('<a href="index.php?page=account" class="current-lang" id="my_acc"><i class="fa fa-user" aria-hidden="true" ></i> My Account</a>');
                        if($('#islogged_in').length > 0 ){
                            $('#islogged_in').val(1);
                            $('.logged_in_already').addClass('hide');
                        }

                        if(localStorage.getItem("nexturl")=='grouporder'){
                            window.location=project_url+'index.php?page=account'
                        }
                    }
                }
            });
        }
    })

    // send mail if forget password
    $('#foget_pass_submit').click(function(event){
        event.preventDefault();
        var formData = new FormData($('#forget-pass-form')[0]);
        formData.append("q","forget_password");
        if($.trim($('#forget_email').val()) == ""){
            success_or_error_msg('#foget_pass_submit_error','danger',"Please enter email address","#forget_email");
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
                    if($.isNumeric(data)==true && data==2){
                        success_or_error_msg('#foget_pass_submit_error',"danger","Please provide a valid email address","#forget_email" );
                    }
                    else if($.isNumeric(data)==true && data==1){
                        $('.sent_password').addClass("hide");
                        $('.sent_password_msg').removeClass("hide");
                    }
                }
            });
        }
    })

    // send mail if forget password
    $('#register_submit').click(function(event){
        event.preventDefault();
        var formData = new FormData($('#register-form')[0]);
        formData.append("q","registration");
        if($.trim($('#cust_name').val()) == ""){
            success_or_error_msg('#registration_submit_error','danger',"Please enter name","#cust_name");
        }
        else if($.trim($('#cust_username').val()) == ""){
            success_or_error_msg('#registration_submit_error','danger',"Please enter username","#cust_username");
        }
        else if($.trim($('#cust_email').val()) == ""){
            success_or_error_msg('#registration_submit_error','danger',"Please enter email address","#cust_email");
        }
        else if($.trim($('#cust_password').val()) == ""){
            success_or_error_msg('#registration_submit_error','danger',"Please enter pasword","#cust_password");
        }
        else if($.trim($('#cust_conf_password').val()) == ""){
            success_or_error_msg('#registration_submit_error','danger',"Please confirm password ","#cust_conf_password");
        }
        else if($.trim($('#cust_password').val()) != $.trim($('#cust_conf_password').val())){
            success_or_error_msg('#registration_submit_error','danger',"Please enter same password","#cust_conf_password");
        }
        else if($.trim($('#cust_contact').val()) == ""){
            success_or_error_msg('#registration_submit_error','danger',"Please enter valid contact no","#cust_contact");
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
                    //alert(data)
                    if($.isNumeric(data)==true && data==2){
                        success_or_error_msg('#registration_submit_error',"danger","Username is already exist, please try with another one","#cust_username" );
                    }
                    else if($.isNumeric(data)==true && data==3){
                        success_or_error_msg('#registration_submit_error',"danger","Email is already exist, please try with another one","#cust_email" );
                    }
                    else if($.isNumeric(data)==true && data==1){
                        $('.done_registration').addClass("hide");
                        $('.done_registration_msg').removeClass("hide");
                        //alert('done')
                        if(localStorage.getItem("nexturl")=='grouporder'){
                            window.location=project_url+'index.php?page=account'
                        }
                    }
                    else{
                        success_or_error_msg('#registration_submit_error',"danger","Registration is not completed. please check your information again.","#cust_email" );
                    }
                }
            });
        }
    })

    //send mail to cakencookies from contact page
    $('#contact_submit').click(function(event){
        event.preventDefault();
        var formData = new FormData($('#contact-form')[0]);
        formData.append("q","contact_us_mail");
        if($.trim($('#first_name').val()) == ""){
            success_or_error_msg('#contact_submit_error','danger',"Please type name","#first_name");
        }
        else if($.trim($('#email').val()) == ""){
            success_or_error_msg('#contact_submit_error','danger',"Please type email","#email");
        }
        else if($.trim($('#mobile').val()) == ""){
            success_or_error_msg('#contact_submit_error','danger',"Please enter mobile no.","#mobile");
        }
        else if($.trim($('#subject').val()) == ""){
            success_or_error_msg('#contact_submit_error','danger',"Please type subject.","#subject");
        }
        else if($.trim($('#message').val()) == ""){
            success_or_error_msg('#contact_submit_error','danger',"Please type message.","#message");
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
                    if($.isNumeric(data)==true && data==1){
                        success_or_error_msg('#contact_submit_error',"success","Mail has sent","" );
                        $('#contact-form')[0].reset();
                    }
                    else if($.isNumeric(data)==true && data==2){
                        success_or_error_msg('#contact_submit_error',"danger","Mail has sent","" );
                    }
                }
            });
        }
    })

    //custome cake
    $('#cc_submit').click(function(event){
        event.preventDefault();
        var formData = new FormData($('#custome-cake-form')[0]);
        formData.append("q","insert_custom_cake");
        if($.trim($('#cc_details').val()) == ""){
            success_or_error_msg('#cc_submit_error','danger',"Please type details","#cc_details");
        }
        else if($.trim($('#cc_name').val()) == ""){
            success_or_error_msg('#cc_submit_error','danger',"Please type name","#cc_name");
        }
        else if($.trim($('#cc_mobile').val()) == ""){
            success_or_error_msg('#cc_submit_error','danger',"Please enter mobile no.","#cc_mobile");
        }
        else if($.trim($('#cc_email').val()) == ""){
            success_or_error_msg('#cc_submit_error','danger',"Please type email.","#cc_email");
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
                    if($.isNumeric(data)==true && data==1){
                        success_or_error_msg('#cc_submit_error',"success","Request has benn accepted, please keep in touch. We will contact with you shortly","" );
                        $('#custome-cake-form')[0].reset();
                    }
                    else if($.isNumeric(data)==true && data==2){
                        success_or_error_msg('#cc_submit_error',"danger","Error! ","" );
                    }
                }
            });
        }
    })



    $(document).on('click','#order_print', function(){
        var divContents = $("#order-div").html();
        var printWindow = window.open('', '', 'height=400,width=800');
        printWindow.document.write('<html><head><title>DIV Contents</title>');
        printWindow.document.write('</head><body style="padding:10px">');
        printWindow.document.write('<link href="plugin/bootstrap/bootstrap.css" rel="stylesheet">');
        printWindow.document.write(divContents);
        printWindow.document.write('</body></html>');
        printWindow.document.close();
        printWindow.print();
    });


    $('.category a').on('click',function(){
        window.location = $(this).attr('href');
    });

    $('#searchSubmit').on('click',function(){
        window.location = 'search.php?search='+$('#searchbox'). val();
    });




    function catering() {
        //alert('sdf')
        window.location.href= project_url+'index.php?page=catering'
    }


    function success_or_error_msg(div_to_show, class_name, message, field_id){
        $(div_to_show).addClass('alert alert-custom alert-'+class_name).html(message).show("slow");
        //$(window).scrollTop(200);
        var set_interval = setInterval(function(){
            $(div_to_show).removeClass('alert alert-custom alert-'+class_name).html("").hide( "slow" );
            if(field_id!=""){ $(field_id).focus();}
            clearInterval(set_interval);
        }, 2000);
    }
		
	
	



</script>
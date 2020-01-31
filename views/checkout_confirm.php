<?php;
session_start();

if(!isset($_SESSION['customer_id']) && $_SESSION['customer_id']!="" && $_SESSION['latest_order_id']!=""){ ob_start(); header("Location:error.php"); exit();}
//var_dump($customer_info);
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
                <p >Thank you for ordering our food. You will receive a confirmation email shortly. your order referenced id #<b></b>
                    <br> Now check a Food Tracker progress with your order.</p>
                <a href="account.php" class="btn-medium btn-primary-gold btn-large">Go To Food Tracker</a>
                <br /><br />
                <button type="button" class="btn btn-warning"  onclick="view_order()" id=""><i class="fa fa-lg fa-print"> &nbsp; Print order #</i></button>
            </div>

    </div>
</section>



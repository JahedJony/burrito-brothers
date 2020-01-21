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


<section class="home-icon shop-cart row  alert-warning" style="padding-top: 0px; margin-top: 0px">
    <div>

    </div>
</section>









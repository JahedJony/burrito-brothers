<?php
session_start();
if(!isset($_SESSION['cart']) || !count($_SESSION['cart'])>0) {

    echo'<script> window.location="index.php?page=categories"; </script> ';
}
?>
<section class="breadcrumb-part" data-stellar-offset-parent="true" data-stellar-background-ratio="0.5" style="background-image: url('./images/breadbg1.jpg');max-height: 220px">
    <div class="container">
        <div class="breadcrumb-inner">
            <h2>CART ITEMS</h2>
            <a href="index.php?page=home">Home</a>
            <span>Cart Items</span>
        </div>
    </div>
</section>

<section class="home-icon shop-cart bg-skeen">
            <div class="icon-default icon-skeen">
                <img src="../images/scroll-arrow.png" alt="">
            </div>
            <div class="container" style="margin: auto">
                <div class="checkout-wrap wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                    <ul class="checkout-bar">
                        <li class="active"><a href="index.php?page=cart">Shopping Cart</a></li>
                        <li class=""><a href="index.php?page=checkout">Checkout</a></li>
                        <li>Order Complete</li>
                    </ul>
                </div>
                <form class="form" method="post" name="cart_detail" id="cart_detail">
                <div class="shop-cart-list wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                    <table class="shop-cart-table">
                        <thead>
                        <tr>
                            <th>PRODUCT</th>
                            <th>PRICE</th>
                            <th>QUANTITY</th>
                            <th>TOTAL</th>
                        </tr>
                        </thead>
                        <tbody id="cart_table">

                        </tbody>
                    </table>
                    <div class="product-cart-detail">
                        <input name="update_cart" id="update_cart"  value="UPDATE CART" class="btn-medium btn-skin pull-right" type="submit">
                    </div>
                </div>
                </form>


                    <div class="cart-total wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms" style="text-align: center">

                    <div class="cart-total-title">
                        <h5>CART TOTALS</h5>
                    </div>
                    <div id="price_summary">

                    </div>

                    <div class="proceed-check">
                        <?php
                        if(isset($_SESSION['group_master'])){?>
                            <a href="#" class="btn-dark-coffee btn-medium" style="text-align: center" onclick="submitItem()">SUBMIT YOUR ITEMS</a>
                        <?php }
                        else{ ?>

                            <a href="index.php?page=checkout" class="btn-primary-gold btn-medium">PROCEED TO CHECKOUT</a>
                        <?php } ?>
                    </div>
                </div>
            </div>
        </section>


<script src="js/cart.js"></script>

<script>
    $("#price_summary").load("views/order_price_summary.php");

    submitItem= function submitItem() {
        $.ajax({
            url: "./includes/controller/ecommerceController.php",
            dataType: "json",
            type: "post",
            async:false,
            data: {
                q: "checkout"
            },
            success: function(data) {
                if(data=='111'){
                    $("#content").load("views/checkout_confirm.php");
                }
                else if(data=='222'){
                    window.location.href= project_url+"index.php?page=account";
                }
            }

        })
    }

    function cart_View(){
        $.ajax({
            url: "./includes/controller/ecommerceController.php",
            dataType: "json",
            type: "post",
            async:false,
            data: {
                q: "viewCartSummery"
            },
            success: function(data) {
                if(!jQuery.isEmptyObject(data.records)){
                    var html = '';
                    var total = 0;
                    var sub_total = 0;
                    var count =0
                    $.each(data.records, function(i,datas){

                        sub_total += parseFloat(datas.discounted_rate)*(datas.quantity);
                        html+=' <tr>\n' +
                            '                            <th>PRODUCT</th>\n' +
                            '                            <td>\n' +
                            '                                <div class="product-cart" style="">\n' +
                            '                                    <img src="/admin/images/item/'+datas.item_image+'" alt="" style="height: 80px; width: 80px; border-radius: 10px;'+ item_image_display +'">\n' +
                            '                                    <span class="text-capitalize">'+datas.item_name+'</span>\n' +
                            '                                </div>\n' +
                            '                            </td>\n' +
                            '                            <th>PRICE</th>\n' +
                            '                            <td>\n' +
                            '                                <strong>'+ currency_symbol+''+datas.discounted_rate+'</strong>\n' +
                            '                            </td>\n' +
                            '                            <th>QUANTITY</th>\n' +
                            '                            <td>\n' +
                            '                                <div class="price-textbox">\n' +
                            '                                    <span class="minus-text" onclick="minusProd('+datas.item_id+')"><i class="icon-minus"></i></span>' +
                            '                                    <input type="hidden" name="cart_key[]" value="'+i+'"/>\n' +
                            '                                    <input name="quantity[]" id="quantity_'+datas.item_id+'" placeholder="'+datas.quantity+'" type="text" value="'+datas.quantity+'">\n' +
                            '                                    <span class="plus-text" onclick="addProd('+datas.item_id+')"><i class="icon-plus"></i></span>\n' +
                            '                                </div>\n' +
                            '                            </td>\n' +
                            '                            <th>TOTAL</th>\n' +
                            '                            <td>\n' +
                            '                                '+ currency_symbol+''+datas.discounted_rate+' * '+datas.quantity+'='+ currency_symbol+''+datas.discounted_rate * datas.quantity+'\n' +
                            '                            </td>\n' +
                            '                            <td class="shop-cart-close"><i class="icon-cancel-5" onclick=deleteCartItem("'+i+'")></i></td>\n' +
                            '                        </tr>'

                        count++;
                        total += sub_total ;
                    });
                    $('#quantity_15').val(15)
                    $('#cart_table').html(html);

                    total = total.toFixed(2);
                    html += '<div class="subtotal"><div class="col-md-6 col-sm-6 col-xs-6"><h6>Subtotal :</h6></div><div class="col-md-6 col-sm-6 col-xs-6"><span>Tk '+total+'</span></div></div>';
                    html  += '<div class="cart-btn"><div class="col-sm-6"><a href="cart.php" class="btn-main checkout">VIEW ALL</a></div><div class="col-sm-6"><a href="checkout.php" class="btn-main checkout">CHECK OUT</a></div></div>';
                    $('#total_item_in_cart').html(count);
                }
                else{
                    $('#total_item_in_cart').html(0);
                    html = "<h6>You have no items in your cart</h6>";
                }

            }
        });
        showCart()
    }
    cart_View()



    // send mail if forget password
    $('#update_cart').click(function(event){
        event.preventDefault();
        var formData = new FormData($('#cart_detail')[0]);
        formData.append("q","update_cart");
        $.ajax({
            url: "./includes/controller/ecommerceController.php",
            type:'POST',
            data:formData,
            async:false,
            cache:false,
            contentType:false,processData:false,
            success: function(data){
                cart_View()
                price_view()
            }
        });
        showCart()
    })

    deleteCartItem = function (cart_key) {
        deleteItem(cart_key);
        cart_View()
        price_view()
        showCart()

    }

    function addProd(cart_key){
        var qty = parseFloat($('#quantity_'+cart_key).val());
        $('#quantity_'+cart_key).val(qty+1);
    }

    function minusProd(cart_key){
        var qty = parseFloat($('#quantity_'+cart_key).val());
        if(qty>1)  $('#quantity_'+cart_key).val(qty-1);
    }

</script>


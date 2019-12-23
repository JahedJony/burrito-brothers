<main>
    <div class="main-part">
        <!-- Start Breadcrumb Part -->
        <section class="breadcrumb-part" data-stellar-offset-parent="true" data-stellar-background-ratio="0.5" style="background-image: url('../images/breadbg1.jpg');">
            <div class="container">
                <div class="breadcrumb-inner">
                    <h2>SHOP CART</h2>
                    <a href="#">Home</a>
                    <span>Shop</span>
                </div>
            </div>
        </section>
        <!-- End Breadcrumb Part -->
        <section class="home-icon shop-cart bg-skeen">
            <div class="icon-default icon-skeen">
                <img src="../images/scroll-arrow.png" alt="">
            </div>
            <div class="container">
                <div class="checkout-wrap wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                    <ul class="checkout-bar">
                        <li class="active">Shopping Cart</li>
                        <li>Checkout</li>
                        <li>Order Complete</li>
                    </ul>
                </div>
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

                       <!-- <tr>
                            <th>PRODUCT</th>
                            <td>
                                <div class="product-cart">
                                    <img src="../images/img71.png" alt="">
                                </div>
                                <div class="product-cart-title">
                                    <span>Blanched Garlic</span>
                                </div>
                            </td>
                            <th>PRICE</th>
                            <td>
                                <strong>$59</strong>
                                <del>$5400.00</del>
                            </td>
                            <th>QUANTITY</th>
                            <td>
                                <div class="price-textbox">
                                    <span class="minus-text"><i class="icon-minus"></i></span>
                                    <input name="txt" placeholder="1" type="text">
                                    <span class="plus-text"><i class="icon-plus"></i></span>
                                </div>
                            </td>
                            <th>TOTAL</th>
                            <td>
                                $59
                            </td>
                            <td class="shop-cart-close"><i class="icon-cancel-5"></i></td>
                        </tr>
                        <tr>
                            <th>PRODUCT</th>
                            <td>
                                <div class="product-cart">
                                    <img src="../images/img72.png" alt="">
                                </div>
                                <div class="product-cart-title">
                                    <span>Blanched Garlic</span>
                                </div>
                            </td>
                            <th>PRICE</th>
                            <td>
                                <strong>$59</strong>
                                <del>$5400.00</del>
                            </td>
                            <th>QUANTITY</th>
                            <td>
                                <div class="price-textbox">
                                    <span class="minus-text"><i class="icon-minus"></i></span>
                                    <input name="txt" placeholder="1" type="text">
                                    <span class="plus-text"><i class="icon-plus"></i></span>
                                </div>
                            </td>
                            <th>TOTAL</th>
                            <td>
                                $59
                            </td>
                            <td class="shop-cart-close"><i class="icon-cancel-5"></i></td>
                        </tr>

                        -->
                        </tbody>
                    </table>
                    <div class="product-cart-detail">
                        <div class="cupon-part">
                            <input type="text" name="txt" placeholder="Cupon Code">
                        </div>
                        <a href="#" class="btn-medium btn-dark-coffee">Apply Coupon</a>
                        <a href="#" class="btn-medium btn-skin pull-right">UPDATE cart</a>
                    </div>
                </div>
                <div class="cart-total wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                    <div class="cart-total-title">
                        <h5>CART TOTALS</h5>
                    </div>
                    <div class="product-cart-total">
                        <small>Total products</small>
                        <span>$140.00</span>
                    </div>
                    <div class="product-cart-total">
                        <small>Total shipping</small>
                        <span>$15.00</span>
                    </div>
                    <div class="grand-total">
                        <h5>TOTAL <span>$140.00</span></h5>
                    </div>
                    <div class="proceed-check">
                        <a href="../theme/shop_checkout.html" class="btn-primary-gold btn-medium">PROCEED TO CHECKOUT</a>
                    </div>
                </div>
            </div>
        </section>
    </div>
</main>


<script>
    function cartView(){
        //alert('ok')
        $.ajax({
            url: "includes/controller/ecommerceController.php",
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
                        //alert(datas.item_image)

                        sub_total += parseFloat(datas.discounted_rate)*(datas.quantity);
                        html+=' <tr>\n' +
                            '                            <th>PRODUCT</th>\n' +
                            '                            <td>\n' +
                            '                                <div class="product-cart" style="'+ item_image_display +'">\n' +
                            '                                    <img src="/admin/images/item/'+datas.item_image+'" alt="" style="height: 80px; width: 140px; border-radius: 10px">\n' +
                            '                                </div>\n' +
                            '                                <div class="product-cart-title">\n' +
                            '                                    <span>'+datas.item_name+'</span>\n' +
                            '                                </div>\n' +
                            '                            </td>\n' +
                            '                            <th>PRICE</th>\n' +
                            '                            <td>\n' +
                            '                                <strong>'+datas.discounted_rate+'</strong>\n' +
                            '                                <del>$5400.00</del>\n' +
                            '                            </td>\n' +
                            '                            <th>QUANTITY</th>\n' +
                            '                            <td>\n' +
                            '                                <div class="price-textbox">\n' +
                            '                                    <span class="minus-text"><i class="icon-minus"></i></span>\n' +
                            '                                    <input name="txt" placeholder="'+datas.quantity+'" type="text">\n' +
                            '                                    <span class="plus-text"><i class="icon-plus"></i></span>\n' +
                            '                                </div>\n' +
                            '                            </td>\n' +
                            '                            <th>TOTAL</th>\n' +
                            '                            <td>\n' +
                            '                                '+datas.discounted_rate+' * '+datas.quantity+'\n' +
                            '                            </td>\n' +
                            '                            <td class="shop-cart-close"><i class="icon-cancel-5"></i></td>\n' +
                            '                        </tr>'

                        /*html += '<div class="cart-item"><div class="cart-item-left"><img src="/admin/images/item/'+datas.item_image+'" alt=""></div><div class="cart-item-right"><h6>'+datas.item_name+'</h6><span> '+datas.discounted_rate+' * '+datas.quantity+' = '+sub_total+'</span></div><span class="delete-icon" onclick="deleteItem('+"'"+datas.cart_key+"'"+')"></span></div>';
                        */
                        count++;
                        total += sub_total ;
                    });

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
                $('#cart_div').html(html);

            }
        });
    }
    cartView()
    $('#apply_cupon').click(function(){
        var cupon_code = $('#cupon_code').val();
        if(cupon_code !=""){
            $.ajax({
                url: "includes/controller/ecommerceController.php",
                type:'POST',
                async:false,
                data: "q=apply_cupon&cupon_code="+cupon_code,
                success: function(data){
                    /*if($.trim(data) == 1)*/
                    location.reload();
                }
            });
        }
    })

    // send mail if forget password
    $('#update_cart').click(function(event){
        event.preventDefault();
        var formData = new FormData($('#cart_detail')[0]);
        formData.append("q","update_cart");
        $.ajax({
            url: "includes/controller/ecommerceController.php",
            type:'POST',
            data:formData,
            async:false,
            cache:false,
            contentType:false,processData:false,
            success: function(data){
                if(data==1)  location.reload();
            }
        });
    })

    function deleteProductFromCart(cart_key){
        $.ajax({
            url: "includes/controller/ecommerceController.php",
            dataType: "json",
            type: "post",
            async:false,
            data: {
                q: "removeFromCart",
                cart_key:cart_key
            },
            success: function(data) {
                $('#tr_'+cart_key).remove();
                if(!jQuery.isEmptyObject(data.records)){
                    var html = '';
                    var total = 0;
                    var sub_total = 0;
                    var count =0
                    $.each(data.records, function(i,datas){
                        sub_total += parseFloat(datas.discounted_rate)*(datas.quantity);
                        html += '<div class="cart-item"><div class="cart-item-left"><img src="admin/images/product/'+datas.product_image+'" alt=""></div><div class="cart-item-right"><h6>'+datas.product_name+'</h6><span> '+datas.discounted_rate+' * '+datas.quantity+' = '+sub_total+'</span></div><span class="delete-icon" onclick="deleteProductFromCart('+"'"+datas.cart_key+"'"+')"></span></div>';
                        count++;
                        total += sub_total ;
                    });
                    //var cupon_amount = datas.cupon_amount;
                    //if()
                    total = total.toFixed(2);
                    $('#cart_total').html(total);
                    $('#discount_total').html(total);
                    $('#grand_total').html(total);

                    html += '<div class="subtotal"><div class="col-md-6 col-sm-6 col-xs-6"><h6>Subtotal :</h6></div><div class="col-md-6 col-sm-6 col-xs-6"><span>Tk '+total+'</span></div></div>';
                    html  += '<div class="cart-btn"><a href="cart.php" class="btn-main checkout">VIEW ALL</a><a href="checkout.php" class="btn-main checkout">CHECK OUT</a></div>';
                    $('#total_product_in_cart').html(count);
                }
                else{
                    html = "<div class='alert alert-danger center' style='width:100%; min-height:100px'>There is no product in your cart</div>";
                    $('#product_container').html(html);
                }
            }
        });
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


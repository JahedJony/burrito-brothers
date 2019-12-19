
        <!-- Start Menu Part -->
        <section class="special-menu home-icon">
            <div class="icon-default">
                <img src="../images/scroll-arrow.png" alt="">
            </div>
            <div class="container">
                <div class="portfolioContainer row" data-defaultfilter=".breakfast" id="menus">
                    <!--div class="col-md-4 col-sm-4 col-xs-12 isotope-item breakfast dinner wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                        <div class="menu-round">
                            <div class="menu-round-img">
                                <img src="../images/img27.jpg" alt="">
                            </div>
                            <div class="menu-round-info">
                                <h5>Lasal Cheese <span>$ 15.00</span></h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-4 col-xs-12 isotope-item breakfast lunch wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                        <div class="menu-round">
                            <div class="menu-round-img">
                                <img src="../images/img28.jpg" alt="">
                            </div>
                            <div class="menu-round-info">
                                <h5>Lasal Cheese <span>$ 15.00</span></h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-4 col-xs-12 isotope-item dessert breakfast wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                        <div class="menu-round">
                            <div class="menu-round-img">
                                <img src="../images/img29.jpg" alt="">
                            </div>
                            <div class="menu-round-info">
                                <h5>Lasal Cheese <span>$ 15.00</span></h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-4 col-xs-12 isotope-item dinner breakfast wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                        <div class="menu-round">
                            <div class="menu-round-img">
                                <img src="../images/img30.jpg" alt="">
                            </div>
                            <div class="menu-round-info">
                                <h5>Lasal Cheese <span>$ 15.00</span></h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-4 col-xs-12 isotope-item freshfood breakfast dessert wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                        <div class="menu-round">
                            <div class="menu-round-img">
                                <img src="../images/img31.jpg" alt="">
                            </div>
                            <div class="menu-round-info">
                                <h5>Lasal Cheese <span>$ 15.00</span></h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-4 col-xs-12 isotope-item freshfood breakfast wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                        <div class="menu-round">
                            <div class="menu-round-img">
                                <img src="../images/img32.jpg" alt="">
                            </div>
                            <div class="menu-round-info">
                                <h5>Lasal Cheese <span>$ 15.00</span></h5>
                            </div>
                        </div>
                    </div-->
                </div>

            </div>
        </section>
        <!-- End Menu Part -->

        <!-- End Discount Part -->
    </div>

<script src="js/app.js"></script>
<script src="js/script.js"></script>
<script src="js/cart.js"></script>

<script>
    var menus = location.search.split('category=')[1];
    menus = menus.split('__').join(' ')

    html_generator = function html_generator(data) {
        //alert(data['photo'])
        var html_op ='                <div class="col-md-4 col-sm-4 col-xs-12 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">\n' +
            '                    <div class="shop-main-list" style="background-color: #e4b95b; border-radius: 15px">\n' +
            '                        <div class="shop-product" style="border-radius: 15px 15px 0px 0px">\n' +
            '                            <img src="'+ project_url+'admin/images/item/'+data['photo']+'" alt=""style="height: 220px; width:100%">\n' +
            '                            <div class="cart-overlay-wrap" style="border-radius: 0px">\n' +
            '                                <div class="cart-overlay" >\n' +
            '                                    <p onclick="cart('+data['item_id']+','+data['rate']+')" class="shop-cart-btn">Add to Cart</p>\n' +
            '                                </div>\n' +
            '                            </div>\n' +
            '                        </div>\n' +
            '                                <a href="index.php?page=item&id='+ data['item_id']+'"><h5>'+ data['name']+' <span style="color: white">'+data['rate']+'</span></h5></a>\n' +
            '                    </div>\n' +
            '                </div>\n'


        var html='<div class="col-md-4 col-sm-4 col-xs-12 isotope-item breakfast dinner wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">\n' +
            '                        <div class="menu-round" style="background-color: #e4b95b; border-radius: 15px">\n' +
            '                            <div class="menu-round-img">\n' +
            '                                <img src="'+ project_url+'admin/images/item/'+data['photo']+'" alt="" style="height: 220px; width:100%">\n' +
            '                            </div>\n' +
            '                            <div class="menu-round-info">\n' +
            '                                <a href="index.php?page=item&id='+ data['item_id']+'"><h5>'+ data['name']+' <span style="color: white">'+data['rate']+'</span></h5></a>\n' +
            '                            </div>\n' +
            '                        </div>\n' +
            '                    </div>'

        return html_op;

    }
    cart = function cart(id, price){
        //gialert(price)

        $.ajax({
            url: "includes/controller/ecommerceController.php",
            dataType: "json",
            type: "post",
            async:false,
            data: {
                q: "addToCart",
                item_id:id,
                quantity:1,
                rate:price
            },
            success: function(data) {
                //alert(data)
                if(!jQuery.isEmptyObject(data.records)){
                    var html = '';
                    var total = 0;
                    var sub_total = 0;
                    var count =0
                    $.each(data.records, function(i,datas){
                        sub_total += parseFloat(datas.discounted_rate)*(datas.quantity);
                        html += '<div class="cart-item"><div class="cart-item-left"><img src="admin/images/product/'+datas.product_image+'" alt=""></div><div class="cart-item-right"><h6>'+datas.product_name+'</h6><span> '+datas.discounted_rate+' * '+datas.quantity+' = '+sub_total+'</span></div><span class="delete-icon" onclick="deleteProduct('+"'"+datas.cart_key+"'"+')"></span></div>';
                        count++;
                        total += sub_total ;
                    });
                    total = total.toFixed(2);
                    html += '<div class="subtotal"><div class="col-md-6 col-sm-6 col-xs-6"><h6>Subtotal :</h6></div><div class="col-md-6 col-sm-6 col-xs-6"><span>Tk '+total+'</span></div></div>';
                    html  += '<div class="cart-btn"><a href="cart.php" class="btn-main checkout">VIEW ALL</a><a href="checkout.php" class="btn-main checkout">CHECK OUT</a></div>';
                    $('#total_product_in_cart').html(count);
                    success_or_error_msg('#added_to_cart_message','info',"Added to cart" ,"#added_to_cart_message");

                }
                else{
                    $('#total_product_in_cart').html(0);
                    html = "<h6>You have no items in your cart</h6>";
                }
                $('#cart_div').html(html);

            }
        });
        showCart()

    }




    load_menu = function load_menu(menu) {
        $.ajax({
            url: project_url + "includes/controller/itemsController.php",
            dataType: "json",
            type: "post",
            async: false,
            data: {
                q: "menu_view",
                menu: menus,
            },
            success: function (data) {
                var menu_html=''
                for(var i=0 ; i<data.length; i++){
                    menu_html = menu_html+ html_generator(data[i])

                }
                $('#menus').html(menu_html)
                //for  showing grid's no of records from total no of records
            }
        });
    }
    load_menu(menus)



</script>

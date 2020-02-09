
<!-- Start Menu Part -->

<section class="breadcrumb-part" data-stellar-offset-parent="true" data-stellar-background-ratio="0.5" style="background-image: url('./images/breadbg1.jpg');max-height: 220px">
    <div class="container">
        <div class="breadcrumb-inner">
            <h2>CATEGORY ITEMS</h2>
            <a href="index.php">Home</a>
            <span>Category Items</span>
        </div>
    </div>
</section>
<section class="special-menu home-icon">
    <div class="icon-default">
        <img src="./images/scroll-arrow.png" alt="">
    </div>
    <?php
    session_start();
    if(isset($_SESSION['group_master'])){?>
        <div class="container" id="group_order" style="display: block">
            <h5 class="text-capitalize" style="text-align: center; color: #777620; margin-bottom: 20px; background-color: yellow">
                You are selecting Items for a Group Order, initiated by <b id="group_master_name"><?php echo $_SESSION['group_master']; ?></b> and TakeOut time is <b id="takeout_time"><?php echo $_SESSION['delivery_date']; ?></b>.
            </h5>
        </div>
    <?php } ?>
    <div class="container">
        <div class="portfolioContainer row" id="menus">

            <!--<div class="col-md-6 col-sm-6 col-xs-12 isotope-item dessert">
                <div class="menu-list">
                                        <span class="menu-list-product">
                                            <img src="../images/img81.png" alt="">
                                        </span>
                    <h5>CHInese Egg Cake <span>$ 15.00</span></h5>
                    <p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames</p>
                </div>
            </div>
            <div class="col-md-6 col-sm-6 col-xs-12 isotope-item dinner">
                <div class="menu-list">
                                        <span class="menu-list-product">
                                            <img src="../images/img82.png" alt="">
                                        </span>
                    <h5>Beef SpaghettI <span>$ 45.00</span></h5>
                    <p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames</p>
                </div>
            </div>

            -->
        </div>

    </div>
</section>
<!-- End Menu Part -->

<!-- End Discount Part -->


<script src="js/app.js"></script>
<script src="js/script.js"></script>
<script src="js/cart.js"></script>

<script>
    //alert(item_image_display)
    var width=''
    if(item_image_display=="display: none"){
        width='style="padding-left: 0px"'
    }

    var menus = location.search.split('category=')[1];
    menus = menus.split('__').join(' ')
	
    html_generator = function html_generator(data) {
        //alert(data['photo'])
        var html_op ='                <div class="col-md-4 col-sm-4 col-xs-12 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">\n' +
            '                    <div class="shop-main-list" style="background-color: #e4b95b; border-radius: 15px">\n' +
            '                        <div class="shop-product" style="border-radius: 15px 15px 0px 0px">\n' +
            '                            <img src="'+ project_url+'admin/'+data['photo']+'" alt=""style="height: 220px; width:100%">\n' +
            '                            <div class="cart-overlay-wrap" style="border-radius: 0px">\n' +
            '                                <div class="cart-overlay" >\n' +
            '                                    <p onclick="cart('+data['item_id']+','+data['rate']+')" class="shop-cart-btn">Add to Cart</p>\n' +
            '                                </div>\n' +
            '                            </div>\n' +
            '                        </div>\n' +
            '                                <a href="index.php?page=item&id='+ data['item_id']+'"><h5 class="text-capitalize">'+ data['name']+' <span style="color: white">'+ currency_symbol+''+data['rate']+'</span></h5></a>\n' +
            '                    </div>\n' +
            '                </div>\n'


        var html='<div class="col-md-6 col-sm-6 col-xs-12 isotope-item breakfast">\n' +
            '         <div class="menu-list" '+width+'>\n' +
            '              <span class="menu-list-product" style="'+ item_image_display +'">\n' +
            '                <img  src="'+ project_url+'admin/'+data['photo']+'" onclick="cart('+data['item_id']+','+data['rate_id']+')" alt="" style="">\n' +
            '              </span>\n' +
            '              <a href="index.php?page=item&id='+ data['item_id']+'">' +
            '                   <h5 class="text-capitalize margin-bottom-0 padding-bottom-4">'+ data['name']+' <span>'+ currency_symbol+''+data['price']+'</span></h5>' +
            '               </a>\n' +
            '              <p>'+ data['details']+'</p>\n' +
            '          </div>\n' +
            '        </div>\n'

        return html;

    }
    cart = function cart(id, rate_id){
        //gialert(price)

        $.ajax({
            url: "./includes/controller/ecommerceController.php",
            dataType: "json",
            type: "post",
            async:false,
            data: {
                q: "addToCart",
                item_id:id,
                quantity:1,
                rate_id:rate_id
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
                        html += '<div class="cart-item"><div class="cart-item-left"><img src="admin/images/item/'+datas.product_image+'" alt=""></div><div class="cart-item-right"><h6>'+datas.product_name+'</h6><span> '+datas.discounted_rate+' * '+datas.quantity+' = '+sub_total+'</span></div><span class="delete-icon" onclick="deleteProduct('+"'"+datas.cart_key+"'"+')"></span></div>';
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
                menu: menu,
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

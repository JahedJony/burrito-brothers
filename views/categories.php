<div class="main-part">
    <!-- Start Breadcrumb Part -->
    <section class="breadcrumb-part" data-stellar-offset-parent="true" data-stellar-background-ratio="0.5" style="background-image: url('../images/breadbg1.jpg');">
        <div class="container">
            <div class="breadcrumb-inner">
                <h2>SHOP</h2>
                <a href="#">Home</a>
                <span>Shop</span>
            </div>
        </div>
    </section>
    <!-- End Breadcrumb Part -->
    <section class="home-icon blog-main-section shop-page">
        <div class="icon-default">
            <img src="../images/scroll-arrow.png" alt="">
        </div>
        <div class="container" id="catagories">
            <!--<div class="portfolioContainer row" data-defaultfilter=".breakfast">
                <div class="col-md-3 col-sm-4 col-xs-12 breakfast dessert dinner wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                    <div class="shop-main-list">
                        <div class="shop-product">
                            <img src="../images/img56.png" alt="">
                            <div class="cart-overlay-wrap">
                                <div class="cart-overlay">
                                    <a href="#" class="shop-cart-btn">ADD TO CART</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-4 col-xs-12 breakfast dinner lunch wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                    <div class="shop-main-list">
                        <div class="shop-product">
                            <img src="../images/img57.png" alt="">
                            <div class="cart-overlay-wrap">
                                <div class="cart-overlay">
                                    <a href="#" class="shop-cart-btn">ADD TO CART</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-4 col-xs-12 breakfast dessert wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                    <div class="shop-main-list">
                        <div class="shop-product">
                            <img src="../images/img58.png" alt="">
                            <div class="cart-overlay-wrap">
                                <div class="cart-overlay">
                                    <a href="#" class="shop-cart-btn">ADD TO CART</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-4 col-xs-12 breakfast dinner wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                    <div class="shop-main-list">
                        <div class="shop-product">
                            <img src="../images/img59.png" alt="">
                            <div class="cart-overlay-wrap">
                                <div class="cart-overlay">
                                    <a href="#" class="shop-cart-btn">ADD TO CART</a>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="col-md-3 col-sm-4 col-xs-12 breakfast freshfood wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                    <div class="shop-main-list">
                        <div class="shop-product">
                            <img src="../images/img60.png" alt="">
                            <div class="cart-overlay-wrap">
                                <div class="cart-overlay">
                                    <a href="#" class="shop-cart-btn">ADD TO CART</a>
                                </div>
                            </div>
                        </div>
                        <a href="#"><h5>Paper Pouch</h5></a>
                        <h5><strong>$ 15.00</strong></h5>
                    </div>
                </div>
                <div class="col-md-3 col-sm-4 col-xs-12 breakfast lunch wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                    <div class="shop-main-list">
                        <div class="shop-product">
                            <img src="../images/img61.png" alt="">
                            <div class="cart-overlay-wrap">
                                <div class="cart-overlay">
                                    <a href="#" class="shop-cart-btn">ADD TO CART</a>
                                </div>
                            </div>
                        </div>
                        <a href="#"><h5>Paper Pouch</h5></a>
                        <h5><strong>$ 15.00</strong></h5>
                    </div>
                </div>
                <div class="col-md-3 col-sm-4 col-xs-12 breakfast freshfood wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                    <div class="shop-main-list">
                        <div class="shop-product">
                            <img src="../images/img62.png" alt="">
                            <div class="cart-overlay-wrap">
                                <div class="cart-overlay">
                                    <a href="#" class="shop-cart-btn">ADD TO CART</a>
                                </div>
                            </div>
                        </div>
                        <a href="#"><h5>Paper Pouch</h5></a>
                        <h5><strong>$ 15.00</strong></h5>
                    </div>
                </div>
                <div class="col-md-3 col-sm-4 col-xs-12 breakfast lunch wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                    <div class="shop-main-list">
                        <div class="shop-product">
                            <img src="../images/img63.png" alt="">
                            <div class="cart-overlay-wrap">
                                <div class="cart-overlay">
                                    <a href="#" class="shop-cart-btn">ADD TO CART</a>
                                </div>
                            </div>
                        </div>
                        <a href="#"><h5>Paper Pouch</h5></a>
                        <h5><strong>$ 15.00</strong></h5>
                    </div>
                </div>
            </div>-->
        </div>
    </section>
</div>

<script>
    load_category = function load_category() {
        $.ajax({
            url: project_url + "includes/controller/itemsController.php",
            dataType: "json",
            type: "post",
            async: false,
            data: {
                q: "category_view",
            },
            success: function (data) {
                //alert(data[0]['id'])
                var category_html=''
                for(var i=0 ; i<data.length; i++){
                    category_html= category_html+ categoryView(data[i])
                }
                $('#catagories').html(category_html)
                    //for  showing grid's no of records from total no of records
            }
        });
    }
    function categoryView(data){
        //alert(data['id'])
        var name = data['name'].split(' ').join('__')

        var html='                <div class="col-md-3 col-sm-4 col-xs-12 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">\n' +
            '                    <div class="shop-main-list" style="background-color: #8a6d3b; border-radius: 15px">\n' +
            '                        <div class="shop-product" style="border-radius: 15px 15px 0px 0px">\n' +
            '                            <img src="'+ project_url+'admin/'+data['photo']+'" alt="">\n' +
            '                            <div class="cart-overlay-wrap">\n' +
            '                                <div class="cart-overlay" >\n' +
            '                                    <a href="index.php?page=menu&category='+ name+'" class="shop-cart-btn">Choose Menu</a>\n' +
            '                                </div>\n' +
            '                            </div>\n' +
            '                        </div>\n' +
            '                        <a href="index.php?page=menu&category='+ name+'"><h5 style="text-transform: uppercase">'+ data['name']+'</h5></a>\n'+
            '                    </div>\n' +
            '                </div>\n'

        return html;

    }
    load_category()
</script>

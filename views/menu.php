
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
<script>
    var menus = location.search.split('category=')[1];
    menus = menus.split('__').join(' ')

    html_generator = function html_generator(data) {
        //alert(data['photo'])
        var html='<div class="col-md-4 col-sm-4 col-xs-12 isotope-item breakfast dinner wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">\n' +
            '                        <div class="menu-round" style="background-color: #8a6d3b; border-radius: 15px">\n' +
            '                            <div class="menu-round-img">\n' +
            '                                <img src="../admin/images/item/'+data['photo']+'" alt="" style="height: 220px; width:100%">\n' +
            '                            </div>\n' +
            '                            <div class="menu-round-info">\n' +
            '                                <a href="index.php?page=item&id='+ data['item_id']+'"><h5>'+ data['name']+' <span>'+data['rate']+'</span></h5></a>\n' +
            '                            </div>\n' +
            '                        </div>\n' +
            '                    </div>'

        return html;

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
                //alert(data[0]['item_id'])
                //alert('ok')
                //alert(data[0]['id'])
                var menu_html=''
                //alert(menu_html)
                for(var i=0 ; i<data.length; i++){
                    //alert(data.length)
                    menu_html = menu_html+ html_generator(data[i])

                }
                $('#menus').html(menu_html)
                //for  showing grid's no of records from total no of records
            }
        });
    }
    load_menu(menus)



</script>

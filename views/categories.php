 <section class="breadcrumb-part" data-stellar-offset-parent="true" data-stellar-background-ratio="0.5" style="background-image: url('../images/breadbg1.jpg');max-height: 220px">
    <div class="container">
            <div class="breadcrumb-inner">
                <h2>HOME CATEGORY</h2>
                <a href="index.php?page=home">Home</a>
                <span>Home Category</span>
            </div>
        </div>
 </section>
    <!-- End Breadcrumb Part -->
 <div class="modal fade booktable" id="cart_empty" tabindex="-1" role="dialog" aria-labelledby="booktable">
     <div class="modal-dialog" role="document">
         <div class="modal-content">
             <div class="modal-body">
                 <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                 <div class="table-title">
                     <h2></h2>
                     <h4 class="heade-xs">You have some items in your cart, would you like to empty your cart?</h4>
                 </div>
                 <div class="row">
                     <div class="col-md-6 col-sm-6 col-xs-6">
                         <button class="btn-main btn-small" id="delete_cart" style="border-radius: 8px">Delete Cart Items</button>
                     </div>
                     <div class="col-md-6 col-sm-6 col-xs-6">
                         <button class="btn-main btn-small" style="border-radius: 8px" class="close" data-dismiss="modal" >Keep Cart Items</button>
                     </div>
                 </div>
             </div>
         </div>
     </div>
 </div>


 <section class="home-icon blog-main-section shop-page">
        <div class="icon-default" >
            <img src="./images/scroll-arrow.png" alt="">
        </div>

     <?php
     session_start();
     if(isset($_SESSION['cart']))
        $cart_check = $_SESSION['cart'];

     if(isset($_SESSION['group_master'])){
     if(isset($cart_check)){
         if($cart_check!=[]){
             //echo 12;
             ?>
             <script>
                 $('#cart_empty').modal()
             </script>
         <?php
         }
     }
         ?>
     <div class="container" id="group_order" style="display: block">
         <h5 class="text-capitalize" style="text-align: center; color: #777620; margin-bottom: 20px; background-color: yellow">
             You are selecting Items for a Group Order, initiated by <b id="group_master_name"><?php echo $_SESSION['group_master']; ?></b> and TakeOut time is <b id="takeout_time"><?php echo $_SESSION['delivery_date']; ?></b>.
         </h5>
     </div>
     <?php } ?>
        <div class="container" id="catagories">
        </div>
    </section>

<script>
    $('#delete_cart').on('click', function () {
        //alert('sdf')
        $('#cart_empty').modal('hide');

        $.ajax({
            url: project_url + "includes/controller/groupController.php",
            dataType: "json",
            type: "post",
            async: false,
            data: {
                q: "check_cart",
            },
            success: function (data) {
                showCart()
            }
        })
    })


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
            '                    <div class="shop-main-list" style="background-color: #e4b95b; border-radius: 15px">\n' +
            '                        <div class="shop-product" style="border-radius: 15px 15px 0px 0px">\n' +
            '                            <img src="'+ project_url+'admin/'+data['photo']+'" alt="" style="border-radius: 17px 17px 17px 17px">\n' +
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

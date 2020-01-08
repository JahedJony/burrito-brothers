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

<section class="breadcrumb-part" data-stellar-offset-parent="true" data-stellar-background-ratio="0.5"
         style="background-image: url('../images/breadbg1.jpg');max-height: 220px" xmlns="http://www.w3.org/1999/html"
         xmlns="http://www.w3.org/1999/html">
    <div class="container">
        <div class="breadcrumb-inner">
            <h2>ITEM NAME</h2>
            <a href="index.php?page=home">Home</a>
            <span>Item name</span>
        </div>
    </div>
</section>
<section class="home-icon shop-cart bg-skeen" style="background-color: rgba(244,242,237,1)">
    <div class="icon-default icon-skeen">
        <img src="../images/scroll-arrow.png" alt="">
    </div>
    <div class="container">

          <div class="row">
               <div class="col-md-12 col-sm-12 col-xs-12 wow fadeInDown  tab-content" data-wow-duration="1000ms" data-wow-delay="300ms" >
                   <div class="col-md-8 col-sm-8 col-xs-12" id="option_body" style="background-color: white; border-radius: 12px 12px 0px 0px; padding-top: 25px; padding-bottom: 20px; margin-bottom: 10px">
                       <!--                      <h4>Item Name</h4>
                                             <input type="hidden" name="item_id[]" value="1" />
                                             <input type="hidden" name="item_rate[]" value="15" />
                                             <label>Item description Item description Item description Item descriptionItem description </label>

                                             //start option block

                                             <div class="col-md-12 col-sm-12 col-xs-12 " style="background-color: rgba(244,242,237,1); padding-top: 25px; padding-bottom: 20px; margin-top: 5px; margin-bottom: 10px">
                                                 //-- option id will come from DB
                                                 <div class="col-md-12 col-sm-12 col-xs-12 ">
                                                     <span style="font-size: 20px"><b>Choose cheese</b> </span><span>( Minimum 1)</span>
                                                 </div>
                                                 <input type="hidden" name="options[]" value="1" />
                                                 <input type="hidden" name="options_name[]" value="Choose Side" />
                                                 <input type="hidden" id="option_required_1" value="" />
                                                 <input type="hidden" id="option_maximum_1" value="" />
                                                 <input type="hidden" id="option_minimum_1" value="" />
                                                 <input type="hidden" id="select_no_1" value="" />
                                                 // start ingredient block
                                                 <div class="options-container col-md-12 col-sm-12 col-xs-12 " style="margin-top: 10px">
                                                     <div class="options-ingredient col-md-3 col-sm-4 col-xs-6" style="text-align: center; margin-top: 10px">
                                                         <input type="hidden"  class="ingredient_id"  value="1" />
                                                         <input type="hidden"  class="ingredient_rate"  value="3" />
                                                         <img src="http://burritobrothers.test/admin/images/category/noFood.png" alt="" style="border-radius: 5px; height: 80px; width: 80px">
                                                         <br><span>Option Name1</span>
                                                     </div>
                                                     <div class="options-ingredient col-md-3 col-sm-4 col-xs-6" style="text-align: center; margin-top: 10px">
                                                         <input type="hidden"  class="ingredient_id"  value="1" />
                                                         <input type="hidden"  class="ingredient_rate"  value="3" />
                                                         <img src="http://burritobrothers.test/admin/images/category/noFood.png" alt="" style="border-radius: 5px; height: 80px; width: 80px">
                                                         <br><span>Option Name1</span>
                                                     </div>
                                                     <div class="options-ingredient col-md-3 col-sm-4 col-xs-6" style="text-align: center; margin-top: 10px">
                                                         <input type="hidden"  class="ingredient_id"  value="1" />
                                                         <input type="hidden"  class="ingredient_rate"  value="3" />
                                                         <img src="http://burritobrothers.test/admin/images/category/noFood.png" alt="" style="border-radius: 5px; height: 80px; width: 80px">
                                                         <br><span>Option Name1</span>
                                                     </div>
                                                     <div class="options-ingredient col-md-3 col-sm-4 col-xs-6" style="text-align: center; margin-top: 10px">
                                                         <input type="hidden" class="ingredient_id"    value="2" />
                                                         <input type="hidden" class="ingredient_rate"  value="3" />
                                                         <img src="http://burritobrothers.test/admin/images/category/noFood.png" alt="" style="border-radius: 5px; height: 80px; width: 80px">
                                                         <br><span>Option Name1</span>
                                                     </div>
                                                     <div class="options-ingredient col-md-3 col-sm-4 col-xs-6" style="text-align: center; margin-top: 10px">
                                                         <input type="hidden"  class="ingredient_id"  value="1" />
                                                         <input type="hidden"  class="ingredient_rate"  value="3" />
                                                         <img src="http://burritobrothers.test/admin/images/category/noFood.png" alt="" style="border-radius: 5px; height: 80px; width: 80px">
                                                         <br><span>Option Name1</span>
                                                     </div>
                                                     <div class="options-ingredient col-md-3 col-sm-4 col-xs-6" style="text-align: center; margin-top: 10px">
                                                         <input type="hidden" class="ingredient_id"    value="2" />
                                                         <input type="hidden" class="ingredient_rate"  value="3" />
                                                         <img src="http://burritobrothers.test/admin/images/category/noFood.png" alt="" style="border-radius: 5px; height: 80px; width: 80px">
                                                         <br><span>Option Name1</span>
                                                     </div>
                                                 </div>
                                                 //   End ingredient
                                             </div>
                      -->
                       //  End option  -->

                   </div>
                   <div class="col-md-4 col-sm-4 col-xs-12 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms" style="position: sticky; alignment: right; float: right">
                        <div class="shop-checkout-right">
                            <label id="title_right" style="text-transform: capitalize; font-size: 20px"></label>
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <div class="col-md-9 col-sm-9 col-xs-9">Cheddar Cheese</div>
                                <div class="col-md-3 col-sm-3 col-xs-3">$5</div>
                            </div>
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <div class="col-md-9 col-sm-9 col-xs-9">14" Big Daddy With Cheese</div>
                                <div class="col-md-3 col-sm-3 col-xs-3">$5.50</div>
                            </div>
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <div class="col-md-9 col-sm-9 col-xs-9">Fresh Jalopenos</div>
                                <div class="col-md-3 col-sm-3 col-xs-3">$0.75</div>
                            </div>
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <div class="col-md-9 col-sm-9 col-xs-9">Tomato Tortilla</div>
                                <div class="col-md-3 col-sm-3 col-xs-3">$12.50</div>
                            </div>
                            <div class="col-md-12 col-sm-12 col-xs-12 checkout-total" style="align-content: baseline">
                            </div>
                            <div class="col-md-12 col-sm-12 col-xs-12 " >
                                <div class="col-md-9 col-sm-9 col-xs-9"><b>Total</b></div>
                                <div class="col-md-3 col-sm-3 col-xs-3"><b>$12.50</b></div>
                            </div>
                        </div>

                   </div>

               </div>
          </div>
    </div>
</section>

<script>
    var add_to_meal=function add_to_meal(option_id,option_name,ing_id,ing_rate,ing_name){
        alert(option_id+'-'+option_name+'-'+ing_id+'-'+ing_rate+'-'+ing_name)
        // array with item id// add the options details and ingredients

        // call a function to calculate and show the all options under the item
        //showItem();
    }


    $('.options-ingredient').on('click', function(){
        var option_id   = $(this).parent().attr('id');
        var option_name = $('#'+option_id+">h2").html();
        var ing_id   = $(this).find('ingredient_id').val();
        var ing_rate   = $(this).find('ingredient_rate').val();
        var ing_name   = $(this).find('h2').html();
        alert('ok')

        add_to_meal(option_id,option_name,ing_id,ing_rate,ing_name);
    })
    set_item_header = function set_item_header(data) {
        //alert(data['item_id'])
        $('#title_right').html(data['name'])
        var html='<h4  style="text-transform: uppercase;">'+data['name']+'</h4>\n' +
            '                       <input type="hidden" name="item_id[]" value="'+data['item_id']+'" />\n' +
            '                       <input type="hidden" name="item_rate[]" value="15" />\n' +
            '                       <label>'+data['details']+'</label>\n'
        return html;
    }
    set_ingredient = function set_ingredient(data){
        var html = '';
        $.each(data, function(i,datas){
            //alert(datas['id'])
            var price=' '
            if(datas['price']>0){
                price+= '('+currency_symbol+''+datas['price']+')'
            }
            html +='<div class="options-ingredient col-md-3 col-sm-4 col-xs-6" style="text-align: center; margin-top: 10px; height: 140px; overflow: hidden; border-width: 1px;">\n' +
                '       <input type="hidden" class="ingredient_id"    value="'+datas['id']+'" />\n' +
                '       <input type="hidden" class="ingredient_rate"  value="3" />\n' +
                '       <img src="http://burritobrothers.test/admin/images/category/noFood.png" alt="" style="border-radius: 5px; height: 80px; width: 80px">\n' +
                '       <br><span  style="text-transform: capitalize;">'+datas['name']+' '+price+'</span>\n' +
                '   </div>'
        });
        return html;
    }

    load_item_option = function load_item_option(){
    //alert('ok')
        $.ajax({
            url:"./includes/controller/itemsController.php",
            dataType: "json",
            type: "post",
            async:false,
            data: {
                q: "menu_options_view",
            },
            success: function(data){
                //alert('ok')
                //console.log(data['option'])
                //alert(data['item']['item_id'])
                var html = '';
                html+=set_item_header(data['item'])
                $.each(data['option'], function(i,datas){
                    console.log(datas)
                    var hints=''
                    if(datas['is_required']==1){
                        hints+='->Required '
                    }
                    if(datas['minimum_choice']>0){
                        hints+='->Minimum '+datas['minimum_choice']
                    }
                    if(datas['maximum_choice']>0){
                        hints+='->Maximum '+datas['maximum_choice']
                    }
                    if(hints==''){
                        hints+='->Additional'
                    }
                    html3='<div class="col-md-12 col-sm-12 col-xs-12 " style="background-color: rgba(244,242,237,1); padding-top: 25px; padding-bottom: 20px; margin-top: 5px; margin-bottom: 10px">\n' +
                        '       <!-- option id will come from DB  -->\n' +
                        '       <div class="col-md-12 col-sm-12 col-xs-12 ">\n' +
                        '             <span style="font-size: 20px; text-transform: capitalize"><b>'+datas['option_name']+'</b> </span><span>'+hints+'</span>\n' +
                        '       </div>\n' +
                        '       <input type="hidden" name="options[]" value="1" />\n' +
                        '       <input type="hidden" name="options_name[]" value="'+datas['option_name']+'" />\n' +
                        '       <input type="hidden" id="option_required_1" value="'+datas['is_required']+'" />\n' +
                        '       <input type="hidden" id="option_maximum_1" value="'+datas['maximum_choice']+'" />\n' +
                        '       <input type="hidden" id="option_minimum_1" value="'+datas['minimum_choice']+'" />\n' +
                        '       <input type="hidden" id="select_no_1" value="'+datas['option_id']+'" />'
                    html3 +=set_ingredient(datas['ingredient'][0])
                    html3 +='</div>\n' +
                        '  <!--   End ingredient  -->\n' +
                        '     </div>'
                    html+=html3;
                });
                //console.log(html)
                $('#option_body').html(html);

                //console.log('--------------')
                //alert(loyalty_points)
            }
        });
    }
    load_item_option()

</script>








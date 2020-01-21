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
               <div class="col-md-12 col-sm-12 col-xs-12 wow fadeInDown  tab-content" id="item_body" data-wow-duration="1000ms" data-wow-delay="300ms" >
                   <div class="col-md-8 col-sm-8 col-xs-12" id="option_body" style="background-color: white; border-radius: 12px 12px 0px 0px; padding-top: 25px; padding-bottom: 20px; margin-bottom: 10px">
                               <!--             <h4 class="col-md-10 col-sm-10 col-xs-10">Item Name</h4><p class="col-md-2 col-sm-2 col-xs-2">ssgdsfgdfsgfd</p>
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

                       //  End option  -->

                   </div>

                   <div class="col-md-4 col-sm-4 col-xs-12 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms" style="position: sticky; alignment: right; float: right">
                        <div class="shop-checkout-right">
                            <label id="title_right" style="text-transform: capitalize; font-size: 20px"></label>
                            <div id="ingredient_summary">
                                <!--
                                <div class="col-md-12 col-sm-12 col-xs-12 checkout-total" style="align-content: baseline; margin-top: 0px; padding: 0px">
                                    <b>Total</b>
                                </div>

                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <div class="col-md-9 col-sm-9 col-xs-9">Cheddar Cheese</div>
                                    <div class="col-md-3 col-sm-3 col-xs-3">$5</div>
                                </div>
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <div class="col-md-9 col-sm-9 col-xs-9">14" Big Daddy With Cheese</div>
                                    <div class="col-md-3 col-sm-3 col-xs-3">$5.50</div>
                                </div>

                                <div class="col-md-12 col-sm-12 col-xs-12 checkout-total" style="align-content: baseline; margin-top: 0px; padding: 0px">
                                    <b>Total</b>
                                </div>

                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <div class="col-md-9 col-sm-9 col-xs-9">Fresh Jalopenos</div>
                                    <div class="col-md-3 col-sm-3 col-xs-3">$0.75</div>
                                </div>
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <div class="col-md-9 col-sm-9 col-xs-9">Tomato Tortilla</div>
                                    <div class="col-md-3 col-sm-3 col-xs-3">$12.50</div>
                                </div>



                                -->

                                </div>

                            <div class="col-md-12 col-sm-12 col-xs-12 checkout-total" style="align-content: baseline"></div>
                            <div class="col-md-12 col-sm-12 col-xs-12 " >
                                <div class="col-md-9 col-sm-9 col-xs-9"><b>Sub Total</b></div>
                                <div class="col-md-3 col-sm-3 col-xs-3" id="total_price"><b>$00.00</b></div>
                            </div>
                            <button class="button-default button-default-submit" style="width: 100%; background-color: #e4b95b; color: white; margin-top: 15px" onclick="addToCart()"><b>Add to Cart</b></button>


                        </div>

                   </div>

               </div>
          </div>
    </div>
</section>

<script>
    var selected_ingredient={};
    var base_price=0;
    var total_price = 0;
    var selected_item_list={};
    var quantity=1;
    var item_id = location.search.split('?')[1].split('&')[1].split('=')[1];
    var item_choice_limit = {}
//alert(item_id)

    chose_summary= function  chose_summary() {
        //console.log(selected_ingredient)
        var html=''
        total_price=base_price;
        var ingredient_ids=''
        var ingredient_name=''

        $.each(selected_ingredient, function (i, data) {
            //alert(data['option_name'])
            if(i!='id_list' && i!='ingredient_name'){
                html+='<div class="col-md-12 col-sm-12 col-xs-12 checkout-total" style="align-content: baseline; margin-top: 0px; padding: 0px">\n' +
                    '       <b>'+data['option_name']+'</b>\n' +
                    '   </div>'
                $.each(data, function (j, ingredient) {
                    if(j!='option_name'){
                        html+='<div class="col-md-12 col-sm-12 col-xs-12">\n' +
                            '    <div class="col-md-9 col-sm-9 col-xs-9 text-capitalize">'+ingredient['name']+'</div>\n' +
                            '    <div class="col-md-3 col-sm-3 col-xs-3">'+currency_symbol+''+ingredient['price']+'</div>\n' +
                            '  </div>\n';
                        total_price+=+ingredient['price']
                        ingredient_ids+=','+j
                        ingredient_name+=ingredient['name']+', '
                    }

                })
            }

        })
        total_price=total_price.toFixed(2)
        //console.log(selected_ingredient)
        selected_ingredient['id_list']=ingredient_ids
        selected_ingredient['ingredient_name']= ingredient_name
        html+=' <div class="col-md-12 col-sm-12 col-xs-12 checkout-total" style="align-content: baseline; margin-top: 0px; padding: 0px"></div>\n' +
            '<div class="col-md-12 col-sm-12 col-xs-12 " >\n' +
            '       <div class="col-md-9 col-sm-9 col-xs-9"><b>Main Dish</b></div>\n' +
            '       <div class="col-md-3 col-sm-3 col-xs-3"><b>'+currency_symbol+''+total_price+'</b></div>\n' +
            '  </div>\n'+
            '    <div class="col-md-12 col-sm-12 col-xs-12 " >\n' +
            '       <div class="col-md-5 col-sm-5 col-xs-9"></div>\n' +
            '       <div class="col-md-4 col-sm-4 col-xs-9">X</div>\n' +
            '       <div class="col-md-3 col-sm-3 col-xs-3"><b>'+quantity+'</b></div>\n' +
            '  </div>\n'+
            ' <div class="col-md-12 col-sm-12 col-xs-12 checkout-total" style="align-content: baseline;margin-top: 0px; padding: 0px"></div>\n' +
            '<div class="col-md-12 col-sm-12 col-xs-12 " >\n' +
            '       <div class="col-md-9 col-sm-9 col-xs-9"><b>Price for Main Dish</b></div>\n' +
            '       <div class="col-md-3 col-sm-3 col-xs-3"><b>'+currency_symbol+''+total_price*quantity+'</b></div>\n' +
            '  </div>'
        var sub_total=total_price*quantity;



        $.each(selected_item_list, function (i, data) {
            //alert(i)
            html+='<div class="col-md-12 col-sm-12 col-xs-12 checkout-total text-capitalize" style="align-content: baseline; margin-top: 10px; padding: 0px">\n' +
                '       <b>'+i+'</b>\n' +
                '   </div>'
            $.each(data, function (i, single_item) {
                if(i!='category_name') {
                    html += '<div class="col-md-12 col-sm-12 col-xs-12">\n' +
                        '    <div class="col-md-8 col-sm-8 col-xs-9 text-capitalize" >' + single_item['name'] + '</div>\n' +
                        '    <div class="col-md-2 col-sm-2 col-xs-9">' + single_item['quantity'] + '</div>\n' +
                        '    <div class="col-md-2 col-sm-2 col-xs-3">' + currency_symbol + '' + single_item['price'] * single_item['quantity'] + '</div>\n' +
                        '  </div>\n';
                    sub_total += +(single_item['price'] * single_item['quantity'])
                }
            })

        })


        $('#ingredient_summary').html(html)
        $('#total_price').html(currency_symbol+''+sub_total.toFixed(2))

    }

    var add_to_meal=function add_to_meal(option_id,option_name,ing_id,ing_rate,ing_name){
        //alert(option_id+'-'+option_name+'-'+ing_id+'-'+ing_rate+'-'+ing_name)
        //var a={}
        if(selected_ingredient[option_id]){
            if(selected_ingredient[option_id][ing_id]){
                delete selected_ingredient[option_id][ing_id];
            }
            else{
                selected_ingredient[option_id][ing_id]={'name':ing_name, 'price':ing_rate}
            }
            //alert('ok')
        }
        else {
            selected_ingredient[option_id]={'option_name':option_name}
            selected_ingredient[option_id][ing_id]={'name':ing_name, 'price':ing_rate}
        }

        chose_summary()

    }

    var add_items=function add_items(item_id, item_name, category_name, quantity, item_price){
        //alert(item_id+'>'+item_name+'>'+category_name+'>'+quantity+'>'+item_price)

        if(selected_item_list[category_name]){

            if(selected_item_list[category_name][item_id]){
                delete selected_item_list[category_name][item_id];
            }
            else{
                selected_item_list[category_name][item_id]={'image':'noFood.png','item_id':item_id,'name':item_name, 'price':item_price , 'quantity':quantity}
            }
            //alert(category_name);

        }
        else {
            selected_item_list[category_name]={'category_name':category_name}
            selected_item_list[category_name][item_id]={'image':'noFood.png', 'item_id':item_id,'name':item_name, 'price':item_price, 'quantity':quantity}

        }
        //alert('item')
        //console.log(selected_item_list)
        chose_summary()
    }


    minusProd = function minusProd(id){
        //alert(id)
        id= 'item_'+id;
        //alert(id)
        //alert($('#'+id).val())
        quantity = parseInt($('#'+id).val())-1;
        $('#'+id).val(quantity)
        chose_summary()
    }

    addProd = function addProd(id){
        id= 'item_'+id;
        quantity = parseInt($('#'+id).val()) +1;
        $('#'+id).val(quantity)
        chose_summary()
    }

    set_item_header = function set_item_header(data) {
        //alert(data['item_id'])
        base_price=parseFloat(data['price']);
        $('#total_price').html(currency_symbol+''+base_price)

        $('#title_right').html(data['name'])
        var html='<div  class="col-md-8 col-sm-12 col-xs-12"><h4 style="text-transform: uppercase;" id="item_name">'+data['name']+'</h4></div>' +
            '     <div class="price-textbox col-md-2 col-sm-9 col-xs-9" style="text-align: right">\n' +
            '           <span class="minus-text" onclick="minusProd('+data['item_id']+')" style="padding-left: 15px;"><i class="icon-minus"></i></span>\n' +
            '           <input name="quantity[]" id="item_'+data['item_id']+'" placeholder="1" type="text" value="1">\n' +
            '           <span class="plus-text" onclick="addProd('+data['item_id']+')" style="padding-right: 15px"><i class="icon-plus"></i></span>\n' +
            '     </div>\n'+
            '     <div class="col-md-1 col-sm-3 col-xs-3"><p  style="text-align: right;color: #0f3e68">'+currency_symbol+'<b>'+data['price']+'</b></p></div>\n' +
            '        <input type="hidden" name="item_id[]" id="item_id" value="'+data['item_id']+'" />\n' +
            '        <input type="hidden" name="item_rate[]" value="15" />\n' +
            '     <div class="col-md-12 col-sm-12 col-xs-12"><label>'+data['details']+'</label></div>\n'

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
            html+='    <div class="options-ingredient col-md-3 col-sm-4 col-xs-6" style="text-align: center; margin-top: 10px; height: 140px; overflow: hidden; border-width: 1px;">\n' +
                '       <input type="hidden" class="ingredient_id"    value="'+datas['id']+'" />\n' +
                '       <input type="hidden" class="ingredient_rate"  value="'+datas['price']+'" />\n' +
                '       <input type="hidden" class="ingredient_name"  value="'+datas['name']+'" />\n' +
                '                    <div class="shop-main-list" style=" border-radius: 15px">\n' +
                '                        <div class="shop-product" style="border-radius: 15px 15px 0px 0px; margin-bottom: 0px; padding-bottom: 0px">\n' +
                '                            <img src="http://burritobrothers.test/admin/images/category/noFood.png" alt="" style="border-radius: 17px 17px 17px 17px; height: 90px; width: 110px">\n' +
                '                            <div class="cart-overlay-wrap" style="background-color: #372727; opacity: .5" >\n' +
                '                                <div class="cart-overlay" >\n' +
                '                                    <i class="fa fa-check" style="font-size:48px;color: white; opacity: 1"></i>\n\n' +
                '                                </div>\n' +
            '                            </div>\n' +
                '                        </div>\n' +
                '                       <br><span  style="text-transform: capitalize; padding-top: 0px; margin-top: 0px">'+datas['name']+' '+price+'</span>\n' +
                '                    </div>\n' +
                '                </div>\n'

            /* html+='<div class="options-ingredient col-md-3 col-sm-4 col-xs-6" style="text-align: center; margin-top: 10px; height: 140px; overflow: hidden; border-width: 1px;">\n' +
                '       <input type="hidden" class="ingredient_id"    value="'+datas['id']+'" />\n' +
                '       <input type="hidden" class="ingredient_rate"  value="'+datas['price']+'" />\n' +
                '       <input type="hidden" class="ingredient_name"  value="'+datas['name']+'" />\n' +
                '       <img src="http://burritobrothers.test/admin/images/category/noFood.png" alt="" style="border-radius: 5px; height: 80px; width: 80px">\n' +
                '       <br><span  style="text-transform: capitalize;">'+datas['name']+' '+price+'</span>\n' +
                '   </div
                */
        });
       // alert(html)
        //console.log(html)
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
                item_id:item_id
            },
            success: function(data){
                //alert('ok')
                //console.log(data)
                //alert(data['item']['item_id'])
                var html = '';
                html+=set_item_header(data['item'])
                $.each(data['option'], function(i,datas){
                    //console.log(datas)
                    var hints=''
                    if(datas['is_required']==1){
                        hints+='  (Required)'
                    }
                    item_choice_limit[datas['option_id']]={}
                    item_choice_limit[datas['option_id']]['maximum']=datas['maximum_choice'];
                    item_choice_limit[datas['option_id']]['minimum']=datas['minimum_choice'];

                    console.log(item_choice_limit)

                    html3='<div class="col-md-12 col-sm-12 col-xs-12 option-div" name="option_div" style="background-color: rgba(244,242,237,1); padding-top: 25px; padding-bottom: 20px; margin-top: 5px; margin-bottom: 10px">\n' +
                        '       <!-- option id will come from DB  -->\n' +
                        '       <div class="col-md-12 col-sm-12 col-xs-12 ">\n' +
                        '             <span style="font-size: 20px; text-transform: capitalize"><b>'+datas['option_name']+'</b> </span><span>'+hints+'</span>\n' +
                        '       </div>\n' +
                        '       <input type="hidden" name="options[]" value="'+datas['option_id']+'" />\n' +
                        '       <input type="hidden" name="options_name[]" value="'+datas['option_name']+'" />\n' +
                        '       <input type="hidden" name="option_selected[]" value="0" />\n' +
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
                $('#option_body').html(html);

                var html_side=''
                $.each(data['side_item'], function (i,datas) {
                    //console.log(datas[i])
                    html_side+='<div class="col-md-8 col-sm-8 col-xs-12" id="additional_items" style="background-color: white; padding-top: 25px; padding-bottom: 20px; margin-bottom: 15px">\n' +
                        '           <div  class="col-md-12 col-sm-12 col-xs-12"><h4 style="text-transform: uppercase;" id="item_name">'+i+'</h4></div>\n'+
                        '           <div class="col-md-12 col-sm-12 col-xs-12 option-div"  style="background-color: rgba(244,242,237,1); padding-top: 25px; padding-bottom: 20px; margin-top: 5px; margin-bottom: 10px">'

                        $.each(datas, function (j, items) {
                        html_side+= '<div class="additional_items col-md-3 col-sm-4 col-xs-6" style="text-align: center; margin-top: 10px; height: 140px; overflow: hidden; border-width: 1px;">\n' +
                            '       <input type="hidden" class="item_id"    value="'+items['item_id']+'" />\n' +
                            '       <input type="hidden" class="item_rate"  value="'+items['price']+'" />\n' +
                            '       <input type="hidden" class="item_name"  value="'+items['name']+'" />\n' +
                            '       <input type="hidden" class="category_name"  value="'+i+'" />\n' +
                            '                    <div class="shop-main-list" style=" border-radius: 15px">\n' +
                            '                        <div class="shop-product" style="border-radius: 15px 15px 0px 0px; margin-bottom: 0px; padding-bottom: 0px">\n' +
                            '                            <img src="http://burritobrothers.test/admin/images/category/noFood.png" alt="" style="border-radius: 17px 17px 17px 17px; height: 90px; width: 110px">\n' +
                            '                            <div class="cart-overlay-wrap" style="background-color: #372727; opacity: .5" >\n' +
                            '                                <div class="cart-overlay" >\n' +
                            '                                    <i class="fa fa-check" style="font-size:48px;color: white; opacity: 1"></i>\n\n' +
                            '                                </div>\n' +
                            '                            </div>\n' +
                            '                        </div>\n' +
                            '                       <br><span  style="text-transform: capitalize; padding-top: 0px; margin-top: 0px">'+items['name']+' '+currency_symbol+' '+items['price']+'</span>\n' +
                            '                    </div>\n' +
                            '                </div>\n'


                    })
                    html_side+='</div></div>'
                })

                $('#item_body').html($('#item_body').html()+html_side)

            }
        });
    }
    load_item_option()


    $('.options-ingredient').on('click', function(){
//alert($(this).find('.cart-overlay-wrap').hasClass('selected_ingredient'))
        if($(this).find('.cart-overlay-wrap').hasClass('selected_ingredient')){
            //alert('ok')
            $(this).find('.cart-overlay-wrap').removeClass('selected_ingredient')
            //$('this').removeClass("selected_ingredient")
        }
        else{
            //alert('orek')
            $(this).find('.cart-overlay-wrap').addClass('selected_ingredient')

            //$('this').addClass("selected_ingredient")
        }
        //alert($(this).find('h4:eq(0)').html();)
        var option_id = $(this).siblings('input:eq(0)').val();
        var option_name = $(this).siblings('input:eq(1)').val()
        var option_selected = $(this).siblings('input:eq(2)').val()
        var ing_id   = $(this).find('input:eq(0)').val();
        var ing_rate   = $(this).find('input:eq(1)').val();
        var ing_name   = $(this).find('input:eq(2)').val();
        add_to_meal(option_id,option_name,ing_id,ing_rate,ing_name);


    })

    $('.additional_items').on('click', function(){


        if($(this).find('.cart-overlay-wrap').hasClass('selected_ingredient')){
            //alert('ok')
            $(this).find('.cart-overlay-wrap').removeClass('selected_ingredient')
            //$('this').removeClass("selected_ingredient")
        }
        else{
            //alert('orek')
            $(this).find('.cart-overlay-wrap').addClass('selected_ingredient')

            //$('this').addClass("selected_ingredient")
        }

        var item_id = $(this).children('input:eq(0)').val();
        var item_name = $(this).children('input:eq(2)').val()
        var item_price = $(this).children('input:eq(1)').val()
        var category_name = $(this).children('input:eq(3)').val()
        var quantity = 1

        //alert(item_id+'>'+item_name+'>'+category_name+'>'+quantity+'>'+item_price)
        add_items(item_id, item_name, category_name, quantity, item_price)

        //add_to_meal(option_id,option_name,ing_id,ing_rate,ing_name);


    })
    addToCart = function addToCart(){

        //console.log(selected_item_list)

        $.ajax({
            url: "./includes/controller/ecommerceController.php",
            dataType: "json",
            type: "post",
            async:false,
            data: {
                q: "addToCart",
                item_id: $('#item_id').val(),
                item_name: $('#item_name').html(),
                item_image: 'noFood.png',
                orignal_rate: total_price,
                discounted_rate: total_price,
                size: 1,
                quantity : quantity,
                ingredient: selected_ingredient,
                selected_item_list: selected_item_list
            },
            success: function(data) {
                alert(1)
                alert(data)
               // console.log(data)
                if(!jQuery.isEmptyObject(data.records)){
                    var html = '';
                    var total = 0;
                    var sub_total = 0;
                    var count =0
                    /*$.each(data.records, function(i,datas){
                        sub_total += parseFloat(datas.discounted_rate)*(datas.quantity);
                        html += '<div class="cart-item"><div class="cart-item-left"><img src="admin/images/item/'+datas.product_image+'" alt=""></div><div class="cart-item-right"><h6>'+datas.product_name+'</h6><span> '+datas.discounted_rate+' * '+datas.quantity+' = '+sub_total+'</span></div><span class="delete-icon" onclick="deleteProduct('+"'"+datas.cart_key+"'"+')"></span></div>';
                        count++;
                        total += sub_total ;
                    });
                    total = total.toFixed(2);
                    html += '<div class="subtotal"><div class="col-md-6 col-sm-6 col-xs-6"><h6>Subtotal :</h6></div><div class="col-md-6 col-sm-6 col-xs-6"><span>Tk '+total+'</span></div></div>';
                    html  += '<div class="cart-btn"><a href="cart.php" class="btn-main checkout">VIEW ALL</a><a href="checkout.php" class="btn-main checkout">CHECK OUT</a></div>';
                    $('#total_product_in_cart').html(count);*/
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


</script>







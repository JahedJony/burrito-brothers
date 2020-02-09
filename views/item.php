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
$order_id = '';
if(isset($_GET['order_id']) && $_GET['order_id']!="") $order_id =  $_GET['order_id'];
?>

<section class="breadcrumb-part" data-stellar-offset-parent="true" data-stellar-background-ratio="0.5"
         style="background-image: url('./images/breadbg1.jpg');max-height: 220px" xmlns="http://www.w3.org/1999/html"
         xmlns="http://www.w3.org/1999/html">
    <div class="container">
        <div class="breadcrumb-inner">
            <h2>ITEM NAME</h2>
            <a href="index.php">Home</a>
            <span>Item name</span>
        </div>
    </div>
</section>
<section class="home-icon shop-cart bg-skeen" style="background-color: rgba(244,242,237,1)">
    <div class="icon-default icon-skeen">
        <img src="./images/scroll-arrow.png" alt="">
    </div>
    <?php
    if(isset($_SESSION['group_master'])){?>
        <div class="container" id="group_order" style="display: block">
            <h5 class="text-capitalize" style="text-align: center; color: #777620; margin-bottom: 20px; background-color: yellow">
                You are selecting Items for a Group Order, initiated by <b id="group_master_name"><?php echo $_SESSION['group_master']; ?></b> and TakeOut time is <b id="takeout_time"><?php echo $_SESSION['delivery_date']; ?></b>.
            </h5>
        </div>
    <?php } ?>
    <div class="container">
          <div class="row">
               <div class="col-md-12 col-sm-12 col-xs-12 wow fadeInDown  tab-content" id="item_body" data-wow-duration="1000ms" data-wow-delay="300ms" >
                   <div class="col-md-8 col-sm-8 col-xs-12" id="option_body" style="background-color: white; border-radius: 12px 12px 0px 0px; padding-top: 25px; padding-bottom: 20px; margin-bottom: 10px">
                   </div>
                   <div class="col-md-4 col-sm-4 col-xs-12 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms" style="position: sticky; alignment: right; float: right">
                       <div class="shop-checkout-right" style="margin-bottom: 10px">
                           <label>Special Instruction</label>
                           <textarea class="form-control" rows="5" style="padding-bottom: 0px; margin-bottom: 0px" id="special_instruction"></textarea>
                       </div>
                       <div class="shop-checkout-right" >
                            <label id="title_right" style="text-transform: capitalize;"></label>
                            <div id="ingredient_summary"></div>
                            <div class="col-md-12 col-sm-12 col-xs-12 checkout-total" style="align-content: baseline"></div>
                            <div class="col-md-12 col-sm-12 col-xs-12 " >
                                <div class="col-md-9 col-sm-9 col-xs-9"><b>Sub Total</b></div>
                                <div class="col-md-3 col-sm-3 col-xs-3" id="total_price"><b>$00.00</b></div>
                            </div>

                           <button class="button-default button-default-submit" style="width: 100%; background-color: #e4b95b; color: white; margin-top: 15px" onclick="addToCart()"><b>Add to Cart</b></button>
                           <div id="select_ingredinet" class="text-center" style="display:none"></div>
                           <div id="select_side" class="text-center" style="display:none"></div>

                       </div>
                   </div>
               </div>
          </div>
    </div>
</section>

<section>

    <div class="modal fade " id="cart_confirmation" tabindex="-2" role="dialog" aria-labelledby="booktable">
        <div class="modal-dialog modal-sm" role="document" style="max-width: 90% ">
            <div class="modal-content">
                <div class="modal-body" style="padding-left: 0px; padding-right: 0px">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>

                    <div id="order-div">
                        <div class="title text-center">
                            <h4 class="text-coffee left">Your Items Has Been Added To Cart<span id="ord_title_vw"></span></h4>
                        </div>
                        <div class="buttons_wrapper" style="padding-bottom: 15px">
                            <div class="col-md-6 col-sm-6 col-xs-6 text-right" style="">
                                <button type="button" class="btn-main btn-small btn-primary" style="border-radius: 4px"><a href="index.php?page=categories" style="color: white">Select More Items</a></button>
                            </div>
                            <div class="col-md-6 col-sm-6 col-xs-6">
                                <button type="button" class="btn-main btn-small btn-primary" style="border-radius: 4px" ><a href="index.php?page=cart" style="color: white">Proceed to Cart</a></button>

                            </div>
                        </div>
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
    var item_choice_limit = {} //limit for ingredient selection in a option group like
    var choosed_ingredient_number = {}
    var cart_side_check=0
    var select_ingredinet_check = 1;


    chose_summary= function  chose_summary() {
        cart_side_check=0;
        select_ingredinet_check = 1;
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
        if(selected_ingredient[option_id]){
            if(selected_ingredient[option_id][ing_id]){
                choosed_ingredient_number[option_id] = choosed_ingredient_number[option_id]-1;
                delete selected_ingredient[option_id][ing_id];
            }
            else{
                if(item_choice_limit[option_id]['maximum']>choosed_ingredient_number[option_id] || item_choice_limit[option_id]['maximum']==0){
                    choosed_ingredient_number[option_id] = choosed_ingredient_number[option_id]+1;
                    selected_ingredient[option_id][ing_id]={'name':ing_name, 'price':ing_rate}
                }
                else{
                    return 0;
                }
            }
        }
        else {
            choosed_ingredient_number[option_id] = 1;
            selected_ingredient[option_id]={'option_name':option_name}
            selected_ingredient[option_id][ing_id]={'name':ing_name, 'price':ing_rate}
        }

        chose_summary()
        return 1;

    }

    var add_items=function add_items(item_id, item_name, category_name, quantity, item_price){

        if(selected_item_list[category_name]){
            if(selected_item_list[category_name][item_id]){
                delete selected_item_list[category_name][item_id];
                if(Object.keys(selected_item_list[category_name]).length>0){
                    delete selected_item_list[category_name];
                }
            }
            else{
                selected_item_list[category_name][item_id]={'image':'noFood.png','item_id':item_id,'name':item_name, 'price':item_price , 'quantity':quantity}
            }
        }
        else {
            selected_item_list[category_name]={'category_name':category_name}
            selected_item_list[category_name][item_id]={'image':'noFood.png', 'item_id':item_id,'name':item_name, 'price':item_price, 'quantity':quantity}
        }
        console.log(selected_item_list)
        chose_summary()
    }

    // Reduce the number of main menu
    minusProd = function minusProd(id){
        id= 'item_'+id;
        quantity = parseInt($('#'+id).val())-1;
        $('#'+id).val(quantity)
        chose_summary()
    }

    // add the number of main menu
    addProd = function addProd(id){
        id= 'item_'+id;
        quantity = parseInt($('#'+id).val()) +1;
        $('#'+id).val(quantity)
        chose_summary()
    }

    //Set the header for the main menu like name, id, quantity  minimum price etc
    set_item_header = function set_item_header(data) {
        base_price=parseFloat(data['price']);
        $('#total_price').html(currency_symbol+''+base_price)

        $('#title_right').html(data['name'])
        var html='<div class="row"><div  class="col-md-8 col-sm-6 col-xs-7"><h4 style="text-transform: uppercase;" id="item_name">'+data['name']+' ('+currency_symbol+'<b>'+data['price']+')</b></h4></div>' +
            '     <div class="price-textbox price-textbox-item col-md-2 col-sm-6 col-xs-5" style="text-align: right">\n' +
            '           <span class="minus-text" onclick="minusProd('+data['item_id']+')" style="padding-left: 15px;"><i class="icon-minus"></i></span>\n' +
            '           <input name="quantity[]" id="item_'+data['item_id']+'" placeholder="1" type="text" value="1">\n' +
            '           <span class="plus-text" onclick="addProd('+data['item_id']+')" style="padding-right: 15px"><i class="icon-plus"></i></span>\n' +
            '     </div></div>\n'+
           
            '        <input type="hidden" name="item_id[]" id="item_id" value="'+data['item_id']+'" />\n' +
            '        <input type="hidden" name="item_rate[]" value="15" />\n' +
            '     <div class="col-md-12 col-sm-12 col-xs-12"><label>'+data['details']+'</label></div>\n'

        return html;
    }

    // Set all ingredient list for the main menu on basis of a category like 'choose a cheese'
    set_ingredient = function set_ingredient(data){
        var html = '';

        $.each(data, function(i,datas){
            var price=' '
            if(datas['price']>0){
                price+= '+'+currency_symbol+''+datas['price']
            }
            if(ingredient_image_display=="display: none"){
                var img = ' <div class="shop-main-list" style=" border-radius: 15px">\n' +
                    '                        <div class="shop-product" style="border-radius: 15px 15px 0px 0px; color:  ">\n' +
                    '                            <div class="text-capitalize bold" style="background-color: #D2B48C ;border-radius: 17px 17px 17px 17px; height: 90px; max-width: 120px; display: flex; justify-content: center; align-items: center; color: white">'+datas['name']+'</br>'+price+'</div>\n' +
                    '                            <div class="cart-overlay-wrap" style="background-color: #372727; opacity: .5; max-width: 120px" >\n' +
                    '                                <div class="cart-overlay" >\n' +
                    '                                    <i class="fa fa-check" style="font-size:48px;color: white; opacity: 1"></i>\n\n' +
                    '                                </div>\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </div>'
            }else {
                var img ='           <div class="shop-main-list" style=" border-radius: 15px">\n' +
                    '                        <div class="shop-product" style="border-radius: 15px 15px 0px 0px; margin-bottom: 0px; padding-bottom: 0px">\n' +
                    '                            <img src="'+project_url+'admin/images/category/noFood.png" alt="" style="border-radius: 17px 17px 17px 17px;">\n' +
                    '                            <div class="cart-overlay-wrap" style="background-color: #372727; opacity: .5" >\n' +
                    '                                <div class="cart-overlay" >\n' +
                    '                                    <i class="fa fa-check" style="font-size:48px;color: white; opacity: 1"></i>\n\n' +
                    '                                </div>\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                       <br><span  style="text-transform: capitalize; padding-top: 0px; margin-top: 0px">'+datas['name']+' '+price+'</span>\n' +
                    '                    </div>\n'
            }

            html+='    <div class="options-ingredient col-md-3 col-sm-4 col-xs-6" style="text-align: center; margin-top: 10px; height: 150px; overflow: hidden; border-width: 1px;">\n' +
                '       <input type="hidden" class="ingredient_id"    value="'+datas['id']+'" />\n' +
                '       <input type="hidden" class="ingredient_rate"  value="'+datas['price']+'" />\n' +
                '       <input type="hidden" class="ingredient_name"  value="'+datas['name']+'" />\n' + img +
                '                </div>'

        });
        return html;
    }

    // set the ingredient category header for the main menu
    load_item_option = function load_item_option(){
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

                var html = '';
                html+=set_item_header(data['item'])
                $.each(data['option'], function(i,datas){
                    //console.log(datas)
                    var hints=''
                    if(parseInt(datas['is_required'])==1 || parseInt(datas['minimum_choice'])>=1){
                        if(parseInt(datas['maximum_choice'])>0){
                            hints+='  (Required: Max-'+parseInt(datas['maximum_choice'])+')'
                        }else {
                            hints+='  (Required)'
                        }
                    }else {
                        if(parseInt(datas['maximum_choice'])>0){
                            hints+='  (Max-'+parseInt(datas['maximum_choice'])+')'
                        }else {
                            hints+='  (Max- Unlimited)'
                        }
                    }

                    choosed_ingredient_number[datas['option_id']]=0
                    item_choice_limit[datas['option_id']]={}
                    item_choice_limit[datas['option_id']]['maximum']=datas['maximum_choice'];
                    item_choice_limit[datas['option_id']]['minimum']=datas['minimum_choice'];
                    item_choice_limit[datas['option_id']]['required']=datas['is_required'];
                    item_choice_limit[datas['option_id']]['name']=datas['option_name'];

                    html3='<div class="col-md-12 col-sm-12 col-xs-12 option-div" name="option_div" style="background-color: rgba(244,242,237,1); padding-top: 25px; padding-bottom: 20px; margin-top: 5px; margin-bottom: 10px">\n' +
                        '       <!-- option id will come from DB  -->\n' +
                        '       <div class="col-md-12 col-sm-12 col-xs-12 left-padding-0 ">\n' +
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
                        '     </div>'
                    html+=html3;
                });
                $('#option_body').html(html);

                var html_side=''

                //this portion will load the side items like brevarage
                $.each(data['side_item'], function (i,datas) {
                    //console.log(datas[i])
                    html_side+='<div class="col-md-8 col-sm-8 col-xs-12" id="additional_items" style="background-color: white; padding-top: 25px; padding-bottom: 20px; margin-bottom: 15px">\n' +
                        '           <div  class="col-md-12 col-sm-12 col-xs-12"><h4 style="text-transform: uppercase;" id="item_name">'+i+'</h4></div>\n'+
                        '           <div class="col-md-12 col-sm-12 col-xs-12 option-div"  style="background-color: rgba(244,242,237,1); padding-top: 25px; padding-bottom: 20px; margin-top: 5px; margin-bottom: 10px">'





                    $.each(datas, function (j, items) {
                        if(ingredient_image_display=="display: none"){
                            var img = ' <div class="shop-main-list" style=" border-radius: 15px">\n' +
                                '                        <div class="shop-product" style="border-radius: 15px 15px 0px 0px; color:  ">\n' +
                                '                            <div class="text-capitalize bold" style="background-color: #D2B48C ;border-radius: 17px 17px 17px 17px; height: 90px; width: 110px; display: flex; justify-content: center; align-items: center; color: white">'+items['name']+' '+currency_symbol+' '+items['price']+'</div>\n' +
                                '                            <div class="cart-overlay-wrap" style="background-color: #372727; opacity: .5; width: 110px" >\n' +
                                '                                <div class="cart-overlay" >\n' +
                                '                                    <i class="fa fa-check" style="font-size:48px;color: white; opacity: 1"></i>\n\n' +
                                '                                </div>\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                    </div>'
                        }else {
                            var img ='           <div class="shop-main-list" style=" border-radius: 15px">\n' +
                                '                        <div class="shop-product" style="border-radius: 15px 15px 0px 0px; margin-bottom: 0px; padding-bottom: 0px">\n' +
                                '                            <img src="'+project_url+'admin/images/category/noFood.png" alt="" style="border-radius: 17px 17px 17px 17px; height: 90px; width: 110px">\n' +
                                '                            <div class="cart-overlay-wrap" style="background-color: #372727; opacity: .5" >\n' +
                                '                                <div class="cart-overlay" >\n' +
                                '                                    <i class="fa fa-check" style="font-size:48px;color: white; opacity: 1"></i>\n\n' +
                                '                                </div>\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                       <br><span  style="text-transform: capitalize; padding-top: 0px; margin-top: 0px">'+items['name']+' '+currency_symbol+' '+items['price']+'</span>\n' +
                                '                    </div>\n'
                        }


                        html_side+= '<div class="additional_items col-md-3 col-sm-4 col-xs-6" style="text-align: center; margin-top: 10px; height: 140px; overflow: hidden; border-width: 1px;">\n' +
                            '       <input type="hidden" class="item_id"    value="'+items['item_id']+'" />\n' +
                            '       <input type="hidden" class="item_rate"  value="'+items['price']+'" />\n' +
                            '       <input type="hidden" class="item_name"  value="'+items['name']+'" />\n' +
                            '       <input type="hidden" class="category_name"  value="'+i+'" />\n' + img+
                            '                </div>\n'
                    })
                    html_side+='</div></div>'
                })

                $('#item_body').html($('#item_body').html()+html_side)
            }
        });
    }
    load_item_option()

    // Ingredient add or remove
    $('.options-ingredient').on('click', function(){

        if($(this).find('.cart-overlay-wrap').hasClass('selected_ingredient')){
            $(this).find('.cart-overlay-wrap').removeClass('selected_ingredient')
        }
        else{
            $(this).find('.cart-overlay-wrap').addClass('selected_ingredient')
        }
        var option_id = $(this).siblings('input:eq(0)').val();
        var option_name = $(this).siblings('input:eq(1)').val()
        var option_selected = $(this).siblings('input:eq(2)').val()
        var ing_id   = $(this).find('input:eq(0)').val();
        var ing_rate   = $(this).find('input:eq(1)').val();
        var ing_name   = $(this).find('input:eq(2)').val();
        if(add_to_meal(option_id,option_name,ing_id,ing_rate,ing_name)==0){
            $(this).find('.cart-overlay-wrap').removeClass('selected_ingredient')
        }
    })

    //additional items like breverage add or remove
    $('.additional_items').on('click', function(){

        if($(this).find('.cart-overlay-wrap').hasClass('selected_ingredient')){
            $(this).find('.cart-overlay-wrap').removeClass('selected_ingredient')
        }
        else{
            $(this).find('.cart-overlay-wrap').addClass('selected_ingredient')
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

        //check if any Mendatory field is not selected
        $.each(choosed_ingredient_number, function (j, ingredient) {
            if(parseInt(item_choice_limit[j]['minimum'])>parseInt(ingredient) || parseInt(item_choice_limit[j]['required'])>parseInt(ingredient)){
                success_or_error_msg('#select_ingredinet','danger',"Please Select "+item_choice_limit[j]['name']+" ","#side_order");
                select_ingredinet_check = 0;
                return false;
            }
        });

        //if((Object.keys(selected_item_list).length!=0 || cart_side_check!=0)  && select_ingredinet_check==1){
            //alert('cart_side_check')
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
                    selected_item_list: selected_item_list,
                    special_instruction: $('#special_instruction').val()
                },
                success: function(data) {
                    $('#cart_confirmation').modal()
                }
            });
       // }
        else if(Object.keys(selected_item_list).length==0 && select_ingredinet_check!=0){
            success_or_error_msg('#select_side','warning',"You did not select any BEVERAGE ","#side_order");
            cart_side_check=1
       }
        showCart()
    }

    //reset the page after added to cart
    $('#cart_confirmation').on('hidden.bs.modal', function () {
        window.location.reload(true);
    })



</script>







function showCart(){
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
            if(!jQuery.isEmptyObject(data.records)){
                var html = '';
                var total = 0;
                var sub_total = 0;
                var count =0
                $.each(data.records, function(i,datas){
                    //alert(datas.item_image)

                    sub_total += parseFloat(datas.discounted_rate)*(datas.quantity);
                    html += '<div class="cart-item"><div class="cart-item-left"><img src="/admin/images/item/'+datas.item_image+'" alt=""></div><div class="cart-item-right"><h6>'+datas.item_name+'</h6><span> '+datas.discounted_rate+' * '+datas.quantity+' = '+sub_total+'</span></div><span class="delete-icon" onclick="deleteItem('+"'"+datas.cart_key+"'"+')"></span></div>';
                    count++;
                    total += sub_total ;
                });
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

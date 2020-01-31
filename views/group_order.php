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


<section class="home-icon shop-cart row  alert-warning" style="padding-top: 0px; margin-top: 0px">
    <form method="POST"  id="group_order" onsubmit=" return false;" name="group_order"  enctype="multipart/form-data">
        <div class="container  col-md-12 col-sm-12 col-xs-12">
            <input type="hidden" name="id_group" id="id_group" value="">
        <div class="col-md-6 col-sm-12 col-xs-12"  style="max-width:100%" >
            <h5 style="text-align: center"> Group Information </h5>
            <hr>
            <input type="text" placeholder="Enter A Name for your Group" list="group_names" name="group_name" id="group_name" />
            <datalist id="group_names"></datalist>
            <table class="table table-bordered" style="padding: 0px" id="member_table">
                <thead>
                <tr>
                    <th width="40%" align="center">Name</th>
                    <th align="center">Email</th>
                    <th width="10%" ><button class="btn-primary" onclick="addMember()" >+</button></th>
                </tr>
                </thead>
                <tbody id="members_info">

                </tbody>
            </table>

        </div>
        <div class="col-md-6 col-sm-12 col-xs-12"  style="max-width:100%">

            <div class="col-md-12 col-sm-12 col-xs-12">
                <label style=" font-size: 16px"> Confirm TakeOut Location </label>
                <div class="payment-mode">
                    <input type="checkbox" checked name="take_out_location" id="take_out_location">
                    <label for="take_out_location" id="take_out_location_">205 PENNSYLVANIA AVENUE S.E. , WASHINGTON D.C. , UNITED STATES</label>
                </div>
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12">
                <label style=" font-size: 18px"> Please select Take-Out date and time </label>
                <input type="text" name="pickup_date_time" id="pickup_date_time" placeholder="Date and Time" class="input-fields date-picker" required value="2020-01-07 12:00:00">
            </div>

            <div class="col-md-12 col-sm-12 col-xs-12">
                <label style=" font-size: 18px"> Please select date and time for notification </label>
                <input type="text" name="notification_date_time" id="notification_date_time" placeholder="Date and Time" class="input-fields date-picker" required value="2020-01-07 12:00:00">
            </div>



        </div>
            <div>
                <div class="col-md-12 center" style="text-align: center; height: 40px"> <button type="button" class="btn btn-warning" id="save_group_order"  style="height: 40px">Initiate a Group Order</button></div>
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div id="form_submit_error" class="text-center" style="display:none"></div>
            </div>
        </div>

    </form>

</section>

<script>


    $('#group_name').on("keyup change", function () {
        //alert( $('#group_name').val())
        $.ajax({
            url: "./includes/controller/groupController.php",
            data: {
                q: "group_details_by_name",
                group_name: $('#group_name').val()

            },
            type: 'POST',
            async: false,
            dataType: "json",
            success: function (data) {
                //alert(data['id'])
                if(data!=0) {
                    $('#id_group').val(data['id'])
                    loadmembers(data['id'])
                }
                else {
                    $('#id_group').val('')
                    newForm()
                }
            }
        });
    })

loadGroups = function loadGroup(){
    var html=''

    $.ajax({
        url: "./includes/controller/groupController.php",
        data:{
            q: "groups",
            customer_id: customer_id
        },
        type:'POST',
        async:false,
        dataType: "json",
        success: function(data){
            if(!jQuery.isEmptyObject(data.records)){
                $.each(data.records, function(i,data){
                    html+='<option>'+data['name']+'</option>'
                })
            }
            $('#group_names').html(html)
        }
    });
}
loadGroups()

    addMember = function addMember(){
        var html =''
        //alert(html)
        html+='<tr class="user_information">\n' +
            '    <td><input type="text" required name="memberName[]" value="" style="margin: 0px; padding: 3px; border-radius: 5px; height: 40px"></td>\n' +
            '    <td><input type="email" required name="memberEmail[]" value="" style="margin: 0px; padding: 3px; border-radius: 5px; height: 40px"></td>\n' +
            '    <td style="margin-top: 10px"><button class="btn-danger deletes" >X</button></td>\n' +
            '  </tr>'
        $('#members_info').append(html)

        $('.deletes').on('click', function () {
            $(this).parent().parent().remove()
        })
    }

    $('#save_group_order').click(function(event){
        //alert('okkk')
        alert()
        event.preventDefault();
        var formData = new FormData($('#group_order')[0]);
        formData.append("q","initiate_group_order");
        formData.append("customer_id",<?php echo $customer_id; ?>);

        //validation
        //console.log($.trim($('#take_out_location').val()))
        if(!$('input[name=take_out_location]:checked', '#group_order').val()){
            success_or_error_msg('#form_submit_error','danger','Please Confirm Take-Out Location',"#take_out_location");
        }
        else if(!$.trim($('#group_name').val())){
            success_or_error_msg('#form_submit_error','danger','Please ENTER  a name for this group',"#pickup_date_time");
        }
        else if(!$.trim($('#pickup_date_time').val())){
            success_or_error_msg('#form_submit_error','danger','Please Select Take-Out Date and Time',"#pickup_date_time");
        }
        else if(!$.trim($('#notification_date_time').val())){
            success_or_error_msg('#form_submit_error','danger','Please Enter the Final Remainder Time to Confirm Order',"#notification_date_time");
        }
        else{
            //alert('ksjfdlk;')
            $.ajax({
                url: "./includes/controller/groupController.php",
                type:'POST',
                data:formData,
                async:false,
                cache:false,
                contentType:false,processData:false,
                success: function(data){
                    alert(data)
                    success_or_error_msg('#form_submit_error','primary','Group Order Successfully Initiated',"#notification_date_time");

                    newForm()
                }
            });
            //alert('done')

        }
    })


    loadmembers = function loadmembers(id){
        var html=''
       // alert(id)

        if(typeof id != 'undefined'){
            //$('#id_group').val(group_id)

            $.ajax({
                url: "./includes/controller/groupController.php",
                data:{
                    q: "group_details",
                    group_id: id

                },
                type:'POST',
                async:false,
                dataType: "json",
                success: function(data){
                    //console.log(data)
                    $('#group_name').val(data['name'])

                    if(!jQuery.isEmptyObject(data.records)){
                        $.each(data.records, function(i,data){
                            html+='<tr class="user_information">\n' +
                                '    <td><input type="text" required  name="memberName[]" value="'+data['name']+'" style="margin: 0px; padding: 3px; border-radius: 5px; height: 40px"></td>\n' +
                                '    <td><input type="email" required name="memberEmail[]" value="'+data['email']+'" style="margin: 0px; padding: 3px; border-radius: 5px; height: 40px"></td>\n' +
                                '    <td style="margin-top: 10px"><button class="btn-danger deletes"   >X</button></td>\n' +
                                '  </tr>'
                           // alert(i)
                        })
                    }

                    $('#members_info').html(html);

                    $('.deletes').on('click', function () {
                        $(this).parent().parent().remove()
                    })
                }

            });
        }
        else {
            newForm()
        }

    }

    function newForm(){
        $.ajax({
            url: "./includes/controller/ecommerceController.php",
            data: {
                q: "get_customer_details"
            },
            type: 'POST',
            async: false,
            dataType: "json",
            success: function (data) {
                console.log(data['records'])
                html='<tr class="user_information">\n' +
                    '    <td><input type="text" required name="memberName[]" value="'+data['records']['0']['full_name']+'" style="margin: 0px; padding: 3px; border-radius: 5px; height: 40px"></td>\n' +
                    '    <td><input type="email" required name="memberEmail[]" value="'+data['records']['0']['email']+'" style="margin: 0px; padding: 3px; border-radius: 5px; height: 40px"></td>\n' +
                    '    <td style="margin-top: 10px"><button class="btn-danger deletes" >X</button></td>\n' +
                    '  </tr>'
                $('#members_info').html(html)

                addMember()

            }
        });
    }

    loadmembers()
</script>









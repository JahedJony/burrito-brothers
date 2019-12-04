<?php
session_start();
include '../../includes/static_text.php';
include("../../dbConnect.php");
include("../../dbClass.php");
$dbClass = new dbClass;
$user_type = $_SESSION['user_type'];

if(!isset($_SESSION['user_id']) && $_SESSION['user_id'] == "") header("Location:".$website_url."../view/login.php");
else if($dbClass->getUserGroupPermission(98) != 1){
    ?>
    <div class="x_panel">
        <div class="alert alert-danger" align="center">You Don't Have permission of this Page.</div>
    </div>
    <?php
}
else{
    $user_name = $_SESSION['user_name'];
    ?>
    <?php if($dbClass->getUserGroupPermission(98) == 1){ ?>
        <div class="x_panel employee_entry_cl">

            <div class="x_content" >
                <form id="setting_form" name="setting_form" enctype="multipart/form-data" class="form-horizontal form-label-left" style="width: 100%; margin: auto">

                    <div class="form-group col-md-12">
                        <div class="x_title col-md-12 col-sm-12 col-xs-12" style="margin-top: 20px; margin-bottom: 20px">
                            <div class="col-md-4 col-sm-4 col-xs-4"><h2>General Information</h2></div>
                            <div class="col-md-8 col-sm-8 col-xs-8"><h2></h2></div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="col-md-6 col-sm-6 col-xs-6">
                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Company Name<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <input type="text" id="company_name" name="company_name" required class="form-control col-lg-12"/>
                            </div>
                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Website Title<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <input type="text" id="website_title" name="website_title" required class="form-control col-lg-12"/>
                            </div>
                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Website Url<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <input type="text" id="website_url" name="website_url" required class="form-control col-lg-12"/>
                            </div>



                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Web Admin Contact<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <input type="text" id="web_admin_contact" name="web_admin_contact" required class="form-control col-lg-12"/>
                            </div>
                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Web Admin Email<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <input type="text" id="web_admin_email" name="web_admin_email" required class="form-control col-lg-12"/>
                            </div>

                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Store Longitude<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <input type="text" id="store_longitude" name="store_longitude" required class="form-control col-lg-12"/>
                            </div>

                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Yelp<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <input type="text" id="yelp_url" name="yelp_url" required class="form-control col-lg-12"/>
                            </div>

                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Tweeter<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <input type="text" id="tweeter_url" name="tweeter_url" required class="form-control col-lg-12"/>
                            </div>

                        </div>
                        <div class="col-md-6 col-sm-6 col-xs-6">
                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Store Name<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <input type="text" id="store_name" name="store_name" required class="form-control col-lg-12"/>
                            </div>
                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Store Incharge <span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <input type="text" id="store_incharge_name" name="store_incharge_name" required class="form-control col-lg-12"/>
                            </div>
                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Store Contact<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <input type="text" id="store_contact" name="store_contact" required class="form-control col-lg-12"/>
                            </div>


                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Store Address<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <textarea rows="2" id="store_address" name="store_address" required class="form-control col-lg-12"/>
                            </div>

                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Store Latitude<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <input type="text" id="store_latitude" name="store_latitude" required class="form-control col-lg-12"/>
                            </div>
                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Facebook<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <input type="text" id="fb_url" name="fb_url" required class="form-control col-lg-12"/>
                            </div>
                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Instagram<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <input type="text" id="instagram_url" name="instagram_url" required class="form-control col-lg-12"/>
                            </div>


                        </div>
                        <div class="x_title col-md-12 col-sm-12 col-xs-12" style="margin-top: 20px; margin-bottom: 20px">
                            <div class="col-md-4 col-sm-4 col-xs-4"><h2>Payment & Checkout Method</h2></div>
                            <div class="col-md-8 col-sm-8 col-xs-8"><h2></h2></div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="col-md-6 col-sm-6 col-xs-6">
                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Take-Out<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <select class="form-control" name="takeout" id="takeout">
                                    <option selected value='1'>Enabled</option>
                                    <option value='0'>Disable</option>
                                </select>
                            </div>
                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Delivery<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <select class="form-control" name="delivery" id="delivery">
                                    <option selected value='1'>Enabled</option>
                                    <option value='0'>Disable</option>
                                </select>
                            </div>
                            <label class="control-label col-md-4 col-sm-4 col-xs-12">DineIn<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <select class="form-control" name="dinein" id="dinein">
                                    <option selected value='1'>Enabled</option>
                                    <option value='0'>Disable</option>
                                </select>
                            </div>



                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Visa Card<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <select class="form-control" name="payment_card_visa" id="payment_card_visa">
                                    <option selected value='1'>Accepted</option>
                                    <option value='0'>Not Accepted</option>
                                </select>
                            </div>

                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Master Card<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <select class="form-control" name="payment_card_master" id="payment_card_master">
                                    <option selected value='1'>Accepted</option>
                                    <option value='0'>Not Accepted</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-6 col-xs-6">
                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Card Payment<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <select class="form-control" name="card_payment" id="card_payment">
                                    <option selected value='1'>Enabled</option>
                                    <option value='0'>Disable</option>
                                </select>
                            </div>
                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Cash Payment<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <select class="form-control" name="cash_payment" id="cash_payment">
                                    <option selected value='1'>Enabled</option>
                                    <option value='0'>Disable</option>
                                </select>
                            </div>
                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Loyelty Payment<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <select class="form-control" name="loyelty_payment" id="loyelty_payment">
                                    <option selected value='1'>Enabled</option>
                                    <option value='0'>Disable</option>
                                </select>
                            </div>


                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Amex Card<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <select class="form-control" name="payment_card_amex" id="payment_card_amex">
                                    <option selected value='1'>Accepted</option>
                                    <option value='0'>Not Accepted</option>
                                </select>
                            </div>

                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Discover Card<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <select class="form-control" name="payment_card_discover" id="payment_card_discover">
                                    <option selected value='1'>Accepted</option>
                                    <option value='0'>Not Accepted</option>
                                </select>
                            </div>



                        </div>

                        <div class="x_title col-md-12 col-sm-12 col-xs-12" style="margin-top: 20px; margin-bottom: 20px">
                            <div class="col-md-4 col-sm-4 col-xs-4"><h2>Currency & Loyalty Settings</h2></div>
                            <div class="col-md-8 col-sm-8 col-xs-8"><h2></h2></div>
                            <div class="clearfix"></div>
                        </div>

                        <div class="col-md-6 col-sm-6 col-xs-6">
                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Currency<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <input type="text" id="currency" name="currency" required value="USD" class="form-control col-lg-12"/>
                            </div>
                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Decimal Placement<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <input type="text" id="decimal_placement" name="decimal_placement" value="2" required class="form-control col-lg-12"/>
                            </div>

                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Point Reserve Value<span class="required">*</span></label>
                            <div class="col-md-2 col-sm-2 col-xs-4" style="margin-bottom: 10px">
                                <input type="text" id="point_reserve_value" name="point_reserve_value" value="2" required class="form-control col-lg-12"/>
                            </div>
                            <div class="col-md-5 col-sm-5 col-xs-8" style="margin-bottom: 10px">
                                <label><p id="point_currency"></p></label>
                            </div>

                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Point Reserve Value<span class="required">*</span></label>
                            <div class="col-md-2 col-sm-2 col-xs-4" style="margin-bottom: 10px">
                                <input type="text" id="redeem_value" name="redeem_value" value="2" required class="form-control col-lg-12"/>
                            </div>
                            <div class="col-md-5 col-sm-5 col-xs-8" style="margin-bottom: 10px">
                                <label><p id="point"></p></label>
                            </div>



                        </div>
                        <div class="col-md-6 col-sm-6 col-xs-6">
                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Currency Symbol<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <input type="text" id="currency_symbol" name="currency_symbol" value="$" required class="form-control col-lg-12"/>
                            </div>

                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Minimum Order<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <input type="text" id="minimum_order_amount" name="minimum_order_amount" placeholder="Minimum Order Amount" required class="form-control col-lg-12"/>
                            </div>
                            <label class="control-label col-md-4 col-sm-4 col-xs-12">Tax Enable<span class="required">*</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-bottom: 10px">
                                <select class="form-control" name="tax_enable" id="tax_enable">
                                    <option  value='1'>Enabled</option>
                                    <option selected value='0'>Disable</option>
                                </select>
                            </div>

                        </div>

                        <div class="x_title col-md-12 col-sm-12 col-xs-12" style="margin-top: 20px; margin-bottom: 20px">
                            <div class="col-md-4 col-sm-4 col-xs-4"><h2>Meta Data Information</h2></div>
                            <div class="col-md-8 col-sm-8 col-xs-8"><h2></h2></div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                            <label class="control-label col-md-2 col-sm-2 col-xs-12">Meta Description<span class="required">*</span></label>
                            <div class="col-md-10 col-sm-10 col-xs-12" style="margin-bottom: 10px">
                                <textarea rows="3" id="meta_description" name="meta_description" required class="form-control col-lg-12"/>
                            </div>

                            <label class="control-label col-md-2 col-sm-2 col-xs-12">Meta Keywards<span class="required">*</span></label>
                            <div class="col-md-10 col-sm-10 col-xs-12" style="margin-bottom: 10px">
                                <textarea rows="2" id="meta_keywards" name="meta_keywards" required class="form-control col-lg-12"/>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-3 col-xs-12">
                            <div class="col-md-12 col-sm-12">
                                <label>Company Logo</label>
                                <hr>

                                <img src="<?php echo $site_url ?>images/no_image.png" width="70%" height="70%" class="img-thumbnail" id="logo">
                                <input type="file" name="company_logo" id="company_logo">
                                <br />
                                <br />
                            </div>
                        </div>



                        </div>

                    <label class="control-label col-md-4 col-sm-4 col-xs-6"></label>
                    <div class="col-md-12 col-sm-12 col-xs-12" style="text-align: center">
                        <button type="submit" id="save_general_settings" class="btn btn-success">Update Settings</button>
                    </div>
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div id="form_submit_error" class="text-center" style="display:none"></div>
                    </div>
                </form>
            </div>

        </div>

        <?php
    }
}
?>
<script src="js/customTable.js"></script>

<script>
    $('#point').text('point = 1$');
    $('#point_currency').text('$= 1 point');


    $(document).ready(function () {

        var url = project_url+"controller/generalSettingController.php";


        load_data = function load_data() {
            $.ajax({
                url: url,
                dataType: "json",
                type: "post",
                async:false,
                data: {
                    q: "general_setting_data",
                },
                success: function(data){
                    //alert(data.records[0]['id'])
                    $('#point').text('point  = 1'+data.records[0]['currency_symbol']);
                    $('#point_currency').text(data.records[0]['currency_symbol']+' = 1 point');

                    if(!jQuery.isEmptyObject(data.records)){
                        $.each(data.records, function(i,data){
                            for (var name in data){
                                if(name!='company_logo'){
                                    $('#'+name).val(data[name]);
                                }
                                else {
                                    $('#logo').attr("src", project_url + data[name]);
                                }
                            }
                        });

                    }
                }
            });
        }
        load_data();

        $('#save_general_settings').click(function(event){
            event.preventDefault();
            var formData = new FormData($('#setting_form')[0]);
            formData.append("q","update_setting");
            $.ajax({
                url: url,
                type:'POST',
                data:formData,
                async:false,
                cache:false,
                contentType:false,processData:false,
                success: function(data){
                    alert(data)
                    if($.isNumeric(data)==true && data==0){
                        success_or_error_msg('#form_submit_error',"danger","Please Insert Unique Username","#user_name" );

                    }
                    else if($.isNumeric(data)==true && data==1){
                        success_or_error_msg('#form_submit_error',"success","Save Successfully");
                    }
                    else{
                        if(data == "img_error")
                            success_or_error_msg('#form_submit_error',"danger",not_saved_msg_for_img_ln);
                        else
                            success_or_error_msg('#form_submit_error',"danger","Not Saved...");
                    }
                    load_data();

                }
            });

        });

    });
</script>



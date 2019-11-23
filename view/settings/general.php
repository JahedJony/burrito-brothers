<?php
session_start();
include '../../includes/static_text.php';
include("../../dbConnect.php");
include("../../dbClass.php");
$dbClass = new dbClass;
$user_type = $_SESSION['user_type'];

if(!isset($_SESSION['user_id']) && $_SESSION['user_id'] == "") header("Location:".$site_url."../view/login.php");
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
            <div class="x_content" id="iniial_collapse">
                <br />
                <form id="setting_form" name="setting_form" enctype="multipart/form-data" class="form-horizontal form-label-left" style="width: 80%; margin: auto">
                    <div class="row">
                        <div class="col-md-9">
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 col-xs-6" >Company Name</label>
                                <div class="col-md-8 col-sm-8  col-xs-6">
                                    <input type="text" id="company_name" name="company_name" class="form-control col-lg-12" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 col-xs-6" >Website Title</label>
                                <div class="col-md-8 col-sm-8  col-xs-6">
                                    <input type="text" id="site_title" name="site_title" class="form-control col-lg-12" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 col-xs-6" >Website URL</label>
                                <div class="col-md-8 col-sm-8  col-xs-6">
                                    <input type="text" id="site_url" name="site_url" class="form-control col-lg-12" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 col-xs-6" >Stock Alert Quantity</label>
                                <div class="col-md-8 col-sm-8  col-xs-6">
                                    <input type="number" id="stock_alert_quantity" name="stock_alert_quantity" class="form-control col-lg-12" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 col-xs-6" >Tax</label>
                                <div class="col-md-8 col-sm-8  col-xs-6">
                                    <input type="number" id="tax" name="tax" class="form-control col-lg-12" />
                                    <span  style=" top: 8px; color: #555; left: 90%; text-align: right; position: absolute; z-index: 1;">%</span>
                                </div>
                            </div>

                            <div class="ln_solid"></div>
                        </div>
                        <div class="col-md-3">
                            <img src="<?php echo $site_url ?>images/no_image.png" width="70%" height="70%" class="img-thumbnail" id="logo">
                            <input type="file" name="logo_upload" id="logo_upload">
                            <br />
                            <br />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-6"></label>
                        <div class="col-md-3 col-sm-3 col-xs-12">
                            <button type="submit" id="save_general_settings" class="btn btn-success">Save Settings</button>
                        </div>
                        <div class="col-md-7 col-sm-7 col-xs-12">
                            <div id="form_submit_error" class="text-center" style="display:none"></div>
                        </div>
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
                    //alert(data['records'].company_name)
                    if(!jQuery.isEmptyObject(data.records)){
                        $.each(data.records, function(i,data){
                            $('#company_name').val(data.company_name);
                            $('#site_title').val(data.site_title);
                            $('#site_url').val(data.site_url);
                            $('#stock_alert_quantity').val(data.stock_alert_quantity);
                            $('#tax').val(data.tax);
                            $('#logo').attr("src", project_url + data.logo);

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



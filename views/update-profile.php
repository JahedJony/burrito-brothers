<h6 class="center">Update your personal informations</h6>
<hr>
<form id="customer_form" name="customer_form" enctype="multipart/form-data" class="form-horizontal form-label-left register-form">   
	<div class="row">
		<div class="col-md-8">
			<div class="form-group">
				<label class="control-label col-md-4 col-sm-4 col-xs-4">Name<span class="required">*</span></label>
				<div class="col-md-8 col-sm-8  col-xs-8">
					<input type="text" id="customer_name" name="customer_name" required class="form-control col-lg-12"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-md-4 col-sm-4 col-xs-4" for="name">Date Of Birth</label>
				<div class="col-md-8 col-sm-8  col-xs-8">
					<input type="text" id="age" name="age" class="form-control col-lg-12 datepicker"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-md-4 col-sm-4 col-xs-4">Contact No<span class="required">*</span></label>
				<div class="col-md-8 col-sm-8  col-xs-8">
					<input type="text" id="contact_no" name="contact_no" required class="form-control col-lg-12"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-md-4 col-sm-4 col-xs-4">Email</label>
				<div class="col-md-8 col-sm-8  col-xs-8">
					<input type="email" id="email" name="email" class="form-control col-lg-12"/>
				</div>
			</div>						
			<div class="form-group"> 
				<label class="control-label col-md-4 col-sm-4 col-xs-4" >Address<span class="required">*</span></label>
				<div class="col-md-8 col-sm-8  col-xs-8">
					<input type="text" id="address" name="address" required class="form-control col-lg-12" />
				</div>
			</div>	
			<div class="form-group">
				<label class="control-label col-md-4 col-sm-4 col-xs-4">Password</label>
				<div class="col-md-8 col-sm-8  col-xs-8">
					<input type="password" id="password" name="password" class="form-control col-lg-12"></textarea> 
					<small>First you need to provide your old password</small>
				</div>
				
			</div>
			<div class="form-group">
				<label class="control-label col-md-4 col-sm-4 col-xs-4" >New Password</label>
				<div class="col-md-8 col-sm-8  col-xs-8">
					<input type="password" id="new_password" name="new_password" class="form-control col-lg-12"/>
				</div>
			</div>
			<div class="ln_solid"></div>
		</div>
		<div class="col-md-4">
			<img src="" width="70%" height="70%" class="img-thumbnail" id="customer_img">
			<input type="file" name="customer_image_upload" id="customer_image_upload"> 
		</div>
	</div>
	<div id="form_submit_error" class="text-center" style="display:none"></div>
	<div class="form-group">
		<label class="control-label col-md-4 col-sm-4 col-xs-4"></label>
		<div class="col-md-8 col-sm-8  col-xs-8">
		
			<input type="hidden" id="is_active" name="is_active" />
			<input type="hidden" id="customer_id" name="customer_id" />    
			<button type="submit" id="save_customer_info" class="btn-medium btn-skin pull-left">Update your informations</button>                                           
		</div>
	</div>
</form>

<script>
    set_customer_data = function set_customer_data(){
        $('#is_active_home_page_div').hide();
        $.ajax({
            url:project_url+"includes/controller/ecommerceController.php",
            dataType: "json",
            type: "post",
            async:false,
            data: {
                q: "get_customer_details",
                customer_id: customer_id,
            },
            success: function(data){
                if(!jQuery.isEmptyObject(data.records)){
                    $.each(data.records, function(i,data){
                        $('#customer_id').val(data.customer_id);
                        $('#customer_name').val(data.full_name);
                        $('#contact_no').val(data.contact_no);
                        $('#email').val(data.email);
                        $('#age').val(data.age);
                        $('#address').val(data.address);
                        $('#is_active').val(data.status);

                        if(data.photo == ""){
                            $('#customer_img').attr("src",'admin/images/no_image.png');
                        }else{
                            $('#customer_img').attr("src","admin/"+data.photo);
                        }
                        $('#customer_img').attr("width", "70%","height","70%");

                        $(".profile").addClass('active');


                        //alert('i am here');
                        //$( ".datepicker" ).datepicker();
                        $( ".datepicker" ).datepicker({
                            dateFormat: "yy-mm-dd"
                        });

                    });
                }
            }
        });
    }
set_customer_data()

    $('#save_customer_info').click(function(event){
        event.preventDefault();
        var formData = new FormData($('#customer_form')[0]);
        formData.append("q","insert_or_update");
        if($.trim($('#customer_name').val()) == ""){
            success_or_error_msg('#form_submit_error','danger',"Please Insert Name","#customer_name");
        }
        else if($.trim($('#contact_no').val()) == ""){
            success_or_error_msg('#form_submit_error','danger',"Please Insert Contact No","#contact_no");
        }
        else if($.trim($('#address').val()) == ""){
            success_or_error_msg('#form_submit_error','danger',"Please Insert Address","#address");
        }
        else if($.trim($('#passport').val()) == "" && $.trim($('#new_passport').val()) != ""){
            success_or_error_msg('#form_submit_error','danger',"Please Insert old password","#password");
        }
        else if($.trim($('#passport').val()) != "" && $.trim($('#new_passport').val()) == ""){
            success_or_error_msg('#form_submit_error','danger',"Please Insert new password","#new_password");
        }
        else{
            //	$('#save_customer_info').attr('disabled','disabled');


            $.ajax({
                url: project_url+'includes/controller/ecommerceController.php',
                type:'POST',
                data:formData,
                async:false,
                cache:false,
                contentType:false,processData:false,
                success: function(data){
                    $('#save_customer_info').removeAttr('disabled','disabled');

                    if($.isNumeric(data)==true && data==5){
                        success_or_error_msg('#form_submit_error',"danger","Please Insert Unique Identy No","#nid_no" );
                    }
                    else if($.isNumeric(data)==true && data>0){
                        success_or_error_msg('#form_submit_error',"success","Save Successfully");
                        show_my_accounts('update-profile');
                        set_customer_data();
                    }
                    else{
                        if(data == "img_error")
                            success_or_error_msg('#form_submit_error',"danger",not_saved_msg_for_img_ln);
                        else
                            success_or_error_msg('#form_submit_error',"danger","Not Saved...");
                    }
                }
            });
        }
    })

</script>


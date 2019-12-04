<?php
session_start();
include '../../includes/static_text.php';
include("../../dbConnect.php");
include("../../dbClass.php");
$dbClass = new dbClass;
$user_type = $_SESSION['user_type'];

if(!isset($_SESSION['user_id']) && $_SESSION['user_id'] == "") header("Location:".$activity_url."../view/login.php");
else if($dbClass->getUserGroupPermission(100) != 1){
?> 
	<div class="x_panel">
		<div class="alert alert-danger" align="center">You Don't Have permission of this Page.</div>
	</div>
	<?php 
} 
else{
	$user_name = $_SESSION['user_name'];
	?>
	
<div class="x_panel">
    <div class="x_title">
        <h2>Unit List</h2>
        <ul class="nav navbar-right panel_toolbox">
            <li>
				<a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
            </li>
        </ul>
        <div class="clearfix"></div>
    </div>
    <div class="x_content">
    	<div id="page_notification_div" class="text-center" style="display:none"></div>        
		<div class="dataTables_length">
        	<label>Show 
                <select size="1" style="width: 56px;padding: 6px;" id="unit_Table_length" name="unit_Table_length" aria-controls="unit_Table">
                    <option value="50" selected="selected">50</option>
                    <option value="100">100</option>
                    <option value="500">500</option>
                 </select> 
                 Entry
             </label>
         </div>
         <div class="dataTables_filter" id="unit_Table_filter">         
			<div class="input-group">
                <input class="form-control" id="search_unit_field" style="" type="text">
                <span class="input-group-btn">
                    <button type="button" class="btn btn-primary has-spinner" id="search_unit_button">
                     <span class="spinner"><i class="fa fa-spinner fa-spin fa-fw "></i></span>
                     <i class="fa  fa-search "></i>
                    </button> 
                </span>
            </div>
       </div>
       <div style="height:250px; width:100%; overflow-y:scroll">
        <table id="unit_Table" name="table_records" class="table table-bordered  responsive-utilities jambo_table table-striped  table-scroll ">
            <thead >
                <tr class="headings">
					<th class="column-title" width="15%">Unit Name</th>				
					<th class="column-title" width="10%">Short Name</th>
					<th class="column-title" width="">note</th>										                    
					<th class="column-title text-center" width="10%">Status</th>
                    <th class="column-title no-link last" width="100"><span class="nobr"></span></th>
                </tr>
            </thead>
            <tbody id="unit_table_body" class="scrollable">              
                
            </tbody>
        </table>
        </div>
        <div id="unit_Table_div">
            <div class="dataTables_info" id="unit_Table_info">Showing <span id="from_to_limit"></span> of  <span id="total_record"></span> entries</div>
            <div class="dataTables_paginate paging_full_numbers" id="unit_Table_paginate">
            </div> 
        </div>  
    </div>
</div>
<?php if($dbClass->getUserGroupPermission(100) == 1){ ?>
<div class="x_panel unit_entry_cl">
    <div class="x_title">
        <h2>Unit Entry</h2>
        <ul class="nav navbar-right panel_toolbox">
            <li>
				<a class="collapse-link" id="toggle_form"><i class="fa fa-chevron-down"></i></a>
            </li>
        </ul>
        <div class="clearfix"></div>
    </div>
    <div class="x_content" id="iniial_collapse">
        <br />             
		<form id="unit_form" name="unit_form" enctype="multipart/form-data" class="form-horizontal form-label-left">   
			<div class="row">
				<div class="col-md-9">
					<div class="form-group">
						<label class="control-label col-md-2 col-sm-2 col-xs-6">Unit Name<span class="required">*</span></label>
						<div class="col-md-4 col-sm-4 col-xs-6">
							<input type="text" id="unit_name" name="unit_name" required class="form-control col-lg-12"/>
						</div>
						<label class="control-label col-md-2 col-sm-2 col-xs-6">Short Name<span class="required">*</span></label>
						<div class="col-md-4 col-sm-4 col-xs-12">
							<input type="text" id="short_name" name="short_name"  required class="form-control col-lg-12"/>
						</div>
					</div>	
					<div class="form-group">
						<label class="control-label col-md-2 col-sm-2 col-xs-6">Base Unit Name</label> 
						<div class="col-md-4 col-sm-4 col-xs-6">
							<input type="text" id="base_unit_name" name="base_unit_name" class="form-control col-lg-12"/> 
							<input type="hidden" id="base_unit_id" name="base_unit_id" />
						</div>
						<label class="control-label col-md-2 col-sm-2 col-xs-6">Operator</label>
						<div class="col-md-4 col-sm-4 col-xs-12">
							<select id="operator" name="operator"  class="form-control col-lg-12">
								<option value='mul'>Multiply</option>
								<option value='div'>Divide</option>
								<option value='add'>Add</option>
								<option value='sub'>Subtract</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-2 col-sm-2 col-xs-6">Operator Value</label>
						<div class="col-md-4 col-sm-4 col-xs-12">
							<input type="text" id="conversion_rate" name="conversion_rate"  class="form-control col-lg-12"/>
						</div>
													
						<label class="control-label col-md-2 col-sm-2 col-xs-6" >Is Active?</label>
						<div class="col-md-4 col-sm-4 col-xs-6">
							<input type="checkbox" id="is_active" name="is_active" checked="checked" class="form-control col-lg-12"/>
						</div>						
					</div>
					<div class="form-group"> 
						<label class="control-label col-md-2 col-sm-2 col-xs-6" >Note</label>
						<div class="col-md-10 col-sm-10  col-xs-6">
							<textarea rows="2" cols="100" id="note" name="note" class="form-control col-lg-12"></textarea> 
						</div>
					</div>
					
					<div class="ln_solid"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-md-2 col-sm-2 col-xs-6"></label>
				<div class="col-md-3 col-sm-3 col-xs-12">
					<input type="hidden" id="unit_id" name="unit_id" />    
					<button type="submit" id="save_unit_info" class="btn btn-success">Save</button>                    
					<button type="button" id="clear_button" class="btn btn-primary">Clear</button>                         
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
<script src="js/autosuggest.js"></script> 
<script>
//------------------------------------- general & UI  --------------------------------------
/*
develped by @momit
=>load grid with paging
=>search records
*/
$(document).ready(function () {	
	var user_type = "<?php echo $user_type; ?>";
	// close form submit section onload page

	// icheck for the inputs
	$('#unit_form').iCheck({
		checkboxClass: 'icheckbox_flat-green',
		radioClass: 'iradio_flat-green'
	});	
	
	$('.flat_radio').iCheck({
		//checkboxClass: 'icheckbox_flat-green'
		radioClass: 'iradio_flat-green'
	});
	

	$('#is_active').iCheck('check');
});




/*
develped by @momit
=>load grid with paging
=>search records
*/
$(document).ready(function (){	
	// initialize page no to "1" for paging
	var current_page_no=1;	

	load_unit_data = function load_unit_data(search_txt){
		$("#search_unit_button").toggleClass('active');		 
		var unit_Table_length =parseInt($('#unit_Table_length').val());

		$.ajax({
			url: project_url+"controller/settingsController.php",
			dataType: "json",
			type: "post",
			async:false,
			data: {
				q: "grid_data_unit",
				search_txt: search_txt,
				limit:unit_Table_length,
				page_no:current_page_no
			},
			success: function(data){
				var todate = "<?php echo date("Y-m-d"); ?>";
				var user_name =  "<?php echo $user_name; ?>";
				
				if(data.entry_status==0){
					$('.unit_entry_cl').hide();
				}
				// for  showing grid's no of records from total no of records 
				show_record_no(current_page_no, unit_Table_length, data.total_records )
				
				var total_pages = data.total_pages;	
				var records_array = data.records;
				$('#unit_Table tbody tr').remove();
				//$("#search_unit_button").toggleClass('active');
				if(!jQuery.isEmptyObject(records_array)){
					// create and set grid table row
					var colums_array=["id*identifier*hidden","unit_name", "short_name", "note","status" ];
					// first element is for view , edit condition, delete condition
					// "all" will show /"no" will show nothing
					var condition_array=["","","update_status","1","delete_status","1"];
					// create_set_grid_table_row(records_array,colums_array,int_fields_array, condition_arraymodule_name,table/grid id, is_checkbox to select tr );
					// cauton: not posssible to use multiple grid in same page					
					create_set_grid_table_row(records_array,colums_array,condition_array,"unit","unit_Table", 0);
					// show the showing no of records and paging for records 
					$('#unit_Table_div').show();					
					// code for dynamic pagination 				
					paging(total_pages, current_page_no, "unit_Table" );					
				}
				// if the table has no records / no matching records 
				else{
					grid_has_no_result( "unit_Table",8);
				}
				$("#search_unit_button").toggleClass('active');							
			}
		});	
	}
	
	// load desire page on clik specific page no
	load_page = function load_page(page_no){
		if(page_no != 0){
			// every time current_page_no need to change if the user change page
			current_page_no=page_no;
			var search_txt = $("#search_unit_field").val();
			load_unit_data(search_txt)
		}
	}	
	// function after click search button 
	$('#search_unit_button').click(function(){
		var search_txt = $("#search_unit_field").val();
		// every time current_page_no need to set to "1" if the user search from search bar
		current_page_no=1;
		load_unit_data(search_txt)
		// if there is lot of data and it tooks lot of time please add the below condition
		/*
		if(search_txt.length>3){
			load_unit_data(search_txt)	
		}
		*/
	});
	//function after press "enter" to search	
	$('#search_unit_field').keypress(function(event){
		var search_txt = $("#search_unit_field").val();	
		if(event.keyCode == 13){
			// every time current_page_no need to set to "1" if the user search from search bar
			current_page_no=1;
			load_unit_data(search_txt)
			// if there is lot of data and it tooks lot of time please add the below condition
			/*
			if(search_txt.length>3){
				load_unit_data(search_txt,1)	
			}*/
		}
	})

	// load data initially on page load with paging
	load_unit_data("");
});







/*
develped by @momit
=>form submition for add/edit
=>clear form
=>load data to edit
=>delete record
=>view 
*/
$(document).ready(function () {		
	var url = project_url+"controller/settingsController.php";	
	
	// save and update for public post/notice
	$('#save_unit_info').click(function(event){		
		event.preventDefault();

        var formData = new FormData($('#unit_form')[0]);
		formData.append("q","insert_or_update_unit");
		if($.trim($('#unit_name').val()) == ""){
            success_or_error_msg('#form_submit_error','danger',"Please Insert Name","#unit_name");
		}
        else if($.trim($('#short_name').val()) == ""){
            success_or_error_msg('#form_submit_error','danger',"Please Insert Short Name","#short_name");
		} 		
		else{
			//$('#save_unit_info').attr('disabled','disabled');			
			$.ajax({
				url: url,
				type:'POST',
				data:formData,
				async:false,
				cache:false,
				contentType:false,processData:false,
				success: function(data){
					$('#save_unit_info').removeAttr('disabled','disabled');
					if($.isNumeric(data)==true && data==5){
						success_or_error_msg('#form_submit_error',"danger","Unit Name already exists","#unit_name" );			
					}
					else if($.isNumeric(data)==true && data>0){
						success_or_error_msg('#form_submit_error',"success","Save Successfully");
						load_unit_data("");
						clear_form();
					}
					else{
						if(data == "img_error")
							success_or_error_msg('#',"danger",not_saved_msg_for_img_ln);
						else	
							success_or_error_msg('#form_submit_error',"danger","Not Saved...");												
					}
				 }	
			});

        }
	})


	
	// clear function to clear all the form value
	clear_form = function clear_form(){			 
		$('#unit_id').val('');		
		$("#unit_form").trigger('reset');		
		$('#save_unit_info').html('Save');
		$('#unit_form').iCheck({
			checkboxClass: 'icheckbox_flat-green',
			radioClass: 'iradio_flat-green'
		});	
	}

    // on select clear button
	$('#clear_button').click(function(){
		clear_form();
	});


    delete_unit = function delete_unit(unit_id){
		if (confirm("Do you want to delete the record? ") == true) {
			$.ajax({
				url: url,
				type:'POST',
				async:false,
				data: "q=delete_unit&unit_id="+unit_id,
				success: function(data){
					if($.trim(data) == 1){
						success_or_error_msg('#page_notification_div',"success","Deleted Successfully");
						load_unit_data("");
					}
					else{
						success_or_error_msg('#page_notification_div',"danger","Not Deleted...");						
					}
				 }	
			});
		} 	
	}
	

	edit_unit = function edit_unit(unit_id){
		$.ajax({
			url: url,
			dataType: "json",
			type: "post",
			async:false,
			data: {
				q: "get_unit_details",
				unit_id: unit_id
			},
			success: function(data){
				if(!jQuery.isEmptyObject(data.records)){
					$.each(data.records, function(i,data){ 
						clear_form();			
						$('#unit_id').val(data.id);
						$('#unit_name').val(data.unit_name);
						$('#short_name').val(data.short_name);
						$('#base_unit_id').val(data.base_unit);
						$('#base_unit_name').val(data.base_unit_name);
						$('#conversion_rate').val(data.conversion_rate);
						$('#operator').val(data.operator);
						$('#note').val(data.note);										
						
						(data.status==1)?$('#is_active').iCheck('check'):$('#is_active').iCheck('uncheck');

						//change button value 
						$('#save_unit_info').html('Update Unit');
						
						// to open submit post section
						if($.trim($('#toggle_form i').attr("class"))=="fa fa-chevron-down")
							$( "#toggle_form" ).trigger( "click" );

					});
					
				}
			}	
		});			
	}				
	
});


</script>
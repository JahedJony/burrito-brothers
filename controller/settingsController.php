<?php 
session_start();
include '../includes/static_text.php';
include("../dbConnect.php");
include("../dbClass.php");

$dbClass = new dbClass;
$conn       = $dbClass->getDbConn();
$loggedUser = $dbClass->getUserId();	
$permission = $dbClass->getUserGroupPermission(100);		

extract($_REQUEST);

switch ($q){
	/************************************************ Company CRUID ***************************************************/
	case "insert_or_update_company":	
		if(isset($Company_id) && $Company_id == ""){
			$check_user_name_availability = $dbClass->getSingleRow("select count(company_name) as no_of_Company from companies where company_name='$company_name'");
			if($check_user_name_availability['no_of_Company']!=0) { echo 5; die;}
			
			$is_active =(isset($_POST['is_active']))?1:0;

			if(isset($_FILES['Company_image_upload']) && $_FILES['Company_image_upload']['name']!= ""){
				$desired_dir = "../images/Company";
				chmod( "../images/Company", 0777);
				$file_name = $_FILES['Company_image_upload']['name'];
				$file_size =$_FILES['Company_image_upload']['size'];
				$file_tmp =$_FILES['Company_image_upload']['tmp_name'];
				$file_type=$_FILES['Company_image_upload']['type'];	
				if($file_size < $file_max_length){
					if(file_exists("$desired_dir/".$file_name)==false){
						if(move_uploaded_file($file_tmp,"$desired_dir/".$file_name))
							$photo = "$file_name";
					}
					else{//rename the file if another one exist
						$new_dir="$desired_dir/".time().$file_name;
						if(rename($file_tmp,$new_dir))
							$photo =time()."$file_name";				
					}
					$photo  = "images/Company/".$photo;					
				}
				else {
					echo $img_error_ln;die;
				}			
			}
			else{
				$photo  = "";	
			}

			$columns_value = array(
				'company_name'=>$company_name,
				'company_address'=>$address,
				'phone'=>$contact_no,
				'note'=>$note,
				'status'=>$is_active,
				'logo'=>$photo,
				'note'=>$note,
				'created_by'=>$loggedUser
			);	
			
			$return = $dbClass->insert("companies", $columns_value);
			if($return) echo "1";
			else 	echo "0";
		}
		else{
		//var_dump($_REQUEST);die;
			$check_user_name_availability = $dbClass->getSingleRow("select count(company_name) as no_of_Company from companies where company_name='$company_name' and company_id!=$Company_id");
			if($check_user_name_availability['no_of_Company']!=0) { echo 5; die;}
			
			$is_active =(isset($_POST['is_active']))?1:0;		
			
			if(isset($_FILES['Company_image_upload']) && $_FILES['Company_image_upload']['name']!= ""){
				$desired_dir = "../images/Company";
				chmod( "../images/Company", 0777);
				$file_name = $_FILES['Company_image_upload']['name'];
				$file_size =$_FILES['Company_image_upload']['size'];
				$file_tmp =$_FILES['Company_image_upload']['tmp_name'];
				$file_type=$_FILES['Company_image_upload']['type'];	
				if($file_size < $file_max_length){
					if(file_exists("$desired_dir/".$file_name)==false){
						if(move_uploaded_file($file_tmp,"$desired_dir/".$file_name))
							$photo = "$file_name";
					}
					else{//rename the file if another one exist
						$new_dir="$desired_dir/".time().$file_name;
						if(rename($file_tmp,$new_dir))
							$photo =time()."$file_name";				
					}
					$photo  = "images/Company/".$photo;					
				}
				else {
					echo $img_error_ln;die;
				}

				$columns_value = array(
					'company_name'=>$company_name,
					'company_address'=>$address,
					'phone'=>$contact_no,
					'note'=>$note,
					'status'=>$is_active,
					'logo'=>$photo,
					'note'=>$note,
					'created_by'=>$loggedUser
				);					
			}
			else{
				$columns_value = array(
					'company_name'=>$company_name,
					'company_address'=>$address,
					'phone'=>$contact_no,
					'note'=>$note,
					'status'=>$is_active,
					'note'=>$note,
					'modified_by'=>$loggedUser
				);
			}
			$condition_array = array(
				'company_id'=>$Company_id
			);	
			$return = $dbClass->update("companies", $columns_value, $condition_array);
							
			if($return) echo "2";
			else 	echo "0";
		}
	break;

	

	
}
?>
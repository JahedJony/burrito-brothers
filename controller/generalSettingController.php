<?php
session_start();
include '../includes/static_text.php';
include("../dbConnect.php");
include("../dbClass.php");

$dbClass = new dbClass;
$conn       = $dbClass->getDbConn();
$loggedUser = $dbClass->getUserId();

extract($_REQUEST);

switch ($q){



    case "general_setting_data":
        $update_permission = $dbClass->getUserGroupPermission(98);
        if($update_permission==1){
            $emp_details = $dbClass->getResultList("SELECT * FROM settings WHERE settings.id =1");
            foreach ($emp_details as $row){
                $data['records'][] = $row;
            }
            echo json_encode($data);
        }
        break;

    case "update_setting":
            if(isset($_FILES['logo_upload']) && $_FILES['logo_upload']['name']!= ""){
                $desired_dir = "../images/banner";
                chmod( "../images/banner", 0777);
                $file_name = $_FILES['logo_upload']['name'];
                $file_size =$_FILES['logo_upload']['size'];
                $file_tmp =$_FILES['logo_upload']['tmp_name'];
                $file_type=$_FILES['logo_upload']['type'];
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
                    $photo  = "images/banner/".$photo;
                }
                else {
                    echo $img_error_ln; die;
                }
            }
            else{
                $logo = $dbClass->getSingleRow("select settings.logo from settings where settings.id = 1");
                $photo= $logo['logo'];
                //echo  $photo['logo']; die;
                //$logo = $photo[0];
            }

            $columns_value = array(
                'id'=>1,
                'company_name'=>$company_name,
                'site_title'=>$site_title,
                'site_url'=>$site_url,
                'stock_alert_quantity'=>$stock_alert_quantity,
                'tax'=>$tax,
                'logo'=>$photo,

            );
            $condition_array = array(
                'id'=>1
            );

            $return = $dbClass->update("settings", $columns_value, $condition_array);

            if($return) echo "1";
            else 	echo "0";
        break;

}
?>



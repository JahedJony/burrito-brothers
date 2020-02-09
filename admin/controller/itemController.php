<?php
session_start();
include '../includes/static_text.php';
include("../dbConnect.php");
include("../dbClass.php");

$dbClass = new dbClass;
$conn       = $dbClass->getDbConn();
$loggedUser = $dbClass->getUserId();

extract($_REQUEST);

switch ($q) {
    case "insert_or_update_option":
        //echo $option_id_input; die;

        if(!isset($is_required_input)){
            $is_required_input=0;
        }
        if($option_id_input!=0){
            $columns_value = array(
                'item_id'=>intval($item_id),
                'name'=>$option_name_input,
                'is_required'=>$is_required_input,
                'maximum_choice'=>$maximum_choice_input,
                'minimum_choice'=>$minimum_choice_input
            );
            $condition_array = array(
                'id' => $option_id_input
            );

            $dbClass->update("item_options", $columns_value,$condition_array);
            $return_option = intval($option_id_input);

        }
        else{
            $columns_value = array(
                'item_id'=>intval($item_id),
                'name'=>$option_name_input,
                'is_required'=>$is_required_input,
                'maximum_choice'=>$maximum_choice_input,
                'minimum_choice'=>$minimum_choice_input
            );
            $return_option = $dbClass->insert("item_options", $columns_value);
        }

        foreach ($ingredient_name as $i => $value){

            $sql = "select id FROM ingredient WHERE name = '$value' AND price= '$ingredient_price[$i]'";
            $ingredient = $dbClass->getSingleRow($sql);

            if(!isset($ingredient['id'])){
                $ing_id = 0;
            }
            else{
                $ing_id = $ingredient['id'];
            }


            $columns_value = array(
                'option_id'=>$return_option,
                'ingredient_id'=>$ing_id,
                'name'=>$value,
                'price'=>$ingredient_price[$i]
            );

            if($ingredient_id!=0){
                $condition_array = array(
                    'id' =>$ingredient_id
                );
                $dbClass->update("options_items", $columns_value,$condition_array);
            }
            else{
                $dbClass->insert("options_items", $columns_value);
            }
        }

        echo json_encode($return_option);
    break;


    case "insert_or_update":

        if(!isset($is_stock)){
            $is_stock=0;
        }
        if(!isset($is_active)){
            $is_active=0;
        }

        //extract()

       // echo json_encode($options[4]); die;

        //echo $is_stock; die;
        //echo json_encode($_FILES['uploded_files']['name']); die;

        /*

        if(isset($_FILES['item_image']) && $_FILES['item_image']['name']!= ""){
            //echo 1; die;
            $desired_dir = "../images/item";
            chmod( "../images/item", 0777);
            $file_name = $_FILES['item_image']['name'];
            $file_size =$_FILES['item_image']['size'];
            $file_tmp =$_FILES['item_image']['tmp_name'];
            $file_type=$_FILES['item_image']['type'];
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
                $photo  = "images/item/".$photo;
            }
            else {
                echo $img_error_ln;die;
            }
        }
        else{
            //echo 0; die;
            $photo  = "images/item/noFood.png";
        }
        */
        $photo  = "images/item/noFood.png";



        $columns_value = array(
            'name'=>$item_name,
            'details'=>$details,
            'category_id'=>$category_option,
            'sell_from_stock'=>$is_stock,
            'availability'=>$is_active,
            'feature_image'=>$photo,
            'price'=>$base_price
        );
        $return_item = $dbClass->insert("items", $columns_value);

        echo $return_item;







        die;




        if(isset($item_id) && $item_id == ""){
            //var_dump($_REQUEST);die;
            $feature_image = "";
            if(isset($_FILES['feature_image_upload']) && $_FILES['feature_image_upload']['name'] != ""){
                $desired_dir = "../images/item";
                chmod( "../images/item", 0777);
                $file_name = $_FILES['feature_image_upload']['name'];
                $file_size =$_FILES['feature_image_upload']['size'];
                $file_tmp =$_FILES['feature_image_upload']['tmp_name'];
                $file_type=$_FILES['feature_image_upload']['type'];

                if($file_size < $file_max_length){
                    if(file_exists("$desired_dir/".$file_name)==false){
                        if(move_uploaded_file($file_tmp,"$desired_dir/".$file_name))
                            $feature_image = "$file_name";
                    }
                    else{//rename the file if another one exist
                        $new_dir="$desired_dir/".time().$file_name;
                        if(rename($file_tmp,$new_dir))
                            $feature_image =time()."$file_name";
                    }
                    chmod( "../images/item/".$feature_image, 0775);
                }
                else{
                    echo $img_error_ln;die;
                }
            }
            else{
                $feature_image = "";
            }


            $sell_from_stock=0;
            if(isset($_POST['sell_from_stock'])){
                $sell_from_stock=1;
            }

            $columns_value = array(
                'name'=>$item_name,
                'code'=>$item_code,
                'details'=>$details,
                'category_id'=>$category_option,
                'sell_from_stock'=>$sell_from_stock,
                'tags'=>$tag,
                'feature_image'=>$feature_image
            );
            $return_item = $dbClass->insert("items", $columns_value);
//echo $return_item; die;

            if(isset($ingredient)){
                //echo 'ing'; die;
                foreach($ingredient as $row){
                    $columns_value = array(
                        'item_id'=>$return_item,
                        'ingredient_id'=>$row
                    );
                    $return_ingredient = $dbClass->insert("item_ingredient", $columns_value);
                    //echo $return_ingredient; die;
                }
            }

            $attachments = "";
            if(isset($_FILES['attached_file']) && $_FILES['attached_file']['name'][0] != ""){
                $desired_dir = "../images/item";
                $desired_dir_thumb = "../images/item/thumb";

                chmod( "../images/item", 0777);
                chmod( "../images/item/thumb", 0777);

                foreach($_FILES['attached_file']['tmp_name'] as $key => $tmp_name ){
                    $file_name = $_FILES['attached_file']['name'][$key];
                    $file_size =$_FILES['attached_file']['size'][$key];
                    $file_tmp =$_FILES['attached_file']['tmp_name'][$key];
                    $file_type=$_FILES['attached_file']['type'][$key];
                    if($file_size < $file_max_length){
                        if(file_exists("$desired_dir/".$file_name)==false){
                            $dbClass->store_uploaded_image($file_tmp, 300, 300, $desired_dir_thumb, "$desired_dir/thumb/".$file_name);
                            $dbClass->store_uploaded_image($file_tmp, 555, 555, $desired_dir_thumb, "$desired_dir/".$file_name);
                            $attachments = "$file_name";
                            /*if(move_uploaded_file($file_tmp,"$desired_dir/".$file_name)){
                            }*/
                        }
                        else{//rename the file if another one exist
                            $new_dir="$desired_dir/".time().$file_name;
                            $dbClass->store_uploaded_image($file_tmp, 300, 300, $desired_dir_thumb, "$desired_dir/thumb/".time().$file_name);
                            if(rename($file_tmp,$new_dir)){
                                $attachments =time()."$file_name";
                            }
                        }
                        chmod( "../images/item/".$attachments, 0775);
                        $columns_value = array(
                            'item_id'=>$return_item,
                            'item_image'=>$attachments
                        );
                        $return_details = $dbClass->insert("item_image",$columns_value);
                    }
                    else{
                        echo $img_error_ln;die;
                    }
                }
            }
            if($return_item){
                foreach($size_id as $key=>$row){
                    $columns_value = array(
                        'item_id'=>$return_item,
                        'size_id'=>$size_id[$key],
                        'unit_id'=>$unit_id[$key],
                        'production_rate'=>$production_rate[$key],
                        'rate'=>$rate[$key],
                        'discount_type'=>$discount_type[$key],
                        'discount_amount'=>$discount_amount[$key],
                        'discounted_rate'=>$production_rate[$key],
                    );
                    //echo $columns_value['size_id']; die;
                    $return_rate = $dbClass->insert("item_rate", $columns_value);
                }
                //echo $columns_value['size_id']; die;
            }

            if($return_rate){
                echo "1";
            }
            else{
                echo "0";
            }

        }
        else if(isset($item_id) && $item_id>0){
            var_dump($_REQUEST);die;
            //echo '333'; die;


            $is_order_result = $dbClass->getSingleRow("select distinct(d.order_id) order_id, p.category_id 
													FROM items p
													LEFT JOIN order_details d on d.item_id = p.item_id  	
													WHERE p.item_id = $item_id");


            if($is_order_result['category_id'] != $category_option){
                if($is_order_result['order_id'] != "" || $is_order_result['order_id'] != NULL) { echo 3; die;}
            }

            if(isset($_FILES['feature_image_upload']) && $_FILES['feature_image_upload']['name'] != ""){
               // echo '11'; die;

                $prev_feature_attachment = $dbClass->getSingleRow("select feature_image from items where item_id = $item_id");
                if($prev_feature_attachment['feature_image'] != "" || $prev_feature_attachment['feature_image'] != NULL){
                    unlink("../images/item/".$prev_feature_attachment['feature_image']);
                }

                $desired_dir = "../images/item";
                chmod( "../images/item", 0777);

                $file_name = $_FILES['feature_image_upload']['name'];
                $file_size =$_FILES['feature_image_upload']['size'];
                $file_tmp =$_FILES['feature_image_upload']['tmp_name'];
                $file_type=$_FILES['feature_image_upload']['type'];
                if($file_size < $file_max_length){
                    if(file_exists("$desired_dir/".$file_name)==false){
                        if(move_uploaded_file($file_tmp,"$desired_dir/".$file_name))
                            $feature_image = "$file_name";
                    }
                    else{//rename the file if another one exist
                        $new_dir="$desired_dir/".time().$file_name;
                        if(rename($file_tmp,$new_dir)){
                            $feature_image =time()."$file_name";
                        }
                    }
                    chmod( "../images/item/".$feature_image, 0775);
                }
                else{
                    echo $img_error_ln;die;
                }
                $columns_value = array(
                    'feature_image'=>$feature_image
                );
                $condition_array = array(
                    'item_id'=>$item_id
                );
                $return_image = $dbClass->update("items", $columns_value,$condition_array);
            }
            else{
                //echo '11'; die;

                if(!isset($_POST['is_feature'])){
                    $prev_feature_attachment = $dbClass->getSingleRow("select feature_image from items where item_id = $item_id");
                    //var_dump($prev_feature_attachment);die;
                    //echo '11'; die;

                    if($prev_feature_attachment['feature_image'] != "" || $prev_feature_attachment['feature_image'] != NULL){
                        // not working properly
                        //echo '11'; die;

                        $columns_value = array(
                            'feature_image'=>""
                        );
                        $condition_array = array(
                            'item_id'=>$item_id
                        );
                        $return_image = $dbClass->update("items", $columns_value,$condition_array);
                        //echo "hei---".$return_image;die;
                        if($return_image){
                            unlink("../images/item/".$prev_feature_attachment['feature_image']);
                        }
                        //-----------------------
                    }
                }

            }



            $is_active=0;
            if(isset($_POST['is_active'])){
                $is_active=1;
            }

            $sell_from_stock=0;
            if(isset($_POST['sell_from_stock'])){
                $sell_from_stock=1;
            }
            //echo $item_name; die;

            $columns_value = array(
                'name'=>$item_name,
                'code'=>$item_code,
                'details'=>$details,
                'category_id'=>$category_option,
                'availability'=>$is_active,
                'sell_from_stock'=>$sell_from_stock,
                'tags'=>$tag
            );
            $condition_array = array(
                'item_id'=>$item_id
            );
            $return_item = $dbClass->update("items", $columns_value,$condition_array);
           // echo '13q1'; die;


            if(isset($ingredient)){
                $condition_array = array(
                    'item_id'=>$item_id
                );
                $return = $dbClass->delete("item_ingredient", $condition_array);

                foreach($ingredient as $row){
                    //echo $price; die;
                    $columns_value = array(
                        'item_id'=>$item_id,
                        'ingredient_id'=>$row,
                    );
                    //echo '13q1'; die;

                    $return_ingredient = $dbClass->insert("item_ingredient", $columns_value);


                }
            }
            //echo $size_id; die;
            //echo '13q1'; die;

            if(isset($size_id)){
                //echo $size_id; die;

                $condition_array = array(
                    'item_id'=>$item_id
                );
                $return = $dbClass->delete("item_rate", $condition_array);

                foreach($size_id as $key=>$row){
                    $columns_value = array(
                        'item_id'=>$item_id,
                        'size_id'=>$size_id[$key],
                        'unit_id'=>$unit_id[$key],
                        'production_rate'=>$production_rate[$key],
                        'stock_quantity'=>$stock_quantity[$key],
                        'rate'=>$rate[$key],
                        'discount_type'=>$discount_type[$key],
                        'discount_amount'=>$discount_amount[$key],
                        'discounted_rate'=>$discounted_rate[$key]
                    );
                    $return_rate = $dbClass->insert("item_rate", $columns_value);
                }
            }
            //echo '1'; die;

            $attachments = "";
            if(isset($_FILES['attached_file']) && $_FILES['attached_file']['name'][0] != ""){
                $desired_dir = "../images/item";
                $desired_dir_thumb = "../images/item/thumb";
                chmod( "../images/item", 0775);
                chmod( "../images/item/thumb", 0777);

                foreach($_FILES['attached_file']['tmp_name'] as $key => $tmp_name ){
                    $file_name = $_FILES['attached_file']['name'][$key];
                    $file_size =$_FILES['attached_file']['size'][$key];
                    $file_tmp =$_FILES['attached_file']['tmp_name'][$key];
                    $file_type=$_FILES['attached_file']['type'][$key];
                    if($file_size < $file_max_length){
                        if(file_exists("$desired_dir/".$file_name)==false){
                            $dbClass->store_uploaded_image($file_tmp, 300, 300, $desired_dir_thumb, "$desired_dir/thumb/".$file_name) ;
                            $dbClass->store_uploaded_image($file_tmp, 550, 550, $desired_dir_thumb, "$desired_dir/".$file_name) ;
                            $attachments = "$file_name";
                            /*if(move_uploaded_file($file_tmp,"$desired_dir/".$file_name)){
                            }*/
                        }
                        else{//rename the file if another one exist
                            $new_dir="$desired_dir/".time().$file_name;
                            $dbClass->store_uploaded_image($file_tmp, 300, 300, $desired_dir_thumb, "$desired_dir/thumb/".$file_name) ;
                            if(rename($file_tmp,$new_dir)){
                                $attachments =time()."$file_name";
                            }
                        }
                        chmod( "../images/item/".$attachments, 0775);
                        $columns_value = array(
                            'item_id'=>$item_id,
                            'item_image'=>$attachments
                        );
                        $return_details = $dbClass->insert("item_image",$columns_value);
                    }
                    else{
                        echo $img_error_ln;die;
                    }
                }
            }
            if($return_item) echo "2";
            else echo "0";
        }
        break;

    case "grid_data":
        $start = ($page_no*$limit)-$limit;
        $end   = $limit;
        $data = array();

        $entry_permission   	    = $dbClass->getUserGroupPermission(62);
        $delete_permission          = $dbClass->getUserGroupPermission(63);
        $update_permission          = $dbClass->getUserGroupPermission(64);

        $category_grid_permission   = $dbClass->getUserGroupPermission(65);

        $condition = "";
        //echo '1', die;

        //# advance search for grid
        if($search_txt == "Print" || $search_txt == "Advance_search"){
            // for advance condition
            if($is_active_status !=2) $condition  .=" WHERE availability = $is_active_status ";
            if($ad_category_id != '') $condition  .=" and category_id = $ad_category_id ";
            if($ad_item_id != '')  $condition  .=" and item_id = $ad_item_id ";
            //echo '4';die;

        }
        // textfield search for grid
        else{
            //echo '5';die;

            $condition .=	" WHERE CONCAT(item_id, name, category_head_name) LIKE '%$search_txt%' ";
        }

        $countsql = "SELECT count(item_id)
					FROM(
					SELECT i.category_id, i.item_id, i.name, i.details, i.price as i_rate,i.availability,
						CASE WHEN c.parent_id IS NULL THEN c.name WHEN c.parent_id IS NOT NULL THEN CONCAT(ec.name,' >> ',c.name) END category_head_name,
						(CASE i.availability WHEN 1 THEN 'Available' WHEN 0 THEN 'Not-Available' END) active_status	
						FROM items i
						LEFT JOIN item_rate r on r.item_id = i.item_id
						LEFT JOIN category c on c.id = i.category_id
						LEFT JOIN category ec ON c.parent_id = ec.id
						LEFT JOIN size s on s.id = r.size_id
						group by i.item_id
						ORDER BY i.item_id DESC  
					)A
					$condition";
        //echo $countsql;die;
        $stmt = $conn->prepare($countsql);
        $stmt->execute();
        $total_records = $stmt->fetchColumn();
        $data['total_records'] = $total_records;
        $data['entry_status'] = $entry_permission;
        $total_pages = $total_records/$limit;
        $data['total_pages'] = ceil($total_pages);
        if($category_grid_permission==1){
            $sql = 	"SELECT category_id, item_id, name, category_head_name, i_rate, details,active_status,availability,
					$update_permission as update_status, $delete_permission as delete_status
					FROM(
						SELECT i.category_id, i.item_id, i.name, i.details, i.price as i_rate,i.availability,
						CASE WHEN c.parent_id IS NULL THEN c.name WHEN c.parent_id IS NOT NULL THEN CONCAT(ec.name,' >> ',c.name) END category_head_name,
						(CASE i.availability WHEN 1 THEN 'Available' WHEN 0 THEN 'Not-Available' END) active_status	
						FROM items i
						LEFT JOIN item_rate r on r.item_id = i.item_id
						LEFT JOIN category c on c.id = i.category_id
						LEFT JOIN category ec ON c.parent_id = ec.id
						LEFT JOIN size s on s.id = r.size_id
						group by i.item_id
						ORDER BY i.item_id DESC
					)A
					$condition
					ORDER BY item_id DESC
					LIMIT $start, $end";
            //echo $sql;die;
            $stmt = $conn->prepare($sql);
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            foreach ($result as $row) {
                $data['records'][] = $row;
            }
            echo json_encode($data);
        }
        break;

    case "load_options":

        $sql = "SELECT id,name, minimum_choice, maximum_choice,
            case is_required when 1 then 'yes' else 'no' end is_required
            FROM item_options
            WHERE item_id = '$item_id'";

        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        foreach ($result as $row) {
            $data['records'][] = $row;
        }
        echo json_encode($data);
        //echo 1; die;
    break;

    case "load_options_items":
        $update_permission = $dbClass->getUserGroupPermission(64);
        if($update_permission==1) {
            $sql = "SELECT id,name, minimum_choice, maximum_choice, is_required 
                FROM item_options
                WHERE id = $option_id";
            $data['records'] = $dbClass->getSingleRow($sql);


            $sql = "SELECT id, name , price 
                FROM options_items
                WHERE option_id= $option_id";
            $stmt = $conn->prepare($sql);
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            foreach ($result as $row) {
                $data['ingredients'][] = $row;
            }
            echo json_encode($data);
            die;
        }

    break;


    case "get_item_details":
        $update_permission = $dbClass->getUserGroupPermission(64);
        if($update_permission==1){
            $sql = "SELECT p.item_id, p.name, p.price, p.details, c.id category_id, p.availability,feature_image
					FROM items p
					LEFT JOIN category c ON c.id = p.category_id
					WHERE p.item_id= $item_id";
            //echo $sql; die;
            $stmt = $conn->prepare($sql);
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            foreach ($result as $row) {
                $data['records'][] = $row;
            }
            echo json_encode($data); die;



            echo json_encode($data);
        }
        break;

    case "category_wise_item_code":
        $category_id 	= $_POST['category_id'];
        $category_code  = $_POST['category_code'];

        $last_item_code = $dbClass->getSingleRow("SELECT MAX(SUBSTR(p.code,LENGTH(c.code)+1)) item_code	
													FROM items p 
													LEFT JOIN category c on c.id = p.category_id
													WHERE c.id = '$category_id' AND LEFT(p.code,LENGTH(c.code)) = c.code");

        if($last_item_code['item_code'] == 'NULL' || $last_item_code['item_code'] == ''){
            $new_item_code = $category_code.'0001';
        }
        else{
            $new_item_code = $category_code.$last_item_code['item_code']+1;
        }
        echo $new_item_code;
        break;

    case "delete_attached_file":
        $attachment_name = $dbClass->getSingleRow("select item_image from item_image where id = $img_id");
        $condition_array = array(
            'id'=>$img_id
        );

        if($dbClass->delete("item_image", $condition_array)){
            unlink("../images/item/".$attachment_name['item_image']);
            unlink("../images/item/thumb/".$attachment_name['item_image']);
            echo 1;
        }
        else
            echo 0;
        break;

    case "delete_item":
        $delete_permission = $dbClass->getUserGroupPermission(63);
        //echo $delete_permission; die;
        if($delete_permission==1){
            $condition_array = array(
                'item_id'=>$item_id
            );
            $columns_value = array(
                'availability'=>0
            );
            $return = $dbClass->update("items", $columns_value, $condition_array);
            /* $prev_attachment = $dbClass->getResultList("select item_image from item_image where item_id=$item_id");
            foreach($prev_attachment as $row){
                unlink("../images/item/".$row['item_image']);
                unlink("../images/item/thumb/".$attachment_name['item_image']);
            }
            $condition_array = array(
                'item_id'=>$item_id
            );

            $return = $dbClass->delete("item_ingredient", $condition_array);
            $return = $dbClass->delete("item_rate", $condition_array);
            $return = $dbClass->delete("item_image", $condition_array);
            $return = $dbClass->delete("items", $condition_array); */
        }
        if($return) echo "1";
        else 		echo "0";
        break;

    case "view_category":
        $data = array();
        $details = $dbClass->getResultList("SELECT id, CONCAT(code,' >> ',head_name)category_name 
											FROM (
												SELECT c.id, c.code, 
												CASE WHEN c.parent_id IS NULL THEN c.name WHEN c.parent_id IS NOT NULL THEN CONCAT(ec.name,' >> ',c.name) END head_name
												FROM category c
												LEFT JOIN category ec ON c.parent_id = ec.id
												ORDER BY c.id
											) A");
        foreach ($details as $row) {
            $data['records'][] = $row;
        }
        echo json_encode($data);
        break;

    case "option_info":
        $sql_query = "SELECT name 
                    FROM item_options 
                    WHERE name LIKE '%$term%'
                    GROUP BY name
                    ORDER BY name";

        //echo $sql_query; die;
        $stmt = $conn->prepare($sql_query);
        $stmt->execute();
        $json = array();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $count = $stmt->rowCount();
        if($count>0){
            foreach ($result as $row) {
                $json[] = $row;
            }
        } else {
            $json[] = array('name' => "",'label' => "No option Found !!!");
        }
        echo json_encode($json);
        break;


    case "ingredient_info":
        $sql_query = "SELECT name, id, price
                    FROM ingredient 
                    WHERE name LIKE '%$term%'
                    ORDER BY name";

        //echo $sql_query; die;
        $stmt = $conn->prepare($sql_query);
        $stmt->execute();
        $json = array();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $count = $stmt->rowCount();
        if($count>0){
            foreach ($result as $row) {
                $json[] = $row;
            }
        } else {
            $json[] = array('name' => "",'label' => "No option Found !!!");
        }
        echo json_encode($json);
        break;

    case "size_info":
        $sql_query = "SELECT id, name, code, CONCAT_WS(' >> ',code,name) sizeDetails
					FROM size WHERE CONCAT(name, code) LIKE '%$term%'
					ORDER BY name";
        $stmt = $conn->prepare($sql_query);
        $stmt->execute();
        $json = array();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $count = $stmt->rowCount();
        if($count>0){
            foreach ($result as $row) {
                $json[] = array('id' => $row["id"],'label' => $row["name"]);
            }
        } else {
            $json[] = array('id' => "0",'label' => "No Size Name Found !!!");
        }
        echo json_encode($json);
        break;

    case "unit_info":
        $sql_query = "SELECT id, unit_name, short_name, CONCAT(unit_name,' (',short_name,')') unitDetails
					FROM units WHERE status=1 and  CONCAT(unit_name, short_name) LIKE '%$term%'
					ORDER BY unit_name";
        $stmt = $conn->prepare($sql_query);
        $stmt->execute();
        $json = array();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $count = $stmt->rowCount();
        if($count>0){
            foreach ($result as $row) {
                $json[] = array('id' => $row["id"],'label' => $row["unitDetails"]);
            }
        } else {
            $json[] = array('id' => "0",'label' => "No Unit Found !!!");
        }
        echo json_encode($json);
        break;

}

function resizeImage($filename, $newwidth, $newheight){
    list($width, $height) = getimagesize($filename);
    if($width > $height && $newheight < $height){
        $newheight = $height / ($width / $newwidth);
    } else if ($width < $height && $newwidth < $width) {
        $newwidth = $width / ($height / $newheight);
    } else {
        $newwidth = $width;
        $newheight = $height;
    }
    $thumb = imagecreatetruecolor($newwidth, $newheight);
    $source = imagecreatefromjpeg($filename);
    imagecopyresized($thumb, $source, 0, 0, 0, 0, $newwidth, $newheight, $width, $height);
    return imagejpeg($thumb);
}


?>
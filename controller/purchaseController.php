<?php 
session_start();
include '../includes/static_text.php';
include("../dbConnect.php");
include("../dbClass.php");

$dbClass = new dbClass;
$conn       = $dbClass->getDbConn();
$loggedUser = $dbClass->getUserId();	
$permission = $dbClass->getUserGroupPermission(102);		

extract($_REQUEST);

switch ($q){
	/************************************************ Expense CRUD ***************************************************/
	
	case "insert_or_update_expense":
		if(isset($expense_id) && $expense_id == ""){
			$last_id_no 	 = $dbClass->getSingleRow("SELECT (IFNULL(MAX(SUBSTR(expense_reference_no,12)),0)+1) last_no  FROM expenses WHERE DATE_FORMAT(expense_date, '%Y') = ".date('Y')." AND DATE_FORMAT(expense_date, '%m')=".date('m'));
			$expense_reference_no 		 = 'EXP'.date('Y').'/'.str_pad(date('m'),2,'0',STR_PAD_LEFT).'/'.str_pad($last_id_no['last_no'],6,'0',STR_PAD_LEFT);
			
			if(isset($_FILES['expense_attachment']) && $_FILES['expense_attachment']['name']!= ""){
				$desired_dir = "../document/purchase";
				chmod( "../document/purchase", 0777);
				$file_name = $_FILES['expense_attachment']['name'];
				$file_size =$_FILES['expense_attachment']['size'];
				$file_tmp =$_FILES['expense_attachment']['tmp_name'];
				$file_type=$_FILES['expense_attachment']['type'];	
				if($file_size < $file_max_length){
					if(file_exists("$desired_dir/".$file_name)==false){
						if(move_uploaded_file($file_tmp,"$desired_dir/".$file_name))
							$attachment = "$file_name";
					}
					else{//rename the file if another one exist
						$new_dir="$desired_dir/".time().$file_name;
						if(rename($file_tmp,$new_dir))
							$attachment =time()."$file_name";				
					}				
				}
				else {
					echo $img_error_ln;die;
				}			
			}
			else{
				$attachment  = "";	
			}

			$columns_value = array(
				'expense_reference_no'=>$expense_reference_no,
				'expense_date'=>$expense_date,
				'expense_amount'=>$expense_amount,
				'balance'=>$expense_amount,
				'expense_type'=>$expense_type,
				'resposible_person_id'=>$people_emp_id,
				'company_id'=>$company_id,
				'season_id'=>$season_id,
				'payment_status'=>$payment_status,				
				'description'=>$description,
				'status'=>$status,
				'attachment'=>$attachment,
				'created_by'=>$loggedUser
			);	
			//$dbClass->print_arrays($columns_value);
			$return = $dbClass->insert("expenses", $columns_value);

			if(is_numeric($return) && $return>0) {
				if(is_array($expense_ids)){
					foreach($expense_ids as $key=>$value){
						$columns_value = array(
							'expense_id'=>$return,
							'expense_head_id'=>$value,
							'description'=>$exp_description[$key],
							'amount'=>$amount[$key]
						);
						$return_succes = $dbClass->insert("expense_details",$columns_value);
					}
				}
			}	
			if($return_succes) echo "1";
			else 	echo "0";
		}
		else{
			$expense = $dbClass->getSingleRow("SELECT * from expenses where id=$expense_id");
			$columns_value = array(
				'expense_date'=>$expense_date,
				'expense_amount'=>$expense_amount,
				'balance'=>($expense_amount-$expense['paid_amount']),
				'expense_type'=>$expense_type,
				'resposible_person_id'=>$people_emp_id,
				'company_id'=>$company_id,
				'season_id'=>$season_id,
				'payment_status'=>$payment_status,				
				'description'=>$description,
				'status'=>$status,
				'modified_by'=>$loggedUser
			);
			$desired_dir = "../document/purchase";
			if(isset($_FILES['expense_attachment']) && $_FILES['expense_attachment']['name']!= ""){				
				chmod( "../document/purchase", 0777);
				$file_name = $_FILES['expense_attachment']['name'];
				$file_size =$_FILES['expense_attachment']['size'];
				$file_tmp =$_FILES['expense_attachment']['tmp_name'];
				$file_type=$_FILES['expense_attachment']['type'];	
				if($file_size < $file_max_length){
					if(file_exists("$desired_dir/".$file_name)==false){
						if(move_uploaded_file($file_tmp,"$desired_dir/".$file_name))
							$attachment = "$file_name";
					}
					else{//rename the file if another one exist
						$new_dir="$desired_dir/".time().$file_name;
						if(rename($file_tmp,$new_dir))
							$attachment =time()."$file_name";				
					}
					$columns_value['attachment']=$attachment;
					
				}
				else {
					echo $img_error_ln;die;
				}			
			}
			else{
				$attachment  = "";	
			}
		 //$dbClass->print_arrays($columns_value);			
			$condition_array = array(
				'id'=>$expense_id
			);	
			$return = $dbClass->update("expenses", $columns_value, $condition_array);
				

			if($return) {
				if($expense['attachment']) unlink($desired_dir.'/'.$expense['attachment']);
				if(is_array($expense_ids)){
				// delete old item details 
					$condition_array = array(
						'expense_id'=>$expense_id
					);
					$del_return = $dbClass->delete("expense_details", $condition_array);					
					if($del_return){					
						// re-entry new items data			
						foreach($expense_ids as $key=>$value){
							$columns_value = array(
								'expense_id'=>$expense_id,
								'expense_head_id'=>$value,
								'description'=>$exp_description[$key],
								'amount'=>$amount[$key]
							);
							$return_succes = $dbClass->insert("expense_details",$columns_value);
						}
					}
					if($return_succes)	echo "2";
				}
			}
			else 	echo "0";
		}
	break;
	
	case "expense_grid_data":	
		$start = ($page_no*$limit)-$limit;
		$end   = $limit;
		$data = array();
	
		//# advance search for grid		
		if($search_txt == "Print" || $search_txt == "Advance_search"){
			$end_date 	 = ($start_date && (!$end_date))?date('Y-m-d'):$end_date;
			$start_date  = ($end_date && (!$start_date))?'2018-01-01':$start_date;
			
			$conditions = array();
			$conditions[] = ($adv_company_id)?" company_id=$adv_company_id":"";
			$conditions[] = ($adv_season_id)?"  season_id=$adv_season_id":"";
			$conditions[] = ($start_date && $end_date)?" expense_date between '$start_date' AND '$end_date' ":"";
			$conditions[] = ($adv_people_emp_id)?" resposible_person_id=$adv_people_emp_id":"";
			$conditions[] = ($adv_expense_type!=3)?" expense_type=$adv_expense_type":"";
			$conditions[] = ($adv_payment_status != 4)?" payment_status=$adv_payment_status":"";
			$conditions[] = ($adv_status != 2)?" status=$adv_status":"";
			
			// return the condition array
			$condition = $dbClass->arrangeCondition($conditions);			
		}
		else{
			$condition =	" where CONCAT(expense_reference_no,expense_date,ifnull(description,''), status_text,payment_status_text,expense_status_text,resposible_person_name,company_name, season_name) LIKE  '%$search_txt%'";			
		}

		//echo $condition;die;
		$countsql = "SELECT COUNT(id)
					FROM(
						SELECT e.id, expense_reference_no,  expense_date, round(expense_amount,2) expense_amount , expense_type, ifnull(description,'') as description,
						round(paid_amount) paid_amount , round(balance) balance, e.status, payment_status, resposible_person_id, e.company_id, season_id, attachment, 
						CASE e.status WHEN 0 THEN 'Deleted' WHEN 1 THEN 'Active' END status_text, 
						CASE payment_status WHEN 1 THEN 'Due' WHEN 2 THEN 'Partial' WHEN 3 THEN 'Paid' END payment_status_text, 
						CASE expense_type WHEN 1 THEN 'Cash' WHEN 2 THEN 'Credit' END expense_status_text,
						cm.company_name, s.season_name,	 p.NAME AS resposible_person_name
						FROM expenses e
						LEFT JOIN companies cm ON cm.company_id= e.company_id
						LEFT JOIN seasons s ON s.id= e.season_id
						LEFT JOIN peoples p ON p.id= e.resposible_person_id
						ORDER BY id ASC
					)A 
					$condition";
		//echo $countsql;die;
		$stmt = $conn->prepare($countsql);
		$stmt->execute();
		$total_records = $stmt->fetchColumn();
		$data['total_records'] = $total_records;
		$data['entry_status'] = $permission; 		
		$total_pages = $total_records/$limit;		
		$data['total_pages'] = ceil($total_pages); 
		if($permission==1){
			$sql = 	"SELECT id,expense_date, expense_reference_no, payment_status_text,  resposible_person_name,expense_status_text, expense_amount, paid_amount,balance , status_text , $permission as update_status, $permission as delete_status, $permission as view_status
					FROM(
						SELECT e.id, expense_reference_no,  expense_date, round(expense_amount,2) expense_amount , expense_type, ifnull(description,'') as description,
						round(paid_amount) paid_amount , round(balance) balance, e.status, payment_status, resposible_person_id, e.company_id, season_id, attachment, 
						CASE e.status WHEN 0 THEN 'Deleted' WHEN 1 THEN 'Active' END status_text, 
						CASE payment_status WHEN 1 THEN 'Due' WHEN 2 THEN 'Partial' WHEN 3 THEN 'Paid' END payment_status_text, 
						CASE expense_type WHEN 1 THEN 'Cash' WHEN 2 THEN 'Credit' END expense_status_text,
						cm.company_name, s.season_name,	 p.NAME AS resposible_person_name
						FROM expenses e
						LEFT JOIN companies cm ON cm.company_id= e.company_id
						LEFT JOIN seasons s ON s.id= e.season_id
						LEFT JOIN peoples p ON p.id= e.resposible_person_id
						ORDER BY id ASC
					)A 
					$condition
					ORDER BY id DESC
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
	
	case "get_expense_details":
		if($permission==1){
			$expense_details = $dbClass->getResultList("SELECT e.id, expense_reference_no,  expense_date, expense_amount, expense_type, ifnull(description,'') as description,
							paid_amount, balance, e.status, payment_status, resposible_person_id, e.company_id, season_id, ifnull(attachment,'') attachment, 
							CASE e.status WHEN 0 THEN 'Deleted' WHEN 1 THEN 'Active' END status_text, 
							CASE payment_status WHEN 1 THEN 'Due' WHEN 2 THEN 'Partial' WHEN 3 THEN 'Paid' END payment_status_text, 
							CASE expense_type WHEN 1 THEN 'Cash' WHEN 2 THEN 'Credit' END expense_type_text,
							cm.company_name, s.season_name,	 p.NAME AS resposible_person_name
							FROM expenses e
							LEFT JOIN companies cm ON cm.company_id= e.company_id
							LEFT JOIN seasons s ON s.id= e.season_id
							LEFT JOIN peoples p ON p.id= e.resposible_person_id
							WHERE e.id='$expense_id'");
			//echo $expense_details; die;
			
			foreach ($expense_details as $row){
				$sql ="SELECT eh.id, concat(ec.expense_cat_name,'=>',eh.expense_head_name) as head_name, ed.amount as amount, ed.description  exp_details
				FROM  expense_details ed 
				LEFT JOIN expense_heads eh ON eh.id=ed.expense_head_id
				LEFT JOIN expense_categories ec ON eh.expense_category_id=ec.id
				WHERE ed.expense_id=".$expense_id;
				//echo $sql;die;
				$stmt = $conn->prepare($sql);
				$stmt->execute();
				$json = array();
				$result = $stmt->fetchAll(PDO::FETCH_ASSOC);			
				$count = $stmt->rowCount();
				
				if($count>0){
					foreach ($result as $roww) {
						$json[] = array('id' => $roww["id"],'expense_id' => $roww["id"],'label' => $roww["head_name"],  'row'=>$roww);
					}
				} else {
					$json[] = array('id' => "0",'label' => "Not Found !!!");
				}			
				array_push($row, $row['items']=$json);
				//$dbClass->print_arrays($row);
				$data['records'][] = $row;
			}
			echo json_encode($data);
		}
	break;
	
	
	case "delete_expense":
		if($permission==1){
			$condition_array = array(
				'company_id'=>$expense_id
			);
			$columns_value = array(
				'status'=>0
			);
			$return = $dbClass->update("expenses", $columns_value, $condition_array);
		}
		if($return==1) echo "1";
		else 		   echo "0";
	break;
	/*----------------------------------------------- END Expense CRUD ---------------------------------------------------*/
	
	
	
	
	

	/************************************************ Purchase CRUD ***************************************************/

	
	case "insert_or_update_purchase":	
		//$dbClass->print_arrays($_POST);
		if(isset($purchase_id) && $purchase_id == ""){
			$last_id_no 	 = $dbClass->getSingleRow("SELECT (IFNULL(MAX(SUBSTR(purchase_reference_no,11)),0)+1) last_no  FROM purchases WHERE DATE_FORMAT(purchase_date, '%Y') = ".date('Y')." AND DATE_FORMAT(purchase_date, '%m')=".date('m'));
			$purchase_reference_no 		 = 'PO'.date('Y').'/'.str_pad(date('m'),2,'0',STR_PAD_LEFT).'/'.str_pad($last_id_no['last_no'],6,'0',STR_PAD_LEFT);
			
			if(isset($_FILES['purchase_attachment']) && $_FILES['purchase_attachment']['name']!= ""){
				$desired_dir = "../document/purchase";
				chmod( "../document/purchase", 0777);
				$file_name = $_FILES['purchase_attachment']['name'];
				$file_size =$_FILES['purchase_attachment']['size'];
				$file_tmp =$_FILES['purchase_attachment']['tmp_name'];
				$file_type=$_FILES['purchase_attachment']['type'];	
				if($file_size < $file_max_length){
					if(file_exists("$desired_dir/".$file_name)==false){
						if(move_uploaded_file($file_tmp,"$desired_dir/".$file_name))
							$attachment = "$file_name";
					}
					else{//rename the file if another one exist
						$new_dir="$desired_dir/".time().$file_name;
						if(rename($file_tmp,$new_dir))
							$attachment =time()."$file_name";				
					}				
				}
				else {
					echo $img_error_ln;die;
				}			
			}
			else{
				$attachment  = "";	
			}
			$columns_value = array(
				'purchase_reference_no'=>$purchase_reference_no,
				'supplier_id'=>$supplier_id,
				'purchased_by'=>$people_emp_id,
				'purchase_date'=>$purchase_date,
				'purchase_status'=>$purchase_type,
				'discount'=>$podiscount,
				'transport_bill'=>$potransport,
				'labour_bill'=>$polabour,
				'total_bill'=>$purchase_amount,
				'balance'=>$purchase_amount,
				'company_id'=>$company_id,
				'season_id'=>$season_id,
				'payment_status'=>$payment_status,				
				'note'=>$note,
				'status'=>$status,
				'attachment'=>$attachment,
				'created_by'=>$loggedUser
			);	
			//$dbClass->print_arrays($columns_value);
			$return = $dbClass->insert("purchases", $columns_value);
			if(is_numeric($return) && $return>0) {
				if(is_array($item_id)){
					foreach($item_id as $key=>$value){
						$columns_value = array(
							'purchase_id'=>$return,
							'item_id'=>$value,
							'rate'=>$price[$key],
							'quantity'=>$quantity[$key],
							'unit'=>$unit_id[$key]
						);
						$return_succes = $dbClass->insert("purchase_items",$columns_value);
					}
				}
			}	
			if($return_succes) echo "1";
			else 	echo "0";
		}
		else{
			$purchase = $dbClass->getSingleRow("SELECT * from purchases where id=$purchase_id");
			$columns_value = array(
				'supplier_id'=>$supplier_id,
				'purchased_by'=>$people_emp_id,
				'purchase_date'=>$purchase_date,
				'purchase_status'=>$purchase_type,
				'discount'=>$podiscount,
				'transport_bill'=>$potransport,
				'labour_bill'=>$polabour,
				'total_bill'=>$purchase_amount,
				'balance'=>($purchase_amount-$purchase['paid']),
				'company_id'=>$company_id,
				'season_id'=>$season_id,
				'payment_status'=>$payment_status,				
				'note'=>$note,
				'status'=>$status,
				'modified_by'=>$loggedUser
			);
			

			if(isset($_FILES['purchase_attachment']) && $_FILES['purchase_attachment']['name']!= ""){
				$desired_dir = "../document/purchase";
				chmod( "../document/purchase", 0777);
				$file_name = $_FILES['purchase_attachment']['name'];
				$file_size =$_FILES['purchase_attachment']['size'];
				$file_tmp =$_FILES['purchase_attachment']['tmp_name'];
				$file_type=$_FILES['purchase_attachment']['type'];	
				if($file_size < $file_max_length){
					if(file_exists("$desired_dir/".$file_name)==false){
						if(move_uploaded_file($file_tmp,"$desired_dir/".$file_name))
							$attachment = "$file_name";
					}
					else{//rename the file if another one exist
						$new_dir="$desired_dir/".time().$file_name;
						if(rename($file_tmp,$new_dir))
							$attachment =time()."$file_name";				
					}
					$columns_value['attachment']=$attachment;					
				}
				else {
					echo $img_error_ln;die;
				}			
			}
			else{
				$attachment  = "";	
			}

			//$dbClass->print_arrays($columns_value);	
			
			$condition_array = array(
				'id'=>$purchase_id
			);	
			$return = $dbClass->update("purchases", $columns_value, $condition_array);
							
			if($return) {
				if($purchase['attachment']) unlink($desired_dir.'/'.$purchase['attachment']);
				if(is_array($item_id)){
				// delete old item details 
					$condition_array = array(
						'purchase_id'=>$purchase_id
					);
					$del_return = $dbClass->delete("purchase_items", $condition_array);					
					if($del_return){					
						// re-entry new items data			
						foreach($item_id as $key=>$value){
							$columns_value = array(
								'purchase_id'=>$purchase_id,
								'item_id'=>$value,
								'rate'=>$price[$key],
								'quantity'=>$quantity[$key],
								'unit'=>$unit_id[$key]
							);
							$return_succes = $dbClass->insert("purchase_items",$columns_value);
						}
					}
					if($return_succes)	echo "2";
				}
			}
			else 	echo "0";
		}
	break;
	
	
	case "purchase_grid_data":	
		$start = ($page_no*$limit)-$limit;
		$end   = $limit;
		$data = array();
	
		//# advance search for grid		
		if($search_txt == "Print" || $search_txt == "Advance_search"){
			$end_date 	 = ($start_date && (!$end_date))?date('Y-m-d'):$end_date;
			$start_date  = ($end_date && (!$start_date))?'2018-01-01':$start_date;
			
			$conditions = array();
			$conditions[] = ($adv_company_id)?" company_id=$adv_company_id":"";
			$conditions[] = ($adv_season_id)?"  season_id=$adv_season_id":"";
			$conditions[] = ($start_date && $end_date)?" purchase_date between '$start_date' AND '$end_date' ":"";
			$conditions[] = ($adv_supplier_id)?" supplier_id=$adv_supplier_id":"";
			$conditions[] = ($adv_people_emp_id)?" purchased_by=$adv_people_emp_id":"";
			$conditions[] = ($adv_purchase_status!=4)?" purchase_status=$adv_purchase_status":"";
			$conditions[] = ($adv_payment_status != 4)?" payment_status=$adv_payment_status":""; 
			$conditions[] = ($adv_status != 2)?" status=$adv_status":"";
			
			// return the condition array
			$condition = $dbClass->arrangeCondition($conditions);			
		}
		else{
			$condition =	" where CONCAT(purchase_reference_no , supplier_name , company_name, purchase_date, purchased_by_name, payment_status_text, purchase_status_text, ifnull(note,''), season_name, status_text, item_details) LIKE  '%$search_txt%'";			
		}
		//echo $condition;die;
		$countsql = "SELECT COUNT(id)
					FROM(
						Select p.id,purchase_reference_no, p.supplier_id, s.name supplier_name,  p.company_id, c.company_name as company_name ,purchase_date,
						purchased_by, pb.name as purchased_by_name, discount,labour_bill,total_bill, 
						paid,balance,p.payment_status,purchase_status,ifnull( p.note,'') note,p.season_id, ss.season_name , p.status,attachment,
						CASE p.status WHEN 0 THEN 'Deleted' WHEN 1 THEN 'Active' END status_text,
						CASE payment_status WHEN 1 THEN 'Due' WHEN 2 THEN 'Partial' WHEN 3 THEN 'Paid' END payment_status_text,
						CASE purchase_status WHEN 1 THEN 'Purchased' WHEN 2 THEN 'Partial Received' WHEN 3 THEN 'Received' END purchase_status_text,
						group_concat(i.item_name, ' (',pd.quantity,u.short_name,') - ', round(pd.rate,2),' ') item_details
						from purchases p
						LEFT JOIN companies c on c.company_id=p.company_id
						LEFT JOIN peoples s on s.id=p.supplier_id
						LEFT JOIN peoples pb on pb.id=p.purchased_by
						LEFT JOIN seasons ss ON ss.id= p.season_id
						LEFT JOIN purchase_items pd ON pd.purchase_id=p.id
						LEFT JOIN items i on i.id=pd.item_id
						LEFT JOIN units u on u.id=pd.unit
						group by p.id
						order by p.id
					)A 
					$condition";
		//echo $countsql;die;
		$stmt = $conn->prepare($countsql);
		$stmt->execute();
		$total_records = $stmt->fetchColumn();
		$data['total_records'] = $total_records;
		$data['entry_status'] = $permission; 		
		$total_pages = $total_records/$limit;		
		$data['total_pages'] = ceil($total_pages); 
		if($permission==1){
			$sql = 	"SELECT id,purchase_reference_no, supplier_id, supplier_name,  company_id, company_name ,purchase_date,purchased_by,
					purchased_by_name, discount,labour_bill,total_bill, paid,balance,payment_status,purchase_status,note,
					season_id, season_name ,status,attachment,status_text, payment_status_text,purchase_status_text,item_details
					, $permission as update_status, $permission as delete_status, $permission as view_status
					FROM(
						Select p.id,purchase_reference_no, p.supplier_id, s.name supplier_name,  p.company_id, c.company_name as company_name ,purchase_date,
						purchased_by, pb.name as purchased_by_name, round(discount,2) discount,round(labour_bill,2) labour_bill,round(total_bill,2) total_bill, round(paid,2) paid,round(balance,2) balance
						,p.payment_status,purchase_status,ifnull( p.note,'') note,p.season_id, ss.season_name , p.status,attachment,
						CASE p.status WHEN 0 THEN 'Deleted' WHEN 1 THEN 'Active' END status_text,
						CASE payment_status WHEN 1 THEN 'Due' WHEN 2 THEN 'Partial' WHEN 3 THEN 'Paid' END payment_status_text,
						CASE purchase_status WHEN 1 THEN 'Purchased' WHEN 2 THEN 'Partial Received' WHEN 3 THEN 'Received' END purchase_status_text,
						group_concat(i.item_name, ' (',pd.quantity,u.short_name,') - ', round(pd.rate,2),' ') item_details
						from purchases p
						LEFT JOIN companies c on c.company_id=p.company_id
						LEFT JOIN peoples s on s.id=p.supplier_id
						LEFT JOIN peoples pb on pb.id=p.purchased_by
						LEFT JOIN seasons ss ON ss.id= p.season_id
						LEFT JOIN purchase_items pd ON pd.purchase_id=p.id
						LEFT JOIN items i on i.id=pd.item_id
						LEFT JOIN units u on u.id=pd.unit
						group by p.id
						order by p.id
					)A 
					$condition
					ORDER BY id DESC
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
	
	case "get_purchase_details":
		if($permission==1){
			$purchase_details = $dbClass->getResultList("Select p.id,purchase_reference_no, p.supplier_id, s.name supplier_name, s.mobile_no , s.email, s.address,  p.company_id, c.company_name as company_name ,purchase_date,
							purchased_by, pb.name as purchased_by_name, round(discount,2) discount, round(transport_bill,2) transport_bill, round(labour_bill,2) labour_bill,round(total_bill,2) total_bill, round(paid,2) paid,round(balance,2) balance
							,p.payment_status,purchase_status,ifnull( p.note,'') note,p.season_id, ss.season_name , p.status,attachment,
							CASE p.status WHEN 0 THEN 'Deleted' WHEN 1 THEN 'Active' END status_text,
							CASE payment_status WHEN 1 THEN 'Due' WHEN 2 THEN 'Partial' WHEN 3 THEN 'Paid' END payment_status_text,
							CASE purchase_status WHEN 1 THEN 'Purchased' WHEN 2 THEN 'Partial Received' WHEN 3 THEN 'Received' END purchase_status_text
							from purchases p
							LEFT JOIN companies c on c.company_id=p.company_id
							LEFT JOIN peoples s on s.id=p.supplier_id
							LEFT JOIN peoples pb on pb.id=p.purchased_by
							LEFT JOIN seasons ss ON ss.id= p.season_id						  
							WHERE p.id=$purchase_id");
		

			foreach ($purchase_details as $row){
				$sql ="select i.id, item_id, concat(ic.item_cat_name,' => ', i.item_name) as item_details,  unit as unit_id,  concat(u.unit_name,' (', u.short_name,')') as unit_name  , round(rate,2) price, round(quantity,2) qty
						from  purchase_items pd 
						LEFT JOIN items i on i.id=pd.item_id
						LEFT JOIN units u on u.id=pd.unit
						LEFT JOIN item_categories ic on ic.id=i.category_id
						where pd.purchase_id=".$purchase_id;
				//echo $sql;die;
				$stmt = $conn->prepare($sql);
				$stmt->execute();
				$json = array();
				$result = $stmt->fetchAll(PDO::FETCH_ASSOC);			
				$count = $stmt->rowCount();
				
				if($count>0){
					foreach ($result as $roww) {
						$json[] = array('id' => $roww["id"],'item_id' => $roww["id"],'label' => $roww["item_details"], 'price'=>$roww["price"], 'row'=>$roww);
					}
				} else {
					$json[] = array('id' => "0",'label' => "Not Found !!!");
				}			
				array_push($row, $row['items']=$json);
				//$dbClass->print_arrays($row);
				$data['records'][] = $row;
				
			}			
			echo json_encode($data);
		}
	break;
	
	case "delete_purchase":
		if($permission==1){
			$condition_array = array(
				'id'=>$purchase_id
			);
			$columns_value = array(
				'status'=>0
			);
			$return = $dbClass->update("purchases", $columns_value, $condition_array);
		}
		if($return==1) echo "1";
		else 		   echo "0";
	break;
	
	
	
}
?>
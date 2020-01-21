<?php
session_start();
include '../dbConnect.php';
include("../dbClass.php");

$dbClass = new dbClass;
extract($_REQUEST);

switch ($q) {
    case "groups":
        $sql = "SELECT * FROM groups_info WHERE user_id=$customer_id order by id desc";
        //echo $sql;die;
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        if($result==null){
            echo 0;
        }
        else{
            foreach ($result as $row) {
                $data['records'][] = $row;
            }
            echo json_encode($data);
        }
    break;

    case "group_details":
        //echo $group_id;
        $sql = "SELECT name, email FROM group_members where group_id=".$group_id;
        //echo $sql;die;
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        if($result==null){
            echo 0;
        }
        else{
            $group_name=  $dbClass->getSingleRow("SELECT name from groups_info WHERE id=".$group_id);


            foreach ($result as $row) {
                $data['records'][] = $row;
            }
            $data['name']=$group_name['name'];
            echo json_encode($data);
        }
        //var_dump($data);
    break;

    case "insert_or_update":


        if(isset($customer_id) && $customer_id != "") {
            $columns_value = array(
                'user_id'=>$customer_id,
                'name'=>$group_name,
                'members'=>$members,
            );
            $return_master = $dbClass->insert("groups_info", $columns_value);

            $user_info=  $dbClass->getSingleRow("SELECT full_name as name , email from customer_infos WHERE customer_id=".$customer_id);
            $user_info['group_id']=$return_master;
            $dbClass->insert("group_members", $user_info);


            while ($members>0){
                $columns_value = array(
                    'group_id'=>$return_master,
                    'name'=>$name[$members-1],
                    'email'=>$email[$members-1],
                );
                $dbClass->insert("group_members", $columns_value);
                $members--;
            }

            echo 1;

        }


        break;

}
?>
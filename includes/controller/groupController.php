<?php
session_start();
include '../dbConnect.php';
include("../dbClass.php");

$dbClass = new dbClass;
extract($_REQUEST);

switch ($q) {
    case "initiate_group_order":
        $count=1;
        $group_order_details_id='';
        $order_key='';
        foreach ($memberName as $users){
            $count++;
        }
        $customer_info = $dbClass->getSingleRow("SELECT full_name, email from customer_infos WHERE customer_id=" . $_SESSION['customer_id']);
        //var_dump($memberName);
        $memberName[$count-1]=$customer_info['full_name'];
        //var_dump($memberName);

        $memberEmail[$count-1]=$customer_info['email'];
        //var_dump($memberName[0]); die;
        if($id_group!='0') {
            $group_info = $dbClass->getSingleRow("SELECT name, members from groups_info WHERE id=" . $id_group);
            $columns_value = array(
                'customer_id' => $_SESSION['customer_id'],
                'group_id' => $id_group,
                'delivery_date' => $pickup_date_time,
                'notification_time' => $notification_date_time,
                'order_status' => 1,
            );
            $group_order_id = $dbClass->insert("group_order", $columns_value);
            $i=0;

            while ($i < ($count - 1)) {
                // var_dump("SELECT id FROM group_members WHERE group_id=$id_group AND name = $memberName[$i] AND email= ".$memberEmail[$i]);
                $sql = "SELECT id FROM group_members WHERE group_id=$id_group AND name = '$memberName[$i]' AND email=  '$memberEmail[$i]' ";
                $members_id = $dbClass->getSingleRow($sql);
                //var_dump( $group_order_id);
                if ($members_id == '') {
                    $member_array = array(
                        'name' => $memberName[$i],
                        'email' => $memberEmail[$i],
                        'group_id' => $id_group
                    );
                    $group_member_id = $dbClass->insert("group_members", $member_array);
                    //var_dump($group_member_id);
                } else {
                    $group_member_id = (int)$members_id['id'];
                }
                $original_string = array_merge(range(0,9), range('a','z'), range('A', 'Z'));
                $original_string = implode("", $original_string);
                $order_key= substr(str_shuffle($original_string), 0, 20);

                $order_member_array = array(
                    'group_member_id' => $group_member_id,
                    'status' => 0,
                    'group_order_id' => $group_order_id,
                    'order_key'=>$order_key

                );
                $group_order_details_id = $dbClass->insert("group_order_details", $order_member_array);
                $i++;
            }
            echo "http://burritobrothers.test/index.php?groupmaster=".$group_order_details_id."&".$order_key;



        }
        else{
            $columns_value = array(
                'user_id' => $_SESSION['customer_id'],
                'name' => $group_name,
                'members' => $count
            );
            $group_id = $dbClass->insert("groups_info", $columns_value);

            $columns_value = array(
                'customer_id' => $_SESSION['customer_id'],
                'group_id' => $group_id,
                'delivery_date' => $pickup_date_time,
                'notification_time' => $notification_date_time,
                'order_status' => 1,
            );
            $group_order_id = $dbClass->insert("group_order", $columns_value);
            $i=0;

            while ($i < ($count)) {
                $member_array = array(
                    'name' => $memberName[$i],
                    'email' => $memberEmail[$i],
                    'group_id' => $group_id
                );
                $group_member_id = $dbClass->insert("group_members", $member_array);

                $original_string = array_merge(range(0,9), range('a','z'), range('A', 'Z'));
                $original_string = implode("", $original_string);
                $order_key= substr(str_shuffle($original_string), 0, 20);

                $order_member_array = array(
                    'group_member_id' => $group_member_id,
                    'status' => 0,
                    'group_order_id' => $group_order_id,
                    'order_key'=>$order_key
                );
                $group_order_details_id = $dbClass->insert("group_order_details", $order_member_array);

                //Send Email to all member to select their menu
                //http://burritobrothers.test/index.php?group=$group_order_details_id&order_key

                $i++;
            }
            echo "http://burritobrothers.test/index.php?groupmaster=".$group_order_details_id."&".$order_key;

        }
        //echo json_encode("http://burritobrothers.test/index.php?group=$group_order_details_id&$order_key");

        //echo '$count';
        break;

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
            //$data['id']=$group_name['name'];

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

    case "group_member_order":

        $sql = "SELECT god.group_order_id, god.order_master_id, ci.full_name, gs.delivery_date from group_order_details god
            LEFT JOIN group_order gs ON gs.order_id=god.group_order_id
            LEFT JOIN customer_infos ci ON ci.customer_id=gs.customer_id
            WHERE god.id = $group_order_details_id AND god.order_key = '$order_key' AND god.status=0";
        //echo $sql;
        $group_order_info_members = $dbClass->getSingleRow($sql);
        //var_dump($group_order_info_members);
        if($group_order_info_members){
            $_SESSION['group_master'] = $group_order_info_members['full_name'];
            $_SESSION['delivery_date'] = $group_order_info_members['delivery_date'];
            $_SESSION['group_order_details_id'] = $group_order_details_id;
            echo 1;
        }
        else
        {
            echo 0;
        }
        break;

}
?>
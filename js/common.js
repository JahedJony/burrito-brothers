

//************** Notification******************* /
var notification_current_page_no = 1;

function show_notifications(customer_id){
	$.ajax({
		url: project_url+"includes/controller/notificationController.php",
		dataType: "json",
		type: "post",
		async:false,
		data:{
			q: "load_notifications",
			limit:2,
			customer_id:customer_id,
			page_no:notification_current_page_no
		},
		success: function(data) {
			$('#unread_notifications').html(data.total_unread);
			if(!jQuery.isEmptyObject(data.records)){
				var notification_li = "";
				$.each(data.records, function(i,notification){ 
					if(notification.status == 0){
						notification_li +='<li><a id="noti_a_'+notification.id+'" style="color:#b66335 !important" onclick="show_notification_details('+notification.id+','+notification.order_id+')" ><span class="image"></span><span class="message">'+notification.details+'</span></a></li>';
					}
					else{
						notification_li +='<li><a  onclick="show_notification_details('+notification.id+','+notification.order_id+')" ><span class="message">'+notification.details+'</span></a></li>';
					}
				})
				$('#notification_ul>li:last').before(notification_li);
				notification_current_page_no++;
				$('#load_more_not_button').removeClass("active");
			}
			else{
				 notification_li = '<li> <div class="text-center alert alert-danger"> No More Notifications   </div></li>	';
				 $('#notification_ul>li:last').before(notification_li);
				 $('#load_more_not_button').removeClass("active");	
				 $('#load_more_not_button').attr("disabled","disabled");				 
			}
		}
	});	
}


function show_notifications_no(customer_id){
	//alert(customer_id);
	$.ajax({
		url: project_url+"includes/controller/notificationController.php",
		dataType: "json",
		type: "post",
		async:false,
		data:{
			q: "load_notifications_no",
			customer_id: customer_id
		},
		success: function(data) {
			$('#unread_notifications').html(data.total_unread);
		}
	});	
}


function show_notification_details(notification_id, order_id){
	view_notification_details(order_id);
	$.ajax({
		url: project_url+"includes/controller/notificationController.php",
		type: "post",
		async:false,
		data:{
			q: "update_notification_status",
			notification_id:notification_id
		},
		success: function(data){
			show_notifications_no()
			$('#noti_a_'+notification_id).css("color","#5A738E !important")
		}
	});
}





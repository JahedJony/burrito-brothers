<section class="default-section contact-part home-icon">
    <div class="icon-default">
        <img src="images/scroll-arrow.png" alt="">
    </div>
    <div class="container">
        <div class="title text-center">
            <h2 class="text-coffee">Contact Us</h2>
            <h6 class="heade-xs">We highly appreciate you to contact with us</h6>
        </div>
        <div class="row">
            <div class="col-md-7 col-sm-7 col-xs-11 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms" style="margin-left: 20px;background-color: rgba(244,242,237,1);padding-top: 5vh; padding-bottom: 5vh; border-radius: 15px;">
                <h5 class="text-coffee">Leave us a Message</h5>
                <p>Please ask any of your queries, we will response very soon. </p>
                <form class="form" method="post" name="contact-form"  id="contact-form" border='1'>
                    <div class="alert-container"></div>
                    <div class="row">
                        <div class="col-md-6 col-sm-6 col-xs-11">
                            <label>Name *</label>
                            <input name="first_name" id="first_name" type="text" required>
                        </div>
                        <div class="col-md-6 col-sm-6 col-xs-11">
                            <label>Email *</label>
                            <input name="email"  id="email" type="email" required>
                        </div>
                        <div class="col-md-6 col-sm-6 col-xs-11">
                            <label>Mobile No *</label>
                            <input name="mobile" id="mobile" type="text" required>
                        </div>
                        <div class="col-md-6 col-sm-6 col-xs-11">
                            <label>Subject *</label>
                            <input name="subject" id="subject" type="text" required>
                        </div>
                        <div class="col-md-12 col-sm-12 col-xs-11">
                            <label>Your Message *</label>
                            <textarea name="message" id="message"  required></textarea>
                        </div>
                        <div class="col-md-12 col-sm-12 col-xs-11">
                            <div id="contact_submit_error" class="text-center" style="display:none"></div>
                        </div>
                        <div class="col-md-12 col-sm-12 col-xs-11">
                            <input name="submit" id="contact_submit" value="SEND MESSAGE" class="btn-black pull-right send_message" type="submit">
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-md-4 col-sm-4 col-xs-11 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms" style="background-color: rgba(244,242,237,1);margin-left: 18px; padding: 5vh; border-radius: 15px;">
                <h3 class="text-primary co-title" style="padding-top: 15px">Our Address</h3>
                    <address id="address">
                    </address>
                <h5 class="text-coffee">Opening Hours</h5>
                    <ul class="time-list">
                        <li><span class="week-name">Monday</span> <span>10-12 PM</span></li>
                        <li><span class="week-name">Tuesday</span> <span>10-12 PM</span></li>
                        <li><span class="week-name">Wednesday</span> <span>10-12 PM</span></li>
                        <li><span class="week-name">Thursday</span> <span>10-12 PM</span></li>
                        <li><span class="week-name">Friday</span> <span>10-12 PM</span></li>
                        <li><span class="week-name">Saturday</span> <span>10-12 PM</span></li>
                        <li><span class="week-name">Sunday</span> <span>4-12 PM</span></li>
                    </ul>
            </div>

        </div>
    </div>
</section>
<!-- End Contact Part -->
<section class="contact-map">
    <div class="map-outer">
        <iframe src="https://www.google.com/maps/d/embed?mid=1yLqCYuceQlMCtPjEOOGDa2hnIzubMMnE&hl=en" width="100%" height="480"></iframe>
    </div>
</section>
<script>
    $(function () {
        $.ajax({
            url:project_url+"includes/controller/ecommerceController.php",
            dataType: "json",
            type: "post",
            async:false,
            data: {
                q: "get_settings_details",
            },
            success: function(data){

                html=''
                if(!jQuery.isEmptyObject(data.records)){
                    $.each(data.records, function(i,data){
                        html ='<b>'+data.store_name+'</b><br>\n' +
                            ' '+data.store_address+'<br>\n' +
                            '  <a href=\'tel:$mobile\'><b>Mobile:</b> '+data.store_contact+'</a><br>'
                    });

                }
                $('#address').html(html);

            }
        });


    })
    $('#contact_submit').click(function(event){
        event.preventDefault();
        var formData = new FormData($('#contact-form')[0]);
        formData.append("q","contact_us_mail");
        if($.trim($('#first_name').val()) == ""){
            success_or_error_msg('#contact_submit_error','danger',"Please type name","#first_name");
        }
        else if($.trim($('#email').val()) == ""){
            success_or_error_msg('#contact_submit_error','danger',"Please type email","#email");
        }
        else if($.trim($('#mobile').val()) == ""){
            success_or_error_msg('#contact_submit_error','danger',"Please enter mobile no.","#mobile");
        }
        else if($.trim($('#subject').val()) == ""){
            success_or_error_msg('#contact_submit_error','danger',"Please type subject.","#subject");
        }
        else if($.trim($('#message').val()) == ""){
            success_or_error_msg('#contact_submit_error','danger',"Please type message.","#message");
        }
        else{
            $.ajax({
                url: project_url+"includes/controller/customerController.php",
                type:'POST',
                data:formData,
                async:false,
                cache:false,
                contentType:false,processData:false,
                success: function(data){
                    if($.isNumeric(data)==true && data==1){
                        success_or_error_msg('#contact_submit_error',"success","Mail has sent","" );
                        $('#contact-form')[0].reset();
                    }
                    else if($.isNumeric(data)==true && data==2){
                        success_or_error_msg('#contact_submit_error',"danger","Mail has sent","" );
                    }
                }
            });
        }
    })

</script>
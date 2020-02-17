<div>
    <button onclick="ingredientadd()">click me to add ingredient</button>
</div>

<script>

    //-------------------------------------------------------------------------

    ingredientadd= function ingredientadd(){
        //alert('ok')
        $.ajax({
            url: project_url+"includes/controller/ecommerceController.php",
            dataType: "json",
            type: "post",
            async: false,
            data: {
                q: "db_update_all_items",
            },
            success: function (data) {
                alert(data)

            }
        })
    }


</script>

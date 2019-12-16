$(function () {
    //http://burritobrothers.test/admin/index.php?module=personal&view=profile
    //alert('ss')
    var url_info = location.search.split('?')[1];
    //alert(url_info)
    if(!url_info) {
        $("#content").load("views/home.php");
    }
    else{
        var main_view=url_info.split('&')
        if(!main_view[1]){
            $("#content").load("views/"+main_view[0].split('page=')[1]+".php");
            //alert('ok')
        }else {
            var data=main_view[1].split('category=')
            data = data[1].split('__').join(' ')
            $("#content").load("views/"+main_view[0].split('page=')[1]+".php");

        }

        //alert(main_view[0].split('page=')[1])
    }
});
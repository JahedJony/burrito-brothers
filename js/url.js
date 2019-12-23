$(function () {
    //http://burritobrothers.test/admin/index.php?module=personal&view=profile
    //alert('ss')
    //alert(location.search)

    var url_info = location.search.split('?')[1];
    if(!url_info) {
        var url = location.search
        if(window.location.pathname.split('/')[1] =='account.php'){
            $("#content").load("views/account.php");
        }
        else if(window.location.pathname.split('/')[1] =='cart.php'){
            $("#content").load("views/cart.php");
        }
        else if(window.location.pathname.split('/')[1] =='checkout.php'){
            $("#content").load("views/checkout.php");
        }
        else{
            $("#content").load("views/home.php");
        }
    }
    else{
        //alert('window..href')

        var main_view=url_info.split('&')
        if(!main_view[1]){
            $("#content").load("views/"+main_view[0].split('page=')[1]+".php");
            //alert('ok')
        }else {
            //alert(main_view[1].split('=')[0]);
            if(main_view[1].split('=')[0]=='category'){
                //alert(main_view[1])
                var data=main_view[1].split('category=')
                data = data[1].split('__').join(' ')
                $("#content").load("views/"+main_view[0].split('page=')[1]+".php");
            }
            else if(main_view[1].split('=')[0]=='id') {
                //alert(main_view[1])
                var data=main_view[1].split('id=')
                //data = data[1].split('__').join(' ')
                //$("#content").load("views/"+main_view[0].split('page=')[1]+".php");
            }


            }

        //alert(main_view[0].split('page=')[1])
    }
});
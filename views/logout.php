<?php
session_start();
$_SESSION = array();
if(isset($_COOKIE[session_name()])) {
	setcookie(session_name(), '', time()-42000, '/');
}
session_destroy();
//header("Location: /index.php");
?>
<script src="../js/static_text.js"></script>
<script>
	//alert(project_url)
	window.location.replace('index.php');
	//window.location.replace('http://localhost/burrito-brothers/index.php');
</script>



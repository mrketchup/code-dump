<?php session_start();

require_once("frugalator/connector.php");

$un=$_POST['un'];
$pw=$_POST['pw'];

$con = new Connector();
$result = $con->connect($un,$pw);

if($result)
{
    $_SESSION['username'] = $un;
    $_SESSION['password'] = $pw;
    $_SESSION['authenticated'] = 1;
    header("location:home.php");
}
else
    header("location:index.php?state=fail");

?>

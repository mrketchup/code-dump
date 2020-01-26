<?php session_start();

require_once("frugalator/connector.php");

if(!isset($_SESSION['authenticated']))
    header("location:index.php");

$un = $_SESSION['username'];
$pw = $_SESSION['password'];
$con = new Connector();
$con->connect($un,$pw);
$user = $con->getUser();

?>

<html>
    <head>
        <title>Frugal - Home : <?php echo $user->getFullName(); ?></title>
    </head>
    <body>
        <h1>Home : <?php echo $user->getFullName(); ?></h1>
        <form name="logout" method="post" action="logout.php">
            <input type="submit" value="Logout"/>
        </form>
        
        <?php
         
        echo '<h4>Total Worth: ' . $user->getTotalWorth() . '</h4>';
        echo 'Net YTD: ' . $user->getNetYTD();
        echo '<br/>Net Past 30 days: ' . $user->getNetDays(30);
        
        ?>
        
    </body>
</html>

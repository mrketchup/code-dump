<?php session_start();

if(isset($_SESSION['authenticated']))
    header("location:home.php");
    
?>

<html>
    <head>
        <title>Frugal Financial Tracking</title>
    </head>
    <body>
        <h1>Frugal Financial Tracking</h1>
        <form name="login" method="post" action="checklogin.php">
            <input name="un" id="un" type="text" size="15"/>
            <input name="pw" id="pw" type="password" size="15"/>
            <input type="submit" value="Login"/>
        </form>
        
        <?php
        
        if($_GET['state'] == 'fail')
            echo 'Username and/or Password incorrect.';
        elseif($_GET['state'] == 'logout')
            echo 'Logout Successful.';
            
        ?>
        
    </body>
</html>

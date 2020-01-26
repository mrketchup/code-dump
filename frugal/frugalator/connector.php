<?php

require_once("user.php");

class Connector
{
    private $user;
    private $authenticated;
    
    public function connect($un,$pw)
    {
        $con = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$con);
    
        $un = stripslashes($un);
        $pw = stripslashes($pw);
        $un = mysql_real_escape_string($un);
        $pw = mysql_real_escape_string($pw);
        
        $query = "select * from Users where username='$un' and password=SHA1('$pw')";
        $login = mysql_query($query,$con);
                             
        $rows = mysql_num_rows($login);
        mysql_close($con);
        
        if($rows == 0)
            return false;
        
        $this->user = new User($un);    
        $this->authenticated = true;
        return true;
    }

    public function createUser($un,$pw,$fn,$ln)
    {
        $con = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$con);
        
        $un = stripslashes($un);
        $pw = stripslashes($pw);
        $un = mysql_real_escape_string($un);
        $pw = mysql_real_escape_string($pw);
        
        $query = "insert into Users values ('$un',SHA1('$pw'),'$fn','$ln')";

        $res = mysql_query($query,$con);
        mysql_close($con);

        return $res;
    }
    
    public function deleteUser($un)
    {
        $con = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$con);
        
        $un = stripslashes($un);
        $un = mysql_real_escape_string($un);
        
        $query = "delete from Users where username='$un'";
        
        $res = mysql_query($query,$con);
        mysql_close($con);

        return $res;
    }
    
    public function isAuthenticated()
    {
        return $this->authenticated;
    }
    
    public function isUsernameAvailable($un)
    {
        $con = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$con);

        $un = stripslashes($un);
        $un = mysql_real_escape_string($un);

        $query = "select * from Users where username='$un'";
        $res = mysql_query($query,$con);

        $rows = mysql_num_rows($res);
        mysql_close($con);
        
        if($rows == 0)
            return true;
        return false;
    }
    
    public function getUser($un = "")
    {
        if($un == "" && $this->authenticated)
            return $this->user;
        return new User($un);
    }
    
    public function changePassword($pw)
    {
        if($this->authenticated)
        {
            $connect = mysql_connect("localhost","user","user");
            mysql_select_db("finances",$connect);
            
            $pw = stripslashes($pw);
            $pw = mysql_real_escape_string($pw);
                
            $query = "update Users set password=sha1('$pw') where username='" . 
                     $this->user->getUsername() . "'";
            mysql_query($query,$connect);
                
            mysql_close($connect);
        }
    }
}

?>

    
<?php
################################################################################
# Test Cases for the Connector class                                           #
################################################################################
/*
error_reporting(E_ALL ^ E_DEPRECATED);

require_once("simpletest/autorun.php");

class ConnectorTest extends UnitTestCase
{
    function TestConnectGoodUsernameAndGoodPassword()
    {
        $con = new Connector();
        $result = $con->connect("mejones","password");
        $this->assertTrue($result);
    }
    
    function TestConnectGoodUsernameAndBadPassword()
    {
        $con = new Connector();
        $result = $con->connect("mejones","pssword");
        $this->assertFalse($result);
    }
    
    function TestConnectBadUsername()
    {
        $con = new Connector();
        $result = $con->connect("mjones","password");
        $this->assertFalse($result);
    }
    
    function TestCreateUser()
    {
        $con = new Connector();
        $result = $con->createUser("ltest","pazzwurd","Larry","Test");
        $this->assertTrue($result);
        
        $result = $con->connect("ltest","pazzwurd");
        $this->assertTrue($result);
    }
    
    function TestDeleteUser()
    {
        $con = new Connector();
        $result = $con->deleteUser("ltest");
        $this->assertTrue($result);
    }
    
    function TestIsAuthenticated()
    {
        $con = new Connector();
        $this->assertFalse($con->isAuthenticated());
        $con->connect("mejones","password");
        $this->assertTrue($con->isAuthenticated());
    }
    
    function TestIsUsernameAvailable()
    {
        $con = new Connector();
        $result = $con->isUsernameAvailable("mejones");
        $this->assertFalse($result);
        
        $result = $con->isUsernameAvailable("ltest");
        $this->assertTrue($result);
    }
    
    function TestGetUser()
    {
        $con = new Connector();
        $user = $con->getUser("mejones");
        $result = $user->getUsername();
        $expected = "mejones";
        $this->assertEqual($result,$expected);
        
        $con->connect("mejones","password");
        $user = $con->getUser();
        $result = $user->getUsername();
        $expected = "mejones";
        $this->assertEqual($result,$expected);
    }
    
    function TestChangePassword()
    {
        $con = new Connector();
        $con->connect("mejones","password");
        $con->changePassword("pazzword");
        
        $con = new Connector();
        $result = $con->connect("mejones","password");
        $this->assertFalse($result);
        
        $result = $con->connect("mejones","pazzword");
        $this->assertTrue($result);
        
        $con->changePassword("password");
    }
}
*/
?>

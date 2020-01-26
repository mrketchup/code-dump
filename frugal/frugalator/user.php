<?php

require_once("account.php");
require_once("category.php");

class User
{
    private $username;
    
    public function User($un)
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "select * from Users where username='$un'";
        $result = mysql_query($query,$connect);
        
        $rows = mysql_num_rows($result);
        if($rows == 0)
             throw new Exception('User does not exist');
        
        $this->username = $un;
            
        mysql_close($connect);
    }
    
    public function getUsername()
    {
        return $this->username;
    }

    public function setFirstname($fn)
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "update Users set firstname='$fn' where username='" . 
                 $this->username . "'";
        mysql_query($query,$connect);
            
        mysql_close($connect);
    }
    
    public function setLastname($ln)
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "update Users set lastname='$ln' where username='" . 
                 $this->username . "'";
        mysql_query($query,$connect);
            
        mysql_close($connect);
    }
    
    public function getFirstname()
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "select * from Users where username='" . $this->username . "'";
        $result = mysql_query($query,$connect);
        $row = mysql_fetch_array($result);
        
        mysql_close($connect);
        
        return $row['firstname'];
    }
    
    public function getLastname()
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "select * from Users where username='" . $this->username . "'";
        $result = mysql_query($query,$connect);
        $row = mysql_fetch_array($result);
        
        mysql_close($connect);
        
        return $row['lastname'];
    }
    
    public function getFullName()
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "select * from Users where username='" . $this->username . "'";
        $result = mysql_query($query,$connect);
        $row = mysql_fetch_array($result);
        
        mysql_close($connect);
        
        return $row['firstname'] . " " . $row['lastname'];
    }
    
    public function getAccount($id)
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
        
        $query = "select * from Accounts where id=$id and owner='" . 
                 $this->username . "'";
        $result = mysql_query($query,$connect);
        
        $rows = mysql_num_rows($result);
        if($rows == 0)
             throw new Exception('User does not own Account');
        mysql_close($connect);
             
        return new Account($id);
    }
    
    public function getAccounts()
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
        
        $query = "select * from Accounts where owner='" . $this->username . "'";
        $result = mysql_query($query,$connect);
        
        mysql_close($connect);
        
        $accounts = array();
        while($account = mysql_fetch_array($result))
        {
            $id = $account['id'];
            $a = new Account($id);
            $accounts[$a->getID()] = $a;
        }
        
        return $accounts;
    }
    
    public function createAccount($n)
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
        
        $query = "insert into Accounts values (0,'$n','" . $this->username . "')";

        mysql_query($query,$connect);
        mysql_close($connect);
    }
    
    public function deleteAccount($id)
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
        
        $query = "delete from Accounts where id='$id' and owner='" . 
                 $this->username . "'";
        mysql_query($query,$connect);           
        mysql_close($connect);
    }
    
    public function getCategory($id)
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
        
        $query = "select * from Categories where id=$id and owner='" . 
                 $this->username . "'";
        $result = mysql_query($query,$connect);
        
        $rows = mysql_num_rows($result);
        if($rows == 0 && $id != 0)
             throw new Exception('User does not own Category');
        mysql_close($connect);
             
        return new Category($id);
    }
    
    public function getCategories($t = "")
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
        
        $query = "select * from Categories where owner='" . $this->username . "'";
        if($t == 'E' || $t == 'I')
            $query = "$query and type='$t'";
        $result = mysql_query($query,$connect);
        
        mysql_close($connect);
        
        $categories = array();
        while($category = mysql_fetch_array($result))
        {
            $id = $category['id'];
            $c = new Category($id);
            $categories[$c->getID()] = $c;
        }
        
        return $categories;
    }
    
    public function createCategory($n,$t)
    {
        if($t != 'E' && $t != 'I')
            throw new Exception('Invalid Category type');
            
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
        
        $query = "insert into Categories values (0,'" . $this->username . 
                 "','$n','$t')";

        mysql_query($query,$connect);
        mysql_close($connect);
    }
    
    public function deleteCategory($id)
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
        
        $query = "delete from Categories where id='$id' and owner='" . 
                 $this->username . "'";
        mysql_query($query,$connect);           
        mysql_close($connect);
    }
    
    public function getTotalWorth()
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "select sum(amount) as total from Transactions T, Accounts A" .
                 " where T.accountid=A.id and A.owner='" . $this->username . "'";
        $result = mysql_query($query,$connect);
        $row = mysql_fetch_array($result);
        
        mysql_close($connect);
        
        return $row['total'];
    }
    
    public function getNetYTD()
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "select sum(amount) as total from Transactions T, Accounts A" .
                 " where T.accountid=A.id and A.owner='" . $this->username . 
                 "' and YEAR(date)=YEAR(now()) and T.categoryid <> 0";
        $result = mysql_query($query,$connect);
        $row = mysql_fetch_array($result);
        
        mysql_close($connect);
        
        return $row['total'];
    }
    
    public function getNetDays($d)
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "select sum(amount) as total from Transactions T, Accounts A" .
                 " where T.accountid=A.id and A.owner='" . $this->username . 
                 "' and date>=ADDDATE(now(),-$d) and T.categoryid <> 0";
        $result = mysql_query($query,$connect);
        $row = mysql_fetch_array($result);
        
        mysql_close($connect);
        
        return $row['total'];
    }
}

?>


<?php
################################################################################
# Test Cases for the User class                                                #
################################################################################
/*
error_reporting(E_ALL ^ E_DEPRECATED);

require_once("simpletest/autorun.php");

class UserTest extends UnitTestCase
{
    function TestGetUsername()
    {
        $user = new User("mejones");
        $result = $user->getUsername();
        $expected = "mejones";
        $this->assertEqual($result,$expected);
    }
    
    function TestGetFirstname()
    {
        $user = new User("mejones");
        $result = $user->getFirstname();
        $expected = "Matt";
        $this->assertEqual($result,$expected);
    }
    
    function TestGetLastname()
    {
        $user = new User("mejones");
        $result = $user->getLastname();
        $expected = "Jones";
        $this->assertEqual($result,$expected);
    }
    
    function TestGetFullName()
    {
        $user = new User("mejones");
        $result = $user->getFullName();
        $expected = "Matt Jones";
        $this->assertEqual($result,$expected);
    }
    
    function TestSetFirstname()
    {
        $user = new User("mejones");
        $user->setFirstname("Scooter");
        $result = $user->getFirstname();
        $expected = "Scooter";
        $this->assertEqual($result,$expected);
        
        $user->setFirstname("Matt");
        $result = $user->getFirstname();
        $expected = "Matt";
        $this->assertEqual($result,$expected);
    }
    
    function TestSetLastname()
    {
        $user = new User("mejones");
        $user->setLastname("Berry");
        $result = $user->getLastname();
        $expected = "Berry";
        $this->assertEqual($result,$expected);
        
        $user->setLastname("Jones");
        $result = $user->getLastname();
        $expected = "Jones";
        $this->assertEqual($result,$expected);
    }
    
    function TestGetAccount()
    {
        $user = new User("mejones");
        $account = $user->getAccount(1);
        $result = $account->getName();
        $expected = "USAA Checking Account";
        $this->assertEqual($result,$expected);
    }
    
    function TestGetAccounts()
    {
        $user = new User("mejones");
        $accounts = $user->getAccounts();
        $result = count($accounts);
        $expected = 2;
        $this->assertEqual($result,$expected);
    }
    
    function TestCreateAccount()
    {
        $user = new User("mejones");
        $user->createAccount("Cash Money!");
        $accounts = $user->getAccounts();
        $result = count($accounts);
        $expected = 3;
        $this->assertEqual($result,$expected);
    }
    
    function TestDeleteAccount()
    {
        $user = new User("mejones");
        $accounts = $user->getAccounts();
        $user->deleteAccount(end($accounts)->getID());
        $accounts = $user->getAccounts();
        $result = count($accounts);
        $expected = 2;
        $this->assertEqual($result,$expected);
    }
    
    function TestGetCategory()
    {
        $user = new User("mejones");
        $category = $user->getCategory(1);
        $result = $category->getName();
        $expected = "TRANSPORTATION";
        $this->assertEqual($result,$expected);
    }
    
    function TestGetCategories()
    {
        $user = new User("mejones");
        $categories = $user->getCategories();
        $result = count($categories);
        $expected = 3;
        $this->assertEqual($result,$expected);
        
        $categories = $user->getCategories('E');
        $result = count($categories);
        $expected = 2;
        $this->assertEqual($result,$expected);
        
        $categories = $user->getCategories('I');
        $result = count($categories);
        $expected = 1;
        $this->assertEqual($result,$expected);
        
        $categories = $user->getCategories('Z');
        $result = count($categories);
        $expected = 3;
        $this->assertEqual($result,$expected);
    }
    
    function TestCreateCategory()
    {
        $user = new User("mejones");
        $user->createCategory("FOOD","E");
        $categories = $user->getCategories();
        $result = count($categories);
        $expected = 4;
        $this->assertEqual($result,$expected);
    }
    
    function TestDeleteCategory()
    {
        $user = new User("mejones");
        $categories = $user->getCategories();
        $user->deleteCategory(end($categories)->getID());
        $categories = $user->getCategories();
        $result = count($categories);
        $expected = 3;
        $this->assertEqual($result,$expected);
    }
    
    function TestGetTotalWorth()
    {
        $user = new User("mejones");
        $result = $user->getTotalWorth();
        $expected = 11691.95;
        $this->assertEqual($result,$expected);
    }
    
    function TestGetNetYTD()
    {
        $user = new User("mejones");
        $result = $user->getNetYTD();
        $expected = 1299.5;
        $this->assertEqual($result,$expected);
    }
    
    function TestGetNetDays()
    {
        $user = new User("mejones");
        $result = $user->getNetDays(30);
        $expected = 1344.5;
        $this->assertEqual($result,$expected);
    }
}
*/
?>

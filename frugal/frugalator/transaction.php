<?php

require_once("user.php");
require_once("account.php");
require_once("category.php");

class Transaction
{
    private $id;
    
    public function Transaction($id)
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "select * from Transactions where id=$id";
        $result = mysql_query($query,$connect);
        
        $rows = mysql_num_rows($result);
        if($rows == 0)
             throw new Exception('Transaction does not exist');
        
        $this->id = $id;
            
        mysql_close($connect);
    }
    
    public function getID()
    {
        return $this->id;
    }
    
    public function getAccount()
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "select * from Transactions where id=" . $this->id;
        $result = mysql_query($query,$connect);
        $row = mysql_fetch_array($result);
        
        mysql_close($connect);
        
        return new Account($row['accountid']);
    }
    
    public function getDate()
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "select * from Transactions where id=" . $this->id;
        $result = mysql_query($query,$connect);
        $row = mysql_fetch_array($result);
        
        mysql_close($connect);
        
        return $row['date'];
    }
    
    public function getDescription()
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "select * from Transactions where id=" . $this->id;
        $result = mysql_query($query,$connect);
        $row = mysql_fetch_array($result);
        
        mysql_close($connect);
        
        return $row['description'];
    }
    
    public function getAmount()
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "select * from Transactions where id=" . $this->id;
        $result = mysql_query($query,$connect);
        $row = mysql_fetch_array($result);
        
        mysql_close($connect);
        
        return $row['amount'];
    }
    
    public function getCategory()
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "select * from Transactions where id=" . $this->id;
        $result = mysql_query($query,$connect);
        $row = mysql_fetch_array($result);
        
        mysql_close($connect);
        
        return new Category($row['categoryid']);
    }
    
    public function setAccount($id)
    {
        $this->getAccount()->getOwner()->getAccount($id);
        
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "update Transactions set accountid='$id' where id=" . $this->id;
        mysql_query($query,$connect);
            
        mysql_close($connect);
    }
    
    public function setDate($d)
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "update Transactions set date='$d' where id=" . $this->id;
        mysql_query($query,$connect);
            
        mysql_close($connect);
    }
    
    public function setDescription($d)
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "update Transactions set description='$d' where id=" . $this->id;
        mysql_query($query,$connect);
            
        mysql_close($connect);
    }
    
    public function setAmount($a)
    {
        $t = $this->getCategory()->getType();
        
        if($a > 0 && $t == 'Income' || $a < 0 && $t == 'Expense')
        {
            $connect = mysql_connect("localhost","user","user");
            mysql_select_db("finances",$connect);
                
            $query = "update Transactions set amount=$a where id=" . $this->id;
            mysql_query($query,$connect);
                
            mysql_close($connect);
        }
    }
    
    public function setCategory($id)
    {
        $t = $this->getAccount()->getOwner()->getCategory($id)->getType();
        $a = $this->getAmount();
        
        if($a > 0 && $t == 'Income' || $a < 0 && $t == 'Expense' || $id == 0)
        {
            $connect = mysql_connect("localhost","user","user");
            mysql_select_db("finances",$connect);
                
            $query = "update Transactions set categoryid=$id where id=" . $this->id;
            mysql_query($query,$connect);
                
            mysql_close($connect);
        }
    }
}

?>


<?php
################################################################################
# Test Cases for the Transaction class                                         #
################################################################################
/*
error_reporting(E_ALL ^ E_DEPRECATED);

require_once("simpletest/autorun.php");

class TransactionTest extends UnitTestCase
{
    function TestGetID()
    {
        $transaction = new Transaction(1);
        $result = $transaction->getID();
        $expected = 1;
        $this->assertEqual($result,$expected);
    }
    
    function TestGetAccount()
    {
        $transaction = new Transaction(1);
        $account = $transaction->getAccount();
        $result = $account->getID();
        $expected = 1;
        $this->assertEqual($result,$expected);
    }
    
    function TestGetDate()
    {
        $transaction = new Transaction(1);
        $result = $transaction->getDate();
        $expected = '2011-02-10';
        $this->assertEqual($result,$expected);
    }
    
    function TestGetDescription()
    {
        $transaction = new Transaction(1);
        $result = $transaction->getDescription();
        $expected = 'Gas';
        $this->assertEqual($result,$expected);
    }
    
    function TestGetAmount()
    {
        $transaction = new Transaction(1);
        $result = $transaction->getAmount();
        $expected = -39.15;
        $this->assertEqual($result,$expected);
    }
    
    function TestGetCategory()
    {
        $transaction = new Transaction(1);
        $category = $transaction->getCategory();
        $result = $category->getID();
        $expected = 1;
        $this->assertEqual($result,$expected);
    }
    
    function TestSetAccount()
    {
        $transaction = new Transaction(1);
        $transaction->setAccount(2);
        $account = $transaction->getAccount();
        $result = $account->getID();
        $expected = 2;
        $this->assertEqual($result,$expected);
        
        $transaction->setAccount(1);
        $account = $transaction->getAccount();
        $result = $account->getID();
        $expected = 1;
        $this->assertEqual($result,$expected);
    }
    
    function TestSetDate()
    {
        $transaction = new Transaction(1);
        $transaction->setDate('1988-01-20');
        $result = $transaction->getDate();
        $expected = '1988-01-20';
        $this->assertEqual($result,$expected);
        
        $transaction->setDate('2011-02-10');
        $result = $transaction->getDate();
        $expected = '2011-02-10';
        $this->assertEqual($result,$expected);
    }
    
    function TestSetDescription()
    {
        $transaction = new Transaction(1);
        $transaction->setDescription('Gasoline');
        $result = $transaction->getDescription();
        $expected = 'Gasoline';
        $this->assertEqual($result,$expected);
        
        $transaction->setDescription('Gas');
        $result = $transaction->getDescription();
        $expected = 'Gas';
        $this->assertEqual($result,$expected);
    }
    
    function TestSetAmount()
    {
        $transaction = new Transaction(1);
        $transaction->setAmount(-49.15);
        $result = $transaction->getAmount();
        $expected = -49.15;
        $this->assertEqual($result,$expected);
        
        $transaction->setAmount(49.15);
        $result = $transaction->getAmount();
        $expected = -49.15;
        $this->assertEqual($result,$expected);
        
        $transaction->setAmount(-39.15);
        $result = $transaction->getAmount();
        $expected = -39.15;
        $this->assertEqual($result,$expected);
        
        $transaction = new Transaction(3);
        $transaction->setAmount(1444.5);
        $result = $transaction->getAmount();
        $expected = 1444.5;
        $this->assertEqual($result,$expected);
        
        $transaction->setAmount(-1444.5);
        $result = $transaction->getAmount();
        $expected = 1444.5;
        $this->assertEqual($result,$expected);
        
        $transaction->setAmount(1344.5);
        $result = $transaction->getAmount();
        $expected = 1344.5;
        $this->assertEqual($result,$expected);
    }
    
    function TestSetCategory()
    {
        $transaction = new Transaction(1);
        $transaction->setCategory(2);
        $category = $transaction->getCategory();
        $result = $category->getID();
        $expected = 2;
        $this->assertEqual($result,$expected);
        
        $transaction->setCategory(3);
        $category = $transaction->getCategory();
        $result = $category->getID();
        $expected = 2;
        $this->assertEqual($result,$expected);
        
        $transaction->setCategory(1);
        $category = $transaction->getCategory();
        $result = $category->getID();
        $expected = 1;
        $this->assertEqual($result,$expected);
        
        $transaction = new Transaction(3);
        $transaction->setCategory(0);
        $category = $transaction->getCategory();
        $result = $category->getID();
        $expected = 0;
        $this->assertEqual($result,$expected);
        
        $transaction->setCategory(2);
        $category = $transaction->getCategory();
        $result = $category->getID();
        $expected = 0;
        $this->assertEqual($result,$expected);
        
        $transaction->setCategory(3);
        $category = $transaction->getCategory();
        $result = $category->getID();
        $expected = 3;
        $this->assertEqual($result,$expected);
    }
}
*/
?>

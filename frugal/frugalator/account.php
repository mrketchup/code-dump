<?php

require_once("user.php");
require_once("transaction.php");

class Account
{
    private $id;
    
    public function Account($id)
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "select * from Accounts where id=$id";
        $result = mysql_query($query,$connect);
        
        $rows = mysql_num_rows($result);
        if($rows == 0)
             throw new Exception('Account does not exist');
        
        $this->id = $id;
            
        mysql_close($connect);
    }
    
    public function getID()
    {
        return $this->id;
    }
    
    public function getName()
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "select * from Accounts where id=" . $this->id;
        $result = mysql_query($query,$connect);
        $row = mysql_fetch_array($result);
        
        mysql_close($connect);
        
        return $row['name'];
    }
    
    public function getOwner()
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "select * from Accounts where id=" . $this->id;
        $result = mysql_query($query,$connect);
        $row = mysql_fetch_array($result);
        
        mysql_close($connect);
        
        return new User($row['owner']);
    }
    
    public function setName($n)
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "update Accounts set name='$n' where id='" . $this->id . "'";
        mysql_query($query,$connect);
            
        mysql_close($connect);
    }
    
    public function getTransaction($id)
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
        
        $query = "select * from Transactions where id=$id and accountid='" . 
                 $this->id . "'";
        $result = mysql_query($query,$connect);
        
        $rows = mysql_num_rows($result);
        if($rows == 0)
             throw new Exception('Transaction does not belong to Account');
        mysql_close($connect);
             
        return new Transaction($id);
    }
    
    public function getTransactions($c = 0)
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
        
        $query = "select * from Transactions where accountid='" . $this->id . "'";
        if($c > 0)
            $query = "$query and categoryid='$c'";
        $result = mysql_query($query,$connect);
        
        mysql_close($connect);
        
        $transactions = array();
        while($transaction = mysql_fetch_array($result))
        {
            $id = $transaction['id'];
            $t = new Transaction($id);
            $transactions[$t->getID()] = $t;
        }
        
        return $transactions;
    }
    
    public function createTransaction($da,$de,$a,$c)
    {
        $t = $this->getOwner()->getCategory($c)->getType();
        
        if(($t != 'E' || $a >= 0) && ($t != 'I' && $a <= 0))
            throw new Exception('Amount does not match Category type');
            
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
        
        $query = "insert into Transactions values (0," . $this->id . 
                 ",'$da','$de',$a,$c)";

        mysql_query($query,$connect);
        mysql_close($connect);
    }
    
    public function deleteTransaction($id)
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
        
        $query = "delete from Transactions where id='$id' and accountid=" . $this->id;
        mysql_query($query,$connect);           
        mysql_close($connect);
    }
}

?>


<?php
################################################################################
# Test Cases for the Account class                                             #
################################################################################
/*
error_reporting(E_ALL ^ E_DEPRECATED);

require_once("simpletest/autorun.php");

class AccountTest extends UnitTestCase
{
    function TestGetName()
    {
        $account = new Account(1);
        $result = $account->getName();
        $expected = "USAA Checking Account";
        $this->assertEqual($result,$expected);
    }
    
    function TestGetID()
    {
        $account = new Account(1);
        $result = $account->getID();
        $expected = 1;
        $this->assertEqual($result,$expected);
    }
    
    function TestSetName()
    {
        $account = new Account(1);
        $account->setName("Cash Money!");
        $result = $account->getName();
        $expected = "Cash Money!";
        $this->assertEqual($result,$expected);
        
        $account->setName("USAA Checking Account");
        $result = $account->getName();
        $expected = "USAA Checking Account";
        $this->assertEqual($result,$expected);
    }
    
    function TestGetOwner()
    {
        $account = new Account(1);
        $user = $account->getOwner();
        $result = $user->getUsername();
        $expected = "mejones";
        $this->assertEqual($result,$expected);
    }
    
    function TestGetTransaction()
    {
        $account = new Account(1);
        $transaction = $account->getTransaction(1);
        $result = $transaction->getID();
        $expected = 1;
        $this->assertEqual($result,$expected);
    }
    
    function TestGetTransactions()
    {
        $account = new Account(1);
        $transactions = $account->getTransactions();
        $result = count($transactions);
        $expected = 3;
        $this->assertEqual($result,$expected);
        
        $account = new Account(2);
        $transactions = $account->getTransactions();
        $result = count($transactions);
        $expected = 1;
        $this->assertEqual($result,$expected);
    }
    
    function TestCreateTransaction()
    {
        $account = new Account(1);
        $account->createTransaction('2011-04-6','Paycheck',1344.51,3);
        $transactions = $account->getTransactions();
        $result = count($transactions);
        $expected = 4;
        $this->assertEqual($result,$expected);
    }
    
    function TestDeleteTransaction()
    {
        $account = new Account(1);
        $transactions = $account->getTransactions();
        $account->deleteTransaction(end($transactions)->getID());
        $transactions = $account->getTransactions();
        $result = count($transactions);
        $expected = 3;
        $this->assertEqual($result,$expected);
    }
}
*/
?>

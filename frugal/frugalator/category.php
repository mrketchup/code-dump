<?php

require_once("user.php");

class Category
{
    private $id;
    
    public function Category($id)
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "select * from Categories where id=$id";
        $result = mysql_query($query,$connect);
        
        $rows = mysql_num_rows($result);
        if($rows == 0 && $id != 0)
             throw new Exception('Category does not exist');
        
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
            
        $query = "select * from Categories where id=" . $this->id;
        $result = mysql_query($query,$connect);
        $row = mysql_fetch_array($result);
        
        mysql_close($connect);
        
        return $row['name'];
    }
    
    public function getOwner()
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "select * from Categories where id=" . $this->id;
        $result = mysql_query($query,$connect);
        $row = mysql_fetch_array($result);
        
        mysql_close($connect);
        
        return new User($row['owner']);
    }
    
    public function getType()
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "select * from Categories where id=" . $this->id;
        $result = mysql_query($query,$connect);
        $row = mysql_fetch_array($result);
        
        mysql_close($connect);
        
        if($row['type'] == 'E')
            return "Expense";
        return "Income";
    }
    
    public function setName($n)
    {
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "update Categories set name='$n' where id=" . $this->id;
        mysql_query($query,$connect);
            
        mysql_close($connect);
    }
    
    public function setType($t)
    {
        if($t != 'E' && $t != 'I')
            throw new Exception('Invalid Category type');
        
        $connect = mysql_connect("localhost","user","user");
        mysql_select_db("finances",$connect);
            
        $query = "update Categories set type='$t' where id=" . $this->id;
        mysql_query($query,$connect);
            
        mysql_close($connect);
    }
}

?>


<?php
################################################################################
# Test Cases for the Category class                                            #
################################################################################
/*
error_reporting(E_ALL ^ E_DEPRECATED);

require_once("simpletest/autorun.php");

class CategoryTest extends UnitTestCase
{
    function TestGetName()
    {
        $category = new Category(1);
        $result = $category->getName();
        $expected = "TRANSPORTATION";
        $this->assertEqual($result,$expected);
    }
    
    function TestGetID()
    {
        $category = new Category(1);
        $result = $category->getID();
        $expected = 1;
        $this->assertEqual($result,$expected);
    }
    
    function TestGetOwner()
    {
        $category = new Category(1);
        $user = $category->getOwner();
        $result = $user->getUsername();
        $expected = "mejones";
        $this->assertEqual($result,$expected);
    }
    
    function TestGetType()
    {
        $category = new Category(1);
        $result = $category->getType();
        $expected = "Expense";
        $this->assertEqual($result,$expected);
    }
    
    function TestSetName()
    {
        $category = new Category(1);
        $category->setName("FOOD");
        $result = $category->getName();
        $expected = "FOOD";
        $this->assertEqual($result,$expected);
        
        $category->setName("TRANSPORTATION");
        $result = $category->getName();
        $expected = "TRANSPORTATION";
        $this->assertEqual($result,$expected);
    }
    
    function TestSetType()
    {
        $category = new Category(1);
        $category->setType('I');
        $result = $category->getType();
        $expected = "Income";
        $this->assertEqual($result,$expected);
        
        $category->setType('E');
        $result = $category->getType();
        $expected = "Expense";
        $this->assertEqual($result,$expected);
    }
}
*/
?>

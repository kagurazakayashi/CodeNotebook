<?php
class Person{
    public $name;
    public $age;
    
    public function __construct($n,$b){
        $this->name=$n;
        $this->age=$b;
    }

    public function say(){
        echo $this->age;
    }

    public function __destruct(){
        echo 'exit';
    }
}

$xm=new Person('11','22');
$xm->say();
?>
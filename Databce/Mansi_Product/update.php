<?php

    include('connection.php');

    $id = $_POST['id'];
    $name = $_POST['product_name'];
    $price = $_POST['product_price'];
    $des = $_POST['product_des'];

    if($name == "" && $price == "" && $des == "" && $id == "")
    {
        echo '0';
    }
    else 
    {
        $sql = "update yogesh_products set product_name = '$name', product_price = '$price', product_des = '$des' where id = '$id'";

        mysqli_query($con, $sql);
        echo '1';   
    }
        

?>
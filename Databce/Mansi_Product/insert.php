<?php

    include('connection.php');

    $pname = $_POST['product_name'];
    $pprice = $_POST['product_price'];
    $pdes = $_POST['product_des'];

    if($pname == "" && $pprice == "" && $pdes == "")
    {
        echo '0';
    }
    else 
    {
        $sql = "insert into Mansi_products(product_name, product_price, product_des) values('$pname', '$pprice', '$pdes')";
        mysqli_query($con, $sql);
    }
        
?>

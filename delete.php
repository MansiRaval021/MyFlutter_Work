<?php

    include('connection.php');

    $id = $_POST['id'];

    if($id == "")
    {
        echo '0';
    }
    else 
    {
        $sql = "delete from Mansi_products where id = '$id'";
        mysqli_query($con, $sql);
        echo '1';
    }
        

?>
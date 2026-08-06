<?php

    include('connection.php');

    $sql = "select * from Mansi_products";
    $request = mysqli_query($con, $sql);
    $response = array();

    while($row = mysqli_fetch_array($request)){
        $data["id"] = $row["id"];
        $data["product_name"] = $row["product_name"];
        $data["product_price"] = $row["product_price"];
        $data["product_des"] = $row["product_des"]; 
        
        array_push($response, $data);

    }

    echo json_encode($response) +"\n";
    mysqli_close($con);

?>
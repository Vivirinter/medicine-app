<?php  

    require 'config.php';

    $response = array();

    $cek_product = mysqli_query($connection, "SELECT * FROM product WHERE status ='1'");

    while ($row_product = mysqli_fetch_array($cek_product)) {
        $key['id_product'] = $row_product['id_product'];
        $key['id_category'] = $row_product['id_category'];
        $key['name'] = $row_product['name'];
        $key['description'] = $row_product['description'];
        $key['image'] = $row_product['image'];
        $key['price'] = $row_product['price'];
        $key['status'] = $row_product['status'];
        $key['created_at'] = $row_product['created_at'];


        array_push($response, $key);
    }
echo json_encode($response);

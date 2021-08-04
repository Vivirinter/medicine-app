<?php  

    require "config.php";

    $response = array();

    $cek_category = mysqli_query($connection, "SELECT * FROM category_product WHERE status ='on'");

    while ($row_category = mysqli_fetch_array($cek_category)) {
        $id_category = $row_category['id_category'];
        $key['idCategory'] = $id_category;
        $key['category'] = $row_category['category'];
        $key['image'] = $row_category['image'];
        $key['status'] = $row_category['status'];

        $key['product'] = array();

        $cek_product = mysqli_query($connection, "SELECT * FROM product WHERE id_category = '$id_category'");

        while ($row_product = mysqli_fetch_array($cek_product)) {
            $key['product'][] = array(
                'id_product' => $row_product['id_product'],
                'id_category' => $row_product['id_category'],
                'name' => $row_product['name'],
                'description' => $row_product['description'],
                'image' => $row_product['image'],
                'price' => $row_product['price'],
                'price' => $row_product['price'],
                'status' => $row_product['status'],
                'created_at' => $row_product['created_at'],
            );
        }

        array_push($response, $key);
    }
echo json_encode($response);

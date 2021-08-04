<?php

require "config.php";

if ($_SERVER["REQUEST_METHOD"] == 'POST') {

    $response = array();
    $cartID = $_POST['cartID'];
    $type = $_POST['type'];

    $cek_cart = mysqli_query($connection, "SELECT * FROM cart WHERE id_cart = '$cartID'");
    $result = mysqli_fetch_array($cek_cart);

    $qty = $result['quantity'];

    if ($result) {
  
        if ($type == "add") {
       
            $update_add = mysqli_query($connection, "UPDATE cart set quantity = quantity + 1 WHERE id_cart = '$cartID'");
            if ($update_add) {
               
                $response['value'] = 1;
                $response['message'] = "";
                echo json_encode($response);
            } else {
                
                $response['value'] = 0;
                $response['message'] = "Не удалось добавить";
                echo json_encode($response);
            }
        } else {
            
            if ($qty == "1") {
                
                $query_delete = mysqli_query($connection, "DELETE FROM cart WHERE id_cart = '$cartID'");
                if ($query_delete) {
                   
                    $response['value'] = 1;
                    $response['message'] = "";
                    echo json_encode($response);
                } else {
                 
                    $response['value'] = 0;
                    $response['message'] = "Не удалось добавить";
                    echo json_encode($response);
                }
            } else {
                
                $update_wanting = mysqli_query($connection, "UPDATE cart set quantity = quantity - 1 WHERE id_cart = '$cartID'");
                if ($update_wanting) {
                   
                    $response['value'] = 1;
                    $response['message'] = "";
                    echo json_encode($response);
                } else {
                    
                    $response['value'] = 0;
                    $response['message'] = "Не удалось добавить";
                    echo json_encode($response);
                }
            }
        }
    } else {
       
        $response['value'] = 0;
        $response['message'] = "Не удалось добавить";
        echo json_encode($response);
    }
}

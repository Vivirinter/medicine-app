<?php

require "config.php";
$response = array();

$userID = $_GET['userID'];

$selectCart = mysqli_query($connection, "SELECT cart.id_cart, cart.quantity, cart.price, product.name, product.image FROM cart JOIN product on 
cart.id_product = product.id_product WHERE cart.id_user = '$userID'");

while ($row = mysqli_fetch_array($selectCart)) {
    # code...
    $key['id_cart'] = $row['id_cart'];
    $key['quantity'] = $row['quantity'];
    $key['name'] = $row['name'];
    $key['image'] = $row['image'];
    $key['price'] = $row['price'];

    array_push($response, $key);
}

echo json_encode($response);

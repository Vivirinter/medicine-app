<?php

require 'config.php';

$response = array();
$userID = $_GET['userID'];

$query_select_cart = mysqli_query($connection, "SELECT COUNT(*) as Quantity FROM cart WHERE id_user = '$userID'");

while ($row = mysqli_fetch_array($query_select_cart)) {

    $key['Quantity'] = $row['Quantity'];

    array_push($response, $key);
}

echo json_encode($response);

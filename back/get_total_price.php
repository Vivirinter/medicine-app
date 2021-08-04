<?php

require "config.php";

$response = array();
$userID = $_GET['userID'];

$query_total_price = mysqli_query($connection, "SELECT SUM(quantity*price) as Total FROM cart WHERE id_user='$userID'");

$result = mysqli_fetch_array($query_total_price);

$response['Total'] = $result['Total'];

echo json_encode($response);

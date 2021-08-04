<?php

$host = "localhost";
$username = "root";
$password = "";
$db_name = "medicine";
$connection = mysqli_connect($host, $username, $password, $db_name);

if (!$connection) {
    echo "Соединение не удалось";
}

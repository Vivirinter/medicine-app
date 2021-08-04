<?php

require "config.php";

if ($_SERVER['REQUEST_METHOD'] == "POST") {

    $response = array();
    $full_name = $_POST['fullname'];
    $email = $_POST['email'];
    $phone = $_POST['phone'];
    $address = $_POST['address'];
    $password = md5($_POST['password']);

    $query_cek_user = mysqli_query($connection, "SELECT * FROM user WHERE email = '$email' || phone = '$phone'");
    $cek_user_result = mysqli_fetch_array($query_cek_user);

    if ($cek_user_result) {
        $response['value'] = 0;
        $response['message'] = "К сожалению, данные зарегистрированы";
        echo json_encode($response);
    } else {
        $query_insert_user = mysqli_query($connection, "INSERT INTO user VALUE('', '$full_name', '$email', '$phone', '$address', '$password', NOW(), 1)");
        if ($query_insert_user) {
  
            $response['value'] = 1;
            $response['message'] = "Регистрация прошла успешно. Пожалуйста, войдите в свою учетную запись ";
            echo json_encode($response);
        } else {
  
            $response['value'] = 2;
            $response['message'] = "К сожалению, регистрация не удалась";
            echo json_encode($response);
        }
    }
}

<?php

require "config.php";

if ($_SERVER['REQUEST_METHOD'] == "POST") {

    $response = array();
    $email = $_POST['email'];
    $password = md5($_POST['password']);

    $query_cek_user = mysqli_query($connection, "SELECT * FROM user WHERE email = '$email'");
    $cek_user_result = mysqli_fetch_array($query_cek_user);

    if ($cek_user_result) {
        $query_login = mysqli_query($connection, "SELECT * FROM user WHERE email = '$email' && password = '$password'");
        if ($query_login) {

            $response['value'] = 1;
            $response['message'] = "Вход в систему прошел успешно";
            $response['user_id'] = $cek_user_result['id_user'];
            $response['name'] = $cek_user_result['name'];
            $response['email'] = $cek_user_result['email'];
            $response['phone'] = $cek_user_result['phone'];
            $response['address'] = $cek_user_result['address'];
            $response['created_at'] = $cek_user_result['created_at'];
            $response['message'] = "Вход в систему прошел успешно";
            echo json_encode($response);
        } else {
            $response['value'] = 2;
            $response['message'] = "Не удалось войти в систему";
            echo json_encode($response);
        }
    } else {
        $response['value'] = 2;
        $response['message'] = "Данные не зарегистрированы!";
        echo json_encode($response);
    }
}

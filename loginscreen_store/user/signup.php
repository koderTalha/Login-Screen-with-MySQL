<?php
include '../connection.php';

$userName = $_POST['user_name'];
$userEmail = $_POST['user_email'];
$userPass = md5($_POST['user_password']);

 $sqlQuery = "INSERT INTO userdetail SET user_name = '$userName', user_email = '$userEmail', user_password : '$userPass'";

 $responseofquery = $connect->query($sqlQuery);

  if($responseofquery)
  {
    echo json_encode(array("success" => true));
  }
  else
  {
    echo json_encode(array("success" => false));
  }


<?php
include '../connection.php';

$userEmail = $_POST['user_email'];

 $sqlQuery ="SELECT * FROM userdetail WHERE user_email = '$userEmail' ";

 $resultofsqlquery = $connect->query($sqlQuery);

 if($resultofsqlquery->num_rows > 0){
    //agr email pehle hi ho
    echo json_encode(array("emailfound" => true));
 }else{
    //email nhi mili
    echo json_encode(array("emailfound " => false));
 }


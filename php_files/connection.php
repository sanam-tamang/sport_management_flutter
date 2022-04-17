<?php

$hostName = "localhost";
$userName = "root";
$password = "root";
$dbName = "idroot";
try{
    $conn = new mysqli($hostName,$userName,$password,$dbName);
  
}catch(Exception $e){
    $data['message'] = "Connection Error due to ".$e;
}



?>
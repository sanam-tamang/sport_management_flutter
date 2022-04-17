
<?php 
  require('connection.php');
  $data['isSent'] = false; 
 if($_SERVER['REQUEST_METHOD'] == 'POST'){
     //product_info table
       //If we later later productID need to initialize in the db
   //   $productID = $conn->real_escape_string($_POST['productID']);
     $productName = $conn->real_escape_string($_POST['productName']);
     $productQuantity = $conn->real_escape_string($_POST['productQuantity']);
     $productColor = $conn->real_escape_string($_POST['productColor']);
     $productDescription = $conn->real_escape_string($_POST['productDescription']);
       $insertedDate = $conn->real_escape_string($_POST['date']);
    
 
     $sqlProduct = "INSERT INTO product_info(productID,productColor,productName,productQuantity,productDescription,insertedDate)VALUES(null,'$productColor','$productName','$productQuantity','$productDescription','$insertedDate')";
     if($conn->query($sqlProduct)=== TRUE){
         $data['isSent'] = true;
     }
     else{
        $data['isSent']  = false; 
     }
}
else{
   echo "<h1'> Method Error </h1>";
}
$conn->close();
header("Content-Type:application/json");
echo json_encode($data);

?>


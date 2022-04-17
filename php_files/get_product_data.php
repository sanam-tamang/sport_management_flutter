<?php

require('connection.php');
 $hasData = false;
      $allRows;
if($_SERVER['REQUEST_METHOD'] == 'GET'){
    $sql = "SELECT * FROM product_info";
    $result = $conn->query($sql);
    if($result->num_rows>0){
          $hasData = true;
     

       while($rows = $result->fetch_assoc()){
          //it simply returns the all the data of or tuples 
          //in data key
          //all rows in $allRows variable
         $allRows[] = $rows;
            
       }
      
    }
    else{
        $hasData = false;
    }
}else{
    echo "Method Error";
}
$conn->close();
//returnin json data to the server
header('Content-Type:application/json');

  $rowsArray = array('hasData' => $hasData, 'data' => $allRows, );
echo json_encode($rowsArray);

?>
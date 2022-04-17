<?php

require('connection.php');
$hasData = false;
$allRows = null;
if($_SERVER['REQUEST_METHOD'] == 'GET'){
    $sql = "SELECT * FROM student_info";
    $result = $conn->query($sql);
    if($result->num_rows>0){
      
       $hasData = true;
       while($rows = $result->fetch_assoc()){
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
header('Content-Type:application/json');

$allData = array('hasData'=> $hasData,'data' => $allRows );
echo json_encode($allData);


?>
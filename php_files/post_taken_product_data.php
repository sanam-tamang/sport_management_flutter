<?php 
  require('connection.php');
  //list of any product taken from the office
  $data['isSent'] = false; 
 if($_SERVER['REQUEST_METHOD'] == 'POST'){
    
    //student_info table
     $studentID  = $conn->real_escape_string($_POST['studentID']);
     $studentName = $conn->real_escape_string($_POST['studentName']);
     $studentFaculty = $conn->real_escape_string($_POST['studentFaculty']);
     //takenProduct : is a product which student or anyone 
     //take from sport house eg. football,basketball etc
     $takenProduct = $conn->real_escape_string($_POST['takenProduct']);
       $takenDate = $conn->real_escape_string($_POST['date']);
     
     $sqlStudent = "INSERT INTO student_info(studentID,studentName,studentFaculty,takenProduct,takenDate)VALUES('$studentID','$studentName','$studentFaculty','$takenProduct','$takenDate')";
    
     if($conn->query($sqlStudent)===TRUE){
         $data['isSent'] = true;
     }
     else{
       
        $data['isSent'] = false; 
     }

}
else{
    echo "<h1'> Method Error </h1>";
}
$conn->close();
header("Content-Type:application/json");
echo json_encode($data);

?>
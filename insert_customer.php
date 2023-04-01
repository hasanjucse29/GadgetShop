<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "shopDB";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $first_name = $_POST["first_name"];
  $last_name = $_POST["last_name"];
  $email = $_POST["email"];
  $phone = $_POST["phone"];
  $address = $_POST["address"];
  $city = $_POST["city"];
  $state = $_POST["state"];
  $zip = $_POST["zip"];

  $sql = "INSERT INTO Customers (first_name, last_name, email, phone, address, city, state, zip)
  VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

  $stmt = $conn->prepare($sql);
  $stmt->bind_param("sssssssi", $first_name, $last_name, $email, $phone, $address, $city, $state, $zip);

  if ($stmt->execute() === TRUE) {
    echo "New record created successfully";
	header("Location: \shopDB\Home.html");
	    exit();
  } else {
    echo "Error: " . $sql . "<br>" . $conn->error;
  }

  $stmt->close();
}

$conn->close();
?>

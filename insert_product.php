<?php
// Check if the form has been submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
  // Retrieve the form data
  $product_name = $_POST["product_name"];
  $product_description = $_POST["product_description"];
  $product_type = $_POST["product_type"];
  $brand_name = $_POST["brand_name"];
  $price = $_POST["price"];
  $stock = $_POST["stock"];

  // Connect to the database
  $servername = "localhost";
  $username = "root";
  $password = "";
  $dbname = "shopDB";

  $conn = new mysqli($servername, $username, $password, $dbname);

  // Check connection
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  // Prepare the SQL statement
  $sql = "INSERT INTO Products (product_name, product_description, product_type, brand_name, price, stock) VALUES (?, ?, ?, ?, ?, ?)";
  $stmt = $conn->prepare($sql);
  $stmt->bind_param("ssssdi", $product_name, $product_description, $product_type, $brand_name, $price, $stock);

  // Execute the statement
  if ($stmt->execute()) {
    echo "New product added successfully";
	header("Location: \shopDB\home.html");
	    exit();
  } else {
    echo "Error: " . $sql . "<br>" . $conn->error;
  }

  // Close the connection
  $stmt->close();
  $conn->close();
}
?>

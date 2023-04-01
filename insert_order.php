<?php
	$customer_id = $_POST['customer_id'];
	$product_id = $_POST['product_id'];
	$quantity = $_POST['quantity'];
	
	$db_host = 'localhost';
	$db_user = 'root';
	$db_password = '';
	$db_name = 'shopDB';
	
	$conn = mysqli_connect($db_host, $db_user, $db_password, $db_name);
	
	if (!$conn) {
		die('Connection failed: ' . mysqli_connect_error());
	}
	
	$sql = "INSERT INTO orders (customer_id, product_id, quantity) VALUES ('$customer_id', '$product_id', '$quantity')";
	
	if (mysqli_query($conn, $sql)) {
		echo "Order placed successfully.";
		header("Location: \shopDB\Home.html");
	    exit();
	} else {
		echo "Error: " . mysqli_error($conn);
	}
	
	mysqli_close($conn);
?>

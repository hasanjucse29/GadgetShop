-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 01, 2023 at 12:21 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shopdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `zip` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `first_name`, `last_name`, `email`, `phone`, `address`, `city`, `state`, `zip`) VALUES
(1, 'Hasan', 'Al Mamun', 'jucse29.399@gmail.com', '01306380171', 'sdfghjk', 'dfghjk', 'dfghjk', '8525'),
(2, 'Hasan', 'Al Mamun', 'jucse29.399@gmail.com', '01306380171', 'sdfghjk', 'dfghjk', 'dfghjk', '8525'),
(3, 'Fatima ', 'Binte Aziz', 'jucse29.367@gmail.com', '01306380171', 'sdfghjk', 'dfghjk', '1351', '8525'),
(4, 'Hasan', 'Al Mamun', 'jucse29.399@gmail.com', '01306380171', 'sdfghjk', 'dfghjk', 'dfghjk', '8525'),
(5, 'Sovon', 'Mallick', 'jucse29.380@gmail.com', '01720510987', '21 No Hall, JU', 'Satkhira', 'Khulna', '9442'),
(6, 'Sudipta', 'Singha', 'jucse29.408@gmail.com', '01746579065', '21 No Hall,JU', 'Moulvibazar', 'Sylhet', '3220'),
(7, 'Jubaer ', 'Ahmed Khan (Predator)', 'jucse29.403@gmail.com', '0151267891', '21 No Hall', 'Gopalganj', 'Khulna', '3898'),
(8, 'Tamjid', 'Islam', 'jucse29.382@gmail.com', '01682926657', 'Savar, Dhaka', 'Feni', 'Chittagong', '51465');

-- --------------------------------------------------------

--
-- Stand-in structure for view `customer_orders`
-- (See below for the actual view)
--
CREATE TABLE `customer_orders` (
`customer_id` int(11)
,`first_name` varchar(50)
,`order_id` int(11)
,`product_name` varchar(255)
,`price` decimal(10,2)
,`quantity` int(11)
,`total_price` decimal(20,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `product_id`, `total_price`, `quantity`) VALUES
(3, 6, 3, '5250.00', 5),
(4, 3, 3, '10500.00', 10),
(5, 3, 3, '10500.00', 10),
(6, 6, 5, '8520.00', 10),
(7, 2, 7, '120000.00', 3),
(8, 8, 6, '150000.00', 1),
(9, 8, 5, '4260.00', 5);

--
-- Triggers `orders`
--
DELIMITER $$
CREATE TRIGGER `calc_total_price` BEFORE INSERT ON `orders` FOR EACH ROW BEGIN
  SET NEW.total_price = (
    SELECT price * NEW.quantity FROM products WHERE product_id = NEW.product_id
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_description` text DEFAULT NULL,
  `product_type` varchar(50) NOT NULL,
  `brand_name` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `product_description`, `product_type`, `brand_name`, `price`, `stock`) VALUES
(1, 'A', 'B', 'Books', 'C', '1050.00', 500),
(2, 'C', 'D', 'Books', 'E', '1050.00', 500),
(3, 'C', 'D', 'Books', 'E', '1050.00', 500),
(4, 'W', 'X', 'Beauty', 'T', '5.00', 5),
(5, 'Electric Kettle', 'Very Nice', 'Electronics', 'Jago', '852.00', 966),
(6, 'Iphone12', 'This is very stylish and expensive', 'Electronics', 'Apple', '150000.00', 1000),
(7, 'Xiaomi K20 Pro', '6.28 ich Super Amoled Display', 'Electronics', 'Xiaomi', '40000.00', 10),
(8, 'HP 15S-DU-1027TX', '14 inch Display, core i3 processor, 8 GB RAM, 1TB HDD', 'Clothing', 'HP', '55000.00', 20);

-- --------------------------------------------------------

--
-- Structure for view `customer_orders`
--
DROP TABLE IF EXISTS `customer_orders`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `customer_orders`  AS SELECT `c`.`customer_id` AS `customer_id`, `c`.`first_name` AS `first_name`, `o`.`order_id` AS `order_id`, `p`.`product_name` AS `product_name`, `p`.`price` AS `price`, `o`.`quantity` AS `quantity`, `p`.`price`* `o`.`quantity` AS `total_price` FROM ((`customers` `c` join `orders` `o` on(`c`.`customer_id` = `o`.`customer_id`)) join `products` `p` on(`o`.`product_id` = `p`.`product_id`))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

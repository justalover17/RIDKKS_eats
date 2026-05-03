-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 03, 2026 at 05:01 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ridkks_eats`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
                        `cart_id` int(11) NOT NULL,
                        `user_id` int(11) DEFAULT NULL,
                        `created_at` timestamp DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cart_details`
--

CREATE TABLE `cart_details` (
                                `cart_detail_id` int(11) NOT NULL,
                                `cart_id` int(11) DEFAULT NULL,
                                `food_id` int(11) DEFAULT NULL,
                                `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
                            `category_id` int(11) NOT NULL,
                            `category_name` varchar(50) NOT NULL,
                            `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
                            `updated_at` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category_name`) VALUES
(1, 'Nepali'),
(2, 'Breakfast'),
(3, 'Desserts'),
(4, 'Drinks'),
(5, 'Italian');

-- --------------------------------------------------------

--
-- Table structure for table `food_item`
--

CREATE TABLE `food_item` (
                             `food_id` int(11) NOT NULL,
                             `name` varchar(100) NOT NULL,
                             `price` decimal(10,2) NOT NULL,
                             `category_id` int(11) DEFAULT NULL,
                             `description` varchar(500) DEFAULT NULL,
                             `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
                             `updated_at` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `food_item`
--

INSERT INTO `food_item` (`food_id`, `name`, `price`, `category_id`, `description`) VALUES
(1, 'Burger', 250.00, 1, 'Delicious juicy burger with fresh veggies.'),
(2, 'Chicken Biryani', 450.00, 1, 'Authentic spiced chicken biryani with raita.'),
(3, 'Chicken Chowmein', 200.00, 1, 'Stir-fried noodles with chicken and veggies.'),
(4, 'Chicken Momo', 250.00, 1, 'Steamed chicken dumplings with spicy achar.'),
(5, 'Fried Rice', 220.00, 1, 'Wok-tossed fried rice with fresh ingredients.'),
(6, 'Kathi Roll', 180.00, 1, 'Spicy chicken wrapped in a flaky paratha.'),
(7, 'Keema Noodles', 260.00, 1, 'Spicy minced meat served over perfectly cooked noodles.'),
(8, 'Momo Platter', 550.00, 1, 'A grand assortment of our best momos in different styles.'),
(9, 'Pad thai', 480.00, 1, 'Authentic sweet and savory stir-fried rice noodles.'),
(10, 'Club sandwich', 300.00, 2, 'Triple decker sandwich with chicken, egg, and mayo.'),
(11, 'Riddiks Breakfast', 450.00, 2, 'Eggs, toast, sausages, beans, and grilled tomatoes.'),
(12, 'Vanilla  Waffle', 350.00, 2, 'Crispy waffle with premium vanilla ice cream and syrup.'),
(13, 'Croissants', 200.00, 2, 'Freshly baked flaky buttery croissants.'),
(14, 'Smoothie Bowl', 350.00, 2, 'Healthy and fresh fruit smoothie bowl.'),
(15, 'Chocolate Brownie', 250.00, 3, 'Rich, fudgy chocolate brownie served warm.'),
(16, 'Red Velvet Cake', 300.00, 3, 'Classic red velvet slice with cream cheese frosting.'),
(17, 'Blue Berry Cake', 320.00, 3, 'Soft cake loaded with fresh blueberries and cream.'),
(18, 'Tiramisu', 400.00, 3, 'Classic Italian coffee-flavored dessert with mascarpone.'),
(19, 'Banana Cake', 200.00, 3, 'Moist and sweet homemade banana bread slice.'),
(20, 'Iced Matcha Latte', 300.00, 4, 'Refreshing premium iced matcha green tea.'),
(21, 'Iced Americano', 250.00, 4, 'Chilled espresso poured over iced water.'),
(22, 'Peach Iced Tea', 220.00, 4, 'Sweet and refreshing peach infused tea over ice.'),
(23, 'Cold Drinks', 100.00, 4, 'Assorted chilled carbonated beverages.'),
(24, 'Mojito', 350.00, 4, 'Classic mint and lime refreshing cooler.'),
(25, 'Strawberry Milkshake', 350.00, 4, 'Creamy shake blended with fresh strawberries.'),
(26, 'Pizza', 750.00, 5, 'Classic wood-fired pizza with rich tomato sauce and mozzarella.'),
(27, 'Spaghetti', 550.00, 5, 'Traditional Italian spaghetti tossed in rich bolognese sauce.'),
(28, 'Sirloin steak', 1200.00, 5, 'Premium cut steak grilled to perfection with mashed potatoes.');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
                          `order_id` int(11) NOT NULL,
                          `user_id` int(11) DEFAULT NULL,
                          `order_date` date DEFAULT NULL,
                          `total_amount` decimal(10,2) DEFAULT NULL,
                          `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
                                 `order_detail_id` int(11) NOT NULL,
                                 `order_id` int(11) DEFAULT NULL,
                                 `food_id` int(11) DEFAULT NULL,
                                 `quantity` int(11) DEFAULT NULL,
                                 `subtotal` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
                         `user_id` int(11) NOT NULL,
                         `name` varchar(100) NOT NULL,
                         `email` varchar(100) NOT NULL,
                         `password` varchar(255) NOT NULL,
                         `phone` varchar(20) DEFAULT NULL,
                         `role` varchar(20) DEFAULT NULL,
                         `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
                         `updated_at` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `password`, `phone`, `role`) VALUES
    (1, 'Admin', 'admin@gmail.com', '$2a$10$5tG8ImLq.HApXHgeKcbuvuFi3QJNEcEM8azDTjcjNgk1UG3Se5.x.', '9800000000', 'admin');



-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
    ADD PRIMARY KEY (`cart_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `cart_details`
--
ALTER TABLE `cart_details`
    ADD PRIMARY KEY (`cart_detail_id`),
  ADD UNIQUE KEY `cart_id` (`cart_id`,`food_id`),
  ADD KEY `food_id` (`food_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
    ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_name` (`category_name`);

--
-- Indexes for table `food_item`
--
ALTER TABLE `food_item`
    ADD PRIMARY KEY (`food_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
    ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
    ADD PRIMARY KEY (`order_detail_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `food_id` (`food_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
    ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
    MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cart_details`
--
ALTER TABLE `cart_details`
    MODIFY `cart_detail_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
    MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `food_item`
--
ALTER TABLE `food_item`
    MODIFY `food_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
    MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
    MODIFY `order_detail_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
    MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
    ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `cart_details`
--
ALTER TABLE `cart_details`
    ADD CONSTRAINT `cart_details_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`),
  ADD CONSTRAINT `cart_details_ibfk_2` FOREIGN KEY (`food_id`) REFERENCES `food_item` (`food_id`);

--
-- Constraints for table `food_item`
--
ALTER TABLE `food_item`
    ADD CONSTRAINT `food_item_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
    ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
    ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`food_id`) REFERENCES `food_item` (`food_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

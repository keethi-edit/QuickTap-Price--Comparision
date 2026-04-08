/*
SQLyog Community Edition- MySQL GUI v7.15 
MySQL - 5.5.29 : Database - grocery_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`grocery_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `grocery_db`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `admin` */

insert  into `admin`(`username`,`password`) values ('admin','admin'),('admin','admin');

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `login` */

insert  into `login`(`username`,`password`) values ('rashmika','1234');

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) NOT NULL,
  `description` text,
  `quantity` varchar(30) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `shop_id` int(11) DEFAULT NULL,
  `image` varchar(500) NOT NULL,
  PRIMARY KEY (`product_id`),
  KEY `shop_id` (`shop_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`shop_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4;

/*Data for the table `products` */

insert  into `products`(`product_id`,`product_name`,`description`,`quantity`,`price`,`shop_id`,`image`) values (35,'Pen','blue color','1','10.00',10,'pen.jpg'),(36,'Book','classmate 40 pages','1','35.00',10,'book.jpg'),(38,'Book','classmate 40 pages','1','25.00',5,'book.jpg'),(39,'Pen','blue color','1','15.00',5,'pen.jpg'),(40,'Milk packet','Use by  30 july 2025','250ml','23.00',5,'milk.jpg'),(41,'Milk packet','Use by  30 july 2025','250ml','25.00',10,'milk.jpg'),(42,'Milk packet','Use by  30 july 2025','250ml','30.00',15,'milk.jpg'),(43,'Book','classmate 40 pages','1','30.00',15,'book.jpg'),(44,'Pen','blue color','1','13.00',15,'pen.jpg'),(45,'Pen','blue color','1','20.00',20,'pen.jpg'),(46,'Book','classmate 40 pages','1','20.00',20,'book.jpg'),(48,'Milk packet','Use by 30 july 2025','250 ml','35.00',20,'milk.jpg'),(49,'heritagemilk','heritagemilk','500ml','40.00',111,'milk.jpg');

/*Table structure for table `shops` */

DROP TABLE IF EXISTS `shops`;

CREATE TABLE `shops` (
  `shop_id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_name` varchar(100) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`shop_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4;

/*Data for the table `shops` */

insert  into `shops`(`shop_id`,`shop_name`,`address`,`email`,`mobile`,`status`) values (5,'VishalMart','Nzb','VishalMart@gmail.com','9886543432',1),(10,'DMart','Nzb','DMart@gmail.com','98865434712',1),(15,'RelianceSmart','Nzb','RelianceSmart@gmail.com','98865434737',1),(20,'Reliance','Nzb','Reliance@gmail.com','98865434737',1),(111,'fox','ameerpet','fox@gmail.com','7878787878',1);

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `status` int(11) NOT NULL,
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `student` */

insert  into `student`(`username`,`password`,`gender`,`address`,`email`,`mobile`,`status`) values ('Rashmika','1234','Female','Nzb','rashmika@gmail.com','9014065600',1),('shanthan','shan','Male','hyd','shan@gmail.com','7702177291',1);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

/*Data for the table `users` */

insert  into `users`(`user_id`,`email`,`password`,`status`) values (1,'rashmikarashu28@gmail.com','1234',0),(2,'satwika1@gmail.com','12345',0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;

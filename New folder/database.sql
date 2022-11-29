-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema batch2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema batch2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `batch2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `batch2` ;

-- -----------------------------------------------------
-- Table `batch2`.`admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `batch2`.`admin` (
  `admin_id` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `fullname` VARCHAR(50) NOT NULL,
  `contact` VARCHAR(15) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `admin_group_id` INT NOT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE INDEX `password_UNIQUE` (`password` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `user_group_id_UNIQUE` (`admin_group_id` ASC) VISIBLE,
  INDEX `user_idx` (`admin_group_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `batch2`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `batch2`.`company` (
  `company_id` INT NOT NULL,
  `company_name` VARCHAR(45) NOT NULL,
  `company_email` VARCHAR(45) NOT NULL,
  `company_profile` VARCHAR(250) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`company_id`, `user_id`),
  INDEX `company_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `company`
    FOREIGN KEY (`user_id`)
    REFERENCES `batch2`.`admin` (`admin_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `batch2`.`coupon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `batch2`.`coupon` (
  `coupon_id` INT NOT NULL,
  `coupon_amt` INT NOT NULL,
  `expiray_date` DATE NOT NULL,
  `coupon_name` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `coupon_id_UNIQUE` (`coupon_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `batch2`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `batch2`.`customer` (
  `customer_id` INT NOT NULL,
  `customer_code` VARCHAR(45) NOT NULL,
  `customer_name` VARCHAR(45) NOT NULL,
  `email_address` VARCHAR(45) NOT NULL,
  `contact_number` VARCHAR(45) NOT NULL,
  `complete_address` VARCHAR(100) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`customer_id`, `user_id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `password_UNIQUE` (`password` ASC) VISIBLE,
  INDEX `customer_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `customer`
    FOREIGN KEY (`user_id`)
    REFERENCES `batch2`.`admin` (`admin_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `batch2`.`login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `batch2`.`login` (
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  INDEX `login_idx` (`username` ASC, `password` ASC) VISIBLE,
  INDEX `login_ibfk_1_idx` (`password` ASC) VISIBLE,
  CONSTRAINT `login`
    FOREIGN KEY (`username`)
    REFERENCES `batch2`.`admin` (`username`),
  CONSTRAINT `login_ibfk_1`
    FOREIGN KEY (`password`)
    REFERENCES `batch2`.`admin` (`password`),
  CONSTRAINT `login_ibfk_2`
    FOREIGN KEY (`username`)
    REFERENCES `batch2`.`customer` (`username`),
  CONSTRAINT `login_ibfk_3`
    FOREIGN KEY (`password`)
    REFERENCES `batch2`.`customer` (`password`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `batch2`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `batch2`.`order` (
  `order_id` INT NOT NULL,
  `reference_no` VARCHAR(45) NOT NULL,
  `customer_id` INT NOT NULL,
  `order_date` DATE NOT NULL,
  `expected_delivery_date` DATE NOT NULL,
  `total_amount` FLOAT NOT NULL,
  `number_of_items` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`order_id`, `customer_id`, `user_id`),
  INDEX `order_idx` (`user_id` ASC) VISIBLE,
  INDEX `order_idx1` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `order`
    FOREIGN KEY (`user_id`)
    REFERENCES `batch2`.`admin` (`admin_id`),
  CONSTRAINT `order_ibfk_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `batch2`.`customer` (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `batch2`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `batch2`.`product` (
  `product_id` INT NOT NULL,
  `product_code` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `product_name` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `product_details` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `product_category_id` INT NOT NULL,
  `quantity_on_hand` INT NOT NULL,
  `retail_price` FLOAT NOT NULL,
  `coupon_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`product_id`, `product_category_id`, `user_id`),
  INDEX `product_idx` (`user_id` ASC) VISIBLE,
  INDEX `product_ibfk_1_idx` (`coupon_id` ASC) VISIBLE,
  CONSTRAINT `product`
    FOREIGN KEY (`user_id`)
    REFERENCES `batch2`.`admin` (`admin_id`),
  CONSTRAINT `product_ibfk_1`
    FOREIGN KEY (`coupon_id`)
    REFERENCES `batch2`.`coupon` (`coupon_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin;


-- -----------------------------------------------------
-- Table `batch2`.`order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `batch2`.`order_details` (
  `order_details_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `quantity_price` FLOAT NOT NULL,
  PRIMARY KEY (`order_details_id`, `order_id`, `product_id`),
  INDEX `order_details_idx` (`order_id` ASC) VISIBLE,
  INDEX `order_details_idx1` (`product_id` ASC) VISIBLE,
  CONSTRAINT `order_details`
    FOREIGN KEY (`order_id`)
    REFERENCES `batch2`.`order` (`order_id`),
  CONSTRAINT `order_details_ibfk_1`
    FOREIGN KEY (`product_id`)
    REFERENCES `batch2`.`product` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `batch2`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `batch2`.`payment` (
  `payment_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `amount_paid` FLOAT NOT NULL,
  `payment_status` INT NOT NULL,
  `paid_by` VARCHAR(45) NOT NULL,
  `user_id` INT NOT NULL,
  `coupon_id` INT NOT NULL,
  PRIMARY KEY (`payment_id`, `order_id`),
  INDEX `payment_idx` (`user_id` ASC) VISIBLE,
  INDEX `payment_idx1` (`order_id` ASC) VISIBLE,
  INDEX `payment_ibfk_2_idx` (`amount_paid` ASC) VISIBLE,
  INDEX `payment_ibfk_2_idx1` (`coupon_id` ASC) VISIBLE,
  INDEX `payment_2_idx` (`coupon_id` ASC, `payment_id` ASC) VISIBLE,
  CONSTRAINT `payment`
    FOREIGN KEY (`user_id`)
    REFERENCES `batch2`.`admin` (`admin_id`),
  CONSTRAINT `payment_ibfk_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `batch2`.`order` (`order_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `batch2`.`product_categpory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `batch2`.`product_categpory` (
  `product_category_id` INT NOT NULL,
  `category_name` VARCHAR(45) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`product_category_id`, `user_id`),
  INDEX `product_category_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `product_category`
    FOREIGN KEY (`user_id`)
    REFERENCES `batch2`.`admin` (`admin_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `batch2`.`user_group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `batch2`.`user_group` (
  `user_group_id` INT NOT NULL,
  `group_name` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `allow_add` INT NOT NULL,
  `allow edit` INT NOT NULL,
  `allow delete` INT NOT NULL,
  `allow_print` INT NOT NULL,
  `allow_import` INT NOT NULL,
  `allow_export` INT NOT NULL,
  UNIQUE INDEX `user_group_id_UNIQUE` (`user_group_id` ASC),
  CONSTRAINT `user_group`
    FOREIGN KEY (`user_group_id`)
    REFERENCES `batch2`.`admin` (`admin_group_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

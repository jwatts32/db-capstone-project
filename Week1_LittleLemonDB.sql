-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemon
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemon
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemon` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemon` ;

-- -----------------------------------------------------
-- Table `LittleLemon`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemon`.`Customers` (
  `CustomerID` INT NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemon`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemon`.`Bookings` (
  `BookingID` INT NOT NULL,
  `Date` DATE NOT NULL,
  `TableNumber` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `customerID_fk_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `customerID_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemon`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemon`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemon`.`Menu` (
  `MenuID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Cuisine` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`MenuID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemon`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemon`.`Orders` (
  `OrderID` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Quantity` INT NOT NULL,
  `TotalCost` DECIMAL NOT NULL,
  `CustomerID` INT NOT NULL,
  `MenuID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `customer_ID_fk_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `menu_ID_fk_idx` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `customer_ID_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemon`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `menuID_fk`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemon`.`Menu` (`MenuID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemon`.`Delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemon`.`Delivery` (
  `DeliveryID` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  `OrderID` INT NOT NULL,
  `StaffID` INT NOT NULL,
  PRIMARY KEY (`DeliveryID`),
  INDEX `orderID_fk_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `orderID_fk`
    FOREIGN KEY (`OrderID`)
    REFERENCES `LittleLemon`.`Orders` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemon`.`Role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemon`.`Role` (
  `RoleID` INT NOT NULL,
  `RoleName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`RoleID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemon`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemon`.`Staff` (
  `StaffID` INT NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `Salary` DECIMAL NOT NULL,
  `RoleID` INT NOT NULL,
  PRIMARY KEY (`StaffID`),
  INDEX `roleID_fk_idx` (`RoleID` ASC) VISIBLE,
  CONSTRAINT `roleID_fk`
    FOREIGN KEY (`RoleID`)
    REFERENCES `LittleLemon`.`Role` (`RoleID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemon`.`Contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemon`.`Contact` (
  `ContactID` INT NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  `ZipCode` INT NOT NULL,
  `Country` VARCHAR(45) NOT NULL,
  `PhoneNumber` INT NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `CustomerID` INT NULL,
  `StaffID` INT NULL,
  PRIMARY KEY (`ContactID`),
  INDEX `cust_id_fk_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `staff_id_fk_idx` (`StaffID` ASC) VISIBLE,
  CONSTRAINT `cust_id_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemon`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `staff_id_fk`
    FOREIGN KEY (`StaffID`)
    REFERENCES `LittleLemon`.`Staff` (`StaffID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemon`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemon`.`MenuItems` (
  `MenuItemID` INT NOT NULL,
  `Course` VARCHAR(45) NOT NULL,
  `Appetizer` VARCHAR(45) NULL,
  `Dessert` VARCHAR(45) NULL,
  PRIMARY KEY (`MenuItemID`),
  CONSTRAINT `menu_fk`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `LittleLemon`.`Menu` (`MenuID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemon`.`MenuContent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemon`.`MenuContent` (
  `MenuID` INT NOT NULL,
  `MenuItemID` INT NOT NULL,
  INDEX `menuID_fk_idx` (`MenuID` ASC) VISIBLE,
  INDEX `menu_item_ID_fk_idx` (`MenuItemID` ASC) VISIBLE,
  CONSTRAINT `menu_ID2_fk`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemon`.`Menu` (`MenuID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `menu_item_ID_fk`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `LittleLemon`.`MenuItems` (`MenuItemID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

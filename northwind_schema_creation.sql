# ---------------------------------------------------------------------- #
# Target DBMS:       MySQL 8                                        #
# Project name:      Northwind                                       #
# Author:            Sachin Prabhu                                  #
# ---------------------------------------------------------------------- #



SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Schema northwind
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `northwind` ;

-- -----------------------------------------------------
-- Schema northwind
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `northwind` DEFAULT CHARACTER SET utf8 ;
USE `northwind` ;

-- -----------------------------------------------------
-- Table `northwind`.`Categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `northwind`.`Categories` ;

CREATE TABLE IF NOT EXISTS `northwind`.`Categories` (
  `CategoryID` INT(11) NOT NULL,
  `CategoryName` VARCHAR(15) NOT NULL,
  `Description` MEDIUMTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`CategoryID`),
  INDEX `idx_CategoryName` (`CategoryName` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `northwind`.`Customer_Demographics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `northwind`.`Customer_Demographics` ;

CREATE TABLE IF NOT EXISTS `northwind`.`Customer_Demographics` (
  `CustomerTypeID` VARCHAR(10) NOT NULL,
  `CustomerDesc` MEDIUMTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`CustomerTypeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `northwind`.`Customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `northwind`.`Customers` ;

CREATE TABLE IF NOT EXISTS `northwind`.`Customers` (
  `CustomerID` VARCHAR(5) NOT NULL,
  `CompanyName` VARCHAR(40) NOT NULL,
  `ContactName` VARCHAR(30) NULL DEFAULT NULL,
  `ContactTitle` VARCHAR(30) NULL DEFAULT NULL,
  `Address` VARCHAR(60) NULL DEFAULT NULL,
  `City` VARCHAR(15) NULL DEFAULT NULL,
  `Region` VARCHAR(15) NULL DEFAULT NULL,
  `PostalCode` VARCHAR(10) NULL DEFAULT NULL,
  `Country` VARCHAR(15) NULL DEFAULT NULL,
  `Phone` VARCHAR(24) NULL DEFAULT NULL,
  `Fax` VARCHAR(24) NULL DEFAULT NULL,
  PRIMARY KEY (`CustomerID`),
  INDEX `idx_City` (`City` ASC) ,
  INDEX `idx_CompanyName` (`CompanyName` ASC) ,
  INDEX `idx_PostalCode` (`PostalCode` ASC) ,
  INDEX `idx_Region` (`Region` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `northwind`.`Customer_customer_demo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `northwind`.`Customer_customer_demo` ;

CREATE TABLE IF NOT EXISTS `northwind`.`Customer_customer_demo` (
  `CustomerID` VARCHAR(5) NOT NULL,
  `CustomerTypeID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`CustomerID`, `CustomerTypeID`),
  INDEX `fk_CustomerTypeID_idx` (`CustomerTypeID` ASC) ,
  CONSTRAINT `fk_CustomerTypeID`
    FOREIGN KEY (`CustomerTypeID`)
    REFERENCES `northwind`.`Customer_Demographics` (`CustomerTypeID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Customer_customer_demo_Customers1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `northwind`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `northwind`.`Employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `northwind`.`Employees` ;

CREATE TABLE IF NOT EXISTS `northwind`.`Employees` (
  `EmployeeID` INT(11) NOT NULL,
  `LastName` VARCHAR(20) NOT NULL,
  `FirstName` VARCHAR(10) NOT NULL,
  `Title` VARCHAR(30) NULL DEFAULT NULL,
  `TitleOfCourtesy` VARCHAR(25) NULL DEFAULT NULL,
  `BirthDate` DATETIME NULL DEFAULT NULL,
  `HireDate` DATETIME NULL DEFAULT NULL,
  `Address` VARCHAR(60) NULL DEFAULT NULL,
  `City` VARCHAR(15) NULL DEFAULT NULL,
  `Region` VARCHAR(15) NULL DEFAULT NULL,
  `PostalCode` VARCHAR(10) NULL DEFAULT NULL,
  `Country` VARCHAR(15) NULL DEFAULT NULL,
  `HomePhone` VARCHAR(24) NULL DEFAULT NULL,
  `Extension` VARCHAR(4) NULL DEFAULT NULL,
  `Notes` MEDIUMTEXT NOT NULL,
  `ReportsTo` INT(11) NULL DEFAULT NULL,
  `PhotoPath` VARCHAR(255) NULL DEFAULT NULL,
  `Salary` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`),
  INDEX `idx_fk_ReportsTo` (`ReportsTo` ASC) ,
  INDEX `idx_LastName` (`LastName` ASC) ,
  INDEX `idx_PostalCode` (`PostalCode` ASC) ,
  CONSTRAINT `fk_ReportsTo`
    FOREIGN KEY (`ReportsTo`)
    REFERENCES `northwind`.`Employees` (`EmployeeID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `northwind`.`Region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `northwind`.`Region` ;

CREATE TABLE IF NOT EXISTS `northwind`.`Region` (
  `RegionID` INT(11) UNSIGNED NOT NULL,
  `RegionDescription` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`RegionID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `northwind`.`Territories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `northwind`.`Territories` ;

CREATE TABLE IF NOT EXISTS `northwind`.`Territories` (
  `TerritoryID` VARCHAR(20) NOT NULL,
  `TerritoryDescription` VARCHAR(50) NOT NULL,
  `RegionID` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`TerritoryID`),
  INDEX `fk_territories_region` (`RegionID` ASC) ,
  CONSTRAINT `fk_territories_region`
    FOREIGN KEY (`RegionID`)
    REFERENCES `northwind`.`Region` (`RegionID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `northwind`.`Employee_Territories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `northwind`.`Employee_Territories` ;

CREATE TABLE IF NOT EXISTS `northwind`.`Employee_Territories` (
  `EmployeeID` INT(11) NOT NULL,
  `TerritoryID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`EmployeeID`, `TerritoryID`),
  INDEX `fk_employee_territories_territories_idx` (`TerritoryID` ASC) ,
  CONSTRAINT `fk_employee_territories_employees`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `northwind`.`Employees` (`EmployeeID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_employee_territories_territories`
    FOREIGN KEY (`TerritoryID`)
    REFERENCES `northwind`.`Territories` (`TerritoryID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `northwind`.`Shippers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `northwind`.`Shippers` ;

CREATE TABLE IF NOT EXISTS `northwind`.`Shippers` (
  `ShipperID` INT(11) NOT NULL,
  `CompanyName` VARCHAR(40) NOT NULL,
  `Phone` VARCHAR(24) NULL DEFAULT NULL,
  PRIMARY KEY (`ShipperID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `northwind`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `northwind`.`Orders` ;

CREATE TABLE IF NOT EXISTS `northwind`.`Orders` (
  `OrderID` INT(11) NOT NULL,
  `CustomerID` VARCHAR(5) NULL DEFAULT NULL,
  `EmployeeID` INT(11) NULL DEFAULT NULL,
  `OrderDate` DATETIME NULL DEFAULT NULL,
  `RequiredDate` DATETIME NULL DEFAULT NULL,
  `ShippedDate` DATETIME NULL DEFAULT NULL,
  `ShipVia` INT(11) NULL DEFAULT NULL,
  `Freight` DECIMAL(10,4) NULL DEFAULT '0.0000',
  `ShipName` VARCHAR(40) NULL DEFAULT NULL,
  `ShipAddress` VARCHAR(60) NULL DEFAULT NULL,
  `ShipCity` VARCHAR(15) NULL DEFAULT NULL,
  `ShipRegion` VARCHAR(15) NULL DEFAULT NULL,
  `ShipPostalCode` VARCHAR(10) NULL DEFAULT NULL,
  `ShipCountry` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `idx_fk_CustomerID` (`CustomerID` ASC) ,
  INDEX `idx_fk_EmployeeID` (`EmployeeID` ASC) ,
  INDEX `idx_fk_ShipVia` (`ShipVia` ASC) ,
  INDEX `idx_OrderDate` (`OrderDate` ASC) ,
  INDEX `idx_ShippedDate` (`ShippedDate` ASC) ,
  INDEX `idx_ShipPostalCode` (`ShipPostalCode` ASC) ,
  CONSTRAINT `fk_orders_customer`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `northwind`.`Customers` (`CustomerID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_employees`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `northwind`.`Employees` (`EmployeeID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_shippers`
    FOREIGN KEY (`ShipVia`)
    REFERENCES `northwind`.`Shippers` (`ShipperID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `northwind`.`Suppliers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `northwind`.`Suppliers` ;

CREATE TABLE IF NOT EXISTS `northwind`.`Suppliers` (
  `SupplierID` INT(11) NOT NULL,
  `CompanyName` VARCHAR(40) NOT NULL,
  `ContactName` VARCHAR(30) NULL DEFAULT NULL,
  `ContactTitle` VARCHAR(30) NULL DEFAULT NULL,
  `Address` VARCHAR(60) NULL DEFAULT NULL,
  `City` VARCHAR(15) NULL DEFAULT NULL,
  `Region` VARCHAR(15) NULL DEFAULT NULL,
  `PostalCode` VARCHAR(10) NULL DEFAULT NULL,
  `Country` VARCHAR(15) NULL DEFAULT NULL,
  `Phone` VARCHAR(24) NULL DEFAULT NULL,
  `Fax` VARCHAR(24) NULL DEFAULT NULL,
  `HomePage` MEDIUMTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`SupplierID`),
  INDEX `idx_CompanyName` (`CompanyName` ASC) ,
  INDEX `idx_PostalCode` (`PostalCode` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `northwind`.`Products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `northwind`.`Products` ;

CREATE TABLE IF NOT EXISTS `northwind`.`Products` (
  `ProductID` INT(11) NOT NULL,
  `ProductName` VARCHAR(100) NOT NULL,
  `SupplierID` INT(11) NULL DEFAULT NULL,
  `CategoryID` INT(11) NULL DEFAULT NULL,
  `QuantityPerUnit` VARCHAR(100) NULL DEFAULT NULL,
  `UnitPrice` DECIMAL(10,4) NULL DEFAULT '0.0000',
  `UnitsInStock` SMALLINT(2) NULL DEFAULT '0',
  `UnitsOnOrder` SMALLINT(2) NULL DEFAULT '0',
  `ReorderLevel` SMALLINT(2) NULL DEFAULT '0',
  `Discontinued` TINYINT(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ProductID`),
  INDEX `idx_fk_CategoryID` (`CategoryID` ASC) ,
  INDEX `idx_fk_SupplierID` (`SupplierID` ASC) ,
  INDEX `idx_ProductName` (`ProductName` ASC) ,
  CONSTRAINT `fk_products_categories`
    FOREIGN KEY (`CategoryID`)
    REFERENCES `northwind`.`Categories` (`CategoryID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products_suppliers`
    FOREIGN KEY (`SupplierID`)
    REFERENCES `northwind`.`Suppliers` (`SupplierID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `northwind`.`Order_Details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `northwind`.`Order_Details` ;

CREATE TABLE IF NOT EXISTS `northwind`.`Order_Details` (
  `OrderID` INT(11) NOT NULL,
  `ProductID` INT(11) NOT NULL,
  `UnitPrice` DECIMAL(10,4) NOT NULL DEFAULT '0.0000',
  `Quantity` SMALLINT(2) NOT NULL DEFAULT '1',
  `Discount` DOUBLE(8,0) NOT NULL DEFAULT '0',
  INDEX `fk_idx_OrderID` (`OrderID` ASC) ,
  INDEX `fk_order_details_products_idx` (`ProductID` ASC) ,
  CONSTRAINT `fk_order_details_orders`
    FOREIGN KEY (`OrderID`)
    REFERENCES `northwind`.`Orders` (`OrderID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_details_products`
    FOREIGN KEY (`ProductID`)
    REFERENCES `northwind`.`Products` (`ProductID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

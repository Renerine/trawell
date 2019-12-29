-- MySQL Script generated by MySQL Workbench
-- Tue Dec 17 11:02:58 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema trawell
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `trawell` ;

-- -----------------------------------------------------
-- Schema trawell
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `trawell` DEFAULT CHARACTER SET utf8 ;
USE `trawell` ;

-- -----------------------------------------------------
-- Table `trawell`.`Ad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`Ad` ;

CREATE TABLE IF NOT EXISTS `trawell`.`Ad` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idOwner` INT NOT NULL,
  `AdPaymentMethod` VARCHAR(60) NOT NULL,
  `AdCost` INT NOT NULL,
  `AdStartingDate` DATETIME NOT NULL,
  `AdDueDate` DATETIME NOT NULL,
  `idPhoto` VARCHAR(268) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idAd_UNIQUE` (`id` ASC),
  INDEX `idUser_idx` (`idOwner` ASC),
    FOREIGN KEY (`idOwner`)
    REFERENCES `trawell`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `trawell`.`BanData`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`ban_data` ;

CREATE TABLE IF NOT EXISTS `trawell`.`ban_data` (
  `id` INT NOT NULL UNIQUE AUTO_INCREMENT,
  `id_admin` INT NOT NULL,
  `id_user` INT NOT NULL,
  `ban_until` DATETIME NOT NULL,
  `motivation` VARCHAR(450) NOT NULL,
    PRIMARY KEY (`id`),
   
    FOREIGN KEY (`id_user`)
    REFERENCES `trawell`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`id_admin`)
    REFERENCES `trawell`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`CarSharing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`CarSharing` ;

CREATE TABLE IF NOT EXISTS `trawell`.`CarSharing` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `departureDate` DATETIME NOT NULL,
  `CarSharingDestination` VARCHAR(500) NOT NULL,
  `CarSharingDeparture` VARCHAR(45) NOT NULL,
  `CarSharingArrival` VARCHAR(45) NOT NULL,
  `CarSharingSpot` INT NOT NULL,
  `idOwner` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idCarSharing_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`CarSpot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`CarSpot` ;

CREATE TABLE IF NOT EXISTS `trawell`.`CarSpot` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idCarSharing` INT NOT NULL,
  `idUser` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idSpot_UNIQUE` (`id` ASC),
  INDEX `idUser_idx` (`idUser` ASC),
  INDEX `idCarSharing_idx` (`idCarSharing` ASC),
 
    FOREIGN KEY (`idUser`)
    REFERENCES `trawell`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
 
    FOREIGN KEY (`idCarSharing`)
    REFERENCES `trawell`.`CarSharing` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`Chat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`Chat` ;

CREATE TABLE IF NOT EXISTS `trawell`.`Chat` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idSender` INT NOT NULL,
  `idReciver` INT NOT NULL,
  UNIQUE INDEX `idChat_UNIQUE` (`id` ASC),
  PRIMARY KEY (`id`),
  INDEX `idSender_idx` (`idSender` ASC),
  INDEX `idReciver_idx` (`idReciver` ASC),
 
    FOREIGN KEY (`id`)
    REFERENCES `trawell`.`Message` (`idChat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
 
    FOREIGN KEY (`idSender`)
    REFERENCES `trawell`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  
    FOREIGN KEY (`idReciver`)
    REFERENCES `trawell`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`Complaint`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`Complaint` ;

CREATE TABLE IF NOT EXISTS `trawell`.`Complaint` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idUser` INT NOT NULL,
  `ComplaintDescription` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `email_idx` (`idUser` ASC),
  
    FOREIGN KEY (`idUser`)
    REFERENCES `trawell`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`Destination`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`Destination` ;

CREATE TABLE IF NOT EXISTS `trawell`.`Destination` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idItinerary` INT NOT NULL,
  `EventName` VARCHAR(50) NOT NULL,
  `DestinationDescription` VARCHAR(450) NULL,
  `DestinationDate` DATETIME NOT NULL,
  `DestinationHour` TIME NOT NULL,
  `isVisited` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idDestination_UNIQUE` (`id` ASC),
  INDEX `idItinerary_idx` (`idItinerary` ASC),
 
    FOREIGN KEY (`idItinerary`)
    REFERENCES `trawell`.`Itinerary` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`Document`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`Document` ;

CREATE TABLE IF NOT EXISTS `trawell`.`Document` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idWallet` INT NOT NULL,
  `DocumentName` VARCHAR(50) NOT NULL,
  `DocumentPath` VARCHAR(268) NOT NULL,
  `DocumentDueDate` DATETIME NULL,
  `DocumentNote` VARCHAR(500) NULL,
  `DocumentIsPrivate` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idDocument_UNIQUE` (`id` ASC),
  INDEX `idWallet_idx` (`idWallet` ASC),
 
    FOREIGN KEY (`idWallet`)
    REFERENCES `trawell`.`Wallet` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`Group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`Group` ;

CREATE TABLE IF NOT EXISTS `trawell`.`Group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `GroupName` VARCHAR(50) NOT NULL,
  `GroupDescription` VARCHAR(500) NULL,
  `idItinerary` INT NOT NULL,
  `idWallet` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idGroup_UNIQUE` (`id` ASC),
  INDEX `fk_Group_Itinerary1_idx` (`idItinerary` ASC),
  UNIQUE INDEX `idItinerary_UNIQUE` (`idItinerary` ASC),
  INDEX `fk_Group_Wallet1_idx` (`idWallet` ASC),
  UNIQUE INDEX `idWallet_UNIQUE` (`idWallet` ASC),
 
    FOREIGN KEY (`idItinerary`)
    REFERENCES `trawell`.`Itinerary` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  
    FOREIGN KEY (`idWallet`)
    REFERENCES `trawell`.`Wallet` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`GroupMember`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`GroupMember` ;

CREATE TABLE IF NOT EXISTS `trawell`.`GroupMember` (
  `idUser` INT NOT NULL,
  `idGroup` INT NOT NULL,
  `isOwner` TINYINT NOT NULL DEFAULT 0,
  INDEX `idGroup_idx` (`idGroup` ASC),
  INDEX `idUser_idx` (`idUser` ASC),
  
    FOREIGN KEY (`idGroup`)
    REFERENCES `trawell`.`Group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  
    FOREIGN KEY (`idUser`)
    REFERENCES `trawell`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`Itinerary`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`Itinerary` ;

CREATE TABLE IF NOT EXISTS `trawell`.`Itinerary` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idOwner` INT NOT NULL,
  `idGroup` INT NULL,
  `ItineraryName` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idItinerary_UNIQUE` (`id` ASC),
  UNIQUE INDEX `idOwner_UNIQUE` (`idOwner` ASC),
 
    FOREIGN KEY (`idOwner`)
    REFERENCES `trawell`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`Message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`Message` ;

CREATE TABLE IF NOT EXISTS `trawell`.`Message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Message` VARCHAR(450) NOT NULL,
  `idPhoto` INT NOT NULL,
  `idChat` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idMessage_UNIQUE` (`id` ASC),
  INDEX `fk_Message_Photo1_idx` (`idPhoto` ASC),
  UNIQUE INDEX `idChat_UNIQUE` (`idChat` ASC),
 
    FOREIGN KEY (`idPhoto`)
    REFERENCES `trawell`.`Photo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`Photo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`Photo` ;

CREATE TABLE IF NOT EXISTS `trawell`.`Photo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idOwner` INT NOT NULL,
  `PhotoName` VARCHAR(100) NOT NULL,
  `PhotoPath` VARCHAR(268) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idPhoto_UNIQUE` (`id` ASC),
  UNIQUE INDEX `PhotoPhat_UNIQUE` (`PhotoPath` ASC),
  INDEX `idOwner_idx` (`idOwner` ASC),
 
    FOREIGN KEY (`idOwner`)
    REFERENCES `trawell`.`Post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`Post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`post` ;

CREATE TABLE IF NOT EXISTS `trawell`.`post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_owner` INT NOT NULL,
  `id_group` INT NOT NULL,
  `id_photo` INT NULL,
  `post_description` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id`),
  
    FOREIGN KEY (`id_owner`)
    REFERENCES `trawell`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
 
    FOREIGN KEY (`id_group`)
    REFERENCES `trawell`.`group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`User`
-- -----------------------------------------------------
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail` varchar(254) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `birth` datetime NOT NULL,
  `banned` tinyint(4) NOT NULL DEFAULT '0',
  `bio` varchar(5000) DEFAULT NULL,
  `profile_photo` int(11) DEFAULT '0',
  `phone` varchar(20) DEFAULT NULL,
  `is_admin` tinyint(4) DEFAULT '0',
  `is_banned` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`,`mail`,`username`),
  UNIQUE KEY `idUser_UNIQUE` (`id`),
  UNIQUE KEY `mail_UNIQUE` (`mail`),
  UNIQUE KEY `userName_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO user VALUES (1,'umbertorussomando@gmail.com','admin','09F43236BB5E2B75230E705C39EDBB71','Umberto','Russomando','1997-11-09 00:00:00',0,NULL,0,'3347877736',1,0);
-- -----------------------------------------------------
-- Table `trawell`.`AgencyData`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`agency` ;

CREATE TABLE IF NOT EXISTS `trawell`.`agency` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name_agency` VARCHAR(100) default null,
  `url` VARCHAR(2083) default null,
  `vat` VARCHAR(20) default null,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id`)
    REFERENCES `trawell`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `trawell`.`Wallet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`Wallet` ;

CREATE TABLE IF NOT EXISTS `trawell`.`Wallet` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idOwner` INT NOT NULL,
  `idGroup` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idWallet_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
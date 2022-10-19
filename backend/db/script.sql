-- MySQL Script generated by MySQL Workbench
-- dilluns, 2 de maig de 2022, 08:54:04
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering
SET
  @OLD_UNIQUE_CHECKS = @ @UNIQUE_CHECKS,
  UNIQUE_CHECKS = 0;
SET
  @OLD_FOREIGN_KEY_CHECKS = @ @FOREIGN_KEY_CHECKS,
  FOREIGN_KEY_CHECKS = 0;
SET
  @OLD_SQL_MODE = @ @SQL_MODE,
  SQL_MODE = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- -----------------------------------------------------
  -- Schema it_academy
  -- -----------------------------------------------------
  CREATE SCHEMA IF NOT EXISTS `it_academy` DEFAULT CHARACTER SET utf8;
USE `it_academy`;
-- -----------------------------------------------------
  -- Table `it_academy`.`user_role`
  -- -----------------------------------------------------
  CREATE TABLE IF NOT EXISTS `it_academy`.`user_role` (
    `id` INT NOT NULL,
    `name` VARCHAR(45) NULL DEFAULT NULL,
    `admin` TINYINT NULL DEFAULT '0',
    `manager` TINYINT NULL DEFAULT '0',
    `registered` TINYINT NULL DEFAULT '0',
    PRIMARY KEY (`id`)
  ) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
  -- Table `it_academy`.`user_status`
  -- -----------------------------------------------------
  CREATE TABLE IF NOT EXISTS `it_academy`.`user_status` (
    `id` INT NOT NULL,
    `name` VARCHAR(45) NOT NULL,
    `active` TINYINT NOT NULL DEFAULT '0',
    `pending` TINYINT NOT NULL DEFAULT '0',
    `suspended` TINYINT NOT NULL DEFAULT '0',
    `deleted` TINYINT NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`)
  ) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
  -- Table `it_academy`.`user`
  -- -----------------------------------------------------
  CREATE TABLE IF NOT EXISTS `it_academy`.`user` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NULL DEFAULT NULL,
    `lastnames` VARCHAR(45) NULL DEFAULT NULL,
    `email` VARCHAR(45) NULL DEFAULT NULL,
    `password` TEXT NULL DEFAULT NULL,
    `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `user_status_id` INT NOT NULL DEFAULT 2,
    `user_role_id` INT NOT NULL DEFAULT 3,
    PRIMARY KEY (`id`),
    INDEX `fk_user_user_status_idx` (`user_status_id` ASC) VISIBLE,
    INDEX `fk_user_user_role1_idx` (`user_role_id` ASC) VISIBLE,
    CONSTRAINT `fk_user_user_role1` FOREIGN KEY (`user_role_id`) REFERENCES `it_academy`.`user_role` (`id`),
    CONSTRAINT `fk_user_user_status` FOREIGN KEY (`user_status_id`) REFERENCES `it_academy`.`user_status` (`id`)
  ) ENGINE = InnoDB AUTO_INCREMENT = 21 DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
  -- Table `it_academy`.`access_log`
  -- -----------------------------------------------------
  CREATE TABLE IF NOT EXISTS `it_academy`.`access_log` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `login` DATETIME NULL DEFAULT NULL,
    `logout` DATETIME NULL DEFAULT NULL,
    `user_id` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_access_log_user1_idx` (`user_id` ASC) VISIBLE,
    CONSTRAINT `fk_access_log_user1` FOREIGN KEY (`user_id`) REFERENCES `it_academy`.`user` (`id`)
  ) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
  -- Table `it_academy`.`recover_password`
  -- -----------------------------------------------------
  CREATE TABLE IF NOT EXISTS `it_academy`.`recover_password` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hash` TEXT NOT NULL,
    `expire_time` TIMESTAMP NOT NULL,
    `user_id` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_recover_password_user1_idx` (`user_id` ASC) VISIBLE,
    CONSTRAINT `fk_recover_password_user1` FOREIGN KEY (`user_id`) REFERENCES `it_academy`.`user` (`id`)
  ) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
  -- Table `it_academy`.`media`
  -- -----------------------------------------------------
  CREATE TABLE IF NOT EXISTS `it_academy`.`media` (
    `id` INT NULL AUTO_INCREMENT,
    `path` TEXT NULL,
    `mime_type` VARCHAR(45) NULL,
    `file_size` VARCHAR(45) NULL,
    `user_id` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_media_user1_idx` (`user_id` ASC) VISIBLE,
    CONSTRAINT `fk_media_user1` FOREIGN KEY (`user_id`) REFERENCES `it_academy`.`user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
  ) ENGINE = InnoDB;
-- -----------------------------------------------------
  -- Table `it_academy`.`media_type`
  -- -----------------------------------------------------
  CREATE TABLE IF NOT EXISTS `it_academy`.`media_type` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `thumbnail` TINYINT NOT NULL DEFAULT 0,
    `medium` TINYINT NOT NULL DEFAULT 0,
    `large` TINYINT NOT NULL DEFAULT 0,
    `original` TINYINT NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`)
  ) ENGINE = InnoDB;
-- -----------------------------------------------------
  -- Table `it_academy`.`media_meta`
  -- -----------------------------------------------------
  CREATE TABLE IF NOT EXISTS `it_academy`.`media_meta` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `path` TEXT NULL,
    `mime_type` VARCHAR(45) NULL,
    `file_size` VARCHAR(45) NULL,
    `media_id` INT NOT NULL,
    `media_type_id` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_media_meta_media1_idx` (`media_id` ASC) VISIBLE,
    INDEX `fk_media_meta_media_type1_idx` (`media_type_id` ASC) VISIBLE,
    CONSTRAINT `fk_media_meta_media1` FOREIGN KEY (`media_id`) REFERENCES `it_academy`.`media` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_media_meta_media_type1` FOREIGN KEY (`media_type_id`) REFERENCES `it_academy`.`media_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
  ) ENGINE = InnoDB;
-- -----------------------------------------------------
  -- Table `it_academy`.`conversation`
  -- -----------------------------------------------------
  CREATE TABLE IF NOT EXISTS `it_academy`.`conversation` (
    `id` INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`id`)
  ) ENGINE = InnoDB;
-- -----------------------------------------------------
  -- Table `it_academy`.`message`
  -- -----------------------------------------------------
  CREATE TABLE IF NOT EXISTS `it_academy`.`message` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `sender_id` INT NOT NULL,
    `conversation_id` INT NOT NULL,
    `text` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_message_1_idx` (`sender_id` ASC) VISIBLE,
    INDEX `fk_message_2_idx` (`conversation_id` ASC) VISIBLE,
    CONSTRAINT `fk_message_1` FOREIGN KEY (`sender_id`) REFERENCES `it_academy`.`user` (`user_status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_message_2` FOREIGN KEY (`conversation_id`) REFERENCES `it_academy`.`conversation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
  ) ENGINE = InnoDB;
-- -----------------------------------------------------
  -- Table `it_academy`.`user_conversation`
  -- -----------------------------------------------------
  CREATE TABLE IF NOT EXISTS `it_academy`.`user_conversation` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `conversation_id` INT NOT NULL,
    `user_id` INT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_user_conversation_1_idx` (`conversation_id` ASC) VISIBLE,
    INDEX `fk_user_conversation_2_idx` (`user_id` ASC) VISIBLE,
    CONSTRAINT `fk_user_conversation_1` FOREIGN KEY (`conversation_id`) REFERENCES `it_academy`.`conversation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_user_conversation_2` FOREIGN KEY (`user_id`) REFERENCES `it_academy`.`user` (`user_status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
  ) ENGINE = InnoDB;
SET
  SQL_MODE = @OLD_SQL_MODE;
SET
  FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET
  UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
CREATE SCHEMA `departments` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE `departments`.`departments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `departments`.`departments`
  ADD UNIQUE INDEX `name_UNIQUE` (`name` ASC);

CREATE TABLE `departments`.`employees` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `birthday` DATE NOT NULL,
  `phone` VARCHAR(17) NULL,
  `email` VARCHAR(64) NULL,
  `id_department` INT NOT NULL,
  PRIMARY KEY (`id`, `firstName`),
  INDEX `id_departments_idx` (`id_department` ASC),
  CONSTRAINT `id_departments`
    FOREIGN KEY (`id_department`)
    REFERENCES `departments`.`departments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `departments`.`employees`
  CHANGE COLUMN `phone` `phone` VARCHAR(17) NOT NULL,
  CHANGE COLUMN `email` `email` VARCHAR(64) NOT NULL,
  ADD UNIQUE INDEX `email_UNIQUE` (`email` ASC);

INSERT INTO `departments`.`departments` (`name`) VALUES ('Java team');
INSERT INTO `departments`.`departments` (`name`) VALUES ('dotNet team');
INSERT INTO `departments`.`departments` (`name`) VALUES ('HR');
INSERT INTO `departments`.`departments` (`name`) VALUES ('accounting');
INSERT INTO `departments`.`departments` (`name`) VALUES ('QA');

INSERT INTO `departments`.employees (firstName, `lastName`, `birthday`, `phone`, `email`, id_department) VALUES ('Ivan', 'Ivanov', '1991.12.12', '+38050-12-34-567', 'ivanov@gmail.com', '1');
INSERT INTO `departments`.employees (firstName, `lastName`, `birthday`, `phone`, `email`, id_department) VALUES ('Petr', 'Petrov', '1988.01.11', '+38099-11-22-333', 'petrov@gmail.com', '3');
INSERT INTO `departments`.employees (firstName, `lastName`, `birthday`, `phone`, `email`, id_department) VALUES ('Sidor', 'Sidorov', '1990.10.30', '+38067-99-88-777', 'sidorov@gmail.com', '2');

CREATE
  ALGORITHM = UNDEFINED
  DEFINER = `root`@`localhost`
  SQL SECURITY DEFINER
VIEW `departments`.`alldepartments` AS
  SELECT
    `departments`.`departments`.`id` AS `id`,
    `departments`.`departments`.`name` AS `name`
  FROM
    `departments`.`departments`;


CREATE
  ALGORITHM = UNDEFINED
  DEFINER = `root`@`localhost`
  SQL SECURITY DEFINER
VIEW `departments`.`allemployees` AS
  SELECT
    `departments`.`employees`.`id` AS `id`,
    `departments`.`employees`.`firstName` AS `firstName`,
    `departments`.`employees`.`lastName` AS `lastName`,
    `departments`.`employees`.`birthday` AS `birthday`,
    `departments`.`employees`.`phone` AS `phone`,
    `departments`.`employees`.`email` AS `email`,
    `departments`.`departments`.`name` AS `name`
  FROM
    (`departments`.`employees`
      LEFT JOIN `departments`.`departments` ON ((`departments`.`employees`.`id_department` = `departments`.`departments`.`id`)))

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Cul_dAmpolla
-- -----------------------------------------------------
-- Una òptica, anomenada “Cul dAmpolla”, vol informatitzar la gestió dels clients i vendes d'ulleres.
-- En primer lloc l'òptica vol saber quin és el proveïdor de cadascuna de les ulleres.
-- 
-- En concret vol saber de cada proveïdor el nom, l'adreça (carrer, número, pis, porta, ciutat, codi postal i país), telèfon, fax, NIF. 
-- 
-- La política de compres de l'òptica es basa en que les ulleres d'una marca es compraran a un únic proveïdor (així en podrà treure més bons preus), però poden comprar ulleres de diverses marques a un proveïdor. De les ulleres vol saber, la marca, la graduació de cadascun dels vidres, el tipus de muntura (flotant, pasta o metàl•lica), el color de la muntura, el color de cada vidre i el preu.
-- 
-- Dels clients vol emmagatzemar el nom, l'adreça postal, el telèfon, el correu electrònic i la data de registre. També ens demanen, quan arriba un client nou, d'emmagatzemar el client que li ha recomanat l'establiment (sempre i quan algú li hagi recomanat).
-- 
-- El nostre sistema haurà d’indicar qui ha sigut l’empleat que ha venut cada ullera.
-- 
-- 
-- Un cop creada la base de dades, omplirem les taules amb dades de prova per tal de verificar que les relacions són correctes.
-- 

-- -----------------------------------------------------
-- Schema Cul_dAmpolla
--
-- Una òptica, anomenada “Cul dAmpolla”, vol informatitzar la gestió dels clients i vendes d'ulleres.
-- En primer lloc l'òptica vol saber quin és el proveïdor de cadascuna de les ulleres.
-- 
-- En concret vol saber de cada proveïdor el nom, l'adreça (carrer, número, pis, porta, ciutat, codi postal i país), telèfon, fax, NIF. 
-- 
-- La política de compres de l'òptica es basa en que les ulleres d'una marca es compraran a un únic proveïdor (així en podrà treure més bons preus), però poden comprar ulleres de diverses marques a un proveïdor. De les ulleres vol saber, la marca, la graduació de cadascun dels vidres, el tipus de muntura (flotant, pasta o metàl•lica), el color de la muntura, el color de cada vidre i el preu.
-- 
-- Dels clients vol emmagatzemar el nom, l'adreça postal, el telèfon, el correu electrònic i la data de registre. També ens demanen, quan arriba un client nou, d'emmagatzemar el client que li ha recomanat l'establiment (sempre i quan algú li hagi recomanat).
-- 
-- El nostre sistema haurà d’indicar qui ha sigut l’empleat que ha venut cada ullera.
-- 
-- 
-- Un cop creada la base de dades, omplirem les taules amb dades de prova per tal de verificar que les relacions són correctes.
-- 
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Cul_dAmpolla` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `Cul_dAmpolla` ;

-- -----------------------------------------------------
-- Table `Cul_dAmpolla`.`vendors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_dAmpolla`.`vendors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `str_number` VARCHAR(45) NOT NULL,
  `address_addition` VARCHAR(10) NULL DEFAULT NULL,
  `city` VARCHAR(45) NOT NULL,
  `zip` CHAR(5) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(15) NULL DEFAULT NULL,
  `fax` VARCHAR(15) NULL DEFAULT NULL,
  `id_card` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_dAmpolla`.`lenses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_dAmpolla`.`lenses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `prescription_R` DECIMAL NOT NULL,
  `prescription_L` DECIMAL NOT NULL,
  `price_R` DECIMAL NOT NULL,
  `price_L` DECIMAL NOT NULL,
  `colour_R` VARCHAR(45) NOT NULL,
  `colour_L` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_dAmpolla`.`frame_colour`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_dAmpolla`.`frame_colour` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_dAmpolla`.`frame_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_dAmpolla`.`frame_types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_dAmpolla`.`frame_brands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_dAmpolla`.`frame_brands` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `vendors_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_vendors1_idx` (`vendors_id` ASC) VISIBLE,
  CONSTRAINT `fk_vendors1`
    FOREIGN KEY (`vendors_id`)
    REFERENCES `Cul_dAmpolla`.`vendors` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_dAmpolla`.`frames`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_dAmpolla`.`frames` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `price` DECIMAL NOT NULL,
  `frame_colour_id` INT NOT NULL,
  `frame_types_id` INT NOT NULL,
  `frame_brands_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_frame_colour1_idx` (`frame_colour_id` ASC) VISIBLE,
  INDEX `fk_frame_types1_idx` (`frame_types_id` ASC) VISIBLE,
  INDEX `fk_frame_brands1_idx` (`frame_brands_id` ASC) VISIBLE,
  CONSTRAINT `fk_frame_colour1`
    FOREIGN KEY (`frame_colour_id`)
    REFERENCES `Cul_dAmpolla`.`frame_colour` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_frame_types1`
    FOREIGN KEY (`frame_types_id`)
    REFERENCES `Cul_dAmpolla`.`frame_types` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_frame_brands1`
    FOREIGN KEY (`frame_brands_id`)
    REFERENCES `Cul_dAmpolla`.`frame_brands` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_dAmpolla`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_dAmpolla`.`employees` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_dAmpolla`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_dAmpolla`.`clients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `str_number` VARCHAR(10) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `zip` CHAR(5) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `recommended_by` INT NULL DEFAULT NULL COMMENT 'Enter the id of the client who recommended our optic if exists\n',
  `employees_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_employees1_idx` (`employees_id` ASC) VISIBLE,
  CONSTRAINT `fk_employees1`
    FOREIGN KEY (`employees_id`)
    REFERENCES `Cul_dAmpolla`.`employees` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_dAmpolla`.`eyeglasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_dAmpolla`.`eyeglasses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `lenses_id` INT NOT NULL,
  `frames_id` INT NOT NULL,
  `total_price` DECIMAL NULL,
  `clients_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_lenses1_idx` (`lenses_id` ASC) VISIBLE,
  INDEX `fk_frames1_idx` (`frames_id` ASC) VISIBLE,
  INDEX `fk_clients1_idx` (`clients_id` ASC) VISIBLE,
  CONSTRAINT `fk_lenses1`
    FOREIGN KEY (`lenses_id`)
    REFERENCES `Cul_dAmpolla`.`lenses` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_frames1`
    FOREIGN KEY (`frames_id`)
    REFERENCES `Cul_dAmpolla`.`frames` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_clients1`
    FOREIGN KEY (`clients_id`)
    REFERENCES `Cul_dAmpolla`.`clients` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
USE cul_dampolla;

INSERT INTO frame_colour
VALUES 
(1,'Amaranth');

INSERT INTO frame_colour
VALUES 
(2,'Amber'),
(3,'Amethyst'),
(4,'Apricot'),
(5,'Aquamarine'),
(6,'Azure'),
(7,'Baby blue'),
(8,'Beige'),
(9,'Black'),
(10,'Blue'),
(11,'Blue-green'),
(12,'Blue-violet'),
(13,'Blush'),
(14,'Bronze'),
(15,'Brown'),
(16,'Burgundy'),
(17,'Byzantium'),
(18,'Carmine'),
(19,'Cerise'),
(20,'Cerulean'),
(21,'Champagne'),
(22,'Chartreuse green'),
(23,'Chocolate'),
(24,'Cobalt blue'),
(25,'Coffee'),
(26,'Copper'),
(27,'Coral'),
(28,'Crimson'),
(29,'Cyan'),
(30,'Desert sand'),
(31,'Electric blue'),
(32,'Emerald'),
(33,'Erin'),
(34,'Gold'),
(35,'Gray'),
(36,'Green'),
(37,'Harlequin'),
(38,'Indigo'),
(39,'Ivory'),
(40,'Jade'),
(41,'Jungle green'),
(42,'Lavender'),
(43,'Lemon'),
(44,'Lilac'),
(45,'Lime'),
(46,'Magenta'),
(47,'Magenta rose'),
(48,'Maroon'),
(49,'Mauve'),
(50,'Navy blue'),
(51,'Ochre'),
(52,'Olive'),
(53,'Orange'),
(54,'Orange-red'),
(55,'Orchid'),
(56,'Peach'),
(57,'Pear'),
(58,'Periwinkle'),
(59,'Persian blue'),
(60,'Pink'),
(61,'Plum'),
(62,'Prussian blue'),
(63,'Puce'),
(64,'Purple'),
(65,'Raspberry'),
(66,'Red'),
(67,'Red-violet'),
(68,'Rose'),
(69,'Ruby'),
(70,'Salmon'),
(71,'Sangria'),
(72,'Sapphire'),
(73,'Scarlet'),
(74,'Silver'),
(75,'Slate gray'),
(76,'Spring bud'),
(77,'Spring green'),
(78,'Tan'),
(79,'Taupe'),
(80,'Teal'),
(81,'Turquoise'),
(82,'Ultramarine'),
(83,'Violet'),
(84,'Viridian'),
(85,'White'),
(86,'Yellow'),
(87,'Transparent');

INSERT INTO `cul_dampolla`.`frame_types` (`name`) 
VALUES 
('rimless'),
('acetate'),
('metallic');

INSERT INTO `cul_dampolla`.`employees` (`name`)
VALUES
('Michele Quinn'),
('Mona Burns'),
('Megan Maldonado'),
('Alma Young'),
('Angel Porter'),
('Geneva Drake'),
('Laura Beck'),
('Julian Allen'),
('Dianna Mcdaniel'),
('Peter Paul');

INSERT INTO cul_dampolla.clients (`id`,`name`,`address`,`str_number`,`city`,`zip`,`country`,`recommended_by`,`employees_id`)
VALUES 
(1,'Elda Arevalo Tejada','C/ Domingo Beltran',12,'Bienservida','02360','Spain',null,2),
(2,'Quinto Amador Caraballo','C/ Outid de Arriba',72,'Horta de Sant Joan','43596','Spain',null,1),
(3,'Janoc Bravo Romero','C/ Inglaterra',24,'Deifontes','18570','Spain',null,2),
(4,'Kenji Maldonado Figueroa','C/ Jose Matia',78,'Pernas de San Pedro','02120','Spain',null,2),
(5,'Fantino Negron Nunyez','Avda. Los llanos',5,'San Torcuato','26291','Spain',2,3),
(6,'Felix Calderon Bustamante','Pl. Virgen Blanca',23,'Gironella','08680','Spain',null,5),
(7,'Gerald Cintron Aranda','Avda. Los llanos',50,'Zorraquin','26288','Spain',null,3),
(8,'Celio Colunga Angulo','C/ Enxertos',74,'La Atalaya','37591','Spain',4,4),
(9,'Minotauro Monroy Chavarria','Rua Olmos',78,'Babilafuente','37330','Spain',null,5),
(10,'Yael Elizondo Montalvo','Calle Proc. San Sebastian',37,'Cervera del Maestre','12578','Spain',4,6),
(11,'Rosina Arteaga Gonzales','C/ Rey',68,'Alboraya','46120','Spain',null,6),
(12,'Balbo Carbajal Chavez','C/ Cadiz',23,'Fonelas','18515','Spain',null,1),
(13,'Miqueo Caldera Vega','Ctra. de la Puerta',62,'Baleira','27130','Spain',6,4),
(14,'Zite Delgado Vasquez','C/ Atamaria',61,'Mies','36637','Spain',null,5),
(15,'Meliton Urrutia Montenegro','C/ Valadour',63,'Zeanuri','48144','Spain',null,1),
(16,'Cochi Herrera Ocasio','C/ Rosa de los Vientos',46,'Canyada de Calatrava','13430','Spain',null,3);

INSERT INTO cul_dampolla.vendors (`name`,`street`,`str_number`,`address_addition`,`city`,`zip`,`country`,`phone`,`fax`,`id_card`)
VALUES
('Glassium SA','C/ Fernández de Leceta',98,null,'Benidorm','3500','Spain','756 819 546',null,'A38702395'),
('Glassvio SL','Ctra. Beas-Cortijos Nuevos',84,1,'Ausejo',26513,'Spain','692 697 644','956 819 545','B43053818'),
('Ugly Glasses  SL','C/ Benito Guinea',55,null,'Arenys de Munt',8358,'Spain','935 285 600','935 285 601','B64168800'),
('Monturasbes SL','C/ Cañadilla',48,null,'La Sotonera',22160,'Spain','603 964 863',null,'B60952868'),
('Sara Matos Pensón','C/ Pascual Yunquera',18,null,'Freila',18812,'Spain','738 012 486',null,'83808196Z'),
('Estela Agade Quezada','C/ Camino Ancho',5,'ESC A 1°','Salamanca',37070,'Spain','602 389 870',null,'54858929L'),
('Alcance Visión SA','Ronda de San Andrés',33,null,'Ahigal de los Aceiteros',37248,'Spain','621 287 721',null,'A3878270');

INSERT INTO cul_dampolla.frame_brands (`name`,`vendors_id`)
VALUES
('Hawkers',2),
('Mr Boho',3),
('Northweek',5),
('Meller',2),
('TU IT',7),
('Etnia',7),
('Kambio Eyewear',1),
('Lana Eyewear',4),
('mó Eyewear',4),
('Charmossas',6),
('Favaritx',3),
('Amichi',3),
('Vito and Willy',1),
('Hudson Glasses',2);

ALTER TABLE `cul_dampolla`.`frames` 
CHANGE COLUMN price price FLOAT NOT NULL ;

INSERT INTO cul_dampolla.frames (`id`,`price`,`frame_colour_id`,`frame_types_id`,`frame_brands_id`)
VALUES
(1,34.78,45,3,14),
(2,45.89,78,2,5),
(3,38.02,23,1,3),
(4,23.89,43,3,3),
(5,32.67,76,2,2),
(6,72.90,4,2,5),
(7,18.65,16,1,7),
(8,29.67,67,3,9),
(9,78.93,34,2,6),
(10,45.62,2,3,12),
(11,28.38,34,3,9),
(12,39.90,86,1,4),
(13,29.99,87,2,14),
(14,36.09,6,3,3),
(15,23.70,17,2,5),
(16,31.90,23,1,12),
(17,53.69,71,1,4),
(18,43.73,63,3,2),
(19,23.65,29,2,13),
(20,14.75,36,3,7),
(21,31.76,36,1,9),
(22,43.44,28,2,10),
(23,32.99,15,3,11),
(24,28.65,32,1,6),
(25,34.99,72,1,5),
(26,34.89,39,3,2);

ALTER TABLE `cul_dampolla`.`lenses` 
CHANGE COLUMN `prescription_R` `prescription_R` FLOAT,
CHANGE COLUMN `prescription_L` `prescription_L` FLOAT,
CHANGE COLUMN `price_R` `price_R` FLOAT,
CHANGE COLUMN `price_L` `price_L` FLOAT;

INSERT INTO cul_dampolla.lenses (`prescription_R`,`prescription_L`,`price_R`,`price_L`,`colour_R`,`colour_L`)
VALUES
(0.25,0.50,50.50,51.50,'green','green'),
(2.25,1.75,53.00,51.00,'white','white'),
(1.75,1.50,45.00,44.00,'blue','blue'),
(0.75,1.50,40.00,41.00,'white','white'),
(3.50,2.75,45.00,40.00,'blue','blue'),
(7.00,1.50,75.00,45.00,'white','white'),
(0.75,1.25,50.00,50.00,'blue','blue'),
(1.25,1.75,50.00,55.00,'green','green'),
(2.25,2.50,53.00,54.00,'white','white'),
(1.25,2.75,48.00,52.50,'blue','blue'),
(0.75,0.25,42.00,40.00,'blue','blue'),
(0.50,1.00,45.00,47.00,'white','white'),
(1.50,1.75,40.00,43.00,'green','green'),
(3.50,1.50,50.00,45.00,'white','white'),
(1.75,1.50,45.00,40.00,'blue','blue'),
(0.75,1.25,50.00,55.00,'white','white'),
(1.75,2.25,45.00,48.00,'white','white'),
(0.75,0.50,40.00,45.00,'blue','blue'),
(1.25,1.00,45.00,49.00,'white','white'),
(2.00,2.25,48.00,50.00,'green','green'),
(0.25,0.75,50.00,52.00,'blue','blue'),
(0.75,0.50,45.00,43.00,'white','white'),
(2.75,3.50,56.00,62.00,'blue','blue'),
(0.25,0.50,45.00,46.00,'white','white'),
(2.50,2.25,52.00,50.00,'green','green'),
(0.75,1.00,38.00,40.00,'white','white');

ALTER TABLE cul_dampolla.eyeglasses
DROP COLUMN total_price;

ALTER TABLE cul_dampolla.eyeglasses
ADD COLUMN total_price FLOAT ;

DROP TRIGGER eyeglasses_price_BI;

DROP PROCEDURE IF EXISTS pr_eyeglasses_price;

DELIMITER //
CREATE FUNCTION f_eyeglasses_price (frames_pr FLOAT, lenses_pr_R FLOAT,lenses_pr_L FLOAT, l_id INT,f_id INT, ey_l_id INT, ey_f_id INT)
RETURNS DECIMAL DETERMINISTIC
BEGIN
DECLARE final_pr DECIMAL;
IF (ey_l_id = l_id AND ey_f_id = f_id)
	THEN SET final_pr = frames_pr + lenses_pr_R + lenses_pr_L;
	ELSE SET final_pr = 0;
END IF;
RETURN final_pr;
END;
//
DELIMITER ;


DELIMITER $$
CREATE TRIGGER eyeglasses_price_BI BEFORE INSERT ON eyeglasses FOR EACH ROW
BEGIN
SET NEW.total_price = f_eyeglasses_price (price, price_R, price_L, 
		lenses.id, frames.id, eyeglasses.lenses_id, eyeglasses.frames_id);
END; 
$$
DELIMITER ;

INSERT INTO eyeglasses (`lenses_id`,`frames_id`,`clients_id`)
VALUES 
(1,1,1),
(2,2,2),
(3,3,3),
(4,4,4),
(5,5,5),
(6,6,6),
(7,7,7),
(8,8,8),
(9,9,9),
(10,10,1),
(11,11,10),
(12,12,11),
(13,13,3),
(14,14,12),
(15,15,5),
(16,16,1),
(17,17,4),
(18,18,13),
(19,19,9),
(20,20,14),
(21,21,15),
(22,22,16),
(23,23,8),
(24,24,3),
(25,25,2),
(26,26,6);

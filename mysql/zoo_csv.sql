CREATE DATABASE zoo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE zoo;

DROP TABLE IF EXISTS zoo;
DROP TABLE IF EXISTS especie;
DROP TABLE IF EXISTS animal;

CREATE TABLE zoo (
    id INT NOT NULL,
    nom VARCHAR(50) NOT NULL,
    ciutat VARCHAR(30) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    grandaria DECIMAL(6,2) NOT NULL,
    pressupost DECIMAL(12,2) NOT NULL
)ENGINE=CSV;

CREATE TABLE especie (
    id INT NOT NULL,
    nom_vulgar VARCHAR(20) NOT NULL,
    nom_cientific VARCHAR(50) NOT NULL,
    familia VARCHAR(20) NOT NULL,
    perill_extincio TINYINT NOT NULL
)ENGINE=CSV;

CREATE TABLE animal (
    id INT NOT NULL,
    nom VARCHAR(20) NOT NULL,
    sexe VARCHAR(1) NOT NULL,
    data_naixement DATETIME NOT NULL,
    pais VARCHAR(50) NOT NULL,
    continent VARCHAR(10) NOT NULL,
    especie_id INT NOT NULL,
    zoo_id INT NOT NULL
)ENGINE=CSV;

INSERT INTO zoo VALUES (1, 'Parc Zoològic de Barcelona', 'Barcelona', 'Espanya', 13, 9900000);
INSERT INTO zoo VALUES (2, 'Loro Parque', 'Puerto de la Cruz', 'Espanya', 13.5, 10000000);
INSERT INTO zoo VALUES (3, 'Zoo Aquarium de Madrid', 'Madrid', 'Espanya', 20, 15000000);

INSERT INTO especie VALUES (1, 'Mallerenga blava', 'Cyanistes caeruleus', 'Paridae', 0);
INSERT INTO especie VALUES (2, 'Orca', 'Orcinus orca', 'Delphinidae', 0);
INSERT INTO especie VALUES (3, 'Dofí mular', 'Tursiops truncatus', 'Delphinidae', 0);

INSERT INTO animal VALUES (1, 'Shira', 'F', STR_TO_DATE('02/07/2015', '%m/%d/%Y'), 'Espanya','Europa', 1, 1);
INSERT INTO animal VALUES (2, 'Nelly', 'M', STR_TO_DATE('02/27/2020', '%m/%d/%Y'), 'Espanya','Europa', 1, 1);
INSERT INTO animal VALUES (3, 'Lucky', 'F', STR_TO_DATE('04/25/2017', '%m/%d/%Y'), 'Espanya','Europa', 1, 1);
INSERT INTO animal VALUES (4, 'Splash', 'M', STR_TO_DATE('04/11/2017', '%m/%d/%Y'), 'Regne Unit','Europa', 2, 2);
INSERT INTO animal VALUES (5, 'Syrup', 'F', STR_TO_DATE('05/15/2014', '%m/%d/%Y'), 'Islàndia','Europa', 2, 2);
INSERT INTO animal VALUES (6, 'Loki', 'M', STR_TO_DATE('06/20/2014', '%m/%d/%Y'), 'Regne Unit','Europa', 2, 2);
INSERT INTO animal VALUES (7, 'Oreo', 'F', STR_TO_DATE('12/27/2015', '%m/%d/%Y'), 'Espanya','Europa', 3, 3);
INSERT INTO animal VALUES (8, 'Ace', 'M', STR_TO_DATE('11/10/2015', '%m/%d/%Y'), 'Espanya','Europa', 3, 3);

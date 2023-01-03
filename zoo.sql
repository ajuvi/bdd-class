DROP TABLE zoo CASCADE CONSTRAINTS;
DROP TABLE especie CASCADE CONSTRAINTS;
DROP TABLE animal CASCADE CONSTRAINTS;

CREATE TABLE zoo (
	id NUMBER(7) PRIMARY KEY,
	nom VARCHAR2(50),
	ciutat VARCHAR2(30),
	pais VARCHAR2(50),
	grandaria NUMBER(6,2),
	pressupost NUMBER(12,2)
);

CREATE TABLE especie (
	id NUMBER(7) PRIMARY KEY,
	nom_vulgar VARCHAR2(20),
	nom_cientific VARCHAR2(50),
	familia VARCHAR2(20),
	perill_extincio NUMBER(1)
);

CREATE TABLE animal (
	id NUMBER(7) PRIMARY KEY,
	nom VARCHAR2(20),
	sexe VARCHAR2(1),
	data_naixement DATE,
	pais VARCHAR2(50),
	continent VARCHAR2(10),
    especie_id NUMBER(7),
    ADD zoo_id NUMBER(7),

    ADD CONSTRAINT fk_especie_id
	    FOREIGN KEY (especie_id) REFERENCES especie(id),
    ADD CONSTRAINT fk_zoo_id
	    FOREIGN KEY (zoo_id) REFERENCES zoo(id)
);


INSERT INTO zoo VALUES (1, 'Parc Zoològic de Barcelona', 'Barcelona', 'Espanya', 13, 9900000);
INSERT INTO zoo VALUES (2, 'Loro Parque', 'Puerto de la Cruz', 'Espanya', 13.5, 10000000);
INSERT INTO zoo VALUES (3, 'Zoo Aquarium de Madrid', 'Madrid', 'Espanya', 20, 15000000);
INSERT INTO zoo VALUES (4, 'Zoo Girona', 'Girona', 'Espanya', 5, 550000);

INSERT INTO especie VALUES (1, 'Mallerenga blava', 'Cyanistes caeruleus', 'Paridae', 0);
INSERT INTO especie VALUES (2, 'Orca', 'Orcinus orca', 'Delphinidae', 1);
INSERT INTO especie VALUES (3, 'Dofí mular', 'Tursiops truncatus', 'Delphinidae', 0);
INSERT INTO especie VALUES (4, 'Tauró blanc', 'Carcharodon carcharias', 'Lamnidae', 1);

INSERT INTO animal VALUES (1, 'Shira', 'F', TO_DATE('02/07/2015', 'MM/DD/YYYY'), 'Espanya','Europa', 1, 1);
INSERT INTO animal VALUES (2, 'Nelly', 'M', TO_DATE('02/27/2020', 'MM/DD/YYYY'), 'Espanya','Europa', 1, 1);
INSERT INTO animal VALUES (3, 'Lucky', 'F', TO_DATE('04/25/2017', 'MM/DD/YYYY'), 'Espanya','Europa', 1, 1);
INSERT INTO animal VALUES (4, 'Splash', 'M', TO_DATE('04/11/2017', 'MM/DD/YYYY'), 'Regne Unit','Europa', 2, 2);
INSERT INTO animal VALUES (5, 'Syrup', 'F', TO_DATE('05/15/2014', 'MM/DD/YYYY'), 'Islàndia','Europa', 2, 2);
INSERT INTO animal VALUES (6, 'Loki', 'M', TO_DATE('06/20/2014', 'MM/DD/YYYY'), 'Regne Unit','Europa', 2, 2);
INSERT INTO animal VALUES (7, 'Oreo', 'F', TO_DATE('12/27/2015', 'MM/DD/YYYY'), 'Espanya','Europa', 3, 3);
INSERT INTO animal VALUES (8, 'Ace', 'M', TO_DATE('11/10/2015', 'MM/DD/YYYY'), 'Espanya','Europa', 3, 3);

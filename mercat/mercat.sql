-- ELIMINAR TAULES

DROP TABLE client CASCADE CONSTRAINTS;
DROP TABLE departament CASCADE CONSTRAINTS;
DROP TABLE empleat CASCADE CONSTRAINTS;
DROP TABLE comanda CASCADE CONSTRAINTS;
DROP TABLE producte CASCADE CONSTRAINTS;
DROP TABLE linia_comanda CASCADE CONSTRAINTS;

-- ELIMINAR SEQÜÈNCIES

DROP SEQUENCE seq_client;
DROP SEQUENCE seq_empleat;
DROP SEQUENCE seq_comanda;
DROP SEQUENCE seq_producte;

-- CREAR SEQÜÈNCIES

CREATE SEQUENCE seq_client
  START WITH 500
  INCREMENT BY 1;

CREATE SEQUENCE seq_empleat
  START WITH 500
  INCREMENT BY 1;
  
CREATE SEQUENCE seq_comanda
  START WITH 500
  INCREMENT BY 1;  

CREATE SEQUENCE seq_producte
  START WITH 500
  INCREMENT BY 1;  

-- CREAR TAULES

create table departament(
    id NUMBER(11),
    nom  VARCHAR2(14) NOT NULL,
    localitat  VARCHAR2(50),
    constraint pk_deptartament 
        primary key(id)
);

CREATE TABLE client(
	id NUMBER(11),
    dni VARCHAR2(10),
	nom VARCHAR2(100) NOT NULL,
	cognom1 VARCHAR2(100) NOT NULL ,
	cognom2 VARCHAR2(100),
	email VARCHAR2(150) NOT NULL,
    dataNaix DATE,
    telefon VARCHAR2(20),
    datalt   DATE DEFAULT SYSDATE,
    actiu NUMBER(1) DEFAULT 1,
    compte VARCHAR2(50),
    direccio VARCHAR(500),
    empresa VARCHAR2(200),
    CONSTRAINT pk_client 
        PRIMARY KEY(id), 
    CONSTRAINT ck_client_actiu 
        CHECK(actiu IN(0,1)) 
);

CREATE TABLE empleat(
    id 	NUMBER(11),
    dni VARCHAR2(10),    
    nom  	VARCHAR2(100) NOT NULL,
    cognom1 VARCHAR2(100) NOT NULL ,
	cognom2 VARCHAR2(100),
    ofici	VARCHAR2(50),
    manager_id  NUMBER(11),
    email VARCHAR2(150) NOT NULL,
    datalt   DATE DEFAULT SYSDATE,
    datanaix DATE,
    salari   NUMBER(11,2),
    comissio NUMBER(11,2),
    deptartament_id NUMBER(11),
    actiu NUMBER(1) DEFAULT 1,
    compte VARCHAR2(50),
    CONSTRAINT pk_empleat
        PRIMARY KEY(id),
     CONSTRAINT fk_empleat_deptament_id
        FOREIGN KEY (deptartament_id)
        REFERENCES departament(id),
    CONSTRAINT fk_empleat_manager_id
        FOREIGN KEY (manager_id)
        REFERENCES empleat(id),
    CONSTRAINT ck_empleat_actiu
        CHECK(actiu IN (0,1))
);

CREATE TABLE producte(
    id NUMBER(11),
    nom VARCHAR2(200) NOT NULL,
    tipus VARCHAR2(50),
    preu NUMBER(11,2) NOT NULL,
    descompte NUMBER(5,2),
    dataIniciOferta DATE,
    dataFiOferta DATE,
    estoc NUMBER(11,2) DEFAULT 0,
    estocMinim NUMBER(11,2) DEFAULT 0,
    proveidor VARCHAR2(50),
    datalt   DATE DEFAULT SYSDATE,
    actiu NUMBER(1) DEFAULT 1,
    descripcio VARCHAR2(500),
    CONSTRAINT pk_producte 
        PRIMARY KEY(id),
    CONSTRAINT ck_producte_actiu
        CHECK(actiu IN (0,1)),
    CONSTRAINT ck_producte_descompte
        CHECK(descompte BETWEEN 0 AND 100)         
);

CREATE TABLE comanda(
	id NUMBER(11),
	dataComanda DATE DEFAULT SYSDATE,
	estat VARCHAR2(9) DEFAULT 'Pendent' NOT NULL,
    pagada NUMBER(1) DEFAULT 0,
	dataEnviat DATE,
	direccio VARCHAR(500),
    client_id NUMBER(11),
	empleat_id NUMBER(11),
    CONSTRAINT pk_comanda 
        PRIMARY KEY(id),
    CONSTRAINT fk_comanda_client 
        FOREIGN KEY(client_id) 
        REFERENCES client(id),
	CONSTRAINT fk_comanda_empleat 
        FOREIGN KEY(empleat_id) 
        REFERENCES empleat(id),
    CONSTRAINT ck_comanda_pagada
        CHECK(pagada IN (0,1))
);


CREATE TABLE linia_comanda(
    numLinia NUMBER(11),
	comanda_id NUMBER(11),
    producte_id NUMBER(11),
	unitats NUMBER(11),
    preuUnitari NUMBER(11,2),
    descompte NUMBER(5,2),
	CONSTRAINT pk_linia_comanda 
        PRIMARY KEY(comanda_id,numLinia),
	CONSTRAINT fk_linia_comanda_producte 
        FOREIGN KEY(producte_id) 
        REFERENCES producte(id),
	CONSTRAINT fk_linia_comanda_comanda 
        FOREIGN KEY(comanda_id) 
        REFERENCES comanda(id)
);

--INSERIR DEPARTAMENTS

INSERT INTO departament(id, nom, localitat) VALUES(10, 'Vendes', 'Girona');

INSERT INTO departament(id, nom, localitat) VALUES(20, 'Marqueting', 'Figueres');

INSERT INTO departament(id, nom, localitat) VALUES(30, 'Administratiu', 'Madrid');


--INSERIR CLIENTS

INSERT INTO client(id, dni, nom, cognom1, cognom2, email, dataNaix, telefon, compte, direccio, empresa) 
VALUES(1, '12345678A', 'Jordi', 'Sunyer', 'Grau', 'jsunyer@gmail.com', TO_DATE('12/09/2021','DD/MM/YYYY'), '638 45 65 89', 'ES1234567890123456789012', 'Carrer Major, 1, Salt', 'Microsoft');

INSERT INTO client(id, dni, nom, cognom1, cognom2, email, dataNaix, telefon, compte, direccio, empresa)
VALUES(2, '23456789B', 'Albert', 'Vidal', 'Mir', 'avidal2@gmail.com', TO_DATE('10/05/1985','DD/MM/YYYY'), '610 34 56 78', NULL, 'Plaça Catalunya, 1, Girona', 'Apple');

INSERT INTO client(id, dni, nom, cognom1, cognom2, email, dataNaix, telefon, compte, direccio, empresa)
VALUES(3, '34567890C', 'Xavier', 'Madi', 'Roura', 'xaviermad@gmail.com', TO_DATE('03/12/1982','DD/MM/YYYY'), '642 57 89 12', 'ES9876543210987654321098', NULL, 'Google');

INSERT INTO client(id, dni, nom, cognom1, cognom2, email, dataNaix, telefon, compte, direccio, empresa)
VALUES(4, '45678901D', 'Anna', 'Cases', 'Terol', 'ancases@gmail.com', TO_DATE('28/09/1978','DD/MM/YYYY'), '678 90 12 34', 'ES4567890123456789012345', 'Carrer Major, 3, Salt', 'Amazon');

INSERT INTO client(id, dni, nom, cognom1, cognom2, email, dataNaix, telefon, compte, direccio, empresa)
VALUES(5, '56789012E', 'Nuria', 'Bosch', 'Garcia', 'nbosch78@gmail.com', TO_DATE('17/06/1984','DD/MM/YYYY'), '667 89 01 23', NULL, 'Carrer Girona, 15, Salt', 'IBM');

INSERT INTO client(id, dni, nom, cognom1, cognom2, email, dataNaix, telefon, compte, direccio, empresa)
VALUES(6, '67890123F', 'Carla', 'Martí', 'Puig', 'carlamarti@gmail.com', TO_DATE('24/03/1995','DD/MM/YYYY'), '635 98 76 54', 'ES3456789012345678901234', 'Avinguda Diagonal, 20, Girona', 'Intel');

INSERT INTO client(id, dni, nom, cognom1, cognom2, email, dataNaix, telefon, compte, direccio, empresa)
VALUES(7, '78901234G', 'Pau', 'Soler', 'Vidal', 'pausol@gmail.com', TO_DATE('18/11/1989','DD/MM/YYYY'), '671 23 45 67', NULL, 'Carrer Provença, 5, Salt', 'Oracle');

INSERT INTO client(id, dni, nom, cognom1, cognom2, email, dataNaix, telefon, compte, direccio, empresa)
VALUES(8, '89012345H', 'Eva', 'González', 'Fernández', 'evagonzalez@gmail.com', TO_DATE('05/07/1977','DD/MM/YYYY'), '689 45 67 89', 'ES5678901234567890123456', 'Carrer Balmes, 10, Girona', 'Facebook');

INSERT INTO client(id, dni, nom, cognom1, cognom2, email, dataNaix, telefon, compte, direccio, empresa)
VALUES(9, '90123456I', 'William', 'Jones', 'Davis', 'williamjones@gmail.com', TO_DATE('21/09/1977','DD/MM/YYYY'), '699 67 89 01', NULL, 'Carrer Joan Maragall, 3, Salt', 'Twitter');

INSERT INTO client(id, dni, nom, cognom1, cognom2, email, dataNaix, telefon, compte, direccio, empresa)
VALUES(10, '01234567J', 'Sophia', 'Taylor', 'Anderson', 'sophiataylor@gmail.com', TO_DATE('04/03/1990','DD/MM/YYYY'), '633 12 34 56', 'ES2345678901234567890123', 'Avinguda Meridiana, 8, Girona', 'Netflix');

INSERT INTO client(id, dni, nom, cognom1, cognom2, email, dataNaix, telefon, compte, direccio, empresa)
VALUES(11, '12345678K', 'Michael', 'Miller', 'Wilson', 'michaelmiller@gmail.com', TO_DATE('19/11/1985','DD/MM/YYYY'), '666 78 90 12', 'ES6789012345678901234567', 'Rambla de la Llibertat, 25, Salt','Oracle');

--INSERIR EMPLEATS

INSERT INTO empleat(id, dni, nom, cognom1, cognom2, ofici, manager_id, email, datanaix, salari, comissio, deptartament_id, compte) 
VALUES(1, '12345678A', 'Gerard', 'Sánchez', 'Vidal', 'Gerent', NULL, 'gerard@empresa.com', TO_DATE('15/03/1975', 'DD/MM/YYYY'), 5000.00, NULL, 10, 'ES1234567890123456789012');

INSERT INTO empleat(id, dni, nom, cognom1, cognom2, ofici, manager_id, email, datanaix, salari, comissio, deptartament_id, compte) 
VALUES(2, '23456789B', 'Laura', 'Gómez', 'Gaya', 'Venedor', 1, 'laura@empresa.com', TO_DATE('10/05/1988', 'DD/MM/YYYY'), 2000.00, NULL, 20, 'ES2345678901234567890123');

INSERT INTO empleat(id, dni, nom, cognom1, cognom2, ofici, manager_id, email, datanaix, salari, comissio, deptartament_id, compte) 
VALUES(3, '34567890C', 'Mark', 'Johnson', 'Julià', 'Venedor', 1, 'marc@empresa.com', TO_DATE('20/09/1990', 'DD/MM/YYYY'), 1800.00, NULL, 20, 'ES3456789012345678901234');

INSERT INTO empleat(id, dni, nom, cognom1, cognom2, ofici, manager_id, email, datanaix, salari, comissio, deptartament_id, compte) 
VALUES(4, '45678901D', 'Anna', 'Martínez', 'Constantins', 'Venedor', 1, 'anna@empresa.com', TO_DATE('05/07/1992', 'DD/MM/YYYY'), 1900.00, NULL, 20, 'ES4567890123456789012345');

INSERT INTO empleat(id, dni, nom, cognom1, cognom2, ofici, manager_id, email, datanaix, salari, comissio, deptartament_id, compte) 
VALUES(5, '56789012E', 'David', 'Smith', 'Brown', 'Venedor', 1, 'david@empresa.com', TO_DATE('12/12/1985', 'DD/MM/YYYY'), 2200.00, NULL, 20, 'ES5678901234567890123456');

INSERT INTO empleat(id, dni, nom, cognom1, cognom2, ofici, manager_id, email, datanaix, salari, comissio, deptartament_id, compte) 
VALUES(6, '67890123F', 'Maria', 'Fernández', 'Giró', 'Administratiu', 1, 'maria@empresa.com', TO_DATE('28/04/1993', 'DD/MM/YYYY'), 1700.00, NULL, 30, 'ES6789012345678901234567');

INSERT INTO empleat(id, dni, nom, cognom1, cognom2, ofici, manager_id, email, datanaix, salari, comissio, deptartament_id, compte) 
VALUES(7, '78901234G', 'John', 'Doe', 'Dash', 'Administratiu', 1, 'joan@empresa.com', TO_DATE('10/08/1991', 'DD/MM/YYYY'), 1800.00, NULL, 30, 'ES7890123456789012345678');

INSERT INTO empleat(id, dni, nom, cognom1, cognom2, ofici, manager_id, email, datanaix, salari, comissio, deptartament_id, compte) 
VALUES(8, '89012345H', 'Clàudia', 'García', 'Martí', 'Marqueting', 1, 'claudia@empresa.com', TO_DATE('15/06/1987', 'DD/MM/YYYY'), 2100.00, NULL, 20, 'ES8901234567890123456789');

--INSERIR PRODUCTES

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(1, 'Procesador Intel Core i9-10900K', 'Procesador', 499.99, 0, NULL, NULL, 100, 10, 'Intel Corporation', 'Procesador de alto rendimiento para ordenadores de sobremesa.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(2, 'Tarjeta gráfica NVIDIA GeForce RTX 3080', 'Tarjeta gráfica', 799.99, 0, NULL, NULL, 50, 5, 'NVIDIA Corporation', 'Tarjeta gráfica de última generación para juegos y diseño.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(3, 'Placa base ASUS ROG Strix Z590-E Gaming', 'Placa base', 349.99, 10, TO_DATE('2024-05-07', 'YYYY-MM-DD'), TO_DATE('2024-05-14', 'YYYY-MM-DD'), 30, 5, 'ASUSTeK Computer Inc.', 'Placa base de alta gama para procesadores Intel de 10ª y 11ª generación.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(4, 'Memoria RAM Corsair Vengeance LPX 16GB', 'Memoria RAM', 89.99, 0, NULL, NULL, 200, 20, 'Corsair Components, Inc.', 'Módulo de memoria DDR4 de alto rendimiento para sistemas de escritorio.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(5, 'Disco duro sólido Samsung 970 EVO Plus 1TB', 'Almacenamiento', 149.99, 0, NULL, NULL, 100, 10, 'Samsung Electronics Co., Ltd.', 'Disco SSD NVMe M.2 con altas velocidades de transferencia.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(6, 'Tarjeta madre MSI MPG Z490 Gaming Edge WiFi', 'Placa base', 199.99, 0, NULL, NULL, 40, 5, 'Micro-Star International Co., Ltd.', 'Placa base para gaming con soporte para procesadores Intel de 10ª generación.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(7, 'Unidad de estado sólido (SSD) Crucial MX500 500GB', 'Almacenamiento', 30, 0, NULL, NULL, 150, 10, 'Micron Technology, Inc.', 'Disco SSD SATA de alto rendimiento y fiabilidad.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(8, 'Tarjeta gráfica AMD Radeon RX 6700 XT', 'Tarjeta gráfica', 499.99, 0, NULL, NULL, 60, 5, 'Advanced Micro Devices, Inc.', 'Tarjeta gráfica para gaming con arquitectura RDNA 2.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(9, 'Disco duro Seagate Barracuda 2TB', 'Almacenamiento', 79.99, 0, NULL, NULL, 120, 10, 'Seagate Technology PLC', 'Disco duro SATA de 3.5 pulgadas para almacenamiento de datos.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(10, 'Procesador AMD Ryzen 9 5900X', 'Procesador', 549.99, 0, NULL, NULL, 80, 5, 'Advanced Micro Devices, Inc.', 'Procesador de alto rendimiento para sistemas de escritorio.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(11, 'Monitor LG UltraGear 27GL850-B', 'Monitor', 449.99, 0, NULL, NULL, 80, 5, 'LG Electronics Inc.', 'Monitor gaming de alta velocidad de actualización y baja latencia.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(12, 'Teclado mecánico Corsair K95 RGB PLATINUM XT', 'Teclado', 199.99, 0, NULL, NULL, 60, 5, 'Corsair Components, Inc.', 'Teclado mecánico RGB con switches Cherry MX y reposamuñecas desmontable.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(13, 'Ratón inalámbrico Logitech G Pro X Superlight', 'Ratón', 149.99, 0, NULL, NULL, 100, 10, 'Logitech International S.A.', 'Ratón inalámbrico ultraligero para gaming con sensor HERO 25K.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(14, 'Auriculares gaming SteelSeries Arctis 7', 'Auriculares', 149.99, 0, NULL, NULL, 120, 10, 'SteelSeries ApS', 'Auriculares inalámbricos con sonido envolvente DTS Headphone:X v2.0.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(15, 'Webcam Logitech C920 HD Pro', 'Cámara web', 69.99, 0, NULL, NULL, 150, 10, 'Logitech International S.A.', 'Cámara web Full HD con micrófonos duales integrados.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(16, 'AIO Cooler Master MasterLiquid ML240L RGB V2', 'Refrigeración líquida', 79.99, 0, NULL, NULL, 80, 5, 'Cooler Master Technology Inc.', 'Sistema de refrigeración líquida RGB de 240mm para procesadores.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(17, 'Monitor Samsung Odyssey G9', 'Monitor', 1499.99, 0, NULL, NULL, 30, 5, 'Samsung Electronics Co., Ltd.', 'Monitor curvo ultrapanorámico de 49 pulgadas con tasa de refresco de 240Hz.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(18, 'Altavoces Logitech G560 LIGHTSYNC', 'Altavoces', 199.99, 0, NULL, NULL, 50, 5, 'Logitech International S.A.', 'Altavoces con tecnología LIGHTSYNC para gaming.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(19, 'Silla gaming DXRacer Formula Series', 'Silla', 299.99, 0, NULL, NULL, 40, 5, 'DXRacer Inc.', 'Silla gaming ergonómica con soporte lumbar y reposabrazos ajustables.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(20, 'Microfono Blue Yeti X', 'Micrófono', 169.99, 0, NULL, NULL, 70, 5, 'Blue Microphones', 'Micrófono USB con iluminación LED y patrones de captura ajustables.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(21, 'Impresora multifunción HP ENVY 6055e', 'Impresora', 129.99, 0, NULL, NULL, 50, 5, 'HP Inc.', 'Impresora multifunción con conexión inalámbrica para uso doméstico.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(22, 'Monitor ASUS TUF Gaming VG27AQ', 'Monitor', 399.99, 0, NULL, NULL, 70, 5, 'ASUSTeK Computer Inc.', 'Monitor gaming con resolución WQHD y tecnología de sincronización adaptativa.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(23, 'Teclado inalámbrico Logitech K780', 'Teclado', 79.99, 0, NULL, NULL, 100, 10, 'Logitech International S.A.', 'Teclado inalámbrico con soporte para múltiples dispositivos.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(24, 'Ratón gaming Razer DeathAdder V2', 'Ratón', 69.99, 0, NULL, NULL, 120, 10, 'Razer Inc.', 'Ratón gaming con sensor óptico de alta precisión.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(25, 'Auriculares inalámbricos Apple AirPods Pro', 'Auriculares', 249.99, 0, NULL, NULL, 80, 5, 'Apple Inc.', 'Auriculares inalámbricos con cancelación de ruido y resistencia al agua.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(26, 'Router ASUS RT-AX88U AX6000', 'Router', 299.99, 0, NULL, NULL, 40, 5, 'ASUSTeK Computer Inc.', 'Router Wi-Fi 6 con tecnología de triple banda.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(27, 'Disco duro externo WD Elements 4TB', 'Almacenamiento', 119.99, 0, NULL, NULL, 60, 5, 'Western Digital Corporation', 'Disco duro externo portátil con USB 3.0.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(28, 'Silla gaming Secretlab Titan', 'Silla', 399.99, 0, NULL, NULL, 30, 5, 'Secretlab', 'Silla gaming con soporte lumbar integrado y reposabrazos ajustables.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(29, 'Altavoz inteligente Amazon Echo Dot (4.ª generación)', 'Altavoz', 59.99, 0, NULL, NULL, 150, 10, 'Amazon.com, Inc.', 'Altavoz inteligente con asistente virtual Alexa.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(30, 'Micrófono Rode NT-USB Mini', 'Micrófono', 99.99, 0, NULL, NULL, 50, 5, 'RØDE Microphones', 'Micrófono de estudio USB compacto y de alta calidad.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(31, 'Monitor Dell S2721DGF', 'Monitor', 449.99, 0, NULL, NULL, 70, 5, 'Dell Technologies Inc.', 'Monitor gaming con resolución QHD y frecuencia de actualización de 165Hz.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(32, 'Auriculares Sony WH-1000XM4', 'Auriculares', 349.99, 0, NULL, NULL, 80, 5, 'Sony Corporation', 'Auriculares inalámbricos con cancelación de ruido y hasta 30 horas de autonomía.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(33, 'Portátil Apple MacBook Pro 13"', 'Portátil', 1299.99, 0, NULL, NULL, 40, 5, 'Apple Inc.', 'Portátil con procesador M1, 8 GB de RAM y SSD de 256 GB.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(34, 'Impresora 3D Creality Ender 3 V2', 'Impresora 3D', 269.99, 0, NULL, NULL, 60, 5, 'Shenzhen Creality 3D Technology Co., Ltd.', 'Impresora 3D con volumen de impresión de 220x220x250 mm.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(35, 'Monitor gaming MSI Optix MAG274QRF-QD', 'Monitor', 599.99, 0, NULL, NULL, 50, 5, 'Micro-Star International Co., Ltd.', 'Monitor gaming con resolución WQHD y tecnología Quantum Dot.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(36, 'Teclado inalámbrico Apple Magic Keyboard', 'Teclado', 99.99, 0, NULL, NULL, 100, 10, 'Apple Inc.', 'Teclado inalámbrico recargable con diseño ultradelgado.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(37, 'Silla gaming AKRacing Masters Series Max', 'Silla', 499.99, 0, NULL, NULL, 30, 5, 'AKRacing Europe GmbH', 'Silla gaming con estructura de acero y cojines ajustables.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(38, 'Monitor gaming Acer Predator XB273UGS', 'Monitor', 549.99, 0, NULL, NULL, 40, 5, 'Acer Inc.', 'Monitor gaming con resolución WQHD y frecuencia de actualización de 165Hz.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(39, 'Sistema de altavoces Bose Companion 2 Serie III', 'Altavoces', 99.99, 0, NULL, NULL, 80, 5, 'Bose Corporation', 'Altavoces multimedia con sonido estéreo.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(40, 'Auriculares inalámbricos Jabra Elite 85t', 'Auriculares', 229.99, 0, NULL, NULL, 70, 5, 'GN Store Nord A/S', 'Auriculares inalámbricos con cancelación de ruido avanzada y ajuste personalizable.');
INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(41, 'Monitor LG 34GN850-B', 'Monitor', 799.99, 0, NULL, NULL, 50, 5, 'LG Electronics Inc.', 'Monitor ultrapanorámico con resolución QHD y tecnología Nano IPS.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(42, 'Teclado gaming Razer BlackWidow V3', 'Teclado', 139.99, 0, NULL, NULL, 60, 5, 'Razer Inc.', 'Teclado mecánico con switches Razer Green y retroiluminación RGB.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(43, 'Ratón Logitech MX Master 3', 'Ratón', 99.99, 0, NULL, NULL, 100, 10, 'Logitech International S.A.', 'Ratón inalámbrico ergonómico con seguimiento avanzado.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(44, 'Impresora HP Color LaserJet Pro M283fdw', 'Impresora', 399.99, 0, NULL, NULL, 40, 5, 'HP Inc.', 'Impresora láser multifunción con conexión inalámbrica.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(45, 'Monitor MSI Optix MAG274QRF-QD', 'Monitor', 499.99, 0, NULL, NULL, 60, 5, 'Micro-Star International Co., Ltd.', 'Monitor gaming con resolución WQHD y tecnología Quantum Dot.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(46, 'Teclado inalámbrico Microsoft Surface Ergonomic', 'Teclado', 129.99, 0, NULL, NULL, 80, 5, 'Microsoft Corporation', 'Teclado inalámbrico ergonómico con almohadilla de descanso.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(47, 'Ratón gaming Corsair NIGHTSWORD RGB', 'Ratón', 79.99, 0, NULL, NULL, 120, 10, 'Corsair Components, Inc.', 'Ratón gaming con sensor óptico personalizable.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(48, 'Auriculares inalámbricos Samsung Galaxy Buds Pro', 'Auriculares', 199.99, 0, NULL, NULL, 90, 5, 'Samsung Electronics Co., Ltd.', 'Auriculares inalámbricos con cancelación de ruido y sonido envolvente.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(49, 'Impresora Epson EcoTank ET-4760', 'Impresora', 499.99, 0, NULL, NULL, 30, 5, 'Seiko Epson Corporation', 'Impresora multifunción con tanques de tinta recargables.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(50, 'Monitor BenQ PD3220U', 'Monitor', 999.99, 0, NULL, NULL, 20, 5, 'BenQ Corporation', 'Monitor profesional con resolución 4K y calibración de color profesional.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(51, 'Tarjeta gráfica ASUS TUF Gaming GeForce RTX 3060', 'Tarjeta gráfica', 399.99, 0, NULL, NULL, 80, 5, 'ASUSTeK Computer Inc.', 'Tarjeta gráfica para gaming con arquitectura NVIDIA Ampere.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(52, 'Disco duro externo LaCie Rugged Mini 2TB', 'Almacenamiento', 119.99, 0, NULL, NULL, 100, 10, 'Seagate Technology PLC', 'Disco duro externo resistente con conexión USB 3.0.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(53, 'Teclado mecánico SteelSeries Apex Pro', 'Teclado', 199.99, 0, NULL, NULL, 60, 5, 'SteelSeries ApS', 'Teclado mecánico con switches ajustables y retroiluminación RGB.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(54, 'Ratón gaming Logitech G502 HERO', 'Ratón', 79.99, 0, NULL, NULL, 120, 10, 'Logitech International S.A.', 'Ratón gaming con sensor HERO 25K y 11 botones programables.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(55, 'Auriculares inalámbricos Sony WH-1000XM3', 'Auriculares', 299.99, 0, NULL, NULL, 70, 5, 'Sony Corporation', 'Auriculares inalámbricos con cancelación de ruido y hasta 30 horas de batería.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(56, 'Impresora multifunción Canon PIXMA TR4520', 'Impresora', 99.99, 0, NULL, NULL, 150, 10, 'Canon Inc.', 'Impresora multifunción con conexión inalámbrica y alimentador automático de documentos.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(57, 'Monitor AOC C24G1', 'Monitor', 199.99, 0, NULL, NULL, 120, 10, 'AOC International', 'Monitor gaming con panel VA y frecuencia de actualización de 144Hz.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(58, 'Altavoz inteligente Google Nest Mini', 'Altavoz', 49.99, 0, NULL, NULL, 200, 10, 'Google LLC', 'Altavoz inteligente con asistente virtual Google Assistant.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(59, 'Cámara web Logitech C922 Pro Stream', 'Cámara web', 99.99, 0, NULL, NULL, 100, 10, 'Logitech International S.A.', 'Cámara web Full HD con fondo personalizable.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(60, 'Micrófono HyperX QuadCast S', 'Micrófono', 159.99, 0, NULL, NULL, 80, 5, 'Kingston Technology Corporation', 'Micrófono USB con iluminación RGB y montura antivibración.');

--INSERIR COMANDES I LINIES DE COMANDA

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(1, TO_DATE('2024-05-07', 'YYYY-MM-DD'), 'Pendent', NULL, 'Carrer Major, 12, Girona', 0, 1, 1);
INSERT INTO linia_comanda(numLinia,comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 1, 1, 100, 499.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(2, TO_DATE('2024-05-07', 'YYYY-MM-DD'), 'Enviat', TO_DATE('2024-05-08', 'YYYY-MM-DD'), 'Avinguda Diagonal, 34, Salt', 1, 2, 2);
INSERT INTO linia_comanda(numLinia,comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 2, 5, 50, 149.99, 0);
INSERT INTO linia_comanda(numLinia,comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 2, 27, 70, 119.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(3, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Mayor, 8, Madrid', 0, 3, 3);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 3, 10, 30, 99.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(4, TO_DATE('2024-03-22', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Gran Vía, 20, Barcelona', 0, 4, 4);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 4, 15, 20, 199.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(5, TO_DATE('2024-05-04', 'YYYY-MM-DD'), 'Pendent', NULL, 'Carrera 45, 10-32, Medellín', 0, 5, 5);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 5, 30, 15, 299.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 5, 35, 10, 199.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(6, TO_DATE('2024-04-10', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle del Sol, 5, Valencia', 0, 6, 6);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 6, 25, 40, 129.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 6, 20, 25, 179.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(7, TO_DATE('2024-02-18', 'YYYY-MM-DD'), 'Enviat', TO_DATE('2024-02-19', 'YYYY-MM-DD'), 'Plaza de España, 15, Sevilla', 1, 7, 7);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 7, 3, 60, 99.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 7, 12, 35, 149.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(8, TO_DATE('2024-03-30', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Mayor, 2, Zaragoza', 0, 8, 8);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 8, 7, 45, 159.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 8, 18, 20, 219.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(9, TO_DATE('2024-05-15', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Real, 3, Málaga', 0, 9, 5);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 9, 22, 55, 129.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 9, 28, 30, 189.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(10, TO_DATE('2024-04-25', 'YYYY-MM-DD'), 'Pendent', NULL, 'Plaza del Ayuntamiento, 1, Alicante', 0, 2, 1);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 10, 8, 65, 139.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 10, 17, 40, 199.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(11, TO_DATE('2024-05-20', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Mayor, 10, Valencia', 0, 3, 2);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 11, 11, 25, 79.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 11, 16, 15, 109.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(12, TO_DATE('2024-03-18', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle de la Luna, 3, Bilbao', 0, 6, 4);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 12, 21, 30, 89.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 12, 24, 20, 129.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(13, TO_DATE('2024-02-10', 'YYYY-MM-DD'), 'Pendent', NULL, 'Plaza de la Constitución, 2, Granada', 0, 8, 5);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 13, 26, 40, 69.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 13, 29, 25, 119.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(14, TO_DATE('2024-04-05', 'YYYY-MM-DD'), 'Pendent', NULL, 'Avenida de la Libertad, 7, Murcia', 0, 1, 3);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 14, 33, 35, 109.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 14, 36, 20, 139.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(15, TO_DATE('2024-01-28', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Real, 1, Córdoba', 0, 9, 2);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 15, 31, 20, 159.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 15, 34, 15, 199.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(16, TO_DATE('2024-03-12', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle San Miguel, 6, Sevilla', 0, 4, 7);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 16, 9, 55, 89.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 16, 14, 40, 119.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(17, TO_DATE('2024-02-28', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Mayor, 5, Valencia', 0, 5, 6);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 17, 19, 25, 179.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 17, 23, 20, 209.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(18, TO_DATE('2024-04-18', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Real, 2, Barcelona', 0, 2, 8);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 18, 32, 30, 129.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 18, 37, 15, 189.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(19, TO_DATE('2024-05-02', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Mayor, 15, Madrid', 0, 3, 6);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 19, 38, 35, 99.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 19, 40, 20, 149.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(20, TO_DATE('2024-01-10', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Gran Vía, 15, Barcelona', 0, 7, 4);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 20, 39, 40, 69.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 20, 41, 25, 119.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(21, TO_DATE('2024-04-30', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Mayor, 20, Valencia', 0, 4, 5);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 21, 10, 25, 99.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 21, 15, 15, 149.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(22, TO_DATE('2024-05-10', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Real, 5, Sevilla', 0, 8, 6);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 22, 20, 30, 179.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 22, 25, 20, 129.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(23, TO_DATE('2024-03-25', 'YYYY-MM-DD'), 'Pendent', NULL, 'Plaza Mayor, 1, Madrid', 0, 5, 7);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 23, 30, 40, 299.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 23, 35, 25, 199.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(24, TO_DATE('2024-02-15', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Gran Vía, 10, Barcelona', 0, 3, 8);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 24, 40, 35, 149.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 24, 45, 20, 199.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(25, TO_DATE('2024-04-20', 'YYYY-MM-DD'), 'Pendent', NULL, 'Avenida de la Constitución, 5, Sevilla', 0, 9, 4);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 25, 1, 50, 499.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 25, 5, 30, 149.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(26, TO_DATE('2024-02-08', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Mayor, 25, Valencia', 0, 6, 5);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 26, 8, 20, 139.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 26, 15, 15, 199.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(27, TO_DATE('2024-02-19', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Gran Vía, 30, Barcelona', 0, 7, 6);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 27, 20, 25, 179.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 27, 25, 20, 129.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(28, TO_DATE('2024-01-08', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Real, 10, Málaga', 0, 8, 7);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 28, 30, 35, 299.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 28, 35, 20, 199.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(29, TO_DATE('2024-02-09', 'YYYY-MM-DD'), 'Pendent', NULL, 'Avenida de la Libertad, 15, Murcia', 0, 9, 8);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 29, 39, 40, 69.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 29, 41, 25, 119.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(30, TO_DATE('2023-09-08', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Mayor, 2, Zaragoza', 0, 1, 2);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 30, 32, 30, 129.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2,30, 37, 15, 189.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(31, TO_DATE('2024-05-11', 'YYYY-MM-DD'), 'Pendent', NULL, 'Carrer Major, 30, Girona', 0, 3, 5);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 31, 10, 20, 99.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 31, 15, 15, 149.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(3, 31, 20, 10, 179.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(32, TO_DATE('2024-05-06', 'YYYY-MM-DD'), 'Pendent', NULL, 'Avinguda Diagonal, 50, Salt', 0, 4, 6);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 32, 25, 30, 129.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 32, 30, 25, 299.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(3, 32, 35, 20, 199.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(4, 32, 40, 15, 149.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(33, TO_DATE('2024-04-18', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Gran Vía, 25, Barcelona', 0, 5, 7);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 33, 10, 20, 99.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 33, 15, 15, 149.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(3, 33, 20, 10, 179.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(4, 33, 25, 5, 129.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(5, 33, 30, 10, 299.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(34, TO_DATE('2024-04-12', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Real, 20, Madrid', 0, 6, 8);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 34, 10, 20, 99.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 34, 15, 15, 149.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(3, 34, 20, 10, 179.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(4, 34, 25, 5, 129.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(5, 34, 30, 10, 299.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(6, 34, 35, 8, 199.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id) 
VALUES(35, TO_DATE('2024-02-10', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Mayor, 30, Sevilla', 0, 7, 5);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(1, 35, 10, 20, 99.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(2, 35, 15, 15, 149.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(3, 35, 20, 10, 179.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte) 
VALUES(4, 35, 25, 5, 129.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id)
VALUES(36, TO_DATE('2024-01-11', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Real, 15, Valencia', 0, 8, 6);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(1, 36, 30, 25, 299.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(2, 36, 35, 20, 199.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id)
VALUES(37, TO_DATE('2024-04-14', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Gran Vía, 35, Barcelona', 0, 9, 7);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(1, 37, 10, 20, 99.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(2, 37, 15, 15, 149.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(3, 37, 20, 10, 179.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(4, 37, 25, 5, 129.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(5, 37, 30, 10, 299.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id)
VALUES(38, TO_DATE('2024-05-02', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Mayor, 35, Madrid', 0, 6, 8);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(1, 38, 10, 20, 99.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(2, 38, 15, 15, 149.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(3, 38, 20, 10, 179.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(4, 38, 25, 5, 129.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(5, 38, 30, 10, 299.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(6, 38, 35, 8, 199.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id)
VALUES(39, TO_DATE('2024-05-01', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Real, 25, Sevilla', 0, 5, 7);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(1, 39, 10, 20, 99.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(2, 39, 15, 15, 149.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(3, 39, 20, 10, 179.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(4, 39, 25, 5, 129.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id)
VALUES(40, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 'Pendent', NULL, 'Avinguda Diagonal, 50, Salt', 0, 4, 6);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(1, 40, 25, 30, 129.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(2, 40, 30, 25, 299.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(3, 40, 35, 20, 199.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(4, 40, 40, 15, 149.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id)
VALUES(41, TO_DATE('2024-05-09', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Gran Vía, 25, Barcelona', 0, 5, 7);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(1, 41, 10, 20, 99.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(2, 41, 15, 15, 149.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(3, 41, 20, 10, 179.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(4, 41, 25, 5, 129.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(5, 41, 30, 10, 299.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id)
VALUES(42, TO_DATE('2024-04-11', 'YYYY-MM-DD'), 'Pendent', NULL, 'Carrer del Comerç, 20, Valencia', 0, 8, 6);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(1, 42, 10, 15, 99.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(2, 42, 20, 10, 179.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(3, 42, 30, 8, 299.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id)
VALUES(43, TO_DATE('2024-05-08', 'YYYY-MM-DD'), 'Pendent', NULL, 'Plaça Catalunya, 5, Barcelona', 0, 2, 7);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(1, 43, 15, 12, 149.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(2, 43, 25, 8, 129.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(3, 43, 35, 10, 199.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id)
VALUES(44, TO_DATE('2024-04-29', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Mayor, 10, Madrid', 0, 3, 2);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(1, 44, 20, 15, 179.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(2, 44, 25, 10, 129.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(3, 44, 30, 8, 299.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(4, 44, 35, 5, 199.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id)
VALUES(45, TO_DATE('2024-05-01', 'YYYY-MM-DD'), 'Pendent', NULL, 'Rambla Catalunya, 15, Barcelona', 0, 4, 4);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(1, 45, 10, 25, 99.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(2, 45, 15, 20, 149.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(3, 45, 20, 15, 179.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(4, 45, 25, 10, 129.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id)
VALUES(46, TO_DATE('2024-05-10', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Mayor, 20, Madrid', 0, 3, 2);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(1, 46, 10, 10, 99.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(2, 46, 15, 8, 149.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id)
VALUES(47, TO_DATE('2024-05-11', 'YYYY-MM-DD'), 'Pendent', NULL, 'Carrer del Carme, 10, Barcelona', 0, 4, 7);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(1, 47, 20, 12, 179.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(2, 47, 25, 10, 129.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id)
VALUES(48, TO_DATE('2024-04-30', 'YYYY-MM-DD'), 'Pendent', NULL, 'Plaza del Sol, 5, Madrid', 0, 5, 3);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(1, 48, 30, 8, 299.99, 0);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(2, 48, 35, 6, 199.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id)
VALUES(49, TO_DATE('2024-05-06', 'YYYY-MM-DD'), 'Pendent', NULL, 'Calle Mayor, 25, Valencia', 0, 6, 5);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(1, 49, 10, 15, 99.99, 0);

INSERT INTO comanda(id, dataComanda, estat, dataEnviat, direccio, pagada, client_id, empleat_id)
VALUES(50, TO_DATE('2024-05-05', 'YYYY-MM-DD'), 'Pendent', NULL, 'Avinguda Diagonal, 25, Barcelona', 0, 7, 4);
INSERT INTO linia_comanda(numLinia, comanda_id, producte_id, unitats, preuUnitari, descompte)
VALUES(1, 50, 15, 10, 149.99, 0);

COMMIT;
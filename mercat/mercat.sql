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
    dataCreat DATE DEFAULT SYSDATE,
    dataModificat DATE,
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
    dataCreat DATE DEFAULT SYSDATE,
    dataModificat DATE,    
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
    dataCreat DATE DEFAULT SYSDATE,
    dataModificat DATE,    
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
    dataCreat DATE DEFAULT SYSDATE,
    dataModificat DATE,    
    actiu NUMBER(1) DEFAULT 1,    
    CONSTRAINT pk_comanda 
        PRIMARY KEY(id),
    CONSTRAINT fk_comanda_client 
        FOREIGN KEY(client_id) 
        REFERENCES client(id),
	CONSTRAINT fk_comanda_empleat 
        FOREIGN KEY(empleat_id) 
        REFERENCES empleat(id),
    CONSTRAINT ck_comanda_actiu
        CHECK(actiu IN (0,1)),        
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
    dataCreat DATE DEFAULT SYSDATE,
    dataModificat DATE,    
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
VALUES(10, 'Procesador AMD Ryzen 9 5900X', 'Procesador', 549.99, 0, NULL, NULL, 4, 5, 'Advanced Micro Devices, Inc.', 'Procesador de alto rendimiento para sistemas de escritorio.');

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
VALUES(42, 'Teclado gaming Razer BlackWidow V3', 'Teclado', 139.99, 0, NULL, NULL, 0, 5, 'Razer Inc.', 'Teclado mecánico con switches Razer Green y retroiluminación RGB.');

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
VALUES(58, 'Altavoz inteligente Google Nest Mini', 'Altavoz', 49.99, 0, NULL, NULL, 2, 10, 'Google LLC', 'Altavoz inteligente con asistente virtual Google Assistant.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(59, 'Cámara web Logitech C922 Pro Stream', 'Cámara web', 99.99, 0, NULL, NULL, 100, 10, 'Logitech International S.A.', 'Cámara web Full HD con fondo personalizable.');

INSERT INTO producte(id, nom, tipus, preu, descompte, dataIniciOferta, dataFiOferta, estoc, estocMinim, proveidor, descripcio) 
VALUES(60, 'Micrófono HyperX QuadCast S', 'Micrófono', 159.99, 0, NULL, NULL, 80, 5, 'Kingston Technology Corporation', 'Micrófono USB con iluminación RGB y montura antivibración.');

--INSERIR COMANDES
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('1',to_date('07/05/24','DD/MM/RR'),'Pendent','0',null,'Carrer Major, 12, Girona','1','1',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('2',to_date('07/05/24','DD/MM/RR'),'Enviat','1',to_date('08/05/24','DD/MM/RR'),'Avinguda Diagonal, 34, Salt','2','2',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('3',to_date('15/01/24','DD/MM/RR'),'Pendent','0',null,'Calle Mayor, 8, Madrid','3','3',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('4',to_date('22/03/24','DD/MM/RR'),'Pendent','0',null,'Calle Gran Vía, 20, Barcelona','4','4',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('5',to_date('04/05/24','DD/MM/RR'),'Pendent','0',null,'Carrera 45, 10-32, Medellín','5','5',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('6',to_date('10/04/24','DD/MM/RR'),'Pendent','0',null,'Calle del Sol, 5, Valencia','6','6',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('7',to_date('18/02/24','DD/MM/RR'),'Enviat','1',to_date('19/02/24','DD/MM/RR'),'Plaza de España, 15, Sevilla','7','7',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('8',to_date('30/03/24','DD/MM/RR'),'Pendent','0',null,'Calle Mayor, 2, Zaragoza','8','8',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('9',to_date('15/05/24','DD/MM/RR'),'Pendent','0',null,'Calle Real, 3, Málaga','9','5',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('10',to_date('25/04/24','DD/MM/RR'),'Pendent','0',null,'Plaza del Ayuntamiento, 1, Alicante','2','1',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('11',to_date('20/05/24','DD/MM/RR'),'Pendent','0',null,'Calle Mayor, 10, Valencia','3','2',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('12',to_date('18/03/24','DD/MM/RR'),'Pendent','0',null,'Calle de la Luna, 3, Bilbao','6','4',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('13',to_date('10/02/24','DD/MM/RR'),'Pendent','0',null,'Plaza de la ConstituciÃ³n, 2, Granada','8','5',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('14',to_date('05/04/24','DD/MM/RR'),'Pendent','0',null,'Avenida de la Libertad, 7, Murcia','1','3',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('15',to_date('28/01/24','DD/MM/RR'),'Pendent','0',null,'Calle Real, 1, Córdoba','9','2',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('16',to_date('12/03/24','DD/MM/RR'),'Pendent','0',null,'Calle San Miguel, 6, Sevilla','4','7',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('17',to_date('28/02/24','DD/MM/RR'),'Pendent','0',null,'Calle Mayor, 5, Valencia','5','6',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('18',to_date('18/04/24','DD/MM/RR'),'Pendent','0',null,'Calle Real, 2, Barcelona','2','8',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('19',to_date('02/05/24','DD/MM/RR'),'Pendent','0',null,'Calle Mayor, 15, Madrid','3','6',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('20',to_date('10/01/24','DD/MM/RR'),'Pendent','0',null,'Calle Gran Vía, 15, Barcelona','7','4',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('21',to_date('30/04/24','DD/MM/RR'),'Pendent','0',null,'Calle Mayor, 20, Valencia','4','5',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('22',to_date('10/05/24','DD/MM/RR'),'Pendent','0',null,'Calle Real, 5, Sevilla','8','6',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('23',to_date('25/03/24','DD/MM/RR'),'Pendent','0',null,'Plaza Mayor, 1, Madrid','5','7',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('24',to_date('15/02/24','DD/MM/RR'),'Pendent','0',null,'Calle Gran Vía, 10, Barcelona','3','8',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('25',to_date('20/04/24','DD/MM/RR'),'Pendent','0',null,'Avenida de la Constitución, 5, Sevilla','9','4',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('26',to_date('08/02/24','DD/MM/RR'),'Pendent','0',null,'Calle Mayor, 25, Valencia','6','5',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('27',to_date('19/02/24','DD/MM/RR'),'Pendent','0',null,'Calle Gran Vía, 30, Barcelona','7','6',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('28',to_date('08/01/24','DD/MM/RR'),'Pendent','0',null,'Calle Real, 10, Málaga','8','7',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('29',to_date('09/02/24','DD/MM/RR'),'Pendent','0',null,'Avenida de la Libertad, 15, Murcia','9','8',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('30',to_date('08/09/23','DD/MM/RR'),'Pendent','0',null,'Calle Mayor, 2, Zaragoza','1','2',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('31',to_date('11/05/24','DD/MM/RR'),'Pendent','0',null,'Carrer Major, 30, Girona','3','5',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('32',to_date('06/05/24','DD/MM/RR'),'Pendent','0',null,'Avinguda Diagonal, 50, Salt','4','6',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('33',to_date('18/04/24','DD/MM/RR'),'Pendent','0',null,'Calle Gran Vía, 25, Barcelona','5','7',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('34',to_date('12/04/24','DD/MM/RR'),'Pendent','0',null,'Calle Real, 20, Madrid','6','8',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('35',to_date('10/02/24','DD/MM/RR'),'Pendent','0',null,'Calle Mayor, 30, Sevilla','7','5',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('36',to_date('11/01/24','DD/MM/RR'),'Pendent','0',null,'Calle Real, 15, Valencia','8','6',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('37',to_date('14/04/24','DD/MM/RR'),'Pendent','0',null,'Calle Gran Vía, 35, Barcelona','9','7',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('38',to_date('02/05/24','DD/MM/RR'),'Pendent','0',null,'Calle Mayor, 35, Madrid','6','8',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('39',to_date('01/05/24','DD/MM/RR'),'Pendent','0',null,'Calle Real, 25, Sevilla','5','7',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('40',to_date('10/03/24','DD/MM/RR'),'Pendent','0',null,'Avinguda Diagonal, 50, Salt','4','6',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('41',to_date('09/05/24','DD/MM/RR'),'Pendent','0',null,'Calle Gran Vía, 25, Barcelona','5','7',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('42',to_date('11/04/24','DD/MM/RR'),'Pendent','0',null,'Carrer del Comerç, 20, Valencia','8','6',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('43',to_date('08/05/24','DD/MM/RR'),'Pendent','0',null,'Plaça Catalunya, 5, Barcelona','2','7',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('44',to_date('29/04/24','DD/MM/RR'),'Pendent','0',null,'Calle Mayor, 10, Madrid','3','2',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('45',to_date('01/05/24','DD/MM/RR'),'Pendent','0',null,'Rambla Catalunya, 15, Barcelona','4','4',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('46',to_date('10/05/24','DD/MM/RR'),'Pendent','0',null,'Calle Mayor, 20, Madrid','3','2',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('47',to_date('11/05/24','DD/MM/RR'),'Pendent','0',null,'Carrer del Carme, 10, Barcelona','4','7',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('48',to_date('30/04/24','DD/MM/RR'),'Pendent','0',null,'Plaza del Sol, 5, Madrid','5','3',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('49',to_date('06/05/24','DD/MM/RR'),'Pendent','0',null,'Calle Mayor, 25, Valencia','6','5',to_date('10/05/24','DD/MM/RR'),null,'1');
Insert into COMANDA (ID,DATACOMANDA,ESTAT,PAGADA,DATAENVIAT,DIRECCIO,CLIENT_ID,EMPLEAT_ID,DATACREAT,DATAMODIFICAT,ACTIU) values ('50',to_date('05/05/24','DD/MM/RR'),'Pendent','0',null,'Avinguda Diagonal, 25, Barcelona','7','4',to_date('10/05/24','DD/MM/RR'),null,'1');

--INSERIR LINIES DE COMANDA

Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','1','1','100','499,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','2','5','50','149,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','2','27','70','119,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','3','10','30','549,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','4','15','20','69,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','5','30','15','99,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','5','35','10','599,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','6','25','40','249,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','6','20','25','169,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','7','3','60','349,99','10',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','7','12','35','199,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','8','7','45','30','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','8','18','20','199,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','9','22','55','399,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','9','28','30','399,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','10','8','65','499,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','10','17','40','1499,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','11','11','25','449,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','11','16','15','79,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','12','21','30','129,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','12','24','20','69,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','13','26','40','299,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','13','29','25','59,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','14','33','35','1299,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','14','36','20','99,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','15','31','20','449,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','15','34','15','269,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','16','9','55','79,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','16','14','40','149,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','17','19','25','299,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','17','23','20','79,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','18','32','30','349,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','18','37','15','499,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','19','38','35','549,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','19','40','20','229,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','20','39','40','99,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','20','41','25','799,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','21','10','25','549,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','21','15','15','69,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','22','20','30','169,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','22','25','20','249,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','23','30','40','99,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','23','35','25','599,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','24','40','35','229,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','24','45','20','499,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','25','1','50','499,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','25','5','30','149,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','26','8','20','499,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','26','15','15','69,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','27','20','25','169,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','27','25','20','249,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','28','30','35','99,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','28','35','20','599,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','29','39','40','99,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','29','41','25','799,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','30','32','30','349,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','30','37','15','499,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','31','10','20','549,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','31','15','15','69,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('3','31','20','10','169,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','32','25','30','249,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','32','30','25','99,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('3','32','35','20','599,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('4','32','40','15','229,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','33','10','20','549,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','33','15','15','69,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('3','33','20','10','169,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('4','33','25','5','249,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('5','33','30','10','99,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','34','10','20','549,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','34','15','15','69,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('3','34','20','10','169,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('4','34','25','5','249,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('5','34','30','10','99,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('6','34','35','8','599,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','35','10','20','549,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','35','15','15','69,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('3','35','20','10','169,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('4','35','25','5','249,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','36','30','25','99,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','36','35','20','599,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','37','10','20','549,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','37','15','15','69,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('3','37','20','10','169,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('4','37','25','5','249,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('5','37','30','10','99,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','38','10','20','549,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','38','15','15','69,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('3','38','20','10','169,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('4','38','25','5','249,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('5','38','30','10','99,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('6','38','35','8','599,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','39','10','20','549,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','39','15','15','69,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('3','39','20','10','169,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('4','39','25','5','249,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','40','25','30','249,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','40','30','25','99,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('3','40','35','20','599,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('4','40','40','15','229,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','41','10','20','549,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','41','15','15','69,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('3','41','20','10','169,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('4','41','25','5','249,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('5','41','30','10','99,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','42','10','15','549,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','42','20','10','169,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('3','42','30','8','99,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','43','15','12','69,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','43','25','8','249,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('3','43','35','10','599,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','44','20','15','169,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','44','25','10','249,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('3','44','30','8','99,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('4','44','35','5','599,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','45','10','25','549,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','45','15','20','69,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('3','45','20','15','169,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('4','45','25','10','249,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','46','10','10','549,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','46','15','8','69,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','47','20','12','169,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','47','25','10','249,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','48','30','8','99,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('2','48','35','6','599,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','49','10','15','549,99','0',to_date('10/05/24','DD/MM/RR'),null);
Insert into LINIA_COMANDA (NUMLINIA,COMANDA_ID,PRODUCTE_ID,UNITATS,PREUUNITARI,DESCOMPTE,DATACREAT,DATAMODIFICAT) values ('1','50','15','10','69,99','0',to_date('10/05/24','DD/MM/RR'),null);




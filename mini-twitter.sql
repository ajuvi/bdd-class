-----------------
-- MINI_TWITTER --
-----------------

-- ELIMINACIÓ DE TAULES --
--------------------------

DROP TABLE usuari CASCADE CONSTRAINTS;
DROP TABLE missatge CASCADE CONSTRAINTS;
DROP TABLE seguits CASCADE CONSTRAINTS;
DROP TABLE likes CASCADE CONSTRAINTS;

-- CREACIÓ DE TAULES --
-----------------------

CREATE TABLE usuari(
	id NUMBER(11),
	nom VARCHAR2(50),
	cognom VARCHAR2(100),   
	username VARCHAR2(50) NOT NULL,    
	password VARCHAR2(50) NOT NULL,    
	email VARCHAR2(50) UNIQUE NOT NULL,
	telefon VARCHAR2(20) UNIQUE,
	descripcio VARCHAR2(200),
	dataNaix DATE,
	CONSTRAINT pk_usuari PRIMARY KEY(id)
);

COMMENT ON COLUMN usuari.id 
    IS 'Clau primària de la taula usuari';
COMMENT ON COLUMN usuari.nom 
    IS 'El nom de l''usuari';
COMMENT ON COLUMN usuari.cognom 
    IS 'El congnom de l''usuari';
COMMENT ON COLUMN usuari.password 
    IS 'El password de l''usuari';
COMMENT ON COLUMN usuari.email 
    IS 'El correu electrònic de l''usuari';    
COMMENT ON COLUMN usuari.telefon 
    IS 'El telefon de l''usuari';    
COMMENT ON COLUMN usuari.descripcio 
    IS 'Una descripció sobre l''usuari';  
COMMENT ON COLUMN usuari.dataNaix 
    IS 'La data de naixament de l''usuari';  

CREATE TABLE missatge(
	id NUMBER(11),
	titol VARCHAR2(10),
	text VARCHAR2(144),
	data DATE DEFAULT SYSDATE,
	usuari_id NUMBER(11) NOT NULL,
	CONSTRAINT pk_missatge PRIMARY KEY(id),
	CONSTRAINT fk_missatge_ref_usuari_id FOREIGN KEY(usuari_id) REFERENCES usuari(id)
);

COMMENT ON COLUMN missatge.id 
    IS 'Clau primària de la taula missatge';
COMMENT ON COLUMN missatge.titol 
    IS 'El titol del missatge';   
COMMENT ON COLUMN missatge.text 
    IS 'El text del missatge';        
COMMENT ON COLUMN missatge.data 
    IS 'La data de quan s''ha escrit el missatge';        
COMMENT ON COLUMN missatge.usuari_id 
    IS 'L''usuari que ha escrit el missatge';  

-- usuar_id1 segueix usuari_id2
CREATE TABLE seguits(
	usuari_id1 NUMBER(11),
	usuari_id2 NUMBER(11),
	data DATE,
	CONSTRAINT pk_seguit PRIMARY KEY(usuari_id1, usuari_id2),
	CONSTRAINT fk_seguit_ref_usuari_id1 FOREIGN KEY(usuari_id1) REFERENCES usuari(id),
	CONSTRAINT fk_seguit_ref_usuari_id2 FOREIGN KEY(usuari_id2) REFERENCES usuari(id)  
);

COMMENT ON COLUMN seguits.usuari_id1 
    IS 'L''usuari que segueix a l''altre usuari';
COMMENT ON COLUMN seguits.usuari_id2 
    IS 'L''usuari que és seguit per l''altre usuari';

CREATE TABLE likes (
	usuari_id NUMBER(11),
	missatge_id NUMBER(11),
	data DATE DEFAULT SYSDATE,
	emoti VARCHAR2(10),
	CONSTRAINT pk_like PRIMARY KEY(usuari_id, missatge_id),
	CONSTRAINT fk_like_ref_usuari_id FOREIGN KEY(usuari_id) REFERENCES usuari(id),
	CONSTRAINT fk_like_ref_missatge_id FOREIGN KEY(missatge_id) REFERENCES missatge(id)
);

COMMENT ON COLUMN likes.usuari_id 
    IS 'L''usuari fa un m''agrada';
COMMENT ON COLUMN likes.missatge_id 
    IS 'EL missatge que rep un m''agrada';

-- INSERCIÓ DE DADES --
-----------------------
INSERT INTO usuari(id,nom,cognom,username,password,email,telefon,dataNaix,descripcio) VALUES (1,'Pere','Pi','perepi','12345','Pere.Pi@gmail.com','626889955',TO_DATE('18/2/2006','DD/MM/YYYY'),'Hola què tal?!?');  
INSERT INTO usuari(id,nom,cognom,username,password,email,telefon,dataNaix,descripcio) VALUES (2,'Mercè','Puig','merpuig','12345','merceditas@yahoo.com','626849955',TO_DATE('5/8/1995','DD/MM/YYYY'),'Estic al mini-twitter.');
INSERT INTO usuari(id,nom,cognom,username,password,email,telefon,dataNaix,descripcio) VALUES (3,'Joan','Montagut','jmontagut','12345','Joan.Montagut@gmail.com','626889555',TO_DATE('21/11/1983','DD/MM/YYYY'),'Estic al mini-twitter.');
INSERT INTO usuari(id,nom,cognom,username,password,email,telefon,dataNaix,descripcio) VALUES (4,'Esteve','Casadesús','ecasades','12345','esteveguay@gmail.com','626889035',TO_DATE('6/4/1998','DD/MM/YYYY'),'Estic al mini-twitter.');
INSERT INTO usuari(id,nom,cognom,username,password,email,telefon,dataNaix,descripcio) VALUES (5,'Lluís','Gutierrez','llguti','12345','lgutierrez@gmail.com','626877955',TO_DATE('25/6/1996','DD/MM/YYYY'),'Estic al mini-twitter.');
INSERT INTO usuari(id,nom,cognom,username,password,email,telefon,dataNaix,descripcio) VALUES (6,'Artur','Juvé','ajuve','54321','ajuve@gmail.com','636889958',TO_DATE('19/10/2000','DD/MM/YYYY'),'Estic al mini-twitter.');
INSERT INTO usuari(id,nom,cognom,username,password,email,telefon,dataNaix,descripcio) VALUES (7,'Roser','Ramírez','rrami','12345','roser62@telefonica.com','',TO_DATE('8/1/1962','DD/MM/YYYY'),'Quan fa sol tot és millor');
INSERT INTO usuari(id,nom,cognom,username,password,email,telefon,dataNaix,descripcio) VALUES (8,'Maria','Pérez','marper','12345','mariaperez@gmail.com','626123955',TO_DATE('29/12/1953','DD/MM/YYYY'),'Estic al mini-twitter.');
INSERT INTO usuari(id,nom,cognom,username,password,email,telefon,dataNaix,descripcio) VALUES (9,'Josep','Güell','jguai','12345','Josep.Guell@gmail.com','626898555',TO_DATE('13/11/2003','DD/MM/YYYY'),'Estic al mini-twitter.');
INSERT INTO usuari(id,nom,cognom,username,password,email,telefon,dataNaix,descripcio) VALUES (10,'Jordi','Garcia','jorgar','12345','Jordi.Garcia@hotmail.com','',TO_DATE('13/7/1996','DD/MM/YYYY'),':)');
INSERT INTO usuari(id,nom,cognom,username,password,email,telefon,dataNaix,descripcio) VALUES (11,'Isabel','Nadal','isanadal','12345','Isabel.Nadal@gmail.com','626885552',TO_DATE('22/3/2014','DD/MM/YYYY'),'Estic al mini-twitter.');

INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (1,'missatge1','Lorem ipsum dolor sit amet 1',TO_DATE('1/1/2022','DD/MM/YYYY'),5);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (2,'missatge2','Lorem ipsum dolor sit amet 2',TO_DATE('2/1/2022','DD/MM/YYYY'),2);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (3,'missatge3','Lorem ipsum dolor sit amet 3',TO_DATE('3/1/2022','DD/MM/YYYY'),9);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (4,'missatge4','Lorem ipsum dolor sit amet 4',TO_DATE('4/1/2022','DD/MM/YYYY'),1);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (5,'missatge5','Lorem ipsum dolor sit amet 5',TO_DATE('5/1/2022','DD/MM/YYYY'),7);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (6,'missatge6','Lorem ipsum dolor sit amet 6',TO_DATE('6/1/2022','DD/MM/YYYY'),2);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (7,'missatge7','Lorem ipsum dolor sit amet 7',TO_DATE('12/1/2022','DD/MM/YYYY'),4);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (8,'missatge8','Lorem ipsum dolor sit amet 8',TO_DATE('15/1/2022','DD/MM/YYYY'),5);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (9,'missatge9','Lorem ipsum dolor sit amet 9',TO_DATE('16/1/2022','DD/MM/YYYY'),11);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (10,'missatge10','Lorem ipsum dolor sit amet 10',TO_DATE('22/1/2022','DD/MM/YYYY'),3);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (11,'missatge11','Lorem ipsum dolor sit amet 11',TO_DATE('25/1/2022','DD/MM/YYYY'),2);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (12,'missatge12','Lorem ipsum dolor sit amet 12',TO_DATE('26/1/2022','DD/MM/YYYY'),11);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (13,'missatge13','Lorem ipsum dolor sit amet 13',TO_DATE('2/2/2022','DD/MM/YYYY'),2);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (14,'missatge14','Lorem ipsum dolor sit amet 14',TO_DATE('3/2/2022','DD/MM/YYYY'),1);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (15,'missatge15','Lorem ipsum dolor sit amet 15',TO_DATE('4/2/2022','DD/MM/YYYY'),10);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (16,'missatge16','Lorem ipsum dolor sit amet 16',TO_DATE('5/2/2022','DD/MM/YYYY'),7);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (17,'missatge17','Lorem ipsum dolor sit amet 17',TO_DATE('6/2/2022','DD/MM/YYYY'),8);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (18,'missatge18','Lorem ipsum dolor sit amet 18',TO_DATE('8/2/2022','DD/MM/YYYY'),1);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (19,'missatge19','Lorem ipsum dolor sit amet 19',TO_DATE('8/2/2022','DD/MM/YYYY'),8);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (20,'missatge20','Lorem ipsum dolor sit amet 20',TO_DATE('8/2/2022','DD/MM/YYYY'),9);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (21,'missatge21','Lorem ipsum dolor sit amet 21',TO_DATE('10/2/2022','DD/MM/YYYY'),3);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (22,'missatge22','Lorem ipsum dolor sit amet 22',TO_DATE('11/2/2022','DD/MM/YYYY'),3);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (23,'missatge23','Lorem ipsum dolor sit amet 23',TO_DATE('12/2/2022','DD/MM/YYYY'),3);
INSERT INTO missatge(id,titol,text,data,usuari_id) VALUES (24,'missatge24','Lorem ipsum dolor sit amet 24',TO_DATE('17/2/2022','DD/MM/YYYY'),3);

INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (1,3);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (1,5);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (1,8);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (1,10);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (2,3);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (2,5);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (2,10);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (4,10);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (4,11);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (4,5);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (4,9);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (5,10);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (6,3);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (6,7);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (6,1);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (6,5);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (6,10);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (8,1);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (8,3);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (8,10);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (9,4);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (9,10);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (10,1);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (10,2);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (10,3);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (10,4);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (10,5);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (10,6);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (10,7);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (10,8);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (10,9);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (10,7);
INSERT INTO seguits(usuari_id1,usuari_id2) VALUES (11,10);

INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (1,7,TO_DATE('13/1/2022','DD/MM/YYYY'),'(Y)');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (1,18,TO_DATE('10/2/2022','DD/MM/YYYY'),':D');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (2,5,TO_DATE('5/1/2022','DD/MM/YYYY'),':(');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (2,11,TO_DATE('25/1/2022','DD/MM/YYYY'),':)');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (3,7,TO_DATE('15/1/2022','DD/MM/YYYY'),':D');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (3,20,TO_DATE('10/2/2022','DD/MM/YYYY'),'(Y)');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (5,14,TO_DATE('13/2/2022','DD/MM/YYYY'),':)');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (6,16,TO_DATE('25/2/2022','DD/MM/YYYY'),':(');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (6,5,TO_DATE('5/1/2022','DD/MM/YYYY'),'(Y)');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (6,9,TO_DATE('17/1/2022','DD/MM/YYYY'),':)');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (6,6,TO_DATE('9/1/2022','DD/MM/YYYY'),':D');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (8,1,TO_DATE('5/1/2022','DD/MM/YYYY'),'(Y)');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (8,2,TO_DATE('12/1/2022','DD/MM/YYYY'),':D');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (9,15,TO_DATE('7/2/2022','DD/MM/YYYY'),':D');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (9,21,TO_DATE('10/2/2022','DD/MM/YYYY'),':(');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (10,8,TO_DATE('17/1/2022','DD/MM/YYYY'),':)');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (10,14,TO_DATE('4/2/2022','DD/MM/YYYY'),':)');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (10,19,TO_DATE('9/2/2022','DD/MM/YYYY'),':D');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (10,5,TO_DATE('8/1/2022','DD/MM/YYYY'),'(Y)');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (10,7,TO_DATE('3/2/2022','DD/MM/YYYY'),':)');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (11,7,TO_DATE('19/1/2022','DD/MM/YYYY'),':)');
INSERT INTO likes(usuari_id,missatge_id, data, emoti) VALUES (11,5,TO_DATE('20/1/2022','DD/MM/YYYY'),':D');
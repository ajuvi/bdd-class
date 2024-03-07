DROP TABLE estacio CASCADE CONSTRAINTS;
DROP TABLE mesura CASCADE CONSTRAINTS;
DROP SEQUENCE seq_mesura;

CREATE TABLE estacio(
	id NUMBER(11),
	nom VARCHAR2(200),
	latitud NUMBER(11,8),
	longitud NUMBER(11,8),    
	altitud NUMBER(11,5),
	usuari VARCHAR(50) DEFAULT USER,    
	CONSTRAINT pk_estacio PRIMARY KEY(id)
);

CREATE TABLE mesura(
	id NUMBER(11),
	data DATE DEFAULT SYSDATE,
	temperatura NUMBER(11,5),
	pressio NUMBER(11,5),
	usuari VARCHAR(50) DEFAULT USER,    
	estacio_id NUMBER(11),
	CONSTRAINT fk_mesura_ref_estacio FOREIGN KEY(estacio_id) REFERENCES estacio(id)
);

CREATE SEQUENCE seq_mesura
	START WITH 1
	INCREMENT BY 1;
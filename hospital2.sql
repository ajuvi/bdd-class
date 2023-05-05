------------------
-- HOSPITAL 2.0 --
-- 03-05-2023   --
------------------

---
-- Eliminació de les taules
---
DROP TABLE dept CASCADE CONSTRAINTS;   
DROP TABLE doctor CASCADE CONSTRAINTS;
DROP TABLE sala CASCADE CONSTRAINTS;
DROP TABLE hospital CASCADE CONSTRAINTS;
DROP TABLE malalt CASCADE CONSTRAINTS;
DROP TABLE empl CASCADE CONSTRAINTS;
DROP TABLE plantilla CASCADE CONSTRAINTS;
DROP TABLE horari CASCADE CONSTRAINTS;
DROP TABLE visita CASCADE CONSTRAINTS;

drop sequence horari_seq;
drop sequence visita_seq;

-- Creació de taules 

CREATE TABLE dept
 (id  NUMBER(11) primary key,
  nom  VARCHAR2(14),
  loc  VARCHAR2(13));

CREATE TABLE empl
 (id        NUMBER(11)   primary key,
  nom       VARCHAR2(16),
  ofici     VARCHAR2(10),
  dir       NUMBER(11),
  datalt    DATE,
  salari    NUMBER(11,2),
  comissio  NUMBER(11,2),
  dept_id   NUMBER(11),
  
  CONSTRAINT fk_empl_dept_id
    FOREIGN KEY (dept_id)
    REFERENCES dept(id)
  );

CREATE TABLE hospital
 (id        NUMBER(11),
  nom       VARCHAR2(12),
  adreca    VARCHAR2(20),
  telefon   VARCHAR2(8),
  nllits    NUMBER(11),
  
  CONSTRAINT pk_hospital PRIMARY KEY(id)
  );

CREATE TABLE sala
 (id            NUMBER(11),
  hospital_id   NUMBER(11),
  nom           VARCHAR2(20),
  nllits        NUMBER(11),
  
  CONSTRAINT pk_sala PRIMARY KEY(id),
  CONSTRAINT fk_sala_hospital
    FOREIGN KEY (hospital_id)
    REFERENCES hospital(id)
  );

CREATE TABLE plantilla
 ( 
    id              NUMBER(11),
    hospital_id     NUMBER(11),
    sala_id         NUMBER(11),
    nom             VARCHAR2(16),
    funcio          VARCHAR2(10),
    torn            VARCHAR2(1),
    salari          NUMBER(11,2),
   
    CONSTRAINT pk_plantilla PRIMARY KEY(id),
    CONSTRAINT fk_plantilla_hospital
        FOREIGN KEY (hospital_id)
        REFERENCES hospital(id),
    CONSTRAINT fk_plantilla_sala
        FOREIGN KEY (sala_id)
        REFERENCES sala(id)    
 );

CREATE TABLE doctor
 ( id               NUMBER(11),
   hospital_id      NUMBER(11),
   nom              VARCHAR2(16),
   especialitat     VARCHAR2(16),
   
   CONSTRAINT pk_doctor PRIMARY KEY(id)
 );

CREATE TABLE horari (
  id NUMBER(11),
  doctor_id NUMBER(11),
  dia NUMBER(1),
  hora_inici NUMBER(2),
  hora_final NUMBER(2),
  
  CONSTRAINT pk_horari PRIMARY KEY(id),
  CONSTRAINT fk_horari_doctor
    FOREIGN KEY (doctor_id)
    REFERENCES doctor(id)	
);

CREATE SEQUENCE visita_seq
    START WITH 1
    INCREMENT BY 1;


CREATE SEQUENCE horari_seq
    START WITH 1
    INCREMENT BY 1;

CREATE TABLE malalt
 (id            NUMBER(11),
  nom           VARCHAR2(12),
  adreca        VARCHAR2(20),
  dnaixa        DATE,
  sexe          VARCHAR2(1),
  nss           NUMBER(9),
  hospital_id   NUMBER(11),
  doctor_id     NUMBER(11),
  
  CONSTRAINT pk_malalt PRIMARY KEY(id),  
  CONSTRAINT fk_malalt_hospital
    FOREIGN KEY (hospital_id)
    REFERENCES hospital(id),
  CONSTRAINT fk_malalt_doctor
    FOREIGN KEY (doctor_id)
    REFERENCES doctor(id)
  );

CREATE TABLE visita(
    id              NUMBER(11),
    sala_id         NUMBER(2) NOT NULL,
    doctor_id       NUMBER(3) NOT NULL,
    malalt_id       NUMBER(5) NOT NULL,
    data            DATE  NOT NULL,
    data_creat      DATE DEFAULT SYSDATE,
    informe         VARCHAR2(200) DEFAULT '',
    estat           NUMBER(1) DEFAULT 0,
    
    CONSTRAINT pk_visita PRIMARY KEY(id),  
    CONSTRAINT fk_visita_sala FOREIGN KEY (sala_id) REFERENCES sala(id),
    CONSTRAINT fk_visita_doctor FOREIGN KEY (doctor_id) REFERENCES doctor(id),
    CONSTRAINT fk_visita_malalt FOREIGN KEY (malalt_id) REFERENCES malalt(id)
);

-- Inserció de dades

INSERT INTO dept VALUES (10,'Comptabilitat','Sevilla');
INSERT INTO dept VALUES (20,'Investigacio','Madrid');
INSERT INTO dept VALUES (30,'Vendes','Barcelona');
INSERT INTO dept VALUES (40,'Produccio','Bilbao');

INSERT INTO empl VALUES
(7369,'SANCHEZ','EMPLEAT',7902,TO_DATE('17-12-1980','dd-mm-yyyy'),104000,null,20);
INSERT INTO empl VALUES
(7499,'ARROYO','VENEDOR',7698,TO_DATE('22-02-1981','dd-mm-yyyy'),208000,39000,30);
INSERT INTO empl VALUES
(7521,'SALA','VENEDOR',698,TO_DATE('22-02-1981','dd-mm-yyyy'),162500,65000,30);
INSERT INTO empl VALUES
(7566,'JIMENEZ','DIRECTOR',7839,TO_DATE('02-04-1981','dd-mm-yyyy'),386750,null,20);
INSERT INTO empl VALUES
(7654,'MARTIN','VENEDOR',7698,TO_DATE('28-09-1981','dd-mm-yyyy'),182000,182000,30);
INSERT INTO empl VALUES
(7698,'NEGRO','DIRECTOR',7839,TO_DATE('01-05-1981','dd-mm-yyyy'),370500,null,30);
INSERT INTO empl VALUES
(7782,'CEREZO','DIRECTOR',7839,TO_DATE('09-06-1981','dd-mm-yyyy'),318500,null,10);
INSERT INTO empl VALUES
(7788,'GIL','ANALISTA',7566,TO_DATE('30-03-1987','dd-mm-yyyy'),390000,null,20);
INSERT INTO empl VALUES
(7839,'REY','PRESIDENT',null,TO_DATE('17-11-1981','dd-mm-yyyy'),650000,null,10);
INSERT INTO empl VALUES
(7844,'TOVAR','VENEDOR',7698,TO_DATE('08-09-1981','dd-mm-yyyy'),195000,0,30);
INSERT INTO empl VALUES
(7876,'ALONSO','EMPLEAT',7788,TO_DATE('03-05-1987','dd-mm-yyyy'),143000,null,20);
INSERT INTO empl VALUES
(7900,'JIMENO','EMPLEAT',7698,TO_DATE('03-12-1981','dd-mm-yyyy'),123500,null,30);
INSERT INTO empl VALUES
(7902,'FERNANDEZ','ANALISTA',7566,TO_DATE('03-12-1981','dd-mm-yyyy'),390000,null,20);
INSERT INTO empl VALUES
(7934,'MUNOZ','EMPLEAT',7782,TO_DATE('23-01-1982','dd-mm-yyyy'),169000,null,10);

INSERT INTO hospital VALUES (13,'Provincial','O''Donell,20','964-4264',502);
INSERT INTO hospital VALUES (18,'General','Atocha, s/n','595-3111',987);
INSERT INTO hospital VALUES (22,'La Paz','Castellana, 1000','923-5411',412);
INSERT INTO hospital VALUES (45,'San Carlos','Ciudad Universitaria','597-1500',845);

INSERT INTO sala VALUES (1,13,'Cures Intensives',21);
INSERT INTO sala VALUES (2,13,'Psiquiatric',67);
INSERT INTO sala VALUES (3,18,'Cures Intensives',10);
INSERT INTO sala VALUES (4,18,'Cardiologia',53);
INSERT INTO sala VALUES (5,22,'Recuperacio',10);
INSERT INTO sala VALUES (6,22,'Psiquiatric',118);
INSERT INTO sala VALUES (7,22,'Maternitat',34);
INSERT INTO sala VALUES (8,45,'Cardiologia',55);
INSERT INTO sala VALUES (9,45,'Recuperacio',13);
INSERT INTO sala VALUES (10,45,'Maternitat',2);

INSERT INTO plantilla VALUES 
(3754,13,1,'Diaz B.','Infermera','T',226200);
INSERT INTO plantilla VALUES 
(3106,13,2,'Hernandez J.','Infermer','T',275000);
INSERT INTO plantilla VALUES 
(6357,18,3,'Karplus W.','Intern','T',337900);
INSERT INTO plantilla VALUES 
(1009,22,5,'Higueras D.','Infermera','T',200500);
INSERT INTO plantilla VALUES 
(8422,22,5,'Bocina G.','Infermer','M',183800);
INSERT INTO plantilla VALUES 
(9901,22,6,'Nunez C.','Intern','M',221000);
INSERT INTO plantilla VALUES 
(6065,22,7,'Rivera G.','Infermera','N',162600);
INSERT INTO plantilla VALUES 
(7379,22,7,'Carlos R.','Infermera','T',221900);
INSERT INTO plantilla VALUES 
(1280,45,8,'Amigo R.','Intern','N',221000);
INSERT INTO plantilla VALUES 
(8526,45,9,'Frank H.','Infermera','T',252200);
   
INSERT INTO doctor VALUES (435,13,'Lopez A', 'Cardiologia');
INSERT INTO doctor VALUES (585,18,'Miller G.', 'Ginecologia');
INSERT INTO doctor VALUES (982,18,'Cajal R.', 'Cardiologia');
INSERT INTO doctor VALUES (453,22,'Galo D.', 'Pediatria');
INSERT INTO doctor VALUES (398,22,'Best D.', 'Urologia');
INSERT INTO doctor VALUES (386,22,'Cabeza D.', 'Psiquiatria');
INSERT INTO doctor VALUES (607,45,'Nino P.', 'Pediatria');
INSERT INTO doctor VALUES (522,45,'Adams C.', 'Neurologia');

-- horari general doctor 435
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 435, 1, 8, 14);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 435, 1, 16, 20);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 435, 2, 8, 14);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 435, 2, 16, 20);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 435, 3, 8, 14);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 435, 3, 16, 20);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 435, 4, 8, 14);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 435, 4, 16, 20);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 435, 5, 8, 14);

-- horari geenral doctor 585
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 585, 1, 14, 22);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 585, 2, 14, 22);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 585, 3, 14, 22);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 585, 4, 14, 22);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 585, 5, 14, 22);

-- horari geenral doctor 982
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 982, 1, 9, 14);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 982, 1, 16, 20);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 982, 2, 9, 14);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 982, 2, 16, 20);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 982, 3, 9, 14);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 982, 3, 16, 20);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 982, 4, 9, 14);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 982, 4, 16, 20);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 982, 5, 9, 14);

-- horari geenral doctor 453
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 453, 1, 9, 14);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 453, 1, 16, 20);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 453, 2, 9, 14);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 453, 2, 16, 20);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 453, 3, 9, 14);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 453, 3, 16, 20);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 453, 4, 9, 14);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 453, 4, 16, 20);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 453, 5, 9, 14);

-- horari geenral doctor 386
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 386, 1, 8, 14);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 386, 2, 8, 14);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 386, 3, 8, 14);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 386, 4, 8, 14);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 386, 5, 8, 14);

-- horari geenral doctor 398
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 398, 1, 8, 14);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 398, 2, 8, 14);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 398, 3, 8, 14);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 398, 4, 8, 14);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 398, 5, 8, 14);

-- horari geenral doctor 607
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 607, 1, 8, 20);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 607, 2, 8, 20);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 607, 5, 8, 20);

-- horari geenral doctor 522
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 522, 1, 8, 15);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 522, 1, 16, 19);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 522, 2, 8, 15);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 522, 2, 16, 19);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 522, 3, 8, 15);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 522, 3, 16, 19);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 522, 4, 8, 15);
INSERT INTO horari VALUES (horari_seq.NEXTVAL, 522, 4, 16, 19);

INSERT INTO malalt VALUES 
(10995,'Laguia M.','Goya 20',TO_DATE('16-05-1956','dd-mm-yyyy'),'M',280862482,13,435);
INSERT INTO malalt VALUES 
(18004,'Serrano V.','Alcala 12',TO_DATE('21-05-1960','dd-mm-yyyy'),'F',284991452,13,435);
INSERT INTO malalt VALUES 
(14024,'Fernandez M.','Recoletos 20',TO_DATE('23-06-1967','dd-mm-yyyy'),'F',321790059,NULL,NULL);
INSERT INTO malalt VALUES 
(36658,'Domin S.','Major 71',TO_DATE('01-01-1942','dd-mm-yyyy'),'M',160654471,18,982);
INSERT INTO malalt VALUES 
(38702,'Neal R.','Orense 11',TO_DATE('18-06-1940','dd-mm-yyyy'),'F',380010217,18,982);
INSERT INTO malalt VALUES
(39217,'Cervantes M.','Peron 38',TO_DATE('29-02-1952','dd-mm-yyyy'),'M',440294390,18,982);
INSERT INTO malalt VALUES 
(59076,'Miller B.','Lopez de Hoyos 2',TO_DATE('16-09-1945','dd-mm-yyyy'),'F',311969044,22,453);
INSERT INTO malalt VALUES 
(63827,'Ruiz P.','Esquerdo 103',TO_DATE('26-12-1980','dd-mm-yyyy'),'M',100973253,22,398);
INSERT INTO malalt VALUES 
(64823,'Fraser A.','Soto 3',TO_DATE('10-07-1980','dd-mm-yyyy'),'F',285201776,22,386);
INSERT INTO malalt VALUES
(74835,'Benitez E.','Argentina 5',TO_DATE('05-10-1957','dd-mm-yyyy'),'M',154811767,45,607);

INSERT INTO visita (id, sala_id, doctor_id, malalt_id, data)
VALUES (visita_seq.NEXTVAL, 1, 435, 10995, TO_DATE('2023-05-04 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO visita (id, sala_id, doctor_id, malalt_id, data)
VALUES (visita_seq.NEXTVAL, 1, 435, 18004, TO_DATE('2023-05-07 11:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO visita (id, sala_id, doctor_id, malalt_id, data)
VALUES (visita_seq.NEXTVAL, 2, 435, 14024, TO_DATE('2023-05-15 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));

COMMIT;

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

drop sequence horari_seq;

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
    foreign key (dept_id)
    references dept(id)
  );

CREATE TABLE hospital
 (id        NUMBER(11) primary key,
  nom       VARCHAR2(12),
  adreca    VARCHAR2(20),
  telefon   VARCHAR2(8),
  nllits    NUMBER(11)
  );

CREATE TABLE sala
 (id            NUMBER(11),
  hospital_id   NUMBER(11),
  nom           VARCHAR2(20),
  nllits        NUMBER(11),
  
  CONSTRAINT pk_sala PRIMARY KEY(id),
  CONSTRAINT fk_sala_hospital
    foreign key (hospital_id)
    references hospital(id)
  );

CREATE TABLE plantilla
 ( 
    id                   NUMBER(11),
    hospital_id          NUMBER(11),
    sala_id              NUMBER(11),
    nom                  VARCHAR2(16),
    funcio               VARCHAR2(10),
    torn                 VARCHAR2(1),
    salari               NUMBER(11,2),
   
    CONSTRAINT pk_plantilla PRIMARY KEY(id),
    CONSTRAINT fk_plantilla_hospital
        foreign key (hospital_id)
        references hospital(id),
   CONSTRAINT fk_plantilla_sala
        foreign key (sala_id)
        references sala(id)    
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

CREATE SEQUENCE horari_seq
    START WITH 1
    INCREMENT BY 1;

CREATE TABLE malalt
 (id    NUMBER(11) primary key,
  nom    VARCHAR2(12),
  adreca VARCHAR2(20),
  dnaixa DATE,
  sexe   VARCHAR2(1),
  nss    NUMBER(9),
  hospital_id NUMBER(11),
  doctor_id NUMBER(11),
  
  CONSTRAINT fk_malalt_hospital
    foreign key (hospital_id)
    references hospital(id),
  CONSTRAINT fk_malalt_doctor
    foreign key (doctor_id)
    references doctor(id)
  );

-- Inserció de dades

insert into dept values (10,'Comptabilitat','Sevilla');
insert into dept values (20,'Investigacio','Madrid');
insert into dept values (30,'Vendes','Barcelona');
insert into dept values (40,'Produccio','Bilbao');

insert into empl values
(7369,'SANCHEZ','EMPLEAT',7902,to_DATE('17-12-1980','dd-mm-yyyy'),104000,null,20);
insert into empl values
(7499,'ARROYO','VENEDOR',7698,to_DATE('22-02-1981','dd-mm-yyyy'),208000,39000,30);
insert into empl values
(7521,'SALA','VENEDOR',698,to_DATE('22-02-1981','dd-mm-yyyy'),162500,65000,30);
insert into empl values
(7566,'JIMENEZ','DIRECTOR',7839,to_DATE('02-04-1981','dd-mm-yyyy'),386750,null,20);
insert into empl values
(7654,'MARTIN','VENEDOR',7698,to_DATE('28-09-1981','dd-mm-yyyy'),182000,182000,30);
insert into empl values
(7698,'NEGRO','DIRECTOR',7839,to_DATE('01-05-1981','dd-mm-yyyy'),370500,null,30);
insert into empl values
(7782,'CEREZO','DIRECTOR',7839,to_DATE('09-06-1981','dd-mm-yyyy'),318500,null,10);
insert into empl values
(7788,'GIL','ANALISTA',7566,to_DATE('30-03-1987','dd-mm-yyyy'),390000,null,20);
insert into empl values
(7839,'REY','PRESIDENT',null,to_DATE('17-11-1981','dd-mm-yyyy'),650000,null,10);
insert into empl values
(7844,'TOVAR','VENEDOR',7698,to_DATE('08-09-1981','dd-mm-yyyy'),195000,0,30);
insert into empl values
(7876,'ALONSO','EMPLEAT',7788,to_DATE('03-05-1987','dd-mm-yyyy'),143000,null,20);
insert into empl values
(7900,'JIMENO','EMPLEAT',7698,to_DATE('03-12-1981','dd-mm-yyyy'),123500,null,30);
insert into empl values
(7902,'FERNANDEZ','ANALISTA',7566,to_DATE('03-12-1981','dd-mm-yyyy'),390000,null,20);
insert into empl values
(7934,'MUNOZ','EMPLEAT',7782,to_DATE('23-01-1982','dd-mm-yyyy'),169000,null,10);

insert into hospital values (13,'Provincial','O''Donell,20','964-4264',502);
insert into hospital values (18,'General','Atocha, s/n','595-3111',987);
insert into hospital values (22,'La Paz','Castellana, 1000','923-5411',412);
insert into hospital values (45,'San Carlos','Ciudad Universitaria','597-1500',845);

insert into sala values (1,13,'Cures Intensives',21);
insert into sala values (2,13,'Psiquiatric',67);
insert into sala values (3,18,'Cures Intensives',10);
insert into sala values (4,18,'Cardiologia',53);
insert into sala values (5,22,'Recuperacio',10);
insert into sala values (6,22,'Psiquiatric',118);
insert into sala values (7,22,'Maternitat',34);
insert into sala values (8,45,'Cardiologia',55);
insert into sala values (9,45,'Recuperacio',13);
insert into sala values (10,45,'Maternitat',2);

insert into plantilla values 
(3754,13,1,'Diaz B.','Infermera','T',226200);
insert into plantilla values 
(3106,13,2,'Hernandez J.','Infermer','T',275000);
insert into plantilla values 
(6357,18,3,'Karplus W.','Intern','T',337900);
insert into plantilla values 
(1009,22,5,'Higueras D.','Infermera','T',200500);
insert into plantilla values 
(8422,22,5,'Bocina G.','Infermer','M',183800);
insert into plantilla values 
(9901,22,6,'Nunez C.','Intern','M',221000);
insert into plantilla values 
(6065,22,7,'Rivera G.','Infermera','N',162600);
insert into plantilla values 
(7379,22,7,'Carlos R.','Infermera','T',221900);
insert into plantilla values 
(1280,45,8,'Amigo R.','Intern','N',221000);
insert into plantilla values 
(8526,45,9,'Frank H.','Infermera','T',252200);
   
insert into doctor values (435,13,'Lopez A', 'Cardiologia');
insert into doctor values (585,18,'Miller G.', 'Ginecologia');
insert into doctor values (982,18,'Cajal R.', 'Cardiologia');
insert into doctor values (453,22,'Galo D.', 'Pediatria');
insert into doctor values (398,22,'Best D.', 'Urologia');
insert into doctor values (386,22,'Cabeza D.', 'Psiquiatria');
insert into doctor values (607,45,'Nino P.', 'Pediatria');
insert into doctor values (522,45,'Adams C.', 'Neurologia');

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

insert into malalt values 
(10995,'Laguia M.','Goya 20',to_DATE('16-05-1956','dd-mm-yyyy'),'M',280862482,13,435);
insert into malalt values 
(18004,'Serrano V.','Alcala 12',to_DATE('21-05-1960','dd-mm-yyyy'),'F',284991452,13,435);
insert into malalt values 
(14024,'Fernandez M.','Recoletos 20',to_DATE('23-06-1967','dd-mm-yyyy'),'F',321790059,NULL,NULL);
insert into malalt values 
(36658,'Domin S.','Major 71',to_DATE('01-01-1942','dd-mm-yyyy'),'M',160654471,18,982);
insert into malalt values 
(38702,'Neal R.','Orense 11',to_DATE('18-06-1940','dd-mm-yyyy'),'F',380010217,18,982);
insert into malalt values
(39217,'Cervantes M.','Peron 38',to_DATE('29-02-1952','dd-mm-yyyy'),'M',440294390,18,982);
insert into malalt values 
(59076,'Miller B.','Lopez de Hoyos 2',to_DATE('16-09-1945','dd-mm-yyyy'),'F',311969044,22,453);
insert into malalt values 
(63827,'Ruiz P.','Esquerdo 103',to_DATE('26-12-1980','dd-mm-yyyy'),'M',100973253,22,398);
insert into malalt values 
(64823,'Fraser A.','Soto 3',to_DATE('10-07-1980','dd-mm-yyyy'),'F',285201776,22,386);
insert into malalt values
(74835,'Benitez E.','Argentina 5',to_DATE('05-10-1957','dd-mm-yyyy'),'M',154811767,45,607);

COMMIT;

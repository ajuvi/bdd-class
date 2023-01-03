Rem
Rem*************************************************************************************
Rem                        Proces de creacio massiu taules SGBD
Rem                              Rem*************************************************************************************
Rem  Es creen taules
Rem     DEPT      PK-> dept_num
Rem     EMPL      PK-> empl_num                      
Rem               FK-> empl_dept_num 
Rem     MALALT    PK-> malalt_num 
Rem     HOSPITAL  PK-> hospital_codi
Rem     SALA      PK-> sala_codi, sala_hospital_codi 
Rem               FK-> sala_hospital_codi
Rem     PLANTILLA PK-> plantilla_empleat_num
Rem               FK-> plantilla_hospital_codi
Rem               FK-> plantilla_sala_codi,plantilla_hospital_codi
Rem     DOCTOR    PK-> doctor_codi
Rem               FK-> doctor_hospital_codi
Rem
Rem*************************************************************************************
Rem
prompt Construint taules per sgbd . Esperi un moment
set termout off
set feedback off 



 
Rem*************************************
Rem   Definici€ estructura taula DEPT
Rem*************************************
drop table dept;   
create table dept
 (dept_num  number(2) primary key,
  dept_nom  varchar2(14),
  dept_loc  varchar2(13));

Rem*************************************
Rem   Insercci€ de dades a la taula DEPT
Rem*************************************
insert into dept values (10,'Comptabilitat','Sevilla');
insert into dept values (20,'Investigacio','Madrid');
insert into dept values (30,'Vendes','Barcelona');
insert into dept values (40,'Produccio','Bilbao');

Rem*************************************
Rem   Definici€ estructura taula EMPL
Rem*************************************
drop table empl;
create table empl
 (empl_num      number(4)   primary key,
  empl_nom      varchar2(16),
  empl_ofici    varchar2(10),
  empl_dir      number(4),
  empl_datalt   date,
  empl_salari   number(11,2),
  empl_comissio number(11,2),
  empl_dept_num number(2));

alter table empl
  add constraint fk_empl_dept_num
  foreign key (empl_dept_num)
  references dept(dept_num);

Rem*************************************
Rem   Insercci€ de dades a la taula EMPL
Rem*************************************
insert into empl values
(7369,'SANCHEZ','EMPLEAT',7902,to_date('17-12-1980','dd-mm-yyyy'),104000,null,20);
insert into empl values
(7499,'ARROYO','VENEDOR',7698,to_date('22-02-1981','dd-mm-yyyy'),208000,39000,30);
insert into empl values
(7521,'SALA','VENEDOR',698,to_date('22-02-1981','dd-mm-yyyy'),162500,65000,30);
insert into empl values
(7566,'JIMENEZ','DIRECTOR',7839,to_date('02-04-1981','dd-mm-yyyy'),386750,null,20);
insert into empl values
(7654,'MARTIN','VENEDOR',7698,to_date('28-09-1981','dd-mm-yyyy'),182000,182000,30);
insert into empl values
(7698,'NEGRO','DIRECTOR',7839,to_date('01-05-1981','dd-mm-yyyy'),370500,null,30);
insert into empl values
(7782,'CEREZO','DIRECTOR',7839,to_date('09-06-1981','dd-mm-yyyy'),318500,null,10);
insert into empl values
(7788,'GIL','ANALISTA',7566,to_date('30-03-1987','dd-mm-yyyy'),390000,null,20);
insert into empl values
(7839,'REY','PRESIDENT',null,to_date('17-11-1981','dd-mm-yyyy'),650000,null,10);
insert into empl values
(7844,'TOVAR','VENEDOR',7698,to_date('08-09-1981','dd-mm-yyyy'),195000,0,30);
insert into empl values
(7876,'ALONSO','EMPLEAT',7788,to_date('03-05-1987','dd-mm-yyyy'),143000,null,20);
insert into empl values
(7900,'JIMENO','EMPLEAT',7698,to_date('03-12-1981','dd-mm-yyyy'),123500,null,30);
insert into empl values
(7902,'FERNANDEZ','ANALISTA',7566,to_date('03-12-1981','dd-mm-yyyy'),390000,null,20);
insert into empl values
(7934,'MUNOZ','EMPLEAT',7782,to_date('23-01-1982','dd-mm-yyyy'),169000,null,10);

Rem*************************************
Rem   Definicio estructura taula MALALT
Rem*************************************
drop table malalt;
create table malalt
 (malalt_num    number(5) primary key,
  malalt_nom    varchar2(12),
  malalt_adreca varchar2(20),
  malalt_dnaixa date,
  malalt_sexe   varchar2(1),
  malalt_nss    number(9));

Rem***************************************
Rem   Insercci€ de dades a la taula MALALT
Rem***************************************
insert into malalt values 
(10995,'Laguia M.','Goya 20',to_date('16-05-1956','dd-mm-yyyy'),'M',280862482);
insert into malalt values 
(18004,'Serrano V.','Alcala 12',to_date('21-05-1960','dd-mm-yyyy'),'F',284991452);
insert into malalt values 
(14024,'Fernandez M.','Recoletos 20',to_date('23-06-1967','dd-mm-yyyy'),'F',321790059);
insert into malalt values 
(36658,'Domin S.','Major 71',to_date('01-01-1942','dd-mm-yyyy'),'M',160654471);
insert into malalt values 
(38702,'Neal R.','Orense 11',to_date('18-06-1940','dd-mm-yyyy'),'F',380010217);
insert into malalt values
(39217,'Cervantes M.','Peron 38',to_date('29-02-1952','dd-mm-yyyy'),'M',440294390);
insert into malalt values 
(59076,'Miller B.','Lopez de Hoyos 2',to_date('16-09-1945','dd-mm-yyyy'),'F',311969044);
insert into malalt values 
(63827,'Ruiz P.','Esquerdo 103',to_date('26-12-1980','dd-mm-yyyy'),'M',100973253);
insert into malalt values 
(64823,'Fraser A.','Soto 3',to_date('10-07-1980','dd-mm-yyyy'),'F',285201776);
insert into malalt values
(74835,'Benitez E.','Argentina 5',to_date('05-10-1957','dd-mm-yyyy'),'M',154811767);

Rem*************************************
Rem   Definicio estructura taula HOSPITAL
Rem*************************************
drop table hospital;
create table hospital
 (hospital_codi    number(2) primary key,
  hospital_nom     varchar2(12),
  hospital_adreca  varchar2(20),
  hospital_telefon varchar2(8),
  hospital_nllits  number(4));

Rem*****************************************
Rem   Insercci€ de dades a la taula HOSPITAL
Rem*****************************************
insert into hospital values (13,'Provincial','O''Donell,20','964-4264',502);
insert into hospital values (18,'General','Atocha, s/n','595-3111',987);
insert into hospital values (22,'La Paz','Castellana, 1000','923-5411',412);
insert into hospital values (45,'San Carlos','Ciudad Universitaria','597-1500',845);

Rem*************************************
Rem   Definicio estructura taula SALA
Rem*************************************
drop table sala;
create table sala
 (sala_codi          number(2),
  sala_hospital_codi number(2),
  sala_nom           varchar2(20),
  sala_nllits        number(4));

alter table sala
add constraint pk_sala_codi_hospital
primary key (sala_codi, sala_hospital_codi);

alter table sala
add constraint fk_sala_hospital_codi
foreign key (sala_hospital_codi)
references hospital(hospital_codi);

Rem*****************************************
Rem   Insercci€ de dades a la taula SALA
Rem*****************************************
insert into sala values (3,13,'Cures Intensives',21);
insert into sala values (6,13,'Psiquiatric',67);
insert into sala values (3,18,'Cures Intensives',10);
insert into sala values (4,18,'Cardiologia',53);
insert into sala values (1,22,'Recuperacio',10);
insert into sala values (6,22,'Psiquiatric',118);
insert into sala values (2,22,'Maternitat',34);
insert into sala values (4,45,'Cardiologia',55);
insert into sala values (1,45,'Recuperacio',13);
insert into sala values (2,45,'Maternitat',2);

Rem***************************************
Rem   Definicio estructura taula PLANTILLA
Rem***************************************
drop table plantilla;  
create table plantilla
 ( plantilla_hospital_codi number(2),
   plantilla_sala_codi     number(2),
   plantilla_empleat_num   number(4) primary key,
   plantilla_nom           varchar2(16),
   plantilla_funcio        varchar2(10),
   plantilla_torn          varchar2(1),
   plantilla_salari        number(11,2));

alter table plantilla
add constraint fk_plantilla_hospital_codi
foreign key (plantilla_hospital_codi)
references hospital(hospital_codi);

alter table plantilla
add constraint fk_plantilla_sala_codi
foreign key (plantilla_sala_codi,plantilla_hospital_codi)
references sala(sala_codi,sala_hospital_codi);

Rem*****************************************
Rem   Insercci€ de dades a la taula PLANTILLA
Rem*****************************************
insert into plantilla values 
(13,6,3754,'Diaz B.','Infermera','T',226200);
insert into plantilla values 
(13,6,3106,'Hernandez J.','Infermer','T',275000);
insert into plantilla values 
(18,4,6357,'Karplus W.','Intern','T',337900);
insert into plantilla values 
(22,6,1009,'Higueras D.','Infermera','T',200500);
insert into plantilla values 
(22,6,8422,'Bocina G.','Infermer','M',183800);
insert into plantilla values 
(22,2,9901,'Nunez C.','Intern','M',221000);
insert into plantilla values 
(22,1,6065,'Rivera G.','Infermera','N',162600);
insert into plantilla 
values (22,1,7379,'Carlos R.','Infermera','T',221900);
insert into plantilla values 
(45,4,1280,'Amigo R.','Intern','N',221000);
insert into plantilla values 
(45,1,8526,'Frank H.','Infermera','T',252200);

Rem***************************************
Rem   Definicio estructura taula DOCTOR
Rem***************************************
drop table doctor;
create table doctor
 ( doctor_codi          number(3) primary key,
   doctor_hospital_codi number(2),
   doctor_nom           varchar2(16),
   doctor_especialitat  varchar2(16));

alter table doctor 
add constraint fk_doctor_hospital_codi
foreign key (doctor_hospital_codi)
references hospital(hospital_codi);

Rem*****************************************
Rem   Insercci€ de dades a la taula DOCTOR
Rem*****************************************   
insert into doctor values (435,13,'Lopez A', 'Cardiologia');
insert into doctor values (585,18,'Miller G.', 'Ginecologia');
insert into doctor values (982,18,'Cajal R.', 'Cardiologia');
insert into doctor values (453,22,'Galo D.', 'Pediatria');
insert into doctor values (398,22,'Best D.', 'Urologia');
insert into doctor values (386,22,'Cabeza D.', 'Psiquiatria');
insert into doctor values (607,45,'Nino P.', 'Pediatria');
insert into doctor values (522,45,'Adams C.', 'Neurologia');

commit;
 
set termout on
set feedback on 

prompt Proces finalitzat.



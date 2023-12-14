drop table dept cascade constraints;   
drop table empl cascade constraints;

-- Definició estructura taula DEPT

create table dept(
    id number(2),
    nom  varchar2(14),
    loc  varchar2(13),
    constraint pk_dept 
        primary key(id)
);

-- Definició estructura taula EMPL

create table empl(
    id 	number(4),
    nom  	varchar2(16),
    ofici	varchar2(10),
    dir  	number(4),
    datalt   date,
    salari   number(11,2),
    comissio number(11,2),
    dept_id number(2),

    constraint pk_empl
        primary key(id),
     constraint fk_empl_dept_id
        foreign key (dept_id)
        references dept(id),
    constraint fk_empl_dir
        foreign key (dir)
        references empl(id)
);

desc empl;
-- Inserció de dades a la taula DEPT

insert into dept values (10,'Comptabilitat','Sevilla');
insert into dept values (20,'Investigacio','Madrid');
insert into dept values (30,'Vendes','Barcelona');
insert into dept values (40,'Produccio','Bilbao');
insert into dept values (50,'Testing','Girona');

-- Insercci de dades a la taula EMPL
insert into empl values
(7839,'REY','PRESIDENT',null,to_date('17-11-1981','dd-mm-yyyy'),650000,null,10);
insert into empl values
(7566,'JIMENEZ','DIRECTOR',7839,to_date('02-04-1981','dd-mm-yyyy'),386750,null,20);
insert into empl values
(7902,'FERNANDEZ','ANALISTA',7566,to_date('03-12-1981','dd-mm-yyyy'),390000,null,20);
insert into empl values
(7369,'SANCHEZ','EMPLEAT',7902,to_date('17-12-1980','dd-mm-yyyy'),104000,null,20);
insert into empl values
(7698,'NEGRO','DIRECTOR',7839,to_date('01-05-1981','dd-mm-yyyy'),370500,null,30);
insert into empl values
(7782,'CEREZO','DIRECTOR',7839,to_date('09-06-1981','dd-mm-yyyy'),318500,null,10);
insert into empl values
(7499,'ARROYO','VENEDOR',7698,to_date('22-02-1981','dd-mm-yyyy'),208000,39000,30);
insert into empl values
(7521,'SALA','VENEDOR',7698,to_date('22-02-1981','dd-mm-yyyy'),162500,65000,30);
insert into empl values
(7654,'MARTIN','VENEDOR',7698,to_date('28-09-1981','dd-mm-yyyy'),182000,182000,30);
insert into empl values
(7788,'GIL','ANALISTA',7566,to_date('30-03-1987','dd-mm-yyyy'),390000,null,20);
insert into empl values
(7844,'TOVAR','VENEDOR',7698,to_date('08-09-1981','dd-mm-yyyy'),195000,0,30);
insert into empl values
(7876,'ALONSO','EMPLEAT',7788,to_date('03-05-1987','dd-mm-yyyy'),143000,null,20);
insert into empl values
(7900,'JIMENO','EMPLEAT',7698,to_date('03-12-1981','dd-mm-yyyy'),123500,null,30);
insert into empl values
(7934,'MUNOZ','EMPLEAT',7782,to_date('23-01-1982','dd-mm-yyyy'),169000,null,10);
insert into empl values
(8100,'ARNAU','EMPLEAT',7902,to_date('14-12-2023','dd-mm-yyyy'),24000,null,null);
-- Confirmar els canvis
commit;
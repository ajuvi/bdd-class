SET AUTOCOMMIT OFF

drop table dept cascade constraints;   
drop table empl cascade constraints;

-- Definició estructura taula DEPT

create table dept(
    id number(2),
    nom  varchar2(14) not null,
    loc  varchar2(13),
    constraint pk_dept 
        primary key(id)
);

-- Definició estructura taula EMPL

create table empl(
    id 	number(4),
    nom  	varchar2(16) not null,
    ofici	varchar2(10),
    dir  	number(4),
    datalt   date default sysdate,
    datanaix   date not null,
    salari   number(11,2),
    comissio number(11,2),
    dept_id number(2),
    actiu number(1),

    constraint pk_empl
        primary key(id),
     constraint fk_empl_dept_id
        foreign key (dept_id)
        references dept(id),
    constraint fk_empl_dir
        foreign key (dir)
        references empl(id),
    constraint ck_actiu
        CHECK(actiu IN (0,1))
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
(7839,'REY','PRESIDENT',null,to_date('17-11-1981','dd-mm-yyyy'),to_date('01-12-1960','dd-mm-yyyy'),650000,null,10,default);
insert into empl values
(7566,'JIMENEZ','DIRECTOR',7839,to_date('02-04-1981','dd-mm-yyyy'),to_date('11-11-1965','dd-mm-yyyy'),386750,null,20,default);
insert into empl values
(7902,'FERNANDEZ','ANALISTA',7566,to_date('03-12-1998','dd-mm-yyyy'),to_date('17-11-1977','dd-mm-yyyy'),390000,null,20,default);
insert into empl values
(7369,'SANCHEZ','EMPLEAT',7902,to_date('17-12-1980','dd-mm-yyyy'),to_date('20-01-1950','dd-mm-yyyy'),104000,null,20,default);
insert into empl values
(7698,'NEGRO','DIRECTOR',7839,to_date('01-05-1981','dd-mm-yyyy'),to_date('23-11-1955','dd-mm-yyyy'),370500,null,30,default);
insert into empl values
(7782,'CEREZO','DIRECTOR',7839,to_date('09-06-1981','dd-mm-yyyy'),to_date('02-02-1967','dd-mm-yyyy'),318500,null,10,default);
insert into empl values
(7499,'ARROYO','VENEDOR',7698,to_date('22-02-1981','dd-mm-yyyy'),to_date('01-01-1939','dd-mm-yyyy'),208000,39000,30,default);
insert into empl values
(7521,'SALA','VENEDOR',7698,to_date('22-02-2020','dd-mm-yyyy'),to_date('20-03-1977','dd-mm-yyyy'),162500,65000,30,default);
insert into empl values
(7654,'MARTIN','VENEDOR',7698,to_date('23-09-2015','dd-mm-yyyy'),to_date('12-09-1988','dd-mm-yyyy'),182000,182000,30,default);
insert into empl values
(7788,'GIL','ANALISTA',7566,to_date('30-03-1999','dd-mm-yyyy'),to_date('17-10-1975','dd-mm-yyyy'),390000,null,20,default);
insert into empl values
(7844,'TOVAR','VENEDOR',7698,to_date('08-09-2009','dd-mm-yyyy'),to_date('18-11-1978','dd-mm-yyyy'),195000,0,30,default);
insert into empl values
(7876,'ALONSO','EMPLEAT',7788,to_date('03-05-2005','dd-mm-yyyy'),to_date('09-09-1981','dd-mm-yyyy'),143000,null,20,default);
insert into empl values
(7900,'JIMENO','EMPLEAT',7698,to_date('03-12-2004','dd-mm-yyyy'),to_date('20-07-1979','dd-mm-yyyy'),123500,null,30,default);
insert into empl values
(7934,'MUNOZ','EMPLEAT',7782,to_date('23-01-2016','dd-mm-yyyy'),to_date('11-12-1988','dd-mm-yyyy'),169000,null,10,default);
insert into empl values
(8100,'ARNAU','EMPLEAT',7902,to_date('14-12-2023','dd-mm-yyyy'),to_date('13-04-1998','dd-mm-yyyy'),24000,null,null,default);
insert into empl values
(8200,'ALBA','EMPLEAT',null,to_date('14-12-2023','dd-mm-yyyy'),to_date('11-08-1981','dd-mm-yyyy'),1000000,null,null,default);

-- Confirmar els canvis
commit;
DROP TABLE REGIONS CASCADE CONSTRAINTS;
DROP TABLE COUNTRIES CASCADE CONSTRAINTS;
DROP TABLE JOBS CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEES CASCADE CONSTRAINTS;
DROP TABLE LOCATIONS CASCADE CONSTRAINTS;
DROP TABLE DEPARTMENTS CASCADE CONSTRAINTS;
DROP TABLE JOB_HISTORY CASCADE CONSTRAINTS;

CREATE TABLE  "REGIONS" 
   (	"REGION_ID" NUMBER CONSTRAINT "REGION_ID_NN" NOT NULL ENABLE, 
	"REGION_NAME" VARCHAR2(25), 
	 CONSTRAINT "REG_ID_PK" PRIMARY KEY ("REGION_ID") ENABLE
   );
CREATE TABLE  "COUNTRIES" 
   (	"COUNTRY_ID" CHAR(2) CONSTRAINT "COUNTRY_ID_NN" NOT NULL ENABLE, 
	"COUNTRY_NAME" VARCHAR2(40), 
	"REGION_ID" NUMBER, 
	 CONSTRAINT "COUNTRY_C_ID_PK" PRIMARY KEY ("COUNTRY_ID") ENABLE, 
	 CONSTRAINT "COUNTR_REG_FK" FOREIGN KEY ("REGION_ID")
	  REFERENCES  "REGIONS" ("REGION_ID") ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS;
CREATE TABLE  "JOBS" 
   (	"JOB_ID" VARCHAR2(10), 
	"JOB_TITLE" VARCHAR2(35) CONSTRAINT "JOB_TITLE_NN" NOT NULL ENABLE, 
	"MIN_SALARY" NUMBER(6,0), 
	"MAX_SALARY" NUMBER(6,0), 
	 CONSTRAINT "JOB_ID_PK" PRIMARY KEY ("JOB_ID") ENABLE
   );
CREATE TABLE  "EMPLOYEES" 
   (	"EMPLOYEE_ID" NUMBER(6,0), 
	"FIRST_NAME" VARCHAR2(20), 
	"LAST_NAME" VARCHAR2(25) CONSTRAINT "EMP_LAST_NAME_NN" NOT NULL ENABLE, 
	"EMAIL" VARCHAR2(25) CONSTRAINT "EMP_EMAIL_NN" NOT NULL ENABLE, 
	"PHONE_NUMBER" VARCHAR2(20), 
	"HIRE_DATE" DATE CONSTRAINT "EMP_HIRE_DATE_NN" NOT NULL ENABLE, 
	"JOB_ID" VARCHAR2(10) CONSTRAINT "EMP_JOB_NN" NOT NULL ENABLE, 
	"SALARY" NUMBER(8,2), 
	"COMMISSION_PCT" NUMBER(2,2), 
	"MANAGER_ID" NUMBER(6,0), 
	"DEPARTMENT_ID" NUMBER(4,0), 
	 CONSTRAINT "EMP_SALARY_MIN" CHECK (salary > 0) ENABLE, 
	 CONSTRAINT "EMP_EMAIL_UK" UNIQUE ("EMAIL") ENABLE, 
	 CONSTRAINT "EMP_EMP_ID_PK" PRIMARY KEY ("EMPLOYEE_ID") ENABLE, 
	 CONSTRAINT "EMP_JOB_FK" FOREIGN KEY ("JOB_ID")
	  REFERENCES  "JOBS" ("JOB_ID") ENABLE, 
	 CONSTRAINT "EMP_MANAGER_FK" FOREIGN KEY ("MANAGER_ID")
	  REFERENCES  "EMPLOYEES" ("EMPLOYEE_ID") ENABLE
   );

CREATE TABLE  "LOCATIONS" 
   (	"LOCATION_ID" NUMBER(4,0), 
	"STREET_ADDRESS" VARCHAR2(40), 
	"POSTAL_CODE" VARCHAR2(12), 
	"CITY" VARCHAR2(30) CONSTRAINT "LOC_CITY_NN" NOT NULL ENABLE, 
	"STATE_PROVINCE" VARCHAR2(25), 
	"COUNTRY_ID" CHAR(2), 
	 CONSTRAINT "LOC_ID_PK" PRIMARY KEY ("LOCATION_ID") ENABLE, 
	 CONSTRAINT "LOC_C_ID_FK" FOREIGN KEY ("COUNTRY_ID")
	  REFERENCES  "COUNTRIES" ("COUNTRY_ID") ENABLE
   );
CREATE TABLE  "DEPARTMENTS" 
   (	"DEPARTMENT_ID" NUMBER(4,0), 
	"DEPARTMENT_NAME" VARCHAR2(30) CONSTRAINT "DEPT_NAME_NN" NOT NULL ENABLE, 
	"MANAGER_ID" NUMBER(6,0), 
	"LOCATION_ID" NUMBER(4,0), 
	 CONSTRAINT "DEPT_ID_PK" PRIMARY KEY ("DEPARTMENT_ID") ENABLE, 
	 CONSTRAINT "DEPT_LOC_FK" FOREIGN KEY ("LOCATION_ID")
	  REFERENCES  "LOCATIONS" ("LOCATION_ID") ENABLE, 
	 CONSTRAINT "DEPT_MGR_FK" FOREIGN KEY ("MANAGER_ID")
	  REFERENCES  "EMPLOYEES" ("EMPLOYEE_ID") ENABLE
   );

ALTER TABLE "EMPLOYEES"
ADD CONSTRAINT "EMP_DEPT_FK" FOREIGN KEY ("DEPARTMENT_ID")
	  REFERENCES  "DEPARTMENTS" ("DEPARTMENT_ID") ENABLE;


CREATE TABLE  "JOB_HISTORY" 
   (	"EMPLOYEE_ID" NUMBER(6,0) CONSTRAINT "JHIST_EMPLOYEE_NN" NOT NULL ENABLE, 
	"START_DATE" DATE CONSTRAINT "JHIST_START_DATE_NN" NOT NULL ENABLE, 
	"END_DATE" DATE CONSTRAINT "JHIST_END_DATE_NN" NOT NULL ENABLE, 
	"JOB_ID" VARCHAR2(10) CONSTRAINT "JHIST_JOB_NN" NOT NULL ENABLE, 
	"DEPARTMENT_ID" NUMBER(4,0), 
	 CONSTRAINT "JHIST_DATE_INTERVAL" CHECK (end_date > start_date) ENABLE, 
	 CONSTRAINT "JHIST_EMP_ID_ST_DATE_PK" PRIMARY KEY ("EMPLOYEE_ID", "START_DATE") ENABLE, 
	 CONSTRAINT "JHIST_JOB_FK" FOREIGN KEY ("JOB_ID")
	  REFERENCES  "JOBS" ("JOB_ID") ENABLE, 
	 CONSTRAINT "JHIST_EMP_FK" FOREIGN KEY ("EMPLOYEE_ID")
	  REFERENCES  "EMPLOYEES" ("EMPLOYEE_ID") ENABLE, 
	 CONSTRAINT "JHIST_DEPT_FK" FOREIGN KEY ("DEPARTMENT_ID")
	  REFERENCES  "DEPARTMENTS" ("DEPARTMENT_ID") ENABLE
   );


CREATE OR REPLACE PROCEDURE  "SECURE_DML" 
IS
BEGIN
  IF TO_CHAR (SYSDATE, 'HH24:MI') NOT BETWEEN '08:00' AND '18:00'
        OR TO_CHAR (SYSDATE, 'DY') IN ('SAT', 'SUN') THEN
	RAISE_APPLICATION_ERROR (-20205,
		'You may only make changes during normal office hours');
  END IF;
END secure_dml;
/
 CREATE OR REPLACE PROCEDURE  "ADD_JOB_HISTORY" 
  (  p_emp_id          job_history.employee_id%type
   , p_start_date      job_history.start_date%type
   , p_end_date        job_history.end_date%type
   , p_job_id          job_history.job_id%type
   , p_department_id   job_history.department_id%type
   )
IS
BEGIN
  INSERT INTO job_history (employee_id, start_date, end_date,
                           job_id, department_id)
    VALUES(p_emp_id, p_start_date, p_end_date, p_job_id, p_department_id);
END add_job_history;
/

DROP SEQUENCE LOCATIONS_SEQ;
  CREATE SEQUENCE   "LOCATIONS_SEQ"  MINVALUE 1 MAXVALUE 9900 INCREMENT BY 100 START WITH 3300 NOCACHE  NOORDER  NOCYCLE
/
DROP SEQUENCE EMPLOYEES_SEQ;
 CREATE SEQUENCE   "EMPLOYEES_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 207 NOCACHE  NOORDER  NOCYCLE
/
DROP SEQUENCE DEPARTMENTS_SEQ;
 CREATE SEQUENCE   "DEPARTMENTS_SEQ"  MINVALUE 1 MAXVALUE 9990 INCREMENT BY 10 START WITH 280 NOCACHE  NOORDER  NOCYCLE
/
CREATE OR REPLACE TRIGGER  "UPDATE_JOB_HISTORY" 
  AFTER UPDATE OF job_id, department_id ON employees
  FOR EACH ROW
BEGIN
  add_job_history(:old.employee_id, :old.hire_date, sysdate,
                  :old.job_id, :old.department_id);
END;
/
ALTER TRIGGER  "UPDATE_JOB_HISTORY" ENABLE
/
CREATE OR REPLACE TRIGGER  "SECURE_EMPLOYEES" 
  BEFORE INSERT OR UPDATE OR DELETE ON employees
BEGIN
  secure_dml;
END secure_employees;
/
ALTER TRIGGER  "SECURE_EMPLOYEES" DISABLE
/
CREATE OR REPLACE FORCE VIEW  "EMP_DETAILS_VIEW" ("EMPLOYEE_ID", "JOB_ID", "MANAGER_ID", "DEPARTMENT_ID", "LOCATION_ID", "COUNTRY_ID", "FIRST_NAME", "LAST_NAME", "SALARY", "COMMISSION_PCT", "DEPARTMENT_NAME", "JOB_TITLE", "CITY", "STATE_PROVINCE", "COUNTRY_NAME", "REGION_NAME") AS 
  SELECT
  e.employee_id,
  e.job_id,
  e.manager_id,
  e.department_id,
  d.location_id,
  l.country_id,
  e.first_name,
  e.last_name,
  e.salary,
  e.commission_pct,
  d.department_name,
  j.job_title,
  l.city,
  l.state_province,
  c.country_name,
  r.region_name
FROM
  employees e,
  departments d,
  jobs j,
  locations l,
  countries c,
  regions r
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id
  AND l.country_id = c.country_id
  AND c.region_id = r.region_id
  AND j.job_id = e.job_id
WITH READ ONLY
/

alter table departments disable constraint dept_mgr_fk cascade;

alter table employees disable constraint emp_dept_fk cascade;


INSERT INTO REGIONS VALUES(1,'Europe');
INSERT INTO REGIONS VALUES(2,'Americas');
INSERT INTO REGIONS VALUES(3,'Asia');
INSERT INTO REGIONS VALUES(4,'Middle East and Africa');


insert into countries values('CA','Canada',2);
insert into countries values('DE','Germany',1);
insert into countries values('UK','United Kingdom',1);
insert into countries values('US','United States of America',2);


INSERT INTO JOBS VALUES('AD_PRES','President',20000,40000);
INSERT INTO JOBS VALUES('AD_VP','Administration Vice President',15000,30000);
INSERT INTO JOBS VALUES('AD_ASST','Administration Assistant',3000,6000);
INSERT INTO JOBS VALUES('FI_MGR','Finance Manager',8200,16000);
INSERT INTO JOBS VALUES('FI_ACCOUNT','Accountant',4200,9000);
INSERT INTO JOBS VALUES('AC_MGR','Accounting Manager',8200,16000);
INSERT INTO JOBS VALUES('AC_ACCOUNT','Public Accountant',4200,9000);
INSERT INTO JOBS VALUES('SA_MAN','Sales Manager',10000,20000);
INSERT INTO JOBS VALUES('SA_REP','Sales Representative',6000,12000);
INSERT INTO JOBS VALUES('PU_MAN','Purchasing Manager',8000,15000);
INSERT INTO JOBS VALUES('PU_CLERK','Purchasing Clerk',2500,5500);
INSERT INTO JOBS VALUES('ST_MAN','Stock Manager',5500,8500);
INSERT INTO JOBS VALUES('ST_CLERK','Stock Clerk',2000,5000);
INSERT INTO JOBS VALUES('SH_CLERK','Shipping Clerk',2500,5500);
INSERT INTO JOBS VALUES('IT_PROG','Programmer',4000,10000);
INSERT INTO JOBS VALUES('MK_MAN','Marketing Manager',9000,15000);
INSERT INTO JOBS VALUES('MK_REP','Marketing Representative',4000,9000);
INSERT INTO JOBS VALUES('HR_REP','Human Resources Representative',4000,9000);
INSERT INTO JOBS VALUES('PR_REP','Public Relations Representative',4500,10500);

INSERT INTO LOCATIONS VALUES(1400,'2014 Jabberwocky Rd','26192','Southlake','Texas','US');
INSERT INTO LOCATIONS VALUES(1500,'2011 Interiors Blvd','99236','South San Francisco','California','US');
INSERT INTO LOCATIONS VALUES(1700,'2004 Charade Rd','98199','Seattle','Washington','US');
INSERT INTO LOCATIONS VALUES(1800,'147 Spadina Ave','M5V 2L7','Toronto','Ontario','CA');
INSERT INTO LOCATIONS VALUES(2500,'Magdalen Centre, The Oxford Science Park','OX9 9ZB','Oxford','Oxford','UK');


INSERT INTO DEPARTMENTS VALUES(10,'Administration',200,1700);
INSERT INTO DEPARTMENTS VALUES(20,'Marketing',201,1800);
INSERT INTO DEPARTMENTS VALUES(50,'Shipping',124,1500);
INSERT INTO DEPARTMENTS VALUES(60,'IT',103,1400);
INSERT INTO DEPARTMENTS VALUES(80,'Sales',149,2500);
INSERT INTO DEPARTMENTS VALUES(90,'Executive',100,1700);
INSERT INTO DEPARTMENTS VALUES(110,'Accounting',205,1700);
INSERT INTO DEPARTMENTS VALUES(190,'Contracting',NULL,1700);


INSERT INTO EMPLOYEES VALUES(100,'Steven','King','SKING','5151234567',TO_DATE('1987-06-17','YYYY-MM-DD'),'AD_PRES',24000,NULL,NULL,90);
INSERT INTO EMPLOYEES VALUES(101,'Neena','Kochhar','NKOCHHAR','5151234568',TO_DATE('1989-09-21','YYYY-MM-DD'),'AD_VP',17000,NULL,100,90);
INSERT INTO EMPLOYEES VALUES(102,'Lex','De Haan','LDEHAAN','5151234569',TO_DATE('1993-01-13','YYYY-MM-DD'),'AD_VP',17000,NULL,100,90);
INSERT INTO EMPLOYEES VALUES(103,'Alexander','Hunold','AHUNOLD','5904234567',TO_DATE('1990-01-03','YYYY-MM-DD'),'IT_PROG',9000,NULL,102,60);
INSERT INTO EMPLOYEES VALUES(104,'Bruce','Ernst','BERNST','5904234568',TO_DATE('1991-05-21','YYYY-MM-DD'),'IT_PROG',6000,NULL,103,60);
INSERT INTO EMPLOYEES VALUES(107,'Diana','Lorentz','DLORENTZ','5904235567',TO_DATE('1999-02-07','YYYY-MM-DD'),'IT_PROG',4200,NULL,103,60);
INSERT INTO EMPLOYEES VALUES(124,'Kevin','Mourgos','KMOURGOS','6501235234',TO_DATE('1999-11-16','YYYY-MM-DD'),'ST_MAN',5800,NULL,100,50);
INSERT INTO EMPLOYEES VALUES(141,'Trenna','Rajs','TRAJS','6501218009',TO_DATE('1995-10-17','YYYY-MM-DD'),'ST_CLERK',3500,NULL,124,50);
INSERT INTO EMPLOYEES VALUES(142,'Curtis','Davies','CDAVIES','6501212994',TO_DATE('1997-01-29','YYYY-MM-DD'),'ST_CLERK',3100,NULL,124,50);
INSERT INTO EMPLOYEES VALUES(143,'Randall','Matos','RMATOS','6501212874',TO_DATE('1998-03-15','YYYY-MM-DD'),'ST_CLERK',2600,NULL,124,50);
INSERT INTO EMPLOYEES VALUES(144,'Peter','Vargas','PVARGAS','6501212004',TO_DATE('1998-07-09','YYYY-MM-DD'),'ST_CLERK',2500,NULL,124,50);
INSERT INTO EMPLOYEES VALUES(149,'Eleni','Zlotkey','EZLOTKEY','011.44.1344.429018',TO_DATE('2000-01-29','YYYY-MM-DD'),'SA_MAN',10500,0.2,100,80);
INSERT INTO EMPLOYEES VALUES(174,'Ellen','Abel','EABEL','011.44.1644.429267',TO_DATE('1996-05-11','YYYY-MM-DD'),'SA_REP',11000,0.3,149,80);
INSERT INTO EMPLOYEES VALUES(176,'Jonathon','Taylor','JTAYLOR','011.44.1644.429265',TO_DATE('1998-03-24','YYYY-MM-DD'),'SA_REP',8600,0.2,149,80);
INSERT INTO EMPLOYEES VALUES(178,'Kimberely','Grant','KGRANT','011.44.1644.429263',TO_DATE('1999-05-24','YYYY-MM-DD'),'SA_REP',7000,0.15,149,NULL);
INSERT INTO EMPLOYEES VALUES(200,'Jennifer','Whalen','JWHALEN','5151234444',TO_DATE('1987-09-17','YYYY-MM-DD'),'AD_ASST',4400,NULL,101,10);
INSERT INTO EMPLOYEES VALUES(201,'Michael','Hartstein','MHARTSTE','5151235555',TO_DATE('1996-02-17','YYYY-MM-DD'),'MK_MAN',13000,NULL,100,20);
INSERT INTO EMPLOYEES VALUES(202,'Pat','Fay','PFAY','6031236666',TO_DATE('1997-08-17','YYYY-MM-DD'),'MK_REP',6000,NULL,201,20);
INSERT INTO EMPLOYEES VALUES(205,'Shelley','Higgins','SHIGGINS','5151238080',TO_DATE('1994-06-07','YYYY-MM-DD'),'AC_MGR',12000,NULL,101,110);
INSERT INTO EMPLOYEES VALUES(206,'William','Gietz','WGIETZ','5151238181',TO_DATE('1994-06-07','YYYY-MM-DD'),'AC_ACCOUNT',8300,NULL,205,110);



INSERT INTO JOB_HISTORY VALUES(102,TO_DATE('1993-01-13','YYYY-MM-DD'),TO_DATE('1998-07-24','YYYY-MM-DD'),'IT_PROG','60');
INSERT INTO JOB_HISTORY VALUES(101,TO_DATE('1989-09-21','YYYY-MM-DD'),TO_DATE('1993-10-27','YYYY-MM-DD'),'AC_ACCOUNT','110');
INSERT INTO JOB_HISTORY VALUES(101,TO_DATE('1993-10-28','YYYY-MM-DD'),TO_DATE('1997-03-15','YYYY-MM-DD'),'AC_MGR','110');
INSERT INTO JOB_HISTORY VALUES(201,TO_DATE('1996-02-17','YYYY-MM-DD'),TO_DATE('1999-12-19','YYYY-MM-DD'),'MK_REP','20');
INSERT INTO JOB_HISTORY VALUES(200,TO_DATE('1987-09-17','YYYY-MM-DD'),TO_DATE('1993-06-17','YYYY-MM-DD'),'AD_ASST','90');
INSERT INTO JOB_HISTORY VALUES(176,TO_DATE('1998-03-24','YYYY-MM-DD'),TO_DATE('1998-12-31','YYYY-MM-DD'),'SA_REP','80');
INSERT INTO JOB_HISTORY VALUES(176,TO_DATE('1999-01-01','YYYY-MM-DD'),TO_DATE('1999-12-31','YYYY-MM-DD'),'SA_MAN','80');
INSERT INTO JOB_HISTORY VALUES(200,TO_DATE('1994-07-01','YYYY-MM-DD'),TO_DATE('1998-12-31','YYYY-MM-DD'),'AC_ACCOUNT','90');



alter table departments enable constraint dept_mgr_fk;

alter table employees enable constraint emp_dept_fk;

commit;

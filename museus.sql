SET AUTOCOMMIT OFF

-- eliminar taules 

DROP TABLE turista CASCADE CONSTRAINTS;
DROP TABLE museu CASCADE CONSTRAINTS;
DROP TABLE visita CASCADE CONSTRAINTS;

-- crear taules

CREATE TABLE turista(
	id NUMBER(11) PRIMARY KEY,
	nom VARCHAR2(100),
	cog1 VARCHAR2(100),
	cog2 VARCHAR2(100)
);

CREATE TABLE museu(
	id NUMBER(11) PRIMARY KEY,
	nom VARCHAR2(100),
	ciutat VARCHAR2(100)
);

CREATE TABLE visita(
	museu_id NUMBER(11),
	turista_id NUMBER(11),
	data DATE DEFAULT SYSDATE,
	valoracio NUMBER(2),
	PRIMARY KEY(museu_id,turista_id,data),
	FOREIGN KEY(museu_id) REFERENCES museu(id),
	FOREIGN KEY(turista_id) REFERENCES turista(id)
);

--MUSEUS
INSERT INTO museu(id, nom, ciutat) VALUES (1,'Museu d''Art de Girona','Girona');
INSERT INTO museu(id, nom, ciutat) VALUES (2,'Museu del Cinema','Girona');
INSERT INTO museu(id, nom, ciutat) VALUES (3,'Museu Picasso de Barcelona','Barcelona');
INSERT INTO museu(id, nom, ciutat) VALUES (4,'Museu Nacional d''Art de Catalunya','Barcelona');
INSERT INTO museu(id, nom, ciutat) VALUES (5,'Museu Dalí','Figueres');
COMMIT;

--TURISTES
INSERT INTO turista(id,nom,cog1,cog2) VALUES (1,'Carmen','Rojo','Del Hoyo');
INSERT INTO turista(id,nom,cog1,cog2) VALUES (2,'Óscar','Pastor','Ibáñez');
INSERT INTO turista(id,nom,cog1,cog2) VALUES (3,'Antonia','Márquez','Delgado');
INSERT INTO turista(id,nom,cog1,cog2) VALUES (4,'Óscar','González','Rodríguez');
INSERT INTO turista(id,nom,cog1,cog2) VALUES (5,'María','Rodríguez','Castellano');
INSERT INTO turista(id,nom,cog1,cog2) VALUES (6,'Marta','Espí','Rico');
INSERT INTO turista(id,nom,cog1,cog2) VALUES (7,'María','Pérez','Morante');
INSERT INTO turista(id,nom,cog1,cog2) VALUES (8,'Carlos','Ruiz','González');
INSERT INTO turista(id,nom,cog1,cog2) VALUES (9,'María Carmen','Casado','Crespo');
INSERT INTO turista(id,nom,cog1,cog2) VALUES (10,'Juan Carlos','Zamora','Ramos');
INSERT INTO turista(id,nom,cog1,cog2) VALUES (11,'Carmen','Olmedo','Vázquez');
INSERT INTO turista(id,nom,cog1,cog2) VALUES (12,'José Luis','Lafuente','Coca');
INSERT INTO turista(id,nom,cog1,cog2) VALUES (13,'María Carmen','Martin','Jiménez');
INSERT INTO turista(id,nom,cog1,cog2) VALUES (14,'Raquel','López','Ledesma');
INSERT INTO turista(id,nom,cog1,cog2) VALUES (15,'Emilia','Salamanca','Salazar');
INSERT INTO turista(id,nom,cog1,cog2) VALUES (16,'Miguel','Gil','Bonilla');
INSERT INTO turista(id,nom,cog1,cog2) VALUES (17,'Carmen','Herrera','Martínez');
INSERT INTO turista(id,nom,cog1,cog2) VALUES (18,'Juan José','Chica','Roig');
INSERT INTO turista(id,nom,cog1,cog2) VALUES (19,'Manuel','Martínez','Rodríguez');
INSERT INTO turista(id,nom,cog1,cog2) VALUES (20,'María','Corbalán','Gázquez');
COMMIT;

--VISITES
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,2,TO_DATE('23/07/2023','DD/MM/YYYY'),4);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,13,TO_DATE('30/07/2023','DD/MM/YYYY'),7);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,7,TO_DATE('10/04/2022','DD/MM/YYYY'),1);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,2,TO_DATE('05/12/2023','DD/MM/YYYY'),6);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,18,TO_DATE('01/10//2021','DD/MM/YYYY'),8);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,6,TO_DATE('03/05/2023','DD/MM/YYYY'),8);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (1,5,TO_DATE('02/08/2023','DD/MM/YYYY'),4);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,12,TO_DATE('11/05//2021','DD/MM/YYYY'),5);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,2,TO_DATE('24/01/2022','DD/MM/YYYY'),8);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,2,TO_DATE('08/04/2023','DD/MM/YYYY'),9);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (1,8,TO_DATE('12/09/2023','DD/MM/YYYY'),4);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,20,TO_DATE('17/11//2021','DD/MM/YYYY'),10);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,8,TO_DATE('19/01/2023','DD/MM/YYYY'),9);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,1,TO_DATE('18/09/2023','DD/MM/YYYY'),7);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,12,TO_DATE('16/05/2023','DD/MM/YYYY'),9);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,3,TO_DATE('23/07//2021','DD/MM/YYYY'),2);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (1,10,TO_DATE('24/04/2023','DD/MM/YYYY'),2);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,3,TO_DATE('27/11/2022','DD/MM/YYYY'),4);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,7,TO_DATE('25/04//2021','DD/MM/YYYY'),0);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (1,7,TO_DATE('11/09//2021','DD/MM/YYYY'),4);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,1,TO_DATE('13/06/2022','DD/MM/YYYY'),6);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,14,TO_DATE('07/09/2022','DD/MM/YYYY'),9);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (5,20,TO_DATE('01/05//2021','DD/MM/YYYY'),1);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (1,10,TO_DATE('18/06//2021','DD/MM/YYYY'),1);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (1,19,TO_DATE('03/05/2023','DD/MM/YYYY'),1);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,11,TO_DATE('23/07/2023','DD/MM/YYYY'),6);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,20,TO_DATE('27/05/2022','DD/MM/YYYY'),2);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,18,TO_DATE('31/12//2021','DD/MM/YYYY'),8);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,15,TO_DATE('16/02/2022','DD/MM/YYYY'),2);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (5,5,TO_DATE('05/06/2022','DD/MM/YYYY'),1);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,13,TO_DATE('18/08/2023','DD/MM/YYYY'),7);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,16,TO_DATE('23/10//2021','DD/MM/YYYY'),5);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (5,13,TO_DATE('29/05//2021','DD/MM/YYYY'),8);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,15,TO_DATE('17/11/2022','DD/MM/YYYY'),0);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,1,TO_DATE('03/04/2023','DD/MM/YYYY'),3);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,10,TO_DATE('03/07/2022','DD/MM/YYYY'),10);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (1,20,TO_DATE('09/12/2023','DD/MM/YYYY'),4);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,17,TO_DATE('21/01//2021','DD/MM/YYYY'),4);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,13,TO_DATE('23/10/2023','DD/MM/YYYY'),7);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,4,TO_DATE('28/09/2022','DD/MM/YYYY'),7);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (5,11,TO_DATE('05/09/2022','DD/MM/YYYY'),1);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,8,TO_DATE('24/09/2022','DD/MM/YYYY'),7);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,16,TO_DATE('21/06/2022','DD/MM/YYYY'),5);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,5,TO_DATE('19/12/2022','DD/MM/YYYY'),3);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,2,TO_DATE('04/04/2022','DD/MM/YYYY'),2);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,10,TO_DATE('20/09/2022','DD/MM/YYYY'),2);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,1,TO_DATE('24/10/2022','DD/MM/YYYY'),1);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,8,TO_DATE('18/06/2023','DD/MM/YYYY'),6);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,16,TO_DATE('26/06//2021','DD/MM/YYYY'),2);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (1,4,TO_DATE('22/04//2021','DD/MM/YYYY'),2);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,3,TO_DATE('06/01//2021','DD/MM/YYYY'),8);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,4,TO_DATE('05/11/2023','DD/MM/YYYY'),10);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (5,1,TO_DATE('14/03/2023','DD/MM/YYYY'),2);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,6,TO_DATE('07/09//2021','DD/MM/YYYY'),6);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (1,11,TO_DATE('06/08/2022','DD/MM/YYYY'),5);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,20,TO_DATE('01/12/2023','DD/MM/YYYY'),4);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,7,TO_DATE('30/03//2021','DD/MM/YYYY'),6);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (1,6,TO_DATE('07/07//2021','DD/MM/YYYY'),9);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,14,TO_DATE('13/12/2022','DD/MM/YYYY'),4);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (5,13,TO_DATE('03/02/2022','DD/MM/YYYY'),5);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,5,TO_DATE('05/02//2021','DD/MM/YYYY'),9);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,17,TO_DATE('23/12/2023','DD/MM/YYYY'),6);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,5,TO_DATE('31/08/2022','DD/MM/YYYY'),4);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,2,TO_DATE('31/03//2021','DD/MM/YYYY'),6);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,12,TO_DATE('24/10//2021','DD/MM/YYYY'),3);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,5,TO_DATE('14/02/2023','DD/MM/YYYY'),3);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (1,12,TO_DATE('26/11/2023','DD/MM/YYYY'),1);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,5,TO_DATE('15/06/2022','DD/MM/YYYY'),9);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,6,TO_DATE('15/10//2021','DD/MM/YYYY'),5);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (1,12,TO_DATE('17/03/2023','DD/MM/YYYY'),3);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (5,7,TO_DATE('09/05/2022','DD/MM/YYYY'),6);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,6,TO_DATE('26/04//2021','DD/MM/YYYY'),4);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,18,TO_DATE('04/12//2021','DD/MM/YYYY'),8);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,9,TO_DATE('29/09/2022','DD/MM/YYYY'),3);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,1,TO_DATE('09/09//2021','DD/MM/YYYY'),10);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (5,4,TO_DATE('21/09/2023','DD/MM/YYYY'),8);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (1,13,TO_DATE('12/07/2022','DD/MM/YYYY'),3);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,13,TO_DATE('03/12/2022','DD/MM/YYYY'),1);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (5,15,TO_DATE('01/11//2021','DD/MM/YYYY'),4);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (1,11,TO_DATE('25/03//2021','DD/MM/YYYY'),10);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,12,TO_DATE('25/09/2023','DD/MM/YYYY'),1);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,11,TO_DATE('24/11//2021','DD/MM/YYYY'),5);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,15,TO_DATE('05/01/2022','DD/MM/YYYY'),8);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,17,TO_DATE('26/09//2021','DD/MM/YYYY'),1);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (5,7,TO_DATE('16/10/2022','DD/MM/YYYY'),1);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,15,TO_DATE('14/11/2023','DD/MM/YYYY'),10);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (5,15,TO_DATE('22/10/2022','DD/MM/YYYY'),10);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,3,TO_DATE('11/09/2023','DD/MM/YYYY'),7);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,6,TO_DATE('22/06/2023','DD/MM/YYYY'),2);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,9,TO_DATE('19/11//2021','DD/MM/YYYY'),1);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,10,TO_DATE('04/11//2021','DD/MM/YYYY'),9);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (5,11,TO_DATE('18/03/2023','DD/MM/YYYY'),8);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,6,TO_DATE('25/07/2023','DD/MM/YYYY'),4);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (5,15,TO_DATE('11/03//2021','DD/MM/YYYY'),10);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,7,TO_DATE('25/08//2021','DD/MM/YYYY'),0);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,2,TO_DATE('06/03/2023','DD/MM/YYYY'),1);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,6,TO_DATE('19/04/2023','DD/MM/YYYY'),8);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,14,TO_DATE('07/09/2023','DD/MM/YYYY'),4);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,14,TO_DATE('03/02/2023','DD/MM/YYYY'),5);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (5,19,TO_DATE('24/04/2023','DD/MM/YYYY'),2);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (1,4,TO_DATE('18/09/2022','DD/MM/YYYY'),2);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (1,10,TO_DATE('26/01/2022','DD/MM/YYYY'),10);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,19,TO_DATE('30/03//2021','DD/MM/YYYY'),3);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (4,19,TO_DATE('10/12//2021','DD/MM/YYYY'),10);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (2,1,TO_DATE('27/09/2022','DD/MM/YYYY'),8);
INSERT INTO visita(museu_id,turista_id,data,valoracio) VALUES (3,3,TO_DATE('02/09//2021','DD/MM/YYYY'),3);
COMMIT;
/*Eliminar Taula logs*/
DROP SEQUENCE seq_logs;
DROP TABLE logs CASCADE CONSTRAINTS;

/*Crear Taula logs*/
CREATE TABLE logs (
    id NUMBER(11),
    tipus VARCHAR2(20) DEFAULT '',
    missatge VARCHAR2(200),
    data DATE DEFAULT SYSDATE,

    CONSTRAINT pk_logs PRIMARY KEY(id)
);

/*Creació sequencia de logs*/
CREATE SEQUENCE seq_logs
    INCREMENT BY 1
    START WITH 1;

/*Creació trigger*/
CREATE OR REPLACE TRIGGER trig_logs
  BEFORE INSERT ON logs
  FOR EACH ROW
BEGIN
    :NEW.id := seq_logs.NEXTVAL;
END;
/

/* paquet pkg_logs */
CREATE OR REPLACE PACKAGE pkg_logs AS
    /*procediment per a afegir nous logs*/
    PROCEDURE log (p_missatge logs.missatge%TYPE);
    PROCEDURE error (p_missatge logs.missatge%TYPE);    
    PROCEDURE warn (p_missatge logs.missatge%TYPE);   
    
    /*procediment per a mostrar els logs*/
    --PROCEDURE print (p_id logs.id%TYPE);   
    --PROCEDURE llistar (p_numLogs NUMBER);
    --PROCEDURE llistar (p_numLogs NUMBER,p_tipus logs.tipus%TYPE);     
END pkg_logs;
/

CREATE OR REPLACE PACKAGE BODY pkg_logs 
AS
    PROCEDURE priv_log (p_tipus logs.tipus%TYPE,p_missatge logs.missatge%TYPE)
    AS  
    BEGIN    
        INSERT INTO logs (id, tipus, missatge, data) VALUES (seq_logs.NEXTVAL ,p_tipus, p_missatge, default);
    END;

    PROCEDURE log (p_missatge logs.missatge%TYPE)
    AS  
    BEGIN    
        pkg_logs.priv_log ('info',p_missatge);
    END;

    PROCEDURE error (p_missatge logs.missatge%TYPE)
    AS  
    BEGIN    
        pkg_logs.priv_log ('error',p_missatge);
    END;

    PROCEDURE warn (p_missatge logs.missatge%TYPE)
    AS  
    BEGIN    
        pkg_logs.priv_log ('warn',p_missatge);
    END;

END pkg_logs;
/

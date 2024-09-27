import cx_Oracle
import os

usuari = "system"
password = "12345"
port=1521
host="127.0.0.1"
sid="xe"

#conn = cx_Oracle.connect(f'{usuari}/{password}@{host}:{port}/{sid}')
#cx_Oracle.init_oracle_client(lib_dir=r'../instantclient_21_12')

def execute_query(sql):
    resultat = None
    try:
        with cx_Oracle.connect(f'{usuari}/{password}@{host}:{port}/{sid}') as conn:
            with conn.cursor() as cursor:    
                cursor = conn.cursor()
                cursor.execute(sql)
                resultat = cursor.fetchall()
    except:
        pass

    return resultat


#print(execute_query("SELECT * FROM animal"));
from db import execute_query

version = execute_query("SELECT * FROM v$version")
print(version)

print()

paraules = execute_query("SELECT id, paraula FROM diccionari WHERE id<=10")
print(paraules)
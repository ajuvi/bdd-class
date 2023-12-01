from db import execute_query

version = execute_query("SELECT * FROM v$version")
print(version)

animals = execute_query("SELECT * FROM animal")
print(animals)
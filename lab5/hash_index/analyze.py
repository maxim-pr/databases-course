import psycopg2


conn = psycopg2.connect(dbname="customers", user="postgres",
                        password="postgres", host="localhost", port="5432")
cursor = conn.cursor()

# get 2 rows
cursor.execute("SELECT name FROM customer WHERE id = 80000 OR id = 90000")
name1 = cursor.fetchone()[0]
name2 = cursor.fetchone()[0]

# analyze cost
cursor.execute("EXPLAIN ANALYZE SELECT * FROM customer WHERE name = %s OR name = %s", (name1, name2))

for el in cursor.fetchall():
    print(el[0])

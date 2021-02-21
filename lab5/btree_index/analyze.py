import psycopg2


conn = psycopg2.connect(dbname="customers", user="postgres",
                        password="postgres", host="localhost", port="5432")
cursor = conn.cursor()

cursor.execute("EXPLAIN ANALYZE SELECT * FROM customer WHERE age > 10 AND age < 30;")

for el in cursor.fetchall():
    print(el[0])

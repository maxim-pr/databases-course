import psycopg2
from faker import Faker


conn = psycopg2.connect(dbname="customers", user="postgres",
                        password="postgres", host="localhost", port="5432")
cursor = conn.cursor()

# create table
cursor.execute('''
    CREATE TABLE customer (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        age SMALLINT NOT NULL,
        address VARCHAR(255) NOT NULL,
        review TEXT
    );
''')
conn.commit()

# populate table with data
faker = Faker()

for i in range(100000):
    cursor.execute('''
        INSERT INTO customer (name, age, address, review)
        VALUES (%s, %s, %s, %s)
    ''', (faker.name(), faker.random_int(0, 100), faker.address(), faker.text()))
    conn.commit()

cursor.close()
conn.close()

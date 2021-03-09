import psycopg2
from geopy.geocoders import Nominatim


conn = psycopg2.connect(dbname="dvdrental", user="postgres",
						password="postgres", host="localhost", port="5432")
cursor = conn.cursor()

# create function
cursor.execute('''
	CREATE OR REPLACE FUNCTION get_address()
	RETURNS table(id INTEGER, address VARCHAR(50))
	LANGUAGE plpgsql
	AS
	$$
	BEGIN
		RETURN QUERY
		SELECT address.address_id, address.address
		FROM address
		WHERE (address.address LIKE '%11%') AND (address.address_id BETWEEN 400 AND 600);
	END
	$$;
''')

# add columns to table
cursor.execute('''
	ALTER TABLE address
	ADD COLUMN IF NOT EXISTS latitude REAL,
	ADD COLUMN IF NOT EXISTS longitude REAL;
''')

# call function
cursor.callproc("get_address", ())
data = cursor.fetchall()

# insert latitude and longitude for every retreived address into table
geocoder = Nominatim(user_agent="test")

for id_, address in data:
	location = geocoder.geocode(address)
	latitude = 0
	longitude = 0
	
	if not location is None:
		latitude = location.latitude
		longitude = location.longitude
	
	cursor.execute('''
		UPDATE address
		SET longitude = %s, latitude = %s
		WHERE address_id = %s;
	''', (longitude, latitude, id_))

	conn.commit()



cursor.close()
conn.close()

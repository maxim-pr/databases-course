-- view that returns all russian customers

CREATE OR REPLACE VIEW russian_customers AS
    SELECT first_name, last_name, country 
    FROM customer
        LEFT JOIN address ON customer.address_id = address.address_id
        LEFT JOIN city ON address.city_id = city.city_id
        LEFT JOIN country ON country.country_id = city.country_id
    WHERE country = 'Russian Federation';

-- test
SELECT first_name, last_name, country FROM russian_customers;



-- view that returns info about actors that took part in horror films

CREATE OR REPLACE VIEW horror_film_actors AS
	SELECT a.actor_id, first_name, last_name, fa.film_id
	FROM actor a
		LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
		LEFT JOIN film_category fc ON fa.film_id = fc.film_id
		LEFT JOIN category ON fc.category_id = category.category_id
	WHERE category.name = 'Horror';

-- test
SELECT actor_id, first_name, last_name, film_id FROM horror_film_actors
ORDER BY actor_id;


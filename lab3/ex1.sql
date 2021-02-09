-- 1) Order countries by id asc, then show the 12th to 17th rows
SELECT * FROM country ORDER BY country_id ASC 
OFFSET 11 LIMIT 6;


-- 2) List all addresses in a city whose name starts with 'A’
SELECT address, city 
FROM address 
    LEFT JOIN city ON address.city_id = city.city_id
    WHERE upper(city) LIKE 'A%';


-- 3) List all customers' first name, last name and the city they live in
SELECT first_name, last_name, city 
FROM customer
    LEFT JOIN address ON customer.address_id = address.address_id
    LEFT JOIN city ON address.city_id = city.city_id;


-- 4) Find all customers with at least one payment whose amount is greater than 11 dollars
SELECT customer.customer_id, first_name, last_name, amount
FROM customer 
    INNER JOIN payment ON payment.customer_id = customer.customer_id
WHERE amount > 11; 


-- 5) Find all duplicated first names in the customer table
-- variant 1
SELECT DISTINCT c1.first_name
	FROM customer c1
    	INNER JOIN customer c2
        	ON c1.first_name = c2.first_name AND c1.customer_id != c2.customer_id;

-- variant 2
SELECT first_name FROM
	(SELECT * FROM customer
	EXCEPT 
	SELECT DISTINCT ON (first_name) * FROM customer) as subq;


SELECT c.first_name, c.last_name, f.title
FROM
-- subquery returns table with all the unrented movies for each customer 
(
	-- 1st select: get cross product between customers and movies
	SELECT customer_id, film_id
	FROM customer CROSS JOIN film

	EXCEPT
	
	-- 2nd select: for each customer get all the movies that he/she rented  
	SELECT c.customer_id, i.film_id
	FROM customer c
		JOIN rental r ON c.customer_id = r.customer_id
		JOIN inventory i ON r.inventory_id = i.inventory_id
) AS subq
	JOIN customer c ON subq.customer_id = c.customer_id
	JOIN film f ON subq.film_id = f.film_id
	JOIN film_category fc ON f.film_id = fc.film_id
WHERE (f.rating = 'R' OR f.rating = 'PG-13') 
	AND (fc.category_id = 11 OR fc.category_id = 14);
	
-- category_id=11 corresponds to Horror,
-- category_id=14 corresponds to Sci-Fi

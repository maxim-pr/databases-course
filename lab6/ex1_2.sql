SELECT store.store_id, SUM(payment.amount)
FROM store
	JOIN staff ON store.store_id = staff.store_id
	JOIN payment ON staff.staff_id = payment.staff_id
WHERE (to_char(payment.payment_date, 'YYYY'), to_char(payment.payment_date, 'MM')) = 
	(
		SELECT to_char(payment_date, 'YYYY') AS year, to_char(payment_date, 'MM') AS month
		FROM payment
		ORDER BY year DESC, month DESC
		LIMIT 1
	)
GROUP BY store.store_id;

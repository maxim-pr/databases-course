-- trigger which checks the payment to be inserted or updated whether its corresponding customer is active

CREATE OR REPLACE FUNCTION public.check_payment()
	RETURNS trigger
	LANGUAGE PLPGSQL
	AS
$$
DECLARE
	is_active INTEGER;
BEGIN
	SELECT active INTO is_active FROM customer
		WHERE NEW.customer_id = customer.customer_id;
	IF (is_active = 0) THEN
		RAISE EXCEPTION 'Customer is not active';
	END IF;
	
	RETURN NULL;
END;
$$;

CREATE TRIGGER check_payment_trigger2
	BEFORE INSERT OR UPDATE
	ON public.payment
	FOR EACH ROW
	EXECUTE PROCEDURE public.check_payment();

-- test trigger
UPDATE payment SET amount = 100 WHERE payment_id = 18554;

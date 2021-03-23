ALTER TABLE account
ADD COLUMN bank_name VARCHAR(50); 


UPDATE account
SET bank_name = 'SberBank'
WHERE id = 1 OR id = 3;

UPDATE account
SET bank_name = 'Tinkoff'
WHERE id = 2;

INSERT INTO account (name, credit, bank_name)
VALUES ('Fees', 0, 'SberBank');

INSERT INTO account (name, credit, bank_name)
VALUES ('Fees', 0, 'Tinkoff');


-- function to performt transaction
CREATE OR REPLACE FUNCTION transact(id_from INTEGER, id_to INTEGER, amount INTEGER)
RETURNS void
AS $$
DECLARE
	bank_name_from VARCHAR(50);
	bank_name_to VARCHAR(50);
BEGIN
	-- retreive money
	UPDATE account
	SET credit = credit - amount
	WHERE id = id_from;
	
	-- send money
	UPDATE account
	SET credit = credit + amount
	WHERE id = id_to;
	
	-- get bank names of the accounts
	SELECT bank_name FROM account 
	WHERE id = id_from
	INTO bank_name_from;
	
	SELECT bank_name FROM account 
	WHERE id = id_to
	INTO bank_name_to;
	
	-- apply fee if banks are different
	IF bank_name_from != bank_name_to THEN
        UPDATE account
		SET credit = credit - 30
		WHERE id = id_from;
		
		UPDATE account
		SET credit = credit + 30
		WHERE name = 'Fees' AND bank_name = bank_name_from;
    END IF;
END
$$
LANGUAGE 'plpgsql';


-- account 1 send 500 RUB to account 3
BEGIN;
SELECT * FROM account;
SELECT * FROM transact(1, 3, 500);
SELECT * FROM account;
ROLLBACK;

-- account 2 send 700 RUB to account 1
BEGIN;
SELECT * FROM account;
SELECT * FROM transact(2, 1, 700);
SELECT * FROM account;
ROLLBACK;

-- account 2 send 100 RUB to account 3
BEGIN;
SELECT * FROM account;
SELECT * FROM transact(2, 3, 100);
SELECT * FROM account;
ROLLBACK;

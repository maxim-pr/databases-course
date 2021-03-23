CREATE TABLE account
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    credit INTEGER NOT NULL
);


INSERT INTO account (name, credit) VALUES ('Ivan', 1000);
INSERT INTO account (name, credit) VALUES ('Petr', 1000);
INSERT INTO account (name, credit) VALUES ('Vova', 1000);



-- account 1 sends 500 RUB to account 3
BEGIN TRANSACTION;

UPDATE account
SET credit = credit - 500
WHERE id = 1;

UPDATE account
SET credit = credit + 500
WHERE id = 3;

SELECT * FROM account;

ROLLBACK TRANSACTION;


-- account 2 sends 700 RUB to account 1

BEGIN TRANSACTION;

UPDATE account
SET credit = credit - 700
WHERE id = 2;

UPDATE account
SET credit = credit + 700
WHERE id = 1;

SELECT * FROM account;

ROLLBACK TRANSACTION;


-- account 2 sends 100 RUB to account 3

BEGIN TRANSACTION;

UPDATE account
SET credit = credit - 100
WHERE id = 2;

UPDATE account
SET credit = credit + 100
WHERE id = 3;

SELECT * FROM account;

ROLLBACK TRANSACTION;

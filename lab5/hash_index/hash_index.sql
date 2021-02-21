-- psql -U postgres -d customers -h localhost -f hash_index.sql

CREATE INDEX name_index ON customer USING hash (name);

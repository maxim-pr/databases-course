-- psql -U postgres -d customers -h localhost -f btree_index.sql

CREATE INDEX age_index ON customer USING btree (age);

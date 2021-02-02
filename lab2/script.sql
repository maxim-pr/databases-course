-- Maxim Pryanikov, group 4

CREATE TABLE production_company (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) UNIQUE NOT NULL,
	address VARCHAR(100) NOT NULL
);

CREATE TABLE movie (
	id SERIAL PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	length SMALLINT NOT NULL,
	plot_outline TEXT,
	release_year SMALLINT NOT NULL,
	production_company_id INTEGER,
	UNIQUE (title, release_year),
	FOREIGN KEY (production_company_id)
		REFERENCES production_company (id)
);

CREATE TABLE genre (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE movie_genre (
	movie_id INTEGER,
	genre_id INTEGER,
	PRIMARY KEY (movie_id, genre_id),
	FOREIGN KEY (movie_id)
		REFERENCES movie (id),
	FOREIGN KEY (genre_id)
		REFERENCES genre (id)
);

CREATE TABLE person (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	birth_date DATE NOT NULL
);

CREATE TABLE actor_role (
	id SERIAL PRIMARY KEY,
	name VARCHAR (100) UNIQUE NOT NULL
); 

CREATE TABLE movie_actor (
	movie_id INTEGER,
	actor_id INTEGER,
	actor_role_id INTEGER,
	PRIMARY KEY (movie_id, actor_id, actor_role_id),
	FOREIGN KEY (movie_id)
		REFERENCES movie (id),
	FOREIGN KEY (actor_id)
		REFERENCES person (id),
	FOREIGN KEY (actor_role_id)
		REFERENCES actor_role (id)
);

CREATE TABLE movie_director (
	movie_id INTEGER,
	director_id INTEGER,
	PRIMARY KEY (movie_id, director_id),
	FOREIGN KEY (movie_id)
		REFERENCES movie (id),
	FOREIGN KEY (director_id)
		REFERENCES person (id)
);

CREATE TABLE quote (
	id SERIAL PRIMARY KEY,
	phrase VARCHAR(255) NOT NULL,
	movie_id INTEGER,
	person_id INTEGER,
	FOREIGN KEY (movie_id)
		REFERENCES movie (id),
	FOREIGN KEY (person_id)
		REFERENCES person (id)
);

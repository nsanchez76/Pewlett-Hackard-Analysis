CREATE TABLE people (
	people_name VARCHAR(30) NOT NULL,
	has_pet BOOLEAN DEFAULT false,
	pet_type VARCHAR (10) NOT NULL,
	pet_name VARCHAR(30) NOT NULL,
	pet_age INT
);

SELECT * FROM people;
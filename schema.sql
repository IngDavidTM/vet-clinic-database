/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(250),
  date_of_birth DATE,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg decimal,
  PRIMARY KEY(id)
);

ALTER TABLE animals
ADD species VARCHAR(250);

CREATE TABLE owners(
  id INT GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(250),
  age INT,
  PRIMARY KEY(id)
);

CREATE TABLE species(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(250),
  PRIMARY KEY(id)
);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD species_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species(id)
ON DELETE CASCADE;

ALTER TABLE animals
ADD owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_owners
FOREIGN KEY (owner_id)
REFERENCES owners(id)
ON DELETE CASCADE;

CREATE TABLE vets(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(250),
  age INT,
  date_of_graduation DATE,
  PRIMARY KEY(id)
);

CREATE TABLE specializations(
  species_id INT,
  vets_id INT,
  FOREIGN KEY (species_id) REFERENCES species(id),
  FOREIGN KEY (vets_id) REFERENCES vets(id)
);

CREATE TABLE visits(
  animals_id INT,
  vets_id INT,
  FOREIGN KEY (animals_id) REFERENCES animals(id),
  FOREIGN KEY (vets_id) REFERENCES vets(id),
  date_of_visit DATE
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- CREATE index on visits for animals_id
CREATE INDEX animals_id ON visits(animals_id);

-- CREATE index on visits for vet_id
CREATE INDEX visits_vet_id_asc ON visits(vets_id ASC);

-- CREATE index on owners email
CREATE INDEX owners_email_asc ON owners(email ASC);

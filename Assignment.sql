-- Active: 1747461697211@@127.0.0.1@5432@ph
CREATE table rangers(ranger_id SERIAL PRIMARY key,name VARCHAR(50) NOT null,region VARCHAR(100) not NULL);
CREATE table species(species_id SERIAL PRIMARY key,common_name VARCHAR(50) NOT NULL,scientific_name VARCHAR(100) NOT NULL,discovery_date DATE NOT NULL,conservation_status VARCHAR(50) CHECK(conservation_status in ('Endangered', 'Vulnerable', 'Historic')));
CREATE table sightings( sighting_id SERIAL PRIMARY key,species_id INTEGER REFERENCES species(species_id), ranger_id INTEGER REFERENCES rangers(ranger_id), location VARCHAR(50) not NULL,sighting_time TIMESTAMP not NULL,notes VARCHAR(50));

INSERT into rangers(name,region) VALUES ('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');


INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);


-- problem solution 1
INSERT into rangers(name,region) VALUES ('Derek Fox','Coastal Plains');

-- problem solution 2

SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;

-- problem solution 3
SELECT * from sightings where location ilike '%pass%';

-- problem solution 4
SELECT name,count(sighting_id) AS total_sightings from rangers JOIN sightings using(ranger_id) GROUP BY name;

-- problem solution 5
SELECT common_name FROM species WHERE species_id NOT IN (SELECT DISTINCT species_id FROM sightings);

-- problem solution 6
SELECT species.common_name, sightings.sighting_time, rangers.name
FROM sightings 
JOIN species ON sightings.species_id = species.species_id
JOIN rangers  ON sightings.ranger_id = rangers.ranger_id
ORDER BY sightings.sighting_time DESC
LIMIT 2;

-- problem solution 7

UPDATE species set conservation_status='Historic'
WHERE discovery_date < '1800-01-01';

-- problem solution 8
SELECT sighting_id,
       CASE
           WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
           WHEN EXTRACT(HOUR FROM sighting_time) < 17 THEN 'Afternoon'
           ELSE 'Evening'
       END AS time_of_day
FROM sightings;

-- problem solution 9
DELETE FROM rangers WHERE ranger_id NOT IN (SELECT DISTINCT ranger_id FROM sightings);



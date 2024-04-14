CREATE DATABASE universe;

\c universe

CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    size TEXT NOT NULL,
    shape VARCHAR(50) NOT NULL,
    has_spiral_arms BOOLEAN NOT NULL,
    num_stars INT NOT NULL,
    age INT
);

INSERT INTO galaxy (name, size, shape, has_spiral_arms, num_stars, age) VALUES
('Milky Way', 'Large', 'Spiral', TRUE, 1000000000, 13000),
('Andromeda', 'Giant', 'Spiral', TRUE, 100000000, 12000),
('Messier 87', 'Supermassive', 'Elliptical', FALSE, 200000000, 20000),
('Triangulum', 'Small', 'Spiral', TRUE, 400000000, 11000),
('Sombrero', 'Medium', 'Spiral', TRUE, 50000000, 13000),
('Whirlpool', 'Large', 'Spiral', TRUE, 200000000, 12000);

CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    type VARCHAR(50) NOT NULL,
    age NUMERIC NOT NULL,
    has_planets BOOLEAN NOT NULL,
    galaxy_id INT REFERENCES galaxy(galaxy_id),
    luminosity INT NOT NULL,
    temperature INT NOT NULL
);

INSERT INTO star (name, type, age, has_planets, galaxy_id, luminosity, temperature) VALUES
('Sun', 'G-type Main Sequence', 4.6, TRUE, 1, 1, 5778),
('Alpha Centauri A', 'G-type Main Sequence', 6.0, TRUE, 1, 1, 5790),
('Alpha Centauri B', 'K-type Main Sequence', 6.0, TRUE, 1, 0, 5260),
('Sirius', 'A-type Main Sequence', 0.3, TRUE, 1, 23, 9940),
('Proxima Centauri', 'M-type Main Sequence', 4.85, FALSE, 1, 0, 3042),
('Betelgeuse', 'Red Supergiant', 8.5, TRUE, 1, 170000, 3600),
('Vega', 'A-type Main Sequence', 0.45, TRUE, 1, 37, 9602);

CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    type VARCHAR(50) NOT NULL,
    distance_from_star NUMERIC NOT NULL,
    has_moons BOOLEAN NOT NULL,
    star_id INT REFERENCES star(star_id),
    mass INT NOT NULL,
    radius INT NOT NULL
);

INSERT INTO planet (name, type, distance_from_star, has_moons, star_id, mass, radius) VALUES
('Earth', 'Terrestrial', 1.0, TRUE, 1, 5973, 6371),
('Mars', 'Terrestrial', 1.5, TRUE, 1, 641.71, 3389.5),
('Jupiter', 'Gas Giant', 5.2, TRUE, 1, 1898180, 69911),
('Saturn', 'Gas Giant', 9.5, TRUE, 1, 568319, 58232),
('Uranus', 'Ice Giant', 19.2, TRUE, 1, 86813, 25362),
('Neptune', 'Ice Giant', 30.1, TRUE, 1, 102413, 24622),
('Kepler-186f', 'Terrestrial', 0.0427, FALSE, 2, 595.79, 5731),
('Gliese 581c', 'Terrestrial', 0.0731, FALSE, 2, 588.6, 7484),
('Gliese 581d', 'Super Earth', 0.22, FALSE, 2, 7572, 7871),
('Kepler-62e', 'Super Earth', 0.12, FALSE, 3, 12500, 15000),
('Kepler-62f', 'Super Earth', 0.41, FALSE, 3, 7825, 15625),
('HD 209458 b', 'Gas Giant', 0.0475, FALSE, 4, 2237, 105234);

CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    type VARCHAR(50) NOT NULL,
    radius NUMERIC NOT NULL,
    is_inhabited BOOLEAN NOT NULL,
    planet_id INT REFERENCES planet(planet_id),
    mass INT NOT NULL,
    orbital_period INT NOT NULL
);


CREATE TABLE mission (
    mission_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT NOT NULL,
    launch_date DATE NOT NULL,
    is_successful BOOLEAN NOT NULL,
    destination VARCHAR(100) NOT NULL,
    spacecraft VARCHAR(100) NOT NULL,
    duration_years INT NOT NULL,
    cost NUMERIC NOT NULL
);

INSERT INTO mission (name, description, launch_date, is_successful, destination, spacecraft, duration_years, cost) VALUES
('Apollo 11', 'First manned mission to land on the Moon', '1969-07-16', TRUE, 'Moon', 'Apollo 11', 0, 355000000),
('Voyager 1', 'Probe to study outer planets and interstellar space', '1977-09-05', TRUE, 'Interstellar Space', 'Voyager 1', 44, 865000000),
('Mars Rover Opportunity', 'Exploration rover on Mars', '2003-07-07', TRUE, 'Mars', 'Opportunity', 15, 400000000),
('New Horizons', 'Probe to study Pluto and the Kuiper belt', '2006-01-19', TRUE, 'Pluto', 'New Horizons', 15, 650000000),
('Cassini-Huygens', 'Saturn exploration mission', '1997-10-15', TRUE, 'Saturn', 'Cassini', 20, 3300000000);


INSERT INTO moon (name, type, radius, is_inhabited, planet_id, mass, orbital_period) VALUES
('Charon', 'Terrestrial', 606.0, FALSE, 7, 1611, 6.39),
('Callisto', 'Terrestrial', 2410.3, FALSE, 3, 1076, 16.69),
('Triton', 'Terrestrial', 1353.4, FALSE, 6, 214687, 5.88),
('Titania', 'Terrestrial', 788.9, FALSE, 6, 3527, 8.71),
('Rhea', 'Terrestrial', 763.8, FALSE, 4, 2309, 4.52),
('Oberon', 'Terrestrial', 761.4, FALSE, 6, 3014, 13.46),
('Europa', 'Terrestrial', 1560.7, FALSE, 3, 4800, 3.55),
('Ganymede', 'Terrestrial', 2634.1, FALSE, 3, 14819, 7.15),
('Io', 'Terrestrial', 1821.6, FALSE, 3, 8932, 1.77),
('Titan', 'Terrestrial', 2574.7, FALSE, 4, 13455, 15.95),
('Enceladus', 'Terrestrial', 252.1, FALSE, 4, 107.2, 1.37),
('Miranda', 'Terrestrial', 235.8, FALSE, 5, 65.8, 1.41),
('Tethys', 'Terrestrial', 531.1, FALSE, 4, 617, 1.89),
('Dione', 'Terrestrial', 561.4, FALSE, 4, 1104, 2.74),
('Ariel', 'Terrestrial', 578.9, FALSE, 5, 1353, 2.52),
('Umbriel', 'Terrestrial', 584.7, FALSE, 5, 1168, 4.14),
('Proteus', 'Terrestrial', 210, FALSE, 8, 50.3, 1.12),
('Hyperion', 'Terrestrial', 135.0, FALSE, 4, 56, 21.28),
('Proxima Centauri b', 'Exoplanet', 699, FALSE, 4, 15, 55.2),
('Iapetus', 'Terrestrial', 735.6, FALSE, 4, 1805, 79.33);


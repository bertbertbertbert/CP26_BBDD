-- Mostra el títol de les pel·lícules on no ha participat cap actor.

SELECT DISTINCT f.title
FROM film f LEFT JOIN film_actor fa ON f.film_id = fa.film_id 
WHERE fa.actor_id  IS NULL;

-- Mostra el nom i cognom dels actors que no han participat a cap pel·lícula.

SELECT a.first_name, a.last_name 
FROM actor a LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id LEFT JOIN film f ON fa.film_id = f.film_id 
WHERE fa.film_id IS NULL;

-- Mostra el nom dels idiomes que no tenen cap pel·lícula enregistrada.

SELECT l.name 
FROM `language` l LEFT JOIN film f ON l.language_id = f.language_id 
WHERE f.language_id IS NULL;

-- Mostra el títol i longitud de les pel·lícules que tinguin una durada d'entre 90 i 100 minuts (inclosos) i
--  de les quals no en tinguem còpies en cap magatzem (inventory). Mostra el resultat ordenat per títol.

SELECT f.title, f.`length` 
FROM film f LEFT JOIN inventory i ON f.film_id = i.film_id 
WHERE (f.`length` BETWEEN 90 AND 100) AND i.film_id IS NULL
ORDER BY f.title;


-- Veure, per cada país, el nom del país i el nom de les seves ciutats enregistrades, ordenat 
-- pel nom del país i el nom de la ciutat.

SELECT c.country, c2.city 
FROM country c JOIN city c2 On c.country_id = c2.country_id
ORDER BY c.country, c2.city;

-- Veure, per cada país, el seu nom i el nom de les seves ciutats, i per cada adreça enregistrada de cada ciutat, 
-- els camps address, address2, i district. Ordena els resultats pel nom del país, nom de la ciutat, i adreça (address).

SELECT c.country, c2.city, a.address, a.address2, a.district 
FROM country c LEFT JOIN city c2 On c.country_id = c2.country_id JOIN address a ON c2.city_id = a.city_id 
ORDER BY c.country, c2.city, a.address;

-- Veure el nom de les ciutats i del seu país, de les ciutats que no tenen cap adreça enregistrada.
-- Ordena els resultats per nom del país i nom de la ciutat.


SELECT c2.city, c.country
FROM country c LEFT JOIN city c2 On c.country_id = c2.country_id LEFT JOIN address a ON c2.city_id = a.city_id 
WHERE a.address IS NULL AND a.address2 IS NULL
ORDER BY c.country, c2.city, a.address;

-- Volem saber si tenim algun actor i client que tinguin el mateix nom i cognoms. Mostrar el nom i 
-- cognom de les coincidències ordenades per cognom i nom.

SELECT a.first_name as actorfirstname, a.last_name as actorlastname
FROM actor a JOIN film_actor fa  ON a.actor_id = fa.actor_id JOIN film f ON fa.film_id = f.film_id JOIN inventory i ON f.film_id = i.film_id JOIN rental r ON i.inventory_id = r.inventory_id JOIN customer c ON r.customer_id = c.customer_id
whERE a.first_name = c.first_name AND a.last_name = c.last_name
ORDER BY actorfirstname, actorlastname;




























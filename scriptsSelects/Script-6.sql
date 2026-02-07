-- CHINOOK simulacro examen  

-- Mostra, en una única columna separada per #, el product_name, el unit_price (si és null mostra 0) i la category.
-- Ordena el resultat pel preu de major a menor i després pel nom del producte.

SELECT CONCAT(p.product_name, "#", IFNULL(od.unit_price, 0), "#", p.category )
FROM products p JOIN order_details od ON p.id = od.product_id
ORDER BY od.unit_price DESC, p.product_name 


-- Mostra el nom de la companyia del client que ha fet la comanda amb més productes diferents.
-- Mostra també l’id de la comanda i el nombre de productes diferents comprats.

SELECT c.company, o.id, COUNT(DISTINCT od.product_id) AS total_productes
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN order_details od ON o.id = od.order_id
GROUP BY o.id, c.company
HAVING COUNT(DISTINCT od.product_id) = (
    SELECT COUNT(DISTINCT od2.product_id)
    FROM order_details od2
    GROUP BY od2.order_id
    ORDER BY COUNT(DISTINCT od2.product_id) DESC
    LIMIT 1
);

-- Mostra l’id de cada comanda i el total de quantitat de productes comprats (suma de quantity).
-- Mostra només aquelles comandes on el total sigui superior a 30.

SELECT o.id, SUM(od.quantity)
FROM orders o JOIN order_details od ON o.id = od.order_id
GROUP BY o.id
HAVING SUM(od.quantity) > 30

-- Mostra l’id, nom i cognom dels empleats que no han gestionat cap comanda.

SELECT e.id, e.first_name, e.last_name 
FROM employees e LEFT JOIN orders o ON e.id = o.employee_id
WHERE o.employee_id IS NULL

-- Mostra les categories de productes i el nombre total de productes de cada categoria.
-- Ordena el resultat de major a menor nombre de productes.

SELECT p.category, COUNT(p.id)
FROM products p 
GROUP BY p.category 
ORDER BY COUNT(p.id) DESC

-- Mostra per cada client el seu nom, cognom i la data de la seva última comanda.
-- Si el client no ha fet cap comanda, mostra NULL.

SELECT c.first_name, c.last_name, MAX(o.order_date)
FROM customers c LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.id 

-- Mostra les ciutats on hi ha almenys 3 clients diferents que han fet alguna comanda.
-- Mostra també el nombre de clients d’aquella ciutat.


SELECT c.city, c.first_name, c.last_name
FROM customers c
WHERE c.city IN (
    SELECT c2.city
    FROM customers c2
    JOIN orders o2 ON c2.id = o2.customer_id
    GROUP BY c2.city
    HAVING COUNT(c2.id) >= 3
)


-- Mostra l’id de les comandes i el preu total de la comanda, ignorant el camp discount.
-- Mostra només les comandes amb un import total superior a 1500.

SELECT o.id, SUM(od.quantity * od.unit_price) as preuTotal
FROM orders o 
JOIN order_details od ON o.id = od.order_id
GROUP BY o.id
HAVING preuTotal > 1500

-- Digues el mes (número de mes) en què s’han fet més comandes, independentment de l’any.

SELECT MONTH(o.order_date)
FROM orders o 
GROUP BY MONTH(o.order_date)
ORDER BY COUNT(MONTH(o.order_date)) DESC
LIMIT 1

-- Mostra el nom i cognom dels clients que han comprat productes de més d’una categoria diferent.

SELECT c.first_name, c.last_name
FROM customers c 
JOIN orders o ON c.id = o.customer_id
JOIN order_details od ON o.id = od.order_id 
JOIN products p ON od.product_id = p.id 
GROUP BY o.id, c.first_name, c.last_name
HAVING COUNT(DISTINCT p.category) > 1

-- Mostra el product_code i el product_name dels productes que no s’han venut mai.

SELECT p.product_code, p.product_name
FROM products p LEFT JOIN order_details od ON p.id = od.product_id 
WHERE od.product_id IS NULL


-- Mostra per cada empleat el seu nom, cognom i el nombre total de comandes que ha gestionat.
-- Si no n’ha gestionat cap, mostra 0.

SELECT e.first_name, e.last_name, COUNT(o.id)
FROM employees e LEFT JOIN orders o ON e.id = o.employee_id
GROUP BY e.id, e.first_name, e.last_name 

-- CHINOOK
-- 1
-- Mostra, en una única columna separada per `#`, el FirstName, el LastName i el Country dels clients.
-- Si el país és NULL, mostra `sense dades`.
-- Ordena el resultat per la longitud del cognom i després pel CustomerId.
   
SELECT CONCAT(c.FirstName, "#", c.LastName, "#", IFNULL(c.Country, 'sense dades'))
FROM Customer c 
ORDER BY LENGTH(c.LastName), c.CustomerId;

-- 2
-- Mostra el CustomerId del client que ha fet la factura amb més línies de factura.
-- Mostra també el nombre total de línies.
SELECT i.CustomerId, COUNT(il.InvoiceId)
FROM Invoice i JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY i.InvoiceId, i.CustomerId
HAVING COUNT(il.InvoiceId)=(
SELECT COUNT(il.InvoiceId)
FROM Invoice i JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY i.InvoiceId
ORDER BY COUNT(il.InvoiceId) DESC
LIMIT 1)

-- 3
-- Mostra l’InvoiceId, el nom i cognom del client i, en una sola línia,
-- el nom dels tracks inclosos en cada factura.

SELECT i.InvoiceId, c.FirstName, c.LastName, GROUP_CONCAT(t.Name)
FROM Customer c 
JOIN Invoice i ON c.CustomerId = i.CustomerId
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
JOIN Track t ON il.TrackId = t.TrackId
GROUP BY i.InvoiceId, c.FirstName, c.LastName

-- 4
-- Mostra el CustomerId, el FirstName i el LastName dels clients
-- que no van fer cap factura el dia 01-01-2012.

SELECT c.CustomerId, c.FirstName, c.LastName
FROM Customer c
WHERE c.CustomerId NOT IN(
SELECT c.CustomerId
FROM Customer c 
JOIN Invoice i ON c.CustomerId = i.CustomerId
WHERE i.InvoiceDate LIKE "2012-01-01%")

-- 5
-- Mostra les dates en què s’han fet almenys 5 factures
-- i on l’import total del dia és com a mínim 100.
-- Mostra també el nombre de factures i l’import total.

SELECT DATE(i.InvoiceDate) AS Dia, 
       COUNT(DISTINCT i.InvoiceId) AS num_factures, 
       SUM(il.Quantity * il.UnitPrice) AS total
FROM Invoice i
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY DATE(i.InvoiceDate)
HAVING COUNT(DISTINCT i.InvoiceId) >= 5
   AND SUM(il.Quantity * il.UnitPrice) >= 100;

-- 6
-- Digues el mes (número) en què s’han fet més factures,
-- independentment de l’any.

SELECT MONTH(i.InvoiceDate)
FROM Invoice i 
GROUP BY MONTH(i.InvoiceDate)
HAVING COUNT(i.InvoiceId) = (
SELECT COUNT(i.InvoiceId)
FROM Invoice i 
GROUP BY MONTH(i.InvoiceDate)
ORDER BY COUNT(i.InvoiceId) DESC
LIMIT 1)

-- 7
-- Mostra, en una única columna i sense repeticions,
-- els Country dels clients i dels empleats.
-- Ordena alfabèticament.

SELECT c.Country 
FROM Customer c 
UNION 
SELECT e.Country 
FROM Employee e  
ORDER BY Country 

-- 8
-- Mostra el CustomerId, el FirstName i el LastName
-- dels 10 últims clients que han fet alguna factura.
-- Ordena el resultat final per FirstName i LastName.


SELECT t.*
FROM (SELECT DISTINCT c.CustomerId, c.FirstName, c.LastName
FROM Invoice i JOIN Customer c ON i.CustomerId = c.CustomerId 
GROUP BY i.InvoiceDate 
ORDER BY  i.InvoiceDate DESC
LIMIT 10) as t
ORDER BY t.FirstName, t.LastName 

-- O
SELECT t.*
FROM (SELECT c.CustomerId, c.FirstName, c.LastName
FROM Invoice i JOIN Customer c ON i.CustomerId = c.CustomerId 
GROUP BY c.CustomerId  
ORDER BY  i.InvoiceDate DESC
LIMIT 10) as t
ORDER BY t.FirstName, t.LastName 

-- 9
-- Mostra el Name del track i el Name del gènere
-- dels tracks que no tenen Composer o no tenen Bytes
-- i que pertanyen als gèneres ‘Rock’ o ‘Jazz’.

SELECT t.Name, g.Name 
FROM Track t JOIN Genre g ON t.GenreId = g.GenreId
WHERE (t.Composer IS NULL OR t.Bytes IS NULL) AND (g.Name LIKE 'Rock' OR g.Name LIKE 'Jazz')

-- 10
-- Mostra l’InvoiceId de les factures
-- que no tenen cap línia associada.

SELECT i.InvoiceId 
FROM Invoice i LEFT JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
WHERE il.InvoiceId IS NULL

-- 11
-- Mostra sense repeticions el FirstName i LastName
-- dels empleats que han gestionat alguna factura
-- amb import total superior a 30
-- i on el client és del mateix país que l’empleat.

SELECT DISTINCT e.FirstName, e.LastName 
FROM Employee e 
JOIN Customer c ON e.EmployeeId = c.SupportRepId
JOIN Invoice i ON c.CustomerId = i.CustomerId
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
WHERE e.Country  = c.Country 
GROUP BY e.EmployeeId  
HAVING SUM(il.Quantity * il.UnitPrice) > 30


-- 12
-- Mostra, per cada client, el seu FirstName i LastName,
-- el nombre total de factures que ha fet
-- i l’import total, arrodonit cap amunt.
-- Si el client no ha fet cap factura, mostra 0.

SELECT c.FirstName, c.LastName, COUNT(DISTINCT i.InvoiceId), SUM(CEIL(IFNULL(il.Quantity * il.UnitPrice, 0)))
FROM Customer c LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
LEFT JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY c.CustomerId, c.FirstName, c.LastName





































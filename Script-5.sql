-- miniwind - subconsultes 01

-- 1 Mostrar totes les dades dels productes que tinguin un preu de cost superior a la mitjana.

SELECT p.*
FROM products p 
WHERE p.standard_cost > (
SELECT AVG(p.standard_cost)
FROM products p )

-- 2 Mostrar totes les dades dels productes que tinguin un preu de cost per sobre de la mitjana 
-- dels productes que son Salses

SELECT p.*
FROM products p 
WHERE p.standard_cost > (
SELECT AVG(p.standard_cost)
FROM products p
WHERE p.category LIKE 'Sauces')

-- 3 Mostra les dades dels clients que siguin de l'estat que té més clients

SELEct c.*
FROM customers c 
WHERE c.state_province = (
SELECT c.state_province
FROM customers c 
GROUP BY c.state_province  
ORDER BY COUNT(c.state_province) DESC
LIMIT 1)

-- 4 De les comandes que s'han pagat amb targeta, quin és el preu que s'ha pagat més alt?

SELECT MAX(od.quantity * od.unit_price)
FROM order_details od JOIN orders o ON od.order_id = o.id 
WHERE o.payment_type LIKE 'Credit Card'

-- 5 Dels clients que han fet comandes, mostra l'id, el nom i cognoms d'aquells que han fet menys comandes.

SELECT c.id, c.first_name, c.last_name 
FROM customers c JOIN orders o ON c.id = o.customer_id
GROUP BY o.customer_id 
HAVING COUNT(o.customer_id) = (
SELECT COUNT(o.customer_id)
FROM orders o 
GROUP BY o.customer_id 
ORDER BY COUNT(o.customer_id) 
LIMIT 1)

-- 6 Mostra l'id, el nom i cognoms dels clients que han fet més comandes

SELECT c.id, c.first_name, c.last_name 
FROM customers c JOIN orders o ON c.id = o.customer_id
GROUP BY o.customer_id, c.id, c.first_name, c.last_name 
HAVING COUNT(o.customer_id) = (
SELECT COUNT(o.customer_id)
FROM orders o 
GROUP BY o.customer_id 
ORDER BY COUNT(o.customer_id) DESC
LIMIT 1)











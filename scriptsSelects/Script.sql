-- Mostra els cognoms de la taula employees que tinguin una "e" en la segona posició.

SELECT last_name
FROM employees e 
WHERE e.last_name LIKE '_e%';


-- Mostra els noms de la taula employees que comencin 
-- per "T" i que continguin una "e".

SELECT first_name
FROM employees 
WHERE first_name LIKE 'T%' AND first_name LIKE '%e%';


-- Mostra el cognom dels empleats la posició dels quals és "Sales Manager", "Sales Representative", o "Sales Coordinator".

SELECT last_name
FROM employees
WHERE job_title = 'Sales Manager' OR job_title = 'Sales Representative' OR job_title = 'Sales Coordinator';


-- Mostra els cognoms dels empleats que no ocupin cap de les tres posicions anteriors.
SELECT last_name
FROM employees e 
WHERE e.job_title NOT IN ('Sales Manager', 'Sales Representative', 'Sales Coordinator');


-- Mostra una llista dels empleats de Washington que sàpiguen francès (es diu a les notes), o d'Atlanta que no en sàpiguen. 
-- Volem veure el seu identificador, el nom, el cognom, la ciutat, i les notes. (Si al camp notes no es menciona aquest idioma 
-- o no posa res és que l'empleat no el sap).

SELECT id, first_name, last_name, city, notes
FROM employees e 
WHERE  (city = 'Washington' AND  notes LIKE '%French%') OR (notes NOT LIKE '%French%' AND city LIKE 'Atlanta');

-- Mostra el nom i el proveïdor dels productes de la taula products que siguin només del proveïdor (supplier_ids) número 4 o només del 10.

SELECT product_name, supplier_ids 
FROM products p 
WHERE p.supplier_ids LIKE '4' OR  p.supplier_ids LIKE '10';


-- Mostra el nom i el proveïdor dels productes de la taula products que NO siguin només del proveïdor 4 ni només del 10.

SELECT product_name, supplier_ids 
FROM products p 
WHERE p.supplier_ids NOT LIKE '4' AND  p.supplier_ids NOT LIKE '10';


-- Obté el nom i el preu dels productes el preu dels quals (list_price) està comprès entre 10 i 20 (inclosos).

SELECT product_name, list_price
FROM products p 
WHERE list_price >= 10 AND p.list_price <=20;

-- Obté el nom i el preu dels productes el preu dels quals NO està comprès entre 10 i 20.

SELECT product_name, list_price
FROM products p 
WHERE p.list_price NOT BETWEEN 10 AND 20;

-- Obté el nom dels productes, el preu i el número del proveïdor que tinguin un preu superior a 20 i que siguin només del proveïdor número 4 o només del número 10.

SELECT product_name, list_price, supplier_ids
FROM products p 
WHERE p.list_price > 20 AND (p.supplier_ids LIKE '4' OR supplier_ids LIKE '10');

-- Mostra el nom, cost i preu dels productes pels quals la diferència entre el preu de cost (standard_cost) 
-- i el preu de venta sigui de més de 10. El preu de venda ha de ser superior al preu de cost.

SELECT p.product_name , standard_cost, list_price
FROM products p
WHERE list_price > p.standard_cost AND (p.list_price - p.standard_cost > 10);

-- Selecciona la llista de productes (identificador i nom del producte) que contenen la paraula 'soup' en el seu nom. Escriu la consulta de manera que funcioni 
-- correctament independentment de si la paraula 'soup' s'escriu en majúscules o en minúscules.

SELECT id, product_name
FROM products
WHERE product_name REGEXP 'soup';


-- Fes una llista de les comandes (taula orders) que es van servir al client número 4 i que, a més, han tingut un cost d'enviament (shipping_fee) de més de 4 dòlars. 
-- Mostra l'identificador i la data de la comanda, i el cost d'enviament.

SELECT id, order_date, shipping_fee
FROM orders o 
WHERE customer_id = 4 AND o.shipping_fee > 4;


-- Obté l'identificador, el codi de producte i el nom del producte, dels productes el preu de venda dels quals sigui menys d'un 30% superior al preu de cost.

SELECT id, product_code, product_name
FROM products p 
WHERE p.list_price < p.standard_cost * 1.30;


-- Obté l'identificador, el nom, i el cognom, de tots els clients que tenen el nom o el cognom acabat en 'e', però no els dos. Ordena els resultats pel cognom.

SELECT id, first_name, last_name 
FROM customers c 
WHERE (first_name LIKE '%e' AND last_name NOT LIKE '%e') OR (last_name LIKE '%e' AND first_name NOT LIKE '%e')
ORDER BY last_name;


-- Obté l'identificador i el nom dels productes pels quals hi ha més d'un proveïdor.

SELECT id, product_name
FROM products p 
WHERE p.supplier_ids LIKE '___%';

-- Obté l'identificador i el nom dels productes que són proporcionats pel proveïdor 3. La consulta ha de mostrar també els productes pels quals hi ha més d'un proveïdor 
-- i el proveïdor 3 és un d'ells. Utilitza el fet que sabem que només hi ha 10 proveïdors diferents.

SELECT id, product_name 
FROM products p 
WHERE p.supplier_ids LIKE '%3' OR p.supplier_ids LIKE '3%';

-- Obté l'identificador i el nom dels productes pels quals la quantitat que es demana quan es fa una comanda al proveïdor (reorder_level) no coincideix amb la quantitat mínima 
-- que s'ha de demanar (minimum_reorder_quantity). Tingues en compte que si només un dels dos camps val null s'ha de considerar com que no coincideixen.

SELECT id, product_name
FROM products p 
WHERE p.reorder_level NOT LIKE p.minimum_reorder_quantity OR  (p.reorder_level IS NULL AND p.minimum_reorder_quantity IS NOT NULL 
OR p.minimum_reorder_quantity IS NULL AND p.reorder_level IS NOT NULL);

-- Obtenir la data de la comanda, la data d'enviament i l'adreça d'enviament de totes les comandes enviades a la ciutat de New Orleans. 
-- Ordena els resultats per la data en què s'ha fet la comanda, 
-- de més recents a més antigues. (Per saber si una comanda està enviada cal consultar camp shipped_date)

SELECT order_date, shipped_date, ship_address
FROM orders
WHERE shipped_date IS NOT NULL AND ship_city = 'New Orleans'
ORDER BY order_date DESC;

-- Obtenir l'identificador, el nom de la persona receptora de l'enviament, i l'identificador de client, de totes les comandes per a 
-- les quals no consta una data d'enviament. Ordena els resultats per l'identificador del client.

SELECT id, ship_name, cUstOmer_id
FROM orders o 
WHERE shipped_date IS NULL 
ORDER BY cUstOmer_id;

-- Obtenir l'identificador, la data de la comanda, i l'identificador de client, de totes les comandes que es van fer entre el febrer 
-- i el maig de 2006 (inclosos), i ordena-les per la data de la comanda.

SELECT id, order_date, customer_id 
FROM orders o 
WHERE DATE(order_date) BETWEEN '2006-02-01' AND '2006-05-31'
ORDER BY order_date;

-- Obté l'identificador, la data de la comanda, i la ciutat de destí de totes les comandes les despeses d'enviament de les quals siguin 
-- superiors a 100 dòlars i que o bé s'hagin pagat amb un xec o bé siguin posteriors a febrer de 2006 (order date) (sense incloure'l).

SELECT id, order_date, ship_city
FROM orders o 
WHERE o.shipping_fee > 100 AND (o.payment_type = 'Check' OR order_date >= '2006-03-01 00:00:00.000' );


-- Obté l'identificador, i l'adreça i ciutat d'enviament de totes les comandes que siguin posteriors al 15 de maig de 2006 i que tinguin un enviament gratuït.

SELECT id, ship_address, ship_city
FROM orders o 
WHERE order_date > '2006-05-15' AND o.shipping_fee = 0;





-- Mostra el nom i cognoms dels usuaris que estan al grup d'ASIX2. Ordena per cognoms i nom de l'usuari

SELECT nomUsuari, cognom1Usuari, cognom2Usuari
FROM usuaris u 
JOIN grups g ON g.id = u.idGrup 
WHERE g.nom = "ASIX2"
ORDER BY cognom1Usuari, cognom2Usuari, nomUsuari;

-- Mostra el nom i cognoms de totes les usuàries que siguin dones i mostra també el nom del grup al qual pertany. Ordena els resultats pel primer cognom

SELECT  u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari, g.nom
FROM usuaris u 
JOIN grups g ON g.id = u.idGrup 
WHERE u.sexe = 'F'
ORDER BY u.cognom1Usuari, u.cognom2Usuari, u.nomUsuari;

-- Mostra el nom i cognoms de tots els usuaris que tenen grup i el nom del grup al qual pertany. Ordena els resultats pel primer cognom

SELECT u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari, g.nom
FROM usuaris u 
JOIN grups g ON g.id = u.idGrup 
WHERE u.idGrup IS NOT NULL 
ORDER BY u.cognom1Usuari;
-- Mostra per cada cicle formatiu que tingui mòduls, el nom del cicle, el nom del mòdul, i les hores del mòdul. 
-- Recorda que no poden haver dues columnes amb el mateix nom (fes servir àlies)
SELECT c.nom AS nomCicle, m.nom as nomModul, m.hores
FROM cicles c 
JOIN moduls m ON c.id = m.cicle;

-- Veure els mòduls que té el cicle formatiu d'ASIX. S'ha de veure el número del mòdul, el seu nom i les hores que té, ordenat per número de mòdul.

SELECT m.modul, m.nom AS modulNom, m.hores
FROM moduls m 
JOIN cicles c ON  c.id = m.cicle
WHERE c.nom = 'ASIX'
ORDER BY m.modul;


-- Veure totes les dades del mòdul de Base de dades d'ASIX.

SELECT m.*
FROM cicles c 
join moduls m on m.cicle = c.id
WHERE c.nom = 'ASIX' and m.nom like '%base de dades%'
ORDER BY m.modul;

-- Mostra totes les dades dels grups i el nom i descripció del cicle al qual pertany. (Vigila que no hi pot haver dues columnes amb el mateix nom)

SELECT g.*, c.nom AS nomCicle, c.descripcio
FROM grups g JOIN cicles c ON g.cicle = c.id;

-- Mostra totes les dades dels grups que són del cicle de DAMVI

SELECT g.*
FROM grups g JOIN cicles c ON g.cicle = c.id
WHERE c.nom = 'DAMVI';

-- Veure el nom i cognoms i la nota dels usuaris que han aprovat en primera convocatòria (nota1c) la unitat formativa amb l'identificador 6. 
-- Ordena els resultats per nota1c de més alta a més baixa i després per cognoms de l'alumne

SELECT u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari, q.nota1c 
FROM usuaris u JOIN qualificacions q ON u.idUsuari = q.idalumne 
WHERE q.idunitatformativa = 6 AND q.nota1c >= 5
ORDER BY q.nota1c DESC, u.cognom1Usuari, u.cognom2Usuari;

-- Veure el nom i cognoms i la nota dels usuaris que han aprovat la unitat formativa amb l'identificador 6 en primera o segona convocatòria. Ordena els resultats per cognoms de l'alumne

SELECT u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari, q.nota1c, q.nota2c 
FROM usuaris u JOIN qualificacions q ON u.idUsuari = q.idalumne 
WHERE q.idunitatformativa = 6 AND (q.nota1c >= 5 OR q.nota2c >= 5)
ORDER BY u.cognom1Usuari, u.cognom2Usuari;



-- 1 Llista el id de les factures (com a invoice_id), el nom i cognom del client i la quantitat a deure d'aquelles factures que s'han facturat durant el mes de Març. 
-- (Taules: invoice, customers i orders).

SELECT i.id, c.first_name, c.last_name, i.amount_due
FROM invoices i JOIN orders o ON i.order_id = o.id JOIN customers c ON o.customer_id = c.id
WHERE i.invoice_date BETWEEN '2006-02-28 23:59:59.000' AND '2006-03-31 23:59:59.000';
















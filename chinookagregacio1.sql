-- CHINOOK - AGREGACIO 01

-- 1 Consulta quants àlbums hi ha a la base de dades.

SELECT Count(*) 
FROM Album a 


-- 2 Cerca quants grups (Artist) hi ha el nom dels quals comenci per l'article The.

SELECT COUNT(*)
FROM Artist a 
WHERE a.Name LIKE 'THE%'


-- 3 Cerca el nom dels tres grups dels quals hi ha més àlbums.

SELECT a.Name, a2.ArtistId 
FROM Artist a JOIN Album a2 ON a.ArtistId = a2.ArtistId
GROUP BY a2.ArtistId 
ORDER BY COUNT( a2.ArtistId) DESC 
LIMIT 3;


-- 4 Cerca la durada mitjana de totes les pistes. Volem el resultat en segons.

SELECT AVG(t.Milliseconds)/1000
FROM Track t 

-- 5 Cerca quantes pistes hi ha en què hi consti algun compositor.

SELECT COUNT(*)
FROM Track t 
WHERE t.Composer IS NULL

-- 6 Cerca quants minuts de música disposem del compositor Johann Sebastian Bach.

SELECT SUM(t.Milliseconds)/60000
FROM Track t 
WHERE t.Composer LIKE 'Johann Sebastian Bach'

-- 7 Cerca el preu mitjà per pista.

SELECT (SUM(t.UnitPrice )/COUNT(*))
FROM Track t 


-- 8 Cerca els diversos preus que tenen les pistes, i quantes n'hi ha de cadascun d'ells.

SELECT t.UnitPrice, COUNT(t.UnitPrice) as quantitat
FROM Track t 
GROUP BY t.UnitPrice 



















-- exercicis agregacio IES23
-- 5
SELECT g.id , g.nom, COUNT(u.idUsuari) as nombreUsuaris
FROM grups g JOIN usuaris u ON g.id = u.idGrup 
WHERE u.sexe = 'M' AND u.dataNaixement < '2001-01-01'
GROUP BY g.nom 
HAVING nombreUsuaris >= 5
ORDER BY nombreUsuaris DESC, g.nom;

-- 6 Mostra els cognoms1 de la taula usuaris que no es repeteixen (és a dir, 
-- no tenim més d'un usuari amb el mateix cognom1). Ordena els resultats per cognom1

SELECT u.cognom1Usuari as cognomUnic
FROM usuaris u 
GROUP BY cognomUnic 
HAVING COUNT(*) = 1
ORDER BY cognomUnic;


-- 7 Mostra els cognoms que almenys apareguin 3 vegades com a cognom1 i que no acabin 
-- per 'z' Ordena el resultat per freqüència d'aparició descendentment i desprès per cognom1

SELECT u.cognom1Usuari as cognom
FROM usuaris u 
WHERE u.cognom1Usuari NOT LIKE '%Z'
GROUP BY u.cognom1Usuari
HAVING COUNT(*) > 2
ORDER BY COUNT(*) DESC, cognom;


-- 8 Mostra el número total d'alumnes que hi ha (un alumne és un usuari amb rol 'A')

SELECT COUNT(*)
FROM usuaris u 
WHERE u.rol = 'A'

-- 9 Mostra, per cada rol, el rol, el número d'usuaris, la quantitat total de saldo i el promig del saldo

SELECT u.rol, COUNT(*), SUM(u.saldo), AVG(u.saldo)
FROM usuaris u 
GROUP BY u.rol


-- 10 (A partir de la taula grups_unitats_formatives i aules) Mostra, de les aules que tenen 
-- assignats grups, el seu identificador, el seu nom i el número d'unitats formatives que tenen assignades


SELECT a.id, a.nomaula, COUNT(guf.idunitatformativa)  
FROM grups_unitats_formatives guf JOIN aules a ON guf.idaula = a.id
GROUP BY  a.id, a.nomaula 


-- 11 (A partir de la taula grups_unitats_formatives i aules) Mostra, per cada aula, el seu nom, el seu identificador,
-- i el número d'unitats formatives que tenen assignades. Ordena el resultat per número d'unitats formatives descendentment i en cas d'empat, pel nom de l'aula


SELECT a.nomaula, a.id, COUNT(guf.idunitatformativa) as unitats_asignades
FROM aules a LEFT JOIN grups_unitats_formatives guf ON a.id = guf.idaula 
GROUP BY  a.nomaula, a.id
ORDER BY unitats_asignades DESC, a.nomaula;

-- 12 Mostra, respecte les aules que no tinguin cap unitat formativa assignada (aules sense us): el número total d'aules, la seva capacitat total, 
-- la capacitat mínima, la capacitat màxima, el promig de capacitat

SELECT COUNT(*), SUM(a.capacitat), MIN(a.capacitat), MAX(a.capacitat), AVG(a.capacitat)
FROM aules a LEFT JOIN grups_unitats_formatives guf ON a.id = guf.idaula 
WHERE guf.idunitatformativa IS NULL













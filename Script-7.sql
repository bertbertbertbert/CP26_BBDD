-- ies23 simulacro examen

-- 1
-- Mostra, en una única columna separada per '#',
-- el nom d’usuari, el rol i l’email.
-- Si l’email és NULL, mostra 'sense dades'.
-- Ordena pel llarg del nom d’usuari i després per idUsuari.

SELECT CONCAT(u.nomUsuari, "#", u.rol, "#", IFNULL(u.emailUsuari, 'sense dades'))
FROM usuaris u 

-- 2
-- Mostra l’idAlumne que ha fet més tasques diferents.
-- Mostra també el nombre total de tasques fetes.

SELECT ta.idalumne, COUNT(ta.idtasca)
FROM tasques_alumnes ta 
GROUP BY ta.idalumne 
HAVING  COUNT(ta.idtasca) =
(SELECT COUNT(DISTINCT ta.idtasca) as numTasques
FROM tasques_alumnes ta 
GROUP BY ta.idalumne 
ORDER BY numTasques DESC
LIMIT 1)

-- 3
-- Mostra l’idAlumne, el nom i cognoms de l’usuari
-- i, en una sola línia, el nom de les unitats formatives
-- en què està matriculat.

SELECT u.idUsuari, u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari, GROUP_CONCAT(uf.unitat)
FROM usuaris u JOIN alumnes_moduls am on u.idUsuari = am.idalumne 
JOIN moduls m ON am.idmodul = m.id
JOIN unitats_formatives uf ON m.id = uf.idmodul
GROUP BY u.idUsuari, u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari

-- 4
-- Mostra l’id i el nom dels alumnes
-- que no han fet cap tasca en cap convocatòria.

SELECT u.idUsuari, u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari
FROM usuaris u LEFT JOIN tasques_alumnes ta ON u.idUsuari = ta.idalumne
WHERE u.rol = 'A' AND ta.idalumne IS NULL

-- 5 (adaptat)
-- Mostra els alumnes amb almenys 5 qualificacions
-- i nota mitjana >= 5
-- Mostra també el nombre de qualificacions i la nota mitjana

SELECT q.idalumne, COUNT(q.id) as numQ, (AVG(nota1c) + AVG(nota2c))/2 as mitjana
FROM qualificacions q 
GROUP BY q.idalumne
HAVING numQ >= 5 AND mitjana >= 5

-- 6
-- Digues el mes (número) en què s’han registrat més tasques,
-- independentment de l’any.
-- Como no tenemos fecha, lo adaptamos a contar tareas por idtasca modulos

SELECT MONTH(Moment) AS mes, COUNT(idtasca) AS totalTasques
FROM tasques_alumnes
GROUP BY mes
ORDER BY totalTasques DESC
LIMIT 1;

-- Si no hay campo Moment, no se puede hacer por mes; habría que omitir o usar idtasca.

-- 7
-- Mostra, en una única columna i sense repeticions,
-- els cicles dels alumnes i dels grups.
-- Ordena alfabèticament.

SELECT cicle FROM usuaris
UNION
SELECT cicle FROM grups
ORDER BY cicle;

-- 8
-- Mostra l’idAlumne, el nom i cognoms
-- dels 10 últims alumnes que han fet alguna tasca.
-- Ordena el resultat final per cognom i nom.

SELECT t.idalumne, u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari
FROM (
  SELECT DISTINCT idalumne
  FROM tasques_alumnes
  ORDER BY idalumne DESC
  LIMIT 10
) AS t
JOIN usuaris u ON t.idalumne = u.idUsuari
ORDER BY u.cognom1Usuari, u.nomUsuari;

-- 9
-- Mostra el nom del mòdul i el nom de la unitat formativa
-- de les unitats que no tenen hores definides
-- o pertanyen a mòduls no obligatoris.

SELECT m.nom AS nomModul, uf.unitat AS nomUnitat
FROM unitats_formatives uf
JOIN moduls m ON uf.idmodul = m.id
WHERE uf.hores IS NULL OR m.obligatoria = 0;

-- 10
-- Mostra l’id de les unitats formatives
-- que no tenen cap tasca associada.

SELECT uf.id
FROM unitats_formatives uf
LEFT JOIN tasques t ON uf.id = t.idunitatformativa
WHERE t.idunitatformativa IS NULL;

-- 11
-- Mostra sense repeticions el nom i cognoms dels professors
-- que tutoritzen alumnes que tenen una nota mitjana superior a 7
-- en els seus mòduls.

SELECT DISTINCT u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari
FROM usuaris u
JOIN usuaris tuts ON u.idUsuari = tuts.tutor
JOIN qualificacions q ON tuts.idUsuari = q.idalumne
GROUP BY u.idUsuari
HAVING (SUM(IFNULL(q.nota1c,0)) + SUM(IFNULL(q.nota2c,0))) / (COUNT(*) * 2) > 7;

-- 12
-- Mostra, per cada alumne, el seu nom i cognoms,
-- el nombre total de mòduls que cursa
-- i la nota mitjana global, arrodonida cap amunt.
-- Si no cursa cap mòdul, mostra 0.

SELECT u.idUsuari, u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari,
       COUNT(DISTINCT q.idunitatformativa) AS numModuls,
       CEIL(
         COALESCE(
           (SUM(IFNULL(q.nota1c,0)) + SUM(IFNULL(q.nota2c,0))) / (COUNT(*) * 2), 
           0
         )
       ) AS notaMitjana
FROM usuaris u
LEFT JOIN qualificacions q ON u.idUsuari = q.idalumne
WHERE u.rol = 'A'
GROUP BY u.idUsuari, u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari;
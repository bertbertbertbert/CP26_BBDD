-- Test: ies23 - barrejades 02

-- 1 Mostra l'idUsuari dels 10 últims usuaris (diferents) que han accedit (taula registre). Ordena els resultats per l'idUsuari.

SELECT t.* 
FROM (SELECT idUsuari 
      FROM registre r 
      GROUP BY idUsuari 
      ORDER BY max(Moment) 
      DESC 
      LIMIT 10) as t 
ORDER BY t.idUsuari

-- 2 Mostra, per cada usuari que s'hagi logejat, el seu idUsuari, el moment de l'últim accés, el moment del primer accés i el número d'accessos que ha fet

SELECT r.idUsuari, MAX(r.Moment), MIN(r.Moment), COUNT(r.Moment) 
FROM registre r 
GROUP BY r.idUsuari

-- 3 Mostrar l'idUsuari, el nom, cognoms dels usuaris actius amb rol 'A' que hagin accedit més de 10 vegades

SELECT r.idUsuari, u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari 
FROM usuaris u JOIN registre r ON u.idUsuari = r.idUsuari 
WHERE u.rol like 'A' and u.actiu = 1 
GROUP BY r.idUsuari, u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari 
HAVING COUNT(r.Moment) > 10

-- 4 Mostrar el nom i cognoms dels usuaris que no han accedit mai. Ordena els resultats per cognom1, cognom2, nom

SELECT u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari 
FROM usuaris u LEFT JOIN registre r ON u.idUsuari = r.idUsuari 
WHERE r.Moment IS NULL 
GROUP BY r.idUsuari, u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari 
ORDER BY u.cognom1Usuari, u.cognom2Usuari, u.nomUsuari

-- 5 Saber el nom i cognoms de l'usuari que més vegades han accedit, sense fer terrorisme. Ordena el resultat per cognom1, cognom2, nom
-- (Alerta: podríem tenir més d'un usuari en aquesta situació)

SELECT u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari 
FROM usuaris u JOIN registre r ON u.idUsuari = r.idUsuari 
GROUP BY r.idUsuari, u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari 
HAVING COUNT(r.Moment)=(SELECT COUNT(r.Moment) 
                        FROM usuaris u2 JOIN registre r ON u2.idUsuari = r.idUsuari 
                        GROUP BY r.idUsuari 
                        ORDER BY COUNT(r.Moment) 
                        DESC 
                        LIMIT 1) 
ORDER BY u.cognom1Usuari, u.cognom2Usuari, u.nomUsuari

-- 6 Mostrar el nom i cognoms dels 10 últims usuaris que han accedit al sistema ordenant el resultat per cognom1, cognom2, nom

SELECT t.* 
FROM ( SELECT DISTINCT u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari 
	   FROM registre r JOIN usuaris u ON u.idUsuari = r.idUsuari 
	   GROUP BY r.idUsuari, u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari 
	   ORDER BY MAX(r.Moment) DESC 
	   LIMIT 10) AS t 
ORDER BY t.cognom1Usuari, t.cognom2Usuari, t.nomUsuari
	       
-- 7 Mostrar els noms dels usuaris que es repeteixen almenys 5 vegades a la taula usuaris

SELECT u.nomUsuari 
FROM usuaris u 
GROUP BY nomUsuari 
HAVING COUNT(nomUsuari) >= 5

-- 8 Saber, per cada rol, quants usuaris actius hi ha

SELECT u.rol, COUNT(u.idUsuari ) 
FROM usuaris u 
WHERE u.actiu = 1 
GROUP BY u.rol
	       
-- 9 Saber els noms dels usuaris que es repeteixen i que tenen assignat un rol diferent. Ordeneu el resultat per nom

SELECT DISTINCT u.nomUsuari 
FROM usuaris u JOIN usuaris u2 ON u.nomUsuari = u2.nomUsuari 
WHERE u.rol != u2.rol 
ORDER BY u.nomUsuari

-- 10 Mostrar el nom, cognoms dels usuaris on tant el seu nom, cognom1, cognom2 tenen dues 'A' almenys.

SELECT u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari 
FROM usuaris u 
WHERE u.nomUsuari LIKE '%a%a%' AND u.cognom1Usuari LIKE '%a%a%' AND u.cognom2Usuari LIKE '%a%a%'

-- 11 Mostra, en una única columna, el cognom dels usuaris, tant si apareixen com a primer cognom com a segon cognom. Els cognoms no han de ser NULL. 
-- Ordena alfabèticament els resultats

SELECT u.cognom1Usuari 
FROM usuaris u 
WHERE u.cognom1Usuari IS NOT NULL 
UNION 
SELECT u.cognom2Usuari 
FROM usuaris u 
WHERE u.cognom2Usuari IS NOT NULL 
ORDER BY 1




	       
	       
	       
	       
	       
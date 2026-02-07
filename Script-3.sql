-- barejades2 ies23

-- 3 Mostrar l'idUsuari, el nom, cognoms dels usuaris actius amb rol 'A' que hagin accedit més de 10 vegades

SELECT u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari
FROM usuaris u LEFT JOIN registre r ON u.idUsuari = r.idUsuari
WHERE r.Moment IS NULL
GROUP BY r.idUsuari 
ORDER BY  u.cognom1Usuari, u.cognom2Usuari, u.nomUsuari 


-- 4 Saber el nom i cognoms de l'usuari que més vegades han accedit, sense fer terrorisme. Ordena el resultat per 
-- cognom1, cognom2, nom

SELECT u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari
FROM usuaris u JOIN registre r ON u.idUsuari = r.idUsuari
GROUP BY r.idUsuari, u.nomUsuari, u.cognom1Usuari, u.cognom2Usuari
HAVING COUNT(r.Moment)=(SELECT COUNT(r.Moment) 
                       FROM usuaris u2 JOIN registre r ON u2.idUsuari = r.idUsuari 
                       GROUP BY r.idUsuari 
                       ORDER BY COUNT(r.Moment) DESC 
                       LIMIT 1)
ORDER BY u.cognom1Usuari,  u.cognom2Usuari, u.nomUsuari
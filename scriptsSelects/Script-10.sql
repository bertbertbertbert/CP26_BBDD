-- ejercicios institut

use institut;

-- Inserta un profesor llamado “Elena Torres”, DNI 45678901, teléfono 555111222, dirección “C/ Primavera 5”.

insert into professors (DNI, nom, adreça, telefon) values
(45678901, "Elena Torres", "C/ Primavera 5", 555111222);

-- Cambia el nombre del alumno con numero_expediente = 1 a “Alberto H.”

update alumne 
set nombre_alumno = "Alberto H."
where numero_expediente = 1;



-- Añade una columna codi_modul tipo INT a la tabla Grup.

alter table grup 
add codi_modul int 


-- Cambia el tipo de la columna nom en Professors a VARCHAR(50).

alter table professors 
modify nom VARCHAR(50);

-- Renombra la columna nom de Alumne a nombre_alumno.

alter table alumne 
change nom nombre_alumno VARCHAR(30)

-- Añade una FK en Alumne que apunte a Grup(codi).

ALTER TABLE Alumne
ADD FOREIGN KEY (codi_grup) REFERENCES Grup(codi);

-- Haz que delegat_id en Grup sea único.

alter table grup 
add unique (delegat_id)

-- Crea un índice en Alumne para la columna codi_grup.











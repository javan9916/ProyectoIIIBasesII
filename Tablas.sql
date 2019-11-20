create table Esclavos(
	usuario			VARCHAR(50) PRIMARY KEY NOT NULL,
	contraseña		VARCHAR(20) NOT NULL,
	direccion_ip	VARCHAR(15) CHECK(direccion_ip LIKE '%_%.%_%.%_%.%_%' AND direccion_ip NOT LIKE '%.%.%.%.%' AND 
										(ParseName(direccion_ip, 4) BETWEEN 0 AND 255) 
										AND (ParseName(direccion_ip, 3) BETWEEN 0 AND 255) 
										AND (ParseName(direccion_ip, 2) BETWEEN 0 AND 255) 
										AND (ParseName(direccion_ip, 1) BETWEEN 0 AND 255)) NOT NULL,
	nombre_db		VARCHAR(50)	NOT NULL
);

create table Profesores(
	codigo		int primary key,
	nombre		varchar(200) not null,
	contraseña	varchar(15)	 not null
);

create table Estudiantes(
	codigo		int primary key,
	nombre		varchar(200) not null,
	contraseña	varchar(15)	 not null
);
drop table Cursos
create table Cursos(
	codigo		int primary key,
	nombre		varchar(200) not null,
	activo		bit not null -- 1 TRUE 0 FALSE
);

create table Profesores_Cursos(
	codigo_profesor int foreign key (codigo_profesor) references Profesores(codigo),
	codigo_curso	int foreign key (codigo_curso) references Cursos(codigo),
);

create table Estudiantes_Cursos(
	codigo_estudiante int foreign key (codigo_estudiante) references Estudiantes(codigo),
	codigo_curso	  int foreign key (codigo_curso) references Cursos(codigo),
);

create table Mensajes(
	codigo		int primary key,
	emisor		int,
	receptor	int,
	mensaje		varchar(500) not null,
);

alter table Mensajes add constraint fk_emisor_e foreign key (emisor) references Estudiantes;
alter table Mensajes add constraint fk_emisor_p foreign key (emisor) references Profesores;
alter table Mensajes add constraint fk_receptor_e foreign key (receptor) references Estudiantes;
alter table Mensajes add constraint fk_receptor_p foreign key (receptor) references Profesores;
alter table Mensajes add constraint fk_receptor_c foreign key (receptor) references Estudiantes;

INSERT INTO Estudiantes (codigo,nombre,contraseña) values (1,'Jazmine','12');
INSERT INTO Estudiantes (codigo,nombre,contraseña) values (2,'Roberto','123');

INSERT INTO Cursos (codigo,nombre,activo) values (1,'Bases de Datos',1);
INSERT INTO Cursos (codigo,nombre,activo) values (2,'Probabilidades',1);
INSERT INTO Cursos (codigo,nombre,activo) values (3,'Taller de Programacion',0);

INSERT INTO Profesores (codigo,nombre,contraseña) values (1,'LeoViquez','12345');
INSERT INTO Profesores (codigo,nombre,contraseña) values (2,'EstebanB','0123');
INSERT INTO Profesores (codigo,nombre,contraseña) values (3,'VeraG','012');


INSERT INTO Estudiantes_Cursos (codigo_curso,codigo_estudiante) values (3,2);
INSERT INTO Profesores_Cursos (codigo_curso,codigo_profesor) values (3,3);

INSERT INTO Mensajes (codigo,emisor,receptor,mensaje) values (1,1,1,'Hola');

SELECT * FROM Estudiantes_Cursos;

--Consulta buscar nombre de id de la tabla Mensajes
SELECT nombre
FROM Cursos
INNER JOIN Estudiantes_Cursos
ON Estudiantes_Cursos.codigo_estudiante = 2;

---DROP PROCEDURE Agregar_Esclavo

CREATE PROCEDURE Agregar_Esclavo
@usuario VARCHAR(50), @contraseña VARCHAR(20), @direccion_ip VARCHAR(15), @nombre_db VARCHAR(50)
AS
BEGIN
	INSERT INTO Esclavos(usuario, contraseña, direccion_ip, nombre_db)
	VALUES (@usuario, @contraseña, @direccion_ip, @nombre_db)
END

EXECUTE Agregar_Esclavo @usuario = 'roberto', @contraseña = '123', @direccion_ip = '126.123.64.7', @nombre_db = 'Eslave1'


CREATE PROCEDURE Mostrar_Cursos_Estudiantes
@codigo_estudiante as int, @activo as bit
AS
BEGIN
	SELECT codigo, nombre FROM (Cursos INNER JOIN Estudiantes_Cursos ON 
		Estudiantes_Cursos.codigo_curso = codigo and Estudiantes_Cursos.codigo_estudiante = @codigo_estudiante)
		where activo = @activo

END
GO

EXECUTE Mostrar_Cursos_Estudiantes @codigo_estudiante = 2, @activo = 0


CREATE PROCEDURE Mostrar_Cursos_Profesores
@codigo_profesor as int, @activo as bit
AS
BEGIN
	SELECT codigo, nombre FROM (Cursos INNER JOIN Profesores_Cursos ON 
		Profesores_Cursos.codigo_curso = codigo and Profesores_Cursos.codigo_profesor = @codigo_profesor)
		where activo = @activo

END
GO

EXECUTE Mostrar_Cursos_Profesores @codigo_profesor = 2, @activo = 1




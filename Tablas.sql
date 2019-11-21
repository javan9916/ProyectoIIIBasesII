-- Tabla para almacenar las bases replicadas, solo estará presente en la madre
create table Esclavos(
	usuario			VARCHAR(50) NOT NULL,
	contraseña		VARCHAR(20) NOT NULL,
	direccion_ip	VARCHAR(15) CHECK(direccion_ip LIKE '%_%.%_%.%_%.%_%' AND direccion_ip NOT LIKE '%.%.%.%.%' AND 
										(ParseName(direccion_ip, 4) BETWEEN 0 AND 255) 
										AND (ParseName(direccion_ip, 3) BETWEEN 0 AND 255) 
										AND (ParseName(direccion_ip, 2) BETWEEN 0 AND 255) 
										AND (ParseName(direccion_ip, 1) BETWEEN 0 AND 255)) NOT NULL,
	nombre_db		VARCHAR(50)	NOT NULL,
	ubicacion		GEOGRAPHY	NOT NULL
);

insert into Esclavos (usuario,contraseña,direccion_ip,nombre_db,ubicacion) values ('sa','2018100294','172.24.80.4','distribution-master',
		geography::Point(10.3659267,-84.5114403, 4326));
-- Coordenada del TEC

insert into Esclavos (usuario,contraseña,direccion_ip,nombre_db,ubicacion) values ('sa','12345','126.123.64.7','eslave1',
		geography::Point(10.3125638,-84.4168282, 4326));
--Coordenada de La Isla (Casa de Roberto XD)

select * from Esclavos;

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

create table Cursos(
	codigo		int primary key,
	nombre		varchar(200) not null,
	activo		bit not null -- 1 TRUE 0 FALSE
);

-- Tabla intermedia entre profesores y cursos
create table Profesores_Cursos(
	codigo_profesor int foreign key (codigo_profesor) references Profesores(codigo),
	codigo_curso	int foreign key (codigo_curso) references Cursos(codigo),
);

-- Tabla intermedia entre estudiantes y cursos
create table Estudiantes_Cursos(
	codigo_estudiante int foreign key (codigo_estudiante) references Estudiantes(codigo),
	codigo_curso	  int foreign key (codigo_curso) references Cursos(codigo),
);

-- Mensajes a nivel general
-- TIPO: Estudiante-Estudiante = 0, Estudiante-Profesor = 1, Estudiante-Grupo = 3, Profesor-Grupo = 4
create table Mensajes(
	tipo			int not null, 
	emisor			int not null,
	receptor		int not null,
	mensaje			varchar(500) not null,
	codigo_curso	int foreign key (codigo_curso) references Cursos(codigo)
);

-- Foreign Key de todas las tablas posibles emisoras y receptoras
alter table Mensajes add constraint fk_emisor_e foreign key (emisor) references Estudiantes;
alter table Mensajes add constraint fk_emisor_p foreign key (emisor) references Profesores;
alter table Mensajes add constraint fk_receptor_e foreign key (receptor) references Estudiantes;
alter table Mensajes add constraint fk_receptor_p foreign key (receptor) references Profesores;
alter table Mensajes add constraint fk_receptor_c foreign key (receptor) references Cursos;

--Consulta buscar nombre de id de la tabla Mensajes
SELECT nombre
FROM Cursos
INNER JOIN Estudiantes_Cursos
ON Estudiantes_Cursos.codigo_estudiante = 2;

---DROP PROCEDURE Agregar_Esclavo

CREATE PROCEDURE Agregar_Esclavo
@usuario VARCHAR(50), @contraseña VARCHAR(20), @direccion_ip VARCHAR(15), @nombre_db VARCHAR(50), @ubicacion GEOGRAPHY
AS
BEGIN
	INSERT INTO Esclavos(usuario, contraseña, direccion_ip, nombre_db, ubicacion)
	VALUES (@usuario, @contraseña, @direccion_ip, @nombre_db, @ubicacion)
END

--EXECUTE Agregar_Esclavo @usuario = 'roberto', @contraseña = '123', @direccion_ip = '126.123.64.7', @nombre_db = 'Eslave1', @ubicacion = geography::Point(10.3125638,-84.4168282, 4326);


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

EXECUTE Mostrar_Cursos_Profesores @codigo_profesor = 6, @activo = 1


CREATE PROCEDURE Mostrar_Estudiantes_Curso
@codigo_curso as int
AS
BEGIN
	SELECT nombre FROM (Estudiantes INNER JOIN Estudiantes_Cursos ON 
		Estudiantes_Cursos.codigo_curso = @codigo_curso and Estudiantes_Cursos.codigo_estudiante = codigo)
END
GO

EXECUTE Mostrar_Estudiantes_Curso @codigo_curso = 3


CREATE PROCEDURE Mostrar_Profesores_Curso
@codigo_curso as int
AS
BEGIN
	SELECT nombre FROM (Profesores INNER JOIN Profesores_Cursos ON 
		Profesores_Cursos.codigo_curso = @codigo_curso and Profesores_Cursos.codigo_profesor = codigo)
END
GO

EXECUTE Mostrar_Profesores_Curso @codigo_curso = 1

-- Busca el usuario mas cercano a partir de la latitud y longitud actual del usuario 
CREATE PROCEDURE Buscar_Esclavo_Cercano
@latitud as float, @longitud as float
AS
DECLARE @ubicacion_actual geography = 
		Geography::STPointFromText('POINT(' + CAST(@latitud AS VARCHAR(20)) + ' ' + CAST(@longitud AS VARCHAR(20)) + ')', 4326)
	
BEGIN
	SELECT TOP 1 usuario,contraseña,direccion_ip,nombre_db, CONVERT(DECIMAL(12,2),ubicacion.STDistance(@ubicacion_actual)) distancia
	FROM Esclavos
	ORDER BY distancia asc
END
GO

drop procedure Buscar_Esclavo_Cercano

-- Se debe declarar primero una variable para poder enviar un dato geography a un procedimiento
DECLARE @geographyPoint geography = geography::Point('10.3642467','-84.4747213', '4326');
-- Coordenada de Florencia

EXECUTE Buscar_Esclavo_Cercano @latitud = -84.4747213, @longitud = 10.3642467;

SELECT ubicacion.STAsText() from Esclavos;

-- Insertar Mensajes
CREATE PROCEDURE Insertar_Mensaje
@tipo as int, @emisor as int, @receptor as int, @mensaje as varchar(500), @codigo_curso as int
AS
BEGIN
	INSERT INTO Mensajes (tipo,emisor,receptor,mensaje,codigo_curso) VALUES (@tipo,@emisor,@receptor,@mensaje,@codigo_curso);
END
GO

CREATE PROCEDURE Ver_Mensajes_E_E
@emisor as int, @receptor as int
AS
BEGIN
	
END
GO

SELECT * FROM Mensajes

-- INSERTS 
INSERT INTO Estudiantes (codigo,nombre,contraseña) values (1,'Jazmine','12');
INSERT INTO Estudiantes (codigo,nombre,contraseña) values (2,'Roberto','123');
INSERT INTO Estudiantes (codigo,nombre,contraseña) values (3,'Javier','1234');
INSERT INTO Estudiantes (codigo,nombre,contraseña) values (4,'Jesus','12345');
INSERT INTO Estudiantes (codigo,nombre,contraseña) values (5,'Kevin','123456');

INSERT INTO Cursos (codigo,nombre,activo) values (1,'Bases de Datos 2',1);
INSERT INTO Cursos (codigo,nombre,activo) values (2,'Probabilidades',1);
INSERT INTO Cursos (codigo,nombre,activo) values (3,'Taller de Programacion',0);
INSERT INTO Cursos (codigo,nombre,activo) values (4,'Matematica Discreta',0);
INSERT INTO Cursos (codigo,nombre,activo) values (5,'Lenguajes de Programacion',1);

INSERT INTO Profesores (codigo,nombre,contraseña) values (6,'LeoViquez','012');
INSERT INTO Profesores (codigo,nombre,contraseña) values (7,'EstebanB','0123');
INSERT INTO Profesores (codigo,nombre,contraseña) values (8,'VeraG','01234');
INSERT INTO Profesores (codigo,nombre,contraseña) values (9,'KarinaG','012345')
INSERT INTO Profesores (codigo,nombre,contraseña) values (10,'OscarViquez','012346');

-- RELACION ESTUDIANTES CURSOS
-- Bases de Datos 2 --> Jazmine, Roberto y Javier
INSERT INTO Estudiantes_Cursos (codigo_curso,codigo_estudiante) values (1,1);
INSERT INTO Estudiantes_Cursos (codigo_curso,codigo_estudiante) values (1,2);
INSERT INTO Estudiantes_Cursos (codigo_curso,codigo_estudiante) values (1,3);
-- Probabilidades --> Roberto y Javier
INSERT INTO Estudiantes_Cursos (codigo_curso,codigo_estudiante) values (2,2);
INSERT INTO Estudiantes_Cursos (codigo_curso,codigo_estudiante) values (2,3);
-- Taller de Programacion --> Jesus, Kevin, Jazmine, Roberto, Javier
INSERT INTO Estudiantes_Cursos (codigo_curso,codigo_estudiante) values (3,1);
INSERT INTO Estudiantes_Cursos (codigo_curso,codigo_estudiante) values (3,2);
INSERT INTO Estudiantes_Cursos (codigo_curso,codigo_estudiante) values (3,3);
INSERT INTO Estudiantes_Cursos (codigo_curso,codigo_estudiante) values (3,4);
INSERT INTO Estudiantes_Cursos (codigo_curso,codigo_estudiante) values (3,5);
-- Matematica Discreta --> Jesus y Kevin
INSERT INTO Estudiantes_Cursos (codigo_curso,codigo_estudiante) values (4,4);
INSERT INTO Estudiantes_Cursos (codigo_curso,codigo_estudiante) values (4,5);
-- Lenguajes --> Jazmine y Roberto
INSERT INTO Estudiantes_Cursos (codigo_curso,codigo_estudiante) values (5,1);
INSERT INTO Estudiantes_Cursos (codigo_curso,codigo_estudiante) values (5,2);

-- RELACION PROFESORES CURSOS
-- Bases de Datos 2 --> LeoViquez
INSERT INTO Profesores_Cursos (codigo_curso,codigo_profesor) values (1,6);
-- Probabilidades --> EstebanB
INSERT INTO Profesores_Cursos (codigo_curso,codigo_profesor) values (2,7);
-- Taller de Programacion --> VeraG
INSERT INTO Profesores_Cursos (codigo_curso,codigo_profesor) values (3,8);
-- Matematica Discreta --> KarinaG
INSERT INTO Profesores_Cursos (codigo_curso,codigo_profesor) values (4,9);
-- Lenguajes de Programacion
INSERT INTO Profesores_Cursos (codigo_curso,codigo_profesor) values (5,10);

SELECT * FROM Estudiantes;
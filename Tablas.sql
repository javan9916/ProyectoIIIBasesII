
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
--drop table Cursos
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

SELECT * FROM Cursos;

SELECT * FROM Estudiantes_Cursos;
SELECT * FROM Profesores;

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

go
CREATE PROCEDURE Mostrar_Cursos_Profesores
@codigo_profesor as int, @activo as bit
AS
BEGIN
	SELECT codigo, nombre FROM (Cursos INNER JOIN Profesores_Cursos ON 
		Profesores_Cursos.codigo_curso = codigo and Profesores_Cursos.codigo_profesor = @codigo_profesor)
		where activo = @activo

END
GO

Select * from Profesores_Cursos

EXECUTE Mostrar_Cursos_Profesores @codigo_profesor = 3, @activo = 0


CREATE PROCEDURE Mostrar_Estudiantes_Curso
@codigo_curso as int
AS
BEGIN
	SELECT nombre FROM (Estudiantes INNER JOIN Estudiantes_Cursos ON 
		Estudiantes_Cursos.codigo_curso = @codigo_curso and Estudiantes_Cursos.codigo_estudiante = codigo)
END
GO

EXECUTE Mostrar_Estudiantes_Curso @codigo_curso = 2


CREATE PROCEDURE Mostrar_Profesores_Curso
@codigo_curso as int
AS
BEGIN
	SELECT nombre FROM (Profesores INNER JOIN Profesores_Cursos ON 
		Profesores_Cursos.codigo_curso = @codigo_curso and Profesores_Cursos.codigo_profesor = codigo)
END
GO

EXECUTE Mostrar_Profesores_Curso @codigo_curso = 1


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

--drop procedure Buscar_Esclavo_Cercano

-- Se debe declarar primero una variable para poder enviar un dato geography a un procedimiento
--DECLARE @geographyPoint geography = geography::Point('10.3642467','-84.4747213', '4326');
-- Coordenada de Florencia

EXECUTE Buscar_Esclavo_Cercano @latitud = -84.4747213, @longitud = 10.3642467;

SELECT ubicacion.STAsText() from Esclavos

--Iniciar Sesion

--Drop procedure LOGEO
CREATE PROCEDURE LOGEO(
	@Usuario varchar(25),
	@Contraseña varchar(25)
)
as 
begin 
 
	DECLARE @Sesiones AS INTEGER;

	Set @Sesiones = (select COUNT(*) from Profesores
		where codigo=@Usuario and contraseña=@Contraseña)

	Set @Sesiones = @Sesiones + (select COUNT(*) from Profesores
		where codigo=@Usuario and contraseña=@Contraseña)

	Select @Sesiones

end

EXECUTE LOGEO @Usuario='1', @Contraseña = '12345';



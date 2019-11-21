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

--EXECUTE LOGEO @Usuario='1', @Contraseña = '12345';

go
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


--EXECUTE Buscar_Esclavo_Cercano @latitud = -84.4747213, @longitud = 10.3642467;
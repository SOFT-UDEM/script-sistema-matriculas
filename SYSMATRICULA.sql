USE master

IF EXISTS (SELECT * FROM SYS.DATABASES WHERE NAME='BDDSISTEMA') 
	BEGIN

	ALTER DATABASE BDDSISTEMA SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE BDDSISTEMA;
	END

	CREATE DATABASE BDDSISTEMA;
	GO

	USE BDDSISTEMA;
	GO
	CREATE TABLE FACULTAD
		(Idfacultad int primary key identity,
			Namfaclt varchar(60))


	CREATE TABLE ALUMNO
	 ( Cod_alumno int primary key identity,
		Nam_alumno 	varchar(65),
		Apellido varchar(65),
		carnet varchar(65),
		IdCarrera int,
		AnioCursado varchar(8),
		address1 varchar(100),
		Fecha_nac datetime,
		Genero varchar (8),
		num_matricula varchar(12),
		tutor varchar(65),
		CedulAlumn varchar(30),
		CelAlumn varchar(30),
		telAlumn varchar(30)
		)

	CREATE TABLE CARRERA
	( Cod_carrera int primary key identity,
		desc_carrera varchar(200),
		Nam_carrera varchar(65),
		IdCarrera int foreign key(IdCarrera) references FACULTAD(Idfacultad))

	CREATE TABLE MATERIA
		(IdCarreraMateria int foreign key(IdCarreraMateria) references CARRERA(Cod_carrera),
			cod_materia int primary key identity,
			credito int,
			Nam_materia varchar(30),
			cuatimestre int)

	CREATE TABLE PROFESOR
		(apellprof varchar(45),
			IdMateria int foreign key(IdMateria) references MATERIA(cod_materia),
			cod_profesor int primary key identity,
			Dom_Prof varchar(200),
			FecNac_Prof datetime,
			Gradprof varchar(30),
			grupo varchar(6),
			Nam_profesor varchar(30),
			CedProf varchar(16),
			CelProf varchar(8),
			TelProf varchar(8))

	CREATE TABLE CAJA
		(IdCarrera int foreign key(IdCarrera) references CARRERA(Cod_carrera),
			IdAlumno int foreign key(IdAlumno) references ALUMNO(Cod_alumno),
			IdCajero int,
			ConceptoIng varchar(200),
			fechaIng datetime,
			IdCaja int primary key identity,
			MontoIng money,
			NamKgro varchar(35),
			TipoIng varchar(12),
			TipoMoneda varchar(10))

	
	CREATE TABLE GRUPO
		(IdGrupo int primary key,
			IdCarrera int foreign key(IdCarrera) references CARRERA(Cod_carrera),
			IdMateria int foreign key(IdMateria) references MATERIA(Cod_Materia),
			IdAlumno int foreign key(IdAlumno) references ALUMNO(Cod_alumno),
			IdProfesor int foreign key(IdProfesor) references PROFESOR(Cod_Profesor))


--Creando procedimiento almacenado de la tabla ALUMNO.
CREATE PROCEDURE SpAlumno
(
	--Parametros o variables de entrada INPUT, identicos a los de la tabla Alumno.
	@Cod_alumno int,
	@Nam_alumno varchar(65),
	@Apellido varchar(65),
	@carnet varchar(65),
	@IdCarrera INT,
	@AnioCursado varchar(8),
	@address1 varchar(100),
	@Fecha_nac datetime,
	@Genero varchar (8),
	@num_matricula varchar(12),
	@tutor varchar(65),
	@CedulAlumn varchar(30),
	@CelAlumn varchar(30),
	@telAlumn varchar(30),
	--Parametro o variable de trabajo Work.
	@W_Operacion varchar(10),
	@O_Mensaje varchar(255) OUTPUT
)
AS
BEGIN
	BEGIN TRY
	--Validar tipo de operación "I" es INSERT
	IF (@W_Operacion = 'I')
	BEGIN
		INSERT INTO BDDSISTEMA..ALUMNO
		(
			Nam_alumno,
			Apellido,
			carnet,
			IdCarrera,
			AnioCursado,
			address1,
			Fecha_nac,
			Genero,
			num_matricula,
			tutor,
			CedulAlumn,
			CelAlumn,
			telAlumn
		)
		VALUES
		(
			@Nam_alumno,
			@Apellido,
			@carnet,
			@IdCarrera,
			@AnioCursado,
			@address1,
			@Fecha_nac,
			@Genero,
			@num_matricula,
			@tutor,
			@CedulAlumn,
			@CelAlumn,
			@telAlumn
		)
		SELECT @O_Mensaje = 'SE HA INSERTADO CORRECTAMENTE EN LA TABLA ALUMNO.'
	END
	--fin de isertado.
	--Validar tipo de operación "U" es UPDATE
	IF (@W_Operacion = 'U')
	BEGIN
		UPDATE BDDSISTEMA..ALUMNO 
			SET
				Nam_alumno = @Nam_alumno,
				Apellido = @Apellido,
				IdCarrera = @IdCarrera,
				AnioCursado = @AnioCursado,
				address1 = @address1,
				Fecha_nac = @Fecha_nac,
				Genero = @Genero,
				num_matricula = @num_matricula,
				tutor = @tutor,
				CedulAlumn = @CedulAlumn,
				CelAlumn = @CelAlumn,
				telAlumn = @telAlumn				
			WHERE carnet = @carnet
			SELECT @O_Mensaje = 'SE HA ACTUALIZADO CORRECTAMENTE UN REGISTRO DE LA TABLA ALUMNO.'
	END
	--fin de actualizado.
	--Validar tipo de operación "S" es SELECT.
	IF (@W_Operacion = 'S')
	BEGIN
		SELECT Cod_alumno, Nam_alumno, Apellido, IdCarrera, AnioCursado, address1, Fecha_nac, Genero, num_matricula, tutor, CedulAlumn, CelAlumn, telAlumn, carnet FROM BDDSISTEMA..ALUMNO
		SELECT @O_Mensaje = 'SE REALIZO UN SELECT CORRECTAMENTE A LA TABLA ALUMNO.'
	END
	--fin de select.
	--Validar tipo de operación "D" es DELETE.
	IF (@W_Operacion = 'D')
	BEGIN
		DELETE BDDSISTEMA..ALUMNO WHERE Cod_alumno = @Cod_alumno
		SELECT @O_Mensaje = 'SE HA ELIMINADO UN REGISTRO DE LA TABLA ALUMNO.'
	END
	--fin de delete.
	END TRY
	BEGIN CATCH
		-- Si ocurrio un error lo notificamos.
		SELECT @O_Mensaje = 'ERROR: ' + ERROR_MESSAGE() + 'EN LINEA: ' + CONVERT(VARCHAR, ERROR_LINE() )
	END CATCH
END
GO
--FIN SP de la tabla Alumno.
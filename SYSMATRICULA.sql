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
		AñoCursado varchar(8),
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











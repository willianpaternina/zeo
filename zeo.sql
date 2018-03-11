SELECT IF(EXISTS (SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'zeo'), 'Si','No') 
AS 'EXISTE LA BASES DE DATOS ZEO';
CREATE DATABASE IF NOT EXISTS zeo CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER 'wapr'@'localhost' IDENTIFIED BY 'Unisinu2018';
GRANT ALL ON zeo.* TO 'wapr'@'localhost' IDENTIFIED BY 'Unisinu2018' WITH GRANT OPTION;
FLUSH PRIVILEGES;
USE zeo;

-- DROP USER 'wapr'@'localhost';

CREATE  TABLE IF NOT EXISTS Roles 
(
	idRol INT NOT NULL AUTO_INCREMENT,
	rol VARCHAR (35) NOT NULL,
	detalle VARCHAR (200) NOT NULL,
	CONSTRAINT PK_Roles PRIMARY KEY (idRol)
) ENGINE = InnoDB;

INSERT INTO Roles (rol, detalle) VALUES ('ADMINISTRADOR', 'ADMINISTRAR');
INSERT INTO Roles (rol, detalle) VALUES ('PACIENTE', 'CONSULTAR');
INSERT INTO Roles (rol, detalle) VALUES ('MEDICO', 'GESTIONAR');
INSERT INTO Roles (rol, detalle) VALUES ('AUXILIAR', 'REPORTAR');

CREATE  TABLE IF NOT EXISTS Administradores 
(
	idAdministrador INT (11) NOT NULL AUTO_INCREMENT ,
	codigo VARCHAR (60) NOT NULL,
	Rol INT (11) NOT NULL DEFAULT 1,
	tipoidentificacion CHAR(2) NOT NULL ,
	identificacion BIGINT NOT NULL ,
	nombre VARCHAR(25) NOT NULL ,
	apellido VARCHAR(35) NOT NULL ,
	apellidocasada VARCHAR (35) NULL,
	genero CHAR(1) NOT NULL ,
	fechanacimiento DATE NOT NULL ,
	tiposangre CHAR(4) NOT NULL ,
	telefono BIGINT(7) NULL ,
	celular BIGINT(10) NOT NULL ,
	estadocivil VARCHAR (35) NOT NULL,
	ocupacion VARCHAR (80) NOT NULL,
	religion VARCHAR (50) NULL,
	pais VARCHAR(35) NOT NULL ,
	departamento VARCHAR(50) NOT NULL ,
	municipio VARCHAR(60) NOT NULL ,
	domicilio VARCHAR(120) NOT NULL ,
	email VARCHAR(200) NOT NULL,
	clave VARCHAR(60) NOT NULL ,
	fecharegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	estado INT (1) NOT NULL,
	CONSTRAINT PK_Administradores PRIMARY KEY (idAdministrador),
	INDEX FK_Administradores_Roles_INDEX (Rol ASC) ,
	CONSTRAINT FK_Administradores_Rol FOREIGN KEY (Rol) REFERENCES Roles (idRol) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT UC_Administradores UNIQUE (identificacion, telefono, celular, email)
) ENGINE = InnoDB;

CREATE  TABLE IF NOT EXISTS Pacientes 
(
	idPaciente INT (11) NOT NULL AUTO_INCREMENT ,
	codigo VARCHAR (60) NOT NULL,
	Rol INT (11) NOT NULL DEFAULT 2,
	tipoidentificacion CHAR(2) NOT NULL ,
	identificacion BIGINT NOT NULL ,
	nombre VARCHAR(25) NOT NULL ,
	apellido VARCHAR(35) NOT NULL ,
	apellidocasada VARCHAR (35) NULL,
	genero CHAR(1) NOT NULL ,
	fechanacimiento DATE NOT NULL ,
	tiposangre CHAR(4) NOT NULL ,
	telefono BIGINT(7) NULL ,
	celular BIGINT(10) NOT NULL ,
	estadocivil VARCHAR (35) NOT NULL,
	ocupacion VARCHAR (80) NOT NULL,
	religion VARCHAR (50) NULL,
	pais VARCHAR(35) NOT NULL ,
	departamento VARCHAR(50) NOT NULL ,
	municipio VARCHAR(60) NOT NULL ,
	domicilio VARCHAR(120) NOT NULL ,
	email VARCHAR(200) NOT NULL,
	clave VARCHAR(60) NOT NULL ,
	fecharegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	estado INT (1) NOT NULL,
	CONSTRAINT PK_Pacientes PRIMARY KEY (idPaciente),
	INDEX FK_Pacientes_Roles_INDEX (Rol ASC) ,
	CONSTRAINT FK_Pacientes_Rol FOREIGN KEY (Rol) REFERENCES Roles (idRol) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT UC_Pacientes UNIQUE (identificacion, telefono, celular, email)
) ENGINE = InnoDB;

CREATE  TABLE IF NOT EXISTS Medicos 
(
	idMedico INT (11) NOT NULL AUTO_INCREMENT ,
	codigo VARCHAR (60) NOT NULL,
	Rol INT (11) NOT NULL DEFAULT 3,
	tipoidentificacion CHAR(2) NOT NULL ,
	identificacion BIGINT NOT NULL ,
	nombre VARCHAR(25) NOT NULL ,
	apellido VARCHAR(35) NOT NULL ,
	apellidocasada VARCHAR (35) NULL,
	genero CHAR(1) NOT NULL ,
	fechanacimiento DATE NOT NULL ,
	tiposangre CHAR(4) NOT NULL ,
	telefono BIGINT(7) NULL ,
	celular BIGINT(10) NOT NULL ,
	estadocivil VARCHAR (35) NOT NULL,
	ocupacion VARCHAR (80) NOT NULL,
	religion VARCHAR (50) NULL,
	pais VARCHAR(35) NOT NULL ,
	departamento VARCHAR(50) NOT NULL ,
	municipio VARCHAR(60) NOT NULL ,
	domicilio VARCHAR(120) NOT NULL ,
	email VARCHAR(200) NOT NULL,
	clave VARCHAR(60) NOT NULL ,
	fecharegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	estado INT (1) NOT NULL,
	CONSTRAINT PK_Medicos PRIMARY KEY (idMedico),
	INDEX FK_Medicos_Roles_INDEX (Rol ASC) ,
	CONSTRAINT FK_Medicos_Rol FOREIGN KEY (Rol) REFERENCES Roles (idRol) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT UC_Medicos UNIQUE (identificacion, telefono, celular, email)
) ENGINE = InnoDB;

CREATE  TABLE IF NOT EXISTS Espacialidades
(
	idEspecialidades INT (11) NOT NULL AUTO_INCREMENT,
	Medico INT (11) NOT NULL,
	especialidad VARCHAR (60) NOT NULL,
	detalle VARCHAR (200) NOT NULL,
	CONSTRAINT PK_Espacialidades PRIMARY KEY (idEspecialidades),
	INDEX FK_Espacialidades_Medicos_INDEX (Medico ASC),
	CONSTRAINT FK_Espacialidades_Medicos FOREIGN KEY (Medico) REFERENCES Medicos (idMedico) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE  TABLE IF NOT EXISTS Hv
(
	idHv INT (11) NOT NULL AUTO_INCREMENT,
	foto VARCHAR (120) NULL DEFAULT 'NO TIENE',
	Medico INT (11) NOT NULL,
	trayectoria VARCHAR (255) NOT NULL,
	experienciaprofesional VARCHAR (255) NOT NULL,
	logrosacademicos VARCHAR (255) NOT NULL,
	publicacionesconferencias VARCHAR (255) NOT NULL,
	idiomas VARCHAR (30) NOT NULL,
	CONSTRAINT PK_Hv PRIMARY KEY (idHv),
	INDEX FK_Espacialidades_Medicos_INDEX (Medico ASC),
	CONSTRAINT FK_Espacialidades_Medicos FOREIGN KEY (Medico) REFERENCES Medicos (idMedico) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE  TABLE IF NOT EXISTS Consultorio
(
	idConsultorio INT (11) NOT NULL AUTO_INCREMENT,
	nombre VARCHAR (180) NOT NULL,
	pais VARCHAR(35) NOT NULL ,
	departamento VARCHAR(50) NOT NULL ,
	municipio VARCHAR(60) NOT NULL ,
	domicilio VARCHAR(120) NOT NULL ,
	CONSTRAINT PK_Consultorio PRIMARY KEY (idConsultorio)
) ENGINE = InnoDB; 

CREATE TABLE IF NOT EXISTS Horario 
(
	idHorario INT (11) NOT NULL AUTO_INCREMENT,
	Medico INT (11) NOT NULL,
	Consultorio INT (11) NOT NULL,
	fecha DATE NOT NULL,	
	horainicio TIME NOT NULL,
	horafinal TIME NOT NULL,
	CONSTRAINT PK_Horario PRIMARY KEY (idHorario),
	INDEX FK_Horario_Medicos_INDEX (Medico ASC),
	INDEX FK_Horario_Consultorio_INDEX (Consultorio ASC),
	CONSTRAINT FK_Horario_Medicos FOREIGN KEY (Medico) REFERENCES Medicos (idMedico) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_Horario_Consultorio FOREIGN KEY (Consultorio) REFERENCES Consultorio (idConsultorio) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE  TABLE IF NOT EXISTS Cita
(
	idCita INT (11) NOT NULL AUTO_INCREMENT,
	Medico INT (11) NOT NULL,
	Paciente INT (11) NOT NULL,
	Horario INT (11) NOT NULL,
	concepto VARCHAR (255) NOT NULL,
	estado VARCHAR (35) NOT NULL,
	CONSTRAINT PK_Cita PRIMARY KEY (idCita),
	INDEX FK_Cita_Medicos_INDEX (Medico ASC),
	INDEX FK_Cita_Pacientes_INDEX (Paciente ASC),
	INDEX FK_Cita_Horario_INDEX (Paciente ASC),
	CONSTRAINT FK_Horario_Medicos FOREIGN KEY (Medico) REFERENCES Medicos (idMedico) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_Horario_Consultorio FOREIGN KEY (Consultorio) REFERENCES Consultorio (idConsultorio) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE  TABLE IF NOT EXISTS Auxiliares 
(
	idAuxiliar INT (11) NOT NULL AUTO_INCREMENT ,
	codigo VARCHAR (60) NOT NULL,
	Rol INT (11) NOT NULL DEFAULT 4,
	tipoidentificacion CHAR(2) NOT NULL ,
	identificacion BIGINT NOT NULL ,
	nombre VARCHAR(25) NOT NULL ,
	apellido VARCHAR(35) NOT NULL ,
	apellidocasada VARCHAR (35) NULL,
	genero CHAR(1) NOT NULL ,
	fechanacimiento DATE NOT NULL ,
	tiposangre CHAR(4) NOT NULL ,
	telefono BIGINT(7) NULL ,
	celular BIGINT(10) NOT NULL ,
	estadocivil VARCHAR (35) NOT NULL,
	ocupacion VARCHAR (80) NOT NULL,
	religion VARCHAR (50) NULL,
	pais VARCHAR(35) NOT NULL ,
	departamento VARCHAR(50) NOT NULL ,
	municipio VARCHAR(60) NOT NULL ,
	domicilio VARCHAR(120) NOT NULL ,
	email VARCHAR(200) NOT NULL,
	clave VARCHAR(60) NOT NULL ,
	fecharegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	estado INT (1) NOT NULL,
	CONSTRAINT PK_Auxiliares PRIMARY KEY (idAuxiliar),
	INDEX FK_Auxiliares_Roles_INDEX (Rol ASC) ,
	CONSTRAINT FK_Auxiliares_Rol FOREIGN KEY (Rol) REFERENCES Roles (idRol) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT UC_Auxiliares UNIQUE (identificacion, telefono, celular, email)
) ENGINE = InnoDB;



 DELIMITER $$
 CREATE PROCEDURE sp_GetPacientes()
   BEGIN
   SELECT * FROM Pacientes;
   END $$
 DELIMITER ;

-- CALL sp_GetPacientes();

 DELIMITER $$
 CREATE PROCEDURE sp_RegisterPacientes
 (
	IN sp_codigo VARCHAR (60),
	IN sp_tipoidentificacion CHAR (2),
	IN sp_identificacion BIGINT (20),
	IN sp_nombre VARCHAR (25),
	IN sp_apellido VARCHAR (35),
	IN sp_apellidocasada VARCHAR (35),
	IN sp_genero CHAR (1),
	IN sp_fechanacimiento DATE,
	IN sp_tiposangre CHAR (4),
	IN sp_telefono BIGINT (7),
	IN sp_celular BIGINT (10),
	IN sp_estadocivil VARCHAR (35),
	IN sp_ocupacion VARCHAR (80),
	IN sp_religion VARCHAR (50),
	IN sp_pais VARCHAR (35),
	IN sp_departamento VARCHAR (50),
	IN sp_municipio VARCHAR (60),
	IN sp_domicilio VARCHAR (120),
	IN sp_email VARCHAR (120),
	IN sp_clave VARCHAR (60)
 )
 BEGIN
	INSERT INTO pacientes (codigo, tipoidentificacion, identificacion, nombre, apellido, apellidocasada, 
						   genero, fechanacimiento, tiposangre, telefono, celular, estadocivil, ocupacion,
						   religion, pais, departamento, municipio, domicilio, email, clave) 
	VALUES (sp_codigo, sp_tipoidentificacion, sp_identificacion, sp_nombre, sp_apellido, sp_apellidocasada, 
			sp_genero, sp_fechanacimiento, sp_tiposangre, sp_telefono, sp_celular, sp_estadocivil, sp_ocupacion,
			sp_religion, sp_pais, sp_departamento, sp_municipio, sp_domicilio, sp_email, sp_clave); 
 END $$
 DELIMITER ;

 DELIMITER $$
 CREATE PROCEDURE sp_GetMedicos()
   BEGIN
   SELECT * FROM Medicos;
   END $$
 DELIMITER ;

-- CALL sp_GetMedicos();

 DELIMITER $$
 CREATE PROCEDURE sp_RegisterMedicos
 (
	IN sp_codigo VARCHAR (60),
	IN sp_tipoidentificacion CHAR (2),
	IN sp_identificacion BIGINT (20),
	IN sp_nombre VARCHAR (25),
	IN sp_apellido VARCHAR (35),
	IN sp_apellidocasada VARCHAR (35),
	IN sp_genero CHAR (1),
	IN sp_fechanacimiento DATE,
	IN sp_tiposangre CHAR (4),
	IN sp_telefono BIGINT (7),
	IN sp_celular BIGINT (10),
	IN sp_estadocivil VARCHAR (35),
	IN sp_ocupacion VARCHAR (80),
	IN sp_religion VARCHAR (50),
	IN sp_pais VARCHAR (35),
	IN sp_departamento VARCHAR (50),
	IN sp_municipio VARCHAR (60),
	IN sp_domicilio VARCHAR (120),
	IN sp_email VARCHAR (120),
	IN sp_clave VARCHAR (60)
 )
 BEGIN
	INSERT INTO medicos (codigo, tipoidentificacion, identificacion, nombre, apellido, apellidocasada, 
						   genero, fechanacimiento, tiposangre, telefono, celular, estadocivil, ocupacion,
						   religion, pais, departamento, municipio, domicilio, email, clave) 
	VALUES (sp_codigo, sp_tipoidentificacion, sp_identificacion, sp_nombre, sp_apellido, sp_apellidocasada, 
			sp_genero, sp_fechanacimiento, sp_tiposangre, sp_telefono, sp_celular, sp_estadocivil, sp_ocupacion,
			sp_religion, sp_pais, sp_departamento, sp_municipio, sp_domicilio, sp_email, sp_clave); 
 END $$
 DELIMITER ;

 DELIMITER $$
 CREATE PROCEDURE sp_GetEspecialidad()
   BEGIN
   SELECT * FROM Espacialidades;
   END $$
 DELIMITER ;


 DELIMITER $$
 CREATE PROCEDURE sp_RegisterEspecialidad
 (
	IN sp_Medico INT (11),
	IN sp_especialidad VARCHAR (60),
	IN sp_detalle VARCHAR (200)
 )
 BEGIN
	INSERT INTO espacialidades (Medico, especialidad, detalle) 
	VALUES (sp_Medico, sp_especialidad, sp_detalle); 
 END $$
 DELIMITER ;




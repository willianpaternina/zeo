-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-04-2018 a las 03:59:03
-- Versión del servidor: 10.1.30-MariaDB
-- Versión de PHP: 7.2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `zeo`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizarEspecialidad` (IN `sp_idEspecialidades` INT, IN `sp_detalle` VARCHAR(200))  BEGIN
	UPDATE espacialidades SET detalle = sp_detalle WHERE idEspecialidades = sp_idEspecialidades;
    select 'ok' as exito ;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizarEstadoCita` (IN `sp_idCita` INT, IN `sp_estado` VARCHAR(35))  BEGIN
	UPDATE cita SET estado = sp_estado WHERE idCita = sp_idCita;
    select 'ok' as exito;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultarActividadesEtapatumo` (IN `sp_Paciente` INT)  BEGIN
	select * from actividades as a INNER JOIN etapatumor as et ON a.Etapatumor = et.idEtapatumor WHERE a.Paciente = sp_Paciente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetPacientes` ()  BEGIN 
	select * from cita as C INNER JOIN pacientes as P ON C.Paciente = P.idPaciente;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_horarioMedico` (IN `sp_Medico` INT(3), IN `sp_Especialidad` INT(3))  BEGIN
	SELECT idHorario as id, fecha as start, CONCAT(horainicio," - " , horafinal) as title FROM horario WHERE Medico = sp_Medico AND Especialidad = sp_Especialidad;
   END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_HorarioPaciente` (IN `sp_Medico` INT)  BEGIN
	SELECT C.idCita as id,  H.fecha AS start, CONCAT(P.nombre," - " , P.apellido , " - " , C.concepto , " - ", C.estado) as title  from cita as C INNER JOIN pacientes as P ON C.Paciente = P.idPaciente INNER JOIN horario as H ON H.idHorario = C.horario INNER JOIN medicos AS M ON M.idMedico = H.Medico WHERE M.idMedico = sp_Medico;
   END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_iniciarsesionadministrador` (IN `sp_email` VARCHAR(200), IN `sp_clave` VARCHAR(100), IN `sp_rol` INT(11))  BEGIN
   SELECT *
   FROM administradores a 
   INNER JOIN Roles r ON a.Rol = r.idRol 
   WHERE a.email = sp_email AND a.clave = sp_clave AND p.Rol = sp_rol;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_iniciarsesionauxiliar` (IN `sp_email` VARCHAR(200), IN `sp_clave` VARCHAR(100), IN `sp_rol` INT(11))  BEGIN
   SELECT *
   FROM auxiliares ax 
   INNER JOIN Roles r ON ax.Rol = r.idRol 
   WHERE ax.email = sp_email AND ax.clave = sp_clave AND p.Rol = sp_rol;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_iniciarsesionmedico` (IN `sp_email` VARCHAR(200), IN `sp_clave` VARCHAR(100), IN `sp_rol` INT(11))  BEGIN
   SELECT *
   FROM medicos m 
   INNER JOIN Roles r ON m.Rol = r.idRol 
   WHERE m.email = sp_email AND m.clave = sp_clave AND p.Rol = sp_rol;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_iniciarsesionpaciente` (IN `sp_email` VARCHAR(200), IN `sp_clave` VARCHAR(100), IN `sp_rol` INT(11))  BEGIN
   SELECT *
   FROM pacientes p 
   INNER JOIN Roles r ON p.Rol = r.idRol 
   WHERE p.email = sp_email AND p.clave = sp_clave AND p.Rol = sp_rol;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ListarAuxiliares` ()  BEGIN
	SELECT * FROM auxiliares;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listarAuxiliaresMedicos` (IN `sp_Medico` INT)  BEGIN
	select *  from auxiliares where Medico = sp_Medico;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listarAuxiliarPorId` (IN `sp_idAuxiliar` INT)  BEGIN
	SELECT * FROM auxiliares WHERE idAuxiliar = sp_idAuxiliar; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listarCitaEstado` (IN `sp_Medico` INT, IN `sp_estado` VARCHAR(35))  BEGIN
	select P.idPaciente, CONCAT(p.nombre, " ", p.apellido) as nombre, h.fecha, c.estado from cita as c INNER JOIN horario as h ON c.Horario = h.idHorario INNER JOIN pacientes as p ON c.Paciente = p.idPaciente INNER JOIN medicos as m ON h.Medico = m.idMedico where m.idMedico = sp_Medico and c.estado = sp_estado;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listarMedicamentosPaciente` (IN `sp_Paciente` INT)  BEGIN
	select * from recetasmedicas as rm INNER JOIN medicamentos as m ON rm.Medicamentos = m.idMedicamento INNER JOIN etapatumor as et ON rm.Etapatumor = et.idEtapatumor WHERE rm.Paciente = sp_Paciente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listarMedicos` (IN `sp_estado` INT(1))  BEGIN
	SELECT * FROM Medicos as M, espacialidades as E WHERE M.idMedico = E.Medico AND estado = sp_estado;
   END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_LoginAuxiliar` (IN `sp_identificacion` INT(20), IN `sp_clave` VARCHAR(60), IN `sp_estado` INT(1), OUT `sp_login` CHAR(2))  IF EXISTS(SELECT identificacion, clave, estado FROM auxiliares WHERE identificacion = sp_identificacion AND clave = sp_clave AND estado = sp_estado ) THEN
	BEGIN
		select 'si' into sp_login;
    END;
ELSE
	BEGIN
		select 'no' into sp_login;
    END;
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrarActividad` (IN `sp_Paciente` INT, IN `sp_Etapatumo` INT, IN `sp_concepto` VARCHAR(255), IN `sp_estado` VARCHAR(35), IN `sp_numerohora` INT, IN `sp_numerodia` INT)  BEGIN
	INSERT INTO actividades (idActividad, Paciente, Etapatumor, concepto, estado, fecharegistro, numerohora, numerodia) 
						values(0, sp_Paciente, sp_Etapatumo, sp_concepto, sp_estado, now(), sp_numerohora,sp_numerodia);
                    select 'ok' as exito;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarAuxiliar` (IN `sp_codigo` VARCHAR(60), IN `sp_Rol` VARCHAR(60), IN `sp_tipoidentificacion` CHAR(2), IN `sp_identificacion` BIGINT(20), IN `sp_nombre` VARCHAR(25), IN `sp_apellido` VARCHAR(35), IN `sp_apellidocasada` VARCHAR(35), IN `sp_genero` CHAR(1), IN `sp_fechanacimiento` DATE, IN `sp_tiposangre` CHAR(4), IN `sp_telefono` BIGINT(7), IN `sp_celular` BIGINT(10), IN `sp_estadocivil` VARCHAR(35), IN `sp_ocupacion` VARCHAR(80), IN `sp_religion` VARCHAR(50), IN `sp_pais` VARCHAR(35), IN `sp_departamento` VARCHAR(35), IN `sp_municipio` VARCHAR(50), IN `sp_domicilio` VARCHAR(120), IN `sp_email` VARCHAR(200), IN `sp_clave` VARCHAR(60), IN `sp_fecharegistro` DATE, IN `sp_estado` INT)  IF NOT EXISTS (SELECT tipoidentificacion, identificacion FROM auxiliares WHERE tipoidentificacion = sp_tipoidentificacion AND identificacion = sp_identificacion )THEN
	 BEGIN		
		INSERT INTO auxiliares (idAuxiliar, codigo, Rol, tipoidentificacion, identificacion, nombre, apellido, apellidocasada, genero, fechanacimiento, tiposangre, telefono, celular, estadocivil, ocupacion, religion, pais, departamento, municipio, domicilio, email, clave, fecharegistro, estado) 
		VALUES (null, sp_codigo, sp_Rol, sp_tipoidentificacion, sp_identificacion, sp_nombre, sp_apellido, sp_apellidocasada, sp_genero, sp_fechanacimiento, sp_tiposangre, sp_telefono, sp_celular, sp_estadocivil, sp_ocupacion, sp_religion, sp_pais, sp_departamento, sp_municipio, sp_domicilio, sp_email, sp_clave, sp_fecharegistro, sp_estado); 
        select 'registro ingresado con exito' as response;
	 END;
 ELSE
	 BEGIN
		 select 'Identificacion se encuentra registrada' as response;
	 END;
 END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrarAuxiliarMedico` (IN `sp_Medico` INT(11), IN `sp_Rol` INT(11), IN `sp_tipoidentificacion` CHAR(2), IN `sp_identificacion` BIGINT(20), IN `sp_nombre` VARCHAR(25), IN `sp_apellido` VARCHAR(35), IN `sp_apellidocasada` VARCHAR(35), IN `sp_genero` CHAR(1), IN `sp_fechanacimiento` DATE, IN `sp_tiposangre` CHAR(4), IN `sp_telefono` BIGINT(7), IN `sp_celular` BIGINT(10), IN `sp_estadocivil` VARCHAR(35), IN `sp_ocupacion` VARCHAR(80), IN `sp_religion` VARCHAR(50), IN `sp_pais` VARCHAR(35), IN `sp_departamento` VARCHAR(50), IN `sp_municipio` VARCHAR(60), IN `sp_domicilio` VARCHAR(120), IN `sp_email` VARCHAR(200), IN `sp_clave` VARCHAR(60), IN `sp_estado` INT(1), IN `sp_cancatTipoIndentificacion` VARCHAR(20))  IF NOT EXISTS (SELECT Rol, CONCAT(tipoidentificacion,identificacion) AS identificacion FROM auxiliares WHERE Rol = sp_Rol AND CONCAT(tipoidentificacion,identificacion) = sp_cancatTipoIndentificacion)THEN
	 BEGIN		
		INSERT INTO auxiliares (idAuxiliar, Medico, Rol, tipoidentificacion, identificacion, nombre, apellido, apellidocasada, genero, fechanacimiento, tiposangre, telefono, celular, estadocivil, ocupacion, religion, pais, departamento, municipio, domicilio, email, clave, fecharegistro, estado) 
        VALUES (null, sp_Medico, sp_Rol, sp_tipoidentificacion,sp_identificacion,sp_nombre,sp_apellido,sp_apellidocasada,sp_genero,sp_fechanacimiento,sp_tiposangre,sp_telefono,sp_celular,sp_estadocivil,sp_ocupacion,sp_religion,sp_pais,sp_departamento,sp_municipio,sp_domicilio,sp_email,sp_clave, now(),sp_estado); 
        select 'ok' as exito ;
	 END;
 ELSE
	 BEGIN
		 select 'no_ok' as response ;
	 END;
 END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarCita` (IN `sp_Paciente` INT, IN `sp_Horario` INT, IN `sp_Concepto` VARCHAR(100), IN `sp_Estado` VARCHAR(35))  BEGIN
	IF NOT EXISTS (SELECT Paciente, Horario, estado FROM cita WHERE Paciente = sp_Paciente AND  Horario = sp_Horario AND estado = sp_Estado )THEN
		 BEGIN
			INSERT INTO cita (idCIta, Paciente, Horario, concepto, estado, fecharegistro)
			values( null, sp_paciente, sp_Horario, sp_concepto, sp_Estado, now()  );
			select 'ok' as exito ;
          
		 END;
	 ELSE
		 BEGIN
			 select 'no_ok' as response ;
		 END;
	 END IF;
     
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrarEspecilidad` (IN `sp_Medico` INT, IN `sp_especialidad` VARCHAR(60), IN `sp_detalle` VARCHAR(200))  IF NOT EXISTS (SELECT Medico, especialidad FROM espacialidades WHERE Medico = sp_Medico AND especialidad = sp_especialidad )THEN
	 BEGIN		
		INSERT INTO espacialidades (idEspecialidades, Medico, especialidad, detalle) 
		VALUES (null, sp_Medico, sp_especialidad, sp_detalle); 
        select 'ok' as exito ;
	 END;
 ELSE
	 BEGIN
		 select 'no_ok' as response ;
	 END;
 END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrarHorario` (IN `sp_Medico` INT, IN `sp_Consultorio` INT, IN `sp_Especialidad` INT, IN `sp_fecha` DATE, IN `sp_horainicio` TIME, IN `sp_horafinal` TIME)  IF NOT EXISTS (
	SELECT * from horario where (medico = sp_Medico and Consultorio = sp_Consultorio and Especialidad = sp_Especialidad and fecha = sp_fecha and horainicio <= horainicio and horainicio <= horafinal) AND 
    (Medico = sp_Medico and Consultorio = sp_Consultorio and Especialidad = sp_Especialidad and fecha = sp_fecha and horafinal >= sp_horainicio and horafinal >= horafinal) AND 
    (Medico = sp_Medico and Consultorio = sp_Consultorio and Especialidad = sp_Especialidad and fecha = sp_fecha and sp_horainicio BETWEEN horainicio and horafinal) AND 
    (Medico = sp_Medico and Consultorio = sp_Consultorio and Especialidad = sp_Especialidad and fecha = sp_fecha and sp_horainicio BETWEEN horafinal and horafinal)
)THEN
	 BEGIN		
		INSERT INTO horario (idHorario, Medico, Consultorio, Especialidad, fecha, horainicio, horafinal) VALUES
                (null, sp_Medico, sp_Consultorio, sp_Especialidad, sp_fecha, sp_horainicio, sp_horafinal);
                select 'ok' as exito;
	 END;
 ELSE
	 BEGIN
		 select 'no_ok' as response ;
	 END;
 END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrarMedicamento` (IN `sp_Paciente` INT, IN `sp_Medicamentos` INT, IN `sp_Etapatumor` INT, IN `sp_concepto` VARCHAR(255), IN `sp_numerohora` INT, IN `sp_numerodia` INT)  BEGIN
INSERT INTO recetasmedicas (idRecetasmedicas, Paciente, Medicamentos, Etapatumor, concepto, fecharegistro, numerohora, numerodia) 
						VALUES (0, sp_Paciente, sp_Medicamentos, sp_Etapatumor, sp_concepto, now(), sp_numerohora, sp_numerodia);
                        select 'ok' as exito;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rol` ()  BEGIN
select * from roles;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades`
--

CREATE TABLE `actividades` (
  `idActividad` int(11) NOT NULL,
  `Paciente` int(11) NOT NULL,
  `Etapatumor` int(11) NOT NULL,
  `concepto` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `estado` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `fecharegistro` date DEFAULT NULL,
  `numerohora` int(11) NOT NULL,
  `numerodia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `actividades`
--

INSERT INTO `actividades` (`idActividad`, `Paciente`, `Etapatumor`, `concepto`, `estado`, `fecharegistro`, `numerohora`, `numerodia`) VALUES
(9, 3, 4, 'DEMO', 'DEMO', '2018-04-05', 2, 3),
(10, 3, 4, 'PRUEBA', 'PRUEBA', '2018-04-05', 3, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administradores`
--

CREATE TABLE `administradores` (
  `idAdministrador` int(11) NOT NULL,
  `Rol` int(11) NOT NULL DEFAULT '1',
  `tipoidentificacion` char(2) COLLATE utf8_spanish_ci NOT NULL,
  `identificacion` bigint(20) NOT NULL,
  `nombre` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `apellido` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `apellidocasada` varchar(35) COLLATE utf8_spanish_ci DEFAULT NULL,
  `genero` char(1) COLLATE utf8_spanish_ci NOT NULL,
  `fechanacimiento` date NOT NULL,
  `tiposangre` char(4) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` bigint(7) DEFAULT NULL,
  `celular` bigint(10) NOT NULL,
  `estadocivil` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `ocupacion` varchar(80) COLLATE utf8_spanish_ci NOT NULL,
  `religion` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `pais` varchar(35) COLLATE utf8_spanish_ci NOT NULL DEFAULT 'COLOMBIA',
  `Departamento` int(2) NOT NULL,
  `Municipio` int(6) NOT NULL,
  `domicilio` varchar(120) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `clave` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  `fecharegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estado` enum('Y','N') COLLATE utf8_spanish_ci NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auxiliares`
--

CREATE TABLE `auxiliares` (
  `idAuxiliar` int(11) NOT NULL,
  `Medico` int(11) NOT NULL,
  `Rol` int(11) NOT NULL DEFAULT '4',
  `tipoidentificacion` char(2) COLLATE utf8_spanish_ci NOT NULL,
  `identificacion` bigint(20) NOT NULL,
  `nombre` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `apellido` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `apellidocasada` varchar(35) COLLATE utf8_spanish_ci DEFAULT NULL,
  `genero` char(1) COLLATE utf8_spanish_ci NOT NULL,
  `fechanacimiento` date NOT NULL,
  `tiposangre` char(4) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` bigint(7) DEFAULT NULL,
  `celular` bigint(10) NOT NULL,
  `estadocivil` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `ocupacion` varchar(80) COLLATE utf8_spanish_ci NOT NULL,
  `religion` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `pais` varchar(35) COLLATE utf8_spanish_ci NOT NULL DEFAULT 'COLOMBIA',
  `Departamento` int(2) NOT NULL,
  `Municipio` int(6) NOT NULL,
  `domicilio` varchar(120) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `clave` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  `fecharegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estado` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `auxiliares`
--

INSERT INTO `auxiliares` (`idAuxiliar`, `Medico`, `Rol`, `tipoidentificacion`, `identificacion`, `nombre`, `apellido`, `apellidocasada`, `genero`, `fechanacimiento`, `tiposangre`, `telefono`, `celular`, `estadocivil`, `ocupacion`, `religion`, `pais`, `Departamento`, `Municipio`, `domicilio`, `email`, `clave`, `fecharegistro`, `estado`) VALUES
(4, 1, 4, 'CC', 12345, 'Arnaldo', 'CASTILAA', '', 'M', '1991-09-01', 'A+', 6678410, 3172755590, 'SOLTERO', 'TECNOLOGO', 'CRISTIANO', 'COLOMBIA', 5, 22, 'ND', 'arnaldo.castilla@hotmail.com', 'qaz123', '2018-04-05 06:07:40', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cita`
--

CREATE TABLE `cita` (
  `idCita` int(11) NOT NULL,
  `Paciente` int(11) NOT NULL,
  `Horario` int(11) NOT NULL,
  `concepto` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `estado` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `fecharegistro` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `cita`
--

INSERT INTO `cita` (`idCita`, `Paciente`, `Horario`, `concepto`, `estado`, `fecharegistro`) VALUES
(1, 3, 3, 'dolor general', 'ATENDIDO', '2018-04-03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clasificaciontumor`
--

CREATE TABLE `clasificaciontumor` (
  `idClasificaciontumor` int(11) NOT NULL,
  `Tipotumores` int(11) NOT NULL,
  `nombreclasificacion` enum('INTESTINAL','DIFUSO') COLLATE utf8_spanish_ci NOT NULL DEFAULT 'INTESTINAL',
  `detalle` varchar(255) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `clasificaciontumor`
--

INSERT INTO `clasificaciontumor` (`idClasificaciontumor`, `Tipotumores`, `nombreclasificacion`, `detalle`) VALUES
(2, 2, 'INTESTINAL', 'CALISIFACION PRUEBA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consultorio`
--

CREATE TABLE `consultorio` (
  `idConsultorio` int(11) NOT NULL,
  `nombre` varchar(180) COLLATE utf8_spanish_ci NOT NULL,
  `pais` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `departamento` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `municipio` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  `domicilio` varchar(120) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `consultorio`
--

INSERT INTO `consultorio` (`idConsultorio`, `nombre`, `pais`, `departamento`, `municipio`, `domicilio`) VALUES
(1, 'PRINCIPAL', 'COLOMBIA', 'BOLIVAR', 'CARTAGENA', 'CRA 58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamentos`
--

CREATE TABLE `departamentos` (
  `idDepartamento` int(2) NOT NULL,
  `departamento` varchar(80) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `departamentos`
--

INSERT INTO `departamentos` (`idDepartamento`, `departamento`) VALUES
(1, 'Amazonas'),
(2, 'Antioquia'),
(3, 'Arauca'),
(4, 'Atlántico'),
(5, 'Bolívar'),
(6, 'Boyacá'),
(7, 'Caldas'),
(8, 'Caquetá'),
(9, 'Casanare'),
(10, 'Cauca'),
(11, 'Cesar'),
(12, 'Chocó'),
(13, 'Córdoba'),
(14, 'Cundinamarca'),
(15, 'Güainia'),
(16, 'Guaviare'),
(17, 'Huila'),
(18, 'La Guajira'),
(19, 'Magdalena'),
(20, 'Meta'),
(21, 'Nariño'),
(22, 'Norte de Santander'),
(23, 'Putumayo'),
(24, 'Quindio'),
(25, 'Risaralda'),
(26, 'San Andrés y Providencia'),
(27, 'Santander'),
(28, 'Sucre'),
(29, 'Tolima'),
(30, 'Valle del Cauca'),
(31, 'Vaupés'),
(32, 'Vichada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `espacialidades`
--

CREATE TABLE `espacialidades` (
  `idEspecialidades` int(11) NOT NULL,
  `Medico` int(11) NOT NULL,
  `especialidad` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  `detalle` varchar(200) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `espacialidades`
--

INSERT INTO `espacialidades` (`idEspecialidades`, `Medico`, `especialidad`, `detalle`) VALUES
(1, 1, 'ONCOLOGIA OBSTETRICIA', 'ONCOLOGO '),
(2, 1, 'ONCOLOGIA OSEA', 'NINGUNA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `etapatumor`
--

CREATE TABLE `etapatumor` (
  `idEtapatumor` int(11) NOT NULL,
  `nombreetapa` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `Tumorprimario` int(11) NOT NULL,
  `Ganglioslinfaticos` int(11) NOT NULL,
  `Metastasis` int(11) NOT NULL,
  `Clasificaciontumor` int(11) NOT NULL,
  `diagnostico` varchar(255) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `etapatumor`
--

INSERT INTO `etapatumor` (`idEtapatumor`, `nombreetapa`, `Tumorprimario`, `Ganglioslinfaticos`, `Metastasis`, `Clasificaciontumor`, `diagnostico`) VALUES
(4, 'ETAPA DEMO', 2, 3, 3, 2, 'dEMO ETAPa');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ganglioslinfaticos`
--

CREATE TABLE `ganglioslinfaticos` (
  `idGanglioslinfaticos` int(11) NOT NULL,
  `codigogl` varchar(4) COLLATE utf8_spanish_ci NOT NULL,
  `nombregl` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `detalle` varchar(255) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `ganglioslinfaticos`
--

INSERT INTO `ganglioslinfaticos` (`idGanglioslinfaticos`, `codigogl`, `nombregl`, `detalle`) VALUES
(1, 'NX', 'GANGLIOS LINFATICOS REGIO', 'GANGLIOS LINFATICOS REGIONALES QUE NO PUEDEN EVALUARSE'),
(2, 'N0', 'NO HAY METASTASIS EN LOS ', 'NO HAY METASTASIS EN LOS GANGLIOS LINFATICOS REGIONALES'),
(3, 'N1', 'METASTASIS EN 1-6 GANGLIO', 'METASTASIS EN 1-6 GANGLIOS LINFATICOS REGIONALES'),
(4, 'N2', 'METASTASIS EN 7-15 GANGLI', 'METASTASIS EN 7-15 GANGLIOS LINFATICOS REGIONALES'),
(5, 'N3', 'METASTASIS EN MAS DE 15 G', 'METASTASIS EN MAS DE 15 GANGLIOS LINFATICOS REGIONALES');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horario`
--

CREATE TABLE `horario` (
  `idHorario` int(11) NOT NULL,
  `Medico` int(11) NOT NULL,
  `Consultorio` int(11) NOT NULL,
  `Especialidad` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `horainicio` time NOT NULL,
  `horafinal` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `horario`
--

INSERT INTO `horario` (`idHorario`, `Medico`, `Consultorio`, `Especialidad`, `fecha`, `horainicio`, `horafinal`) VALUES
(3, 1, 1, 1, '2018-04-20', '07:00:00', '12:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hv`
--

CREATE TABLE `hv` (
  `idHv` int(11) NOT NULL,
  `foto` varchar(120) COLLATE utf8_spanish_ci DEFAULT 'NO TIENE',
  `Medico` int(11) NOT NULL,
  `trayectoria` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `experienciaprofesional` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `logrosacademicos` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `publicacionesconferencias` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `idiomas` varchar(30) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicamentos`
--

CREATE TABLE `medicamentos` (
  `idMedicamento` int(11) NOT NULL,
  `codigomaterial` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `ean` bigint(20) NOT NULL,
  `nombre` varchar(120) COLLATE utf8_spanish_ci NOT NULL,
  `presentacion` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `viaadministracion` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `disis` decimal(10,2) NOT NULL,
  `efectosadversos` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `indicaciones` varchar(255) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `medicamentos`
--

INSERT INTO `medicamentos` (`idMedicamento`, `codigomaterial`, `ean`, `nombre`, `presentacion`, `viaadministracion`, `disis`, `efectosadversos`, `indicaciones`) VALUES
(1, '0003', 123112, 'MEDICAMENTO DE PRUEBA', 'PASTILLA', 'ORAL', '1.00', 'NINGUNO', 'NINGUNO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicos`
--

CREATE TABLE `medicos` (
  `idMedico` int(11) NOT NULL,
  `Rol` int(11) NOT NULL DEFAULT '3',
  `tipoidentificacion` char(2) COLLATE utf8_spanish_ci NOT NULL,
  `identificacion` bigint(20) NOT NULL,
  `departamentoidentificacion` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `nombre` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `apellido` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `apellidocasada` varchar(35) COLLATE utf8_spanish_ci DEFAULT NULL,
  `genero` char(1) COLLATE utf8_spanish_ci NOT NULL,
  `fechanacimiento` date NOT NULL,
  `tiposangre` char(4) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` bigint(7) DEFAULT NULL,
  `celular` bigint(10) NOT NULL,
  `estadocivil` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `ocupacion` varchar(80) COLLATE utf8_spanish_ci NOT NULL,
  `religion` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `pais` varchar(35) COLLATE utf8_spanish_ci NOT NULL DEFAULT 'COLOMBIA',
  `Departamento` int(2) NOT NULL,
  `Municipio` int(6) NOT NULL,
  `domicilio` varchar(120) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `clave` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  `fecharegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estado` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `medicos`
--

INSERT INTO `medicos` (`idMedico`, `Rol`, `tipoidentificacion`, `identificacion`, `departamentoidentificacion`, `nombre`, `apellido`, `apellidocasada`, `genero`, `fechanacimiento`, `tiposangre`, `telefono`, `celular`, `estadocivil`, `ocupacion`, `religion`, `pais`, `Departamento`, `Municipio`, `domicilio`, `email`, `clave`, `fecharegistro`, `estado`) VALUES
(1, 3, 'CC', 123, 'BOLIVAR', 'HERNAN', 'SIMANCA', NULL, 'M', '1959-06-06', 'A+', 56765877, 3172755590, 'CASADO', 'ONCOLOGO', 'CRISTIANO', 'COLOMBIA', 5, 106, 'CRA 58A #6 - 88', 'HERNAN.SIMANCA@GMAIL.COM', '123', '2018-04-04 01:38:24', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metastasis`
--

CREATE TABLE `metastasis` (
  `idMetastasis` int(11) NOT NULL,
  `codigom` varchar(4) COLLATE utf8_spanish_ci NOT NULL,
  `nombrem` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `detalle` varchar(255) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `metastasis`
--

INSERT INTO `metastasis` (`idMetastasis`, `codigom`, `nombrem`, `detalle`) VALUES
(1, 'MX', 'METASTASIS A DISTANCIA QU', 'METASTASIS A DISTANCIA QUE NO PUEDE EVALUARSE'),
(2, 'M0', 'NO HAY METASTASIS A DISTA', 'NO HAY METASTASIS A DISTANCIA'),
(3, 'M1', 'METASTASIS A DISTANCIA', 'METASTASIS A DISTANCIA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `municipios`
--

CREATE TABLE `municipios` (
  `idMunicipio` int(6) NOT NULL,
  `municipio` varchar(80) COLLATE utf8_spanish_ci NOT NULL,
  `Departamento` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `municipios`
--

INSERT INTO `municipios` (`idMunicipio`, `municipio`, `Departamento`) VALUES
(1, 'Leticia', 1),
(2, 'Puerto Nariño', 1),
(3, 'Abejorral', 2),
(4, 'Abriaquí', 2),
(5, 'Alejandria', 2),
(6, 'Amagá', 2),
(7, 'Amalfi', 2),
(8, 'Andes', 2),
(9, 'Angelópolis', 2),
(10, 'Angostura', 2),
(11, 'Anorí', 2),
(12, 'Anzá', 2),
(13, 'Apartadó', 2),
(14, 'Arboletes', 2),
(15, 'Argelia', 2),
(16, 'Armenia', 2),
(17, 'Barbosa', 2),
(18, 'Bello', 2),
(19, 'Belmira', 2),
(20, 'Betania', 2),
(21, 'Betulia', 2),
(22, 'Bolívar', 2),
(23, 'Briceño', 2),
(24, 'Burítica', 2),
(25, 'Caicedo', 2),
(26, 'Caldas', 2),
(27, 'Campamento', 2),
(28, 'Caracolí', 2),
(29, 'Caramanta', 2),
(30, 'Carepa', 2),
(31, 'Carmen de Viboral', 2),
(32, 'Carolina', 2),
(33, 'Caucasia', 2),
(34, 'Cañasgordas', 2),
(35, 'Chigorodó', 2),
(36, 'Cisneros', 2),
(37, 'Cocorná', 2),
(38, 'Concepción', 2),
(39, 'Concordia', 2),
(40, 'Copacabana', 2),
(41, 'Cáceres', 2),
(42, 'Dabeiba', 2),
(43, 'Don Matías', 2),
(44, 'Ebéjico', 2),
(45, 'El Bagre', 2),
(46, 'Entrerríos', 2),
(47, 'Envigado', 2),
(48, 'Fredonia', 2),
(49, 'Frontino', 2),
(50, 'Giraldo', 2),
(51, 'Girardota', 2),
(52, 'Granada', 2),
(53, 'Guadalupe', 2),
(54, 'Guarne', 2),
(55, 'Guatapé', 2),
(56, 'Gómez Plata', 2),
(57, 'Heliconia', 2),
(58, 'Hispania', 2),
(59, 'Itagüí', 2),
(60, 'Ituango', 2),
(61, 'Jardín', 2),
(62, 'Jericó', 2),
(63, 'La Ceja', 2),
(64, 'La Estrella', 2),
(65, 'La Pintada', 2),
(66, 'La Unión', 2),
(67, 'Liborina', 2),
(68, 'Maceo', 2),
(69, 'Marinilla', 2),
(70, 'Medellín', 2),
(71, 'Montebello', 2),
(72, 'Murindó', 2),
(73, 'Mutatá', 2),
(74, 'Nariño', 2),
(75, 'Nechí', 2),
(76, 'Necoclí', 2),
(77, 'Olaya', 2),
(78, 'Peque', 2),
(79, 'Peñol', 2),
(80, 'Pueblorrico', 2),
(81, 'Puerto Berrío', 2),
(82, 'Puerto Nare', 2),
(83, 'Puerto Triunfo', 2),
(84, 'Remedios', 2),
(85, 'Retiro', 2),
(86, 'Ríonegro', 2),
(87, 'Sabanalarga', 2),
(88, 'Sabaneta', 2),
(89, 'Salgar', 2),
(90, 'San Andrés de Cuerquía', 2),
(91, 'San Carlos', 2),
(92, 'San Francisco', 2),
(93, 'San Jerónimo', 2),
(94, 'San José de Montaña', 2),
(95, 'San Juan de Urabá', 2),
(96, 'San Luís', 2),
(97, 'San Pedro', 2),
(98, 'San Pedro de Urabá', 2),
(99, 'San Rafael', 2),
(100, 'San Roque', 2),
(101, 'San Vicente', 2),
(102, 'Santa Bárbara', 2),
(103, 'Santa Fé de Antioquia', 2),
(104, 'Santa Rosa de Osos', 2),
(105, 'Santo Domingo', 2),
(106, 'Santuario', 2),
(107, 'Segovia', 2),
(108, 'Sonsón', 2),
(109, 'Sopetrán', 2),
(110, 'Tarazá', 2),
(111, 'Tarso', 2),
(112, 'Titiribí', 2),
(113, 'Toledo', 2),
(114, 'Turbo', 2),
(115, 'Támesis', 2),
(116, 'Uramita', 2),
(117, 'Urrao', 2),
(118, 'Valdivia', 2),
(119, 'Valparaiso', 2),
(120, 'Vegachí', 2),
(121, 'Venecia', 2),
(122, 'Vigía del Fuerte', 2),
(123, 'Yalí', 2),
(124, 'Yarumal', 2),
(125, 'Yolombó', 2),
(126, 'Yondó (Casabe)', 2),
(127, 'Zaragoza', 2),
(128, 'Arauca', 3),
(129, 'Arauquita', 3),
(130, 'Cravo Norte', 3),
(131, 'Fortúl', 3),
(132, 'Puerto Rondón', 3),
(133, 'Saravena', 3),
(134, 'Tame', 3),
(135, 'Baranoa', 4),
(136, 'Barranquilla', 4),
(137, 'Campo de la Cruz', 4),
(138, 'Candelaria', 4),
(139, 'Galapa', 4),
(140, 'Juan de Acosta', 4),
(141, 'Luruaco', 4),
(142, 'Malambo', 4),
(143, 'Manatí', 4),
(144, 'Palmar de Varela', 4),
(145, 'Piojo', 4),
(146, 'Polonuevo', 4),
(147, 'Ponedera', 4),
(148, 'Puerto Colombia', 4),
(149, 'Repelón', 4),
(150, 'Sabanagrande', 4),
(151, 'Sabanalarga', 4),
(152, 'Santa Lucía', 4),
(153, 'Santo Tomás', 4),
(154, 'Soledad', 4),
(155, 'Suan', 4),
(156, 'Tubará', 4),
(157, 'Usiacuri', 4),
(158, 'Achí', 5),
(159, 'Altos del Rosario', 5),
(160, 'Arenal', 5),
(161, 'Arjona', 5),
(162, 'Arroyohondo', 5),
(163, 'Barranco de Loba', 5),
(164, 'Calamar', 5),
(165, 'Cantagallo', 5),
(166, 'Cartagena', 5),
(167, 'Cicuco', 5),
(168, 'Clemencia', 5),
(169, 'Córdoba', 5),
(170, 'El Carmen de Bolívar', 5),
(171, 'El Guamo', 5),
(172, 'El Peñon', 5),
(173, 'Hatillo de Loba', 5),
(174, 'Magangué', 5),
(175, 'Mahates', 5),
(176, 'Margarita', 5),
(177, 'María la Baja', 5),
(178, 'Mompós', 5),
(179, 'Montecristo', 5),
(180, 'Morales', 5),
(181, 'Norosí', 5),
(182, 'Pinillos', 5),
(183, 'Regidor', 5),
(184, 'Río Viejo', 5),
(185, 'San Cristobal', 5),
(186, 'San Estanislao', 5),
(187, 'San Fernando', 5),
(188, 'San Jacinto', 5),
(189, 'San Jacinto del Cauca', 5),
(190, 'San Juan de Nepomuceno', 5),
(191, 'San Martín de Loba', 5),
(192, 'San Pablo', 5),
(193, 'Santa Catalina', 5),
(194, 'Santa Rosa ', 5),
(195, 'Santa Rosa del Sur', 5),
(196, 'Simití', 5),
(197, 'Soplaviento', 5),
(198, 'Talaigua Nuevo', 5),
(199, 'Tiquisio (Puerto Rico)', 5),
(200, 'Turbaco', 5),
(201, 'Turbaná', 5),
(202, 'Villanueva', 5),
(203, 'Zambrano', 5),
(204, 'Almeida', 6),
(205, 'Aquitania', 6),
(206, 'Arcabuco', 6),
(207, 'Belén', 6),
(208, 'Berbeo', 6),
(209, 'Beteitiva', 6),
(210, 'Boavita', 6),
(211, 'Boyacá', 6),
(212, 'Briceño', 6),
(213, 'Buenavista', 6),
(214, 'Busbanza', 6),
(215, 'Caldas', 6),
(216, 'Campohermoso', 6),
(217, 'Cerinza', 6),
(218, 'Chinavita', 6),
(219, 'Chiquinquirá', 6),
(220, 'Chiscas', 6),
(221, 'Chita', 6),
(222, 'Chitaraque', 6),
(223, 'Chivatá', 6),
(224, 'Chíquiza', 6),
(225, 'Chívor', 6),
(226, 'Ciénaga', 6),
(227, 'Coper', 6),
(228, 'Corrales', 6),
(229, 'Covarachía', 6),
(230, 'Cubará', 6),
(231, 'Cucaita', 6),
(232, 'Cuitiva', 6),
(233, 'Cómbita', 6),
(234, 'Duitama', 6),
(235, 'El Cocuy', 6),
(236, 'El Espino', 6),
(237, 'Firavitoba', 6),
(238, 'Floresta', 6),
(239, 'Gachantivá', 6),
(240, 'Garagoa', 6),
(241, 'Guacamayas', 6),
(242, 'Guateque', 6),
(243, 'Guayatá', 6),
(244, 'Guicán', 6),
(245, 'Gámeza', 6),
(246, 'Izá', 6),
(247, 'Jenesano', 6),
(248, 'Jericó', 6),
(249, 'La Capilla', 6),
(250, 'La Uvita', 6),
(251, 'La Victoria', 6),
(252, 'Labranzagrande', 6),
(253, 'Macanal', 6),
(254, 'Maripí', 6),
(255, 'Miraflores', 6),
(256, 'Mongua', 6),
(257, 'Monguí', 6),
(258, 'Moniquirá', 6),
(259, 'Motavita', 6),
(260, 'Muzo', 6),
(261, 'Nobsa', 6),
(262, 'Nuevo Colón', 6),
(263, 'Oicatá', 6),
(264, 'Otanche', 6),
(265, 'Pachavita', 6),
(266, 'Paipa', 6),
(267, 'Pajarito', 6),
(268, 'Panqueba', 6),
(269, 'Pauna', 6),
(270, 'Paya', 6),
(271, 'Paz de Río', 6),
(272, 'Pesca', 6),
(273, 'Pisva', 6),
(274, 'Puerto Boyacá', 6),
(275, 'Páez', 6),
(276, 'Quipama', 6),
(277, 'Ramiriquí', 6),
(278, 'Rondón', 6),
(279, 'Ráquira', 6),
(280, 'Saboyá', 6),
(281, 'Samacá', 6),
(282, 'San Eduardo', 6),
(283, 'San José de Pare', 6),
(284, 'San Luís de Gaceno', 6),
(285, 'San Mateo', 6),
(286, 'San Miguel de Sema', 6),
(287, 'San Pablo de Borbur', 6),
(288, 'Santa María', 6),
(289, 'Santa Rosa de Viterbo', 6),
(290, 'Santa Sofía', 6),
(291, 'Santana', 6),
(292, 'Sativanorte', 6),
(293, 'Sativasur', 6),
(294, 'Siachoque', 6),
(295, 'Soatá', 6),
(296, 'Socha', 6),
(297, 'Socotá', 6),
(298, 'Sogamoso', 6),
(299, 'Somondoco', 6),
(300, 'Sora', 6),
(301, 'Soracá', 6),
(302, 'Sotaquirá', 6),
(303, 'Susacón', 6),
(304, 'Sutamarchán', 6),
(305, 'Sutatenza', 6),
(306, 'Sáchica', 6),
(307, 'Tasco', 6),
(308, 'Tenza', 6),
(309, 'Tibaná', 6),
(310, 'Tibasosa', 6),
(311, 'Tinjacá', 6),
(312, 'Tipacoque', 6),
(313, 'Toca', 6),
(314, 'Toguí', 6),
(315, 'Topagá', 6),
(316, 'Tota', 6),
(317, 'Tunja', 6),
(318, 'Tunungua', 6),
(319, 'Turmequé', 6),
(320, 'Tuta', 6),
(321, 'Tutasá', 6),
(322, 'Ventaquemada', 6),
(323, 'Villa de Leiva', 6),
(324, 'Viracachá', 6),
(325, 'Zetaquirá', 6),
(326, 'Úmbita', 6),
(327, 'Aguadas', 7),
(328, 'Anserma', 7),
(329, 'Aranzazu', 7),
(330, 'Belalcázar', 7),
(331, 'Chinchiná', 7),
(332, 'Filadelfia', 7),
(333, 'La Dorada', 7),
(334, 'La Merced', 7),
(335, 'La Victoria', 7),
(336, 'Manizales', 7),
(337, 'Manzanares', 7),
(338, 'Marmato', 7),
(339, 'Marquetalia', 7),
(340, 'Marulanda', 7),
(341, 'Neira', 7),
(342, 'Norcasia', 7),
(343, 'Palestina', 7),
(344, 'Pensilvania', 7),
(345, 'Pácora', 7),
(346, 'Risaralda', 7),
(347, 'Río Sucio', 7),
(348, 'Salamina', 7),
(349, 'Samaná', 7),
(350, 'San José', 7),
(351, 'Supía', 7),
(352, 'Villamaría', 7),
(353, 'Viterbo', 7),
(354, 'Albania', 8),
(355, 'Belén de los Andaquíes', 8),
(356, 'Cartagena del Chairá', 8),
(357, 'Curillo', 8),
(358, 'El Doncello', 8),
(359, 'El Paujil', 8),
(360, 'Florencia', 8),
(361, 'La Montañita', 8),
(362, 'Milán', 8),
(363, 'Morelia', 8),
(364, 'Puerto Rico', 8),
(365, 'San José del Fragua', 8),
(366, 'San Vicente del Caguán', 8),
(367, 'Solano', 8),
(368, 'Solita', 8),
(369, 'Valparaiso', 8),
(370, 'Aguazul', 9),
(371, 'Chámeza', 9),
(372, 'Hato Corozal', 9),
(373, 'La Salina', 9),
(374, 'Maní', 9),
(375, 'Monterrey', 9),
(376, 'Nunchía', 9),
(377, 'Orocué', 9),
(378, 'Paz de Ariporo', 9),
(379, 'Pore', 9),
(380, 'Recetor', 9),
(381, 'Sabanalarga', 9),
(382, 'San Luís de Palenque', 9),
(383, 'Sácama', 9),
(384, 'Tauramena', 9),
(385, 'Trinidad', 9),
(386, 'Támara', 9),
(387, 'Villanueva', 9),
(388, 'Yopal', 9),
(389, 'Almaguer', 10),
(390, 'Argelia', 10),
(391, 'Balboa', 10),
(392, 'Bolívar', 10),
(393, 'Buenos Aires', 10),
(394, 'Cajibío', 10),
(395, 'Caldono', 10),
(396, 'Caloto', 10),
(397, 'Corinto', 10),
(398, 'El Tambo', 10),
(399, 'Florencia', 10),
(400, 'Guachené', 10),
(401, 'Guapí', 10),
(402, 'Inzá', 10),
(403, 'Jambaló', 10),
(404, 'La Sierra', 10),
(405, 'La Vega', 10),
(406, 'López (Micay)', 10),
(407, 'Mercaderes', 10),
(408, 'Miranda', 10),
(409, 'Morales', 10),
(410, 'Padilla', 10),
(411, 'Patía (El Bordo)', 10),
(412, 'Piamonte', 10),
(413, 'Piendamó', 10),
(414, 'Popayán', 10),
(415, 'Puerto Tejada', 10),
(416, 'Puracé (Coconuco)', 10),
(417, 'Páez (Belalcazar)', 10),
(418, 'Rosas', 10),
(419, 'San Sebastián', 10),
(420, 'Santa Rosa', 10),
(421, 'Santander de Quilichao', 10),
(422, 'Silvia', 10),
(423, 'Sotara (Paispamba)', 10),
(424, 'Sucre', 10),
(425, 'Suárez', 10),
(426, 'Timbiquí', 10),
(427, 'Timbío', 10),
(428, 'Toribío', 10),
(429, 'Totoró', 10),
(430, 'Villa Rica', 10),
(431, 'Aguachica', 11),
(432, 'Agustín Codazzi', 11),
(433, 'Astrea', 11),
(434, 'Becerríl', 11),
(435, 'Bosconia', 11),
(436, 'Chimichagua', 11),
(437, 'Chiriguaná', 11),
(438, 'Curumaní', 11),
(439, 'El Copey', 11),
(440, 'El Paso', 11),
(441, 'Gamarra', 11),
(442, 'Gonzalez', 11),
(443, 'La Gloria', 11),
(444, 'La Jagua de Ibirico', 11),
(445, 'La Paz (Robles)', 11),
(446, 'Manaure Balcón del Cesar', 11),
(447, 'Pailitas', 11),
(448, 'Pelaya', 11),
(449, 'Pueblo Bello', 11),
(450, 'Río de oro', 11),
(451, 'San Alberto', 11),
(452, 'San Diego', 11),
(453, 'San Martín', 11),
(454, 'Tamalameque', 11),
(455, 'Valledupar', 11),
(456, 'Acandí', 12),
(457, 'Alto Baudó (Pie de Pato)', 12),
(458, 'Atrato (Yuto)', 12),
(459, 'Bagadó', 12),
(460, 'Bahía Solano (Mútis)', 12),
(461, 'Bajo Baudó (Pizarro)', 12),
(462, 'Belén de Bajirá', 12),
(463, 'Bojayá (Bellavista)', 12),
(464, 'Cantón de San Pablo', 12),
(465, 'Carmen del Darién (CURBARADÓ)', 12),
(466, 'Condoto', 12),
(467, 'Cértegui', 12),
(468, 'El Carmen de Atrato', 12),
(469, 'Istmina', 12),
(470, 'Juradó', 12),
(471, 'Lloró', 12),
(472, 'Medio Atrato', 12),
(473, 'Medio Baudó', 12),
(474, 'Medio San Juan (ANDAGOYA)', 12),
(475, 'Novita', 12),
(476, 'Nuquí', 12),
(477, 'Quibdó', 12),
(478, 'Río Iró', 12),
(479, 'Río Quito', 12),
(480, 'Ríosucio', 12),
(481, 'San José del Palmar', 12),
(482, 'Santa Genoveva de Docorodó', 12),
(483, 'Sipí', 12),
(484, 'Tadó', 12),
(485, 'Unguía', 12),
(486, 'Unión Panamericana (ÁNIMAS)', 12),
(487, 'Ayapel', 13),
(488, 'Buenavista', 13),
(489, 'Canalete', 13),
(490, 'Cereté', 13),
(491, 'Chimá', 13),
(492, 'Chinú', 13),
(493, 'Ciénaga de Oro', 13),
(494, 'Cotorra', 13),
(495, 'La Apartada y La Frontera', 13),
(496, 'Lorica', 13),
(497, 'Los Córdobas', 13),
(498, 'Momil', 13),
(499, 'Montelíbano', 13),
(500, 'Monteria', 13),
(501, 'Moñitos', 13),
(502, 'Planeta Rica', 13),
(503, 'Pueblo Nuevo', 13),
(504, 'Puerto Escondido', 13),
(505, 'Puerto Libertador', 13),
(506, 'Purísima', 13),
(507, 'Sahagún', 13),
(508, 'San Andrés Sotavento', 13),
(509, 'San Antero', 13),
(510, 'San Bernardo del Viento', 13),
(511, 'San Carlos', 13),
(512, 'San José de Uré', 13),
(513, 'San Pelayo', 13),
(514, 'Tierralta', 13),
(515, 'Tuchín', 13),
(516, 'Valencia', 13),
(517, 'Agua de Dios', 14),
(518, 'Albán', 14),
(519, 'Anapoima', 14),
(520, 'Anolaima', 14),
(521, 'Apulo', 14),
(522, 'Arbeláez', 14),
(523, 'Beltrán', 14),
(524, 'Bituima', 14),
(525, 'Bogotá D.C.', 14),
(526, 'Bojacá', 14),
(527, 'Cabrera', 14),
(528, 'Cachipay', 14),
(529, 'Cajicá', 14),
(530, 'Caparrapí', 14),
(531, 'Carmen de Carupa', 14),
(532, 'Chaguaní', 14),
(533, 'Chipaque', 14),
(534, 'Choachí', 14),
(535, 'Chocontá', 14),
(536, 'Chía', 14),
(537, 'Cogua', 14),
(538, 'Cota', 14),
(539, 'Cucunubá', 14),
(540, 'Cáqueza', 14),
(541, 'El Colegio', 14),
(542, 'El Peñón', 14),
(543, 'El Rosal', 14),
(544, 'Facatativá', 14),
(545, 'Fosca', 14),
(546, 'Funza', 14),
(547, 'Fusagasugá', 14),
(548, 'Fómeque', 14),
(549, 'Fúquene', 14),
(550, 'Gachalá', 14),
(551, 'Gachancipá', 14),
(552, 'Gachetá', 14),
(553, 'Gama', 14),
(554, 'Girardot', 14),
(555, 'Granada', 14),
(556, 'Guachetá', 14),
(557, 'Guaduas', 14),
(558, 'Guasca', 14),
(559, 'Guataquí', 14),
(560, 'Guatavita', 14),
(561, 'Guayabal de Siquima', 14),
(562, 'Guayabetal', 14),
(563, 'Gutiérrez', 14),
(564, 'Jerusalén', 14),
(565, 'Junín', 14),
(566, 'La Calera', 14),
(567, 'La Mesa', 14),
(568, 'La Palma', 14),
(569, 'La Peña', 14),
(570, 'La Vega', 14),
(571, 'Lenguazaque', 14),
(572, 'Machetá', 14),
(573, 'Madrid', 14),
(574, 'Manta', 14),
(575, 'Medina', 14),
(576, 'Mosquera', 14),
(577, 'Nariño', 14),
(578, 'Nemocón', 14),
(579, 'Nilo', 14),
(580, 'Nimaima', 14),
(581, 'Nocaima', 14),
(582, 'Pacho', 14),
(583, 'Paime', 14),
(584, 'Pandi', 14),
(585, 'Paratebueno', 14),
(586, 'Pasca', 14),
(587, 'Puerto Salgar', 14),
(588, 'Pulí', 14),
(589, 'Quebradanegra', 14),
(590, 'Quetame', 14),
(591, 'Quipile', 14),
(592, 'Ricaurte', 14),
(593, 'San Antonio de Tequendama', 14),
(594, 'San Bernardo', 14),
(595, 'San Cayetano', 14),
(596, 'San Francisco', 14),
(597, 'San Juan de Río Seco', 14),
(598, 'Sasaima', 14),
(599, 'Sesquilé', 14),
(600, 'Sibaté', 14),
(601, 'Silvania', 14),
(602, 'Simijaca', 14),
(603, 'Soacha', 14),
(604, 'Sopó', 14),
(605, 'Subachoque', 14),
(606, 'Suesca', 14),
(607, 'Supatá', 14),
(608, 'Susa', 14),
(609, 'Sutatausa', 14),
(610, 'Tabio', 14),
(611, 'Tausa', 14),
(612, 'Tena', 14),
(613, 'Tenjo', 14),
(614, 'Tibacuy', 14),
(615, 'Tibirita', 14),
(616, 'Tocaima', 14),
(617, 'Tocancipá', 14),
(618, 'Topaipí', 14),
(619, 'Ubalá', 14),
(620, 'Ubaque', 14),
(621, 'Ubaté', 14),
(622, 'Une', 14),
(623, 'Venecia (Ospina Pérez)', 14),
(624, 'Vergara', 14),
(625, 'Viani', 14),
(626, 'Villagómez', 14),
(627, 'Villapinzón', 14),
(628, 'Villeta', 14),
(629, 'Viotá', 14),
(630, 'Yacopí', 14),
(631, 'Zipacón', 14),
(632, 'Zipaquirá', 14),
(633, 'Útica', 14),
(634, 'Inírida', 15),
(635, 'Calamar', 16),
(636, 'El Retorno', 16),
(637, 'Miraflores', 16),
(638, 'San José del Guaviare', 16),
(639, 'Acevedo', 17),
(640, 'Agrado', 17),
(641, 'Aipe', 17),
(642, 'Algeciras', 17),
(643, 'Altamira', 17),
(644, 'Baraya', 17),
(645, 'Campoalegre', 17),
(646, 'Colombia', 17),
(647, 'Elías', 17),
(648, 'Garzón', 17),
(649, 'Gigante', 17),
(650, 'Guadalupe', 17),
(651, 'Hobo', 17),
(652, 'Isnos', 17),
(653, 'La Argentina', 17),
(654, 'La Plata', 17),
(655, 'Neiva', 17),
(656, 'Nátaga', 17),
(657, 'Oporapa', 17),
(658, 'Paicol', 17),
(659, 'Palermo', 17),
(660, 'Palestina', 17),
(661, 'Pital', 17),
(662, 'Pitalito', 17),
(663, 'Rivera', 17),
(664, 'Saladoblanco', 17),
(665, 'San Agustín', 17),
(666, 'Santa María', 17),
(667, 'Suaza', 17),
(668, 'Tarqui', 17),
(669, 'Tello', 17),
(670, 'Teruel', 17),
(671, 'Tesalia', 17),
(672, 'Timaná', 17),
(673, 'Villavieja', 17),
(674, 'Yaguará', 17),
(675, 'Íquira', 17),
(676, 'Albania', 18),
(677, 'Barrancas', 18),
(678, 'Dibulla', 18),
(679, 'Distracción', 18),
(680, 'El Molino', 18),
(681, 'Fonseca', 18),
(682, 'Hatonuevo', 18),
(683, 'La Jagua del Pilar', 18),
(684, 'Maicao', 18),
(685, 'Manaure', 18),
(686, 'Riohacha', 18),
(687, 'San Juan del Cesar', 18),
(688, 'Uribia', 18),
(689, 'Urumita', 18),
(690, 'Villanueva', 18),
(691, 'Algarrobo', 19),
(692, 'Aracataca', 19),
(693, 'Ariguaní (El Difícil)', 19),
(694, 'Cerro San Antonio', 19),
(695, 'Chivolo', 19),
(696, 'Ciénaga', 19),
(697, 'Concordia', 19),
(698, 'El Banco', 19),
(699, 'El Piñon', 19),
(700, 'El Retén', 19),
(701, 'Fundación', 19),
(702, 'Guamal', 19),
(703, 'Nueva Granada', 19),
(704, 'Pedraza', 19),
(705, 'Pijiño', 19),
(706, 'Pivijay', 19),
(707, 'Plato', 19),
(708, 'Puebloviejo', 19),
(709, 'Remolino', 19),
(710, 'Sabanas de San Angel (SAN ANGEL)', 19),
(711, 'Salamina', 19),
(712, 'San Sebastián de Buenavista', 19),
(713, 'San Zenón', 19),
(714, 'Santa Ana', 19),
(715, 'Santa Bárbara de Pinto', 19),
(716, 'Santa Marta', 19),
(717, 'Sitionuevo', 19),
(718, 'Tenerife', 19),
(719, 'Zapayán (PUNTA DE PIEDRAS)', 19),
(720, 'Zona Bananera (PRADO - SEVILLA)', 19),
(721, 'Acacías', 20),
(722, 'Barranca de Upía', 20),
(723, 'Cabuyaro', 20),
(724, 'Castilla la Nueva', 20),
(725, 'Cubarral', 20),
(726, 'Cumaral', 20),
(727, 'El Calvario', 20),
(728, 'El Castillo', 20),
(729, 'El Dorado', 20),
(730, 'Fuente de Oro', 20),
(731, 'Granada', 20),
(732, 'Guamal', 20),
(733, 'La Macarena', 20),
(734, 'Lejanías', 20),
(735, 'Mapiripan', 20),
(736, 'Mesetas', 20),
(737, 'Puerto Concordia', 20),
(738, 'Puerto Gaitán', 20),
(739, 'Puerto Lleras', 20),
(740, 'Puerto López', 20),
(741, 'Puerto Rico', 20),
(742, 'Restrepo', 20),
(743, 'San Carlos de Guaroa', 20),
(744, 'San Juan de Arama', 20),
(745, 'San Juanito', 20),
(746, 'San Martín', 20),
(747, 'Uribe', 20),
(748, 'Villavicencio', 20),
(749, 'Vista Hermosa', 20),
(750, 'Albán (San José)', 21),
(751, 'Aldana', 21),
(752, 'Ancuya', 21),
(753, 'Arboleda (Berruecos)', 21),
(754, 'Barbacoas', 21),
(755, 'Belén', 21),
(756, 'Buesaco', 21),
(757, 'Chachaguí', 21),
(758, 'Colón (Génova)', 21),
(759, 'Consaca', 21),
(760, 'Contadero', 21),
(761, 'Cuaspud (Carlosama)', 21),
(762, 'Cumbal', 21),
(763, 'Cumbitara', 21),
(764, 'Córdoba', 21),
(765, 'El Charco', 21),
(766, 'El Peñol', 21),
(767, 'El Rosario', 21),
(768, 'El Tablón de Gómez', 21),
(769, 'El Tambo', 21),
(770, 'Francisco Pizarro', 21),
(771, 'Funes', 21),
(772, 'Guachavés', 21),
(773, 'Guachucal', 21),
(774, 'Guaitarilla', 21),
(775, 'Gualmatán', 21),
(776, 'Iles', 21),
(777, 'Imúes', 21),
(778, 'Ipiales', 21),
(779, 'La Cruz', 21),
(780, 'La Florida', 21),
(781, 'La Llanada', 21),
(782, 'La Tola', 21),
(783, 'La Unión', 21),
(784, 'Leiva', 21),
(785, 'Linares', 21),
(786, 'Magüi (Payán)', 21),
(787, 'Mallama (Piedrancha)', 21),
(788, 'Mosquera', 21),
(789, 'Nariño', 21),
(790, 'Olaya Herrera', 21),
(791, 'Ospina', 21),
(792, 'Policarpa', 21),
(793, 'Potosí', 21),
(794, 'Providencia', 21),
(795, 'Puerres', 21),
(796, 'Pupiales', 21),
(797, 'Ricaurte', 21),
(798, 'Roberto Payán (San José)', 21),
(799, 'Samaniego', 21),
(800, 'San Bernardo', 21),
(801, 'San Juan de Pasto', 21),
(802, 'San Lorenzo', 21),
(803, 'San Pablo', 21),
(804, 'San Pedro de Cartago', 21),
(805, 'Sandoná', 21),
(806, 'Santa Bárbara (Iscuandé)', 21),
(807, 'Sapuyes', 21),
(808, 'Sotomayor (Los Andes)', 21),
(809, 'Taminango', 21),
(810, 'Tangua', 21),
(811, 'Tumaco', 21),
(812, 'Túquerres', 21),
(813, 'Yacuanquer', 21),
(814, 'Arboledas', 22),
(815, 'Bochalema', 22),
(816, 'Bucarasica', 22),
(817, 'Chinácota', 22),
(818, 'Chitagá', 22),
(819, 'Convención', 22),
(820, 'Cucutilla', 22),
(821, 'Cáchira', 22),
(822, 'Cácota', 22),
(823, 'Cúcuta', 22),
(824, 'Durania', 22),
(825, 'El Carmen', 22),
(826, 'El Tarra', 22),
(827, 'El Zulia', 22),
(828, 'Gramalote', 22),
(829, 'Hacarí', 22),
(830, 'Herrán', 22),
(831, 'La Esperanza', 22),
(832, 'La Playa', 22),
(833, 'Labateca', 22),
(834, 'Los Patios', 22),
(835, 'Lourdes', 22),
(836, 'Mutiscua', 22),
(837, 'Ocaña', 22),
(838, 'Pamplona', 22),
(839, 'Pamplonita', 22),
(840, 'Puerto Santander', 22),
(841, 'Ragonvalia', 22),
(842, 'Salazar', 22),
(843, 'San Calixto', 22),
(844, 'San Cayetano', 22),
(845, 'Santiago', 22),
(846, 'Sardinata', 22),
(847, 'Silos', 22),
(848, 'Teorama', 22),
(849, 'Tibú', 22),
(850, 'Toledo', 22),
(851, 'Villa Caro', 22),
(852, 'Villa del Rosario', 22),
(853, 'Ábrego', 22),
(854, 'Colón', 23),
(855, 'Mocoa', 23),
(856, 'Orito', 23),
(857, 'Puerto Asís', 23),
(858, 'Puerto Caicedo', 23),
(859, 'Puerto Guzmán', 23),
(860, 'Puerto Leguízamo', 23),
(861, 'San Francisco', 23),
(862, 'San Miguel', 23),
(863, 'Santiago', 23),
(864, 'Sibundoy', 23),
(865, 'Valle del Guamuez', 23),
(866, 'Villagarzón', 23),
(867, 'Armenia', 24),
(868, 'Buenavista', 24),
(869, 'Calarcá', 24),
(870, 'Circasia', 24),
(871, 'Cordobá', 24),
(872, 'Filandia', 24),
(873, 'Génova', 24),
(874, 'La Tebaida', 24),
(875, 'Montenegro', 24),
(876, 'Pijao', 24),
(877, 'Quimbaya', 24),
(878, 'Salento', 24),
(879, 'Apía', 25),
(880, 'Balboa', 25),
(881, 'Belén de Umbría', 25),
(882, 'Dos Quebradas', 25),
(883, 'Guática', 25),
(884, 'La Celia', 25),
(885, 'La Virginia', 25),
(886, 'Marsella', 25),
(887, 'Mistrató', 25),
(888, 'Pereira', 25),
(889, 'Pueblo Rico', 25),
(890, 'Quinchía', 25),
(891, 'Santa Rosa de Cabal', 25),
(892, 'Santuario', 25),
(893, 'Providencia', 26),
(894, 'Aguada', 27),
(895, 'Albania', 27),
(896, 'Aratoca', 27),
(897, 'Barbosa', 27),
(898, 'Barichara', 27),
(899, 'Barrancabermeja', 27),
(900, 'Betulia', 27),
(901, 'Bolívar', 27),
(902, 'Bucaramanga', 27),
(903, 'Cabrera', 27),
(904, 'California', 27),
(905, 'Capitanejo', 27),
(906, 'Carcasí', 27),
(907, 'Cepita', 27),
(908, 'Cerrito', 27),
(909, 'Charalá', 27),
(910, 'Charta', 27),
(911, 'Chima', 27),
(912, 'Chipatá', 27),
(913, 'Cimitarra', 27),
(914, 'Concepción', 27),
(915, 'Confines', 27),
(916, 'Contratación', 27),
(917, 'Coromoro', 27),
(918, 'Curití', 27),
(919, 'El Carmen', 27),
(920, 'El Guacamayo', 27),
(921, 'El Peñon', 27),
(922, 'El Playón', 27),
(923, 'Encino', 27),
(924, 'Enciso', 27),
(925, 'Floridablanca', 27),
(926, 'Florián', 27),
(927, 'Galán', 27),
(928, 'Girón', 27),
(929, 'Guaca', 27),
(930, 'Guadalupe', 27),
(931, 'Guapota', 27),
(932, 'Guavatá', 27),
(933, 'Guepsa', 27),
(934, 'Gámbita', 27),
(935, 'Hato', 27),
(936, 'Jesús María', 27),
(937, 'Jordán', 27),
(938, 'La Belleza', 27),
(939, 'La Paz', 27),
(940, 'Landázuri', 27),
(941, 'Lebrija', 27),
(942, 'Los Santos', 27),
(943, 'Macaravita', 27),
(944, 'Matanza', 27),
(945, 'Mogotes', 27),
(946, 'Molagavita', 27),
(947, 'Málaga', 27),
(948, 'Ocamonte', 27),
(949, 'Oiba', 27),
(950, 'Onzaga', 27),
(951, 'Palmar', 27),
(952, 'Palmas del Socorro', 27),
(953, 'Pie de Cuesta', 27),
(954, 'Pinchote', 27),
(955, 'Puente Nacional', 27),
(956, 'Puerto Parra', 27),
(957, 'Puerto Wilches', 27),
(958, 'Páramo', 27),
(959, 'Rio Negro', 27),
(960, 'Sabana de Torres', 27),
(961, 'San Andrés', 27),
(962, 'San Benito', 27),
(963, 'San Gíl', 27),
(964, 'San Joaquín', 27),
(965, 'San José de Miranda', 27),
(966, 'San Miguel', 27),
(967, 'San Vicente del Chucurí', 27),
(968, 'Santa Bárbara', 27),
(969, 'Santa Helena del Opón', 27),
(970, 'Simacota', 27),
(971, 'Socorro', 27),
(972, 'Suaita', 27),
(973, 'Sucre', 27),
(974, 'Suratá', 27),
(975, 'Tona', 27),
(976, 'Valle de San José', 27),
(977, 'Vetas', 27),
(978, 'Villanueva', 27),
(979, 'Vélez', 27),
(980, 'Zapatoca', 27),
(981, 'Buenavista', 28),
(982, 'Caimito', 28),
(983, 'Chalán', 28),
(984, 'Colosó (Ricaurte)', 28),
(985, 'Corozal', 28),
(986, 'Coveñas', 28),
(987, 'El Roble', 28),
(988, 'Galeras (Nueva Granada)', 28),
(989, 'Guaranda', 28),
(990, 'La Unión', 28),
(991, 'Los Palmitos', 28),
(992, 'Majagual', 28),
(993, 'Morroa', 28),
(994, 'Ovejas', 28),
(995, 'Palmito', 28),
(996, 'Sampués', 28),
(997, 'San Benito Abad', 28),
(998, 'San Juan de Betulia', 28),
(999, 'San Marcos', 28),
(1000, 'San Onofre', 28),
(1001, 'San Pedro', 28),
(1002, 'Sincelejo', 28),
(1003, 'Sincé', 28),
(1004, 'Sucre', 28),
(1005, 'Tolú', 28),
(1006, 'Tolú Viejo', 28),
(1007, 'Alpujarra', 29),
(1008, 'Alvarado', 29),
(1009, 'Ambalema', 29),
(1010, 'Anzoátegui', 29),
(1011, 'Armero (Guayabal)', 29),
(1012, 'Ataco', 29),
(1013, 'Cajamarca', 29),
(1014, 'Carmen de Apicalá', 29),
(1015, 'Casabianca', 29),
(1016, 'Chaparral', 29),
(1017, 'Coello', 29),
(1018, 'Coyaima', 29),
(1019, 'Cunday', 29),
(1020, 'Dolores', 29),
(1021, 'Espinal', 29),
(1022, 'Falan', 29),
(1023, 'Flandes', 29),
(1024, 'Fresno', 29),
(1025, 'Guamo', 29),
(1026, 'Herveo', 29),
(1027, 'Honda', 29),
(1028, 'Ibagué', 29),
(1029, 'Icononzo', 29),
(1030, 'Lérida', 29),
(1031, 'Líbano', 29),
(1032, 'Mariquita', 29),
(1033, 'Melgar', 29),
(1034, 'Murillo', 29),
(1035, 'Natagaima', 29),
(1036, 'Ortega', 29),
(1037, 'Palocabildo', 29),
(1038, 'Piedras', 29),
(1039, 'Planadas', 29),
(1040, 'Prado', 29),
(1041, 'Purificación', 29),
(1042, 'Rioblanco', 29),
(1043, 'Roncesvalles', 29),
(1044, 'Rovira', 29),
(1045, 'Saldaña', 29),
(1046, 'San Antonio', 29),
(1047, 'San Luis', 29),
(1048, 'Santa Isabel', 29),
(1049, 'Suárez', 29),
(1050, 'Valle de San Juan', 29),
(1051, 'Venadillo', 29),
(1052, 'Villahermosa', 29),
(1053, 'Villarrica', 29),
(1054, 'Alcalá', 30),
(1055, 'Andalucía', 30),
(1056, 'Ansermanuevo', 30),
(1057, 'Argelia', 30),
(1058, 'Bolívar', 30),
(1059, 'Buenaventura', 30),
(1060, 'Buga', 30),
(1061, 'Bugalagrande', 30),
(1062, 'Caicedonia', 30),
(1063, 'Calima (Darién)', 30),
(1064, 'Calí', 30),
(1065, 'Candelaria', 30),
(1066, 'Cartago', 30),
(1067, 'Dagua', 30),
(1068, 'El Cairo', 30),
(1069, 'El Cerrito', 30),
(1070, 'El Dovio', 30),
(1071, 'El Águila', 30),
(1072, 'Florida', 30),
(1073, 'Ginebra', 30),
(1074, 'Guacarí', 30),
(1075, 'Jamundí', 30),
(1076, 'La Cumbre', 30),
(1077, 'La Unión', 30),
(1078, 'La Victoria', 30),
(1079, 'Obando', 30),
(1080, 'Palmira', 30),
(1081, 'Pradera', 30),
(1082, 'Restrepo', 30),
(1083, 'Riofrío', 30),
(1084, 'Roldanillo', 30),
(1085, 'San Pedro', 30),
(1086, 'Sevilla', 30),
(1087, 'Toro', 30),
(1088, 'Trujillo', 30),
(1089, 'Tulúa', 30),
(1090, 'Ulloa', 30),
(1091, 'Versalles', 30),
(1092, 'Vijes', 30),
(1093, 'Yotoco', 30),
(1094, 'Yumbo', 30),
(1095, 'Zarzal', 30),
(1096, 'Carurú', 31),
(1097, 'Mitú', 31),
(1098, 'Taraira', 31),
(1099, 'Cumaribo', 32),
(1100, 'La Primavera', 32),
(1101, 'Puerto Carreño', 32),
(1102, 'Santa Rosalía', 32);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `idPaciente` int(11) NOT NULL,
  `Rol` int(11) NOT NULL DEFAULT '2',
  `tipoidentificacion` char(2) COLLATE utf8_spanish_ci NOT NULL,
  `identificacion` bigint(20) NOT NULL,
  `departamentoidentificacion` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `nombre` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `apellido` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `apellidocasada` varchar(35) COLLATE utf8_spanish_ci DEFAULT NULL,
  `genero` char(1) COLLATE utf8_spanish_ci NOT NULL,
  `fechanacimiento` date NOT NULL,
  `tiposangre` char(4) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` bigint(7) DEFAULT NULL,
  `celular` bigint(10) NOT NULL,
  `estadocivil` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `ocupacion` varchar(80) COLLATE utf8_spanish_ci NOT NULL,
  `religion` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `pais` varchar(35) COLLATE utf8_spanish_ci NOT NULL DEFAULT 'COLOMBIA',
  `Departamento` int(2) NOT NULL,
  `Municipio` int(6) NOT NULL,
  `domicilio` varchar(120) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `clave` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `fecharegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estado` enum('Y','N') COLLATE utf8_spanish_ci NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pacientes`
--

INSERT INTO `pacientes` (`idPaciente`, `Rol`, `tipoidentificacion`, `identificacion`, `departamentoidentificacion`, `nombre`, `apellido`, `apellidocasada`, `genero`, `fechanacimiento`, `tiposangre`, `telefono`, `celular`, `estadocivil`, `ocupacion`, `religion`, `pais`, `Departamento`, `Municipio`, `domicilio`, `email`, `clave`, `fecharegistro`, `estado`) VALUES
(3, 2, 'CC', 123, '', 'ARNALDO', 'FLOREZ', NULL, 'M', '1991-09-01', 'A+', 6765841, 3172755590, 'SOLTERO', 'TECNOLOGO', 'CRISTIANO', 'COLOMBIA', 5, 166, 'CRA 58', 'ARNALDO.CASTILLA@HOTMAIL.COM', '123', '2018-04-04 01:36:28', 'Y');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recetasmedicas`
--

CREATE TABLE `recetasmedicas` (
  `idRecetasmedicas` int(11) NOT NULL,
  `Paciente` int(11) NOT NULL,
  `Medicamentos` int(11) NOT NULL,
  `Etapatumor` int(11) NOT NULL,
  `concepto` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `fecharegistro` date DEFAULT NULL,
  `numerohora` int(11) NOT NULL,
  `numerodia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `recetasmedicas`
--

INSERT INTO `recetasmedicas` (`idRecetasmedicas`, `Paciente`, `Medicamentos`, `Etapatumor`, `concepto`, `fecharegistro`, `numerohora`, `numerodia`) VALUES
(1, 3, 1, 4, 'INSERT VISTA', '2018-04-05', 3, 4),
(2, 3, 1, 4, 'INSERT VISTA', '2018-04-05', 3, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `idRol` int(11) NOT NULL,
  `rol` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `detalle` varchar(200) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`idRol`, `rol`, `detalle`) VALUES
(1, 'ADMINISTRADOR', 'ADMINISTRAR'),
(2, 'PACIENTE', 'CONSULTAR'),
(3, 'MEDICO', 'GESTIONAR'),
(4, 'AUXILIAR', 'REPORTAR'),
(5, 'ADMINISTRADOR', 'ADMINISTRAR'),
(6, 'PACIENTE', 'CONSULTAR'),
(7, 'MEDICO', 'GESTIONAR'),
(8, 'AUXILIAR', 'REPORTAR');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `signosvitales`
--

CREATE TABLE `signosvitales` (
  `idSignosvitales` int(11) NOT NULL,
  `Paciente` int(11) NOT NULL,
  `temperaturacorporal` decimal(2,2) NOT NULL,
  `presionarterial` int(11) NOT NULL,
  `frecuenciacardiaca` int(11) NOT NULL,
  `frecuenciarespiratoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipotumores`
--

CREATE TABLE `tipotumores` (
  `idTipotumor` int(11) NOT NULL,
  `codigotTumor` varchar(4) COLLATE utf8_spanish_ci NOT NULL,
  `nombreTumor` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `detalle` varchar(255) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tipotumores`
--

INSERT INTO `tipotumores` (`idTipotumor`, `codigotTumor`, `nombreTumor`, `detalle`) VALUES
(1, 'C160', 'TUMOR MALIGNO DEL CARDIAS', 'TUMOR DE CARDIAS'),
(2, 'C161', 'TUMOR MALIGNO DE FUNDUS GASTRICO', 'TUMOR FUNDUS GASTRICO'),
(3, 'C162', 'TUMOR MALIGNO DEL CUERPO GASTRICO', 'TUMOR DEL CUERPO GASTRICO'),
(4, 'C163', 'TUMOR MALIGNO DEL ANTRO PILORICO', 'TUMOR DEL ANTRO PILORICO'),
(5, 'C164', 'TUMOR MALIGNO PILORICO', 'TUMOR PILORICO'),
(6, 'C165', 'TUMOR MALIGNO DE LA CURVATURA MENOR DEL ESTOMAGO', 'TUMOR DE LA CURVATURA MENOR DEL ESTOMAGO'),
(7, 'C166', 'TUMOR MALIGNO DE LA CURVATURA MAYOR DEL ESTOMAGO', 'TUMOR DE LA CURVATURA MAYOR DEL ESTOMAGO'),
(8, 'C168', 'LESION DE SITIOS CONTIGUOS AL ESTOMAGO', 'LESION DE SITIOS CONTIGUOS AL ESTOMAGO'),
(9, 'C169', 'TUMOR MALIGNO DEL ESTOMAGO', 'TUMOR DEL ESTOMAGO'),
(10, 'D002', 'CARCINOMA IN SITU DEL ESTOMAGO', 'CARCINOMA DE ESTOMAGO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tumorprimario`
--

CREATE TABLE `tumorprimario` (
  `idTumorprimario` int(11) NOT NULL,
  `codigotp` varchar(4) COLLATE utf8_spanish_ci NOT NULL,
  `nombretp` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `detalle` varchar(255) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tumorprimario`
--

INSERT INTO `tumorprimario` (`idTumorprimario`, `codigotp`, `nombretp`, `detalle`) VALUES
(1, 'TX', 'TUMOR PRIMARIO QUE NO PUE', 'ETAPA DONDE EL TUMOR PRIMARIO NO PUEDE EVALUARSE'),
(2, 'T0', 'NO HAY INDICIOS DE TUMOR ', 'ETAPA DONDE NO HAY INDICIOS DE TUMOR PRIMARIO'),
(3, 'TIS', 'TUMOR INTRAEPITELIA, SIN ', 'CARDIOMA IN SITU: TUMOR INTRAEPITELIA, SIN PENETRACION DE LA LAMINA PROPIA'),
(4, 'T1', 'TUMOR QUE INVADE LA LAMIN', 'ETAPA DONDE EL TUMOR QUE INVADE LA LAMINA PROPIA O LA SUBMUCOSA'),
(5, 'T2', 'TUMOR QUE INVADE LA MUSCU', 'TUMOR QUE INVADE LA MUSCULARIS PROPIA O LA SUBSEROSA'),
(6, 'T2A', 'TUMOR QUE INVADE LA MUSCU', 'TUMOR QUE INVADE LA MUSCULARIS PROPIA'),
(7, 'T2B', 'TUMOR QUE INVADE LA SUBSE', 'TUMOR QUE INVADE LA SUBSEROSA'),
(8, 'T3', 'TUMOR QUE PENETRA LA SERO', 'TUMOR QUE PENETRA LA SEROSA'),
(9, 'T4', 'TUMOR QUE INVADE LA ESTRU', 'TUMOR QUE INVADE LA ESTRUCTURA ADYACENTE');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actividades`
--
ALTER TABLE `actividades`
  ADD PRIMARY KEY (`idActividad`),
  ADD KEY `FK_Actividades_Pacientes_INDEX` (`Paciente`),
  ADD KEY `FK_Actividades_Etapatumor_INDEX` (`Etapatumor`);

--
-- Indices de la tabla `administradores`
--
ALTER TABLE `administradores`
  ADD PRIMARY KEY (`idAdministrador`),
  ADD UNIQUE KEY `UC_Administradores` (`identificacion`,`telefono`,`celular`,`email`),
  ADD KEY `FK_Administradores_Roles_INDEX` (`Rol`),
  ADD KEY `FK_Administradores_Departamento_INDEX` (`Departamento`),
  ADD KEY `FK_Administradores_Municipio_INDEX` (`Municipio`);

--
-- Indices de la tabla `auxiliares`
--
ALTER TABLE `auxiliares`
  ADD PRIMARY KEY (`idAuxiliar`),
  ADD UNIQUE KEY `UC_Auxiliares` (`identificacion`,`telefono`,`celular`,`email`),
  ADD KEY `FK_Auxiliares_Roles_INDEX` (`Rol`),
  ADD KEY `FK_Auxiliares_Departamento_INDEX` (`Departamento`),
  ADD KEY `FK_Auxiliares_Municipio_INDEX` (`Municipio`);

--
-- Indices de la tabla `cita`
--
ALTER TABLE `cita`
  ADD PRIMARY KEY (`idCita`),
  ADD KEY `FK_Cita_Pacientes_INDEX` (`Paciente`),
  ADD KEY `FK_Cita_Horario_INDEX` (`Horario`);

--
-- Indices de la tabla `clasificaciontumor`
--
ALTER TABLE `clasificaciontumor`
  ADD PRIMARY KEY (`idClasificaciontumor`),
  ADD KEY `FK_Clasificaciontumor_Tipotumores_INDEX` (`Tipotumores`);

--
-- Indices de la tabla `consultorio`
--
ALTER TABLE `consultorio`
  ADD PRIMARY KEY (`idConsultorio`);

--
-- Indices de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`idDepartamento`);

--
-- Indices de la tabla `espacialidades`
--
ALTER TABLE `espacialidades`
  ADD PRIMARY KEY (`idEspecialidades`),
  ADD KEY `FK_Espacialidades_Medicos_INDEX` (`Medico`);

--
-- Indices de la tabla `etapatumor`
--
ALTER TABLE `etapatumor`
  ADD PRIMARY KEY (`idEtapatumor`),
  ADD KEY `FK_Etapatumor_Tumorprimario_INDEX` (`Tumorprimario`),
  ADD KEY `FK_Etapatumor_Ganglioslinfaticos_INDEX` (`Ganglioslinfaticos`),
  ADD KEY `FK_Etapatumor_Metastasis_INDEX` (`Metastasis`),
  ADD KEY `FK_Etapatumor_Clasificaciontumor_INDEX` (`Clasificaciontumor`);

--
-- Indices de la tabla `ganglioslinfaticos`
--
ALTER TABLE `ganglioslinfaticos`
  ADD PRIMARY KEY (`idGanglioslinfaticos`);

--
-- Indices de la tabla `horario`
--
ALTER TABLE `horario`
  ADD PRIMARY KEY (`idHorario`),
  ADD KEY `FK_Horario_Medicos_INDEX` (`Medico`),
  ADD KEY `FK_Horario_Consultorio_INDEX` (`Consultorio`),
  ADD KEY `FK_Horario_Especialidad_INDEX` (`Especialidad`);

--
-- Indices de la tabla `hv`
--
ALTER TABLE `hv`
  ADD PRIMARY KEY (`idHv`),
  ADD KEY `FK_Hv_Medicos_INDEX` (`Medico`);

--
-- Indices de la tabla `medicamentos`
--
ALTER TABLE `medicamentos`
  ADD PRIMARY KEY (`idMedicamento`);

--
-- Indices de la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD PRIMARY KEY (`idMedico`),
  ADD UNIQUE KEY `UC_Medicos` (`identificacion`,`telefono`,`celular`,`email`),
  ADD KEY `FK_Medicos_Roles_INDEX` (`Rol`),
  ADD KEY `FK_Medicos_Departamento_INDEX` (`Departamento`),
  ADD KEY `FK_Medicos_Municipio_INDEX` (`Municipio`);

--
-- Indices de la tabla `metastasis`
--
ALTER TABLE `metastasis`
  ADD PRIMARY KEY (`idMetastasis`);

--
-- Indices de la tabla `municipios`
--
ALTER TABLE `municipios`
  ADD PRIMARY KEY (`idMunicipio`),
  ADD KEY `FK_Municipios_Departamento` (`Departamento`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`idPaciente`),
  ADD UNIQUE KEY `UC_Pacientes` (`identificacion`,`telefono`,`celular`,`email`),
  ADD KEY `FK_Pacientes_Roles_INDEX` (`Rol`),
  ADD KEY `FK_Pacientes_Departamento_INDEX` (`Departamento`),
  ADD KEY `FK_Pacientes_Municipio_INDEX` (`Municipio`);

--
-- Indices de la tabla `recetasmedicas`
--
ALTER TABLE `recetasmedicas`
  ADD PRIMARY KEY (`idRecetasmedicas`),
  ADD KEY `FK_Recetasmedicas_Pacientes_INDEX` (`Paciente`),
  ADD KEY `FK_Recetasmedicas_Medicamentos_INDEX` (`Medicamentos`),
  ADD KEY `FK_Recetasmedicas_Etapatumor_INDEX` (`Etapatumor`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`idRol`);

--
-- Indices de la tabla `signosvitales`
--
ALTER TABLE `signosvitales`
  ADD PRIMARY KEY (`idSignosvitales`),
  ADD KEY `FK_Signosvitales_Pacientes_INDEX` (`Paciente`);

--
-- Indices de la tabla `tipotumores`
--
ALTER TABLE `tipotumores`
  ADD PRIMARY KEY (`idTipotumor`);

--
-- Indices de la tabla `tumorprimario`
--
ALTER TABLE `tumorprimario`
  ADD PRIMARY KEY (`idTumorprimario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actividades`
--
ALTER TABLE `actividades`
  MODIFY `idActividad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `administradores`
--
ALTER TABLE `administradores`
  MODIFY `idAdministrador` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auxiliares`
--
ALTER TABLE `auxiliares`
  MODIFY `idAuxiliar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `cita`
--
ALTER TABLE `cita`
  MODIFY `idCita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `clasificaciontumor`
--
ALTER TABLE `clasificaciontumor`
  MODIFY `idClasificaciontumor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `consultorio`
--
ALTER TABLE `consultorio`
  MODIFY `idConsultorio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  MODIFY `idDepartamento` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `espacialidades`
--
ALTER TABLE `espacialidades`
  MODIFY `idEspecialidades` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `etapatumor`
--
ALTER TABLE `etapatumor`
  MODIFY `idEtapatumor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `ganglioslinfaticos`
--
ALTER TABLE `ganglioslinfaticos`
  MODIFY `idGanglioslinfaticos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `horario`
--
ALTER TABLE `horario`
  MODIFY `idHorario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `hv`
--
ALTER TABLE `hv`
  MODIFY `idHv` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `medicamentos`
--
ALTER TABLE `medicamentos`
  MODIFY `idMedicamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `medicos`
--
ALTER TABLE `medicos`
  MODIFY `idMedico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `metastasis`
--
ALTER TABLE `metastasis`
  MODIFY `idMetastasis` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `municipios`
--
ALTER TABLE `municipios`
  MODIFY `idMunicipio` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1103;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `idPaciente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `recetasmedicas`
--
ALTER TABLE `recetasmedicas`
  MODIFY `idRecetasmedicas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `idRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `signosvitales`
--
ALTER TABLE `signosvitales`
  MODIFY `idSignosvitales` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipotumores`
--
ALTER TABLE `tipotumores`
  MODIFY `idTipotumor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tumorprimario`
--
ALTER TABLE `tumorprimario`
  MODIFY `idTumorprimario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `actividades`
--
ALTER TABLE `actividades`
  ADD CONSTRAINT `FK_Actividades_Etapatumor` FOREIGN KEY (`Etapatumor`) REFERENCES `etapatumor` (`idEtapatumor`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Actividades_Pacientes` FOREIGN KEY (`Paciente`) REFERENCES `pacientes` (`idPaciente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `administradores`
--
ALTER TABLE `administradores`
  ADD CONSTRAINT `FK_Administradores_Departamento` FOREIGN KEY (`Departamento`) REFERENCES `departamentos` (`idDepartamento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Administradores_Municipio` FOREIGN KEY (`Municipio`) REFERENCES `municipios` (`idMunicipio`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Administradores_Rol` FOREIGN KEY (`Rol`) REFERENCES `roles` (`idRol`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `auxiliares`
--
ALTER TABLE `auxiliares`
  ADD CONSTRAINT `FK_Auxiliares_Departamento` FOREIGN KEY (`Departamento`) REFERENCES `departamentos` (`idDepartamento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Auxiliares_Municipio` FOREIGN KEY (`Municipio`) REFERENCES `municipios` (`idMunicipio`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Auxiliares_Rol` FOREIGN KEY (`Rol`) REFERENCES `roles` (`idRol`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `FK_Cita_Horario` FOREIGN KEY (`Horario`) REFERENCES `horario` (`idHorario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Cita_Pacientes` FOREIGN KEY (`Paciente`) REFERENCES `pacientes` (`idPaciente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `clasificaciontumor`
--
ALTER TABLE `clasificaciontumor`
  ADD CONSTRAINT `FK_Clasificaciontumor_Tipotumores` FOREIGN KEY (`Tipotumores`) REFERENCES `tipotumores` (`idTipotumor`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `espacialidades`
--
ALTER TABLE `espacialidades`
  ADD CONSTRAINT `FK_Espacialidades_Medicos` FOREIGN KEY (`Medico`) REFERENCES `medicos` (`idMedico`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `etapatumor`
--
ALTER TABLE `etapatumor`
  ADD CONSTRAINT `FK_Etapatumor_Clasificaciontumor` FOREIGN KEY (`Clasificaciontumor`) REFERENCES `clasificaciontumor` (`idClasificaciontumor`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Etapatumor_Ganglioslinfaticos` FOREIGN KEY (`Ganglioslinfaticos`) REFERENCES `ganglioslinfaticos` (`idGanglioslinfaticos`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Etapatumor_Metastasis` FOREIGN KEY (`Metastasis`) REFERENCES `metastasis` (`idMetastasis`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Etapatumor_Tumorprimario` FOREIGN KEY (`Tumorprimario`) REFERENCES `tumorprimario` (`idTumorprimario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `horario`
--
ALTER TABLE `horario`
  ADD CONSTRAINT `FK_Horario_Consultorio` FOREIGN KEY (`Consultorio`) REFERENCES `consultorio` (`idConsultorio`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Horario_Especialidad` FOREIGN KEY (`Especialidad`) REFERENCES `espacialidades` (`idEspecialidades`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Horario_Medicos` FOREIGN KEY (`Medico`) REFERENCES `medicos` (`idMedico`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `hv`
--
ALTER TABLE `hv`
  ADD CONSTRAINT `FK_Hv_Medicos` FOREIGN KEY (`Medico`) REFERENCES `medicos` (`idMedico`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD CONSTRAINT `FK_Medicos_Departamento` FOREIGN KEY (`Departamento`) REFERENCES `departamentos` (`idDepartamento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Medicos_Municipio` FOREIGN KEY (`Municipio`) REFERENCES `municipios` (`idMunicipio`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Medicos_Rol` FOREIGN KEY (`Rol`) REFERENCES `roles` (`idRol`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `municipios`
--
ALTER TABLE `municipios`
  ADD CONSTRAINT `FK_Municipios_Departamento` FOREIGN KEY (`Departamento`) REFERENCES `departamentos` (`idDepartamento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD CONSTRAINT `FK_Pacientes_Departamento` FOREIGN KEY (`Departamento`) REFERENCES `departamentos` (`idDepartamento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Pacientes_Municipio` FOREIGN KEY (`Municipio`) REFERENCES `municipios` (`idMunicipio`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Pacientes_Rol` FOREIGN KEY (`Rol`) REFERENCES `roles` (`idRol`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `recetasmedicas`
--
ALTER TABLE `recetasmedicas`
  ADD CONSTRAINT `FK_Recetasmedicas_Etapatumor` FOREIGN KEY (`Etapatumor`) REFERENCES `etapatumor` (`idEtapatumor`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Recetasmedicas_Medicamentos` FOREIGN KEY (`Medicamentos`) REFERENCES `medicamentos` (`idMedicamento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Recetasmedicas_Pacientes` FOREIGN KEY (`Paciente`) REFERENCES `pacientes` (`idPaciente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `signosvitales`
--
ALTER TABLE `signosvitales`
  ADD CONSTRAINT `FK_Signosvitales_Pacientes` FOREIGN KEY (`Paciente`) REFERENCES `pacientes` (`idPaciente`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-03-2018 a las 05:14:09
-- Versión del servidor: 10.1.31-MariaDB
-- Versión de PHP: 7.2.3

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
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizarAuxiliar` (IN `sp_idAuxiliar` INT, IN `sp_nombre` VARCHAR(25), IN `sp_apellido` VARCHAR(35), IN `sp_apellidocasada` VARCHAR(35), IN `sp_genero` CHAR(1), IN `sp_fechanacimiento` DATE, IN `sp_tiposangre` CHAR(4), IN `sp_telefono` BIGINT(7), IN `sp_celular` BIGINT(10), IN `sp_estadocivil` VARCHAR(35), IN `sp_ocupacion` VARCHAR(80), IN `sp_religion` VARCHAR(50), IN `sp_pais` VARCHAR(35), IN `sp_departamento` VARCHAR(35), IN `sp_municipio` VARCHAR(50), IN `sp_domicilio` VARCHAR(120), IN `sp_email` VARCHAR(200), IN `sp_clave` VARCHAR(60), IN `sp_estado` INT)  BEGIN
	UPDATE auxiliares SET nombre = sp_nombre, apellido = sp_apellido, apellidocasada = sp_apellidocasada,
    	genero = sp_genero, fechanacimiento = sp_fechanacimiento, tiposangre = sp_tiposangre, telefono = sp_telefono,
        celular = sp_celular, estadocivil = sp_estadocivil, ocupacion = sp_ocupacion, religion = sp_religion, pais = sp_pais,
        departamento = sp_departamento, municipio = sp_municipio, domicilio = sp_domicilio, email = sp_email, clave = sp_clave,
        	estado = sp_estado WHERE idAuxiliar = sp_idAuxiliar;
            select 'ok' as exito;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizarEspecialidad` (IN `sp_idEspecialidades` INT, IN `sp_detalle` VARCHAR(200))  BEGIN
	UPDATE espacialidades SET detalle = sp_detalle WHERE idEspecialidades = sp_idEspecialidades;
    select 'ok' as exito ;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Consultorios` ()  BEGIN
	select * from  consultorio;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetPacientes` ()  BEGIN 
	select * from cita as C INNER JOIN pacientes as P ON C.Paciente = P.idPaciente;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_horarioMedico` (IN `sp_Medico` INT(3), IN `sp_Especialidad` INT(3))  BEGIN
	SELECT idHorario as id, fecha as start, CONCAT(horainicio," - " , horafinal) as title FROM horario WHERE Medico = sp_Medico AND Especialidad = sp_Especialidad;
   END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_horarioMedicoPorId` (IN `sp_Medico` INT)  BEGIN
	select * from horario as h INNER JOIN consultorio as c ON h.Consultorio = c.idConsultorio INNER JOIN espacialidades as e ON h.Especialidad = e.idEspecialidades WHERE h.Medico = sp_Medico;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_HorarioPaciente` (IN `sp_Medico` INT)  BEGIN
	SELECT P.idPaciente as id,  H.fecha AS start, CONCAT(P.nombre," - " , P.apellido , " - " , C.concepto , " - ", C.estado, " - ") as title  from cita as C INNER JOIN pacientes as P ON C.Paciente = P.idPaciente INNER JOIN horario as H ON H.idHorario = C.horario INNER JOIN medicos AS M ON M.idMedico = H.Medico WHERE M.idMedico = sp_Medico;
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
			INSERT INTO cita (idCIta, Paciente, Horario, concepto, estado, fecha_registro)
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rol` ()  BEGIN
select * from roles;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administradores`
--

CREATE TABLE `administradores` (
  `idAdministrador` int(11) NOT NULL,
  `codigo` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
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
  `pais` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `departamento` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `municipio` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  `domicilio` varchar(120) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `clave` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  `fecharegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estado` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `administradores`
--

INSERT INTO `administradores` (`idAdministrador`, `codigo`, `Rol`, `tipoidentificacion`, `identificacion`, `nombre`, `apellido`, `apellidocasada`, `genero`, `fechanacimiento`, `tiposangre`, `telefono`, `celular`, `estadocivil`, `ocupacion`, `religion`, `pais`, `departamento`, `municipio`, `domicilio`, `email`, `clave`, `fecharegistro`, `estado`) VALUES
(1, 'ADM1992', 1, 'CC', 1143356416, 'WILLIAM ALBERTO', 'PATERNINA ROMO', NULL, 'M', '1992-01-21', 'O+', NULL, 3008329299, 'SOLTERO', 'INGENIERO', 'CATOLICO', 'COLOMBIA', 'BOLIVAR', 'CARTAGENA', 'BARRIO NUEVO BOSQUE MZN 7 LOTE 39', 'INGWILLIAN@HOTMAIL.COM', '1143356416', '2018-03-13 02:58:02', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auxiliares`
--

CREATE TABLE `auxiliares` (
  `idAuxiliar` int(11) NOT NULL,
  `Medico` int(60) NOT NULL,
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
  `pais` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `departamento` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `municipio` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  `domicilio` varchar(120) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `clave` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  `fecharegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estado` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `auxiliares`
--

INSERT INTO `auxiliares` (`idAuxiliar`, `Medico`, `Rol`, `tipoidentificacion`, `identificacion`, `nombre`, `apellido`, `apellidocasada`, `genero`, `fechanacimiento`, `tiposangre`, `telefono`, `celular`, `estadocivil`, `ocupacion`, `religion`, `pais`, `departamento`, `municipio`, `domicilio`, `email`, `clave`, `fecharegistro`, `estado`) VALUES
(3, 1, 4, 'CC', 12345678, 'DEMO', 'DEMO', 'DEMO', 'M', '1965-09-09', 'A+', 67666888, 30987676766, 'SOLTERO', 'SIN OCUPACION', 'CRISTIANO', 'COLOMBIA', 'BOLIVAR', 'CARTAGENA', 'CRA58A', 'DEMO@DEMO.COM', 'QAZ123', '2018-03-30 22:01:15', 1);

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
  `fecha_registro` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `cita`
--

INSERT INTO `cita` (`idCita`, `Paciente`, `Horario`, `concepto`, `estado`, `fecha_registro`) VALUES
(2, 1, 1, 'CONSULTA RUTINARIA', 'ESPERA_ATENCION', '2018-03-16'),
(3, 2, 1, 'DOLOR DE MUSCULOS', 'ESPERA_ATENCION', '2018-03-16');

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
(1, 'PRINCIPAL', 'COLOMBIA', 'BOLIVAR', 'CARTAGENA', 'AVENIDA PEDRO HEREDIA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `espacialidades`
--

CREATE TABLE `espacialidades` (
  `idEspecialidades` int(11) NOT NULL,
  `Medico` int(11) NOT NULL,
  `especialidad` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  `detalle` text COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `espacialidades`
--

INSERT INTO `espacialidades` (`idEspecialidades`, `Medico`, `especialidad`, `detalle`) VALUES
(1, 1, 'ONCOLOGIA OSEA', 'ONCOLOGIA OSEA'),
(2, 2, 'ONCOLOGIA OBSTETRICIA', 'ONCOLOGIA OBSTETRICIA'),
(3, 1, 'ONCOLOGIA PULMONAR', 'ONCOLOGIA PULMONAR'),
(8, 1, 'ONCOLOGO RADIOLOGO', 'ONCOLOGIA TECNOLOGICA'),
(9, 1, 'ONCOLOGO NEONATAL', 'ONCOLOGO NEONATAL'),
(10, 1, 'ONCOLOGIA FRENTAL', 'ONCOLOGIA FRENTAL'),
(11, 1, 'ONCOLOGIA PRUEBA', 'ONCOLOGIA PRUEBA'),
(12, 1, 'DEMO', 'DEMO PRUEBA'),
(13, 1, 'PRUEBa', 'PRUEBA'),
(14, 1, 'ONCOLOGIA CEREBRAL', 'ESTUDIO COMPLETO de la cabeza'),
(16, 1, 'ONCOLOGIA NEURAL', 'oncologia neura'),
(17, 1, 'adas', 'adasdasdasdasasdasd'),
(18, 1, 'Pannm', 'kmnabsujhf demo');

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
(1, 1, 1, 1, '2018-03-30', '08:00:00', '13:00:00'),
(2, 1, 1, 1, '2018-03-31', '15:00:00', '16:59:00'),
(3, 1, 1, 1, '2018-03-29', '15:00:00', '16:59:00'),
(8, 1, 1, 1, '2018-03-30', '06:00:00', '06:52:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicos`
--

CREATE TABLE `medicos` (
  `idMedico` int(11) NOT NULL,
  `codigo` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  `Rol` int(11) NOT NULL DEFAULT '3',
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
  `pais` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `departamento` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `municipio` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  `domicilio` varchar(120) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `clave` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  `fecharegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estado` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `medicos`
--

INSERT INTO `medicos` (`idMedico`, `codigo`, `Rol`, `tipoidentificacion`, `identificacion`, `nombre`, `apellido`, `apellidocasada`, `genero`, `fechanacimiento`, `tiposangre`, `telefono`, `celular`, `estadocivil`, `ocupacion`, `religion`, `pais`, `departamento`, `municipio`, `domicilio`, `email`, `clave`, `fecharegistro`, `estado`) VALUES
(1, 'D12345', 3, 'CC', 123, 'HERNAN', 'SIMANCA', NULL, 'M', '2018-03-12', 'O+', 6626841, 3017250139, 'SOLTERO', 'ORTOPEDA', 'CRISTIANO', 'COLOMBIA', 'BOLIVAR', 'CARTAGENA', 'NO TIENE', 'HERNAN.SIMANCA@HOTMAIL.COM', '123', '2018-03-14 04:29:03', 1),
(2, 'M432', 3, 'CC', 5678, 'ARNALDO', 'CASTILLA', NULL, 'M', '2018-03-06', 'AB+', 6765874, 3012451141, 'SOLTERO', 'ONCOLOGO GASTRICO', 'CRISTIANO', 'MEXICO', 'MEXICO DC', 'MEXICO DC', '', 'ONC.ARNALDO@GMAIL.COM', '5678', '2018-03-14 23:18:24', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `idPaciente` int(11) NOT NULL,
  `codigo` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  `Rol` int(11) NOT NULL DEFAULT '2',
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
  `pais` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `departamento` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `municipio` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  `domicilio` varchar(120) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `clave` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  `fecharegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estado` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pacientes`
--

INSERT INTO `pacientes` (`idPaciente`, `codigo`, `Rol`, `tipoidentificacion`, `identificacion`, `nombre`, `apellido`, `apellidocasada`, `genero`, `fechanacimiento`, `tiposangre`, `telefono`, `celular`, `estadocivil`, `ocupacion`, `religion`, `pais`, `departamento`, `municipio`, `domicilio`, `email`, `clave`, `fecharegistro`, `estado`) VALUES
(1, 'ABCDE', 2, 'CC', 123, 'ARNALDO', 'RAFAEL', NULL, 'M', '2018-03-06', 'A+', 67658777, 3172755590, 'SOLTERO', 'DESARROLLADOR', 'CRISTIANO', 'COLOMBIA', 'BOLIVAR', 'CARTAGENA', 'CRA 58A #6 - 88', 'ARNALDO.CASTILLA@HOTMAIL.COM', '123', '2018-03-14 04:30:47', 1),
(2, 'QAZ123', 2, 'CC', 741852, 'ROBERTO', 'MOREALES', NULL, 'M', '2017-12-19', 'A+', 6662651, 3014521456, 'CASADO', 'INGENIERO MECANICO', 'MUSULMAN', 'COLOMBIA', 'ATLANTICO', 'BARRANQUILLA', 'NO TENGO', 'ROBERTO.MORALES@YAHOO.ES', '741852', '2018-03-16 21:25:12', 1);

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
(4, 'AUXILIAR', 'REPORTAR');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administradores`
--
ALTER TABLE `administradores`
  ADD PRIMARY KEY (`idAdministrador`),
  ADD UNIQUE KEY `UC_Administradores` (`identificacion`,`telefono`,`celular`,`email`),
  ADD KEY `FK_Administradores_Roles_INDEX` (`Rol`);

--
-- Indices de la tabla `auxiliares`
--
ALTER TABLE `auxiliares`
  ADD PRIMARY KEY (`idAuxiliar`),
  ADD UNIQUE KEY `UC_Auxiliares` (`identificacion`,`telefono`,`celular`,`email`),
  ADD KEY `FK_Auxiliares_Roles_INDEX` (`Rol`);

--
-- Indices de la tabla `cita`
--
ALTER TABLE `cita`
  ADD PRIMARY KEY (`idCita`),
  ADD KEY `FK_Cita_Paciente_INDEX` (`Paciente`),
  ADD KEY `FK_Cita_Horario_INDEX` (`Horario`);

--
-- Indices de la tabla `consultorio`
--
ALTER TABLE `consultorio`
  ADD PRIMARY KEY (`idConsultorio`);

--
-- Indices de la tabla `espacialidades`
--
ALTER TABLE `espacialidades`
  ADD PRIMARY KEY (`idEspecialidades`),
  ADD KEY `FK_Espacialidades_Medicos_INDEX` (`Medico`);

--
-- Indices de la tabla `horario`
--
ALTER TABLE `horario`
  ADD PRIMARY KEY (`idHorario`),
  ADD KEY `FK_Horario_Medicos_INDEX` (`Medico`),
  ADD KEY `FK_Horario_Consultorio_INDEX` (`Consultorio`),
  ADD KEY `FK_Horario_Especialidad` (`Especialidad`);

--
-- Indices de la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD PRIMARY KEY (`idMedico`),
  ADD UNIQUE KEY `UC_Medicos` (`identificacion`,`telefono`,`celular`,`email`),
  ADD KEY `FK_Medicos_Roles_INDEX` (`Rol`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`idPaciente`),
  ADD UNIQUE KEY `UC_Pacientes` (`identificacion`,`telefono`,`celular`,`email`),
  ADD KEY `FK_Pacientes_Roles_INDEX` (`Rol`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`idRol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `administradores`
--
ALTER TABLE `administradores`
  MODIFY `idAdministrador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `auxiliares`
--
ALTER TABLE `auxiliares`
  MODIFY `idAuxiliar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `cita`
--
ALTER TABLE `cita`
  MODIFY `idCita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `consultorio`
--
ALTER TABLE `consultorio`
  MODIFY `idConsultorio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `espacialidades`
--
ALTER TABLE `espacialidades`
  MODIFY `idEspecialidades` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `horario`
--
ALTER TABLE `horario`
  MODIFY `idHorario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `medicos`
--
ALTER TABLE `medicos`
  MODIFY `idMedico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `idPaciente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `idRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `administradores`
--
ALTER TABLE `administradores`
  ADD CONSTRAINT `FK_Administradores_Rol` FOREIGN KEY (`Rol`) REFERENCES `roles` (`idRol`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `auxiliares`
--
ALTER TABLE `auxiliares`
  ADD CONSTRAINT `FK_Auxiliares_Rol` FOREIGN KEY (`Rol`) REFERENCES `roles` (`idRol`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `FK_Cita_Horario` FOREIGN KEY (`Horario`) REFERENCES `horario` (`idHorario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Cita_Paciente` FOREIGN KEY (`Paciente`) REFERENCES `pacientes` (`idPaciente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `espacialidades`
--
ALTER TABLE `espacialidades`
  ADD CONSTRAINT `FK_Espacialidades_Medicos` FOREIGN KEY (`Medico`) REFERENCES `medicos` (`idMedico`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `horario`
--
ALTER TABLE `horario`
  ADD CONSTRAINT `FK_Horario_Consultorio` FOREIGN KEY (`Consultorio`) REFERENCES `consultorio` (`idConsultorio`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Horario_Especialidad` FOREIGN KEY (`Especialidad`) REFERENCES `espacialidades` (`idEspecialidades`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Horario_Medicos` FOREIGN KEY (`Medico`) REFERENCES `medicos` (`idMedico`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD CONSTRAINT `FK_Medicos_Rol` FOREIGN KEY (`Rol`) REFERENCES `roles` (`idRol`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD CONSTRAINT `FK_Pacientes_Rol` FOREIGN KEY (`Rol`) REFERENCES `roles` (`idRol`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

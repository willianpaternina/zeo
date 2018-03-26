<?php

require_once $_SERVER['DOCUMENT_ROOT'] . "/Zeo/Configuracion/Conexion.php";
require_once $_SERVER['DOCUMENT_ROOT'] . "/Zeo/Dao/IMedicos.php";
require_once $_SERVER['DOCUMENT_ROOT'] . "/Zeo/Modelo/Sesion.php";

/**
 * Description of MedicosControlador
 *
 * @author Willian
 */
class MedicosControlador extends Conexion implements IMedicos {

    public $objSe;
    public $result;

    public function __construct() {
        parent::ConexionMySQLServer();
        $this->objSe = new Sesion();
        $this->result = array();
    }

    public function ActualizarInformacion(Medicos $medicos) {
        
    }

    public function IniciarSesionMedico() {
        try {
            $stm = $this->cnn->prepare("SELECT *
                                    FROM medicos m 
                                    INNER JOIN Roles r ON m.Rol = r.idRol
                                    WHERE m.identificacion = :identificacion AND m.clave = :clave AND m.Rol = :rol;");
            $stm->bindParam(':identificacion', $_POST["identificacion"]);
            $stm->bindParam(':clave', $_POST["clave"]);
            $stm->bindParam(':rol', $_POST["rol"]);
            $stm->execute();
            $result = $stm->fetchAll();
            if ($result) {
                $rol = $result[0]['rol'];
                switch ($rol) {
                    case 'MEDICO' :
                        $this->objSe->init();
                        $this->objSe->set('idMedico', $result[0]['idMedico']);
                        $this->objSe->set('codigo', $result[0]['codigo']);
                        $this->objSe->set('nombre', $result[0]['nombre']);
                        $this->objSe->set('apellido', $result[0]['apellido']);
                        $this->objSe->set('apellidocasada', $result[0]['apellidocasada']);
                        $this->objSe->set('idRol', $result[0]['idRol']);
                        $this->objSe->set('rol', $result[0]['rol']);
                        header('Location: ../Vistas/Medico/LayoutMedico.php');
                        break;
                }
            } else {
                header('Location: ../index.php?error=1');
            }
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

    public function ListaPaciente() {
        try {
            $result = array();
            $stm = $this->cnn->prepare("SELECT * FROM pacientes;");
            $stm->execute();
            foreach ($stm->fetchAll(PDO::FETCH_OBJ) as $_paciente) {
                $paciente = new Pacientes();
                $paciente->setIdPaciente($_paciente->idPaciente);
                $paciente->setCodigo($_paciente->codigo);
                $paciente->setRol($_paciente->Rol);
                $paciente->setTipoidentificacion($_paciente->tipoidentificacion);
                $paciente->setIdentificacion($_paciente->identificacion);
                $paciente->setNombre($_paciente->nombre);
                $paciente->setApellido($_paciente->apellido);
                $paciente->setApellidocasada($_paciente->apellidocasada);
                $paciente->setGenero($_paciente->genero);
                $paciente->setFechanacimiento($_paciente->fechanacimiento);
                $paciente->setTiposangre($_paciente->tiposangre);
                $paciente->setTelefono($_paciente->telefono);
                $paciente->setCelular($_paciente->celular);
                $paciente->setEstadocivil($_paciente->estadocivil);
                $paciente->setOcupacion($_paciente->ocupacion);
                $paciente->setReligion($_paciente->religion);
                $paciente->setPais($_paciente->pais);
                $paciente->setDepartamento($_paciente->departamento);
                $paciente->setMunicipio($_paciente->municipio);
                $paciente->setDomicilio($_paciente->domicilio);
                $paciente->setEmail($_paciente->email);
                $paciente->setClave($_paciente->clave);
                $paciente->setFecharegistro($_paciente->fecharegistro);
                $paciente->setEstado($_paciente->estado);
                $result[] = $paciente;
            }
            return $result;
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }
    
    public function ListaPacientePorId($idPaciente) {
        try {
            $stm = $this->cnn->prepare("CALL sp_GetPacienteById (?);");
            $stm->execute(array($idPaciente));
        } catch (Exception $e) {
            die($e->getMessage());
        }
    }

    public function RegistrarPaciente(Pacientes $pacientes) {
        try {
            $sql = "CALL sp_RegisterPacientes (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
            $this->cnn->prepare($sql)->execute(array(
                $pacientes->getCodigo('codigo'),
                $pacientes->getTipoidentificacion('tipoidentificacion'),
                $pacientes->getIdentificacion('identificacion'),
                $pacientes->getNombre('nombre'),
                $pacientes->getApellido('apellido'),
                $pacientes->getApellidocasada('apellidocasada'),
                $pacientes->getGenero('genero'),
                $pacientes->getFechanacimiento('fechanacimiento'),
                $pacientes->getTiposangre('tiposangre'),
                $pacientes->getTelefono('telefono'),
                $pacientes->getCelular('celular'),
                $pacientes->getEstadocivil('estadocivil'),
                $pacientes->getOcupacion('ocupacion'),
                $pacientes->getReligion('religion'),
                $pacientes->getPais('pais'),
                $pacientes->getDepartamento('departamento'),
                $pacientes->getMunicipio('municipio'),
                $pacientes->getDomicilio('domicilio'),
                $pacientes->getEmail('email'),
                $pacientes->getClave('clave'))
            );
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

    public function listarMedicos($estado = 1) {
        $sql = "CALL sp_listarMedicos (?);";
        $stmt = $this->cnn->prepare($sql);
        $stmt->bindParam(1, $estado);
        $stmt->execute();

        while ($row = $stmt->fetch()) {
            $this->result[] = $row;
        }

        return $this->result;
    }

    public function horarioMedico($Medico, $Especialidad) {
        $sql = "CALL sp_horarioMedico (?, ?);";
        $stmt = $this->cnn->prepare($sql);
        $stmt->bindParam(1, $Medico);
        $stmt->bindParam(2, $Especialidad);
        $stmt->execute();

        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $this->result[] = $row;
        }

        return $this->result;
    }

    public function registrarCita($id_paciente, $id_horario, $concepto, $estado) {
        /*
         * Capturar mensaje de procedimiento almacenado
         */
        try {
            $sql = "CALL sp_RegistrarCita (?, ?, ?, ?);   ";
            $stmt = $this->cnn->prepare($sql);
            $stmt->bindParam(1, $id_paciente);
            $stmt->bindParam(2, $id_horario);
            $stmt->bindParam(3, $concepto);
            $stmt->bindParam(4, $estado);

            $stmt->execute();
            if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $this->result[] = $row;
            }
            return $this->result;
            return;
        } catch (Exception $exc) {
            echo $exc->getMessage();
        }
    }

    public function horarioCitaPaciente($id_medico) {
        try {
            $sql = "CALL sp_HorarioPaciente (?);";
            $stmt = $this->cnn->prepare($sql);
            $stmt->bindParam(1, $id_medico);

            $rpta = $stmt->execute();
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $this->result[] = $row;
            }
            return $this->result;
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

}

if (isset($_POST["idMedico"]) and isset($_POST["idEspecialidad"])) {
    $controlador = new MedicosControlador();
    $r = $controlador->horarioMedico($_POST["idMedico"], $_POST["idEspecialidad"]);
    echo json_encode($r);
    return;
}
if (isset($_POST["registrarCita"]) and $_POST["registrarCita"] == "si") {
    $controlador = new MedicosControlador();
    $r = $controlador->registrarCita($_POST["id_paciente"], $_POST["id_horario"], $_POST["concepto"], $_POST["estado"]);
    echo json_encode($r);
    return;
}
if (isset($_POST["citaMedica"])) {
    session_start();
    $controlador = new MedicosControlador();
    $r = $controlador->horarioCitaPaciente($_SESSION["idMedico"]);
    echo json_encode($r);
    return;
}
?>
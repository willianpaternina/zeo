<?php

require_once $_SERVER['DOCUMENT_ROOT'] . "/Zeo/Configuracion/Conexion.php";
require_once $_SERVER['DOCUMENT_ROOT'] . "/Zeo/Dao/IMedicos.php";
require_once $_SERVER['DOCUMENT_ROOT'] . "/Zeo/Modelo/Sesion.php";
require_once $_SERVER['DOCUMENT_ROOT']."/Zeo/Modelo/Especialidades.php";
require_once $_SERVER['DOCUMENT_ROOT']."/Zeo/Modelo/Auxiliares.php";

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

    public function medicosEspecialidades($id_medico) {
        try {
            $sql = "select idEspecialidades, especialidad, detalle from espacialidades where Medico = ?;";
            //echo $sql;exit;
            $stmt = $this->cnn->prepare($sql);
            $stmt->bindParam(1, $id_medico);

            $stmt->execute();
            
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $this->result[] = $row;
            }
            return $this->result;
            
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

    public function registrarEspecialidad(Especialidades $Especialidad) {
        try {
            $sql = "CALL sp_registrarEspecilidad (?, ?, ?);";
            $stmt = $this->cnn->prepare($sql);
            $stmt->bindParam(1, $Especialidad->getMedico());
            $stmt->bindParam(2, $Especialidad->getEspecialidad());
            $stmt->bindParam(3, $Especialidad->getDetalleespecialidad());

            $stmt->execute();
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $this->result[] = $row;
            }
            return $this->result;
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

    public function actualizarEspecialidad(Especialidades $Especialidad) {
        try {
            $sql = "CALL sp_actualizarEspecialidad (?, ?);";
            $stmt = $this->cnn->prepare($sql);
            $stmt->bindParam(1, $Especialidad->getIdEspecialidades());
            $stmt->bindParam(2, $Especialidad->getDetalleespecialidad());
            
            $stmt->execute();
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $this->result[] = $row;
            }
            return $this->result;
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

    public function listarAuxiliarMedico($id_medico) {
        try {
            $sql = "call sp_listarAuxiliaresMedicos(?);";
            //echo $sql;exit;
            $stmt = $this->cnn->prepare($sql);
            $stmt->bindParam(1, $id_medico);

            $stmt->execute();
            
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $this->result[] = $row;
            }
            return $this->result;
            
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

    public function registrarAuxiliarMedico(Auxiliares $auxiliares) {
        try {
            $sql = "CALL sp_registrarAuxiliarMedico (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
            $stmt = $this->cnn->prepare($sql);
            $stmt->bindParam(1, $auxiliares->getCodigo());
            $stmt->bindParam(2, $auxiliares->getRol());
            $stmt->bindParam(3, $auxiliares->getTipoidentificacion());
            $stmt->bindParam(4, $auxiliares->getIdentificacion());
            $stmt->bindParam(5, $auxiliares->getNombre());
            $stmt->bindParam(6, $auxiliares->getApellido());
            $stmt->bindParam(7, $auxiliares->getApellidocasada());
            $stmt->bindParam(8, $auxiliares->getGenero());
            $stmt->bindParam(9, $auxiliares->getFechanacimiento());
            $stmt->bindParam(10, $auxiliares->getTiposangre());
            $stmt->bindParam(11, $auxiliares->getTelefono());
            $stmt->bindParam(12, $auxiliares->getCelular());
            $stmt->bindParam(13, $auxiliares->getEstadocivil());
            $stmt->bindParam(14, $auxiliares->getOcupacion());
            $stmt->bindParam(15, $auxiliares->getReligion());
            $stmt->bindParam(16, $auxiliares->getPais());
            $stmt->bindParam(17, $auxiliares->getDepartamento());
            $stmt->bindParam(18, $auxiliares->getMunicipio());
            $stmt->bindParam(19, $auxiliares->getDomicilio());
            $stmt->bindParam(20, $auxiliares->getEmail());
            $stmt->bindParam(21, $auxiliares->getClave());
            $stmt->bindParam(22, $auxiliares->getEstado());
            $stmt->bindParam(23, $auxiliares->getFecharegistro());
            
            $stmt->execute();
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $this->result[] = $row;
            }
            return $this->result;
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

    public function listarAuxiliaresPorId($id_auxiliar) {
        $sql = "CALL sp_listarAuxiliarPorId (?);";
        $stmt = $this->cnn->prepare($sql);
        $stmt->bindParam(1, $id_auxiliar);
        $stmt->execute();

        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $this->result[] = $row;
        }

        return $this->result;
    }

    public function actualizarAuxiliarMedico(Auxiliares $auxiliares) {
         try {
            $sql = "CALL sp_actualizarAuxiliar (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
            $stmt = $this->cnn->prepare($sql);
            $stmt->bindParam(1, $auxiliares->getIdAuxiliar());
            $stmt->bindParam(2, $auxiliares->getNombre());
            $stmt->bindParam(3, $auxiliares->getApellido());
            $stmt->bindParam(4, $auxiliares->getApellidocasada());
            $stmt->bindParam(5, $auxiliares->getGenero());
            $stmt->bindParam(6, $auxiliares->getFechanacimiento());
            $stmt->bindParam(7, $auxiliares->getTiposangre());
            $stmt->bindParam(8, $auxiliares->getTelefono());
            $stmt->bindParam(9, $auxiliares->getCelular());
            $stmt->bindParam(10, $auxiliares->getEstadocivil());
            $stmt->bindParam(11, $auxiliares->getOcupacion());
            $stmt->bindParam(12, $auxiliares->getReligion());
            $stmt->bindParam(13, $auxiliares->getPais());
            $stmt->bindParam(14, $auxiliares->getDepartamento());
            $stmt->bindParam(15, $auxiliares->getMunicipio());
            $stmt->bindParam(16, $auxiliares->getDomicilio());
            $stmt->bindParam(17, $auxiliares->getEmail());
            $stmt->bindParam(18, $auxiliares->getClave());
            $stmt->bindParam(19, $auxiliares->getEstado());
            
            $stmt->execute();
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $this->result[] = $row;
            }
            return $this->result;
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

    public function listarHorarioMedicoPorId($id_medico) {
        $sql = "CALL sp_horarioMedicoPorId (?);";
        $stmt = $this->cnn->prepare($sql);
        $stmt->bindParam(1, $id_medico);
        $stmt->execute();

        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $this->result[] = $row;
        }

        return $this->result;
    }

    public function listarConsultorios() {
        try {
            $sql = "CALL sp_Consultorios ();";
            $stmt = $this->cnn->prepare($sql);
            $stmt->execute();

            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $this->result[] = $row;
            }

            return $this->result;
        } catch (Exception $exc) {
            echo $exc->getTraceAsString();
        }
    }
    public function actualizarEstado($idCita, $estado){
        $sql = " call sp_actualizarEstadoCita(?, ?); ";
        $stmt = $this->cnn->prepare($sql);
        $stmt->bindParam(1, $idCita);
        $stmt->bindParam(2, $estado);

        $stmt->execute();
        if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $this->result[] = $row;
        }
        return $this->result;
    }
    
    public function listarCitaEstado($id_medico, $estado){
        $sql = " call sp_listarCitaEstado(?, ?); ";
        $stmt = $this->cnn->prepare($sql);
        $stmt->bindParam(1, $id_medico);
        $stmt->bindParam(2, $estado);

        $stmt->execute();
        if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $this->result[] = $row;
        }
        return $this->result;
    }

    public function medicoRegistrarActividad($datos) {
        $sql = " call sp_registrarActividad(?, ?, ?, ?, ?, ?); ";
        $stmt = $this->cnn->prepare($sql);
        $stmt->bindParam(1, $datos["idPaciente"]);
        $stmt->bindParam(2, $datos["etapaTumor"]);
        $stmt->bindParam(3, $datos["concepto"]);
        $stmt->bindParam(4, $datos["estado"]);
        $stmt->bindParam(5, $datos["numHoras"]);
        $stmt->bindParam(6, $datos["numDias"]);

        $stmt->execute();
        if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $this->result[] = $row;
        }
        return $this->result;
    }

    public function consultarActividadesEtapa($idPaciente) {
        $sql = " call sp_consultarActividadesEtapatumo(?); ";
        $stmt = $this->cnn->prepare($sql);
        $stmt->bindParam(1, $idPaciente);

        $stmt->execute();
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $this->result[] = $row;
        }
        return $this->result;
    }

    public function medicoRegistrarMedicamento($datos) {
        $sql = " call sp_registrarMedicamento(?, ?, ?, ?, ?, ?); ";
        $stmt = $this->cnn->prepare($sql);
        $stmt->bindParam(1, $datos["idPacienteMed"]);
        $stmt->bindParam(2, $datos["medicamentos"]);
        $stmt->bindParam(3, $datos["etapa"]);
        $stmt->bindParam(4, $datos["concepto"]);
        $stmt->bindParam(5, $datos["medNumHoras"]);
        $stmt->bindParam(6, $datos["medNumDias"]);

        $stmt->execute();
        if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $this->result[] = $row;
        }
        return $this->result;
    }

    public function listarMedicamentoPaciente($idPaciente) {
        $sql = " call sp_listarMedicamentosPaciente(?); ";
        $stmt = $this->cnn->prepare($sql);
        $stmt->bindParam(1, $idPaciente);

        $stmt->execute();
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $this->result[] = $row;
        }
        return $this->result;
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
if(isset($_GET["medicoEspecialidades"]) && $_GET["medicoEspecialidades"]=="especialidad" ){
    session_start();
    $controlador = new MedicosControlador();
    $r = $controlador->medicosEspecialidades($_SESSION["idMedico"]);
    echo '{
            "data": [';
            for($i=0;$i<count($r)-1;$i++){
            echo ' 
              [
                "'.($i+1).'",
                "'.$r[$i]["especialidad"].'",
                "'.$r[$i]["detalle"].'",
                "'.$r[$i]["idEspecialidades"].'"
              ],';
            }
            echo ' 
              [
                "'.(count($r)).'",
                "'.$r[$i]["especialidad"].'",
                "'.$r[$i]["detalle"].'",
                "'.$r[$i]["idEspecialidades"].'"
              ]
            ]
          }';
    return;
    
}
if(isset($_GET["medicoEspecialidades"]) && $_GET["medicoEspecialidades"]=="RegistrarEspecialidad" ){
    error_reporting(0);
    session_start();
    $controlador = new MedicosControlador();
    $r = $controlador->registrarEspecialidad(new Especialidades(0, $_SESSION["idMedico"], $_POST["especialidad"], $_POST["detalle"]));
    echo json_encode($r);
    return;
}
if(isset($_GET["medicoEspecialidades"]) && $_GET["medicoEspecialidades"]=="ActualizarEspecialidad" ){
    error_reporting(0);
    session_start();
    $controlador = new MedicosControlador();
    $r = $controlador->actualizarEspecialidad(new Especialidades($_POST["idEspecialidad"], null, null, $_POST["detalle"]));
    echo json_encode($r);
    return;
}
if(isset($_GET["medicoEspecialidades"]) && $_GET["medicoEspecialidades"]=="listarAuxiliaresMedico"){
    session_start(); 
    $controlador = new MedicosControlador();
     $r = $controlador->listarAuxiliarMedico($_SESSION["idMedico"]);
     
     echo '{
            "data": [';
            for($i=0;$i<count($r)-1;$i++){
            echo ' 
              [
                "'.($i+1).'",
                "'.$r[$i]["tipoidentificacion"]." ".$r[$i]["identificacion"].'",
                "'.$r[$i]["nombre"].'",
                "'.$r[$i]["apellido"].'",
                "'.$r[$i]["fechanacimiento"].'",
                "'.$r[$i]["idAuxiliar"].'"
              ],';
            }
            echo ' 
              [
                "'.(count($r)).'",
                "'.$r[$i]["tipoidentificacion"]." ".$r[$i]["identificacion"].'",
                "'.$r[$i]["nombre"].'",
                "'.$r[$i]["apellido"].'",
                "'.$r[$i]["fechanacimiento"].'",
                "'.$r[$i]["idAuxiliar"].'"
              ]
            ]
          }';
    return;
}
if(isset($_POST["medicoEspecialidades"]) && $_POST["medicoEspecialidades"]=="registrarAuxiliarMedico"){
    //print_r($_POST);return;
    error_reporting(0);
    session_start();
    $controlador = new MedicosControlador();
    $r = $controlador->registrarAuxiliarMedico(
            new Auxiliares(
                    0, $_SESSION["idMedico"], 4, $_POST["tipo_ident"],$_POST["identificacion"],$_POST["nombre"],$_POST["apellido"],$_POST["apellidocasado"],$_POST["genero"],
                    $_POST["fechanac"],$_POST["tiposangre"],$_POST["telefono"],$_POST["celular"],$_POST["estadocivil"],$_POST["ocupacion"],$_POST["religion"],$_POST["pais"],$_POST["departamento"],
                    $_POST["municipio"], $_POST["domicilio"], $_POST["email"], $_POST["clave"], $_POST["tipo_ident"].$_POST["identificacion"],1
                    )
            );
    echo json_encode($r);
    return;
}
if(isset($_POST["medicoEspecialidades"]) && $_POST["medicoEspecialidades"]=="listarAuxiliaresPorId"){
    $controlador = new MedicosControlador();
    $r = $controlador->listarAuxiliaresPorId($_POST["idAuxiliar"]);
    echo json_encode($r);
    return;
}
if(isset($_POST["medicoEspecialidades"]) && $_POST["medicoEspecialidades"]=="actualizarAuxiliar"){
    error_reporting(0);
    session_start();
    $controlador = new MedicosControlador();
    $r = $controlador->actualizarAuxiliarMedico(
            new Auxiliares(
                    $_POST["idAuxiliar"], 0, 0, null, 0, $_POST["nombre"], $_POST["apellido"], $_POST["apellidocasado"], $_POST["genero"], $_POST["fechanac"], $_POST["tiposangre"],
                    $_POST["telefono"], $_POST["celular"], $_POST["estadocivil"], $_POST["ocupacion"], $_POST["religion"], $_POST["pais"], $_POST["departamento"], $_POST["municipio"], $_POST["domicilio"],
                    $_POST["email"], $_POST["clave"], null, $_POST["estado"]
                    )
            );
    echo json_encode($r);
    return;
}

if(isset($_GET["medicoEspecialidades"]) && $_GET["medicoEspecialidades"]=="listarHorarioMedicoPorId"){
    session_start();
    $controlador = new MedicosControlador();
    $r = $controlador->listarHorarioMedicoPorId($_SESSION["idMedico"]);
     echo '{
            "data": [';
            for($i=0;$i<count($r)-1;$i++){
            echo ' 
              [
                "'.($i+1).'",
                "'.$r[$i]["nombre"].'",
                "'.$r[$i]["especialidad"].'",
                "'.$r[$i]["fecha"].'",
                "'.$r[$i]["horainicio"].'",
                "'.$r[$i]["horafinal"].'"
              ],';
            }
            echo ' 
              [
                "'.(count($r)).'",
                "'.$r[$i]["nombre"].'",
                "'.$r[$i]["especialidad"].'",
                "'.$r[$i]["fecha"].'",
                "'.$r[$i]["horainicio"].'",
                "'.$r[$i]["horafinal"].'"
              ]
            ]
          }';
    return;
}
if(isset($_GET["medicoEspecialidades"]) && $_GET["medicoEspecialidades"]=="listarConsultorios"){
    $controlador = new MedicosControlador();
    $r = $controlador->listarConsultorios();
    echo json_encode($r);
    return;
}

if(isset($_POST["actualizarEstado"]) && $_POST["actualizarEstado"]=="estado"){
    
    $controlador = new MedicosControlador();
    $r = $controlador->actualizarEstado($_POST["idCita"], $_POST["estado"]);
    echo json_encode($r);
    return;
}

if(isset($_GET["listarCitaEstado"]) && $_GET["listarCitaEstado"]=="listarEstadoMedico"){
    session_start();
    $controlador = new MedicosControlador();
    $r = $controlador->listarCitaEstado($_SESSION["idMedico"], 'ATENDIDO');
     if(count($r) != 0){
         echo '{
            "data": [';
            for($i=0;$i<count($r)-1;$i++){
            echo ' 
              [
                "'.($i+1).'",
                "'.$r[$i]["nombre"].'",
                "'.$r[$i]["fecha"].'",
                "'.$r[$i]["estado"].'",
                "'.$r[$i]["idPaciente"].'"
              ],';
            }
            echo ' 
              [
                "'.(count($r)).'",
                "'.$r[$i]["nombre"].'",
                "'.$r[$i]["fecha"].'",
                "'.$r[$i]["estado"].'",
                "'.$r[$i]["idPaciente"].'"
              ]
            ]
          }';
     }else{
         echo '{
            "data": [';
            
            echo ' 
              [
                "",
                "",
                "",
                "",
                ""
              ] 
              ]
              }';
            
            
     }
    return;
}
if(isset($_POST["medigoRegistrarActividad"]) && $_POST["medigoRegistrarActividad"]=="registarActividad"){
    //print_r($_POST);return;
    $datos = array(
        "idPaciente" => $_POST["idPaciente"],
        "etapaTumor" => $_POST["etapaTumor"],
        "concepto" => $_POST["concepto"],
        "estado" => $_POST["estado"],
        "numHoras" => $_POST["numHoras"],
        "numDias" => $_POST["numDias"],
    );
    $regitrarActividad = new MedicosControlador();
    $r = $regitrarActividad->medicoRegistrarActividad($datos);
    echo json_encode($r);return;
}
if(isset($_GET["consultarActividadesEtapa"]) && $_GET["consultarActividadesEtapa"]=="listarActividades"){
    $controller = new MedicosControlador();
    $r = $controller->consultarActividadesEtapa($_GET["idPaciente"]);
    if(count($r) != 0){
         echo '{
            "data": [';
            for($i=0;$i<count($r)-1;$i++){
            echo ' 
              [
                "'.$r[$i]["nombreetapa"].'",
                "'.$r[$i]["concepto"].'",
                "'.$r[$i]["estado"].'",
                "'.$r[$i]["fecharegistro"].'",
                "'.$r[$i]["numerohora"].'",
                "'.$r[$i]["numerodia"].'"
              ],';
            }
            echo ' 
              [
                "'.$r[$i]["nombreetapa"].'",
                "'.$r[$i]["concepto"].'",
                "'.$r[$i]["estado"].'",
                "'.$r[$i]["fecharegistro"].'",
                "'.$r[$i]["numerohora"].'",
                "'.$r[$i]["numerodia"].'"
              ]
            ]
          }';
     }else{
         echo '{
            "data": [';
            
            echo ' 
              [
                "",
                "",
                "",
                "",
                "",
                "",
                ""
              ] 
              ]
              }';
            
            
     }
    return;
}
if(isset($_POST["registrarMedicamento"]) && $_POST["registrarMedicamento"]=="medicoRegistrarMedicamento"){
    //print_r($_POST);return;
    $datos = array(
        "idPacienteMed" => $_POST["idPacienteMed"],
        "medicamentos" => $_POST["medicamentos"],
        "etapa" => $_POST["etapa"],
        "concepto" => $_POST["concepto"],
        "medNumHoras" => $_POST["medNumHoras"],
        "medNumDias" => $_POST["medNumDias"]
    );
    $controller = new MedicosControlador();
    $r = $controller->medicoRegistrarMedicamento($datos);
    echo json_encode($r);
}

if(isset($_GET["listarMedicamentoPaciente"]) && $_GET["listarMedicamentoPaciente"]=="listar"){
    $controller = new MedicosControlador();
    $r = $controller->listarMedicamentoPaciente($_GET["idPaciente"]);
    if(count($r) != 0){
         echo '{
            "data": [';
            for($i=0;$i<count($r)-1;$i++){
            echo ' 
              [
                "'.$r[$i]["nombre"].'",
                "'.$r[$i]["nombreetapa"].'",
                "'.$r[$i]["concepto"].'",
                "'.$r[$i]["fecharegistro"].'",
                "'.$r[$i]["numerohora"].'",
                "'.$r[$i]["numerodia"].'"
              ],';
            }
            echo ' 
              [
                "'.$r[$i]["nombre"].'",
                "'.$r[$i]["nombreetapa"].'",
                "'.$r[$i]["concepto"].'",
                "'.$r[$i]["fecharegistro"].'",
                "'.$r[$i]["numerohora"].'",
                "'.$r[$i]["numerodia"].'"
              ]
            ]
          }';
     }else{
         echo '{
            "data": [';
            
            echo ' 
              [
                "",
                "",
                "",
                "",
                "",
                ""
              ] 
              ]
              }';
            
            
     }
    return;
}
?>
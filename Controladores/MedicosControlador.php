<?php
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
            $stm = $this->cnn->prepare("CALL sp_GetPacientes();");
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
                $result[] = $paciente;
            }
            return $result;
        } catch (PDOException $e) {
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

}

?>
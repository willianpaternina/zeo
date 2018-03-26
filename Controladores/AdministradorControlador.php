<?php
/**
 * Esta clase contiene los metodos para interacturar con las diferentes vistas
 *
 * @package    Controladores
 * @author     Willian Paternina <willian.paternina@unisinu.edu.co>
 * @copyright  2017-2018 Proyecto de grado para optar el titulo de ingeniero de sistemas
 * @version    1.0
 */
class AdministradorControlador extends Conexion implements IAdministradores {
    
    public $objSe;
    public $result;
    
    public function __construct() {
        parent::ConexionMySQLServer();
        $this->objSe = new Sesion();
    }
    
    public function ActualizarInformacion(Administradores $administradores) {
        
    }

    public function IniciarSesionAdministrador() {
        try {
            $stm = $this->cnn->prepare("SELECT *
                                        FROM Administradores a 
                                        INNER JOIN Roles r ON a.Rol = r.idRol
                                        WHERE a.identificacion = :identificacion AND a.clave = :clave AND a.Rol = :rol;");
            $stm->bindParam(':identificacion', $_POST["identificacion"]);
            $stm->bindParam(':clave', $_POST["clave"]);
            $stm->bindParam(':rol', $_POST["rol"]);
            $stm->execute();
            $result = $stm->fetchAll();
            if ($result) {
                $rol = $result[0]['rol'];
                switch ($rol) {
                    case 'ADMINISTRADOR' :
                        $this->objSe->init();
                        $this->objSe->set('idAdministrador', $result[0]['idAdministrador']);
                        $this->objSe->set('codigo', $result[0]['codigo']);
                        $this->objSe->set('nombre', $result[0]['nombre']);
                        $this->objSe->set('apellido', $result[0]['apellido']);
                        $this->objSe->set('apellidocasada', $result[0]['apellidocasada']);
                        $this->objSe->set('idRol', $result[0]['idRol']);
                        $this->objSe->set('rol', $result[0]['rol']);
                        header('Location: ../Vistas/Administrador/LayoutAdministrador.php');
                        break;
                }
            } else {
                header('Location: ../index.php?error=1');
            }
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

    public function ListaMedico() {
        try {
            $result = array();
            $stm = $this->cnn->prepare("CALL sp_GetMedicos();");
            $stm->execute();
            foreach ($stm->fetchAll(PDO::FETCH_OBJ) as $_medico) {
                $medico = new Medicos();
                $medico->setIdMedico($_medico->idMedico);
                $medico->setCodigo($_medico->codigo);
                $medico->setRol($_medico->Rol);
                $medico->setTipoidentificacion($_medico->tipoidentificacion);
                $medico->setIdentificacion($_medico->identificacion);
                $medico->setNombre($_medico->nombre);
                $medico->setApellido($_medico->apellido);
                $medico->setApellidocasada($_medico->apellidocasada);
                $medico->setGenero($_medico->genero);
                $medico->setFechanacimiento($_medico->fechanacimiento);
                $medico->setTiposangre($_medico->tiposangre);
                $medico->setTelefono($_medico->telefono);
                $medico->setCelular($_medico->celular);
                $medico->setEstadocivil($_medico->estadocivil);
                $medico->setOcupacion($_medico->ocupacion);
                $medico->setReligion($_medico->religion);
                $medico->setPais($_medico->pais);
                $medico->setDepartamento($_medico->departamento);
                $medico->setMunicipio($_medico->municipio);
                $medico->setDomicilio($_medico->domicilio);
                $medico->setEmail($_medico->email);
                $medico->setClave($_medico->clave);
                $medico->setFecharegistro($_medico->fecharegistro);
                $result[] = $medico;
            }
            return $result;
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

    public function RegistrarMedico(Medicos $medicos) {
        try {
            $sql = "CALL sp_RegisterMedicos (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
            $this->cnn->prepare($sql)->execute(array(
                $medicos->getCodigo('codigo'),
                $medicos->getTipoidentificacion('tipoidentificacion'),
                $medicos->getIdentificacion('identificacion'),
                $medicos->getNombre('nombre'),
                $medicos->getApellido('apellido'),
                $medicos->getApellidocasada('apellidocasada'),
                $medicos->getGenero('genero'),
                $medicos->getFechanacimiento('fechanacimiento'),
                $medicos->getTiposangre('tiposangre'),
                $medicos->getTelefono('telefono'),
                $medicos->getCelular('celular'),
                $medicos->getEstadocivil('estadocivil'),
                $medicos->getOcupacion('ocupacion'),
                $medicos->getReligion('religion'),
                $medicos->getPais('pais'),
                $medicos->getDepartamento('departamento'),
                $medicos->getMunicipio('municipio'),
                $medicos->getDomicilio('domicilio'),
                $medicos->getEmail('email'),
                $medicos->getClave('clave'),
                $medicos->getEstado('estado'))
            );
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

    public function ListaEspecialidad() {
        try {
            $result = array();
            $stm = $this->cnn->prepare("CALL sp_GetEspecialidad();");
            $stm->execute();
            foreach ($stm->fetchAll(PDO::FETCH_OBJ) as $_especialidad) {
                $especialidades = new Especialidades();
                $especialidades->setIdEspecialidades($_especialidad->idEspecialidades);
                $especialidades->setMedico($_especialidad->Medico);
                $especialidades->setEspecialidad($_especialidad->especialidad);
                $especialidades->setDetalleespecialidad($_especialidad->detalle);
                $result[] = $especialidades;
            }
            return $result;
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

    public function RegistrarEspecialidad(Especialidades $especialidades) {
         try {
            $sql = "CALL sp_RegisterEspecialidad (?, ?, ?);";
            $this->cnn->prepare($sql)->execute(array(
                $especialidades->getMedico('Medico'),
                $especialidades->getEspecialidad('especialidad'),
                $especialidades->getDetalleespecialidad('detalle'))
            );
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

}

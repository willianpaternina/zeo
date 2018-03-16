<?php
require_once $_SERVER['DOCUMENT_ROOT']."/Zeo/Dao/IAuxiliares.php";
require_once $_SERVER['DOCUMENT_ROOT']."/Zeo/Configuracion/Conexion.php";
require_once $_SERVER['DOCUMENT_ROOT']."/Zeo/Modelo/Sesion.php";
require_once $_SERVER['DOCUMENT_ROOT']."/Zeo/Modelo/Auxiliares.php";
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


   
            
/**
 * Description of AuxiliarControlador
 *
 * @author Willian
 */
class AuxiliarControlador extends Conexion implements IAuxiliares {
    
    public $objSe;
    public $result;
    
    public function __construct() {
        parent::ConexionMySQLServer();
        $this->objSe = new Sesion();
    }
    
    public function ActualizarInformacion(Auxiliares $auxiliares) {
        
    }
    public function RegistrarAuxiliar(Auxiliares $auxiliares){
        try {
            $sql = "CALL sp_RegistrarAuxiliar(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?); ";
            $this->cnn->prepare($sql)->execute(array(
                $auxiliares->getCodigo(),
                $auxiliares->getRol(),
                $auxiliares->getTipoidentificacion(),
                $auxiliares->getIdentificacion(),
                $auxiliares->getNombre(),
                $auxiliares->getApellido(),
                $auxiliares->getApellidocasada(),
                $auxiliares->getGenero(),
                $auxiliares->getFechanacimiento(),
                $auxiliares->getTiposangre(),
                $auxiliares->getTelefono(),
                $auxiliares->getCelular(),
                $auxiliares->getEstadocivil(),
                $auxiliares->getOcupacion(),
                $auxiliares->getReligion(),
                $auxiliares->getPais(),
                $auxiliares->getDepartamento(),
                $auxiliares->getMunicipio(),
                $auxiliares->getDomicilio(),
                $auxiliares->getEmail(),
                $auxiliares->getClave(),
                $auxiliares->getFecharegistro(),
                $auxiliares->getEstado()
            ));
            
        } catch (Exception $exc) {
            echo $exc->getMessage();
        } 
    }
    public function IniciarSesionAuxiliar() {
        try {
            $stm = $this->cnn->prepare("SELECT *
                                        FROM Auxiliares ax 
                                        INNER JOIN Roles r ON ax.Rol = r.idRol
                                        WHERE ax.identificacion = :identificacion AND ax.clave = :clave AND ax.Rol = :rol;");
            $stm->bindParam(':identificacion', $_POST["identificacion"]);
            $stm->bindParam(':clave', $_POST["clave"]);
            $stm->bindParam(':rol', $_POST["rol"]);
            $stm->execute();
            $result = $stm->fetchAll();
            if ($result) {
                $rol = $result[0]['rol'];
                switch ($rol) {
                    case 'AUXILIAR' :
                        $this->objSe->init();
                        $this->objSe->set('idAuxiliar', $result[0]['idAuxiliar']);
                        $this->objSe->set('codigo', $result[0]['codigo']);
                        $this->objSe->set('nombre', $result[0]['nombre']);
                        $this->objSe->set('apellido', $result[0]['apellido']);
                        $this->objSe->set('apellidocasada', $result[0]['apellidocasada']);
                        $this->objSe->set('idRol', $result[0]['idRol']);
                        $this->objSe->set('rol', $result[0]['rol']);
                        header('Location: ../Vistas/Auxiliar/LayoutAuxiliar.php');
                        break;
                }
            } else {
                header('Location: ../index.php?error=1');
            }
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

}

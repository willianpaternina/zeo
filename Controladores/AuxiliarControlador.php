<?php

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

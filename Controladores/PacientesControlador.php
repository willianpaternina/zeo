<?php

/**
 * Esta clase contiene los metodos para interacturar con las diferentes vistas
 *
 * @package    Controladores
 * @author     Willian Paternina <willian.paternina@unisinu.edu.co>
 * @copyright  2017-2018 Proyecto de grado para optar el titulo de ingeniero de sistemas
 * @version    1.0
 */
class PacientesControlador extends Conexion implements IPacientes {
    
    public $objSe;
    public $result;
    
    public function __construct() {
        parent::ConexionMySQLServer();
        $this->objSe = new Sesion();
    }


    public function IniciarSesionPaciente() {
        try {
            $stm = $this->cnn->prepare("SELECT *
                                        FROM Pacientes p 
                                        INNER JOIN Roles r ON p.Rol = r.idRol
                                        WHERE p.identificacion = :identificacion AND p.clave = :clave AND p.Rol = :rol;");
            $stm->bindParam(':identificacion', $_POST["identificacion"]);
            $stm->bindParam(':clave', $_POST["clave"]);
            $stm->bindParam(':rol', $_POST["rol"]);
            $stm->execute();
            $result = $stm->fetchAll();
            if ($result) {
                $rol = $result[0]['rol'];
                switch ($rol) {
                     case 'PACIENTE' :
                         $this->objSe->init();
                         $this->objSe->set('idPaciente', $result[0]['idPaciente']);
                         $this->objSe->set('codigo', $result[0]['codigo']);
                         $this->objSe->set('nombre', $result[0]['nombre']);
                         $this->objSe->set('apellido', $result[0]['apellido']);
                         $this->objSe->set('apellidocasada', $result[0]['apellidocasada']);
                         $this->objSe->set('idRol', $result[0]['idRol']);
                         $this->objSe->set('rol', $result[0]['rol']);
                         header('Location: ../Vistas/Paciente/LayoutPaciente.php'); 
                     break;
                }
            }else {
                header('Location: ../index.php?error=1');
            }
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }


}

?>

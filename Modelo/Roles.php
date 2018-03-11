<?php
/**
 * Esta clase modela la tabla roles de la base de datos
 *
 * @package    Modelo
 * @author     Willian Paternina <willian.paternina@unisinu.edu.co>
 * @copyright  2017-2018 Proyecto de grado para optar el titulo de ingeniero de sistemas
 * @version    1.0
 */
class Roles {
    
    private $idRol;
    private $rol;
    private $detalle;
    
    public function __Roles ($idRol, $rol, $detalle) {
        $this->idRol = $idRol;
        $this->rol = $rol;
        $this->detalle = $detalle;
    }
            
    function getIdRol() {
        return $this->idRol;
    }

    function getRol() {
        return $this->rol;
    }

    function getDetalle() {
        return $this->detalle;
    }

    function setIdRol($idRol) {
        $this->idRol = $idRol;
    }

    function setRol($rol) {
        $this->rol = $rol;
    }

    function setDetalle($detalle) {
        $this->detalle = $detalle;
    }
}

?>

<?php

/**
 * Esta clase modela la tabla especialidades de la base de datos
 *
 * @package    Modelo
 * @author     Willian Paternina <willian.paternina@unisinu.edu.co>
 * @copyright  2017-2018 Proyecto de grado para optar el titulo de ingeniero de sistemas
 * @version    1.0
 */
class Especialidades {
    
    private $idEspecialidades;
    private $Medico;
    private $especialidad;
    private $detalleespecialidad;
    
    function __construct($idEspecialidades, $Medico, $especialidad, $detalleespecialidad) {
        $this->idEspecialidades = $idEspecialidades;
        $this->Medico = $Medico;
        $this->especialidad = $especialidad;
        $this->detalleespecialidad = $detalleespecialidad;
    }
    function getIdEspecialidades() {
        return $this->idEspecialidades;
    }

    function getMedico() {
        return $this->Medico;
    }

    function getEspecialidad() {
        return $this->especialidad;
    }

    function getDetalleespecialidad() {
        return $this->detalleespecialidad;
    }

    function setIdEspecialidades($idEspecialidades) {
        $this->idEspecialidades = $idEspecialidades;
    }

    function setMedico($Medico) {
        $this->Medico = $Medico;
    }

    function setEspecialidad($especialidad) {
        $this->especialidad = $especialidad;
    }

    function setDetalleespecialidad($detalleespecialidad) {
        $this->detalleespecialidad = $detalleespecialidad;
    }



}

?>
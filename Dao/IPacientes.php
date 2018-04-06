<?php
/**
 * Esta interface contiene los metodos de PacientesControlador.php
 *
 * @package    Dao
 * @author     Willian Paternina <willian.paternina@unisinu.edu.co>
 * @copyright  2017-2018 Proyecto de grado para optar el titulo de ingeniero de sistemas
 * @version    1.0
 */
interface IPacientes {
    
     public function IniciarSesionPaciente();
     public function listarCitas($idPaciente, $estado);
     public function actualizarEstadoCita($idCita, $estado);
     public function listarActividades($Paciente);
}
?>

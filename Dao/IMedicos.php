<?php
/**
 * Esta interface contiene los metodos de MedicosControlador.php
 *
 * @package    Dao
 * @author     Willian Paternina <willian.paternina@unisinu.edu.co>
 * @copyright  2017-2018 Proyecto de grado para optar el titulo de ingeniero de sistemas
 * @version    1.0
 */
interface IMedicos {
    
     public function IniciarSesionMedico();
     public function ActualizarInformacion(Medicos $medicos);
     public function ListaPaciente();
     public function RegistrarPaciente(Pacientes $pacientes);
     public function listarMedicos($estado = 1);
     public function horarioMedico($Medico, $Especialidad);
     public function registrarCita($id_paciente, $id_horario, $concepto, $estado);
     public function horarioCitaPaciente($id_medico);
     public function medicosEspecialidades($id_medico);
     public function registrarEspecialidad(Especialidades $Especialidad);
     public function actualizarEspecialidad(Especialidades $Especialidad);
     public function listarAuxiliarMedico($id_medico);
     public function registrarAuxiliarMedico(Auxiliares $auxiliares);
}

?>

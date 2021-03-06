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
     public function listarAuxiliaresPorId($id_auxiliar);
     public function actualizarAuxiliarMedico(Auxiliares $auxiliares);
     public function listarHorarioMedicoPorId($id_medico);
     public function listarConsultorios();
     public function actualizarEstado($idCita, $estado);
     public function listarCitaEstado($id_medico, $estado);
     public function medicoRegistrarActividad($datos);
     public function consultarActividadesEtapa($idPaciente);
     public function medicoRegistrarMedicamento($datos);
     public function listarMedicamentoPaciente($idPaciente);
     public function listarEspecialidadMedico($idMedico);
     public function registrarHorario($datos);
     
     
}

?>

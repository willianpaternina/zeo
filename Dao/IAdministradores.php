<?php
/**
 * Esta interface contiene los metodos de AdministradoresControlador.php
 *
 * @package    Dao
 * @author     Willian Paternina <willian.paternina@unisinu.edu.co>
 * @copyright  2017-2018 Proyecto de grado para optar el titulo de ingeniero de sistemas
 * @version    1.0
 */
interface IAdministradores {
   
     public function IniciarSesionAdministrador();
     public function ActualizarInformacion(Administradores $administradores);
     public function ListaMedico();
     public function ListaEspecialidad();
     public function RegistrarMedico(Medicos $medicos);
     public function RegistrarEspecialidad(Especialidades $especialidades);
}

?>

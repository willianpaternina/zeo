<?php
/**
 * Esta interface contiene los metodos de AuxiliarControlador.php
 *
 * @package    Dao
 * @author     Willian Paternina <willian.paternina@unisinu.edu.co>
 * @copyright  2017-2018 Proyecto de grado para optar el titulo de ingeniero de sistemas
 * @version    1.0
 */
interface IAuxiliares {
    
     public function IniciarSesionAuxiliar();
     public function ActualizarInformacion(Auxiliares $auxiliares);
     public function RegistrarAuxiliar(Auxiliares $auxiliares);
}

?>

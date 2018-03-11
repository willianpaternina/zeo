<?php
/**
 * Este archivo comprueba que la conexion esta correcta
 *
 * @package    Configuracion
 * @author     Willian Paternina <willian.paternina@unisinu.edu.co>
 * @copyright  2017-2018 Proyecto de grado para optar el titulo de ingeniero de sistemas
 * @version    1.0
 */
    include_once 'Conexion.php';
    $con = new Conexion();
    $con->ConexionMySQLServer();
?>


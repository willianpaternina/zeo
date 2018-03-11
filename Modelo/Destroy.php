<?php
/**
 * Esta clase destruye todas las variables de sesion
 *
 * @package    Modelo
 * @author     Willian Paternina <willian.paternina@unisinu.edu.co>
 * @copyright  2017-2018 Proyecto de grado para optar el titulo de ingeniero de sistemas
 * @version    1.0
 */
class Destroy {

    public function __construct() { }

    public function init() {
        @session_start();
    }

    public function destroy() {
        session_unset();
        session_destroy();
    }

}

?>
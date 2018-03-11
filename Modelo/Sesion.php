<?php
/**
 * Esta clase contienen todas las variables de sesion como objeto
 *
 * @package    Modelo
 * @author     Willian Paternina <willian.paternina@unisinu.edu.co>
 * @copyright  2017-2018 Proyecto de grado para optar el titulo de ingeniero de sistemas
 * @version    1.0
 */
class Sesion {
    
     public function __construct() { }

     public function init() {
         @session_start();
     }

     public function set($varname, $value) {
         $_SESSION[$varname] = $value;
     }

     public function get($varname) {
         return $_SESSION[$varname];
     }
}

?>

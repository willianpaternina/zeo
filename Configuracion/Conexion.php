<?php

/**
 * Esta clase me conecta con la base de datos
 *
 * @package    Configuracion
 * @author     Willian Paternina <willian.paternina@unisinu.edu.co>
 * @copyright  2017-2018 Proyecto de grado para optar el titulo de ingeniero de sistemas
 * @version    1.0
 */
include_once 'cfg.php';
class Conexion extends PDO {

    protected $cnn;

    public function ConexionMySQLServer() {
        try {
            $this->cnn = new PDO(SERVER, USERNAME, PASSWORD);
            $this->cnn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }
}

?>

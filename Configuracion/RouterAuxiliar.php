<?php

/**
 * Description of RouterAuxiliar
 *
 * @author Willian
 */
class RouterAuxiliar {

    public function LoadView($view) {
        switch ($view) :
            case 'inicio':
                include_once ('../../Vistas/Auxiliar/' . $view . '.php');
                break;
            case 'logout':
                include_once ('../../Vistas/Auxiliar/' . $view . '.php');
                break;
            default:
                include_once ('../../Vistas/Auxiliar/error.php');
        endswitch;
    }

    public function validateURL($variable) {
        if (empty($variable)) {
            include_once('../../Vistas/Auxiliar/inicio.php');
        } else {
            return true;
        }
    }

}

?>
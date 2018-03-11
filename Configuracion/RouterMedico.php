<?php

/**
 * Description of RouterPaciente
 *
 * @author Willian
 */
class RouterMedico {

    public function LoadView($view) {
        switch ($view) :
            case 'inicio':
                include_once ('../../Vistas/Medico/' . $view . '.php');
                break;
            case 'pacientes':
                include_once ('../../Vistas/Medico/' . $view . '.php');
                break;
            case 'regpaciente':
                include_once ('../../Vistas/Medico/' . $view . '.php');
                break;
            case 'logout':
                include_once ('../../Vistas/Medico/' . $view . '.php');
                break;
            default:
                include_once ('../../Vistas/Medico/error.php');
        endswitch;
    }

    public function validateURL($variable) {
        if (empty($variable)) {
            include_once('../../Vistas/Medico/inicio.php');
        } else {
            return true;
        }
    }

}

?>

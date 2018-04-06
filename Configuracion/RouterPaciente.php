<?php

/**
 * Description of RouterPaciente
 *
 * @author Willian
 */
class RouterPaciente {

    public function LoadView($view) {
        switch ($view) :
            case 'inicio':
                include_once ('../../Vistas/Paciente/' . $view . '.php');
                break;
            case 'logout':
                include_once ('../../Vistas/Paciente/' . $view . '.php');
                break;
            case 'cita':
                include_once ('../../Vistas/Paciente/' . $view . '.php');
                break;
            case 'citasactivas':
                include_once ('../../Vistas/Paciente/' . $view . '.php');
                break;
            case 'citasrealizadas':
                include_once ('../../Vistas/Paciente/' . $view . '.php');
                break;
            
            default:
                include_once ('../../Vistas/Paciente/error.php');
        endswitch;
    }

    public function validateURL($variable) {
        if (empty($variable)) {
            include_once('../../Vistas/Paciente/inicio.php');
        } else {
            return true;
        }
    }

}

?>

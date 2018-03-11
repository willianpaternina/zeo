<?php

/**
 * Description of RouterPaciente
 *
 * @author Willian
 */
class RouterAdministrador {

    public function LoadView($view) {
        switch ($view) :
            case 'inicio':
                include_once ('../../Vistas/Administrador/' . $view . '.php');
                break;
            case 'logout':
                include_once ('../../Vistas/Administrador/' . $view . '.php');
                break;
            case 'medicos':
                include_once ('../../Vistas/Administrador/' . $view . '.php');
            break;
            case 'regmedico':
                include_once ('../../Vistas/Administrador/' . $view . '.php');
            break;
            case 'especialidades':
                include_once ('../../Vistas/Administrador/' . $view . '.php');
            break;
            case 'regespecialidad':
                include_once ('../../Vistas/Administrador/' . $view . '.php');
            break;
            default:
                include_once ('../../Vistas/Administrador/error.php');
        endswitch;
    }

    public function validateURL($variable) {
        if (empty($variable)) {
            include_once('../../Vistas/Administrador/inicio.php');
        } else {
            return true;
        }
    }

}

?>

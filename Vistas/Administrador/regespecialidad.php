<?php
     include_once '../../Configuracion/Conexion.php';
     
     include_once '../../Modelo/Roles.php';
     include_once '../../Dao/IRoles.php';
     
     include_once '../../Modelo/Medicos.php';
     include_once '../../Modelo/Especialidades.php';
     include_once '../../Dao/IAdministradores.php';
     include_once '../../Controladores/AdministradorControlador.php';
     
     $modelespecialdad = new Especialidades();
     $controladministrador = new AdministradorControlador();
     
     if (isset($_POST['btnguardarespecialidad'])) { 
         $modelespecialdad->setMedico($_REQUEST['txtmedico']);
         $modelespecialdad->setEspecialidad($_REQUEST['txtespecialidad']);
         $modelespecialdad->setDetalleespecialidad($_REQUEST['txtdetalleespecialidad']);
         $controladministrador->RegistrarEspecialidad($modelespecialdad);
         echo '<script type="text/javascript">window.location.replace("LayoutAdministrador.php?load=medicos");</script>';
         exit;
     }
?>
<div class="ui segments">
    <div class="ui blue inverted segment">
        <h3>ASIGNACIÓN DE ESPECIALIDAD</h3>
    </div>
    <div class="ui secondary segment">
        <form class="ui form" method="POST">
            <div class="three fields">
                <div class="field">
                    <select id="txtzona" name="txtmedico" class="ui multiple dropdown selection" required="true">
                        <option value="">MEDICOS...</option>
                        <?php foreach ($controladministrador->ListaMedico() AS $_combomedico) : ?>
                        <option value="<?php echo $_combomedico->getIdMedico('idMedico'); ?>"><?php echo $_combomedico->getNombre('nombre') . ' ' . $_combomedico->getApellido('apellido'); ?></option> 
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="field">
                    <div class="ui selection dropdown">
                        <input type="hidden" name="txtespecialidad">
                        <i class="dropdown icon"></i>
                        <div class="default text">Especialidad</div>
                        <div class="menu">
                            <div class="item" data-value="ANESTESIOLOGÍA">ONCOLOGÍA DE LA RADIACIÓN</div>
                            <div class="item" data-value="ATENCIÓN PRIMARIA">ONCOLOGÍA QUIRÚRGICA</div>
                            <div class="item" data-value="CARDIOLOGÍA">ONCOLOGÍA MEDICA</div>
                            <div class="item" data-value="CIENCIAS DE LA ACTIVIDAD FÍSICA">ONCOLOGÍA INTERVENTIONAL</div>
                            <div class="item" data-value="CIENCIAS DE LA ACTIVIDAD FÍSICA">ONCOLOGÍA GINECOLÓGICA</div>
                            <div class="item" data-value="CIRUGÍA GENERAL">ONCOLOGÍA PEDIÁTRICA</div>
                        </div>
                    </div>
                </div>
                <div class="field">
                    <input type="text" name="txtdetalleespecialidad" placeholder="Detalle especialidad" size="200">
                </div>
                <input type="submit" name="btnguardarespecialidad" class="ui green button" value="Guardar">
            <button name="btncancelarmedico" class="ui red button" OnClick="location.href = 'LayoutAdministrador.php?load=medicos'">Cancelar</button>
            </div>
        </form>
    </div>
</div>
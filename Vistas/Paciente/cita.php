<?php
    require_once $_SERVER['DOCUMENT_ROOT']."/Zeo/Controladores/MedicosControlador.php";
    //print_r($_SESSION);
    $medicos = new MedicosControlador();
    $listaMedicos = $medicos->listarMedicos();
?>
<div class="ui segments">
    <div class="ui blue inverted segment">
        <h4>MÓDULO DE CITAS MEDICAS</h4>
    </div>
    <div class="ui secondary segment">
        <div class="ui segments">
            <div class="ui blue inverted segment">
                <p>MEDICOS DISPONIBLES</p>
            </div>
            <div class="ui secondary segment">
                <button class="ui blue button abrir_modal" ><i class="fa fa-arrow-left"></i> modal</button>
                <?php for($i=0;$i<sizeof($listaMedicos);$i++) : ?>
                <div class="ui raised segment botoneraexcelpdfpaciente medicos">
                    <table class="ui celled table" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>CODIGO</th>
                                <th>PACIENTE</th>
                                <th>EMAIL</th>
                                <th>ESPECIALIDAD</th>
                                <th>CITAS</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><?php echo $listaMedicos[$i]["codigo"] ?></td>
                                <td><?php echo $listaMedicos[$i]["nombre"]." ".$listaMedicos[$i]["apellido"] ?></td>
                                <td><?php echo $listaMedicos[$i]["email"] ?></td>
                                <td><?php echo $listaMedicos[$i]["especialidad"] ?></td>
                                <td>
                                    <button class="ui blue button" id="btnhorario" value="<?php echo $_SESSION["idPaciente"] ?>" onClick="horario(<?php echo $listaMedicos[$i]["idMedico"] ?>, <?php echo $listaMedicos[$i]["idEspecialidades"] ?>)"><i class="fa fa-calendar"></i> Horario</button>
                                </td>
                            <tr>
                        </tbody>
                    </table>
                            
                </div>
                <?php endfor ?>
                <div class="ui raised segment botoneraexcelpdfpaciente horario" style="display: none">
                    
                    <button class="ui blue button" id="back"><i class="fa fa-arrow-left"></i> Regresar</button>
                    <h1>Horario del medico: </h1>
                    <div id='calendar'></div>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- VENTANA MODAL PARA TOMAR LA CITA -->
<!-- modal ver detalle del paciente-->
<div class="ui fullscreen modal confirmar_cita">
    
    <i class="close icon"></i>
    <div class="header">
        <h4>CONFIRMACIÓN CITA MEDICA</h4>
    </div>
    <div class="content">
        <table class="ui celled table" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <th>
                        <div class="ui fluid input focus">
                            <input type="text" placeholder="Ingresar motivo de la cita medica" id="motivoCitaMedida">
                        </div>
                    </th>
                </tr>
            </thead>
        </table>
    </div>
    <div class="actions">
        <button class="ui green button" id="_btnGuardarCita"><i class="fa fa-edit"></i> Guardar cita</button>
    </div>
</div>
<!-- fin modal ver detalle del paciente-->
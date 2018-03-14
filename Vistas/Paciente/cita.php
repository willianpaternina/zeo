<?php
     require_once $_SERVER['DOCUMENT_ROOT']."/Zeo/Controladores/MedicosControlador.php";
     
     $medicos = new MedicosControlador();
     $listaMedicos = $medicos->listarMedicos();
     //print_r($listaMedicos);exit;
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
                <?php for($i=0;$i<sizeof($listaMedicos);$i++) : ?>
                <div class="ui raised segment botoneraexcelpdfpaciente medicos">
                    <table class="ui celled table" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                 <th><?php echo $listaMedicos[$i]["codigo"] ?></th>
                                <th><?php echo $listaMedicos[$i]["nombre"]." ".$listaMedicos[$i]["apellido"] ?></th>
                                <th><?php echo $listaMedicos[$i]["email"] ?></th>
                                <th><button class="btn btn-info" onclick="horario(<?php echo $listaMedicos[$i]["idMedico"] ?>)">Horario</button></th>
                            </tr>
                        </thead>
                    </table>
                            
                </div>
                <?php endfor ?>
                <div class="ui raised segment botoneraexcelpdfpaciente horario" style="display: none">
                    <p><a href="javascript:void(0)" id="back">Regresar</a></p>
                    <h1>Horario del medico: </h1>
                    <div id='calendar'></div>
                </div>
            </div>
        </div>
    </div>
</div>

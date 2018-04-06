<div class="ui segments">
    <div class="ui blue inverted segment">
        <h4>MÓDULO DE CITAS MEDICAS</h4>
    </div>
    <div class="ui secondary segment">
        <div class="ui segments">
            <div class="ui blue inverted segment">
                <p>CITAS PROGRAMADAS</p>
            </div>
            <div class="ui secondary segment">
                <div class="ui raised segment botoneraexcelpdfpaciente horario" >
                    <div id='calendar'></div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- VENTANA MODAL PARA CAMBIAR ESTADO CITA -->
<div class="ui fullscreen modal cambiarEstado">
    
    <i class="close icon"></i>
    <div class="header">
        <h4>CAMBAIR ESTADO CITA MEDICA: <span id="nombrePaciente"></span></h4>
    </div>
    <div class="content">
        <table class="ui celled table" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <th>
                        <div class="ui fluid">
                            <select id="estado" class="ui fluid dropdown">
                                <option value="ATENDIDO">ATENDIDO</option>
                                <option value="REPROGRAMADO">REPROGRAMADO</option>
                            </select>
                        </div>
                    </th>
                </tr>
            </thead>
        </table>
    </div>
    <div class="actions">
        <button class="ui green button" id="_btnActualizarEstado"><i class="fa fa-edit"></i> Actualizar estado</button>
    </div>
</div>
<!-- VENTANA MODAL PARA CAMBIAR ESTADO CITA-->
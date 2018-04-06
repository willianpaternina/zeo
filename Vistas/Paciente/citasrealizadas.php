<div class="ui segments">
    <div class="ui blue inverted segment">
        <h4>MÓDULO DE CITAS ACTIVAS</h4>
    </div>
    <div class="ui secondary segment">
        <div class="ui segments">
            <div class="ui blue inverted segment">
                <p>GESTION DE CITAS</p>
            </div>
            <div class="ui secondary segment">
                    <div class="ui raised segment botoneraexcelpdfespecialidad ">
                        <table id="tblCitasRealizadas" class="ui selectable blue celled table " cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Concepto</th>
                                    <th>Estado</th>
                                    <th>Especialidad</th>
                                    <th>Fecha</th>
                                    <th>Hora</th>
                                    <th></th>
                                </tr>
                            </thead>
                        </table>

                    </div>
                
                    <div class="ui raised segment botoneraexcelpdfpaciente horario" style="display: none">

                        <button class="ui blue button" id="back"><i class="fa fa-arrow-left"></i> Regresar</button>
                        <h1>Horario del medico: </h1>
                        <div id='calendar'></div>
                    </div>
            </div>
        </div>
    </div>
</div>


<!-- VENTANA MODAL PARA REGISTRAR ESPECIALIDAD -->
<div class="ui fullscreen modal verActividades">
    <i class="close icon"></i>
    <div class="header">
        <h4>VER ACTIVIDADES</h4>
    </div>
    <div class="content">
        <table id="tblActividadesPacientes" class="ui selectable blue celled table " cellspacing="0" width="100%">
            <thead>
                <tr>
                    <th>Etapa tumo</th>
                    <th>Concepto</th>
                    <th>Estado</th>
                    <th>Fecha Registro</th>
                    <th>Numero Hora</th>
                    <th>Hora Dia</th>
                </tr>
            </thead>
        </table>
        
    </div>
    <div class="actions">
        
    </div>
</div>

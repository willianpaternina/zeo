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
<div class="ui mini modal addEspecialidad">
    <i class="close icon"></i>
    <div class="header">
        <h4>REGISTRAR ESPECIALIDAD</h4>
    </div>
    <div class="content">
        <div class="ui tertiary inverted red segment" style="display: none" id="mensaje_error">
            <p>La especialidad ya se encuentra registrada</p>
        </div>
        <div class="ui tertiary inverted green segment" style="display: none" id="mensajedeexito">
            <p>La especialidad se guardó con exito</p>
        </div>
        <form class="ui form especialidad">
            <div class="field">
              <label>Especialidad</label>
              <input type="text" id="nombreEspecialidad" name="nombreEspecialidad" placeholder="Nombre Especialidad">
            </div>
            <div class="field">
            <label>Detalle especialidad</label>
            <textarea rows="2" id="detalleEspecialidad" name="detalleEspecialidad" placeholder="Detalle de la especialidad"></textarea>
            </div>
            <button class="ui blue button" type="submit">Guardar especialidad</button>
            <div class="ui error message"></div>
          </form>
        
    </div>
    <div class="actions">
        
    </div>
</div>

<?php
    require_once $_SERVER['DOCUMENT_ROOT']."/Zeo/Controladores/MedicosControlador.php";

?>
<div class="ui segments">
    <div class="ui blue inverted segment">
        <h4>MÓDULO DE ESPECIALIDAD</h4>
    </div>
    <div class="ui secondary segment">
        <div class="ui segments">
            <div class="ui blue inverted segment">
                <p>GESTION DE ESPECIALIDADES</p>
            </div>
            <div class="ui secondary segment">
                    <div class="ui raised segment botoneraexcelpdfespecialidad ">
                        <table id="tblHorario" class="ui selectable blue celled table " cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Consultorio</th>
                                    <th>Especialidad</th>
                                    <th>Fecha</th>
                                    <th>Hora inicio</th>
                                    <th>Hora fin</th>
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
<div class="ui mini modal addHorario">
    <i class="close icon"></i>
    <div class="header">
        <h4>REGISTRAR HORARIO</h4>
    </div>
    <div class="content">
        <form class="ui form especialidad">
            <div class="field">
              <label>Consultorio</label>
              <select id="select_consultorio"></select>
            </div>
            <div class="field">
              <label>Especialidad</label>
              <select id="select_especialidad"></select>
            </div>
            <div class="field">
              <label>Fecha</label>
              <input type="text" id="upd_nombreEspecialidad" name="fecha" placeholder="Fecha atencion">
            </div>
            <div class="field">
              <label>Hora inicio</label>
              <input type="text" id="upd_nombreEspecialidad" name="upd_nombreEspecialidad" placeholder="Hora inicio fin">
            </div>
            <div class="field">
              <label>Hora fin</label>
              <input type="text" id="upd_nombreEspecialidad" name="upd_nombreEspecialidad" placeholder="Hora final atencion">
            </div>
            <button class="ui blue button" type="submit">Guardar horario</button>
            <div class="ui error message"></div>
          </form>
        
    </div>
    <div class="actions">
        
    </div>
</div>
<!-- fin modal ver detalle del paciente-->

<!-- VENTANA MODAL PARA ACTUALIZAR ESPECIALIDAD -->
<div class="ui mini modal updHorario">
    <i class="close icon"></i>
    <div class="header">
        <h4>ACTUALIZAR ESPECIALIDAD</h4>
    </div>
    <div class="content">
        <div class="ui tertiary inverted red segment" style="display: none" id="updmensaje_error">
            <p>No se pudo actualizar la especialidad</p>
        </div>
        <div class="ui tertiary inverted green segment" style="display: none" id="updmensajedeexito">
            <p>La especialidad se actualizó con exito</p>
        </div>
        <form class="ui form upd_especialidad">
            <div class="field">
              <label>Especialidad</label>
              <input type="text" id="upd_nombreEspecialidad" readonly="" name="upd_nombreEspecialidad" placeholder="Nombre Especialidad">
            </div>
            <div class="field">
            <label>Detalle especialidad</label>
            <input type="hidden" id="upd_idEspecialidad"  />
            <textarea rows="2" id="upd_detalleEspecialidad" name="upd_detalleEspecialidad" placeholder="Detalle de la especialidad"></textarea>
            </div>
            <button class="ui green button" type="submit">Actualizar especialidad</button>
            <div class="ui error message"></div>
          </form>
        
    </div>
    <div class="actions">
        
    </div>
</div>
<!-- fin modal ver detalle del paciente-->
<div class="ui segments">
    <div class="ui blue inverted segment">
        <h4>MÓDULO DE GESTION DE ACTIVIDADES Y MEDICAMENTOS</h4>
    </div>
    <div class="ui secondary segment">
        <div class="ui segments">
            <div class="ui blue inverted segment">
                <p>GESTION DE ACTIVIDADES Y MEDICAMENTOS A PACIENTES</p>
            </div>
            <div class="ui secondary segment">
                <button type="button" id="nuevopaciente" class="ui button teal " ><i class="fa fa-plus-square"></i></button>
                    <div class="ui raised segment botoneraexcelpdfauxiliares ">
                        <table id="tblActividadesMedicamento" class="ui selectable blue celled table botonesAuxiliar " cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                     <th>#</th>
                                     <th>Paciente</th>
                                     <th>Fecha atencion</th>
                                     <th>Estado</th>
                                     <th></th>
                                </tr>
                            </thead>
                        </table>
                    </div>
            </div>
        </div>
    </div>
</div>


<!-- VENTANA MODAL PARA REGISTRAR ACTIVIDADES -->
<div class="ui fullscreen modal addActividad">
    <i class="close icon"></i>
    <div class="header">
        <h4>REGISTRAR ACTIVIDAD</h4>
    </div>
    <div class="content">
        <form class="ui form frmAddActividad" id="frmActividad">
            <div class="fields">
                <div class="five wide field">
                    <label>Estapa tumor</label>
                    <input type="number" placeholder="Etapa tumor" id="etapaTumor" name="etapaTumor">
                </div>
                <div class="five wide field">
                    <label>Concepto</label>
                    <input type="text" placeholder="Concepto" name="concepto" id="concepto">
                </div>
                <div class="five wide field">
                    <label>Estado</label>
                    <input type="text" placeholder="Estado" name="estado" id="estado">
                </div>
            </div>
            <div class="fields">
                <div class="five wide field">
                    <label># Horas</label>
                    <input type="number" placeholder="Numero de horas" name="numHoras" id="numHoras">
                </div>
                <div class="five wide field">
                    <label># Dias</label>
                    <input type="text" placeholder="Numero de dias" name="numDias" id="numDias">
                </div>
            </div>
            <input type="hidden" id="idPaciente" />
            <button class="ui blue button" type="submit">Guardar actividad</button>
            <div class="ui error message"></div>
        </form>
        
    </div>
    <div class="actions">
        
    </div>
</div>
<!-- FIN MODAL REGISTRAR ACTIVIDADES-->

<!-- VENTANA MODAL PARA VER ACTIVIDADES -->
<div class="ui fullscreen modal verActividad">
    <i class="close icon"></i>
    <div class="header">
        <h4>CONSULTA DE ACTIVIDADES</h4>
    </div>
    <div class="content">
        <table id="tblVerActividadesPaciente" class="ui selectable blue celled table botonesAuxiliar " cellspacing="0" width="100%">
            <thead>
                <tr>
                     <th>Etapa Tumor</th>
                     <th>Concepto</th>
                     <th>Estado</th>
                     <th>Fecha registro</th>
                     <th>Numero hora</th>
                     <th>Numero dia</th>
                     <th></th>
                </tr>
            </thead>
        </table>
        
    </div>
    <div class="actions">
        
    </div>
</div>
<!-- FIN VENTANA MODAL PARA VER ACTIVIDADES -->


<!-- VENTANA MODAL PARA AGREGAR MEDICAMENTOS -->
<div class="ui fullscreen modal addMedicamentos">
    <i class="close icon"></i>
    <div class="header">
        <h4>AGREGAR MEDICAMENTOS</h4> 
    </div>
    <div class="content">
        <form class="ui form frmAddMedicamento" id="frmMedicamento">
            <div class="fields">
                <div class="five wide field">
                    <label>Medicamentos</label>
                    <input type="number" placeholder="Etapa tumor" id="medicamentos" name="medicamentos">
                </div>
                <div class="five wide field">
                    <label>Etapa tumor</label>
                    <input type="number" placeholder="Estado" name="etapa" id="etapa">
                </div>
                <div class="five wide field">
                    <label>Concepto</label>
                    <input type="text" placeholder="Concepto" name="conceptoMed" id="conceptoMed">
                </div>              

            </div>
            <div class="fields">
                <div class="five wide field">
                    <label># Horas</label>
                    <input type="number" placeholder="Numero de horas" name="medNumHoras" id="medNumHoras">
                </div>
                <div class="five wide field">
                    <label># Dias</label>
                    <input type="text" placeholder="Numero de dias" name="medNumDias" id="medNumDias">
                </div>
            </div>
            <input type="hidden" id="idPacienteMed" />
            <button class="ui blue button" type="submit">GUARDAR MEDICAMENTO</button>
            <div class="ui error message"></div>
        </form>
        
    </div>
    <div class="actions">
        
    </div>
</div>
<!-- FIN MODAL ACTUALIZAR USUARIOS-->

<!-- VENTANA MODAL PARA VER MEDICAMENTOS -->
<div class="ui fullscreen modal _verMedicamentos">
    <i class="close icon"></i>
    <div class="header">
        <h4>CONSULTA DE MEDICAMENTOS</h4>
    </div>
    <div class="content">
        <table id="tblVerMedicamentosPaciente" class="ui selectable blue celled table botonesAuxiliar " cellspacing="0" width="100%">
            <thead>
                <tr>
                     <th>Etapa Tumor</th>
                     <th>Concepto</th>
                     <th>Estado</th>
                     <th>Fecha registro</th>
                     <th>Numero hora</th>
                     <th>Numero dia</th>
                     <th></th>
                </tr>
            </thead>
        </table>
        
    </div>
    <div class="actions">
        
    </div>
</div>
<!-- FIN VENTANA MODAL PARA VER MEDICAMENTOS -->


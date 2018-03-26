<?php
    require_once $_SERVER['DOCUMENT_ROOT']."/Zeo/Controladores/MedicosControlador.php";
    //print_r($_SESSION);
    $medicos = new MedicosControlador();
    $listaMedicos = $medicos->listarMedicos();
?>
<div class="ui segments">
    <div class="ui blue inverted segment">
        <h4>MÓDULO DE AUXILIARES</h4>
    </div>
    <div class="ui secondary segment">
        <div class="ui segments">
            <div class="ui blue inverted segment">
                <p>GESTION DE AUXILIARES</p>
            </div>
            <div class="ui secondary segment">
                        
                <button type="button" id="nuevopaciente" class="ui button teal " ><i class="fa fa-plus-square"></i></button>
                    <div class="ui raised segment botoneraexcelpdfauxiliares ">
                        <table id="tblAuxiliares" class="ui selectable blue celled table botonesAuxiliar " cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                     <th>Fecha Nacimiento</th>
                                     <th>Identificación</th>
                                     <th>Nombre</th>
                                     <th>Apellido</th>
                                     <th>Sangre</th>
                                     <th>Telefono</th>
                                     <th>Celular</th>
                                     <th>Operaciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Fecha Nacimiento</td>
                                    <td>Identificación</td>
                                    <td>Nombre</td>
                                    <td>Apellido</td>
                                    <td>Sangre</td>
                                    <td>Telefono</td>
                                    <td>Celular</td>
                                    <td>Operaciones</td>
                                </tr>
                            </tbody>
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


<!-- VENTANA MODAL PARA REGISTRAR AUXILIARES -->
<div class="ui fullscreen modal addAuxiliar">
    <i class="close icon"></i>
    <div class="header">
        <h4>REGISTRAR AUXILIAR</h4>
    </div>
    <div class="content">
        <form class="ui form auxiliar" id="frmAuxiliar">
            <div class="fields">
                <div class="two wide field">
                    <label>Tipo Identificación</label>
                    <select name="tident">
                      <option value="">SELECCIONE</option>
                      <option value="TI">TI</option>
                      <option value="CC">CC</option>
                      <option value="RC">RC</option>
                    </select>
                </div>
                <div class="three wide field">
                    <label># Identificación</label>
                    <input type="number" name="identificacion" placeholder="Num identificacion">
                </div>
                <div class=" four wide field">
                    <label>Nombre</label>
                    <input type="text" name="nombre" placeholder="Nombres">
                </div>
                <div class="four wide field">
                    <label>Apellido</label>
                    <input type="text" name="apellido" placeholder="Apellidos">
                </div>
                <div class="three wide field">
                    <label>Apellido casado</label>
                    <input type="text" placeholder="Apellido casado">
                </div>
            </div>
            <div class="fields">
                <div class="one wide field">
                    <label>Genero</label>
                    <select name="genero">
                      <option value="">SELECCIONE</option>
                      <option value="M">M</option>
                      <option value="F">F</option>
                    </select>
                </div>
                <div class="two wide field calendar" id="fechanac">
                    <label>Fecha Nac</label>
                    <input type="text" name="fechanac" placeholder="Fecha nacimiento">
                </div>
                <div class="two wide field">
                    <label>Tipo Sangre</label>
                    <select name="tiposangre">
                      <option value="">SELECCIONE</option>
                      <option value="A+">A+</option>
                      <option value="B+">B+</option>
                    </select>
                </div>
                <div class="two wide field">
                    <label>Telefono</label>
                    <input type="text" name="telefono" placeholder="Telefono">
                </div>
                <div class="two wide field">
                    <label>Celular</label>
                    <input type="text" name="celular" placeholder="# Celular">
                </div>
                <div class="four wide field">
                    <label>Estado Civil</label>
                    <select name="estadocivil">
                      <option value="">SELECCIONE</option>
                      <option value="SOLTERO">SOLTERO</option>
                      <option value="CASADO">CASADO</option>
                    </select>
                </div>
                <div class="three wide field">
                    <label>Ocupación</label>
                    <input type="text" placeholder="Ocupación" name="ocupacion">
                </div>
            </div>
            <div class="fields">
                <div class="two wide field">
                    <label>Religión</label>
                    <input type="text" placeholder="Religión" name="religion">
                </div>
                <div class="two wide field">
                    <label>Pais</label>
                    <input type="text" placeholder="País">
                </div>
                <div class="two wide field">
                    <label>Departamento</label>
                    <input type="text" placeholder="Departamento">
                </div>
                <div class="two wide field">
                    <label>Municipio</label>
                    <input type="text" placeholder="Municipio">
                </div>
                <div class="two wide field">
                    <label>Domicilio</label>
                    <input type="text" placeholder="Domicilio">
                </div>
                <div class="five wide field">
                    <label>Correo Elec</label>
                    <input type="text" placeholder="Direccion correo electronico" name="email">
                </div>
                <div class="two wide field">
                    <label>Clave</label>
                    <input type="password" name="clave" placeholder="Clave">
                </div>
                
            </div>
            <button class="ui blue button" type="submit">Guardar auxiliar</button>
            <div class="ui error message"></div>
        </form>
        
    </div>
    <div class="actions">
        
    </div>
</div>
<!-- fin modal ver detalle del paciente-->
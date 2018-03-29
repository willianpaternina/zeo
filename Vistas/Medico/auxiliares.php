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
                                     <th>#</th>
                                     <th>Identificacion</th>
                                     <th>Nombre</th>
                                     <th>Apellido</th>
                                     <th>Fecha nacimiento</th>
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
                    <select name="tident" id="tipo_ident">
                      <option value="">SELECCIONE</option>
                      <option value="TI">TI</option>
                      <option value="CC">CC</option>
                      <option value="RC">RC</option>
                    </select>
                </div>
                <div class="three wide field">
                    <label># Identificación</label>
                    <input type="number" name="identificacion" id="identificacion" placeholder="Num identificacion">
                </div>
                <div class=" four wide field">
                    <label>Nombre</label>
                    <input type="text" name="nombre" id="nombre" placeholder="Nombres">
                </div>
                <div class="four wide field">
                    <label>Apellido</label>
                    <input type="text" name="apellido" id="apellido" placeholder="Apellidos">
                </div>
                <div class="three wide field">
                    <label>Apellido casado</label>
                    <input type="text" id="apellidocasado" placeholder="Apellido casado">
                </div>
            </div>
            <div class="fields">
                <div class="one wide field">
                    <label>Genero</label>
                    <select name="genero" id="genero">
                      <option value="">SELECCIONE</option>
                      <option value="M">M</option>
                      <option value="F">F</option>
                    </select>
                </div>
                <div class="two wide field calendar">
                    <label>Fecha Nac</label>
                    <input type="text" name="fechanac" id="fechanac" placeholder="Fecha nacimiento">
                </div>
                <div class="two wide field" >
                    <label>Tipo Sangre</label>
                    <select name="tiposangre" id="tiposangre">
                      <option value="">SELECCIONE</option>
                      <option value="A+">A+</option>
                      <option value="B+">B+</option>
                    </select>
                </div>
                <div class="two wide field">
                    <label>Telefono</label>
                    <input type="text" name="telefono" id="telefono" placeholder="Telefono">
                </div>
                <div class="two wide field">
                    <label>Celular</label>
                    <input type="text" name="celular" id="celular" placeholder="# Celular">
                </div>
                <div class="four wide field">
                    <label>Estado Civil</label>
                    <select name="estadocivil" id="estadocivil">
                      <option value="">SELECCIONE</option>
                      <option value="SOLTERO">SOLTERO</option>
                      <option value="CASADO">CASADO</option>
                    </select>
                </div>
                <div class="three wide field">
                    <label>Ocupación</label>
                    <input type="text" placeholder="Ocupación" id="ocupacion" name="ocupacion">
                </div>
            </div>
            <div class="fields">
                <div class="two wide field">
                    <label>Religión</label>
                    <input type="text" placeholder="Religión" id="religion" name="religion">
                </div>
                <div class="two wide field">
                    <label>Pais</label>
                    <input type="text" placeholder="País" name="pais" id="pais">
                </div>
                <div class="two wide field">
                    <label>Departamento</label>
                    <input type="text" placeholder="Departamento" name="departamento" id="departamento">
                </div>
                <div class="two wide field">
                    <label>Municipio</label>
                    <input type="text" placeholder="Municipio" name="municipio" id="municipio">
                </div>
                <div class="two wide field">
                    <label>Domicilio</label>
                    <input type="text" placeholder="Domicilio" name="domicilio" id="domicilio">
                </div>
                <div class="five wide field">
                    <label>Correo Elec</label>
                    <input type="text" placeholder="Direccion correo electronico" name="email" id="email">
                </div>
                <div class="two wide field">
                    <label>Clave</label>
                    <input type="password" name="clave" placeholder="Clave" id="clave">
                </div>
                
            </div>
            <button class="ui blue button" type="submit">Guardar auxiliar</button>
            <div class="ui error message"></div>
        </form>
        
    </div>
    <div class="actions">
        
    </div>
</div>
<!-- FIN MODAL REGISTRAR USUARIOS-->

<!-- VENTANA MODAL PARA VER AUXILIARES -->
<div class="ui fullscreen modal verAuxiliar">
    <i class="close icon"></i>
    <div class="header">
        <h4>VER AUXILIAR</h4>
    </div>
    <div class="content">
        <form class="ui form auxiliar" id="frmVerAuxiliar">
            <div class="fields">
                <div class="four wide field">
                    <label>Identificación</label>
                    <input type="text"  id="ver_identificacion" placeholder="Num identificacion" readonly="">
                </div>
                <div class="four wide field">
                    <label> Nombre</label>
                    <input type="text" id="ver_nombre" placeholder="Num identificacion" readonly="">
                </div>
                <div class=" four wide field">
                    <label>Apellido</label>
                    <input type="text" id="ver_apellido" placeholder="Nombres" readonly="">
                </div>
                <div class="four wide field">
                    <label>Apellido casado</label>
                    <input type="text"  id="ver_apellidocasado" placeholder="Apellidos" readonly="">
                </div>
                
            </div>
            <div class="fields">
                <div class="five wide field">
                    <label>genero</label>
                    <input type="text"  id="ver_genero" placeholder="Num identificacion" readonly="true">
                </div>
                <div class="five wide field">
                    <label> Fecha nacimiento</label>
                    <input type="text" id="ver_fechanac" placeholder="Num identificacion" readonly="">
                </div>
                <div class=" five wide field">
                    <label>Tipo sangre</label>
                    <input type="text" id="ver_tiposangre" placeholder="Nombres" readonly="">
                </div>
                <div class="four wide field">
                    <label>Telefono</label>
                    <input type="text"  id="ver_telefono" placeholder="Apellidos" readonly="">
                </div>
            </div>
            <div class="fields">
                <div class="five wide field">
                    <label>Celular</label>
                    <input type="text"  id="ver_celular" placeholder="Num identificacion" readonly="true">
                </div>
                <div class="five wide field">
                    <label> Estado civil</label>
                    <input type="text" id="ver_estadocivil" placeholder="Num identificacion" readonly="">
                </div>
                <div class=" five wide field">
                    <label>Ocupacion</label>
                    <input type="text" id="ver_ocupacion" placeholder="Nombres" readonly="">
                </div>
                <div class="four wide field">
                    <label>Religion</label>
                    <input type="text"  id="ver_religion" placeholder="Apellidos" readonly="">
                </div>
            </div>
            <div class="fields">
                <div class="five wide field">
                    <label>Pais</label>
                    <input type="text"  id="ver_pais" placeholder="Num identificacion" readonly="true">
                </div>
                <div class="five wide field">
                    <label>Departamento</label>
                    <input type="text" id="ver_departamento" placeholder="Num identificacion" readonly="">
                </div>
                <div class=" five wide field">
                    <label>Municipio</label>
                    <input type="text" id="ver_municipio" placeholder="Nombres" readonly="">
                </div>
                <div class="four wide field">
                    <label>Domicilio</label>
                    <input type="text"  id="ver_domicilio" placeholder="Apellidos" readonly="">
                </div>
            </div>
            <div class="fields">
                <div class="five wide field">
                    <label>Email</label>
                    <input type="text"  id="ver_email" placeholder="Num identificacion" readonly="true">
                </div>
                <div class="five wide field">
                    <label>Fecha registro</label>
                    <input type="text" id="ver_fecharegistro" placeholder="Num identificacion" readonly="">
                </div>
                <div class=" five wide field">
                    <label>Estado</label>
                    <input type="number" id="ver_estado" placeholder="Nombres" readonly="">
                </div>
                
            </div>
        </form>
        
    </div>
    <div class="actions">
        
    </div>
</div>
<!-- fin modal ver detalle del paciente-->
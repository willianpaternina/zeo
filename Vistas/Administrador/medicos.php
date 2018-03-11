<?php
     include_once '../../Configuracion/Conexion.php';

     include_once '../../Modelo/Roles.php';
     include_once '../../Modelo/Medicos.php';
     include_once '../../Dao/IAdministradores.php';
     include_once '../../Controladores/AdministradorControlador.php';

     $modelmedico = new Medicos();
     $controladministrador = new AdministradorControlador();
?>
<div class="ui segments">
    <div class="ui blue inverted segment">
        <h4>MÓDULO DE MEDICOS</h4>
    </div>
    <div class="ui secondary segment">
        <div class="ui segments">
            <div class="ui blue inverted segment">
                <p>GESTIÓN DE MEDICOS Y ESPECIALIDADES</p>
            </div>
            <div class="ui secondary segment">
                <!-- modal ver detalle del medico-->
                <div class="ui fullscreen modal test">
                    <i class="close icon"></i>
                    <div class="header">
                        <h4>Información del medico detallada</h4>
                    </div>
                    <div class="content">
                        <table class="ui inverted blue celled table" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>Identificación</th>
                                    <th>Nombre</th>
                                    <th>Apellido</th>
                                    <th>Sangre</th>
                                    <th>Genero</th>
                                    <th>Fecha de nacimiento</th>
                                    <th>Estado civil</th>
                                    <th>Domicilio</th>
                                    <th>Ocupación</th>
                                    <th>Religión</th>
                                </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                    </div>
                    <div class="content">
                        <table class="ui inverted blue celled table" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>E-mail</th>
                                    <th>Telefono/celular</th>
                                    <th>Fecha/Hora de registro</th>
                                </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                    </div>
                    <div class="actions">
                        <button class="ui orange button"><i class="fa fa-edit"></i> Editar</button>
                    </div>
                </div>
                <!-- fin modal ver detalle del paciente-->
                <button type="button" id="nuevomedico" class="ui button teal" OnClick="location.href = 'LayoutAdministrador.php?load=regmedico'"><i class="fa fa-plus-square"></i></button>
                <button type="button" id="nuevomedico" class="ui button teal" OnClick="location.href = 'LayoutAdministrador.php?load=regespecialidad'">Asignación de especialidades</button>
                <div class="ui raised segment botoneraexcelpdfmedico">
                    <table id="tblMedico" class="ui selectable blue celled table" cellspacing="0" width="100%">
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
                            <?php foreach ($controladministrador->ListaMedico() as $_medico): ?>
                                <tr>
                                    <td><?php echo $_medico->getFechanacimiento('fechanacimiento'); ?></td>   
                                    <td><?php echo $_medico->getTipoidentificacion('tipoidentificacion') . ' ' . $_medico->getIdentificacion('identificacion'); ?></td>   
                                    <td><?php echo $_medico->getNombre('nombre'); ?></td>
                                    <td><?php echo $_medico->getApellido('apellido'); ?></td>
                                    <td><?php echo $_medico->getTiposangre('tiposangre'); ?></td>
                                    <td><?php echo $_medico->getTelefono('telefono'); ?></td>
                                    <td><?php echo $_medico->getCelular('celular'); ?></td>
                                    <td>
                                        <button class="ui blue button _vermedicomodal" value="<?php echo $_medico->getIdMedico('idMedico'); ?>"><i class="fa fa-eye"></i> Ver detalle</button>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

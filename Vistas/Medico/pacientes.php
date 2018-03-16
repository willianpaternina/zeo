<?php
     include_once '../../Configuracion/Conexion.php';

     include_once '../../Modelo/Roles.php';
     include_once '../../Modelo/Pacientes.php';
     include_once '../../Dao/IMedicos.php';
     include_once '../../Controladores/MedicosControlador.php';

     $modelpaciente = new Pacientes();
     $controlmedico = new MedicosControlador();
?>
<div class="ui segments">
    <div class="ui blue inverted segment">
        <h4>MÓDULO DE PACIENTES asdasd</h4>
    </div>
    <div class="ui secondary segment">
        <div class="ui segments">
            <div class="ui blue inverted segment">
                <p>GESTIÓN DE PACIENTES</p>
            </div>
            <div class="ui secondary segment">
                <!-- modal ver detalle del paciente-->
                <div class="ui fullscreen modal test">
                    <i class="close icon"></i>
                    <div class="header">
                        <h4>Información del paciente detallada</h4>
                    </div>
                    <div class="content">
                        <table class="ui celled table" cellspacing="0" width="100%">
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
                                <?php foreach ($controlmedico->ListaPaciente() as $_paciente): ?>
                                <tr>
                                    <td><?php echo $_paciente->getTipoidentificacion('tipoidentificacion').' '.$_paciente->getIdentificacion('identificacion'); ?></td>   
                                    <td><?php echo $_paciente->getNombre('nombre'); ?></td>
                                    <td><?php echo $_paciente->getApellido('apellido'); ?></td>
                                    <td><?php echo $_paciente->getTiposangre('tiposangre'); ?></td>
                                    <td><?php echo $_paciente->getGenero('genero'); ?></td>
                                    <td><?php echo $_paciente->getFechanacimiento('fechanacimiento'); ?></td>
                                    <td><?php echo $_paciente->getEstadocivil('estadocivil'); ?></td>
                                    <td><?php echo $_paciente->getMunicipio('municipio').' '.$_paciente->getPais('pais').'/'.$_paciente->getDepartamento('departamento').' '.$_paciente->getDomicilio('domicilio'); ?></td>
                                    <td><?php echo $_paciente->getOcupacion('ocupacion'); ?></td>
                                    <td><?php echo $_paciente->getReligion('religion'); ?></td>
                                </tr>
                            <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                    <div class="content">
                        <table class="ui celled table" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>E-mail</th>
                                    <th>Telefono/celular</th>
                                    <th>Fecha/Hora de registro</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($controlmedico->ListaPaciente() as $_paciente): ?>
                                    <tr>
                                        <td><?php echo $_paciente->getEmail('email'); ?></td>
                                        <td><?php echo $_paciente->getTelefono('telefono').' - '.$_paciente->getCelular('celular'); ?></td>
                                        <td><?php echo $_paciente->getFecharegistro('fecharegistro'); ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                    <div class="actions">
                        
                    </div>
                </div>
                <!-- fin modal ver detalle del paciente-->
                <button type="button" id="nuevopaciente" class="ui button teal" OnClick="location.href = 'LayoutMedico.php?load=regpaciente'"><i class="fa fa-plus-square"></i></button>
                <div class="ui raised segment botoneraexcelpdfpaciente">
                    <table id="tblPaciente" class="ui selectable blue celled table" cellspacing="0" width="100%">
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
                            <?php foreach ($controlmedico->ListaPaciente() as $_paciente): ?>
                                <tr>
                                    <td><?php echo $_paciente->getFechanacimiento('fechanacimiento'); ?></td>    
                                    <td><?php echo $_paciente->getTipoidentificacion('tipoidentificacion').' '.$_paciente->getIdentificacion('identificacion'); ?></td>   
                                    <td><?php echo $_paciente->getNombre('nombre'); ?></td>
                                    <td><?php echo $_paciente->getApellido('apellido'); ?></td>
                                    <td><?php echo $_paciente->getTiposangre('tiposangre'); ?></td>
                                    <td><?php echo $_paciente->getTelefono('telefono'); ?></td>
                                    <td><?php echo $_paciente->getCelular('celular'); ?></td>
                                    <td>
                                        <button class="ui blue button _verpacientemodal" value="<?php echo $_paciente->getIdPaciente('idPaciente'); ?>"><i class="fa fa-eye"></i> Ver detalle</button>
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

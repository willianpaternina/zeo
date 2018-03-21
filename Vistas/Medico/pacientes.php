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
        <h4>MÓDULO DE PACIENTES</h4>
    </div>
    <div class="ui secondary segment">
        <div class="ui segments">
            <div class="ui blue inverted segment">
                <p>GESTIÓN DE PACIENTES</p>
            </div>
            <div class="ui secondary segment">
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
                            <?php foreach ($controlmedico->ListaPaciente() AS $_paciente) : ?>
                                <tr>
                                    <td><?php echo $_paciente->getFechanacimiento('fechanacimiento'); ?></td>    
                                    <td><?php echo $_paciente->getTipoidentificacion('tipoidentificacion').' '.$_paciente->getIdentificacion('identificacion'); ?></td>   
                                    <td><?php echo $_paciente->getNombre('nombre'); ?></td>
                                    <td><?php echo $_paciente->getApellido('apellido'); ?></td>
                                    <td><?php echo $_paciente->getTiposangre('tiposangre'); ?></td>
                                    <td><?php echo $_paciente->getTelefono('telefono'); ?></td>
                                    <td><?php echo $_paciente->getCelular('celular'); ?></td>
                                    <td>
                                        <button type="button" id="verpaciente" class="ui button violet" OnClick="location.href = 'LayoutMedico.php?load=verpaciente&idpaciente=<?php echo $_paciente->getIdPaciente(); ?>'"><i class="fa fa-eye"></i></button>
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

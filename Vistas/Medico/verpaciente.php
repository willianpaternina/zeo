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
    <div class="ui segment">
        <p>Información del paciente detallada</p>
    </div>
    <div class="ui secondary segment">
        <?php foreach ($controlmedico->ListaPaciente() as $_paciente) : ?>
        <table style="display: block; overflow: scroll;" class="ui selectable blue celled table" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>NUMERO</th>
                        <th>CODIGO</th>
                        <th>IDENTIFICACIÓN</th>
                        <th>NOMBRE</th>
                        <th>APELLIDO</th>
                        <th>GENERO</th>
                        <th>FECHA DE NACIEMINTO</th>
                        <th>TIPO DE SANGRE</th>
                        <th>TELEFONO</th>
                        <th>CELULAR</th>
                        <th>ESTADO CIVIL</th>
                        <th>OCUPACIÓN</th>
                        <th>RELIGIÓN</th>
                        <th>DIRECCIÓN</th>
                        <th>CORREO</th>
                        <th>FECHA DE REGISTRO</th>
                        <th>ESTADO</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><?php echo $_paciente->getIdPaciente('idPaciente'); ?></td>
                        <td><?php echo $_paciente->getCodigo('codigo'); ?></td>
                        <td><?php echo $_paciente->getTipoidentificacion('tipoidentificacion').' '. $_paciente->getIdentificacion('identificacion'); ?></td>
                        <td><?php echo $_paciente->getNombre('nombre'); ?></td>
                        <td><?php echo $_paciente->getApellido('apellido').' '. $_paciente->getApellidocasada('apellidocasada'); ?></td>
                        <td><?php echo $_paciente->getGenero('genero'); ?></td>
                        <td><?php echo $_paciente->getFechanacimiento('fechanacimiento'); ?></td>
                        <td><?php echo $_paciente->getTiposangre('tiposangre'); ?></td>
                        <td><?php echo $_paciente->getTelefono('telefono'); ?></td>
                        <td><?php echo $_paciente->getCelular('celular'); ?></td>
                        <td><?php echo $_paciente->getEstadocivil('estadocivil'); ?></td>
                        <td><?php echo $_paciente->getOcupacion('ocupacion'); ?></td>
                        <td><?php echo $_paciente->getReligion('religion'); ?></td>
                        <td><?php echo $_paciente->getDomicilio('domicilio') .' '. $_paciente->getMunicipio('municipio').' '.$_paciente->getDepartamento('departamento').' '.$_paciente->getPais('pais'); ?></td>
                        <td><?php echo $_paciente->getEmail('email'); ?></td>
                        <td><?php echo $_paciente->getFecharegistro('fecharegistro'); ?></td>
                        <td><?php echo $_paciente->getEstado('estado'); ?></td>
                    </tr>
                </tbody>
            </table>
        <?php endforeach; ?>
    </div>
</div>

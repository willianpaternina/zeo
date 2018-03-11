<?php 
     include_once '../../Configuracion/Conexion.php';
     
     include_once '../../Modelo/Roles.php';
     include_once '../../Dao/IRoles.php';
     
     include_once '../../Modelo/Medicos.php';
     include_once '../../Modelo/Pacientes.php';
     include_once '../../Dao/IMedicos.php';
     include_once '../../Controladores/MedicosControlador.php';
     
     $modelpaciente = new Pacientes();
     $controlmedico = new MedicosControlador();
     
     if (isset($_POST['btnguardarpaciente'])) { 
         $modelpaciente->setCodigo($_REQUEST['txtcodigo']);
         $modelpaciente->setTipoidentificacion($_REQUEST['txttipoidentificacion']);
         $modelpaciente->setIdentificacion($_REQUEST['txtidentificacion']);
         $modelpaciente->setNombre($_REQUEST['txtnombre']);
         $modelpaciente->setApellido($_REQUEST['txtapellido']);
         $modelpaciente->setApellidocasada($_REQUEST['txtapellidocasada']);
         $modelpaciente->setGenero($_REQUEST['txtgenero']);
         $modelpaciente->setFechanacimiento($_REQUEST['txtfechanacimiento']);
         $modelpaciente->setTiposangre($_REQUEST['txttiposangre']);
         $modelpaciente->setTelefono($_REQUEST['txttelefono']);
         $modelpaciente->setCelular($_REQUEST['txtcelular']);
         $modelpaciente->setEstadocivil($_REQUEST['txtestadocivil']);
         $modelpaciente->setOcupacion($_REQUEST['txtocupacion']);
         $modelpaciente->setReligion($_REQUEST['txtreligion']);
         $modelpaciente->setPais($_REQUEST['txtpais']);
         $modelpaciente->setDepartamento($_REQUEST['txtdepartamento']);
         $modelpaciente->setMunicipio($_REQUEST['txtmunicipio']);
         $modelpaciente->setDomicilio($_REQUEST['txtdomicilio']);
         $modelpaciente->setEmail($_REQUEST['txtemail']);
         $modelpaciente->setClave($_REQUEST['txtclave']);
         $controlmedico->RegistrarPaciente($modelpaciente);
         echo '<script type="text/javascript">window.location.replace("LayoutMedico.php?load=pacientes");</script>';
         exit;
     }
     
    
     
?>
<div class="ui segments">
    <div class="ui blue inverted segment">
        <h3>Registrar nuevo paciente</h3>
    </div>
    <div class="ui secondary segment">
        <form class="ui form" method="POST">
            <div class="five fields">
                <div class="field">
                    <input type="number" name="txtcodigo" placeholder="Código del paciente" required="true" size="20">
                </div>
                <div class="field">
                    <div class="ui selection dropdown">
                        <input type="hidden" name="txttipoidentificacion" required="true">
                        <i class="dropdown icon"></i>
                        <div class="default text">Tipo de identificación</div>
                        <div class="menu">
                            <div class="item" data-value="CC">Cédula de ciudadanía</div>
                            <div class="item" data-value="TE">Tarjeta de extranjería</div>
                            <div class="item" data-value="CE">Cédula de extranjería</div>
                            <div class="item" data-value="TI">Tarjeta de identidad</div>
                            <div class="item" data-value="RC">Registro civil</div>
                        </div>
                    </div>
                </div>
                <div class="field">
                    <input type="number" name="txtidentificacion" placeholder="Identificación" required="true" size="20">
                </div>
                <div class="field">
                    <input type="text" name="txtnombre" placeholder="Nombre del paciente" required="true" size="25">
                </div>
                <div class="field">
                    <input type="text" name="txtapellido" placeholder="Apellidos del paciente" required="true" size="35">
                </div>
                <div class="field">
                    <input type="text" name="txtapellidocasada" placeholder="Apellido casada" size="35">
                </div>
            </div>
            <div class="five fields">
                <div class="field">
                    <div class="ui selection dropdown">
                        <input type="hidden" name="txtgenero" required="true">
                        <i class="dropdown icon"></i>
                        <div class="default text">Genero</div>
                        <div class="menu">
                            <div class="item" data-value="M">M</div>
                            <div class="item" data-value="F">F</div>
                        </div>
                    </div>
                </div>
                <div class="field">
                    <input type="date" name="txtfechanacimiento" placeholder="Fecha de nacimiento" required="true">
                </div>
                <div class="field">
                    <div class="ui selection dropdown">
                        <input type="hidden" name="txttiposangre">
                        <i class="dropdown icon"></i>
                        <div class="default text">Tipo de sangre</div>
                        <div class="menu">
                            <div class="item" data-value="O+">O+</div>
                            <div class="item" data-value="A-">A-</div>
                            <div class="item" data-value="A+">A+</div>
                            <div class="item" data-value="B-">B-</div>
                            <div class="item" data-value="B+">B+</div>
                            <div class="item" data-value="AB+">AB+</div>
                            <div class="item" data-value="AB-">AB-</div>
                        </div>
                    </div>
                </div>
                <div class="field">
                    <input type="number" name="txttelefono" placeholder="Telefono"  size="7">
                </div>
                <div class="field">
                    <input type="number" name="txtcelular" placeholder="Celular" required="true" size="10">
                </div>
            </div>
            <div class="five fields">
                <div class="field">
                    <div class="ui selection dropdown">
                        <input type="hidden" name="txtestadocivil">
                        <i class="dropdown icon"></i>
                        <div class="default text">Estado civil</div>
                        <div class="menu">
                            <div class="item" data-value="SOLTERO/A">Soltero/a</div>
                            <div class="item" data-value="COMPROMETIDO/A">Comprometido/a</div>
                            <div class="item" data-value="CASADO/A">Casado/a</div>
                            <div class="item" data-value="DIVORCIADO/A">Divorciado/a</div>
                            <div class="item" data-value="VIUDO/A">Viudo/a</div>
                        </div>
                    </div>
                </div>
                <div class="field">
                    <input type="text" name="txtocupacion" placeholder="Ocupación" required="true" size="10">
                </div>
                <div class="field">
                    <input type="text" name="txtreligion" placeholder="Religión" required="true" size="10">
                </div>
                <div class="field">
                    <input type="text" name="txtpais" placeholder="Pais" required="true" size="10">
                </div>
                <div class="field">
                    <input type="text" name="txtdepartamento" placeholder="Departamento" required="true" size="10">
                </div>
                <div class="field">
                    <input type="text" name="txtmunicipio" placeholder="Municipio" required="true" size="10">
                </div>
            </div>
            <div class="three fields">
                <div class="field">
                    <input type="text" name="txtdomicilio" placeholder="Domicilio" required="true" size="10">
                </div>
                <div class="field">
                    <input type="email" name="txtemail" placeholder="Correo electronico" required="true" size="120">
                </div>
                <div class="field">
                    <input type="password" name="txtclave" placeholder="Codigo de acceso" required="true" size="60">
                </div>
                <div class="field">
                    <input type="password" name="txtconfirmarclave" placeholder="Confirmar codigo de acceso" required="true" size="60">
                </div>
            </div>
            <input type="submit" name="btnguardarpaciente" class="ui green button" value="Guardar">
            <button name="btncancelarpaciente" class="ui red button" OnClick="location.href = 'LayoutMedico.php?load=pacientes'">Cancelar</button>
        </form>
    </div>
</form>
</div>
</div>


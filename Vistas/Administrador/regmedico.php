<?php 
     include_once '../../Configuracion/Conexion.php';
     
     include_once '../../Modelo/Roles.php';
     include_once '../../Dao/IRoles.php';
     
     include_once '../../Modelo/Medicos.php';
     include_once '../../Dao/IAdministradores.php';
     include_once '../../Controladores/AdministradorControlador.php';
     
     $modelmedico = new Medicos();
     $controladministrador = new AdministradorControlador();
     
     if (isset($_POST['btnguardarmedico'])) { 
         $modelmedico->setCodigo($_REQUEST['txtcodigo']);
         $modelmedico->setTipoidentificacion($_REQUEST['txttipoidentificacion']);
         $modelmedico->setIdentificacion($_REQUEST['txtidentificacion']);
         $modelmedico->setNombre($_REQUEST['txtnombre']);
         $modelmedico->setApellido($_REQUEST['txtapellido']);
         $modelmedico->setApellidocasada($_REQUEST['txtapellidocasada']);
         $modelmedico->setGenero($_REQUEST['txtgenero']);
         $modelmedico->setFechanacimiento($_REQUEST['txtfechanacimiento']);
         $modelmedico->setTiposangre($_REQUEST['txttiposangre']);
         $modelmedico->setTelefono($_REQUEST['txttelefono']);
         $modelmedico->setCelular($_REQUEST['txtcelular']);
         $modelmedico->setEstadocivil($_REQUEST['txtestadocivil']);
         $modelmedico->setOcupacion($_REQUEST['txtocupacion']);
         $modelmedico->setReligion($_REQUEST['txtreligion']);
         $modelmedico->setPais($_REQUEST['txtpais']);
         $modelmedico->setDepartamento($_REQUEST['txtdepartamento']);
         $modelmedico->setMunicipio($_REQUEST['txtmunicipio']);
         $modelmedico->setDomicilio($_REQUEST['txtdomicilio']);
         $modelmedico->setEmail($_REQUEST['txtemail']);
         $modelmedico->setClave($_REQUEST['txtclave']);
         $controladministrador->RegistrarMedico($modelmedico);
         echo '<script type="text/javascript">window.location.replace("LayoutAdministrador.php?load=medicos");</script>';
         exit;
     }
     
    
     
?>
<div class="ui segments">
    <div class="ui blue inverted segment">
        <h3>REGISTRAR NUEVO MEDICO</h3>
    </div>
    <div class="ui secondary segment">
        <form class="ui form" method="POST">
            <div class="five fields">
                <div class="field">
                    <input type="number" name="txtcodigo" placeholder="Código del medico" required="true" size="20">
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
                    <input type="text" name="txtnombre" placeholder="Nombre del medico" required="true" size="25">
                </div>
                <div class="field">
                    <input type="text" name="txtapellido" placeholder="Apellidos del medico" required="true" size="35">
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
            </div>
            <input type="submit" name="btnguardarmedico" class="ui green button" value="Guardar">
            <button name="btncancelarmedico" class="ui red button" OnClick="location.href = 'LayoutAdministrador.php?load=medicos'">Cancelar</button>
        </form>
    </div>
</form>
</div>
</div>


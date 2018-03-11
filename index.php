<?php
$err = isset($_GET['error']) ? $_GET['error'] : null;
?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, user-scalable=no" />
        <meta name="description" content="">
        <meta name="keywords" content="">
        <title>ZEO</title>
        <link href="Vistas/Recursos/css/makeup.css" rel="stylesheet" type="text/css"/>
        <link href="Vistas/Recursos/css/normalize.css" rel="stylesheet" type="text/css"/>
        <link href="Vistas/Recursos/css/bootsnipp.min.css" rel="stylesheet" type="text/css"/>
        <link href="Vistas/Recursos/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="Vistas/Recursos/css/access.css" rel="stylesheet" type="text/css"/>
    </head>
    <body oncontextmenu="return false">
        <div class="container">
            <div class="row">
                <div class="col-sm-6 col-md-4 col-md-offset-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <strong> Acceso de usuarios</strong>
                        </div>
                        <div class="panel-body">
                            <form role="form" action="./Padlock/validatesessionpaciente.php" method="POST">
                                <fieldset>
                                    <div class="row">
                                        <div class="center-block">
                                            <img class="profile-img" src="Vistas/Recursos/img/logouser.png" alt=""/>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12 col-md-10  col-md-offset-1 ">
                                            <div class="form-group">
                                                <div id="alertaadvertencia">
                                                    <span class="sr-only">Error:</span>
                                                    <?php
                                                    if ($err == 1) {
                                                        echo "<div class='alert alert-danger'><span class='sr-only'>Error:</span><img src='Vistas/Recursos/img/user__exclamation.png'/> <strong>Error</strong>, usuario o contraseña invalidos</div>";
                                                    }
                                                    if ($err == 2) {
                                                        echo "<div class='alert alert-warning'><span class='sr-only'>Advertencia:</span><img src='Vistas/Recursos/img/user__exclamation.png'/> <strong>Por favor</strong>, debe iniciar sesión para poder acceder</div>";
                                                    }
                                                    if ($err == 3) {
                                                        echo "<div class='alert alert-warning'><span class='sr-only'>Advertencia:</span><img src='Vistas/Recursos/img/user__exclamation.png'/> <strong>Advertencia</strong>, No tiene los permisos requeridos</div>";
                                                    }
                                                    ?>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon">
                                                        <img src="Vistas/Recursos/img/user.png" alt=""/>
                                                    </span>
                                                    <input class="form-control" placeholder="Identificación" name="identificacion" type="text" required="" onKeyPress="return SoloNumeros(event);">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon">
                                                        <img src="Vistas/Recursos/img/pass.png" alt=""/>
                                                    </span>
                                                    <input class="form-control" placeholder="Contraseña" name="clave" type="password" required="">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <select class="form-control" id="rol" name="rol">
                                                    <option value="1">ADMINISTRADOR</option>
                                                    <option value="2">PACIENTE</option>
                                                    <option value="3">MEDICO</option>
                                                    <option value="4">AUXILIAR</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <input type="submit" id="btniniciarsesion" class="btn btn-lg btn-primary btn-block" value="iniciar sesión">
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>
                            </form>
                        </div>
                        <div class="panel-footer ">
                            <a href="#" onClick=""> He olvidado mi contraseña </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="Vistas/Recursos/js/jquery.min.js" type="text/javascript"></script>
        <script src="Vistas/Recursos/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="Vistas/Recursos/js/validate.js" type="text/javascript"></script>
        <script src="Vistas/Recursos/js/validatenumbersletters.js" type="text/javascript"></script>
    </body>
</html>


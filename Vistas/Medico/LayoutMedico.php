<?php 
     include_once '../../Configuracion/RouterMedico.php';
     include_once '../../Modelo/Sesion.php';
     $objses = new Sesion();
     $objses->init();

     if (isset($_SESSION['nombre'])) {
         $nombremedico = $objses->get('nombre');
         $idmedico = $objses->get('idMedico');
         $idrol = $objses->get('idRol');
         $rol = $objses->get('rol');
         if ($idrol != 3) {
             include_once '../../Modelo/Destroy.php';
             $objdes = new Destroy();             
             $objdes->destroy();
             header('Location: ../../index.php?error=3');
         }
     } else {
         $usuario = isset($nombremedico) ? $nombremedico : null;
         if ($usuario == '') {
             header('Location: ../../index.php?error=2');
         }
     }
?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
        <link href="../Recursos/css/normalize.css" rel="stylesheet" type="text/css"/>
        <link href="../Recursos/lib/font-awesome-4.7.0/css/font-awesome.css" rel="stylesheet" type="text/css"/>
        <link href="../Recursos/lib/Semantic/semantic.css" rel="stylesheet" type="text/css"/>
        <link href="../Recursos/css/dataTables.semanticui.min.css" rel="stylesheet" type="text/css"/>
        <link href="../Recursos/css/buttons.jqueryui.min.css" rel="stylesheet" type="text/css"/>
        <link href="../Recursos/css/session.css" rel="stylesheet" type="text/css"/>
        <link href="../Recursos/css/layout.css" rel="stylesheet" type="text/css"/>
        <link href="../Recursos/css/fullcalendar.min.css" rel="stylesheet" type="text/css"/>
        <link href="../Recursos/css/fullcalendar.print.min.css" rel='stylesheet' media='print' />
    </head>
    <body>
        <div class="ui-layout-north">
            <?php include_once ('../Recursos/include/north.php'); ?>
        </div>
        <div class="ui-layout-west">
            <?php include_once ('../Recursos/include/menumedico.php'); ?>
        </div>
        
        <div class="ui-layout-center">
            <?php
             $medico = new RouterMedico();
             if ($medico->validateURL(isset($_GET['load']))) {
                 $medico->LoadView($_GET['load']);
             }
         ?>  
        </div>
   
        <script src="../Recursos/js/jquery.min.js" type="text/javascript"></script>
        <script src="../Recursos/js/layout.js" type="text/javascript"></script>
        <script src="../Recursos/js/tab.js" type="text/javascript"></script>
        <script src="../Recursos/js/makeup.js" type="text/javascript"></script>
        <script src="../Recursos/js/table.js" type="text/javascript"></script>
        <script src="../Recursos/js/jquery-latest.js" type="text/javascript"></script>
        <script src="../Recursos/js/jquery.layout-latest.js" type="text/javascript"></script>
        <script src="../Recursos/lib/Semantic/semantic.js" type="text/javascript"></script>
        <script src="../Recursos/js/jquery.dataTables.min.js" type="text/javascript"></script>
        <script src="../Recursos/js/dataTables.semanticui.min.js" type="text/javascript"></script>
        <script src="../Recursos/js/dataTables.buttons.min.js" type="text/javascript"></script>
        <script src="../Recursos/js/buttons.colVis.min.js" type="text/javascript"></script>
        <script src="../Recursos/js/buttons.html5.min.js" type="text/javascript"></script>
        <script src="../Recursos/js/buttons.jqueryui.min.js" type="text/javascript"></script>
        <script src="../Recursos/js/buttons.print.min.js" type="text/javascript"></script>
        <script src="../Recursos/js/jszip.min.js" type="text/javascript"></script>
        <script src="../Recursos/js/vfs_fonts.js" type="text/javascript"></script>
        <script src="../Recursos/js/dropdown.js" type="text/javascript"></script>
        <script src="../Recursos/js/modal.js" type="text/javascript"></script>
        <script src="js/medico.js" type="text/javascript"></script>
        <script src='../Recursos/js/moment.min.js' type="text/javascript"></script>
        <script src='../Recursos/js/fullcalendar.min.js' type="text/javascript"></script>
    </body>   
</html>
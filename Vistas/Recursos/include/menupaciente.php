<div class="ui blue vertical menu">
    <?php if(isset($_GET["load"]) && $_GET["load"]==="inicio"): ?>
        <a class="active item" href="LayoutPaciente.php?load=inicio"><i class="home icon"></i>Inicio</a>
    <?php else: ?>
        <a class="item" href="LayoutPaciente.php?load=inicio"><i class="home icon"></i>Inicio</a>
    <?php endif ?>
        
    <?php if(isset($_GET["load"]) && $_GET["load"]==="cita"): ?>
        <a class="active item" href="LayoutPaciente.php?load=cita"><i class="edit icon"></i>Cita medica</a>
    <?php else: ?>
        <a class="item" href="LayoutPaciente.php?load=cita"><i class="edit icon"></i>Cita medica</a>
    <?php endif ?>
        
    <?php if(isset($_GET["load"]) && $_GET["load"]==="citasactivas"): ?>
        <a class="active item" href="LayoutPaciente.php?load=citasactivas"><i class="edit icon"></i>Citas Activas</a>
    <?php else: ?>
        <a class="item" href="LayoutPaciente.php?load=citasactivas"><i class="edit icon"></i>Citas Activas</a>
    <?php endif ?>
        
    <?php if(isset($_GET["load"]) && $_GET["load"]==="citasrealizadas"): ?>
        <a class="active item" href="LayoutPaciente.php?load=citasrealizadas"><i class="edit icon"></i>Citas Realizadas</a>
    <?php else: ?>
        <a class="item" href="LayoutPaciente.php?load=citasrealizadas"><i class="edit icon"></i>Citas Realizadas</a>
    <?php endif ?>
    <a class="item" href="LayoutPaciente.php?load=logout"><i class="power icon"></i>Cerrar sesión</a>
    
    
</div>	

<?php
     require '../Configuracion/Conexion.php';
     require '../Modelo/Sesion.php';
     
     include_once '../Dao/IAdministradores.php';
     require '../Controladores/AdministradorControlador.php';
     
     include_once '../Dao/IPacientes.php';
     require '../Controladores/PacientesControlador.php';
     
     include_once '../Dao/IMedicos.php';
     require '../Controladores/MedicosControlador.php';
   
     include_once '../Dao/IAuxiliares.php';
     require '../Controladores/AuxiliarControlador.php';
     require_once $_SERVER['DOCUMENT_ROOT']."/Zeo/Modelo/Auxiliares.php";
     
     
     $rol = $_POST['rol'];
     switch ($rol) {
         case 1 :
             $objadministrador = new AdministradorControlador();
             $objadministrador->IniciarSesionAdministrador();
         break;
         case 2 :
             $objpaciente = new PacientesControlador();
             $objpaciente->IniciarSesionPaciente();
         break;
         case 3 :
             $objmedico = new MedicosControlador();
             $objmedico->IniciarSesionMedico();
         break;
         case 4 :
             $objauxiliar = new AuxiliarControlador();
             $objauxiliar->IniciarSesionAuxiliar();
         break;
     }
?>


<?php
     require_once $_SERVER['DOCUMENT_ROOT']."/Zeo/Modelo/Destroy.php";
     $objSe = new Destroy();
     $objSe->init();
     $objSe->destroy();
?>
<script>
    window.location.href = "../../index.php";
</script>

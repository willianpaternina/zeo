<?php
     require'../../Modelo/Destroy.php';
     $objSe = new Destroy();
     $objSe->init();
     $objSe->destroy();
?>
<script>
    window.location.href = "../../index.php";
</script>

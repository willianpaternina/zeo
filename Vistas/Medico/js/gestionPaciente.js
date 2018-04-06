$(function(){
    var gestionActividades = $('#tblActividadesMedicamento').DataTable({
        "ajax": 'http://localhost/zeo/Controladores/MedicosControlador.php?listarCitaEstado=listarEstadoMedico',
         "columnDefs": [ {
            "targets": -1,
            "data": null,
            "defaultContent": "<button class='ui mini blue button btnAddActividad' ><i class='add icon'></i></button> <button class='ui mini blue button btnVerActividad'><i class='eye icon'></i></button>"+
                               "<button class='ui mini green button btnAddMedicamento' ><i class='add icon'></i></button> <button class='ui mini green button btnVerMedicamento'><i class='eye icon'></i></button> ",
        } ],
        "language": idioma_espanol,
        "aaSorting": [[0, "desc"]],
        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "todos"]],
        "dom": "Blfrtip",
        buttons: [
            {
                extend: 'excelHtml5',
                text: '<button class="ui green button" type="button"><i class="fa fa-file-excel-o"></i></button>',
                titleAttr: 'Excel'
            },
        ]
    });
    gestionActividades.buttons().container().insertBefore('.botoneraexcelpdfauxiliares');
    
    $('#tblActividadesMedicamento tbody').on( 'click', 'button.btnAddMedicamento', function () {
        var data = gestionActividades.row( $(this).parents('tr') ).data();
        //alert("agregar medicamentos");
        $("#idPacienteMed").val(data[4]);
        $(".addMedicamentos").modal("show")
    })
    $('#tblActividadesMedicamento tbody').on( 'click', 'button.btnVerMedicamento', function () {
        var data = gestionActividades.row( $(this).parents('tr') ).data();
        //alert("ver medicamentos");
        //$("#idPacienteMed").val(data[4]);
        $("._verMedicamentos").modal("show")
        var consultarMedicamentos = $('#tblVerMedicamentosPaciente').DataTable({
            "destroy":true,
            //"ajax": 'http://localhost/zeo/Controladores/MedicosControlador.php?consultarActividadesEtapa=listarActividades&idPaciente='+data[4],
             "columnDefs": [ {
                "targets": -1,
                "data": null,
                "defaultContent": "<button class='ui mini blue button btnAddActividad' ><i class='edit icon'></i></button> ",
            } ],
            "language": idioma_espanol,
            "aaSorting": [[0, "desc"]],
            "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "todos"]],
            
        });
        consultarMedicamentos.buttons().container().insertBefore('.botoneraexcelpdfauxiliares');
        
    })
    $('#tblActividadesMedicamento tbody').on( 'click', 'button.btnAddActividad', function () {
        var data = gestionActividades.row( $(this).parents('tr') ).data();
        $("#idPaciente").val(data[4]);
        $(".addActividad").modal("show")
    })
    $('#tblActividadesMedicamento tbody').on( 'click', 'button.btnVerActividad', function () {
        var data = gestionActividades.row( $(this).parents('tr') ).data();
        //data[4]
        $(".verActividad").modal("show")
        var consultarActividades = $('#tblVerActividadesPaciente').DataTable({
            "destroy":true,
            "ajax": 'http://localhost/zeo/Controladores/MedicosControlador.php?consultarActividadesEtapa=listarActividades&idPaciente='+data[4],
             "columnDefs": [ {
                "targets": -1,
                "data": null,
                "defaultContent": "<button class='ui mini blue button btnAddActividad' ><i class='edit icon'></i></button> ",
            } ],
            "language": idioma_espanol,
            "aaSorting": [[0, "desc"]],
            "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "todos"]],
            
        });
        consultarActividades.buttons().container().insertBefore('.botoneraexcelpdfauxiliares');
        
        
    })
    /*
      * VALIDACION FORMULARIO ACTIVIDAD
      */     
    $('.ui.form.frmAddActividad')
    .form({
      fields: {
        etapaTumor     : 'empty',
        concepto     : 'empty',
        estado     : 'empty',
        numHoras     : 'empty',
        numDias     : 'empty',
      },
      onSuccess : function(e){
          e.preventDefault();
          
          var datos = new FormData();
              datos.append("idPaciente", $("#idPaciente").val());
              datos.append("etapaTumor", $("#etapaTumor").val());
              datos.append("concepto", $("#concepto").val());
              datos.append("estado", $("#estado").val());
              datos.append("numHoras", $("#numHoras").val());
              datos.append("numDias", $("#numDias").val());
              
              datos.append("medigoRegistrarActividad", "registarActividad");
           $.ajax({
                    url: 'http://localhost/zeo/Controladores/MedicosControlador.php',
                    type: 'POST',
                    data: datos,
                    cache: false,
                    processData: false,
                    contentType: false,
                    success: function(respuesta){
                        //console.log(respuesta);return
                        rept = eval(respuesta)
                        if(rept[0]["exito"]=='ok'){
                             $('.ui.form.frmAddActividad').form('reset')
                            //mensaje exito
                            alert("Los datos se actualizaron de manera exitosa")
                            //actualizar data
                            gestionActividades.ajax.reload(null,false);
                            //cerrar ventana modal
                            $(".addActividad").modal('hide');
                            
                        }else{
                             //mensaje exito
                            alert("Los datos no pudieron ser actualizados, intente mas tarde.")
                            //actualizar data
                            gestionActividades.ajax.reload(null,false);
                             $(".addActividad").modal('hide');

                        }
                    }
                });
      }
    })
    /*
      * VALIDACION FORMULARIO MEDICAMENTO
      */     
    $('.ui.form.frmAddMedicamento')
    .form({
      fields: {
        medicamentos     : 'empty',
        etapa     : 'empty',
        concepto     : 'empty',
        medNumHoras     : 'empty',
        medNumDias     : 'empty',
      },
      onSuccess : function(e){
          e.preventDefault();
          
          var datos = new FormData();
              datos.append("idPacienteMed", $("#idPacienteMed").val());
              datos.append("medicamentos", $("#medicamentos").val());
              datos.append("etapa", $("#etapa").val());
              datos.append("concepto", $("#conceptoMed").val());
              datos.append("medNumHoras", $("#medNumHoras").val());
              datos.append("medNumDias", $("#medNumDias").val());
              
              datos.append("registrarMedicamento", "medicoRegistrarMedicamento");
           $.ajax({
                    url: 'http://localhost/zeo/Controladores/MedicosControlador.php',
                    type: 'POST',
                    data: datos,
                    cache: false,
                    processData: false,
                    contentType: false,
                    success: function(respuesta){
                        console.log(respuesta);return
                        rept = eval(respuesta)
                        if(rept[0]["exito"]=='ok'){
                             $('.ui.form.frmAddActividad').form('reset')
                            //mensaje exito
                            alert("Los datos se actualizaron de manera exitosa")
                            //actualizar data
                            gestionActividades.ajax.reload(null,false);
                            //cerrar ventana modal
                            $(".addActividad").modal('hide');
                            
                        }else{
                             //mensaje exito
                            alert("Los datos no pudieron ser actualizados, intente mas tarde.")
                            //actualizar data
                            gestionActividades.ajax.reload(null,false);
                             $(".addActividad").modal('hide');

                        }
                    }
                });
      }
    })
    
    
})
var idioma_espanol = {
    "sProcessing": "Procesando...",
    "sLengthMenu": "Mostrar _MENU_ registros",
    "sZeroRecords": "No se encontraron resultados",
    "sEmptyTable": "Ningún dato disponible en esta tabla",
    "sInfo": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
    "sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
    "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
    "sInfoPostFix": "",
    "sSearch": "",
    "searchPlaceholder": "Buscar...",
    "sUrl": "",
    "sInfoThousands": ",",
    "sLoadingRecords": "Cargando...",
    "oPaginate": {
        "sFirst": "Primero",
        "sLast": "Ultimo",
        "sNext": "Siguiente",
        "sPrevious": "Anterior"
    }
}
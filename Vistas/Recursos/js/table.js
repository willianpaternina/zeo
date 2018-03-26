$(document).ready(function () {    
    var paciente = $('#tblPaciente').DataTable({
        "language": idioma_espanol,
        "aaSorting": [[0, "desc"]],
        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "todos"]],
        buttons: [
            {
                extend: 'excelHtml5',
                text: '<button class="ui green button" type="button"><i class="fa fa-file-excel-o"></i></button>',
                titleAttr: 'Excel'
            }
        ]
    });
    paciente.buttons().container().insertBefore('.botoneraexcelpdfpaciente');
    
    var medico = $('#tblMedico').DataTable({
        "language": idioma_espanol,
        "aaSorting": [[0, "desc"]],
        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "todos"]],
        buttons: [
            {
                extend: 'excelHtml5',
                text: '<button class="ui green button" type="button"><i class="fa fa-file-excel-o"></i></button>',
                titleAttr: 'Excel'
            }
        ]
    });
    medico.buttons().container().insertBefore('.botoneraexcelpdfmedico');
    
    var auxiliares = $('#tblAuxiliares').DataTable({
        "language": idioma_espanol,
        "aaSorting": [[0, "desc"]],
        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "todos"]],
        buttons: [
            {
                extend: 'excelHtml5',
                text: '<button class="ui green button" type="button"><i class="fa fa-file-excel-o"></i></button>',
                titleAttr: 'Excel'
            },
            {
                "text": "<i class='fa fa-user-plus'></i>",
                "titleAttr": "Agregar auxiliar",
                "className":"ui blue button",
                "action": function(){
                  $(".addAuxiliar").modal('show');
                
                }
            },
        ]
    });
    auxiliares.buttons().container().insertBefore('.botoneraexcelpdfauxiliares');
    
     var especialidad = $('#tblEspecialidad').DataTable({
        
         "ajax": 'http://localhost/zeo/Controladores/MedicosControlador.php?medicoEspecialidades=especialidad',
         "columnDefs": [ {
            "targets": -1,
            "data": null,
            "defaultContent": "<button class='ui yellow button btnEditarEspecialidad' idEspecialidadClick>Editar!</button>",
        } ],
        "language": idioma_espanol,
        "aaSorting": [[0, "desc"]],
        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "todos"]],
        "dom": "Blfrtip",
        "buttons": [
            {
                "text": "<i class='fa fa-user-plus'></i>",
                "titleAttr": "Agregar especialidad",
                "className":"ui blue button",
                "action": function(){
                  $(".addEspecialidad").modal('show');
                   $(".addEspecialidad").modal({
                    closable: true
                    });
                
                }
            },
            {
                extend: 'excelHtml5',
                text: '<button class="ui green button" type="button"><i class="fa fa-file-excel-o"></i></button>',
                titleAttr: 'Excel'
            },
            {
                extend: 'csvHtml5',
                text: '<i class="fa fa-file-text-o"></i>',
                "className":"ui orange button",
                titleAttr: 'CSV'
            },
            {
                extend: 'pdfHtml5',
                text: '<i class="fa fa-file-pdf-o"></i>',
                "className":"ui red button",
                titleAttr: 'PDF'
            },
            
        ]
    });
    //especialidad.buttons().container().insertBefore('.botoneraexcelpdfespecialidad');
   /*
      * VALIDACION FORMULARIO ADDESPECILIDAD
      */     
    $('.ui.form.especialidad')
    .form({
      fields: {
        nombreEspecialidad    : ['minLength[4]', 'empty'],
        detalleEspecialidad   : 'empty',
        
      },
      onSuccess : function(e){
          e.preventDefault();
          var datos = new FormData();
            datos.append("especialidad", $('#nombreEspecialidad').val());
            datos.append("detalle", $("#detalleEspecialidad").val());

          $.ajax({
                url: 'http://localhost/zeo/Controladores/MedicosControlador.php?medicoEspecialidades=RegistrarEspecialidad',
                type: 'POST',
                data: datos,
                cache: false,
                processData: false,
                contentType: false,
                success: function(respuesta){
                    //console.log(respuesta);return;
                    rept = eval(respuesta)
                    if(rept[0]["exito"]=='ok'){
                        $("#mensajedeexito").show(1500);
                            especialidad.ajax.reload(null,false);
                        setTimeout(function(){
                            $("#nombreEspecialidad").val("");
                            $("#detalleEspecialidad").val("");
                            $("#mensajedeexito").hide();  
                            $(".addEspecialidad").modal('hide');}, 3500);
                        $("#mensaje_exito").hide();
                    }else if(rept[0]["response"]=='no_ok'){
                        $("#mensaje_error").show(1500);
                        setTimeout(function(){ 
                            $("#nombreEspecialidad").val("");
                            $("#detalleEspecialidad").val("");
                            $("#mensaje_error").hide(); 
                            $(".addEspecialidad").modal('hide');}, 3500);

                    }
                }
            });
      }
    })
    
    /*
      * VALIDACION FORMULARIO ACTUALIZARESPECIALIDAD
      */     
    $('.ui.form.upd_especialidad')
    .form({
      fields: {
        upd_detalleEspecialidad   : 'empty',
      },
      onSuccess : function(e){
          e.preventDefault();
          var datos = new FormData();
            datos.append("idEspecialidad", $('#upd_idEspecialidad').val());
            datos.append("detalle", $("#upd_detalleEspecialidad").val());
            
          $.ajax({
                url: 'http://localhost/zeo/Controladores/MedicosControlador.php?medicoEspecialidades=ActualizarEspecialidad',
                type: 'POST',
                data: datos,
                cache: false,
                processData: false,
                contentType: false,
                success: function(respuesta){
                    rept = eval(respuesta)
                    if(rept[0]["exito"]=='ok'){
                        console.log(rept[0]["exito"])
                        $("#updmensajedeexito").show(2500);
                        setTimeout(function(){
                            especialidad.ajax.reload(null,false);
                            $("#updmensajedeexito").hide();  
                            $(".updEspecialidad").modal('hide');}, 3500);
                        $("#updmensajedeexito").hide();
                    }else {
                        $("#updmensaje_error").show(1500);
                        setTimeout(function(){ 
                            $("#updmensaje_error").hide(); 
                            $(".updEspecialidad").modal('hide');}, 3500);
                    }
                }
            });
      }
    })
    /*
      * VALIDACION FORMULARIO ACTUALIZARESPECIALIDAD
      */   
     
     $('#tblEspecialidad tbody').on( 'click', 'button', function () {
        var data = especialidad.row( $(this).parents('tr') ).data();
            //alert( data[0] );
            //console.log(data);return;
            $("#upd_idEspecialidad").val(data[3]);
            $("#upd_detalleEspecialidad").val(data[2]);
            $("#upd_nombreEspecialidad").val(data[1]);
            $(this).attr("idEspecialidadClick", data[3]);
            $(this).attr("idEspecialidadClick", data[3]);
            $(".updEspecialidad").modal('show')
            
    } );
});

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






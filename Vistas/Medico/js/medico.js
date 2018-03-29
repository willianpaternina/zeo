$(function(){     
    /*
     * CALENDARIO VISTA INICIO MEDICO
     */
    $('#calendar').fullCalendar({
        header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,basicWeek'
      },
      defaultDate: horaActual(),
        defaultView: 'month',  
        navLinks: true, // can click day/week names to navigate views
        editable: true,
        events: {
             type: 'POST',
             cache: false,
             data: {
               citaMedica: ""
             },
             url: 'http://localhost/zeo/Controladores/MedicosControlador.php',
             error: function(response) {
                console.log(response)
              },
             
          },
  })
  var auxiliares = $('#tblAuxiliares').DataTable({
        "ajax": 'http://localhost/zeo/Controladores/MedicosControlador.php?medicoEspecialidades=listarAuxiliaresMedico',
         "columnDefs": [ {
            "targets": -1,
            "data": null,
            "defaultContent": "<button class='ui mini button btnEditarAuxiliar' >Editar!</button> <button class='ui mini button btnVerAuxiliar'>ver!</button>",
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
    
    $('#tblAuxiliares tbody').on( 'click', 'button.btnEditarAuxiliar', function () {
        var data = auxiliares.row( $(this).parents('tr') ).data();
            //alert( data[0] );
            console.log(data);return;
            
            
    } );
    
    $('#tblAuxiliares tbody').on( 'click', 'button.btnVerAuxiliar', function () {
        var data = auxiliares.row( $(this).parents('tr') ).data();
            //alert( data[0] );
            console.log(data);return;
            
            
    } );
    /*
      * VALIDACION FORMULARIO ADDAUXILIAR
      */     
    $('.ui.form.auxiliar')
    .form({
      fields: {
        nombre     : 'empty',
        /*tident   : 'empty',
        identificacion : ['minLength[4]', 'empty'],
        apellido : ['minLength[3]', 'empty'],
        genero   : 'empty',
        fechanac    : 'empty',
        tiposangre : 'empty',
        ocupacion : 'empty',
        email: 'empty',
        clave: ['minLength[4]', 'empty']*/
      },
      onSuccess : function(e){
          e.preventDefault();
          var datos = new FormData();
              datos.append("tipo_ident", $("#tipo_ident").val());
              datos.append("identificacion", $("#identificacion").val());
              datos.append("nombre", $("#nombre").val());
              datos.append("apellido", $("#apellido").val());
              datos.append("apellidocasado", $("#apellidocasado").val());
              datos.append("genero", $("#genero").val());
              datos.append("fechanac", $("#fechanac").val());
              datos.append("tiposangre", $("#tiposangre").val());
              datos.append("telefono", $("#telefono").val());
              datos.append("celular", $("#celular").val());
              datos.append("estadocivil", $("#estadocivil").val());
              datos.append("ocupacion", $("#ocupacion").val());
              datos.append("religion", $("#religion").val());
              datos.append("pais", $("#pais").val());
              datos.append("departamento", $("#departamento").val());
              datos.append("municipio", $("#municipio").val());
              datos.append("domicilio", $("#domicilio").val());
              datos.append("email", $("#email").val());
              datos.append("clave", $("#clave").val());
              datos.append("medicoEspecialidades", "registrarAuxiliarMedico");
              


                $.ajax({
                    url: 'http://localhost/zeo/Controladores/MedicosControlador.php',
                    type: 'POST',
                    data: datos,
                    cache: false,
                    processData: false,
                    contentType: false,
                    success: function(respuesta){
                        rept = eval(respuesta)
                        if(rept[0]["exito"]=='ok'){
                            //mensaje exito
                            alert("Los datos se guardaron de manera exitosa")
                            //actualizar data
                            auxiliares.ajax.reload(null,false);
                            //limpiar campos
                            $(".ui.form.auxiliar")[0].reset();
                            //cerrar ventana modal
                            $(".addAuxiliar").hide();
                            
                        }else if(rept[0]["response"]=='no_ok'){
                             //mensaje exito
                            alert("El tipo y numero de identificacion ya se encuentran registrados, por favor, cambielos")
                            //actualizar data
                            auxiliares.ajax.reload(null,false);

                        }
                    }
                });
      }
    })    
})


/*
 * FUNCION RETORNA HORA ACTUAL, SE UTILIZA EN EL CALENDARIO
 */
var horaActual = function(){
    var hoy = new Date();
    var dd = hoy.getDate();
    var mm = hoy.getMonth()+1; //hoy es 0!
    var yyyy = hoy.getFullYear();

    if(dd<10) {
        dd='0'+dd
    } 

    if(mm<10) {
        mm='0'+mm
    } 

    hoy = mm+'/'+dd+'/'+yyyy;
    return hoy

}
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




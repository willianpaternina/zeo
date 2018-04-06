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
        eventClick: function(calEvent, jsEvent, view){
            //alert(calEvent.id);
            $("#nombrePaciente").html(calEvent.title)
            $(".cambiarEstado").modal("show")
            $("#_btnActualizarEstado").on("click", function(){
                    
                    var datos = new FormData();
                        datos.append("idCita", calEvent.id);
                        datos.append("estado", $("#estado").val());
                        datos.append("actualizarEstado", "estado");

                    $.ajax({
                        url: 'http://localhost/zeo/Controladores/MedicosControlador.php',
                        type: 'POST',
                        data: datos,
                        cache: false,
                        processData: false,
                        contentType: false,
                        success: function(respuesta){
                            var rept = eval(respuesta)
                            if(rept[0]["exito"]=='ok'){
                                alert("Estado actualizado con exito!!!");
                                $(".cambiarEstado").modal("hide");
                                $('#calendar').fullCalendar('refetchEvents');
                            }
                        }
                    });
                })
        },
  })
  var auxiliares = $('#tblAuxiliares').DataTable({
        "ajax": 'http://localhost/zeo/Controladores/MedicosControlador.php?medicoEspecialidades=listarAuxiliaresMedico',
         "columnDefs": [ {
            "targets": -1,
            "data": null,
            "defaultContent": "<button class='ui mini blue button btnEditarAuxiliar' ><i class='edit icon'></i></button> <button class='ui mini blue button btnVerAuxiliar'><i class='eye icon'></i></button>",
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
           
            $("._editAuxiliar").modal("show");
            var datos = new FormData();
              datos.append("idAuxiliar", data[5]);
              datos.append("medicoEspecialidades", "listarAuxiliaresPorId");

                $.ajax({
                    url: 'http://localhost/zeo/Controladores/MedicosControlador.php',
                    type: 'POST',
                    data: datos,
                    cache: false,
                    processData: false,
                    contentType: false,
                    success: function(respuesta){
                       
                        rept = eval(respuesta)
                        $("#edit_IdAuxiliar").val(rept[0].idAuxiliar)
                        $("#edit_NombreAuxiliar").html(rept[0].nombre +" "+rept[0].apellido);
                        $("#edit_identificacion").val(rept[0].tipoidentificacion +" "+rept[0].identificacion);
                        $("#edit_nombre").val(rept[0].nombre);
                        $("#edit_apellido").val(rept[0].apellido);
                        $("#edit_apellidocasado").val(rept[0].apellidocasada);
                        $("#edit_genero").val(rept[0].genero);
                        $("#edit_fechanac").val(rept[0].fechanacimiento);
                        $("#edit_tiposangre").val(rept[0].tiposangre);
                        $("#edit_telefono").val(rept[0].telefono);
                        $("#edit_celular").val(rept[0].celular);
                        $("#edit_estadocivil").val(rept[0].estadocivil);
                        $("#edit_ocupacion").val(rept[0].ocupacion);
                        $("#edit_religion").val(rept[0].religion);
                        $("#edit_pais").val(rept[0].pais);
                        $("#edit_departamento").val(rept[0].departamento);
                        $("#edit_municipio").val(rept[0].municipio);
                        $("#edit_domicilio").val(rept[0].domicilio);
                        $("#edit_email").val(rept[0].email);
                        $("#edit_estado").val(rept[0].estado);
                        $("#edit_clave").val(rept[0].clave);
                    }
                }); 
    } );
    
    $('#tblAuxiliares tbody').on( 'click', 'button.btnVerAuxiliar', function () {
        var data = auxiliares.row( $(this).parents('tr') ).data();
            //alert( data[0] );
            $(".verAuxiliar").modal("show")
            
            var datos = new FormData();
              datos.append("idAuxiliar", data[5]);
              datos.append("medicoEspecialidades", "listarAuxiliaresPorId");

                $.ajax({
                    url: 'http://localhost/zeo/Controladores/MedicosControlador.php',
                    type: 'POST',
                    data: datos,
                    cache: false,
                    processData: false,
                    contentType: false,
                    success: function(respuesta){
                       
                        rept = eval(respuesta)
                        
                        $("#datosDelAuxiliar").html(rept[0].nombre +" "+rept[0].apellido);
                        $("#ver_identificacion").val(rept[0].tipoidentificacion +" "+rept[0].identificacion);
                        $("#ver_nombre").val(rept[0].nombre);
                        $("#ver_apellido").val(rept[0].apellido);
                        $("#ver_apellidocasado").val(rept[0].apellidocasada);
                        $("#ver_genero").val(rept[0].genero);
                        $("#ver_fechanac").val(rept[0].fechanacimiento);
                        $("#ver_tiposangre").val(rept[0].tiposangre);
                        $("#ver_telefono").val(rept[0].telefono);
                        $("#ver_celular").val(rept[0].celular);
                        $("#ver_estadocivil").val(rept[0].estadocivil);
                        $("#ver_ocupacion").val(rept[0].ocupacion);
                        $("#ver_religion").val(rept[0].religion);
                        $("#ver_pais").val(rept[0].pais);
                        $("#ver_departamento").val(rept[0].departamento);
                        $("#ver_municipio").val(rept[0].municipio);
                        $("#ver_domicilio").val(rept[0].domicilio);
                        $("#ver_email").val(rept[0].email);
                        $("#ver_fecharegistro").val(rept[0].fecharegistro);
                        $("#ver_estado").val(rept[0].estado);
                    }
                }); 
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
                            $('.ui.form.auxiliar').form('reset')
                            //cerrar ventana modal
                            $(".addAuxiliar").modal('hide');
                            
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
    /*
      * VALIDACION FORMULARIO ADDAUXILIAR
      */     
    $('.ui.form.editAuxiliar')
    .form({
      fields: {
        edit_nombre     : 'empty',
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
          //alert("ok")
          var datos = new FormData();
              datos.append("idAuxiliar", $("#edit_IdAuxiliar").val());
              datos.append("nombre", $("#edit_nombre").val());
              datos.append("apellido", $("#edit_apellido").val());
              datos.append("apellidocasado", $("#edit_apellidocasado").val());
              datos.append("genero", $("#edit_genero").val());
              datos.append("fechanac", $("#edit_fechanac").val());
              datos.append("tiposangre", $("#edit_tiposangre").val());
              datos.append("telefono", $("#edit_telefono").val());
              datos.append("celular", $("#edit_celular").val());
              datos.append("estadocivil", $("#edit_estadocivil").val());
              datos.append("ocupacion", $("#edit_ocupacion").val());
              datos.append("religion", $("#edit_religion").val());
              datos.append("pais", $("#edit_pais").val());
              datos.append("departamento", $("#edit_departamento").val());
              datos.append("municipio", $("#edit_municipio").val());
              datos.append("domicilio", $("#edit_domicilio").val());
              datos.append("email", $("#edit_email").val());
              datos.append("clave", $("#edit_clave").val());
              datos.append("estado", $("#edit_estado").val());
              datos.append("medicoEspecialidades", "actualizarAuxiliar");

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
                            alert("Los datos se actualizaron de manera exitosa")
                            //actualizar data
                            auxiliares.ajax.reload(null,false);
                            //cerrar ventana modal
                            $("._editAuxiliar").modal('hide');
                            
                        }else{
                             //mensaje exito
                            alert("Los datos no pudieron ser actualizados, intente mas tarde.")
                            //actualizar data
                            auxiliares.ajax.reload(null,false);
                             $("._editAuxiliar").modal('hide');

                        }
                    }
                });
      }
    })
    
    
    var Horario = $('#tblHorario').DataTable({
        "ajax": 'http://localhost/zeo/Controladores/MedicosControlador.php?medicoEspecialidades=listarHorarioMedicoPorId',
         "columnDefs": [ {
            "targets": -1,
            "data": null,
            "defaultContent": "<button class='ui mini blue button btnEditarAuxiliar' ><i class='edit icon'></i></button>",
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
                "titleAttr": "Agregar horario",
                "className":"ui blue button",
                "action": function(){
                    selectConsultorios();
                  $(".addHorario").modal('show');
                
                }
            },
        ]
    });
    Horario.buttons().container().insertBefore('.botoneraexcelpdfauxiliares');
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

var selectConsultorios = function(){
    $.ajax({
    type: "GET",
    url: 'http://localhost/zeo/Controladores/MedicosControlador.php?medicoEspecialidades=listarConsultorios', 
    dataType: "json",
    success: function(data){
        $('#select_consultorio').html('');
        //console.log(data);return;
      $("#select_consultorio").append('<option value=0>SELECCIONE</option>');  
      $.each(data,function(key, registro) {
        $("#select_consultorio").append('<option value='+registro.idConsultorio+'>'+registro.nombre+'</option>');
      });        
    },
    error: function(data) {
      alert('error');
    }
  });
}



$(function(){   
    
    $("#back").on("click", function(){
        $(".medicos").show(500);
        $(".horario").hide(1500);
        $('#calendar').fullCalendar('destroy');
        $("#motivoCitaMedida").val("")
    })
    var citasActivas = $('#tblCitasActivas').DataTable({
        "ajax": 'http://localhost/zeo/Controladores/PacientesControlador.php?listarCitas=listar',
         "columnDefs": [ {
            "targets": -1,
            "data": null,
            "defaultContent": "<button class='ui mini red button btnCancelarCita' ><i class='delete icon'></i></button> "
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
    citasActivas.buttons().container().insertBefore('.botoneraexcelpdfauxiliares');
    $('#tblCitasActivas tbody').on( 'click', 'button.btnCancelarCita', function () {
        var data = citasActivas.row( $(this).parents('tr') ).data();
        if(confirm("¿Desea cancelar la cita?")){
            //return;
            var datos = new FormData();
                datos.append("idCita", data[6]);
                datos.append("estado", "CANCELADO_USUARIO");
                datos.append("actualizarEstadoCita", "update");

            $.ajax({
                "destroy":true,
                url: 'http://localhost/zeo/Controladores/PacientesControlador.php',
                type: 'POST',
                data: datos,
                cache: false,
                processData: false,
                contentType: false,
                success: function(respuesta){
                    var rept = eval(respuesta)
                    if(rept[0]["exito"]=='ok'){
                        alert("cita cancelada exitosamente");
                        citasActivas.ajax.reload(null,false);
                        return;
                    }
                }
            });
        }
       
    })
    
    var citasRealizadas = $('#tblCitasRealizadas').DataTable({
        "ajax": 'http://localhost/zeo/Controladores/PacientesControlador.php?listarCitasRealizadas=listar',
         "columnDefs": [ {
            "targets": -1,
            "data": null,
            "defaultContent": "<button class='ui mini blue button btnverActividad' ><i class='eye icon'></i></button> <button class='ui mini green button btnVerMedicamentos' ><i class='eye icon'></i></button> "
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
    citasRealizadas.buttons().container().insertBefore('.botoneraexcelpdfauxiliares');
    
    $('#tblCitasRealizadas tbody').on( 'click', 'button.btnverActividad', function () {
        var data = citasRealizadas.row( $(this).parents('tr') ).data();
        $(".verActividades").modal("show")
        var verActividadPaciente = $('#tblActividadesPacientes').DataTable({
            "destroy":true,
            "ajax": 'http://localhost/zeo/Controladores/PacientesControlador.php?listarActividades=listar&idPaciente='+data[6],
            "language": idioma_espanol,
            "aaSorting": [[0, "desc"]],
            "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "todos"]],
            
        });
        verActividadPaciente.buttons().container().insertBefore('.botoneraexcelpdfauxiliares');
       
    })
})

var horario = function(id_medico, id_especialidad){
    
    $(".medicos").hide(1500);
    $(".horario").show();
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
               idMedico: id_medico,
               idEspecialidad: id_especialidad
             },
             url: 'http://localhost/zeo/Controladores/MedicosControlador.php',
             error: function(response) {
                console.log(response)
              },
             
          },
          eventClick: function(calEvent, jsEvent, view) {
                $(".confirmar_cita").modal('show');
                $(".confirmar_cita").modal({
                    closable: true
                });
                var id_horario = calEvent.id;
                var id_paciente = $("#btnhorario").val();
                var estado = "ESPERA_ATENCION";
                $("#_btnGuardarCita").on("click", function(){
                    if($("#_motivoCitaMedica").val() == ""){
                        $("#_motivoCitaMedica").focus();
                        alert("Debes ingresar un motivo de consulta \n  Es super importante para tu medico!!!");
                        return;
                    }
                    var datos = new FormData();
                        datos.append("id_horario", id_horario);
                        datos.append("id_paciente", id_paciente);
                        datos.append("concepto", $("#_motivoCitaMedica").val());
                        datos.append("estado", estado);
                        datos.append("registrarCita", "si");
                    

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
                                $("#mensajedeexito").show(1500);
                                setTimeout(function(){
                                    $("#_motivoCitaMedica").val("");
                                    $("#mensajedeexito").hide();  
                                    $(".confirmar_cita").modal('hide');}, 3500);
                                $("#mensaje_exito").hide();
                            }else if(rept[0]["response"]=='no_ok'){
                                $("#mensaje_error").show(1500);
                                setTimeout(function(){ 
                                    $("#_motivoCitaMedica").val("");
                                    $("#mensaje_error").hide(); 
                                    $(".confirmar_cita").modal('hide');}, 3500);
                                
                            }
                        }
                    });
                })

          }
    });
    
}

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
    
 /*
  * VENTANA MODAL CITAS
  */
 $(".abrir_modal").on("click", function () {
    $(".confirmar_cita").modal('show');
    $(".confirmar_cita").modal({
        closable: true
    });
});




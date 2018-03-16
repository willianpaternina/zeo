/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(function(){   
    
    $("#back").on("click", function(){
        $(".medicos").show(500);
        $(".horario").hide(1500);
        $('#calendar').fullCalendar('destroy');
        $("#motivoCitaMedida").val("")
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
                 //alert('there was an error while fetching events!');
              },
             
          },
          eventClick: function(calEvent, jsEvent, view) {
                $(".confirmar_cita").modal('show');
                $(".confirmar_cita").modal({
                    closable: true
                });
            console.log('Event: ' + calEvent.id + 'Id_paciente: ' + $("#btnhorario").val() );
            return;

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

$("#_btnGuardarCita").on("click", function(){
    alert("guardar cita XD")
})

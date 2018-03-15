/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(function(){   
    
    $("#back").on("click", function(){
        $(".medicos").show();
        $(".horario").hide();
        $('#calendar').fullCalendar('destroy');
        $('#calendar').fullCalendar('destroy');
    })
    
})

var horario = function(id_medico){
     
    $(".medicos").hide();
    $(".horario").show();
    $('#calendar').fullCalendar({
        header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,basicWeek'
      },
        defaultDate: horaActual(),
        defaultView: 'month',
        events: {
             type: 'POST',
             cache: false,
             data: {
               idMedico: id_medico  
             },
             url: 'http://localhost/zeo/Controladores/MedicosControlador.php',
             error: function(response) {
                console.log(response)
                 //alert('there was an error while fetching events!');
              },
             
          },         
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
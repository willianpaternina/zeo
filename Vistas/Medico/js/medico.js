$(function(){
     /*
      * VALIDACION FORMULARIO ADDAUXILIAR
      */     
    $('.ui.form.auxiliar')
    .form({
      fields: {
        nombre     : 'empty',
        tident   : 'empty',
        identificacion : ['minLength[4]', 'empty'],
        apellido : ['minLength[3]', 'empty'],
        genero   : 'empty',
        fechanac    : 'checked',
        tiposangre : 'empty',
        ocupacion : 'empty',
        religion : 'empty',
        email: 'empty',
        clave: ['minLength[4]', 'empty']
      },
      onSuccess : function(e){
          e.preventDefault();
          alert("tofo ok");
      }
    })    
     
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



$(document).ready(function () {    
    var paciente = $('#tblPaciente').DataTable({
        "language": {
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
        },
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
        "language": {
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
        },
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
    
});






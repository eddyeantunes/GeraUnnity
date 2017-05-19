var tipo_senha="${tipo_senha}"
var tipo_senhaarray = tipo_senha.split(',');
var valor = "${valores}";
var valorarray = valor.split(',').map(function(i){
    return parseInt(i, 10);
});
var chart = Highcharts.chart('Grafico', {

	title: {
        text: 'Demandas de Alunos'
    },

    yAxis: [{
        title: {
            text: ''
        }
    }],
    tooltip: {
        shared: true,
        valueSuffix: ' vez'
    },
    xAxis: {
        categories: tipo_senhaarray
    },

    series: [{
    	
    	name:"Solicitado",
        type: 'column',
        colorByPoint: true,
        data: valorarray,
        showInLegend: false
    }]

});


$('#plain').click(function () {
    chart.update({
        chart: {
            inverted: false,
            polar: false
        }
      
    });
});

$('#inverted').click(function () {
    chart.update({
        chart: {
            inverted: true,
            polar: false
        }
    });
});



<%@page import="java.sql.Date"%>
<%@page import="br.com.geraunity.model.Senha"%>
<%@page import="java.util.List"%>
<%@page import="br.com.geraunity.servicos.SenhaServicos"%>
<div id="erros"></div>
<div class="corpo">

<input type="button" id="plain" value="Plano">
<input type="button" id="inverted" Value="lateral">
	<div id="Grafico" style="min-width: 310px; width: 100%;"></div>
</div>
<script src="js/highui.js"></script>

<script type="text/javascript">
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


window.onbeforeunload = function() {
	<%request.getSession().removeAttribute("valores");%>

	<%request.getSession().removeAttribute("tipo_senha");%>
};

</script>
<script>
$(document).ready(function() {
	
	if("${erro}" != ""){
		  $('#erros').append( "<div class='alert erro'><span class='closebtn'>&times;</span> ${erro}</div>  <%request.getSession().removeAttribute("erro");%>");
		  
		 }else if("${alerta}" != ""){
			 $('#erros').append( "<div class='alert alerta'><span class='closebtn'>&times;</span> ${alerta}</div>  <%request.getSession().removeAttribute("alerta");%>");
		 }else if("${sucesso}" != ""){
			 $('#erros').append( "<div class='alert sucesso'><span class='closebtn'>&times;</span> ${sucesso}</div>  <%request.getSession().removeAttribute("sucesso");%>");
						}

						$('.closebtn').on('click', function() {
							$('.alert').remove();
						});
						$('.alert').delay(3000).fadeOut(2000);

					});
	$(function() {
		$('#formGrafico').on(
				'submit',
				function() {
					checkURL();
					carregarPag("#SenhaController?acao=demanda", $(
							'#formGrafico').serialize());

				});
	});
</script>
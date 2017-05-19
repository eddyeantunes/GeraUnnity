<%@page import="java.sql.Date"%>
<%@page import="br.com.geraunity.model.Senha"%>
<%@page import="java.util.List"%>
<%@page import="br.com.geraunity.servicos.SenhaServicos"%>
<div id="erros"></div>
<div class="corpo">
	<div id="Grafico" style="min-width: 310px; width: 100%;"></div>
</div>

<script src="js/highui.js"></script>
<script type="text/javascript">

	var xAxis, series;

	xAxis = {
		categories : [ 'Dias Atendidos' ]
	};
	series = [ {
		name : 'Janeiro',
		data : [ 2, 5, 6, 7, 8 ],
		pointStart : 1
	} ];
	var datas = "${datas}";
	
	var datasarray = datas.split(',');
	var valor = "${valores}";
	var valorarray = valor.split(',').map(function(i){
	    return parseInt(i, 10);
	});
	var valornao = "${valoresnao}";
	
	var valornaoarray = valornao.split(',').map(function(i){
	    return parseInt(i, 10);
	});
	$(function() {
		Highcharts
				.chart(
						'Grafico',
						{
							chart : {
								type : 'areaspline'
							},
							title : {
								text : 'Atendimento de Aluno'
							},
							legend : {
								layout : 'vertical',
								align : 'left',
								verticalAlign : 'top',
								x : 150,
								y : 100,
								floating : true,
								borderWidth : 1,
								backgroundColor : (Highcharts.theme && Highcharts.theme.legendBackgroundColor)
										|| '#FFFFFF'
							},
							xAxis : {
								categories : datasarray
							},
							yAxis : {
								title : {
									text : 'Atendimento de Alunos'
								}
							},
							tooltip : {
								shared : true,
								valueSuffix : ' alunos'
							},
							credits : {
								enabled : false
							},
							plotOptions : {
								areaspline : {
									fillOpacity : 0.5
								}
							},
							series : [ {
								name : 'Atendidos',
								data : valorarray
							}, {
								name : 'Não Atendidos',
								data : valornaoarray
							}]
						});
	});
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
					carregarPag("#SenhaController?acao=estatistica", $(
							'#formGrafico').serialize());

				});
	});
</script>
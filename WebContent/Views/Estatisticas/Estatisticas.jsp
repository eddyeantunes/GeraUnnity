<%@page import="java.sql.Date"%>
<%@page import="br.com.geraunity.model.Senha"%>
<%@page import="java.util.List"%>
<%@page import="br.com.geraunity.servicos.SenhaServicos"%>
<div id="erros"></div>
<div class="corpo">
	<div class="formulariosCad">
		<form id="formGrafico" method="post"
			onsubmit="return false;">

			<span>Selecione o Mês :</span>
			<p><select name="mes">

				<%
					SenhaServicos senhaservicos = new SenhaServicos();

					List<String> listames = senhaservicos.ListarMes();

					//Retorna todos os mes do banco de dados.
					for (String mes : listames) {
				%>
				
				<option><%=mes%></option>
				<%
					}
				
				%>
			</select>
			</p> 
			<span>Qual gráfico deseja :</span>
			<p>
			<select name="tipo">
			<option>Demanda</option>
			<!-- <option>Atendimendo</option>  // TIREI POR QUE TA DANDO ERRO --'-->
			</select>
			</p>
			<input type="submit" value="Visualizar">
		</form>
	</div>	
</div>
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
					carregarPag("#SenhaController?acao=grafico", $(
							'#formGrafico').serialize());

				});
	});
</script>
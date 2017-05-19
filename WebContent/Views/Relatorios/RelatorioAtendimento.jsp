<%@page import="br.com.geraunity.model.Senha"%>
<%@page import="br.com.geraunity.servicos.SenhaServicos"%>
<%@ include file="../Conexao/VerConect.jsp"%>
<%@page import="java.util.List"%>
<%@page import="br.com.geraunity.servicos.AlunoServices"%>
<%@page import="br.com.geraunity.model.Funcionario"%>
<%@page import="br.com.geraunity.model.Aluno"%>
<div id="erros"></div>

<div class="corpo">
	<div class="headerMenu">
		<h1>Relatório do Atendimento (Aluno)</h1>
	</div>
	
	<table>
		<tr>
			<td><b>Nome Completo</b></td>
			<td><b>CPF</b></td>
			<td><b>Email</b></td>
			<td><b>Data</b></td>
			<td><b>Compareceu?</b></td>
			<td><b>Solucionado?</b></td>
			<td><b>Solicitação</b></td>
			<td><b>Atendido?</b></td>
		</tr>
		<%
		SenhaServicos senhaservicos = new SenhaServicos();
		AlunoServices alunoservicos = new AlunoServices();
		Aluno alun = new Aluno();
		List<Senha> listaSenhaa = senhaservicos.ListarAtendimento();
		for (Senha a : listaSenhaa) {
	alun=alunoservicos.pegaAluno(a.getAluno_CPF());
		
	%>
		<tr>
			<td><%=alun.getAluno_Nome()%></td>
			<td><%=a.getAluno_CPF()%></td>
			<td><%=alun.getAluno_Email()%></td>
			
			<td><%=a.getData()%></td>
			<td><%=a.getCompareceu()%></td>
			<td><%=a.getSolucionado()%></td>
			<td><%=a.getTipo_Senha()%></td>
			<td><%=a.getSenha_Situacao()%></td>
		
		</tr>
		<%
		}
	%>
	</table>
</div>
<script type="text/javascript">
$(document).ready(function() {

	if("${erro}" != ""){
		  $('#erros').append( "<div class='alert erro'><span class='closebtn'>&times;</span> ${erro}</div>  <%request.getSession().removeAttribute("erro");%>");
		  
		 }else if("${alerta}" != ""){
			 $('#erros').append( "<div class='alert alerta'><span class='closebtn'>&times;</span> ${alerta}</div>  <%request.getSession().removeAttribute("alerta");%>");
		 }else if("${sucesso}" != ""){
			 $('#erros').append( "<div class='alert sucesso'><span class='closebtn'>&times;</span> ${sucesso}</div>  <%request.getSession().removeAttribute("sucesso");%>
	");
						}

						$('.closebtn').on('click', function() {
							$('.alert').remove();
						});
						$('.alert').delay(3000).fadeOut(2000);

					});
</script>

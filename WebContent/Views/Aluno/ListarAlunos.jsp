<%@ include file="../Conexao/VerConect.jsp"%>
<%@page import="java.util.List"%>
<%@page import="br.com.geraunity.servicos.AlunoServices"%>
<%@page import="br.com.geraunity.model.Funcionario"%>
<%@page import="br.com.geraunity.model.Aluno"%>
<div id="erros"></div>

<div class="corpo">
<div class="headerMenu">
	<h1>Alunos cadastrados no banco de dados</h1>
</div>
<div class="botao">
	<a href="#Views/Aluno/CadastrarAluno.jsp">Cadastrar Aluno</a>
</div>
<table>
	<tr>
		<td><b>Id</b></td>
		<td><b>Nome Completo</b></td>
		<td><b>Email</b></td>
		<td><b>CPF</b></td>
		<td><b>Opções</b></td>
	</tr>
	<%
		AlunoServices alunoservicos = new AlunoServices();
		List<Aluno> listaaluno = alunoservicos.ListarAlunos();
		for (Aluno a : listaaluno) {
	%>
	<tr>
		<td><%=a.getAluno_Id()%></td>
		<td><%=a.getAluno_Nome()%></td>
		<td><%=a.getAluno_Email()%></td>
		<td><%=a.getAluno_CPF()%></td>
		<td><span style="width: 70px; text-align: center;"><a
				href="#Views/Aluno/EditarAluno.jsp?idAluno=<%=a.getAluno_Id()%>"><img
					src="imgs/editar.png" /></a></span> <span
			style="width: 70px; text-align: center;"><a
				href="#AlunoController?acao=deletar&idAluno=<%=a.getAluno_Id()%>"><img
					src="imgs/deletar.png" /></a></span></td>
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
			 $('#erros').append( "<div class='alert sucesso'><span class='closebtn'>&times;</span> ${sucesso}</div>  <%request.getSession().removeAttribute("sucesso");%>");
						}

						$('.closebtn').on('click', function() {
							$('.alert').remove();
						});
						$('.alert').delay(3000).fadeOut(2000);

					});
</script>

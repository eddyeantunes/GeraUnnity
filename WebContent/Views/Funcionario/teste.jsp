<%@page import="br.com.geraunity.servicos.FuncionarioServices"%>
<%@ include file="../Conexao/VerConect.jsp"%>
<%@page import="java.util.List"%>
<div id="erros"></div>
<div class="corpo">
<div class="headerMenu">
	<h1>Funcionários</h1>
</div>
<div class="botao">
<a href="#Views/Funcionario/CadastrarFunc.jsp" >Cadastrar Funcionário</a></div>
<table>
<tr>
<td><b>Id</b></td>
<td><b>Nome Completo</b></td>
<td><b>Email</b></td>
<td><b>Tipo</b></td>
<td><b>Opções</b></td>
</tr>
	<%
		FuncionarioServices funcionarioservicos = new FuncionarioServices();
		List<Funcionario> listaFuncionario = funcionarioservicos.ListarFuncionarios();
		for (Funcionario func : listaFuncionario) {
	%>
	<tr>
		<td><%=func.getFuncionario_Id()%></td>
		<td><%=func.getFuncionario_Nome()%></td>
		<td><%=func.getFuncionario_Email()%></td>
		<td><%=func.getFuncionario_Tipo()%></td>
		<td>
		<span style="width:70px; text-align:center;"><a href="#Views/Funcionario/EditarFuncionario.jsp?idFuncionario=<%=func.getFuncionario_Id()%>"><img src="imgs/editar.png"/></a></span>
		<span style="width:70px; text-align:center;"><a href="#FuncionarioController?acao=deletar&idFuncionario=<%=func.getFuncionario_Id()%>"><img src="imgs/deletar.png"/></a></span>
		</td>
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


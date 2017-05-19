<%@page import="br.com.geraunity.hibernate.HibernateUtil"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.Session"%>
<%@ include file="../Conexao/VerConect.jsp"%>
<div id="erros"></div>
<div class="corpo">
<div class="headerMenu">
	<h1>Editar Aluno</h1>
</div>
<div class="formulariosCad">
<%
    int idFuncionario = 	Integer.parseInt(request.getParameter("idFuncionario"));

	Session sessao = HibernateUtil.pegaConecta().openSession();
	Funcionario func = null;
	Transaction tx = null;
	try{
	
		tx = sessao.getTransaction();
		tx.begin();
		func = (Funcionario)sessao.load(Funcionario.class, idFuncionario);
		
	
%>
	<form method="post" id="formEditFunc" action="#" onsubmit="return false">
		<p> <span>Id do Aluno </span><input type="text" name="idFuncionario" value="<%=idFuncionario%>" readonly/>
		
		</p>
		<p>
			<span>Nome Completo</span><input type="text" name="nomeFuncionario"
				placeholder="Digite o nome do aluno..." maxlength="50" value="<%=func.getFuncionario_Nome()%>">
		</p>
		<p>
			<span>Email</span><input type="email" name="emailFuncionario"
				placeholder="Digite o email do aluno..." maxlength="50" value="<%=func.getFuncionario_Email()%>">
		</p>
		<p>
			<span>CPF</span><input type="text" class="cpf" name="cpfFuncionario"
				placeholder="Digite o cpf do aluno..." value="<%=func.getFuncionario_CPF()%>">
		</p>
		<p>
			<span>Senha</span><input type="password" name="senhaFuncionario"
				placeholder="Digite a senha do aluno... "value="<%=func.getFuncionario_Password()%>">
		</p>
		<p>
			<span>Tipo de Funcionário</span><select name="tipoFunc">
			<option>Normal</option>
			<option>Administrador</option>
			</select>
				
		</p>
		<input type="submit" value="Editar"  /> 
	</form>
	<div class="clear"></div>
</div>
</div>
<%
	}catch(Exception e){
		if(tx != null){
			tx.rollback();
		}
		e.printStackTrace();
	}finally{
		sessao.close();
	}
%>
<script src="js/jquerymask.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('.cpf').mask("000.000.000-00");
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
		$('#formEditFunc').on(
				'submit',
				function() {
					checkURL();
					carregarPag("#FuncionarioController?acao=editar", $(
							'#formEditFunc').serialize());

				});
	});
</script>
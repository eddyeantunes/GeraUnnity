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
    int alunoId = 	Integer.parseInt(request.getParameter("idAluno"));

	Session sessao = HibernateUtil.pegaConecta().openSession();
	Aluno alu = null;
	Transaction tx = null;
	try{
	
		tx = sessao.getTransaction();
		tx.begin();
		alu = (Aluno)sessao.load(Aluno.class, alunoId);
		
	
%>
	<form method="post" id="formEditAluno" action="#" onsubmit="return false">
		<p> <span>Id do Aluno </span><input type="text" name="idAluno" value="<%=alunoId%>" readonly/>
		
		</p>
		<p>
			<span>Nome Completo</span><input type="text" name="nomeAluno"
				placeholder="Digite o nome do aluno..." maxlength="50" value="<%=alu.getAluno_Nome()%>">
		</p>
		<p>
			<span>Email</span><input type="email" name="emailAluno"
				placeholder="Digite o email do aluno..." maxlength="50" value="<%=alu.getAluno_Email()%>">
		</p>
		<p>
			<span>CPF</span><input type="text" class="cpf" name="cpfAluno"
				placeholder="Digite o cpf do aluno..." value="<%=alu.getAluno_CPF()%>">
		</p>
		<p>
			<span>Senha</span><input type="password" name="senhaAluno"
				placeholder="Digite a senha do aluno... "value="<%=alu.getAluno_Password()%>">
		</p>
		<input type="submit" value="Editar"  /> 
	</form>
	<div class="clear"></div>
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

</div>
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
		$('#formEditAluno').on(
				'submit',
				function() {
					checkURL();
					carregarPag("#AlunoController?acao=editar", $(
							'#formEditAluno').serialize());

				});
	});
</script>
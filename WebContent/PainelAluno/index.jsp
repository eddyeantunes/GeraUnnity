<%@page import="java.util.Locale"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Gera Unity - Gerador de Senhas para entidades de ensino</title>
<link rel="stylesheet" type="text/css" href="../css/stylePainel.css" />
</head>
<body>
	<div id="erros"></div>

	<div class="container">
		<div class="formulariosCad"
			style="display: block; margin: 20px auto; max-width: 500px; background: #fff; border-radius: 10px; padding: 20px;">
			<div class="headerMenu">
				<h1>Pedido de senha</h1>
			</div>
			<form style="margin-top: 10px;"
				action="../SenhaController?acao=cadsenha" method="post">
				<p>
					<span>CPF:</span> <input type="text" name="alunoCPF" class="cpf">
				</p>
				<p>
					<span>Tipo de Atendimento:</span> <select name="tipoAtendimento">
						<option>2ª Via de Boleto</option>
						<option>Fies</option>
						<option>Problemas ao Acessar portal</option>
						<option>Problemas com curso</option>
						<option>Cancelamento de mátricula</option>
						<option>Trancamento de curso</option>
					</select>
				</p>
				<p
					style="width: 100%; text-align: center; margin: initial !important">
					<input type="submit" value="GerarSenha"> <input
						type="reset" value="Limpar">
				</p>
			</form>

		</div>

		<div class="clear"></div>
	</div>
	<div class="container">
		<div class="formulariosCad"
			style="display: block; margin: 20px auto; max-width: 500px; background: #fff; border-radius: 10px; padding: 20px;">
			<div class="headerMenu">
				<h1>Ultima Senha Solicitada</h1>
			</div>
			<div style="margin-top:10px; ">
			<p><b>Aluno Solicitante:</b> ${NomeAluno}</p>
			<p><b>Senha Solicitada:</b> ${Senha}</p>
			<%request.getSession().removeAttribute("NomeAluno");%>
			<%request.getSession().removeAttribute("Senha");%>
			</div>
		</div>

		<div class="clear"></div>
	</div>
	<script src="../js/jquery.js"></script>
	<script src="../js/jquerymask.js"></script>
	<script>
    $(document).ready(function(){
    	  $('.cpf').mask('000.000.000-00');
    	  
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

		$('.tabs').on(
				'click',
				'li a',
				function() {
					$('.active').removeClass('active');
					$(this).addClass('active');

					$('.show').removeClass('show').addClass('hide').hide();

					$($(this).attr('href')).removeClass('hide')
							.addClass('show').hide().fadeIn(550);
				});
		$('.closebtn').on('click', function() {
			$('.alert').hide();
		});
	</script>
</body>
</html>
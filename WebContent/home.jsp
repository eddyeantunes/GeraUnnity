<%@include file="Views/Conexao/VerConect.jsp" %>
<%@page import="br.com.geraunity.model.Funcionario"%>
<%@page import="java.util.List"%>
<%@page import="br.com.geraunity.servicos.AlunoServices"%>
<%@page import="br.com.geraunity.model.Aluno"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/stylePainel.css" />
<title>GeraUnity - Seu Atendimento</title>
<link rel="shortcut icon" href="imgs/favicon.png" />
</head>
<body>

	<div class="menu_header container">
		<div class="content">

			<nav>
				<ul>
					<li><a href="#Views/home.jsp">Home</a></li>
					<li><a href="<%if (funcOnline) {
				out.println("#Views/Relatorios/RelatorioAtendimento.jsp");
			} else {
				out.println("#Views/Relatorios/RelatorioAtendimentoAluno.jsp");
			}%>">Relatórios de Atendimento</a></li>
					<%
						if (funcOnline == true && funcionario.getFuncionario_Tipo().equals("Administrador")) {
					%>
					<li><a href="#Views/Estatisticas/Estatisticas.jsp">Estatísticas</a></li>
					<li><a href="#Views/Aluno/ListarAlunos.jsp">Alunos</a></li>
					<li><a href="#Views/Funcionario/ListarFuncionarios.jsp">Funcionários</a></li>
					<%
						}
					%>
					<li><a
						href="<%if (funcOnline) {
				out.println("FuncionarioController?acao=sair");
			} else {
				out.println("AlunoController?acao=sair");
			}%>">Sair</a></li>
				</ul>
			</nav>
			<div class="clear"></div>
		</div>
	</div>

	<div class="container">
		<div class="content">
			<div id="carregaajax">
			<div class="clear"></div>
			</div>
		</div>
	</div>


	<script type="text/javascript" src="js/jquery.js"></script>
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

							carregarPag("#Views/home.jsp");
							checkURL(); // checa se a URL contém hash

							$('.menu_header a').click(function(e) {
								checkURL(this.hash);
							});

							setInterval("checkURL()", 250);

						});

		var lasturl = "";

		function checkURL(hash) {
			if (!hash) {
				hash = window.location.hash;
			}

			if (hash != lasturl) {
				lasturl = hash;

				if (hash == "") {
					carregarPag("#Views/home.jsp");
				} else { // se houver hash, a outra função é chamada para tratá-lo e executar o Ajax
					carregarPag(hash);
				}
			}
		}

		function carregarPag(url, campos) { // o parâmetro é o HREF do link HTML, exemplo: href="#pagina1"

			url = url.replace('#', ''); // remove a cerquilha

			$.ajax({ // configurações Ajax
				type : "POST",
				url : url, // extensão PHP, se quiser definir a extensão da página via atributo HREF, é só deixar somente a variável "url" aqui <<< e colocar href="#pagina.(extensao)"
				timeout : 5000,
				dataType : "html",
				data : campos,
				success : function(msg) {
					if (parseInt(msg) != 0) {
						$("#carregaajax").html(msg);

					}
				},
				error : function() { // manipula a mensagem de erro
					$("#carregaajax").html(
							"Erro a página procurada nao foi encontrada");

				}
			});

		}
	</script>
</body>
</html>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Gera Unity - Gerador de Senhas para Universidade</title>

<link href="css/style.css" rel="stylesheet" type="text/css" />
</head>

<body>
	<div id="erros"></div>
	<div class="logo" style="
    width: 100% !important;
    text-align: center;
    margin-top: 80px;
">
			<img src="imgs/logo_GeraUnitySF.png" style="width:267px">
		</div>
	<div class="container">
		<div class="flat-form">
			<ul class="tabs">
				<li><a href="#Aluno" class="active">Aluno</a></li>
				<li><a href="#Funcionario">Funcionario</a></li>
			</ul>
			<div id="Aluno" class="form-action show">
				<p>Sistema Gerador de senha, para você gerar basta entrar.</p>
				<form method="post" action="AlunoController?acao=logar">
					<ul>
						<li><input type="text" name="alunocpf" class="cpf"
							placeholder="CPF" /></li>
						<li><input type="password" name="password"
							placeholder="Senha" /></li>
						<li style="padding-bottom: 18px;"><input type="submit"
							value="Login" class="button" /></li>
					</ul>
				</form>
			</div>


			<div id="Funcionario" class="form-action hide">
				<p>Sistema gerador de senhas, logar como funcionário.</p>
				<form action="FuncionarioController?acao=logar" method="post">
					<ul>
						<li><input type="text" class="cpf" placeholder="CPF"
							name="funcionariocpf" /></li>
						<li><input type="password" placeholder="Senha"
							name="password" /></li>
						<li style="padding-bottom: 18px;"><input type="submit" value="Logar" class="button" /></li>
					</ul>
				</form>
			</div>
		</div>
	</div>
	<script src="js/jquery.js"></script>
	<script src="js/jquerymask.js"></script>
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


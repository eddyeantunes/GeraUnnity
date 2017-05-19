<%@ include file="../Conexao/VerConect.jsp"%>


<div id="erros"></div>
<div class="corpo">
	<div class="headerMenu">
		<h1>Cadastrar Funcionário</h1>
	</div>
	<div class="formulariosCad">

		<form method="post" id="formFunc" action="#" onsubmit="return false">

			<p>
				<span>Nome Completo</span><input type="text" name="nomeFunc"
					placeholder="Digite o nome do aluno..." maxlength="50">
			</p>
			<p>
				<span>Email</span><input type="email" name="emailFunc"
					placeholder="Digite o email do aluno..." maxlength="50">
			</p>
			<p>
				<span>CPF</span><input type="text" class="cpf" name="cpfFunc"
					placeholder="Digite o cpf do aluno...">
			</p>
			<p>
				<span>Senha</span><input type="password" name="senhaFunc"
					placeholder="Digite a senha do aluno...">
			</p>
			<p>
				<span>Tipo de Funcionário</span><select name="tipoFunc">
					<option>Normal</option>
					<option>Administrador</option>
				</select>

			</p>
			<input type="submit" value="Cadastrar" id="bu" /> <input
				type="reset" value="Resetar" />
		</form>
		<div class="clear"></div>
	</div>

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
		$('#formFunc').on(
				'submit',
				function() {
					checkURL();
					carregarPag("#FuncionarioController?acao=adcionar", $(
							'#formFunc').serialize());

				});
	});
</script>
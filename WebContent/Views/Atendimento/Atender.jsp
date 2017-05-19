<%@page import="br.com.geraunity.model.Aluno"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<div class="corpo">
	<%
		
	%>
	<div id="erros"></div>
	<div class="headerMenu">
		<h1>Dados do Aluno</h1>
	</div>

	<div class="formulariosCad" style="float: left;">
		<p>
			<span>Id do Aluno </span><input type="text" name="idAluno"
				value="${alunoatendendo.getAluno_Id()}" readonly />

		</p>
		<p>
			<span>Nome Completo</span><input type="text" maxlength="50"
				value="${alunoatendendo.getAluno_CPF()}" readonly>
		</p>
		<p>
			<span>Email</span><input type="text" maxlength="50"
				value="${alunoatendendo.getAluno_Email()}" readonly>
		</p>
		<p>
			<span>CPF</span><input type="text" class="cpf"
				value="${alunoatendendo.getAluno_CPF()}" readonly>
		</p>

		<div class="clear"></div>
	</div>

	<div style="float: right; text-align: center;">
		<p style="border-bottom: 2px solid #3b68af">
			<span>Senha Chamada:</span>

		</p>
		<p style="font-size: 5em">${senha}</p>
		<p>
			<input type="button" id="btn" value="Chamar Novamente"
				onclick="enviarmensagem()">
		</p>
	</div>
	<div style="float: left; width: 100%;">
		<div class="headerMenu">
			<h1>Atendimento</h1>
		</div>
		<p>
			<b>Motivo do Atendimento:</b> ${motivo}
		</p>
		<form class="formulariosCad" action="#" id="formAtendimento"
			onsubmit="return false;">

			<p>
				<b>1- Aluno Compareceu ?</b>
			</p>
			<p style="width: 100%; float: left;">
				<span style="min-width: 100px"><input type="radio"
					name="compareceu" value="sim" required>Sim</span> <span
					style="min-width: 100px"><input type="radio"
					name="compareceu" value="nao"  required>Não</span>
			</p>
			<p>
				<b>2- A demanda do aluno foi solucionada?</b>
			</p>
			<p style="width: 100%; float: left;">
				<span style="min-width: 100px"><input type="radio"
					name="solucionado" value="sim"  required>Sim</span> <span
					style="min-width: 100px"><input type="radio" name="solucionado"
					value="nao"  required>Não</span>
			</p>
			<div style="float: left; width: 100%; text-align: center;">
				<input type="submit" id="btn" value="Concluir atendimento">
			</div>
		</form>
	</div>


</div>
<script type="text/javascript">
	var webSocket = new WebSocket("ws://localhost:8060/GeraUnity/ChamaSenha");

	window.onbeforeunload = function() {
		webSocket.close();
	};
	function enviarmensagem() {

		webSocket.send(" ");
	};
	$(function() {
		$('#formAtendimento').on(
				'submit',
				function() {
					checkURL();
					carregarPag(
							"#SenhaController?acao=concluir&senha=${senha}", $(
									'#formAtendimento').serialize());

				});
	});
</script>
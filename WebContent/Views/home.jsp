<%@page import="java.util.List"%>
<%@page import="br.com.geraunity.servicos.AlunoServices"%>
<%@page import="br.com.geraunity.model.Funcionario"%>
<%@page import="br.com.geraunity.model.Aluno"%>
<div id="erros"></div>
<%
	Aluno aluno = (Aluno) request.getSession().getAttribute("aluno"); // Aqui eu recebo todos os dados dos alunos de uma sessão e transformo ela em modelo
	Funcionario funcionario = (Funcionario) request.getSession().getAttribute("funcionario");
	boolean funcOnline = false;
	if (aluno != null) {
		funcOnline = false;
	} else if (funcionario != null) {
		funcOnline = true;
	} else {
		request.setAttribute("erro", "Por favor, refaça o login para que possa acessar a página.");
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}
%>
<div class="corpo">
<div class="logo" style="float:left;">
<img src="imgs/logo_GeraUnity.png"/>
	</div>

	<p style="margin-top:60px;">
	<span >
	
		Bem Vindo <b> <%
 	if (funcOnline) {
 		out.println(funcionario.getFuncionario_Nome());
 		out.println("<b id='logado'></b>");
 	 	
 		out.println(" <input type='button' id='btn' value='Chamar Senha'onclick='enviarmensagem()' style='float:right; margin-top:10px'>");
 	}else{
 		out.println();
 	}
 %></span></b>
		</p>
		<div style="float:left; width:100%; margin-top:10px;">
		<p>Software desenvolvido por Alunos do 4º Periodo da Faculdade Pitágoras.<p>
		<p><b>Alunos:</b></p>
		<p><b>Victor de Morais</b></p>
		<p><b>Caio Farias</b></p>
		<p><b>Ana Carolina</b></p>
		<p><b>Welerson Paes</b></p>
		 <p>O Software Tem como objetivo, fazer gerenciamento de senhas em universidades e faculdades no atendimento ao aluno(SAA).
		<p>Pode Ajudar na gestão e otimização de atendimento, gerar dados estatísticos e estratégicos para tomadas de decisões, o sistema visa em possíveis melhorias
de atendimento ao aluno.</p>
	
</p>
	</div>
</div>

<script>

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
			
				var senha;
				var logado = document.getElementById("logado").innerHTML;
				var webSocket =  new WebSocket("ws://localhost:8060/GeraUnity/ChamaSenha");
				
				webSocket.onmessage = function(event){
			
					senha = event.data;
				
					carregarPag("#SenhaController?acao=atender","senha="+senha);
				};
			
				function enviarmensagem(){
					
					webSocket.send(logado);
					
				};
				
		
		</script>

<script>

</script>


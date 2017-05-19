<%@page import="br.com.geraunity.model.Funcionario"%>
<%@page import="br.com.geraunity.model.Aluno"%>
<%
		Aluno aluno = (Aluno) request.getSession().getAttribute("aluno"); // Aqui eu recebo todos os dados dos alunos de uma sessão e transformo ela em modelo
		Funcionario funcionario = (Funcionario) request.getSession().getAttribute("funcionario");
		boolean funcOnline = false;
		if (aluno != null) {
			funcOnline = false;
		} else if (funcionario != null) {
			funcOnline = true;
		} else {
			request.getSession().setAttribute("erro","Ouve Algum Erro, por favor logue novamente");
			
	response.sendRedirect("http://"+request.getServerName()+":"+request.getServerPort()+"/GeraUnity/login.jsp");
		}
	%>
package br.com.geraunity.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.geraunity.model.Aluno;
import br.com.geraunity.servicos.AlunoServices;
@WebServlet("/AlunoController")
public class AlunoController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String acao = request.getParameter("acao");
		if(acao.equalsIgnoreCase("sair")){
			request.getSession().removeAttribute("aluno");
			request.getSession().setAttribute("sucesso","Você Saiu com Sucesso!");
			response.sendRedirect("login.jsp");
			
		}else{
			request.getSession().removeAttribute("aluno");
			request.getSession().setAttribute("alerta","Ouve Algum Erro, por favor logue novamente");
			response.sendRedirect("login.jsp");
			
		}
	
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String acao = request.getParameter("acao");
		if(acao.equalsIgnoreCase("logar")){
					
		String alunocpf = request.getParameter("alunocpf").replaceAll("[^0-9]","");
		String password = request.getParameter("password");
		System.out.println(password + alunocpf);
		System.out.println(alunocpf);
		AlunoServices alunoservico = new AlunoServices();
		boolean result = alunoservico.AutenticaAluno(alunocpf, password);
		
		Aluno aluno = alunoservico.pegaAluno(alunocpf);
		
		if(result == true){
			 request.getSession().setAttribute("aluno", aluno);		
			 response.sendRedirect("home.jsp");
		 }
		 else{

			 request.getSession().setAttribute("alerta","CPF ou Senha Invalidos por favor logue novamente.");
			 response.sendRedirect("login.jsp");
		 }
		}else if(acao.equalsIgnoreCase("adcionar"))
		{
			String nomeAluno = request.getParameter("nomeAluno");
			String emailAluno = request.getParameter("emailAluno");
			String cpfAluno = request.getParameter("cpfAluno").replaceAll("[^0-9]", ""); // Aqui eu to falando qe eu vou remover todos os caracteres e so vai ter numero.
			String senhaAluno = request.getParameter("senhaAluno");
			Aluno aluno = new Aluno(nomeAluno,emailAluno,cpfAluno, senhaAluno);
			AlunoServices alunoservico = new AlunoServices();
			boolean resultado = alunoservico.AdcionarAluno(aluno);
			if (resultado){
			 request.getSession().setAttribute("sucesso","Usuário Cadastrado com sucesso");
			}else{
				request.getSession().setAttribute("erro","O CPF na qual procura cadastrar , já está cadastrado em nosso banco de dados!");	
			}
			RequestDispatcher view = request.getRequestDispatcher( "Views/Aluno/CadastrarAluno.jsp" );
		        view.forward(request, response);
		}
		else if(acao.equalsIgnoreCase("editar")){

			int idAluno = Integer.parseInt(request.getParameter("idAluno"));
			String nomeAluno = request.getParameter("nomeAluno");
			String emailAluno = request.getParameter("emailAluno");
			String cpfAluno = request.getParameter("cpfAluno").replaceAll("[^0-9]", ""); // Aqui eu to falando qe eu vou remover todos os caracteres e so vai ter numero.
			String senhaAluno = request.getParameter("senhaAluno");
			Aluno aluno = new Aluno(nomeAluno,emailAluno,cpfAluno, senhaAluno);
			AlunoServices alunoservico = new AlunoServices();
			boolean resultado = alunoservico.EditarAluno(idAluno,aluno);
			if (resultado){
			 request.getSession().setAttribute("sucesso","Usuário editado com sucesso");
			}else{
				request.getSession().setAttribute("erro","O usuário não foi atualizado, por favor reporte este erro ao Administrador.");	
			}
			RequestDispatcher view = request.getRequestDispatcher( "Views/Aluno/EditarAluno.jsp" );
	        view.forward(request, response);
		}
		else if(acao.equalsIgnoreCase("deletar")){

			int idAluno = Integer.parseInt(request.getParameter("idAluno"));
			AlunoServices alunoservico = new AlunoServices();
			boolean resultado = alunoservico.DeletarAluno(idAluno);
			if (resultado){
			 request.getSession().setAttribute("sucesso","Usuário deletado com sucesso!");
			}else{
				request.getSession().setAttribute("erro","O usuário não foi encontrado.");	
			}
			RequestDispatcher view = request.getRequestDispatcher( "Views/Aluno/ListarAlunos.jsp" );
	        view.forward(request, response);
		}else {
			request.getSession().removeAttribute("aluno");
			request.getSession().setAttribute("Erro","Ouve Algum Erro, por favor logue novamente");
			response.sendRedirect("login.jsp");
		}
		
	}
	 
}

	
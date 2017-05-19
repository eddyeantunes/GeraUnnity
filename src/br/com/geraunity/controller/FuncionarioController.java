package br.com.geraunity.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.geraunity.model.Funcionario;
import br.com.geraunity.servicos.FuncionarioServices;
@WebServlet("/FuncionarioController")
public class FuncionarioController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String acao = request.getParameter("acao");
		if(acao.equalsIgnoreCase("sair")){
			request.getSession().removeAttribute("funcionario");
			request.getSession().setAttribute("sucesso","Você Saiu com Sucesso!");
			response.sendRedirect("login.jsp");
			
		}else{
			request.getSession().removeAttribute("funcionario");
			request.getSession().setAttribute("alerta","Ouve Algum Erro, por favor logue novamente");
			response.sendRedirect("login.jsp");
			
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String acao = request.getParameter("acao");
		if(acao.equalsIgnoreCase("logar")){
		String funcionariocpf = request.getParameter("funcionariocpf").replaceAll("[^0-9]","");
		String password = request.getParameter("password");
			
		FuncionarioServices funcionarioservico = new FuncionarioServices();
		boolean result = funcionarioservico.AutenticaFuncionario(funcionariocpf, password);
		
		Funcionario funcionario = funcionarioservico.pegaFuncionario(funcionariocpf);
		
		if(result == true){
			 request.getSession().setAttribute("funcionario", funcionario);		
			 response.sendRedirect("home.jsp");
		 }
		 else{

			 request.getSession().setAttribute("alerta","CPF ou Senha Invalidos por favor logue novamente.");
			 response.sendRedirect("login.jsp");
		 }
		}else if(acao.equalsIgnoreCase("adcionar"))
		{
			String nomeFunc = request.getParameter("nomeFunc");
			String emailFunc = request.getParameter("emailFunc");
			String cpfFunc = request.getParameter("cpfFunc").replaceAll("[^0-9]", ""); // Aqui eu to falando qe eu vou remover todos os caracteres e so vai ter numero.
			String senhaFunc = request.getParameter("senhaFunc");
			String tipoFunc = request.getParameter("tipoFunc");
			Funcionario funcionario = new Funcionario(nomeFunc,emailFunc,cpfFunc, senhaFunc, tipoFunc);
			FuncionarioServices funcionarioservicos = new FuncionarioServices();
			boolean resultado = funcionarioservicos.AdcionarFunc(funcionario);
			if (resultado){
			 request.getSession().setAttribute("sucesso","Usuário Cadastrado com sucesso");
			}else{
				request.getSession().setAttribute("erro","O CPF na qual procura cadastrar , já está cadastrado em nosso banco de dados!");	
			}
			RequestDispatcher view = request.getRequestDispatcher( "Views/Funcionario/CadastrarFunc.jsp" );
		        view.forward(request, response);
		}else if(acao.equalsIgnoreCase("editar")){

			int idFuncionario = Integer.parseInt(request.getParameter("idFuncionario"));
			String nomeFuncionario = request.getParameter("nomeFuncionario");
			String emailFuncionario = request.getParameter("emailFuncionario");
			String cpfFuncionario = request.getParameter("cpfFuncionario").replaceAll("[^0-9]", ""); // Aqui eu to falando qe eu vou remover todos os caracteres e so vai ter numero.
			String senhaFuncionario = request.getParameter("senhaFuncionario");
			String tipoFuncionario = request.getParameter("tipoFunc");
			Funcionario funcionario = new Funcionario(nomeFuncionario, emailFuncionario,cpfFuncionario, senhaFuncionario,tipoFuncionario);
	
			FuncionarioServices funcionarioservico = new FuncionarioServices();
			boolean resultado = funcionarioservico.EditarFuncionario(idFuncionario, funcionario);
			if (resultado){
			 request.getSession().setAttribute("sucesso","Funcionário editado com sucesso");
			}else{
				request.getSession().setAttribute("erro","O Funcionário não foi atualizado, por favor reporte este erro ao Administrador.");	
			}
			RequestDispatcher view = request.getRequestDispatcher( "Views/Funcionario/EditarFuncionario.jsp" );
	        view.forward(request, response);
		}
		else if(acao.equalsIgnoreCase("deletar")){

			int idFuncionario = Integer.parseInt(request.getParameter("idFuncionario"));
			FuncionarioServices funcionarioservico = new FuncionarioServices();
			boolean resultado = funcionarioservico.DeletarFuncionario(idFuncionario);
			if (resultado){
			 request.getSession().setAttribute("sucesso","Funcionário deletado com sucesso!");
			}else{
				request.getSession().setAttribute("erro","O Funcionário não foi encontrado.");	
			}
			RequestDispatcher view = request.getRequestDispatcher( "Views/Funcionario/ListarFuncionarios.jsp" );
	        view.forward(request, response);
		}
		else{
			request.getSession().removeAttribute("funcionario");
			request.getSession().setAttribute("Erro","Ouve Algum Erro, por favor logue novamente");
			response.sendRedirect("login.jsp");
			
		}
	}

}

	
package br.com.geraunity.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.Month;
import java.time.format.TextStyle;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Objects;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.geraunity.model.Aluno;
import br.com.geraunity.model.Senha;
import br.com.geraunity.servicos.AlunoServices;
import br.com.geraunity.servicos.SenhaServicos;

@WebServlet("/SenhaController")
public class SenhaController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final String String = null;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String acao = request.getParameter("acao");
		String mes = "";
		Calendar calendario = Calendar.getInstance();
		Locale localizacao = new Locale("pt", "BR"); // Defino que é PT BR ,
														// para que não pegue
														// datas em ingles ,
														// tipo sunday monday
														// thursday tuesday

		mes = calendario.getDisplayName(Calendar.MONTH, Calendar.LONG, localizacao);
		Date datacomp = new Date();
		SimpleDateFormat teste = new SimpleDateFormat("yyyy-MM-dd");

		if (acao.equalsIgnoreCase("cadsenha")) {
			SenhaServicos senhaservico = new SenhaServicos();
			int numsenha = senhaservico.UltimaSenha(teste.format(datacomp));

			String data = teste.format(datacomp);
			String Aluno_CPF = request.getParameter("alunoCPF").replaceAll("[^0-9]", "");
			String Tipo_Senha = request.getParameter("tipoAtendimento");
			String SenhaSituacao = "Não Atendido";
			String compareceu = "não";
			String solucionado = "não";
			Senha senha = new Senha(numsenha, mes, data, Aluno_CPF, Tipo_Senha, SenhaSituacao, compareceu, solucionado);
			
			boolean resultado = senhaservico.CadastraSenha(senha);
			if (resultado) {
				request.getSession().setAttribute("sucesso", "Senha Emitida com sucesso");

				request.getSession().setAttribute("Senha", numsenha);
				
				AlunoServices alunoservicos = new AlunoServices();
				Aluno aluno=alunoservicos.pegaAluno(Aluno_CPF);
				request.getSession().setAttribute("NomeAluno", aluno.getAluno_Nome());
			} else {
				request.getSession().setAttribute("erro", "Erro ao emitir senha, o CPF digitado não está cadastrado.");
			}

			response.sendRedirect("PainelAluno/");
		} else if (acao.equalsIgnoreCase("atender")) {
			int senha = Integer.parseInt(request.getParameter("senha"));
			Aluno aluno = null;

			SenhaServicos senhaservicos = new SenhaServicos();
			aluno = senhaservicos.BuscaAluno(senha, teste.format(datacomp));
			String motivo = senhaservicos.Motivo(senha, teste.format(datacomp));
			if (aluno != null & motivo != null) {
				request.getSession().setAttribute("alunoatendendo", aluno); // aqui
																			// eu
																			// pego0
																			// o
																			// resultado
																			// do
																			// meu
																			// serviços
																			// e
																			// adciono
																			// no
																			// cache
																			// para
																			// acessar
																			// da
																			// pagina
																			// de
																			// atendimento
				request.getSession().setAttribute("senha", senha);
				request.getSession().setAttribute("motivo", motivo);
				RequestDispatcher view = request.getRequestDispatcher("Views/Atendimento/Atender.jsp");
				view.forward(request, response);
			} else {
				request.getSession().setAttribute("erro", "Não Possui senhas para ser chamada!");
				RequestDispatcher view = request.getRequestDispatcher("Views/home.jsp");
				view.forward(request, response);
			}

		} else if (acao.equalsIgnoreCase("concluir")) {
			int senha = Integer.parseInt(request.getParameter("senha"));

			String compareceu = request.getParameter("compareceu");
			String solucionado = request.getParameter("solucionado");

			SenhaServicos senhaservicos = new SenhaServicos();
			boolean resultado = senhaservicos.ConcluiAtendimento(senha, teste.format(datacomp), compareceu,
					solucionado);

			request.getSession().removeAttribute("alunoatendendo");
			request.getSession().removeAttribute("motivo");

			if (resultado) {
				request.getSession().setAttribute("sucesso", "Atendimento Efetuado com sucesso!");
			} else {
				request.getSession().setAttribute("erro", "Problema ao salvar o atendimento do aluno");
			}
			RequestDispatcher view = request.getRequestDispatcher("Views/home.jsp");
			view.forward(request, response);

		} else if (acao.equalsIgnoreCase("grafico")) {
			String messelecionado = request.getParameter("mes");

			String graficoselecionado = request.getParameter("tipo");

			SenhaServicos senhaservicos = new SenhaServicos();
			if (graficoselecionado.equals("Demanda")) {
				List<Object[]> resultado = senhaservicos.Demanda(messelecionado);

				String valores = "0", tipo_senha = "";
				for (Object[] employee : resultado) {

					tipo_senha += (String) employee[0] + ",";
					Long contador = (Long) employee[1];
					valores += "0" + contador + ",";
				}

				if (valores.charAt(valores.length() - 1) == ',') {
					valores = valores.substring(0, valores.length() - 1);
				}
				if (resultado != null) {
					System.out.println("teste");
					request.getSession().setAttribute("sucesso", "Gráfico gerado com sucesso, verifique abaixo.");
					request.getSession().setAttribute("tipo_senha", tipo_senha);
					request.getSession().setAttribute("valores", valores);
					RequestDispatcher view = request.getRequestDispatcher("Views/Estatisticas/EstatisticasDemanda.jsp");
					view.forward(request, response);
				} else {
					request.getSession().setAttribute("erro", "Problema ao gerar Gráfico");
					RequestDispatcher view = request.getRequestDispatcher("Views/Estatisticas/Estatisticas.jsp");
					view.forward(request, response);
				}

			} else if (graficoselecionado.equals("Atendimendo")) {
				int mesNumero = 0;
				switch (messelecionado) {
				case "Janeiro":
					mesNumero = 1;
					break;
				case "Fevereiro":
					mesNumero = 2;
					break;
				case "Março":
					mesNumero = 3;
					break;
				case "Abril":
					mesNumero = 4;
					break;
				case "Maio":
					mesNumero = 5;
					break;
				case "Junho":
					mesNumero = 6;
					break;
				case "Julho":
					mesNumero = 7;
					break;
				case "Agosto":
					mesNumero = 8;
					break;
				case "Setembro":
					mesNumero = 9;
					break;
				case "Outubro":
					mesNumero = 10;
					break;
				case "Novembro":
					mesNumero = 11;
					break;
				case "Dezembro":
					mesNumero = 12;
					break;

				}

				List<Object[]> resultado = senhaservicos.graficoAtendidos(mesNumero);
				// List<Object[]> resultadoNao =
				// senhaservicos.graficoNaoAtendidos(mesNumero);
				Date datatemp = null;
				boolean primeiro = true;
				String datas = " ", valores = "0", valoresnao = "";
				for (Object[] employee : resultado) {
					Date data = (Date) employee[0];

					String firstName = (String) employee[1];
					Long contador = 0 + (Long) employee[2];

					// if(primeiro == true &&data!= null &&
					// firstName.equals("Não Atendido")){

					// valoresnao += (Long)employee[2]+",";
					// }
					// if(datatemp != null && datatemp != data &&
					// firstName.equals("Atendido")){

					// if(datatemp.equals(data)&& firstName.equals("Não
					// Atendido")){
					// valoresnao += (Long)employee[2]+",";
					// datas += data +",";
					// }
					// }
					if (primeiro == true) {
						if (employee[2] != null && firstName.equals("Não Atendido")) {
							valoresnao += contador + ",";
						} else if(firstName.equals("Não Atendido")) {
							valoresnao += 0 + ",";
						}
					}
					if (employee[2] != null && firstName.equals("Não Atendido")) {
						System.out.println("teste" + contador);
						if (data.equals(datatemp)) {
							valoresnao += contador + ",";
						}

					} else if (employee[2] != null && firstName.equals("Atendido")) {
						valores += contador + ",";
						datas += data + ",";
						
					}
					primeiro = false;
					datatemp = data;
					// if(data!= null && firstName.equals("Não Atendido") &&
					// data != datatemp){
					// System.out.println("teste ok ");
					// datas += data +",";

					// }
					// if(Objects.isNull(contador) == false){
					// System.out.println("ok");
					// }
				}

				System.out.println(valoresnao + "Valores nao");
				if (datas.charAt(datas.length() - 1) == ',') {
					datas = datas.substring(0, datas.length() - 1);
				}
				if (valores.charAt(valores.length() - 1) == ',') {
					valores = valores.substring(0, valores.length() - 1);
				}
				if (valoresnao.charAt(valoresnao.length() - 1) == ',') {
					valoresnao = valoresnao.substring(0, valoresnao.length() - 1);
				}
				if (resultado != null) {
					request.getSession().setAttribute("sucesso", "Gráfico gerado com sucesso, verifique abaixo.");
					request.getSession().setAttribute("datas", datas);
					request.getSession().setAttribute("valores", valores);

					request.getSession().setAttribute("valoresnao", valoresnao);
					RequestDispatcher view = request
							.getRequestDispatcher("Views/Estatisticas/EstatisticasAtendendimento.jsp");
					view.forward(request, response);
				} else {
					request.getSession().setAttribute("erro", "Problema ao gerar Gráfico");
					RequestDispatcher view = request.getRequestDispatcher("Views/Estatisticas/Estatisticas.jsp");
					view.forward(request, response);
				}

			}
		} else {

			response.sendRedirect("login.jsp");

		}
	}

}

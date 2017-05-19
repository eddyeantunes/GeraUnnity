<%@page import="org.hibernate.criterion.Projections"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.hibernate.Session"%>
<%@page import="br.com.geraunity.hibernate.HibernateUtil"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="br.com.geraunity.servicos.FuncionarioServices"%>
<%@ include file="../Conexao/VerConect.jsp"%>
<%@page import="java.util.List"%>
<div id="erros"></div>
<div class="corpo">
	<div class="headerMenu">
		<h1>Funcionários</h1>
	</div>
	<div class="botao">
		<a href="#Views/Funcionario/CadastrarFunc.jsp">Cadastrar
			Funcionário</a>
	</div>
	<table>
		<tr>
			<td><b>Id</b></td>
			<td><b>Nome Completo</b></td>
			<td><b>Email</b></td>
			<td><b>Tipo</b></td>
			<td><b>Opções</b></td>
		</tr>
		<%
//			FuncionarioServices funcionarioservicos = new FuncionarioServices();
//			List<Funcionario> listaFuncionario = funcionarioservicos.ListarFuncionarios();
//			for (Funcionario func : listaFuncionario) {
		int pageIndex = 0;
	int totalNumberOfRecords = 0;
	int numberOfRecordsPerPage = 5;
	String sPageIndex = request.getParameter("pageIndex");

	if (sPageIndex == null) {
		pageIndex = 1;
	} else {
		pageIndex = Integer.parseInt(sPageIndex);
	}

	int s = (pageIndex * numberOfRecordsPerPage) - numberOfRecordsPerPage;
	Session sessao = HibernateUtil.pegaConecta().openSession();

	Criteria crit = sessao.createCriteria(Funcionario.class);
	crit.setFirstResult(s);
	crit.setMaxResults(numberOfRecordsPerPage);

	List l = crit.list();
	Iterator it = l.iterator();
	while (it.hasNext()) {
		Funcionario p = (Funcionario) it.next();
		%>
		<tr>
			<td><%=p.getFuncionario_Id()%></td>
			<td><%=p.getFuncionario_Nome()%></td>
			<td><%=p.getFuncionario_Email()%></td>
			<td><%=p.getFuncionario_Tipo()%></td>
			<td><span style="width: 70px; text-align: center;"><a
					href="#Views/Funcionario/EditarFuncionario.jsp?idFuncionario=<%=p.getFuncionario_Id()%>"><img
						src="imgs/editar.png" /></a></span> <span
				style="width: 70px; text-align: center;"><a
					href="#FuncionarioController?acao=deletar&idFuncionario=<%=p.getFuncionario_Id()%>"><img
						src="imgs/deletar.png" /></a></span></td>
		</tr>
		<%
			}
	%>
	</table>
	<%
	Criteria crit1 = sessao.createCriteria(Funcionario.class);
	crit1.setProjection(Projections.rowCount());

	List l1 = crit1.list();

	Iterator it1 = l1.iterator();

	if (it1.hasNext()) {
		Object o = it1.next();
		totalNumberOfRecords = Integer.parseInt(o.toString());
	}

	int noOfPages = totalNumberOfRecords / numberOfRecordsPerPage;
	if (totalNumberOfRecords > (noOfPages * numberOfRecordsPerPage)) {
		noOfPages = noOfPages + 1;
	}
%>
<div class=" botao" style="	float:right;
	margin-top:5px;">
	<%for (int i = 1; i <= noOfPages; i++) {
		String myurl = "#Views/Funcionario/ListarFuncionarios.jsp?pageIndex=" + i;
		out.println("<a  href=" + myurl + ">" + i + "</a>");
	}
		%>
	</div>
</div>



package br.com.geraunity.servicos;

import java.sql.Date;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import br.com.geraunity.hibernate.HibernateUtil;
import br.com.geraunity.model.Aluno;
import br.com.geraunity.model.Funcionario;
import br.com.geraunity.model.Senha;

public class SenhaServicos {
	public boolean CadastraSenha(Senha senha) {
		Session sessao = HibernateUtil.pegaConecta().openSession();
		Transaction tx = null;
		if (!VerificaAluno(senha))
			return false;
		try {
			tx = sessao.getTransaction();
			tx.begin();
			sessao.save(senha);
			tx.commit();
		} catch (Exception e) {
			if (tx != null) {
				tx.rollback();
			}
			e.printStackTrace();
		} finally {
			sessao.close();
		}
		return true;

	}

	public boolean VerificaAluno(Senha senha) {
		Session sessao = HibernateUtil.pegaConecta().openSession();
		boolean result = false;
		Transaction tx = null;
		try {
			tx = sessao.getTransaction();
			tx.begin();
			Query query = sessao.createQuery("from Aluno where Aluno_CPF = '" + senha.getAluno_CPF() + "'");
			Aluno aluno = (Aluno) query.uniqueResult();
			tx.commit();
			if (aluno != null)
				result = true;
		} catch (Exception ex) {
			if (tx != null) {
				tx.rollback();
			}

		} finally {
			sessao.close();
		}
		return result;
	}

	public int UltimaSenha(String data) {
		Session sessao = HibernateUtil.pegaConecta().openSession();
		int ultimadata = 0001;
		Transaction tx = null;

		try {
			tx = sessao.getTransaction();
			tx.begin();
			Query query = sessao
					.createQuery("Select Senhas from Senha where Data='" + data + "'  ORDER BY Senhas Desc limit 1");
			query.setMaxResults(1);
			ultimadata = (int) query.uniqueResult() + 1;

			tx.commit();
		} catch (Exception ex) {
			if (tx != null) {
				tx.rollback();
			}

		} finally {
			sessao.close();
		}
		return ultimadata;
	}

	public int Chama(String data) {
		Session sessao = HibernateUtil.pegaConecta().openSession();
		int ultimoatendido = 0;
		Transaction tx = null;

		try {
			tx = sessao.getTransaction();
			tx.begin();
			Query query = sessao.createQuery("Select Senhas from Senha where Data='" + data
					+ "'and Senha_Situacao='Não Atendido' ORDER BY Senhas ASC limit 1");
			query.setMaxResults(1);
			ultimoatendido = (int) query.uniqueResult();
			// Query query2 = sessao.createQuery("from Senha where
			// Data='"+data+"'and Senhas='"+ultimoatendido+"' ORDER BY Senhas
			// ASC limit 1");
			// Senha senhaup = (Senha)query2.uniqueResult();
			// senhaup.setSenha_Situacao("Em Atendimento");
			// sessao.update(senhaup);

			tx.commit();
		} catch (Exception ex) {
			if (tx != null) {
				tx.rollback();
			}

		} finally {
			sessao.close();
		}
		return ultimoatendido;
	}

	public Aluno BuscaAluno(int senha, String data) {
		Session sessao = HibernateUtil.pegaConecta().openSession();
		Transaction tx = null;
		Aluno aluno = null;
		Senha resultadosenha = null;
		try {
			tx = sessao.getTransaction();
			tx.begin();
			Query query = sessao.createQuery("from Senha where Data='" + data + "' and Senhas ='" + senha + "'");
			resultadosenha = (Senha) query.uniqueResult();

			Query query2 = sessao.createQuery("from Aluno where Aluno_CPF='" + resultadosenha.getAluno_CPF() + "'");
			aluno = (Aluno) query2.uniqueResult();

			tx.commit();
		} catch (Exception ex) {
			if (tx != null) {
				tx.rollback();
			}

		} finally {
			sessao.close();
		}
		return aluno;
	}

	public String Motivo(int senha, String data) {
		Session sessao = HibernateUtil.pegaConecta().openSession();
		Transaction tx = null;

		String resultadosenha = "";
		try {
			tx = sessao.getTransaction();
			tx.begin();
			Query query = sessao.createQuery("from Senha where Data='" + data + "' and Senhas ='" + senha + "'");
			Senha result = (Senha) query.uniqueResult();
			resultadosenha = result.getTipo_Senha();
			tx.commit();
		} catch (Exception ex) {
			if (tx != null) {
				tx.rollback();
			}

		} finally {
			sessao.close();
		}
		return resultadosenha;
	}

	public boolean ConcluiAtendimento(int senha, String data, String compareceu, String solucionado) {
		Session sessao = HibernateUtil.pegaConecta().openSession();
		Transaction tx = null;
		Senha resultadosenha = null;
		try {

			tx = sessao.getTransaction();
			tx.begin();
			Query query = sessao.createQuery("from Senha where Data='" + data + "' and Senhas ='" + senha + "'");
			resultadosenha = (Senha) query.uniqueResult();
			resultadosenha.setCompareceu(compareceu);
			resultadosenha.setSolucionado(solucionado);
			resultadosenha.setSenha_Situacao("Atendido");
			sessao.update(resultadosenha);
			tx.commit();
			return true;
		} catch (Exception e) {
			if (tx != null) {
				tx.rollback();
			}
			e.printStackTrace();
		} finally {
			sessao.close();
		}
		return false;
	}

	public List<Object[]> graficoAtendidos(int mes) {
		Session sessao = HibernateUtil.pegaConecta().openSession();
		Transaction tx = null;
		String resultado = null;
	
		List<Object[]> employees= null;
		
		try {
			tx = sessao.getTransaction();
			tx.begin();
			//Query query = sessao.createQuery("SELECT DATE(Data), Senha_Situacao, COUNT(*) from Senha where month(data)='"+mes+"' and Senha_Situacao = 'Atendido' GROUP BY Data, Senha_Situacao");
			Query query = sessao.createQuery("SELECT DATE(Data), Senha_Situacao, COUNT(*) from Senha where month(data)='"+mes+"' GROUP BY Data, Senha_Situacao");
			
			resultado = query.toString();
			employees= (List<Object[]>)query.list();
		   //  for(Object[] employee: employees){
		   // 	 Date data = (Date)employee[0];
		    //     String firstName = (String)employee[1];
		     //    int contador = (int)employee[2];
		      //   System.out.println(data + firstName + contador);
		     //}
			tx.commit();
			
		} catch (Exception e) {
			if (tx != null) {
				tx.rollback();
			}
			e.printStackTrace();
		} finally {
			sessao.close();

		}
		return employees;
	}
	public List<Object[]> graficoNaoAtendidos(int mes) {
		Session sessao = HibernateUtil.pegaConecta().openSession();
		Transaction tx = null;
		String resultado = null;
	
		List<Object[]> employees= null;
		
		try {
			tx = sessao.getTransaction();
			tx.begin();
			Query query = sessao.createQuery("SELECT DATE(Data), Senha_Situacao, COUNT(*) from Senha where month(data)='"+mes+"' and Senha_Situacao = 'Não Atendido' GROUP BY Data, Senha_Situacao");
			resultado = query.toString();
			employees= (List<Object[]>)query.list();
		   //  for(Object[] employee: employees){
		   // 	 Date data = (Date)employee[0];
		    //     String firstName = (String)employee[1];
		     //    int contador = (int)employee[2];
		      //   System.out.println(data + firstName + contador);
		     //}
			tx.commit();
			
		} catch (Exception e) {
			if (tx != null) {
				tx.rollback();
			}
			e.printStackTrace();
		} finally {
			sessao.close();

		}
		return employees;
	}

	public List<String> ListarMes() {
		List<String> list = new ArrayList<String>();
		Session sessao = HibernateUtil.pegaConecta().openSession();
		Transaction tx = null;

		tx = sessao.getTransaction();
		tx.begin();
		Query query = sessao.createQuery("select Distinct Mes from Senha");
		System.out.println(query.list());
		list = query.list();
		try {
			tx.commit();
		} catch (Exception e) {
			if (tx != null) {
				tx.rollback();

			}
		} finally {
			sessao.close();
		}

		return list;

	}
	
	public List<Object[]> Demanda(String mes) {
		Session sessao = HibernateUtil.pegaConecta().openSession();
		Transaction tx = null;
		String resultado = null;
	
		List<Object[]> employees= null;
		
		try {
			tx = sessao.getTransaction();
			tx.begin();
			Query query = sessao.createQuery("SELECT Tipo_Senha, COUNT(*) from Senha where mes='"+mes+"'GROUP BY Tipo_Senha");
			resultado = query.toString();
			employees= (List<Object[]>)query.list();
		   //  for(Object[] employee: employees){
		   // 	 Date data = (Date)employee[0];
		    //     String firstName = (String)employee[1];
		     //    int contador = (int)employee[2];
		      //   System.out.println(data + firstName + contador);
		     //}
			tx.commit();
			
		} catch (Exception e) {
			if (tx != null) {
				tx.rollback();
			}
			e.printStackTrace();
		} finally {
			sessao.close();

		}
		return employees;
	}
	public List<Senha>  ListarSenhaAl(String CPF)
	{
		List<Senha> list = new ArrayList<Senha>();
		Session sessao = HibernateUtil.pegaConecta().openSession();
		Transaction tx = null;
		try{
			tx =sessao.getTransaction();
			tx.begin();
			list = sessao.createQuery("from Senha where Aluno_CPF='"+CPF+"'").list();
			tx.commit();
		}catch(Exception e){
			if(tx !=null){
				tx.rollback();
				
			}
		}finally{
			sessao.close();
		}
		
		return list;
		
	}
	public List<Senha>  ListarAtendimento()
	{
		java.util.Date date = new java.util.Date();
		LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		int mes = localDate.getMonthValue();
		
		//List<Senha> list = new ArrayList<Senha>();
		Session sessao = HibernateUtil.pegaConecta().openSession();
		Transaction tx = null;
		try{
			tx =sessao.getTransaction();
			tx.begin();
			 Query query =  sessao.createQuery("from Senha Order BY id_senha ASC");
			  List<Senha> list = (List<Senha>)query.list();
			  
			tx.commit();
			return list;
		}catch(Exception e){
			if(tx !=null){
				tx.rollback();
				
			}
		}finally{
			sessao.close();
		}
		return null;
		
		
	}
}

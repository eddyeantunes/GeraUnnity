package br.com.geraunity.servicos;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import br.com.geraunity.hibernate.HibernateUtil;
import br.com.geraunity.model.Aluno;
import br.com.geraunity.model.Funcionario;

public class FuncionarioServices {
	public boolean AutenticaFuncionario(String funcionariocpf, String password){
		Funcionario funcionario = pegaFuncionario(funcionariocpf);
		if(funcionario!=null && funcionario.getFuncionario_CPF().equals(funcionariocpf) && funcionario.getFuncionario_Password().equals(password)){
			return true;
		}else{
			return false;
		}
	}
	public Funcionario pegaFuncionario(String funcionariocpf){
		Session sessao = HibernateUtil.pegaConecta().openSession();
		Transaction tx = null;
		Funcionario funcionario = null;
		try{
			tx = sessao.getTransaction();
			tx.begin();
			Query query = sessao.createQuery("from Funcionario where Funcionario_CPF ='"+funcionariocpf+"'");
			funcionario = (Funcionario)query.uniqueResult();
			tx.commit();
		}catch(Exception e ){
			if(tx != null){
				tx.rollback();
			}
			e.printStackTrace();
			
		}finally{
			sessao.close();// Fecha a Conexão com o banco de dados
		}
		
		return funcionario;
	}
	public boolean AdcionarFunc(Funcionario funcionario){
		Session sessao = HibernateUtil.pegaConecta().openSession();
		if(VerificaFunc(funcionario)) return false;
		Transaction tx = null;
		try{
			tx = sessao.getTransaction();
			tx.begin();
			sessao.saveOrUpdate(funcionario);
			tx.commit();
		}catch(Exception e){
			if(tx != null){
				tx.rollback();
			}
			e.printStackTrace();
		}finally{
			sessao.close();
		}
		return true;
	}
	public boolean VerificaFunc(Funcionario funcionario){
		Session sessao = HibernateUtil.pegaConecta().openSession();
		boolean result = false;
		Transaction tx = null;
		try{
			tx =sessao.getTransaction();
			tx.begin();
			Query query = sessao.createQuery("from Funcionario where Funcionario_CPF = '"+funcionario.getFuncionario_CPF()+"'");
			Funcionario func = (Funcionario)query.uniqueResult();
			tx.commit();
			if(func!=null) result =true;
		}catch(Exception ex){
			if(tx!=null){
				tx.rollback();
			}
			
		}finally{
			sessao.close();
		}
		return result;
	}
	public List<Funcionario>  ListarFuncionarios()
	{
		List<Funcionario> list = new ArrayList<Funcionario>();
		Session sessao = HibernateUtil.pegaConecta().openSession();
		Transaction tx = null;
		try{
			tx =sessao.getTransaction();
			tx.begin();
			list = sessao.createQuery("from Funcionario").list();
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
	public boolean EditarFuncionario(int idFuncionario,Funcionario funcionario){
		Session sessao = HibernateUtil.pegaConecta().openSession();
		
		Transaction tx = null;
		try{
			
			tx = sessao.getTransaction();
			tx.begin();
			Funcionario func = (Funcionario)sessao.get(Funcionario.class, idFuncionario);
				
			
			func.setFuncionario_Nome(funcionario.getFuncionario_Nome());
			func.setFuncionario_Email(funcionario.getFuncionario_Email());
			func.setFuncionario_CPF(funcionario.getFuncionario_CPF());
			func.setFuncionario_Tipo(funcionario.getFuncionario_Tipo());
			func.setFuncionario_Password(funcionario.getFuncionario_Password());
			sessao.update(func);
			
			tx.commit();
		}catch(Exception e){
			if(tx != null){
				tx.rollback();
			}
			e.printStackTrace();
		}finally{
			sessao.close();
		}
		return true;
	}
	public boolean DeletarFuncionario(int idFuncionario){
		Session sessao = HibernateUtil.pegaConecta().openSession();
	
		Transaction tx = null;
		try{
			tx = sessao.getTransaction();
			tx.begin();
			Funcionario funcionario = (Funcionario)sessao.get(Funcionario.class, idFuncionario);
			
			sessao.delete(funcionario);
			
			tx.commit();
		}catch(Exception e){
			if(tx != null){
				tx.rollback();
			}
			e.printStackTrace();
		}finally{
			sessao.close();
		}
		return true;
	}

	
}

package br.com.geraunity.servicos;


import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import br.com.geraunity.hibernate.HibernateUtil;
import br.com.geraunity.model.Aluno;

public class AlunoServices {
	public boolean AutenticaAluno(String alunocpf , String password){

		Aluno aluno = pegaAluno(alunocpf);
		
		if(aluno!=null && aluno.getAluno_CPF().equals(alunocpf) && aluno.getAluno_Password().equals(password)){
			return true;
		}else{
				return false;
			}
	}
	public Aluno pegaAluno(String alunocpf){
		Session sessao = HibernateUtil.pegaConecta().openSession();
		Transaction tx = null;
		Aluno aluno = null;
		
		try{
			tx = sessao.getTransaction();
			tx.begin();
			Query query = sessao.createQuery("from Aluno where Aluno_CPF='"+alunocpf+"'");
			aluno = (Aluno)query.uniqueResult();
			tx.commit(); // Ele executa a Query e Salva 
		}catch(Exception e){
			if(tx != null){
				tx.rollback(); // o Rollback , se caso ele não salvar no Commit , ele volta a mesmo valor como não encotnrado e sem fazer alterações no banco de dados.
			}
			e.printStackTrace();
		}finally {
            sessao.close();
        }
        return aluno;

    	
    	
	}
	public List<Aluno>  ListarAlunos()
	{
		List<Aluno> list = new ArrayList<Aluno>();
		Session sessao = HibernateUtil.pegaConecta().openSession();
		Transaction tx = null;
		try{
			tx =sessao.getTransaction();
			tx.begin();
			list = sessao.createQuery("from Aluno").list();
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
	public boolean AdcionarAluno(Aluno aluno){
		Session sessao = HibernateUtil.pegaConecta().openSession();
		if(VerificaAluno(aluno)) return false;
		Transaction tx = null;
		try{
			tx = sessao.getTransaction();
			tx.begin();
			sessao.saveOrUpdate(aluno);
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
	public boolean EditarAluno(int idAluno,Aluno aluno){
		Session sessao = HibernateUtil.pegaConecta().openSession();
		
		Transaction tx = null;
		try{
			
			tx = sessao.getTransaction();
			tx.begin();
			Aluno al = (Aluno)sessao.get(Aluno.class, idAluno);
				
			
			al.setAluno_Nome(aluno.getAluno_Nome());
			al.setAluno_Email(aluno.getAluno_Email());
			al.setAluno_CPF(aluno.getAluno_CPF());
			al.setAluno_Password(aluno.getAluno_Password());
			sessao.update(al);
			
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
	public boolean DeletarAluno(int idAluno){
		Session sessao = HibernateUtil.pegaConecta().openSession();
	
		Transaction tx = null;
		try{
			tx = sessao.getTransaction();
			tx.begin();
			Aluno aluno = (Aluno)sessao.get(Aluno.class, idAluno);
			System.out.println(aluno.getAluno_CPF());
			
			sessao.delete(aluno);
			
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

	
	public boolean VerificaAluno(Aluno aluno){
		Session sessao = HibernateUtil.pegaConecta().openSession();
		boolean result = false;
		Transaction tx = null;
		try{
			tx =sessao.getTransaction();
			tx.begin();
			Query query = sessao.createQuery("from Aluno where Aluno_CPF = '"+aluno.getAluno_CPF()+"'");
			
			Aluno alun = (Aluno)query.uniqueResult();
			tx.commit();
			
			if(alun!=null) result = true;
		}catch(Exception ex){
			if(tx!=null){
				tx.rollback();
			}
			
		}finally{
			sessao.close();
		}
		return result;
	}
		
	
}

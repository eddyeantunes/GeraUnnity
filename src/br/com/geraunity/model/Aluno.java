package br.com.geraunity.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="aluno")//na hora do mapeamento define de qual tabela ira ser buscado
public class Aluno {
	@Id @GeneratedValue
	private int Aluno_Id;
	private String Aluno_Nome;
	private String Aluno_Email;
	private String Aluno_CPF;
	private String Aluno_Password;
	public Aluno(){}
	public Aluno(String aluno_Nome, String aluno_Email, String aluno_CPF, String aluno_Password) {
		
		Aluno_Nome = aluno_Nome;
		Aluno_Email = aluno_Email;
		Aluno_CPF = aluno_CPF;
		Aluno_Password = aluno_Password;
	}

	public int getAluno_Id() {
		return Aluno_Id;
	}

	public void setAluno_Id(int aluno_Id) {
		Aluno_Id = aluno_Id;
	}

	public String getAluno_Nome() {
		return Aluno_Nome;
	}

	
	public String getAluno_Password() {
		return Aluno_Password;
	}

	public void setAluno_Password(String aluno_Password) {
		Aluno_Password = aluno_Password;
	}

	public void setAluno_Nome(String aluno_Nome) {
		Aluno_Nome = aluno_Nome;
	}

	public String getAluno_Email() {
		return Aluno_Email;
	}

	public void setAluno_Email(String aluno_Email) {
		Aluno_Email = aluno_Email;
	}

	public String getAluno_CPF() {
		return Aluno_CPF;
	}

	public void setAluno_CPF(String aluno_CPF) {
		Aluno_CPF = aluno_CPF;
	}

	
	
	
}

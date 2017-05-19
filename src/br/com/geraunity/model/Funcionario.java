package br.com.geraunity.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "funcionario") // tabela de Mapeamento
public class Funcionario {
	@Id
	@GeneratedValue // Define que a propriedade abaixo é uma ID que gera
					// automatico
	private int Funcionario_Id;
	private String Funcionario_Nome;
	private String Funcionario_Email;
	private String Funcionario_CPF;
	private String Funcionario_Password;
	private String Funcionario_Tipo;

	public Funcionario() {
	}

	public int getFuncionario_Id() {
		return Funcionario_Id;
	}

	public void setFuncionario_Id(int funcionario_Id) {
		Funcionario_Id = funcionario_Id;
	}

	public String getFuncionario_Nome() {
		return Funcionario_Nome;
	}

	public void setFuncionario_Nome(String funcionario_Nome) {
		Funcionario_Nome = funcionario_Nome;
	}

	public String getFuncionario_Email() {
		return Funcionario_Email;
	}

	public void setFuncionario_Email(String funcionario_Email) {
		Funcionario_Email = funcionario_Email;
	}

	public String getFuncionario_CPF() {
		return Funcionario_CPF;
	}

	public void setFuncionario_CPF(String funcionario_CPF) {
		Funcionario_CPF = funcionario_CPF;
	}

	public String getFuncionario_Password() {
		return Funcionario_Password;
	}

	public void setFuncionario_Password(String funcionario_Password) {
		Funcionario_Password = funcionario_Password;
	}

	public String getFuncionario_Tipo() {
		return Funcionario_Tipo;
	}

	public void setFuncionario_Tipo(String funcionario_Tipo) {
		Funcionario_Tipo = funcionario_Tipo;
	}

	public Funcionario(String funcionario_Nome, String funcionario_Email, String funcionario_CPF,
			String funcionario_Password, String funcionario_Tipo) {

		Funcionario_Nome = funcionario_Nome;
		Funcionario_Email = funcionario_Email;
		Funcionario_CPF = funcionario_CPF;
		Funcionario_Password = funcionario_Password;
		Funcionario_Tipo = funcionario_Tipo;
	}

}

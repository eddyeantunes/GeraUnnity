package br.com.geraunity.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "senha")
public class Senha {
	@Id
	@GeneratedValue
	private int id_senha;
	private int Senhas;
	private String Mes;
	private String Data;
	private String Aluno_CPF;
	private String Tipo_Senha;
	private String Senha_Situacao;
	private String Compareceu;
	private String Solucionado;

	public Senha() {
	}
	public int getid_senha() {
		return id_senha;
	}

	public void setid_senha(int Id_senha) {
		id_senha = Id_senha;
	}
	public int getSenhas() {
		return Senhas;
	}

	public void setSenhas(int senhas) {
		Senhas = senhas;
	}

	public String getMes() {
		return Mes;
	}

	public void setMes(String mes) {
		Mes = mes;
	}

	public String getData() {
		return Data;
	}

	public void setData(String data) {
		Data = data;
	}

	public String getAluno_CPF() {
		return Aluno_CPF;
	}

	public void setAluno_CPF(String aluno_CPF) {
		Aluno_CPF = aluno_CPF;
	}

	public String getTipo_Senha() {
		return Tipo_Senha;
	}

	public void setTipo_Senha(String tipo_Senha) {
		Tipo_Senha = tipo_Senha;
	}

	public String getSenha_Situacao() {
		return Senha_Situacao;
	}

	public void setSenha_Situacao(String senha_Situacao) {
		Senha_Situacao = senha_Situacao;
	}

	public String getCompareceu() {
		return Compareceu;
	}

	public void setCompareceu(String compareceu) {
		Compareceu = compareceu;
	}

	public String getSolucionado() {
		return Solucionado;
	}

	public void setSolucionado(String solucionado) {
		Solucionado = solucionado;
	}



	public Senha(int senhas, String mes, String data, String aluno_CPF, String tipo_Senha, String senha_Situacao,
			String compareceu, String solucionado) {
		this.Senhas = senhas;
		this.Mes = mes;
		this.Data = data;
		this.Aluno_CPF = aluno_CPF;
		this.Tipo_Senha = tipo_Senha;
		this.Senha_Situacao = senha_Situacao;
		this.Compareceu = compareceu;
		this.Solucionado = solucionado;
	}

}

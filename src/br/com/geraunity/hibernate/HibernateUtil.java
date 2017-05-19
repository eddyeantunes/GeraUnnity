package br.com.geraunity.hibernate;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {

	private static SessionFactory factory = null;
	private static Configuration conf = null;

	private static SessionFactory Conecta() {
		try {
			conf = new Configuration();
			conf.configure("hibernate.cfg.xml");
			factory = conf.buildSessionFactory();
			System.out.println("Configuração carregada com sucesso!");
			System.out.println("Session Factory Carregada com sucesso!");
			return factory;

		} catch (Throwable ex) {
			System.out.println("Falha ao criar Sessão");
			ex.printStackTrace();
			throw new ExceptionInInitializerError(ex);
		}
	}

	public static SessionFactory pegaConecta() {
		if (factory == null) {
			factory = Conecta();
		}
		return factory;

	}
}
package br.com.geraunity.websocket;



import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import br.com.geraunity.servicos.SenhaServicos;

@ServerEndpoint("/ChamaSenha")
public class ChamaSenha{
	static Set<Session> users = Collections.synchronizedSet(new HashSet<Session>()); // Aqui recebe todos os usuários que estão dentro do WebSocket
	//lembrandoq ue pode ter varios usuarios ao mesmo tempo
	//então utilizaremos aideia de 1 para 1 
	
	
	
	@OnOpen
	public void onOpen(Session session) {
		System.out.println("Sessão Conectada" + session.getId() + "Connected");
		users.add(session);
	}

	@OnMessage
	public void onMessage(Session session, String Mensagem) {
		System.out.println("Mensagem recebida pela sessão: " + session.getId() + Mensagem);
		Iterator<Session> iter = users.iterator(); // Iterator é como se fosse uma lista com todas as sessões conectadas 
		while (iter.hasNext()) {
			try {
				Date datacomp = new Date();
				SimpleDateFormat teste = new SimpleDateFormat("yyyy-MM-dd");
				SenhaServicos senhaservicos = new SenhaServicos();
				int senha = senhaservicos.Chama(teste.format(datacomp));
				iter.next().getBasicRemote().sendText(Integer.toString(senha)); // Aqui ele pega todos os usuarios conectados e envia para a pagina
				
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	@OnClose
	public void onClose(Session session){
		users.remove(session);
		System.out.println("Sessão "+session.getId()+"Encerrada com sucesso");
	}
}

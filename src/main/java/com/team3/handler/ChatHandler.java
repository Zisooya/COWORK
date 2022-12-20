package com.team3.handler;

import java.util.ArrayList;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.server.ServerEndpoint;

import org.springframework.stereotype.Controller;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@ServerEndpoint(value="/messanger.do")
public class ChatHandler {
	
	// 사용자 정보를 담기 위한 sessionList 선언
	private static final List<Session> sessionList = new ArrayList<Session>();
	//private static final org.mybatis.logging.Logger logger = LoggerFactory.getLogger(WebSocketChat.class);
	
	public ChatHandler() {
		System.out.println("웹소켓(서버) 객체 생성");
	}
	
    /***
     * 웹 소켓이 연결되면 호출되는 이벤트
     */ 
	@OnOpen
	public void onOpen(Session session) {
		
		// 사용자가 증가할 때마다 세션의 getId()는 1씩 증가

		log.info("Open session id:" + session.getId());
		
		try {
			final Basic basic = session.getBasicRemote();
			basic.sendText("대화방에 연결 되었습니다.");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		// 세션 리스트에 연결된 세션 추가.
		sessionList.add(session);
	}
	
	// 모든 사용자에게 메시지 전달
	private void sendAllSessionToMessage(Session self, String sender, String message) {
		
		try {

			// 모든 사용자의 수 만큼 반복.
			for(Session session : ChatHandler.sessionList) {		
				if(!self.getId().equals(session.getId())) {
					session.getBasicRemote().sendText(sender+" : "+message);
				}
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
	}


	
	// 내가 입력하는 메세지
    /**
     * 웹 소켓으로부터 메시지가 오면 호출되는 이벤트
     * @param message
     * @return
     */	
	@OnMessage
	public void onMessage(String message, Session session) {
		String sender = message.split(",")[1];
		message = message.split(",")[0];
		
		log.info("Message From " + sender + ": " + message);
		
		try {
			final Basic basic = session.getBasicRemote();
			basic.sendText("<나> : " + message);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		sendAllSessionToMessage(session, sender, message);
	}
	
    /**
     * 웹 소켓이 에러가 나면 호출되는 이벤트
     * @param t
     */		
	@OnError
	public void onError(Throwable e, Session session) {
		System.out.println("에러에러에러");
	}
	
    /**
     * 웹 소켓이 닫히면 호출되는 이벤트
     */		
	@OnClose
	public void onClose(Session session) {
		log.info("Session " + session.getId() + " has ended");
		sessionList.remove(session);
	}
	
}

package com.team3.handler;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.server.ServerEndpoint;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.team3.model.Chat_MessageDTO;
import com.team3.model.MessengerDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@ServerEndpoint(value="/messanger.do")
public class ChatHandler {
	
	@Autowired
	private MessengerDAO messengerDao;
	
	
	// 사용자 정보를 담기 위한 sessionList 선언
	private static final List<Session> sessionList = new ArrayList<Session>();
	
	// (<"chat_room_no", 채팅방번호>, <"session", 세션>) - (<"chat_room_no", 채팅방번호>, <"session", 세션>) 형태 
	//private List<Map<String, Object>> sessionList = new ArrayList<Map<String, Object>>();
	
	
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
	private void sendAllSessionToMessage(Session self, String sender, String message, String send_date) {
		
		try {
			// 모든 사용자의 수 만큼 반복.
			for(Session session : ChatHandler.sessionList) {
				
				if(!self.getId().equals(session.getId())) {
					session.getBasicRemote().sendText(sender+" : "+message+ " ("+send_date+")");
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
        
		System.out.println("메세지 >>> " + message );
		
		String[] messageArr = message.split(",");
		//System.out.println(messageArr[0]);
		//System.out.println(messageArr[1]);
		//System.out.println(messageArr[2]);
		//System.out.println(messageArr[3]);
		
		
		//String sender = message.split(",")[1];
		//message = message.split(",")[0];		
		
		String sender = messageArr[1];
		message = messageArr[0];
		int chat_room_no = Integer.parseInt(messageArr[2]);
		String send_date = messageArr[3];
		
		System.out.println("sender>>>"+sender);
		System.out.println("message>>>"+message);
		System.out.println("chat_room_no>>>"+chat_room_no);
		System.out.println("send_date>>>"+send_date);
		
		log.info("Message From " + sender + ": " + message);
		
		
		// 메세지 정보를 DB에 저장하는 메소드 호출.
		insertMessage(chat_room_no,sender,message,send_date);
		
		try {
			final Basic basic = session.getBasicRemote();
			basic.sendText("<나> : " + message + " ("+send_date+")");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		sendAllSessionToMessage(session, sender, message, send_date);
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
	
	// DB에 메세지 저장하는 메소드
	public void insertMessage(int chat_room_no,String sender,String message,String send_date) {
		Chat_MessageDTO chatMessageDTO = new Chat_MessageDTO();
		System.out.println("------------파라미터 쓰기--------------");
		System.out.println(chat_room_no);
		System.out.println(sender);
		System.out.println(message);
		System.out.println(send_date);
		System.out.println("------------파라미터 쓰기 끝--------------");
		chatMessageDTO.setChat_room_no(1);
		chatMessageDTO.setSender("coya319");
		chatMessageDTO.setMessage("디티오...");
		chatMessageDTO.setSend_date("2022/12/22 00:51:15");
		
		System.out.println("------------getter메소드--------------");
		System.out.println(chatMessageDTO.getChat_room_no());
		System.out.println(chatMessageDTO.getSender());
		System.out.println(chatMessageDTO.getMessage());
		System.out.println(chatMessageDTO.getSend_date());
		
		int check = this.messengerDao.messenger_insertMessage(chatMessageDTO);
		
		if(check>0) {
			System.out.println("Chat_MessageDTO insert 성공!");
		}else {
			System.out.println("Chat_MessageDTO insert 실패");
		}		
	}
	
	
	
}

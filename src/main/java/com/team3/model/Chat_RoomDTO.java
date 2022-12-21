package com.team3.model;

import java.util.HashSet;
import java.util.Set;

import org.springframework.web.socket.WebSocketSession;


import lombok.Data;

@Data
public class Chat_RoomDTO {
	private int chat_room_no;
	private String chat_room_name;
	private String chat_kind;
	private String regdate;

	//private Set<WebSocketSession> sessions = new HashSet<>();


	
}

package com.team3.model;

import lombok.Data;

@Data
public class Chat_MessageDTO {

   
    //private MessageType type; // 메시지 타입
    private int chat_room_no; // 방번호
    private String sender; // 메시지 보낸사람
    private String message; // 메시지
    private String send_date;
	    
}
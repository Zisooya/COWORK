package com.team3.model;

import lombok.Data;

@Data
public class Messenger_NotiDTO {
    private int mem_no;
    private int chat_room_no;
    private int message_no;
    private String message_status;
    private String noti_cont;
    private String regdate;
}

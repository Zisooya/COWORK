package com.team3.model;

import java.util.List;

public interface MessengerDAO {

	List<Chat_RoomDTO> getOneToOneChatRoomList(int mem_no);
	
	List<Chat_RoomDTO> getGroupChatRoomList(int mem_no);
	
	List<Chat_MessageDTO> getMessageList(int chat_room_no);
	
	int messenger_insertMessage(Chat_MessageDTO chatMessageDTO);
	
	int getChatRoomNoMax(int mem_no);
}

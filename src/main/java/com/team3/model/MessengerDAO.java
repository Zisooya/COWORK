package com.team3.model;

import java.util.List;

public interface MessengerDAO {

	List<Chat_RoomDTO> getOneToOneChatRoomList();
	
	List<Chat_RoomDTO> getGroupChatRoomList();
}

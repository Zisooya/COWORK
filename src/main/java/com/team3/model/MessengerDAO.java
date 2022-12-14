package com.team3.model;

import java.util.List;
import java.util.Map;

import com.team3.model.member.MemberDTO;

public interface MessengerDAO {

	List<Chat_RoomDTO> getOneToOneChatRoomList(int mem_no);
	
	List<Chat_RoomDTO> getGroupChatRoomList(int mem_no);
	
	List<Chat_MessageDTO> getMessageList(int chat_room_no);
	
	int messenger_insertMessage(Chat_MessageDTO chatMessageDTO);
	
	int getChatRoomNoMax(int mem_no);
	
	List<MemberDTO> getAllMemList();
	
	List<MemberDTO> searchMemList(String keyword);
	
	String getMemName(int mem_no);
	
	int messenger_insertChatRoom(Chat_RoomDTO chatRoomDTO);
	
	int insertMemToChatRoom(int mem_no);
	
	int messenger_getNewChatRoomNo();
	
	String getChatRoomName(int chat_room_no);
	
	MemberDTO getMemDTO(int mem_no);
	
	List<MemberDTO> getParticipantList(Map<String,Object> map);
	
	int getMessageNoMax();
	
	int insertNoti(Messenger_NotiDTO notiDTO);
	
	int readNoti(Messenger_NotiDTO notiDTO);
	
	int getPartiCount(int chat_room_no);
	
	Chat_MessageDTO getLastMDto(int chat_room_no);
	
	int getUnreadCount(Map<String,Object> map);
	
}

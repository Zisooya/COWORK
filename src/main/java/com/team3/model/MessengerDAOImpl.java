package com.team3.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MessengerDAOImpl implements MessengerDAO {

	 @Autowired
	 private SqlSessionTemplate sqlSession;

	@Override
	public List<Chat_RoomDTO> getOneToOneChatRoomList(int mem_no) {
		
		return this.sqlSession.selectList("messengerDao.oneToOneChatRoomList",mem_no);
	}

	@Override
	public List<Chat_RoomDTO> getGroupChatRoomList(int mem_no) {
		return this.sqlSession.selectList("messengerDao.groupChatRoomList",mem_no);
	}

	@Override
	public List<Chat_MessageDTO> getMessageList(int chat_room_no) {
		return this.sqlSession.selectList("messengerDao.messageList",chat_room_no);
	}

	@Override
	public int messenger_insertMessage(Chat_MessageDTO chatMessageDTO) {
		return this.sqlSession.insert("messengerDao.messenger_insertMessage", chatMessageDTO);
	}
}

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
	public List<Chat_RoomDTO> getOneToOneChatRoomList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Chat_RoomDTO> getGroupChatRoomList() {
		// TODO Auto-generated method stub
		return null;
	}
}

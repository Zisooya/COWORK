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
		// TODO Auto-generated method stub
		return this.sqlSession.selectList("messengerDao.groupChatRoomList",mem_no);

	}
}

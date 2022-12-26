package com.team3.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team3.model.member.MemberDTO;

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

	@Override
	public int getChatRoomNoMax(int mem_no) {
		return this.sqlSession.selectOne("messengerDao.messenger_getChatRoomNoMax", mem_no);
	}

	@Override
	public List<MemberDTO> getAllMemList() {
		return this.sqlSession.selectList("messengerDao.messenger_getAllMemList");
	}

	@Override
	public List<MemberDTO> searchMemList(String keyword) {
		return this.sqlSession.selectList("messengerDao.messenger_searchMemList",keyword);
	}

	@Override
	public String getMemName(int mem_no) {
		return this.sqlSession.selectOne("messengerDao.messenger_getMemName",mem_no);
	}

	@Override
	public int messenger_insertChatRoom(Chat_RoomDTO chatRoomDTO) {
		return this.sqlSession.insert("messengerDao.messenger_insertChatRoom", chatRoomDTO);
	}

	@Override
	public int insertMemToChatRoom(int mem_no) {
		return this.sqlSession.insert("messengerDao.messenger_insertMemToChatRoom",mem_no);
	}

	@Override
	public int messenger_getNewChatRoomNo() {
		return this.sqlSession.selectOne("messengerDao.messenger_getNewChatRoomNo");
	}

	@Override
	public String getChatRoomName(int chat_room_no) {
		return this.sqlSession.selectOne("messengerDao.messenger_getChatRoomName", chat_room_no);
	}

	@Override
	public MemberDTO getMemDTO(int mem_no) {
		return this.sqlSession.selectOne("messengerDao.messenger_getMemDTO", mem_no);
	}

	@Override
	public List<MemberDTO> getParticipantList(Map<String,Object> map) {
		return this.sqlSession.selectList("messengerDao.messenger_getParticipantList", map);
	}
}

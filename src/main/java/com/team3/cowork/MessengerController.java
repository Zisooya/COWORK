package com.team3.cowork;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team3.model.Chat_MessageDTO;
import com.team3.model.Chat_RoomDTO;
import com.team3.model.MessengerDAO;
import com.team3.model.member.MemberDTO;

@Controller
public class MessengerController {

	
	@Autowired
	private MessengerDAO messengerDao;

	@RequestMapping("openChatRoom.do")
	public @ResponseBody List<Chat_MessageDTO> openChatRoom(int chat_room_no) {
		System.out.println("넘어온 chat_room_no : " + chat_room_no);

		// 채팅방 번호에 해당하는 채팅방의 메세지들 불러오기.
		List<Chat_MessageDTO> messageList = this.messengerDao.getMessageList(chat_room_no);
		
		System.out.println("List왔나요??" + messageList);
		return messageList;
	}
	
	@RequestMapping("messenger.do")
	public String messenger(HttpSession session,Model model){
		
		// 로그인된 세션 불러오기
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		
		// 현재 로그인 된 회원 번호
		int mem_no = member.getMem_no();
		
		System.out.println("로그인한 회원 번호 : "+mem_no);
		
		// 일대일 대화 목록 조회
		List<Chat_RoomDTO> oneToOneChatList = this.messengerDao.getOneToOneChatRoomList(mem_no);
		
		System.out.println("일대일 대화 목록"+oneToOneChatList);
		// 그룹 대화 목록 조회
		List<Chat_RoomDTO> groupChatList = this.messengerDao.getGroupChatRoomList(mem_no);
		System.out.println("그룹 대화 목록"+ groupChatList);
		
		model.addAttribute("oneToOneChatList", oneToOneChatList);
		model.addAttribute("groupChatList", groupChatList);

		return "messenger";
	}
	

}

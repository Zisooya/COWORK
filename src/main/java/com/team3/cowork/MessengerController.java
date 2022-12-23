package com.team3.cowork;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team3.model.AddressDAO;
import com.team3.model.Chat_MessageDTO;
import com.team3.model.Chat_RoomDTO;
import com.team3.model.DepartmentDTO;
import com.team3.model.MessengerDAO;
import com.team3.model.member.MemberDTO;

@Controller
public class MessengerController {

	
	@Autowired
	private MessengerDAO messengerDao;

	@Autowired
	private AddressDAO addressDao;	

	@RequestMapping("openChatRoom.do")
	public @ResponseBody List<Chat_MessageDTO> openChatRoom(int chat_room_no) {

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
	
	@RequestMapping("messenger_insertMessage.do") 
	public @ResponseBody int insertMessage(@RequestParam("chat_room_no") int chat_room_no,@RequestParam("sender") String sender,@RequestParam("message") String message,@RequestParam("send_date") String send_date){
		
		Chat_MessageDTO chatMessageDTO = new Chat_MessageDTO();
		
		chatMessageDTO.setChat_room_no(chat_room_no);
		chatMessageDTO.setSender(sender);
		chatMessageDTO.setMessage(message);
		chatMessageDTO.setSend_date(send_date);
		
		// DB에 메세지 저장
		int check = this.messengerDao.messenger_insertMessage(chatMessageDTO);

		if(check>0) {
			System.out.println("Chat_MessageDTO insert 성공!");
		}else {
			System.out.println("Chat_MessageDTO insert 실패");
		}	
		
		return check;
	}
	
	@RequestMapping("messenger_getChatRoomNoMax.do")
	public @ResponseBody int getChatRoomNoMax(@RequestParam("mem_no")int mem_no) {

		// 채팅방 번호에 해당하는 채팅방의 메세지들 불러오기.
		int chatRoomNoMax = this.messengerDao.getChatRoomNoMax(mem_no);
		
		System.out.println("채팅방 최댓값은???"+chatRoomNoMax);
		
		return chatRoomNoMax;
	}	
	
	@RequestMapping("messenger_getAllDeptList.do")
	public @ResponseBody List<DepartmentDTO> getAllDeptList() {

		// 채팅방 번호에 해당하는 채팅방의 메세지들 불러오기.
		List<DepartmentDTO> deptList = this.addressDao.getAllDeptList();
		
		System.out.println("deptList왔나요??" + deptList);
		return deptList;
	}		
	

}

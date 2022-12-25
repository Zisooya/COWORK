package com.team3.cowork;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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

		int chatRoomNoMax = this.messengerDao.getChatRoomNoMax(mem_no);
		
		System.out.println("채팅방 최댓값은???"+chatRoomNoMax);
		
		return chatRoomNoMax;
	}	
	
	@RequestMapping("messenger_getAllDeptList.do")
	public @ResponseBody List<DepartmentDTO> getAllDeptList() {

		List<DepartmentDTO> deptList = this.addressDao.getAllDeptList();
		
		System.out.println("deptList왔나요??" + deptList);
		return deptList;
	}		
	
	@RequestMapping("newChat.do")
	public String newChat(Model model) {
		
		// member 전체 연락처 불러오는 메소드 호출
		List<MemberDTO> memList = this.messengerDao.getAllMemList();
		model.addAttribute("memList", memList);
		
		return "newChat";
	}
	
	@RequestMapping("messenger_searchMem.do")
	public @ResponseBody List<MemberDTO> searchMem(@RequestParam ("keyword") String keyword) {
		
		System.out.println("넘어온 keyword : " + keyword);
		
		List<MemberDTO> searchMemList = this.messengerDao.searchMemList(keyword);
		
		return searchMemList;
	}
	
	@RequestMapping(value="/messenger_insertNewChatRoom", method = RequestMethod.POST, produces = "application/text; charset=UTF-8;")
	public @ResponseBody String insertNewChatRoom
	(@RequestParam (value="checkedMemArr[]") List<String> checkedMemArr, 
			@RequestParam (value="chat_room_no") int chat_room_no,
			@RequestParam (value="chat_kind") String chat_kind,
			@RequestParam(value="regdate") String regdate,
			@RequestParam (value="myNum") int myNum) {
		
		String chatRoomName = "";
		
		String memName = "";
		
		for(int i =0; i<checkedMemArr.size(); i++){

			int mem_no = Integer.parseInt(checkedMemArr.get(i));
			
			// 회원번호로 해당 회원의 이름 가져오는 메소드 호출.
			
			memName = this.messengerDao.getMemName(mem_no);
			if(i==0) {
				chatRoomName += memName;
			}else {
				chatRoomName += "," + memName;
			}

		}
		System.out.println("현재 chatRoomName >>> "+chatRoomName);
		
		// DB에 채팅방 insert하는 메소드 호출
		Chat_RoomDTO chatRoomDTO = new Chat_RoomDTO();
		
		chatRoomDTO.setChat_room_no(chat_room_no);
		chatRoomDTO.setChat_room_name(chatRoomName);
		chatRoomDTO.setChat_kind(chat_kind);
		chatRoomDTO.setRegdate(regdate);
		
		int check = this.messengerDao.messenger_insertChatRoom(chatRoomDTO);
		
		if(check>0) {
			System.out.println("채팅방 생성 성공");
		}else {
			System.out.println("채팅방 생성 실패");
		}		
		
		// 현재 사용자 포함, 체크된 모든 회원 해당 채팅방의 참여자로 DB의 chat_member 테이블에 insert.
		
		// 현재 사용자 채팅방에 추가
		int check2 = this.messengerDao.insertMemToChatRoom(myNum);
		
		if(check2>0) {
			System.out.println("현재 사용자 채팅방 참가 성공");
		}else {
			System.out.println("현재 사용자 채팅방 참가 실패");
		}
		
		int check3 = 0;
		
		// 체크된 사용자 채팅방에 추가
		for(int i =0; i<checkedMemArr.size(); i++){
			int mem_no = Integer.parseInt(checkedMemArr.get(i));
			//map.put("mem_no", mem_no);
			check3 = this.messengerDao.insertMemToChatRoom(mem_no);
			
			if(check3>0) {
				System.out.println(i + "번 째 체크된 사용자 채팅방 참가 성공");
			}else {
				System.out.println(i + "체크된 사용자 채팅방 참가 실패");
			}			
		}
		
		String result = "";
		
		if(check>0 && check2>0) {
			
			if(check3 > 0) {
				result = "새로운 대화 생성 성공";
			}
			
		}else {
			result = "새로운 대화 생성 실패";
		}
		
		return result;
	}		
	

}

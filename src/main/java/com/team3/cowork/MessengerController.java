package com.team3.cowork;


import java.util.ArrayList;
import java.util.Arrays;
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
import com.team3.model.Messenger_NotiDTO;
import com.team3.model.member.MemberDTO;
import com.team3.model.member.MemberService;

@Controller
public class MessengerController {

	@Autowired
	private MemberService service;	
	
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
		
	@RequestMapping(value="/messenger_getChatRoomName.do", method = RequestMethod.POST, produces = "application/text; charset=UTF-8;")
	public @ResponseBody String getChatRoomName(int chat_room_no) {
		
		// 채팅방 번호에 해당하는 채팅방의 이름 불러오기.
		String chatRoomName = this.messengerDao.getChatRoomName(chat_room_no);
		
		System.out.println("chatRoomName은???" + chatRoomName);
		
		return chatRoomName;
	}	
	
	@RequestMapping("messenger_getMyDTO.do")
	public @ResponseBody MemberDTO searchMem(@RequestParam ("mem_no") int mem_no) {
		
		MemberDTO myDTO = this.messengerDao.getMemDTO(mem_no);
		
		return myDTO;
	}		

	@RequestMapping("messenger_getParticipantList.do")
	public @ResponseBody List<MemberDTO> getParticipantDTO
	(@RequestParam ("chat_room_no") int chat_room_no,
	@RequestParam ("myNum") int myNum) {
		
		Map<String,Object>map = new HashMap<String,Object>();
		
		map.put("chat_room_no", chat_room_no);
		map.put("myNum", myNum);
		
		List<MemberDTO> participantList = this.messengerDao.getParticipantList(map);
		
		return participantList;
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
		
		// System.out.println("일대일 대화 목록"+oneToOneChatList);
		
		
		// 그룹 대화 목록 조회
		List<Chat_RoomDTO> groupChatList = this.messengerDao.getGroupChatRoomList(mem_no);
		//System.out.println("그룹 대화 목록"+ groupChatList);
/*		
		// 각 채팅방에 해당하는 1)참가자수, 2)마지막 메세지 날짜,마지막 메세지, 3)unread 메세지 수 조회
		int[] partiCountArr = new int[oneToOneChatList.size()];
		List<Chat_MessageDTO> messageList = new ArrayList<Chat_MessageDTO>();
		int[] unreadCountArr = new int[oneToOneChatList.size()];
		
		for(int i=0; i<oneToOneChatList.size(); i++) {
			
			// 각 채팅방 번호
			int chat_room_no = oneToOneChatList.get(i).getChat_room_no();
			
			// 1) 각 채팅방의 참가자 수 구하는 메소드 호출
			int partiCount = this.messengerDao.getPartiCount(chat_room_no);
			
			// 2) 각 채팅방의 마지막 메세지 구하는 메소드 호출
			Chat_MessageDTO lastMDto = this.messengerDao.getLastMDto(chat_room_no);
			
			// 3) 각 채팅방의 메세지 DTO에서 mem_no가 현재 사용자이고 unread 상태인 메세지의 수 조회하는 메소드 호출
			Map<String,Object>map = new HashMap<String,Object>();
			map.put("chat_room_no", chat_room_no);
			map.put("myNum", mem_no);
			
			int unreadCount = this.messengerDao.getUnreadCount(map);
			
			System.out.println("채팅방 번호:"+chat_room_no+" / 파티원수:" + partiCount+" / 마지막메세지:" + lastMDto+" / 안읽은 메세지 수:" + unreadCount);
			
			// 구한 데이터를 각각 배열과 리스트에 추가
			partiCountArr[i] = partiCount;
			
			if(lastMDto != null) {
				messageList.add(i, lastMDto);
			}else {
				Chat_MessageDTO nullDto = new Chat_MessageDTO(); 
				nullDto.setMessage("");
				nullDto.setSend_date("");
				messageList.add(i, nullDto);
			}
			
			unreadCountArr[i] = unreadCount;
			
		}
		
*/		

		
		model.addAttribute("oneToOneChatList", oneToOneChatList);
		//model.addAttribute("partiCountArr", partiCountArr);
		//model.addAttribute("messageList", messageList);
		//model.addAttribute("unreadCountArr", unreadCountArr);
		model.addAttribute("groupChatList", groupChatList);

		return "messenger";
	}
	
	// 이거 참고만 하고 나중에 지우기.
	public void newChatRoomName(List<Chat_RoomDTO> list) {
		// 넘겨줄 채팅방 이름 재작업
		String memName;	// 나 포함 참가자
		String[] participant;  // 나 포함 참가자
		String newChatRoomName;	// 채팅방 이름(나를 제외한 참가자 이름들) 채팅방 이름
		
		// 각 DTO 반복 실행
		for(int i=0; i<list.size(); i++) {
			
			memName = list.get(i).getChat_room_name();
			participant = memName.split(",");
			
			int lastIndex = (participant.length-1);
			
		// 채팅방 생성 시 채팅방 이름: 마지막 인덱스가 '나'	
		//System.out.println(i+"번 째 dto 삭제 전: " + Arrays.toString(participant));
		
		List<String> strList = new ArrayList<>(Arrays.asList(participant));
		strList.remove(lastIndex);
		participant = strList.toArray(new String[0]);

		//System.out.println(i+"번 째 dto 삭제 후: " + Arrays.toString(participant));
		newChatRoomName = Arrays.toString(participant);
		
		//System.out.println(i+"번 째 dto 새로운 채팅방 이름: " + newChatRoomName );
		
		// 나를 제외한 참가자 이름을 채팅방 이름으로 set
		list.get(i).setChat_room_name(newChatRoomName);
		
		
		}			
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
		
		// DB에 저장된 메세지의 message_no 컬럼값 리턴
		int message_no = this.messengerDao.getMessageNoMax();
		
		return message_no;
	}
	
	@RequestMapping(value="/messenger_insertNoti.do", method = RequestMethod.POST)
	public @ResponseBody int insertNoti(@RequestBody Messenger_NotiDTO notiDTO) {
		
		// DB의 messenger_noti테이블에 데이터 저장. 
		int check = this.messengerDao.insertNoti(notiDTO);
		
		if(check>0) {
			System.out.println("현재 사용자의 noti table insert 성공");
		}		
		
		// 같은 채팅방에 참여 중인 회원을 구하는 메소드 호출
		int myNum = notiDTO.getMem_no();
		int chat_room_no = notiDTO.getChat_room_no();
		
		Map<String,Object>map = new HashMap<String,Object>();
		
		map.put("chat_room_no", chat_room_no);
		map.put("myNum", myNum);
		
		List<MemberDTO> participantList = this.messengerDao.getParticipantList(map);
		
		// 참여중인 모든 회원 번호 - messenger_noti테이블에 데이터 저장.
		for(int i =0; i<participantList.size(); i++){

			//System.out.println("참여자: "+participantList.get(i));
			notiDTO.setMem_no(participantList.get(i).getMem_no());
			
			check = this.messengerDao.insertNoti(notiDTO);
			
			if(check>0) {
				// System.out.println((i+1)+"번 째 참여자 noti table insert 성공");
			}

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
	
	@RequestMapping(value="/messenger_insertNewChatRoom.do", method = RequestMethod.POST)
	public @ResponseBody int insertNewChatRoom
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
		
		// 현재 사용자 채팅방에 추가(=> 프론트 단에서 체크 시 자신도 추가되게 해서 안해도 됨.)
/*		
		int check2 = this.messengerDao.insertMemToChatRoom(myNum);
		
		if(check2>0) {
			System.out.println("현재 사용자 채팅방 참가 성공");
		}else {
			System.out.println("현재 사용자 채팅방 참가 실패");
		}
 */		
		int check3 = 0;
		
		// 체크된 사용자 채팅방에 추가
		for(int i =0; i<checkedMemArr.size(); i++){
			int mem_no = Integer.parseInt(checkedMemArr.get(i));
			check3 = this.messengerDao.insertMemToChatRoom(mem_no);
			
			if(check3>0) {
				System.out.println(i + "번 째 체크된 사용자 채팅방 참가 성공");
			}else {
				System.out.println(i + "체크된 사용자 채팅방 참가 실패");
			}			
		}
		
		// 채팅방 열어주기 위해 방금 생성된 채팅방 번호 넘겨주기.
		int newChatRoomNo = this.messengerDao.messenger_getNewChatRoomNo();
		
		return newChatRoomNo;
	}		
	
	@RequestMapping("messenger_getNotiCount.do")
	public @ResponseBody int getNotiCount(@RequestParam ("myNum") int myNum) {
		
	int notiCount = this.service.getNotiCount(myNum);
		
		return notiCount;
	}	
	
	@RequestMapping(value="/messenger_readNoti.do", method = RequestMethod.POST)
	public @ResponseBody int readNoti(@RequestBody Messenger_NotiDTO notiDTO) {
		
		int check = this.messengerDao.readNoti(notiDTO);
		
		return check;
	}	
		
		

}

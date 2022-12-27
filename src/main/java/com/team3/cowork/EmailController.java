package com.team3.cowork;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.team3.model.EmailDTO;
import com.team3.model.EmailService;
import com.team3.model.PageDTO;
import com.team3.model.mail.CommException;
import com.team3.model.mail.PaginationMail;
import com.team3.model.member.MemberDTO;

import lombok.AllArgsConstructor;

@Controller
public class EmailController {

	@Autowired
	private EmailService mailService;

	@RequestMapping("mail_list.do")
	public String list() {
		return "mail_list";
	}

	@RequestMapping("send.do")
	public String inserString() {
		return "mail/sendForm";
	}

	// 메일 작성하기
	@RequestMapping("insert.do")
	public String insertMail(EmailDTO dto, HttpServletRequest request, HttpSession session,
			@RequestParam(name = "uploadFile", required = false) MultipartFile file) {

		if (!file.getOriginalFilename().equals("")) {
			String filepath = saveFile(file, request);

			if (filepath != null) {
				dto.setFilename(file.getOriginalFilename());
				dto.setFilepath(filepath);
			}
		}

		mailService.insertMail(dto);

		session.setAttribute("msg", "메일을 성공적으로 전송했습니다.");

		return "redirect:sendList.do";
	}

	// 파일 저장
	private String saveFile(MultipartFile file, HttpServletRequest request) {

		String resources = request.getSession().getServletContext().getRealPath("resources");
		String savePath = resources + "//mail_files//";

		String filename = file.getOriginalFilename();
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

		String ext = filename.substring(filename.lastIndexOf("."));
		String filepath = currentTime + ext;

		try {
			file.transferTo(new File(savePath + filepath));

		} catch (IOException e) {
			e.printStackTrace();
			throw new CommException("file upload error");
		}

		return filepath;
	}

	// 보낸메일함
	@RequestMapping("sendList.do")
	public String selectSendMailList(@RequestParam(value = "page", required = false, defaultValue = "1") int Page,
			Model model, HttpServletRequest request) {

		MemberDTO mem = (MemberDTO) request.getSession().getAttribute("member");

		// 현재 로그인 된 회원 번호
		int mem_no = mem.getMem_no();

		System.out.println("로그인한 회원 번호 : " + mem_no);

		int listCount = mailService.selectSendMailListCount(mem.getMem_name());

		PageDTO pi = PaginationMail.getPageInfo(listCount, Page, 10, 10);

		ArrayList<EmailDTO> sendList = mailService.selectSendMailList(pi, mem.getMem_name());

		model.addAttribute("sendList", sendList);
		model.addAttribute("pi", pi);

		return "mail/sendMailListView";
	}

	// 보낸 메일 보기
	@RequestMapping("sendDetail.do")
	public ModelAndView selectSendMail(int mno, ModelAndView mv) {

		EmailDTO m = mailService.selectSendMail(mno);
		
		mv.addObject("m", m).setViewName("mail/sendMailDetailView");

		return mv;
	}

	// 받은 메일함
	@RequestMapping("receiveList.do")
	public String selectReceiveMailList(@RequestParam(value = "page", required = false, defaultValue = "1") int Page,
			Model model, HttpServletRequest request) {

		MemberDTO mem = (MemberDTO) request.getSession().getAttribute("member");

		// 현재 로그인 된 회원 번호
		int mem_no = mem.getMem_no();

		System.out.println("로그인한 회원 번호 : " + mem_no);

		int listCount = mailService.selectReceiveMailListCount(mem.getMem_name());

		PageDTO pi = PaginationMail.getPageInfo(listCount, Page, 10, 10);

		ArrayList<EmailDTO> receiveList = mailService.selectReceiveMailList(pi, mem.getMem_name());

		model.addAttribute("receiveList", receiveList);
		model.addAttribute("pi", pi);

		return "mail/receiveMailListView";
	}

	// 받은 메일 보기
	@RequestMapping("receiveDetail.do")
	public String selectReceiveMail(int mno, Model model, HttpServletRequest request) {

		// 조회수 올려서 읽음처리하기
		EmailDTO m = mailService.selectReceiveMail(mno);

		// 보낸사람
		MemberDTO sendEmp = mailService.selectSendEmp(mno);

		model.addAttribute("sendEmp", sendEmp);
		model.addAttribute("m", m);

		return "mail/receiveMailDetailView";
	}
	
	// 보낸메일보기->메일다시보내기
	@RequestMapping("resend.do")
	public String resendMail(@RequestParam(name = "mno") int mno) {

		// 보낸메일 가져오기
		EmailDTO m = mailService.selectSendMail(mno);

		// 아이디 가져오기
		MemberDTO id = mailService.getReceiver(m.getEml_to());

		m.setEml_title("[재전송] " + m.getEml_title());
		m.setEml_to(id.getMem_id());

		mailService.resendMail(m);

		return "redirect:sendList.do";
	}

	// 보낸메일 전달 화면
	@RequestMapping("sendDelivery.do")
	public ModelAndView sendDelivery(EmailDTO m, HttpServletRequest request,
			@RequestParam(name = "mno", required = false) int mno, ModelAndView mv) {
		
		MemberDTO mem = (MemberDTO) request.getSession().getAttribute("member");

		// 현재 로그인 된 회원 번호
		int mem_no = mem.getMem_no();

		System.out.println("로그인한 회원 번호 : " + mem_no);

		int listCount = mailService.selectReceiveMailListCount(mem.getMem_name());
		
		EmailDTO sendMail = mailService.selectSendMail(mno);

		mv.addObject("sendMail", sendMail).setViewName("mail/sendDeliveryForm");

		return mv;
	}
	
	// 받은메일 전달 화면
	@RequestMapping("receiveDelivery.do")
	public String receiveDelivery(EmailDTO m, HttpServletRequest request,
			@RequestParam(name = "mno", required = false) int mno, Model model) {

		EmailDTO receiveMail = mailService.selectSendMail(mno);
		
		//보낸사람
		MemberDTO sendEmp = mailService.selectSendEmp(mno);

		model.addAttribute("receiveMail", receiveMail);
		model.addAttribute("sendEmp", sendEmp);

		return "mail/receiveDeliveryForm";
	}
	

	// 받은,보낸메일 전달
	@RequestMapping("insertDelivery.do")
	public String insertSendDelivery(EmailDTO m, HttpServletRequest request, HttpSession session,
			@RequestParam(name = "reUploadFile", required = false) MultipartFile file) {

		if (!file.getOriginalFilename().equals("")) {
			if (m.getFilepath() != null) {
				deleteFile(m.getFilepath(), request);
			}

			String changeName = saveFile(file, request);
			m.setFilename(file.getOriginalFilename());
			m.setFilepath(changeName);
		}

		mailService.insertSendDelivery(m);
		
		session.setAttribute("msg","메일을 성공적으로 전달했습니다.");

		return "redirect:sendList.do";
	}

	// 파일 지우기
	private void deleteFile(String fileName, HttpServletRequest request) {

		String resources = request.getSession().getServletContext().getRealPath("resources");
		String savePath = resources + "\\mail_files\\";

		File deleteFile = new File(savePath + fileName);
		deleteFile.delete();

	}

	// 보낸메일 휴지통으로 이동
	@RequestMapping("wasteSendMail.do")
	public String wasteSendMail(@RequestParam(name = "mno") int mno, HttpSession session) {

		mailService.wasteSendMail(mno);
		
		session.setAttribute("msg","메일을 휴지통으로 이동했습니다.");
		
		return "redirect:sendList.do";

	}
	
	// 휴지통 리스트
	@RequestMapping("waste.do")
	public String selectWasteMailList(@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage, Model model,
										HttpServletRequest request) {
		
		MemberDTO mem = (MemberDTO) request.getSession().getAttribute("member");
		
		// 현재 로그인 된 회원 번호
		int mem_no = mem.getMem_no();

		System.out.println("로그인한 회원 번호 : " + mem_no);

		int listCount = mailService.selectWasteMailListCount(mem.getMem_name());

		PageDTO pi = PaginationMail.getPageInfo(listCount, currentPage, 10, 10);

		ArrayList<EmailDTO> wasteList = mailService.selectWasteMailList(pi, mem.getMem_name());

		model.addAttribute("wasteList", wasteList);
		model.addAttribute("pi", pi);
		
		return "mail/wasteMailListView";
	}
	
	// 받은메일에 답장폼
	@RequestMapping("sendReply.do")
	public String sendReply(EmailDTO m, HttpServletRequest request,
			@RequestParam(name = "mno", required = false) int mno, Model model) {

		EmailDTO receiveMail = mailService.selectReceiveMail(mno);

		// 보낸사람
		MemberDTO sendEmp = mailService.selectSendEmp(mno);

		model.addAttribute("receiveMail", receiveMail);
		model.addAttribute("sendEmp", sendEmp);

		return "mail/replyForm";
	}

	// 받은 메일 답장보내기
	@RequestMapping("insertReply.do")
	public String insertReply(EmailDTO m, HttpServletRequest request, HttpSession session,
			@RequestParam(name = "reUploadFile", required = false) MultipartFile file) {

		if (!file.getOriginalFilename().equals("")) {
			if (m.getFilepath() != null) {
				deleteFile(m.getFilepath(), request);
			}

			String changeName = saveFile(file, request);
			m.setFilename(file.getOriginalFilename());
			m.setFilepath(changeName);
		}

		mailService.insertReply(m);

		session.setAttribute("msg", "답장을 성공적으로 전송했습니다.");

		return "redirect:sendList.do";
	}

	// 받은메일보기에서 휴지통으로 이동
	@RequestMapping("wasteReceiveMail.do")
	public String wasteReceiveMail(@RequestParam(name = "mno") int mno, HttpSession session) {

		mailService.wasteReceiveMail(mno);

		session.setAttribute("msg", "메일을 휴지통으로 이동했습니다.");

		return "redirect:receiveList.do";

	}

	// 휴지통메일 보기
	@RequestMapping("wasteDetail.do")
	public String selectWasteMail(HttpSession session, int mno, Model model) {
		
		// 로그인된 세션 불러오기
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		
		// 현재 로그인 된 회원 번호
		int mem_no = member.getMem_no();
		
		System.out.println("로그인한 회원 번호 : "+mem_no);

		EmailDTO m = mailService.selectSendMail(mno);

		// 보낸사람
		MemberDTO sendEmp = mailService.selectSendEmp(mno);
		MemberDTO receiveEmp = mailService.selectReceiveEmp(mno);
		
		model.addAttribute("m", m);
		model.addAttribute("sendEmp", sendEmp);
		model.addAttribute("receiveEmp", receiveEmp);

		return "mail/wasteMailDetailView";
	}

	// 휴지통에서 복구
	@RequestMapping("returnMail.do")
	public String returnMail(int mno, String empId, HttpSession session) {

		EmailDTO m = mailService.selectMail(mno);

		// 작성자인경우
		if (m.getEml_from().equals(empId)) {

			mailService.returnSendMail(mno);

			session.setAttribute("msg", "메일을 휴지통에서 복구했습니다.");

			return "redirect:sendList.do";

			// 수신자인경우
		} else {

			mailService.returnReceiveMail(mno);

			session.setAttribute("msg", "메일을 휴지통에서 복구했습니다.");

			return "redirect:receiveList.do";

		}
	}

	// 휴지통에서 영구삭제
	@RequestMapping("wasteMail.do")
	public String wasteMail(int mno, String empId, HttpSession session) {

		EmailDTO m = mailService.selectSendMail(mno);

		// 작성자인경우
		if (m.getEml_from().equals(empId)) {

			// 수신자 상태확인
			if (m.getReceiver_status() == 3) {

				mailService.wasteMail(mno);

			} else {

				mailService.updateWriter(mno);

			}

			// 수신자인경우
		} else {

			// 발신자상태확인
			if (m.getWriter_status() == 3) {

				mailService.wasteMail(mno);

			} else {

				mailService.updateReceiver(mno);

			}
		}

		return "redirect:waste.do";

	}

	// 주소록 - 부서코드로 사원리스트 출력
	@ResponseBody
	@RequestMapping(value = "empList.do", produces = "application/json; charset=UTF-8")
	public String selectList(String dept_code) {

		ArrayList<MemberDTO> list = this.mailService.selectMemberDTOList(dept_code);

		JSONArray jrr = new JSONArray();

		JSONObject obj = null;

		if (list != null) {
			for (MemberDTO mem : list) {
				obj = new JSONObject();

				obj.put("mem_no", mem.getMem_no());
				obj.put("mem_name", mem.getMem_name());
				obj.put("mem_position", mem.getMem_position());
				obj.put("mem_rank", mem.getMem_rank());

				jrr.put(obj);
			}
		}

		JSONObject jsonMap = null;

		if (dept_code != null && jrr != null) {
			jsonMap = new JSONObject();

			jsonMap.put("jrr", jrr);
			jsonMap.put("dept_code", dept_code);
		}
		System.out.println("dept_code >> " + dept_code);
		return jsonMap.toString();
	}
}

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

	@RequestMapping("mail_list.do") public String list() { return "mail_list"; }
	
	@RequestMapping("send.do")
	public String inserString() {
		return "mail/sendForm";
	}
	// 메일 작성하기
	@RequestMapping("insert.do")
	public String insertMail(EmailDTO dto, HttpServletRequest request, HttpSession session,
			@RequestParam(name = "uploadFile", required = false) MultipartFile file) throws Exception {

		if (!file.getOriginalFilename().equals("")) {
			String changeName = saveFile(file, request);

			if (changeName != null) {
				dto.setFilename(file.getOriginalFilename());
				dto.setFilepath(changeName);
			}
		}

		mailService.insertMail(dto);
		
		session.setAttribute("msg","메일을 성공적으로 전송했습니다.");

		return "redirect:sendList.do";
	}
	
	// 파일 저장
	private String saveFile(MultipartFile file, HttpServletRequest request) {

		String resources = request.getSession().getServletContext().getRealPath("resources");
		String savePath = resources + "\\mail_files\\";

		String originalName = file.getOriginalFilename();
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

		String ext = originalName.substring(originalName.lastIndexOf("."));
		String changeName = currentTime + ext;

		try {
			file.transferTo(new File(savePath + changeName));

		} catch (IOException e) {
			e.printStackTrace();
			throw new CommException("file upload error");
		}

		return changeName;
	}
	
	// 보낸메일함
	@RequestMapping("sendList.do")
	public String selectSendMailList(
			@RequestParam(value = "Page", required = false, defaultValue = "1") int Page, Model model,
			HttpServletRequest request) {

		MemberDTO mem = (MemberDTO) request.getSession().getAttribute("loginUser");

		int listCount = mailService.selectSendMailListCount(mem.getMem_id());

		PageDTO pi = PaginationMail.getPageInfo(listCount, Page, 10, 10);

		ArrayList<EmailDTO> sendList = mailService.selectSendMailList(pi, mem.getMem_id());

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
	public String selectReceiveMailList(
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage, Model model,
			HttpServletRequest request) {

		MemberDTO mem = (MemberDTO) request.getSession().getAttribute("loginUser");

		int listCount = mailService.selectReceiveMailListCount(mem.getMem_id());

		PageDTO pi = PaginationMail.getPageInfo(listCount, currentPage, 10, 10);

		ArrayList<EmailDTO> receiveList = mailService.selectReceiveMailList(pi, mem.getMem_id());

		model.addAttribute("receiveList", receiveList);
		model.addAttribute("pi", pi);

		return "mail/receiveMailListView";
	}

	// 받은 메일 보기
	@RequestMapping("receiveDetail.do")
	public String selectReceiveMail(int mno, Model model, HttpServletRequest request) {

		// 조회수 올려서 읽음처리하기
		EmailDTO m = mailService.selectReceiveMail(mno);
		
		//보낸사람
		MemberDTO sendEmp = mailService.selectSendEmp(mno);
		
		model.addAttribute("sendEmp", sendEmp);
		model.addAttribute("m", m);

		return "mail/receiveMailDetailView";
	}

	
	//주소록 - 부서코드로 사원리스트 출력
	@ResponseBody
	@RequestMapping(value = "empList.do", produces="application/json; charset=UTF-8")
	public String selectList(String dept_code) {
		
		ArrayList<MemberDTO> list = this.mailService.selectMemberDTOList(dept_code);
		
		JSONArray jrr = new JSONArray();
		
		JSONObject obj = null;

		if(list != null) {
			for(MemberDTO mem : list) {
				obj = new JSONObject();
				
				obj.put("mem_name", mem.getMem_name());
				obj.put("mem_id", mem.getMem_id());
				obj.put("mem_position", mem.getMem_position());
				obj.put("mem_rank", mem.getMem_rank());
			 
				jrr.put(obj);
		 	}
		}
		
		JSONObject jsonMap = null;
		
		if(dept_code != null && jrr != null) {
			jsonMap = new JSONObject();
			
			jsonMap.put("jrr", jrr);
			jsonMap.put("dept_code", dept_code);
		}
		System.out.println("dept_code >> " + dept_code);
		return jsonMap.toString();
	}
}

package com.team3.cowork;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.team3.model.DepartmentDTO;
import com.team3.model.Messenger_NotiDTO;
import com.team3.model.TeamDTO;
import com.team3.model.member.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CoworkController {

	@Autowired
	private MemberDAO dao;

	@Autowired
	private MemberService service;

	@Autowired
	private Mem_Upload mem_upload;

	@Autowired
	private UserMailSendService mailSender;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@RequestMapping("main.do")
	public String main() {
		return "main";
	}

	@RequestMapping("member_login_ok.do")
	public String loginOk(@ModelAttribute MemberDTO dto, @RequestParam("mem_id") String mem_id, @RequestParam("mem_pwd") String mem_pwd, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();

		if (session.getAttribute("member") != null) {
			session.removeAttribute("member");
		}

		MemberDTO result = service.memberLogin(mem_id, mem_pwd);
		
		// 로그인 시 메신저 알림 세션에 저장하기_Jisoo
		String memberId = dto.getMem_id();
		int mem_no = this.service.getMemNo(memberId);
		List<Messenger_NotiDTO> notiDtoList = this.service.getMemNotiDTO(mem_no);
		int notiCount = this.service.getNotiCount(mem_no);
		
		if (result != null) {
			// 로그인 시 메신저 알림 세션에 저장하기_Jisoo
			session.setAttribute("noti", notiDtoList);
			session.setAttribute("notiCount", notiCount);
			
			session.setAttribute("member", result);
			model.addAttribute("msg", null);
			model.addAttribute("url", "/main.do");
		} else {
			model.addAttribute("msg", "아이디 또는 비밀번호가 올바르지 않습니다.");
			model.addAttribute("url", "/");
		}
		return "member/msg";
	}

	@RequestMapping("member_logout.do")
	public String logout(HttpSession session) {
		service.memberLogout(session);

		return "redirect:/";
	}

	@RequestMapping("member_join.do")
	public String join(Model model) {
		List<DepartmentDTO> deptList = this.service.getDeptList();
		List<TeamDTO> teamList = this.service.getTeamList();

		model.addAttribute("deptList", deptList);
		model.addAttribute("teamList", teamList);

		return "member/join";
	}

	@RequestMapping(value = "member_join_ok.do", method = RequestMethod.POST, headers = ("content-type=multipart/*"))
	public String joinOk(@ModelAttribute MemberDTO dto, MultipartHttpServletRequest mRequest, HttpSession session, Model model) {
		String fileName = mem_upload.fileUpload(mRequest, session);
		if (fileName != null) {
			dto.setMem_image(fileName);
		}

		int result = service.memberJoin(dto);

		if (result > 0) {
			return "redirect:/";
		} else {
			model.addAttribute("msg", "회원가입 오류");
			model.addAttribute("url", "/");
			return "member/msg";
		}
	}

	@RequestMapping("member_idCheck.do")
	@ResponseBody
	public void idCheck(String mem_id, HttpServletResponse response) throws IOException {
		int result = 0;

		if (service.idCheck(mem_id) != 0) {
			result = 1;
		}
		response.getWriter().print(result);
	}

	@RequestMapping("member_findId.do")
	public String memberFindId() {
		return "member/findId";
	}

	@RequestMapping("member_findId_ok.do")
	public ModelAndView memberFindIdOk(@ModelAttribute MemberDTO dto) {
		ModelAndView mav = new ModelAndView();

		String id = service.memberFindId(dto);

		if (id != null) {
			mav.setViewName("member/getId");
			mav.addObject("memberFindId", id);
		} else {
			mav.setViewName("member/msg");
			mav.addObject("msg", "등록되지 않은 회원정보입니다.");
			mav.addObject("url", "/member_findId.do");
		}

		return mav;
	}

	@RequestMapping("member_findPwd.do")
	public String memberFindPwd() {
		return "member/findPwd";
	}

	@RequestMapping("member_findPwd_ok.do")
	@ResponseBody
	public void memberFindPwdOk(@RequestParam("mem_id") String mem_id, @RequestParam("mem_email") String mem_email, HttpServletResponse response) throws IOException {
		int result = 0;

		if (mailSender.mailSendWithPassword(mem_id, mem_email) != 0) {
			result = 1;
		}

		response.getWriter().print(result);
	}

	@RequestMapping("myPage.do")
	public String myPage() {
		return "member/myPage";
	}

	@RequestMapping("myPage_edit.do")
	public String myPageEdit(Model model) {
		List<DepartmentDTO> deptList = this.service.getDeptList();
		List<TeamDTO> teamList = this.service.getTeamList();

		model.addAttribute("deptList", deptList);
		model.addAttribute("teamList", teamList);

		return "member/edit";
	}

	@RequestMapping("myPage_edit_ok.do")
	public String myPageEditOk(@ModelAttribute MemberDTO dto, MultipartHttpServletRequest mRequest, HttpSession session, HttpServletRequest request) {
		String fileName = mem_upload.fileUpload(mRequest, session);
		if (fileName != null) {
			dto.setMem_image(fileName);
		}
		if (session.getAttribute("member") != null) {
			service.memberEdit(dto);
			MemberDTO updateMember = dao.selectMember(dto.getMem_id());
			request.getSession().setAttribute("member", updateMember);
		}
		System.out.println("바뀐 세션값 >> " + session.getAttribute("member"));

		return "redirect:/main.do";
	}

	@RequestMapping("myPage_delete.do")
	public String myPageDelete() {
		return "member/delete";
	}

	@RequestMapping("myPage_delete_ok.do")
	public String myPageDeleteOk(@ModelAttribute MemberDTO dto, HttpSession session, Model model) {
		String mem_id = ((MemberDTO)session.getAttribute("member")).getMem_id();

		String sessionPwd = ((MemberDTO)session.getAttribute("member")).getMem_pwd();
		String dtoPwd = dto.getMem_pwd();

		if (passwordEncoder.matches(dtoPwd, sessionPwd)) {
			service.memberDelete(mem_id);
			session.invalidate();

			model.addAttribute("msg", "회원이 정상적으로 탈퇴되었습니다.");
			model.addAttribute("url", "/");
			return "member/msg";
		} else {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			model.addAttribute("url", "/myPage_delete.do");
			return "member/msg";
		}
	}
}

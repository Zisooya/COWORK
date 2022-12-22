package com.team3.cowork;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.team3.model.member.Mem_Upload;
import com.team3.model.member.MemberDTO;
import com.team3.model.member.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CoworkController {

	@Autowired
	private MemberService service;

	@Autowired
	private Mem_Upload mem_upload;

	@RequestMapping("main.do")
	public String main() {
		return "main";
	}

	@RequestMapping("member_login_ok.do")
	public String loginOk(@ModelAttribute MemberDTO dto, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();

		MemberDTO result = service.memberLogin(dto);

		if (result != null) {
			session.setAttribute("member", result);
			model.addAttribute("msg", null);
			model.addAttribute("url", "main.do");
		} else {
			model.addAttribute("msg", "아이디 또는 비밀번호가 올바르지 않습니다.");
			model.addAttribute("url", "/");
		}
		return "member/msg";
	}

	/*@RequestMapping("member_loginCheck.do")
	@ResponseBody
	public void loginCheck(@ModelAttribute MemberDTO dto, HttpServletResponse response) throws IOException {
		MemberDTO check = service.loginCheck(dto);

		System.out.println("check는 >> " + check);
		String str = "";

		if (check != null) {
			if (dto.getMem_pwd().equals(check.getMem_pwd())) {
				str = "true";
			} else {
				str = "false";
			}
		}

		response.getWriter().print(str);
	}*/

	@RequestMapping("member_logout.do")
	public String logout(HttpSession session) {
		service.memberLogout(session);

		return "redirect:/";
	}

	@RequestMapping("member_join.do")
	public String join() {

		return "member/join";
	}

	@RequestMapping(value = "member_join_ok.do", method = RequestMethod.POST, headers = ("content-type=multipart/*"))
	public String joinOk(@ModelAttribute MemberDTO dto, MultipartHttpServletRequest mRequest, HttpSession session) {
		String fileName = mem_upload.fileUpload(mRequest, session);
		if (fileName != null) {
			dto.setMem_image(fileName);
		}
		service.memberJoin(dto);

		return "redirect:/";
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

	@RequestMapping("member_edit.do")
	public ModelAndView memberEdit(@RequestParam String mem_id) {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("member/edit");
		mav.addObject("memberEdit", service.memberDetail(mem_id));

		return mav;
	}

	@RequestMapping("member_edit_ok.do")
	public String memberEditOk(@ModelAttribute MemberDTO dto) {
		service.memberEdit(dto);

		return "redirect:member_edit.do?mem_id=" + dto.getMem_id();
	}

	@RequestMapping("member_delete.do")
	public String memberDelete() {
		return "member/delete";
	}

	@RequestMapping("member_delete_ok.do")
	public String memberDeleteOk(@RequestParam String mem_id, HttpSession session) {
		service.memberDelete(mem_id, session);

		return "redirect:/";
	}

	@RequestMapping("member_findId.do")
	public String memberFindId() {
		return "member/findId";
	}

	@RequestMapping("member_findId_ok.do")
	public ModelAndView memberFindIdOk(@ModelAttribute MemberDTO dto) {
		ModelAndView mav = new ModelAndView();

		String id = service.memberFindId(dto);

		mav.setViewName("member/getId");
		mav.addObject("memberFindId", id);

		return mav;
	}

	@RequestMapping("member_findPwd.do")
	public String memberFindPwd() {
		return "member/findPwd";
	}

	@RequestMapping("member_findPwd_ok.do")
	public ModelAndView memberFindPwdOk(@ModelAttribute MemberDTO dto) {
		ModelAndView mav = new ModelAndView();

		String pwd = service.memberFindPwd(dto);

		mav.setViewName("member/getPwd");
		mav.addObject("memberFindPwd", pwd);

		return mav;
	}

	@RequestMapping("myPage.do")
	public String myPage() {
		return "myPage";
	}
}

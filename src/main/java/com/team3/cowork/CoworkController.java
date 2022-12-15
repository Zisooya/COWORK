package com.team3.cowork;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.team3.model.*;
import com.team3.model.member.MemberDAO;
import com.team3.model.member.MemberDTO;
import com.team3.model.member.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CoworkController {

	@Autowired
	private MemberDAO dao;

	/*
	 * @Autowired private MemberService service;
	 */
	 @RequestMapping("drag.do")
	 public String dragetest() {
		 return "projects_include/drag";
	 }
	

	@RequestMapping("member_login.do")	// 임시로 만든 메서드임. 추후 로그인 화면을 시작페이지로 변경 예정.
	public String login() {
		return "member/login";
	}

	@RequestMapping("member_login_ok.do")
	public String loginOk(@ModelAttribute MemberDTO dto, HttpServletRequest request) {
		HttpSession session = request.getSession();

		MemberDTO result = service.memberLogin(dto);

		if (result != null) {
			session.setAttribute("member", result);
			return "redirect:/";
		} else {
			return "redirect:member_login.do";
		}
	}

	@RequestMapping("member_logout.do")
	public String logout(HttpSession session) {
		service.memberLogout(session);

		return "redirect:member_login.do";
	}

	@RequestMapping("member_join.do")
	public String join() {

		return "member/join";
	}

	@RequestMapping("member_join_ok.do")
	public String joinOk(@ModelAttribute MemberDTO dto) {
		service.memberJoin(dto);
		return "redirect:member_login.do";
	}

	@RequestMapping("member_idCheck.do")
	@ResponseBody
	public void checkId(String mem_id, HttpServletResponse response) throws IOException {
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

		return "redirect:member_login.do";
	}

	@RequestMapping("member_findId.do")
	public String memberFindId() {
		return "member/findId";
	}

	@RequestMapping("member_findId_ok.do")
	public ModelAndView memberFindIdOk(@ModelAttribute MemberDTO dto) {
		ModelAndView mav = new ModelAndView();

		List<MemberDTO> list = service.memberFindId(dto);

		mav.setViewName("member/login");
		mav.addObject("memberFindId", list);

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

		mav.setViewName("member/login");
		mav.addObject("memberFindPwd", pwd);

		return mav;
	}
}

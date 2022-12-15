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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
		return "login";
	}

	@RequestMapping("member_login_ok.do")
	public String loginOk(MemberDTO dto, HttpServletRequest request) {
		HttpSession session = request.getSession();

		MemberDTO login = dao.login(dto);

		if (login == null) {
			session.setAttribute("member", null);
		} else {
			session.setAttribute("member", login);
		}
		return "main";
	}

	@RequestMapping("member_logout.do")
	public ModelAndView logout(HttpSession session) {
		dao.logout(session);

		ModelAndView mav = new ModelAndView();

		mav.setViewName("login");
		mav.addObject("msg", "logout");

		return mav;
	}

	@RequestMapping("member_join.do")
	public String join() {
		return "join";
	}

	@RequestMapping("member_join_ok.do")
	public ModelAndView joinOk(MemberDTO dto) {
		ModelAndView mav = new ModelAndView();

		dao.join(dto);
		mav.setViewName("login");

		return mav;
	}

	@RequestMapping("member_idCheck.do")
	@ResponseBody
	public int checkId(String mem_id) {
		return dao.checkId(mem_id);
	}
}

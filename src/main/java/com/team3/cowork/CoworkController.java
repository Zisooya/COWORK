package com.team3.cowork;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.team3.model.MemberDAO;
import com.team3.model.MemberDTO;

@Controller
public class CoworkController {

	@Autowired
	private MemberDAO dao;
	
	@RequestMapping("testDB.do")
	public String testDB(Model model) {
		MemberDTO dto = this.dao.testDB();
		model.addAttribute("Test", dto);
		return "testDB";
	}

	@RequestMapping("calendar.do")
	public String calendarMain(Model model) {

	}

	@RequestMapping("login.do")
	public String login(Model model) {
		return "login";
	}
}

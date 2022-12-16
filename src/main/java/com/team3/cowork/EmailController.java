package com.team3.cowork;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.team3.model.EmailDAO;

@Controller
public class EmailController {
	
	@Autowired
	private EmailDAO mailService; 

	@RequestMapping("mail_list.do") public String list() { return "mail_list"; }
	
	@RequestMapping("send.do")
	public String inserString() {
		return "mail/sendForm";
	}
	
}

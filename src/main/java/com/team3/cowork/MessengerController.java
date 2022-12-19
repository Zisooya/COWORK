package com.team3.cowork;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class MessengerController {

	
	//@Autowired
//	private AddressDAO addressDao;

	@RequestMapping("messenger.do")
	public String messenger(Model model){
		//member.mem_no
		
		// 일대일 대화 목록 조회
		
		// 그룹 대화 목록 조회
		
		return "messenger";
	}
	

}

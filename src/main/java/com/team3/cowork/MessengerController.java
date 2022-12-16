package com.team3.cowork;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.team3.model.AddressDAO;

@Controller
public class MessengerController {

	
	@Autowired
//	private AddressDAO addressDao;

	@RequestMapping("messenger.do")
	public String messenger(){
		return "messenger";
	}
}

package com.team3.model;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.team3.model.member.MemberDTO;

@Repository
public interface EmailService {
	
	void insertMail(EmailDTO m);
	
	EmailDTO selectSendMail(int mno);
	
	int selectSendMailListCount(String mem_id);
	
	ArrayList<EmailDTO> selectSendMailList(PageDTO dto, String mem_name);
	
	List<EmailDTO> getEmailList(PageDTO dto);
	
	int insertEmail(EmailDTO dto);
	
	MemberDTO selectSendEmp(int mno);
	
	EmailDTO selectReceiveMail(int mno);
	
	int selectReceiveMailListCount(String mem_id);

	ArrayList<EmailDTO> selectReceiveMailList(PageDTO dto, String mem_name);
	
	ArrayList<MemberDTO> selectMemberDTOList(String dept_code);
}

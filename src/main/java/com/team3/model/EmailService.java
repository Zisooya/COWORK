package com.team3.model;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.team3.model.member.MemberDTO;

@Repository
public interface EmailService {
	
	void insertMail(EmailDTO dto);
	
	EmailDTO selectSendMail(int mno);
	
	int selectSendMailListCount(String mem_id);
	
	ArrayList<EmailDTO> selectSendMailList(PageDTO dto, String mem_name);
	
	List<EmailDTO> getEmailList(PageDTO dto);
	
	int insertEmail(EmailDTO dto);
	
	MemberDTO selectSendEmp(int mno);
	
	EmailDTO selectReceiveMail(int mno);
	
	int selectReceiveMailListCount(String mem_id);

	ArrayList<EmailDTO> selectReceiveMailList(PageDTO pi, String mem_name);
	
	ArrayList<MemberDTO> selectMemberDTOList(String dept_code);
	
	MemberDTO getReceiver(String receiver);
	
	void insertReply(EmailDTO m);
	
	void resendMail(EmailDTO m);
	
	void insertSendDelivery(EmailDTO m);
	
	void wasteSendMail(int mno);
	
	int selectWasteMailListCount(String empId);
	
	ArrayList<EmailDTO> selectWasteMailList(PageDTO pi, String empId);
	
	void wasteReceiveMail(int mno);
	
	MemberDTO selectReceiveEmp(int mno);
	
	EmailDTO selectMail(int mno);
	
	void returnSendMail(int mno);
	
	void returnReceiveMail(int mno);
	
	void wasteMail(int mno);

	void updateWriter(int mno);

	void updateReceiver(int mno);
	
	ArrayList<EmailDTO> mainSendMailList(String empId);

	ArrayList<EmailDTO> mainReceiveMailList(String empId);

	int selectCountNoRead(String empId);
}

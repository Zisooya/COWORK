package com.team3.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.team3.model.member.MemberDTO;

public interface EmailDAO {
	
	int getListCount();
	
	Map<String, String> send(String email, String title, String body);
	
	void insertMail(EmailDTO m) throws Exception;
	
	EmailDTO selectSendMail(int mno);
	
	int selectSendMailListCount(String mem_name);
	
	ArrayList<EmailDTO> selectSendMailList(PageDTO dto, String mem_name);
	
	List<EmailDTO> getEmailList(PageDTO dto);
	
	int insertEmail(EmailDTO dto);
	
	EmailDTO EmailCont(int no);
	
	int updateEmail(EmailDTO dto);
	
	MemberDTO selectSendEmp(int mno);
	
	EmailDTO selectReceiveMail(int mno);
	
	int selectReceiveMailListCount(String mem_id);

	ArrayList<EmailDTO> selectReceiveMailList(PageDTO dto, String mem_name);
	
	ArrayList<EmailDTO> selectReceiveMailList(SqlSession sqlSession, PageDTO pi, String empId);
	
	ArrayList<MemberDTO> selectMemberDTOList(String deptCode);
}

package com.team3.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team3.model.mail.CommException;
import com.team3.model.member.MemberDTO;

@Service
public class EmailServiceImpl implements EmailService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private EmailDAO emailDao;

	@Override
	public void insertMail(EmailDTO dto) {

		int result = emailDao.insertMail(sqlSession, dto);
		
		if(result < 0) {
			
			throw new CommException("메일 전송 실패");
		}
	}

	@Override
	public EmailDTO selectSendMail(int mno) {
		
		return emailDao.selectSendMail(sqlSession, mno);
	}

	@Override
	public int selectSendMailListCount(String mem_id) {
		
		return emailDao.selectSendMailListCount(sqlSession, mem_id);
	}

	@Override
	public ArrayList<EmailDTO> selectSendMailList(PageDTO dto, String mem_name) {
		
		return emailDao.selectSendMailList(sqlSession, dto, mem_name);
	}

	@Override
	public List<EmailDTO> getEmailList(PageDTO dto) {
		
		return this.sqlSession.selectList("list", dto);
	}

	@Override
	public int insertEmail(EmailDTO dto) {
		
		return this.sqlSession.insert("insert", dto);
	}

	@Override
	public MemberDTO selectSendEmp(int mno) {
		
		return emailDao.selectSendEmp(sqlSession, mno);
	}

	@Override
	public EmailDTO selectReceiveMail(int mno) {
		
		EmailDTO m = null;
		
		int result = emailDao.increaseCount(sqlSession, mno);
		
		if(result < 0) {
			
			throw new CommException("increaseCount 실패");
			
		}else {
			
			m = emailDao.selectReceiveMail(sqlSession, mno);
		}
		
		return m;
	}

	@Override
	public int selectReceiveMailListCount(String mem_id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<EmailDTO> selectReceiveMailList(PageDTO dto, String mem_name) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<MemberDTO> selectMemberDTOList(String deptCode) {
		return emailDao.selectMemberDTOList(sqlSession, deptCode);
	}

	@Override
	public MemberDTO getReceiver(String receiver) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertReply(EmailDTO m) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void resendMail(EmailDTO m) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertSendDelivery(EmailDTO m) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void wasteSendMail(int mno) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int selectWasteMailListCount(String empId) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<EmailDTO> selectWasteMailList(PageDTO pi, String empId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void wasteReceiveMail(int mno) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MemberDTO selectReceiveEmp(int mno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public EmailDTO selectMail(int mno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void returnSendMail(int mno) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void returnReceiveMail(int mno) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void wasteMail(int mno) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateWriter(int mno) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateReceiver(int mno) {
		// TODO Auto-generated method stub
		
	}

}

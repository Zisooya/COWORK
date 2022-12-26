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
		return emailDao.selectReceiveMailListCount(sqlSession, mem_id);
	}

	@Override
	public ArrayList<EmailDTO> selectReceiveMailList(PageDTO pi, String mem_name) {
		return emailDao.selectReceiveMailList(sqlSession, pi, mem_name);
	}

	@Override
	public ArrayList<MemberDTO> selectMemberDTOList(String deptCode) {
		return emailDao.selectMemberDTOList(sqlSession, deptCode);
	}

	@Override
	public MemberDTO getReceiver(String receiver) {
		return emailDao.getReceiver(sqlSession, receiver);
	}

	@Override
	public void insertReply(EmailDTO m) {
		int result = emailDao.insertReply(sqlSession, m);
		
		if(result < 0) {
			throw new CommException("메일 답장 실패");
		}
	}

	@Override
	public void resendMail(EmailDTO m) {
		int result = emailDao.resendMail(sqlSession, m);
		
		if(result < 0) {
			throw new CommException("메일 재전송 실패");
		}
	}

	@Override
	public void insertSendDelivery(EmailDTO m) {
		int result = emailDao.insertSendDelivery(sqlSession, m);
		
		if(result < 0) {
			throw new CommException("메일 전달 실패");
		}
	}

	@Override
	public void wasteSendMail(int mno) {
		int result = emailDao.wasteSendMail(sqlSession, mno);
		
		if(result < 0) {
			throw new CommException("메일 휴지통 이동 실패");
		}
	}

	@Override
	public int selectWasteMailListCount(String empId) {
		return emailDao.selectWasteMailListCount(sqlSession, empId);
	}

	@Override
	public ArrayList<EmailDTO> selectWasteMailList(PageDTO pi, String empId) {
		return emailDao.selectWasteMailList(sqlSession, pi, empId);
	}

	@Override
	public void wasteReceiveMail(int mno) {
		int result = emailDao.wasteReceiveMail(sqlSession, mno);
		
		if(result < 0) {
			throw new CommException("wasteReceiveMail 실패");
		}
	}

	@Override
	public MemberDTO selectReceiveEmp(int mno) {
		return emailDao.selectReceiveEmp(sqlSession, mno);
	}

	@Override
	public EmailDTO selectMail(int mno) {
		return emailDao.selectMail(sqlSession, mno);
	}

	@Override
	public void returnSendMail(int mno) {
		int result = emailDao.returnSendMail(sqlSession, mno);
		
		if(result < 0) {
			throw new CommException("returnSendMail 실패");
		}
	}

	@Override
	public void returnReceiveMail(int mno) {
		int result = emailDao.returnReceiveMail(sqlSession, mno);
		
		if(result < 0) {
			throw new CommException("returnReceiveMail 실패");
		}
	}

	@Override
	public void wasteMail(int mno) {
		int result = emailDao.wasteMail(sqlSession, mno);
		
		if(result < 0) {
			throw new CommException("wasteMail 실패");
		}
	}

	@Override
	public void updateWriter(int mno) {
		int result = emailDao.updateWriter(sqlSession, mno);
		
		if(result < 0) {
			throw new CommException("updateWriter 실패");
		}
	}

	@Override
	public void updateReceiver(int mno) {
		int result = emailDao.updateReceiver(sqlSession, mno);
		
		if(result < 0) {
			throw new CommException("updateReceiver 실패");
		}	
	}
}

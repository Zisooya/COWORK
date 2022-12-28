package com.team3.model;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.team3.model.member.MemberDTO;

@Repository
public class EmailDAO {
	
	// 메일 작성
	public int insertMail(SqlSessionTemplate sqlSession, EmailDTO dto) {
		return sqlSession.insert("emailDao.insertMail", dto);
	}
	
	//주소록
	public ArrayList<MemberDTO> selectMemberDTOList(SqlSessionTemplate sqlSession, String deptCode) {
		
		return (ArrayList)sqlSession.selectList("emailDao.selectMemberDTOList", deptCode);
	}
	
	// 보낸 메일 리스트 
	public int selectSendMailListCount(SqlSessionTemplate sqlSession, String mem_id) {
		return sqlSession.selectOne("emailDao.selectSendMailListCount", mem_id);
	}
   
	public ArrayList<EmailDTO> selectSendMailList(SqlSessionTemplate sqlSession, PageDTO pi, String mem_id){
		
		int offset = (pi.getPage()-1)*pi.getAllPage();
		RowBounds rowBounds = new RowBounds(offset, pi.getAllPage()); 
		
		return (ArrayList)sqlSession.selectList("emailDao.selectSendMailList", mem_id, rowBounds);
	} 
	
	//보낸메일 보기
	public EmailDTO selectSendMail(SqlSessionTemplate sqlSession, int mno) {
		return sqlSession.selectOne("emailDao.selectSendMail", mno);
	}
	
	//보낸사람
	public MemberDTO selectSendEmp(SqlSessionTemplate sqlSession, int mno) {
	
		return sqlSession.selectOne("emailDao.selectSendEmp", mno);
	}
	
	//유저이름으로 유저아이디 가져오기
	public MemberDTO getReceiver(SqlSessionTemplate sqlSession, String receiver) {
		
		return sqlSession.selectOne("emailDao.getReceiver", receiver);
	}
	
	//보낸메일 전달
	public int insertSendDelivery(SqlSessionTemplate sqlSession, EmailDTO m) {
		
		return sqlSession.insert("emailDao.insertSendDelivery", m);
	}
	
	//보낸메일 뷰에서 휴지통으로
	public int wasteSendMail(SqlSessionTemplate sqlSession, int mno) {
		
		return sqlSession.update("emailDao.wasteSendMail", mno);
	}
	
	//휴지통수
	public int selectWasteMailListCount(SqlSessionTemplate sqlSession, String empId) {
		
		return sqlSession.selectOne("emailDao.selectWasteMailListCount", empId);
	}

	//휴지통 리스트
	public ArrayList<EmailDTO> selectWasteMailList(SqlSessionTemplate sqlSession, PageDTO pi, String empId) {
		
		int offset = (pi.getPage()-1)*pi.getBlock();
		RowBounds rowBounds = new RowBounds(offset, pi.getBlock()); 
		
		return (ArrayList)sqlSession.selectList("emailDao.selectWasteMailList", empId, rowBounds);
	}
	
	//받은메일 답장
	public int insertReply(SqlSessionTemplate sqlSession, EmailDTO m) {
		
		return sqlSession.insert("emailDao.insertReply", m);
	}
	
	//보낸메일 복구
	public int returnSendMail(SqlSessionTemplate sqlSession, int mno) {
	
		return sqlSession.update("emailDao.returnSendMail", mno);
	}
	
	//받은메일 복구
	public int returnReceiveMail(SqlSessionTemplate sqlSession, int mno) {
	
		return sqlSession.update("emailDao.returnReceiveMail", mno);
	}
	
	//메일 영구삭제
	public int wasteMail(SqlSessionTemplate sqlSession, int mno) {
	
		return sqlSession.delete("emailDao.wasteMail", mno);
	}
	
	//발신자상태3
	public int updateWriter(SqlSessionTemplate sqlSession, int mno) {
	
		return sqlSession.update("emailDao.updateWriter", mno);
	}

	//수신자상태3
	public int updateReceiver(SqlSessionTemplate sqlSession, int mno) {
	 
		return sqlSession.update("emailDao.updateReceiver", mno);
	}
	
	//메일번호로 메일 선택
	public EmailDTO selectMail(SqlSessionTemplate sqlSession, int mno) {
		
		return sqlSession.selectOne("emailDao.selectMail", mno);
	}
	
	//받는사람
	public MemberDTO selectReceiveEmp(SqlSessionTemplate sqlSession, int mno) {
	
		return sqlSession.selectOne("emailDao.selectReceiveEmp", mno);
	}
	
	//받은 메일함 리스트 수
	public int selectReceiveMailListCount(SqlSessionTemplate sqlSession, String empId) {
		
		return sqlSession.selectOne("emailDao.selectReceiveMailListCount", empId);
	}
	
	//받은 메일 리스트
	public ArrayList<EmailDTO> selectReceiveMailList(SqlSessionTemplate sqlSession, PageDTO pi, String mem_to) {
		
		int offset = (pi.getPage()-1)*pi.getStartBlock();
		RowBounds rowBounds = new RowBounds(offset, pi.getStartBlock()); 
		
		return (ArrayList)sqlSession.selectList("emailDao.selectReceiveMailList", mem_to, rowBounds);
	}
	
	//받은메일보기
	public EmailDTO selectReceiveMail(SqlSessionTemplate sqlSession, int mno) {
		
		return sqlSession.selectOne("emailDao.selectReceiveMail", mno);
	}
	
	//받은메일 확인 시 조회수 증가
	public int increaseCount(SqlSessionTemplate sqlSession, int mno) {
		
		return sqlSession.update("emailDao.increaseCount", mno);
	}
	
	//받은메일 휴지통
	public int wasteReceiveMail(SqlSessionTemplate sqlSession, int mno) {
		
		return sqlSession.update("emailDao.wasteReceiveMail", mno);
	}
	
	//보낸메일 다시 보내기
	public int resendMail(SqlSessionTemplate sqlSession, EmailDTO m) {
		
		return sqlSession.insert("emailDao.resendMail", m);
	}
	//메인 보낸메일
	public ArrayList<EmailDTO> mainSendMailList(SqlSessionTemplate sqlSession, String empId) {
		
		return (ArrayList)sqlSession.selectList("emailDao.mainSendMailList", empId);
	}
	
	//메인 받은 메일
	public ArrayList<EmailDTO> mainReceiveMailList(SqlSessionTemplate sqlSession, String empId) {
		return (ArrayList)sqlSession.selectList("emailDao.mainReceiveMailList", empId);
	}
	//안읽은 메일 갯수
	public int selectCountNoRead(SqlSessionTemplate sqlSession, String empId) {

		return sqlSession.selectOne("emailDao.selectCountNoRead", empId);
	}

}

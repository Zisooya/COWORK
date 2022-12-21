package com.team3.model;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.team3.model.member.MemberDTO;

@Repository
public class EmailService {
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
}

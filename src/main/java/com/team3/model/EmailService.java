package com.team3.model;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.team3.model.member.MemberDTO;

@Repository
public class EmailService {
	// email 작성
	public int insertMail(SqlSessionTemplate sqlSession, EmailDTO dto) {
		return sqlSession.insert("EmailDAO.insertMail", dto);
	}
	// send-email list 
	public int selectSendMailListCount(SqlSessionTemplate sqlSession, String mem_id) {
		return sqlSession.selectOne("EmailDAO.selectSendMailListCount", mem_id);
	}
   
	public ArrayList<EmailDTO> selectSendMailList(SqlSessionTemplate sqlSession, PageDTO pi, String mem_id){
		
		int offset = (pi.getPage()-1)*pi.getAllPage();
		RowBounds rowBounds = new RowBounds(offset, pi.getAllPage()); 
		
		return (ArrayList)sqlSession.selectList("EmailDAO.selectSendMailList", mem_id, rowBounds);
	} 
	//주소록
	public ArrayList<MemberDTO> selectEmployeeList(SqlSessionTemplate sqlSession, String deptCode) {
		
		return (ArrayList)sqlSession.selectList("EmailDAO.selectEmployeeList", deptCode);
	}
}

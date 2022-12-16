package com.team3.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team3.model.member.MemberDTO;

@Repository
public class EmailDAOImpl implements EmailDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private EmailService mailservice;
	
	@Override
	public int getListCount() {
		return this.sqlSession.selectOne("count");
	}

	@Override
	public Map<String, String> send(String email, String title, String body) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertMail(EmailDTO dto) throws Exception {
		int result = mailservice.insertMail(sqlSession, dto);
		if(result < 0) {
			throw new Exception("메일 전송 실패");
		}
		
	}

	@Override
	public int selectSendMailListCount(String mem_name) {
		return mailservice.selectSendMailListCount(sqlSession, mem_name);
	}

	@Override
	public ArrayList<EmailDTO> selectSendMailList(PageDTO dto, String mem_name) {
		return mailservice.selectSendMailList(sqlSession, dto, mem_name);
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
	public EmailDTO EmailCont(int no) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateEmail(EmailDTO dto) {
		// TODO Auto-generated method stub
		return 0;
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
	public ArrayList<EmailDTO> selectReceiveMailList(SqlSession sqlSession, PageDTO pi, String empId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<MemberDTO> selectMemberDTOList(String deptCode) {
		// TODO Auto-generated method stub
		return null;
	}

}

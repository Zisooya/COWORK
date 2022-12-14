package com.team3.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	// 로그인
	@Override
	public MemberDTO login(MemberDTO dto) {
		return sqlSession.selectOne("login", dto);
	}

	// 로그아웃
	@Override
	public void logout(HttpSession session) {
		session.invalidate();
	}

	// 회원 가입
	@Override
	public void join(MemberDTO dto) {
		sqlSession.insert("join", dto);
	}

	// 아이디 중복 확인
	@Override
	public int checkId(String mem_id) {
		return this.sqlSession.selectOne("checkId", mem_id);
	}

	// 프로젝트 생성 시 멤버 리스트 가져오기
	@Override
	public List<MemberDTO> getMemberList() {
		return this.sqlSession.selectList("allMem");
	}
}

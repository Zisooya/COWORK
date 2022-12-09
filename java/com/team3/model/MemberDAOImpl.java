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

	@Override
	public boolean loginCheck(MemberDTO dto) {
		String name = sqlSession.selectOne("login_check", dto);

		return name != null;
	}

	@Override
	public MemberDTO getMember(MemberDTO dto) {
		return sqlSession.selectOne("getMember", dto);
	}

	@Override
	public void logout(HttpSession session) {

	}

	// 프로젝트 생성 시 멤버 리스트 가져오기
	@Override
	public List<MemberDTO> getMemberList() {
		return this.sqlSession.selectList("allMem");
	}
}

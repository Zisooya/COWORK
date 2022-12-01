package com.team3.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int memberCheck(String id) {
		return this.sqlSession.selectOne("check", id);
	}

	@Override
	public MemberDTO getMember(String pwd) {
		return this.sqlSession.selectOne("getMember", pwd);
	}
}

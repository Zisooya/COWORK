package com.team3.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int memberCheck(String id) {
		return this.sqlSession.selectOne("check", id);
	}

	@Override
	public MemberDTO getMember(String id) {
		return this.sqlSession.selectOne("login", id);
	}
}

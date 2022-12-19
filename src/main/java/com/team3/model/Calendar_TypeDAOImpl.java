package com.team3.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Calendar_TypeDAOImpl implements Calendar_TypeDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Calendar_TypeDTO> getCalTypeList(int mem_no) {
		return this.sqlSession.selectList("calTypeList", mem_no);
	}

	@Override
	public int insertCalType(Calendar_TypeDTO dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Calendar_TypeDTO getCalType(int mem_no) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateCalType(Calendar_TypeDTO dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteCalType(int mem_no, int cal_no) {
		// TODO Auto-generated method stub
		return 0;
	}
}

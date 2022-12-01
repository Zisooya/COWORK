package com.team3.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CalendarDAOImpl implements CalendarDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<CalendarDTO> getCalList(int mem_no) {
		return this.sqlSession.selectList("calList");
	}

	@Override
	public int insertEvent(CalendarDTO dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public CalendarDTO getEvent(int mem_no) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateEvent(CalendarDTO dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteEvent(int mem_no, int cal_no) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<CalendarDTO> searchCalList(String field, String keyword) {
		// TODO Auto-generated method stub
		return null;
	}
}

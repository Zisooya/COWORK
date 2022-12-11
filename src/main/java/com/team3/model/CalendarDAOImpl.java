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
		List<CalendarDTO> list = this.sqlSession.selectList("calList", mem_no);
		for(int i=0; i<list.size(); i++) {
			System.out.println(list.get(i));
		}
		return list;
	}

	@Override
	public int insertEvent(CalendarDTO dto) {
		return this.sqlSession.insert("add", dto);
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

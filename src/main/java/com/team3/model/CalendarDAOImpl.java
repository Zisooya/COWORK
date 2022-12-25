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
		int res = 0;
		if(dto.getCal_repeat().equals("no_repeat")) {
			res = this.sqlSession.insert("calAdd", dto);
		}else if(dto.getCal_repeat().equals("cycle_d_1")) {
			res = this.sqlSession.insert("calAdd_repeat_d_1", dto);
		}else if(dto.getCal_repeat().equals("cycle_d_weekday")) {
			res = this.sqlSession.insert("calAdd_repeat_d_weekday", dto);
		}else if(dto.getCal_repeat().equals("cycle_w_1")) {
			res = this.sqlSession.insert("calAdd_repeat_w_1", dto);
		}
		return res;
	}

	@Override
	public CalendarDTO getEvent(int mem_no) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateEvent(CalendarDTO dto) {
		int res = 0;
		if(dto.getCal_repeat().equals("no_repeat")) {
			res = this.sqlSession.update("calUpdate", dto);
		}else if(dto.getCal_repeat().equals("cycle_d_1")) {
			res = this.sqlSession.update("calUpdate_repeat_d_1", dto);
		}else if(dto.getCal_repeat().equals("cycle_d_weekday")) {
			res = this.sqlSession.update("calUpdate_repeat_d_weekday", dto);
		}else if(dto.getCal_repeat().equals("cycle_w_1")) {
			res = this.sqlSession.update("calUpdate_repeat_w_1", dto);
		}
		return res;
	}
	
	@Override
	public int updateEventDrag(CalendarDTO dto) {
		return this.sqlSession.update("calUpdate_drag", dto);
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

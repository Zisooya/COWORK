package com.team3.model;

import java.util.List;

public interface CalendarDAO {
	
	List<CalendarDTO> getCalList(int mem_no);
	
	int insertEvent(CalendarDTO dto);
	
	CalendarDTO getEvent(int mem_no);
	
	int updateEvent(CalendarDTO dto);
	
	int updateEventDrag(CalendarDTO dto);
	
	int deleteEvent(int mem_no, int cal_no);
	
	List<CalendarDTO> searchCalList(String field, String keyword);
}

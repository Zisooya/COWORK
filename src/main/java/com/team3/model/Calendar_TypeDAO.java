package com.team3.model;

import java.util.List;

public interface Calendar_TypeDAO {
	
	List<Calendar_TypeDTO> getCalTypeList(int mem_no);
	
	int insertCalType(Calendar_TypeDTO dto);
	
	Calendar_TypeDTO getCalType(int mem_no);
	
	int updateCalType(Calendar_TypeDTO dto);
	
	int deleteCalType(int mem_no, int cal_no);
}

package com.team3.model;

import java.util.List;

public interface ProjectsDAO {
	
	List<ProjectsDTO> getProjectsList();
	
	List<Main_ProjectsDTO> getMainList();
	
	List<Projects_statusDTO> getStatusList();
	
	void insertProject(ProjectsDTO dto);
	
	ProjectsDTO getprojects(int num);
	
	int updateProjects(ProjectsDTO dto);
	
	int deleteProjects(int num);
	
	void updateSeq(int num);
	
	List<ProjectsDTO> searchProjectList(String field,String keyword);
	
	void updatetaker2(ProjectsDTO dto);
	void updatetaker3(ProjectsDTO dto);
	void updatetaker4(ProjectsDTO dto);
	void updatetaker5(ProjectsDTO dto);

}

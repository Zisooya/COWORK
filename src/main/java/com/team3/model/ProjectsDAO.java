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
	
	int updatetaker(ProjectsDTO dto);
	int updatetaker2(ProjectsDTO dto);
	int updatetaker3(ProjectsDTO dto);
	int updatetaker4(ProjectsDTO dto);
	int updatetaker5(ProjectsDTO dto);

	int updateend(ProjectsDTO dto);
	int updatestart(ProjectsDTO dto);
	
	int updatecomment(ProjectsDTO dto);
	
	int deletetaker1(ProjectsDTO dto);
	int deletetaker2(ProjectsDTO dto);
	int deletetaker3(ProjectsDTO dto);
	int deletetaker4(ProjectsDTO dto);
	int deletetaker5(ProjectsDTO dto);

	int insertStatus(Projects_statusDTO dto);

	void updateStatus(String status_name, int project_no);

	int selectStatus_no(String status_name);


}

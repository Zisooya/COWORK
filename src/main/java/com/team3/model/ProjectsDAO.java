package com.team3.model;

import java.util.List;

public interface ProjectsDAO {
	
	
	List<ProjectsDTO> getProjectsList(PageDTO dto);				// 프로젝트 리스트 _테이블
	List<Main_ProjectsDTO> getMainList();						// 메인 프로젝트 리스트 _ 테이블 & 보드 & 모달
	List<Projects_statusDTO> getStatusList();					// 스테이터스 리스트 _ 테이블 & 보드 & 모달
	
	List<ProjectsDTO> getProjectsList();						// 프로젝트 리스트 _ 보드
	List<ProjectsDTO> getProjectsListByProjects(PageDTO dto);	// 프로젝트 프로젝트명으로 검색 _ 테이블
	List<ProjectsDTO> getProjectsListByname(PageDTO dto);		// 프로젝트 이름으로 검색 _ 테이블
	List<ProjectsDTO> getProjectsListByStatus(PageDTO pdto);	// 프로젝트 스테이터스로 필터링 _ 테이블
	
	void insertProject(ProjectsDTO dto);						// 프로젝트 추가 _ 테이블
	int board_insertProject(ProjectsDTO dto);					// 프로젝트 추가 _ 보드
	int insertStatus(Projects_statusDTO dto);					// 스테이터스 추가 _보드
	
	ProjectsDTO getprojects(int num);							// 프로젝트 상세보기 _보드 & 테이블
	
	int updateProjects(ProjectsDTO dto);						// 프로젝트 스테이터스 변경 _ 모달
	void UpdateStatus(ProjectsDTO dto);							// 프로젝트 스테이터스 변경 _ 보드
	int updateend(ProjectsDTO dto);								// 프로젝트 마감일 변경 _ 모달
	int updatestart(ProjectsDTO dto);							// 프로젝트 시작일 변경 _ 모달
	int updatecomment(ProjectsDTO dto);							// 프로젝트 상세내용 추가 및 변경 _ 모달
	
	int deleteProjects(int num);								// 프로젝트 삭제 _ 모달
	
	int getListCount();											// 프로젝트 카운트 _ 테이블
	int getListCountByname(PageDTO dto);						// 프로젝트 이름으로 카운트 _ 테이블
	int getListCountByproject(PageDTO dto);						// 프로젝트 프로젝트명으로 카운트 _ 테이블
	int getListCountByStatus(int status_no);					// 프로젝트 스테이터스로 카운트 _ 테이블
	
	int selectStatus_no(Projects_statusDTO sdto);				// 프로젝트 스테이터스로 필터링 _ 테이블 
	
	/* 프로젝트 멤버 추가 및 삭제 _ 모달 */
	int updatetaker(ProjectsDTO dto);							
	int updatetaker2(ProjectsDTO dto);
	int updatetaker3(ProjectsDTO dto);
	int updatetaker4(ProjectsDTO dto);
	int updatetaker5(ProjectsDTO dto);
	
	int deletetaker1(ProjectsDTO dto);
	int deletetaker2(ProjectsDTO dto);
	int deletetaker3(ProjectsDTO dto);
	int deletetaker4(ProjectsDTO dto);
	int deletetaker5(ProjectsDTO dto);
	
}

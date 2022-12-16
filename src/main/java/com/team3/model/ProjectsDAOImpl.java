package com.team3.model;

import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProjectsDAOImpl implements ProjectsDAO{
		
	@Inject
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<ProjectsDTO> getProjectsList(PageDTO dto) {
		return this.sqlSession.selectList("all",dto);
	}
	
	@Override
	public List<Main_ProjectsDTO> getMainList() {
		return this.sqlSession.selectList("getMain");
	}
	@Override
	public List<Projects_statusDTO> getStatusList() {
		return this.sqlSession.selectList("status");
	}
	@Override
	public List<ProjectsDTO> getProjectsList() {
		return this.sqlSession.selectList("board_project_list");
	}

	@Override
	public List<ProjectsDTO> getProjectsListByProjects(PageDTO dto) {
		return this.sqlSession.selectList("selectproject", dto);
	}

	@Override
	public List<ProjectsDTO> getProjectsListByname(PageDTO dto) {
		return this.sqlSession.selectList("selectname", dto);
	}
	
	@Override
	public List<ProjectsDTO> getProjectsListByStatus(PageDTO pdto) {
		return this.sqlSession.selectList("selectStatus", pdto);
	}

	@Override
	public void insertProject(ProjectsDTO dto) {
		this.sqlSession.insert("insert", dto);
	}

	@Override
	public ProjectsDTO getprojects(int num) {
		return this.sqlSession.selectOne("cont", num);
	}

	@Override
	public int updateProjects(ProjectsDTO dto) {
		return this.sqlSession.update("move", dto);
	}

	@Override
	public int deleteProjects(int num) {
		return this.sqlSession.delete("deleteProject",num);
	}

	@Override
	public int updatetaker(ProjectsDTO dto) {
		return this.sqlSession.update("updateMember1",dto);
	}
	
	@Override
	public int updatetaker2(ProjectsDTO dto) {
		return this.sqlSession.update("updateMember2",dto);
	}

	@Override
	public int updatetaker3(ProjectsDTO dto) {
		return this.sqlSession.update("updateMember3",dto);
	}

	@Override
	public int updatetaker4(ProjectsDTO dto) {
		return this.sqlSession.update("updateMember4",dto);
	}

	@Override
	public int updatetaker5(ProjectsDTO dto) {
		return this.sqlSession.update("updateMember5",dto);
	}

	@Override
	public int updatestart(ProjectsDTO dto) {
		return this.sqlSession.update("start", dto);
	}

	@Override
	public int updateend(ProjectsDTO dto) {
		return this.sqlSession.update("end", dto);
	}

	@Override
	public int updatecomment(ProjectsDTO dto) {
		return this.sqlSession.update("comment", dto);
	}

	@Override
	public int deletetaker1(ProjectsDTO dto) {
		return this.sqlSession.update("deletetaker1", dto);
	}

	@Override
	public int deletetaker2(ProjectsDTO dto) {
		return this.sqlSession.update("deletetaker2", dto);
	}

	@Override
	public int deletetaker3(ProjectsDTO dto) {
		return this.sqlSession.update("deletetaker3", dto);
	}

	@Override
	public int deletetaker4(ProjectsDTO dto) {
		return this.sqlSession.update("deletetaker4", dto);
	}

	@Override
	public int deletetaker5(ProjectsDTO dto) {
		return this.sqlSession.update("deletetaker5", dto);
	}

	@Override
	public int insertStatus(Projects_statusDTO dto) {
		return this.sqlSession.insert("insertStatus", dto);
	}

	@Override
	public void UpdateStatus(ProjectsDTO dto) {
		this.sqlSession.update("update_status", dto);
	}

	@Override
	public int selectStatus_no(Projects_statusDTO sdto) {
		return this.sqlSession.selectOne("select_status_no", sdto);
	}

	@Override
	public int board_insertProject(ProjectsDTO dto) {
		return this.sqlSession.insert("board_insertProject", dto);
	}

	@Override
	public int getListCount() {
		return this.sqlSession.selectOne("count");
	}

	

	@Override
	public int getListCountByname(PageDTO dto) {
		return this.sqlSession.selectOne("countByName", dto);
	}

	@Override
	public int getListCountByproject(PageDTO dto) {
		return this.sqlSession.selectOne("countByProject",dto);
	}

	@Override
	public int getListCountByStatus(int status_no) {
		return this.sqlSession.selectOne("countByStatus",status_no);
	}



}

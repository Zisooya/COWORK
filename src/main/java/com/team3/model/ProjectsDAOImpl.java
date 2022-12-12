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
	public List<ProjectsDTO> getProjectsList() {
		return this.sqlSession.selectList("all");	
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
	public void updateSeq(int num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ProjectsDTO> searchProjectList(String field, String keyword) {
		// TODO Auto-generated method stub
		return null;
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
	public void updateStatus(String status_name, int project_no) {
		this.sqlSession.update(status_name, status_name);
	}

	@Override
	public int selectStatus_no(String status_name) {
		return this.sqlSession.selectOne("SelectStatus_no", status_name);
	}

}

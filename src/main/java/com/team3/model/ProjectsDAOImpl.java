package com.team3.model;

import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateProjects(ProjectsDTO dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteProjects(int num) {
		// TODO Auto-generated method stub
		return 0;
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

	

	

}

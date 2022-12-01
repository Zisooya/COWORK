package com.team3.cowork;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.team3.model.Main_ProjectsDTO;
import com.team3.model.MemberDAO;
import com.team3.model.MemberDTO;
import com.team3.model.ProjectsDAO;
import com.team3.model.ProjectsDTO;
import com.team3.model.Projects_statusDTO;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CoworkController {

	@Autowired
	private MemberDAO dao;
  
	// ProjectDAO 변수 생성 _ 세건
	@Autowired
	private ProjectsDAO dao_projects;

	// 프로젝트 목록 생성 페이지 _ 세건
	@RequestMapping("project_control.do")
	public String project_control(Model model) {
		List<com.team3.model.ProjectsDTO> list = this.dao_projects.getProjectsList();
		List<Main_ProjectsDTO> main = this.dao_projects.getMainList();
		List<Projects_statusDTO> status = this.dao_projects.getStatusList();
		model.addAttribute("list", list);
		model.addAttribute("main", main);
		model.addAttribute("status", status);
		return "project_control";
	}
			
	// 프로젝트 생성 페이지 _ 세건
	@RequestMapping("project_insert.do")
	public void project_insert(Model model,ProjectsDTO dto,HttpServletResponse response) throws IOException {
		this.dao_projects.insertProject(dto);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("location.href='project_control.do'");
		out.println("</script>");
	}


/*
	@RequestMapping("calendar.do")
	public String calendarMain(Model model) {
		return "calender";
	}


	@RequestMapping("member_login.do")
	public String memberLogin() {
		return "login";
	}

*/


}

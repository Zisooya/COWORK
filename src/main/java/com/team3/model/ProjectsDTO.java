package com.team3.model;

import lombok.Data;

@Data

public class ProjectsDTO {
	
	private int project_no;
	private String project_name;
	private String project_start;
	private String project_end;
	private String project_img;
	private String project_giver;
	private String project_taker;
	private int project_progress;
	private int project_status;
	private int project_main;
}

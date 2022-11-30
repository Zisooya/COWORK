package com.team3.model;

import lombok.Data;

@Data
public class MemberDTO {
	
    private int mem_no;
    private String mem_name;
    private String mem_id;
    private String mem_pwd;
    private String mem_job;
    private String mem_rank;
    private int dept_no;
    private int team_no;
    private String mem_email;
    private String mem_phone;
    
}

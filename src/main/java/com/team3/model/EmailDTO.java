package com.team3.model;

import java.sql.Date;

import lombok.Data;

@Data
public class EmailDTO {
	private int eml_no;      		// 메일번호
	private String eml_from;			// 보낸사람 	
	private String eml_to;	     	    // 받는사람
	private String eml_title;
	private String eml_content;     // 메일내용
	private Date create_date;	    // 보낸날짜		 
	private int read_count;			// 횟수
	private int importantFlag;
	private int writer_status;
	private int receiver_status;
	private String filename;		//
	private String filepath;
	
}

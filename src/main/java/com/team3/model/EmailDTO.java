package com.team3.model;

import java.sql.Date;

import lombok.Data;

@Data
public class EmailDTO {
	private int eml_no;      		// 메일번호
	private int eml_from;			// 보낸사람 	
	private int eml_to;	     	    // 받는사람
	private String eml_title;
	private String eml_content;     // 메일내용
	private Date cteate_date;	    // 보낸날짜		 
	private Date read_date;			// 수신날짜
	private String read_status;
	private int importantFlag;
	private String filename;		//
	private String filepath;
	private String status;
	private String send_status;
}

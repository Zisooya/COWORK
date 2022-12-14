package com.team3.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class CustomerDTO {
		
	private MultipartFile multi_image;
    private int mem_no;
    private int customer_no;
    private String customer_name;
    private String customer_position;
    private String customer_rank;
    private String customer_dept;
    private String customer_team;
    private String customer_email;
    private String customer_phone;
    private String customer_image;
}

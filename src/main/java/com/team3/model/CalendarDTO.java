package com.team3.model;

import lombok.Data;

@Data
public class CalendarDTO {

	private int cal_no;
	private int mem_no;
	private String cal_mark;
	private String cal_title;
	private String cal_start_time;
	private String cal_end_time;
	private int cal_repeat_day;
	private int cal_repeat_week;
	private int cal_repeat_month;
	private int cal_repeat_year;
	private String cal_repeat_detail;
	private int cal_repeat_count;
	private int cal_attendee1;
	private int cal_attendee2;
	private int cal_attendee3;
	private int cal_attendee4;
	private int cal_attendee5;
	private int cal_type_no;
	private String cal_type_name;
	private String cal_place;
	private String cal_memo;
	private String cal_file;
	private String cal_category1;
	private String cal_category2;
	private String cal_category3;
	private String cal_category4;
	private String cal_category5;
	private String cal_category6;
	private String cal_category7;
	private String cal_alarm;
	private String cal_status;
}
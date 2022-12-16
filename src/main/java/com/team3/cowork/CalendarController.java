package com.team3.cowork;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.team3.model.Cal_Upload;
import com.team3.model.CalendarDAO;
import com.team3.model.CalendarDTO;

@Controller
public class CalendarController {

	@Autowired
	private CalendarDAO dao_cal;

	@RequestMapping("calendar.do")
	public String calendarMain(Model model) {

		return "cal_main";
	}

	@RequestMapping("calendarList.do")
	@ResponseBody
	public List<CalendarDTO> calendarList(@RequestParam("no") int memNo, Model model) {
		List<CalendarDTO> list = this.dao_cal.getCalList(memNo);
		return list;
	}

	@Autowired
	private Cal_Upload cal_upload;

	/*
	@RequestMapping(value = "upload_ok.do", produces = "application/text; charset=utf8", consumes = {
			MediaType.MULTIPART_FORM_DATA_VALUE })
	@ResponseBody
	public String calInsertOk(@ModelAttribute CalendarDTO dto, HttpServletResponse response,
			MultipartHttpServletRequest mRequest) throws IOException {
		String file_res = "";
		if (cal_upload.fileUpload(mRequest)) {
			file_res = "파일 업로드 성공";
		} else {
			file_res = "파일 업로드 실패";
		}
		System.out.println("파일 업로드 결과 >>> " + file_res);

		String insert_res = "";
		int check = this.dao_cal.insertEvent(dto);
		response.setContentType("text/html; charset=utf-8");
		if (check > 0) {
			insert_res = "이벤트 추가 성공!!";
		} else {
			insert_res = "이벤트 추가 실패...";
		}
		System.out.println("form태그 정보 insert 결과 >>> " + insert_res);

		String final_res = file_res + " / " + insert_res;
		System.out.println("최종 결과 >>> " + final_res);
		return final_res;
	}
	*/

	/*
	 @RequestMapping(value="upload_ok.do", produces ="application/text; charset=utf8")
	 @ResponseBody
	 public String calUploadOk(MultipartHttpServletRequest mRequest) {
		 String res = "";
		 if(cal_upload.fileUpload(mRequest)) {
			 res = "파일 업로드 성공";
		 }else {
			 res = "파일 업로드 실패";
		 }
		 System.out.println(res);
		 return res;
	 }
	 
	 */
	 @RequestMapping(value="cal_insert.do", produces ="application/text; charset=utf8")
	 @ResponseBody
	 public String calInsert(@ModelAttribute CalendarDTO dto,
				@RequestParam("startTime") String stTime,
				@RequestParam("endTime") String endTime,
				MultipartHttpServletRequest mRequest) throws ParseException {
		 String res = "";
		 String filename = cal_upload.fileUpload(mRequest);
		 /*
		 SimpleDateFormat input = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		 SimpleDateFormat output = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		 Date stTime_date = input.parse(stTime.substring(0, 16));
		 Date endTime_date = input.parse(endTime.substring(0, 16));
		 String stTime_string = output.format(stTime_date);
		 String endTime_string = output.format(endTime_date);
		 */
		 if(dto.getAllDay() != null) {	// '종일'선택 시 DB에는 종료일+1일로 저장(그래야 캘린더 상에 제대로 나옴)
			 SimpleDateFormat output = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			 Date endTime_date = output.parse(endTime.substring(0, 16));
			 Calendar cal = Calendar.getInstance();
			 cal.setTime(endTime_date);
			 cal.add(Calendar.DATE, 1);
			 String endDate = output.format(cal.getTime());
			 
			 dto.setStart(stTime.substring(0, 16));
			 dto.setEnd(endDate);
		 }else {
			 dto.setStart(stTime.substring(0, 16));
			 dto.setEnd(endTime.substring(0, 16));
		 }
		 /*
		 SimpleDateFormat input = new SimpleDateFormat("h:mm a");
		 SimpleDateFormat output = new SimpleDateFormat("HH:mm");
		 Date stTime_date = input.parse(stTime);
		 System.out.println("stTime파싱 성공");
		 String stTime_string = output.format(stTime_date);
		 System.out.println("date->String 변환 성공");
		 String final_startTime = dto.getStart() +" "+stTime_string;
		 System.out.println("final_startTime >> "+final_startTime);
		 dto.setStart(final_startTime);
		  */
		 if(filename != null) {
			 dto.setCal_file(filename);
			 res = "파일 업로드 성공";
		 }else {
			 res = "파일 업로드 실패";
		 }
		 this.dao_cal.insertEvent(dto);
		 return res;
	 }
	 
	 @RequestMapping(value="cal_update_drag.do", produces ="application/text; charset=utf8")
	 @ResponseBody
	 public String calUpdateDrag(@RequestBody Map<String, Object> param) throws ParseException {
		 //System.out.println("param : "+param);
		 int id = Integer.parseInt((String) param.get("id"));
		 String start = (String)param.get("start");
		 String end = (String)param.get("end");
		 boolean allDay = (Boolean) param.get("allDay");
		 //System.out.println("id : "+id);
		 //System.out.println("start : "+start);
		 //System.out.println("end : "+end);
		 //System.out.println("allDay : "+allDay);
		 
		 SimpleDateFormat input = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSX");
		 SimpleDateFormat output = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		 output.setTimeZone(TimeZone.getTimeZone("GMT"));
		 Date start_Date = input.parse(start);
		 Date end_Date = input.parse(end);
		 Calendar cal_start = Calendar.getInstance();
		 Calendar cal_end = Calendar.getInstance();
		 cal_start.setTime(start_Date);
		 cal_end.setTime(end_Date);
		 
		 String startDate = output.format(cal_start.getTime());
		 String endDate = output.format(cal_end.getTime());
		 //System.out.println("최종 시작일 data : "+startDate);
		 //System.out.println("최종 종료일 data : "+endDate);
		 
		 CalendarDTO dto = new CalendarDTO();
		 dto.setCal_no(id);
		 dto.setStart(startDate);
		 dto.setEnd(endDate);
		 
		 int check = this.dao_cal.updateEvent(dto);
		 //System.out.println("update return값 : "+check);
		 String result = "";
		 if(check > 0) {
			 result = "날짜 업데이트 성공";
		 }
		 
		 return result;
	 }
	 
}

package com.team3.cowork;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
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
	
	@RequestMapping(value="upload_ok.do", produces = "application/text; charset=utf8", consumes = { MediaType.MULTIPART_FORM_DATA_VALUE })
	@ResponseBody
	public String calInsertOk(@ModelAttribute CalendarDTO dto, HttpServletResponse response, MultipartHttpServletRequest mRequest) throws IOException {
		String file_res = "";
		if(cal_upload.fileUpload(mRequest)) {
			file_res = "파일 업로드 성공";
		}else {
			file_res = "파일 업로드 실패";
		}
		System.out.println("파일 업로드 결과 >>> "+file_res);
		
		String insert_res = "";
		int check = this.dao_cal.insertEvent(dto);
		response.setContentType("text/html; charset=utf-8");
		if(check > 0) {
			insert_res = "이벤트 추가 성공!!";
		}else {
			insert_res = "이벤트 추가 실패...";
		}
		System.out.println("form태그 정보 insert 결과 >>> "+insert_res);
		
		String final_res = file_res+" / "+insert_res;
		System.out.println("최종 결과 >>> "+final_res);
		return final_res;
	}
	
	/*
	 * @RequestMapping(value="upload_ok.do", produces =
	 * "application/text; charset=utf8")
	 * 
	 * @ResponseBody public String calUploadOk(MultipartHttpServletRequest mRequest)
	 * { String res = ""; if(cal_upload.fileUpload(mRequest)) { res = "파일 업로드 성공";
	 * }else { res = "파일 업로드 실패"; } System.out.println(res); return res; }
	 */
}

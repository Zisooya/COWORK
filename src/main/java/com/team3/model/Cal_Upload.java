package com.team3.model;

import java.io.File;
import java.util.Calendar;
import java.util.Iterator;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Service
public class Cal_Upload {
	public boolean fileUpload(MultipartHttpServletRequest mRequest) {
		boolean isUpload = false;
		
		String uploadPath = "C:\\Users\\VVIP\\Documents\\GitHub\\COWORK\\src\\main\\webapp\\resources\\cal_upload\\";
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH);
		int day = cal.get(Calendar.DAY_OF_MONTH);
		
		// 업로드된 파일들의 이름 목록을 제공하는 메서드
		Iterator<String> iterator = mRequest.getFileNames();
		while(iterator.hasNext()) {
			String uploadFileName = iterator.next();
			MultipartFile mFile = mRequest.getFile(uploadFileName);
			System.out.println("uploadFileName >> " + uploadFileName);
			String originalFileName = mFile.getOriginalFilename();
			System.out.println("originalFileName >> " + originalFileName);
			
			// 실제 폴더를 만들어보자
			// ...........\\resources\\upload\\2022-11-25
			String homedir = uploadPath + year + "-" + month + "-" + day;
			File path1 = new File(homedir);
			if(!path1.exists()) {
				path1.mkdirs();
			}
			
			// 실제 파일을 만들어보자
			String saveFileName = originalFileName;
			if(!saveFileName.equals("")) {
				saveFileName = System.currentTimeMillis() + "_" + saveFileName;
				
				try {
					File origin = new File(homedir+"/"+saveFileName);
					
					// transferTo() : 파일 데이터를 지정한 폴더로 실제 저장하는 메서드
					mFile.transferTo(origin);
					
					isUpload = true;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		}	// while문 end
		
		return isUpload;
	}
}

package com.team3.model.mail;

import com.team3.model.PageDTO;

public class PaginationMail {
	
	public static PageDTO getPageInfo(int listCount, int page, int pageLimit, int boardLimit) {
		
		// * allPage : 총 페이지 수
		
		int allPage = (int)Math.ceil((double)listCount/boardLimit);
		
		// * startNo : 현재 페이지에 보여지는 페이징 바의 시작 수
		int startNo = (page - 1) / pageLimit * pageLimit + 1;
		
		// * endNo : 현재 페이지에 보여지는 페이징 바의 끝 수
		int endNo = startNo + pageLimit - 1;
		
		if(allPage < endNo) {
			endNo = allPage;
		}
		
		PageDTO pi = new PageDTO(page,listCount, startNo, endNo, allPage, pageLimit, boardLimit);
		return pi;
		
	}

}

package com.team3.model.mail;

import com.team3.model.PageDTO;

public class PaginationMail {
	
	public static PageDTO getPageInfo(int listCount, int currentPage, int pageLimit, int boardLimit) {
		
		// * maxPage : 총 페이지 수
		
		int maxPage = (int)Math.ceil((double)listCount/boardLimit);
		
		// * startPage : 현재 페이지에 보여지는 페이징 바의 시작 수
		int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		
		// * endPage : 현재 페이지에 보여지는 페이징 바의 끝 수
		int endPage = startPage + pageLimit - 1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		PageDTO pi = new PageDTO( currentPage,listCount, startPage, endPage, maxPage, pageLimit, boardLimit);
		return pi;
		
	}

}

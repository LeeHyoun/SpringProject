package com.spring.Service;

import java.util.List;

import com.spring.DTO.BookDTO;
import com.spring.DTO.BookPageDTO;

public interface BookService {
	//board
	public int selectCount(); 
	public List<BookDTO> selectList(int ipage, BookPageDTO bookPageDTO); 
	public BookDTO getone(int bookno);

}	

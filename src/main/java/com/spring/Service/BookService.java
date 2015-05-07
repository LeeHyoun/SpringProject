package com.spring.service;

import java.util.List;

import com.spring.dto.BookDTO;
import com.spring.dto.BookPageDTO;

public interface BookService {
	//board
	public int selectCount(); 
	public List<BookDTO> selectList(int ipage, BookPageDTO bookPageDTO); 
	public BookDTO getone(int bookno);
	public BookDTO addBook(BookDTO bookDTO);

}	

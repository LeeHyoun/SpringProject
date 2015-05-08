package com.spring.dao;

import java.util.List;

import com.spring.dto.BookDTO;
import com.spring.dto.BookPageDTO;

public interface BookDAO {
	public List<BookDTO> selectList(int pg,BookPageDTO  bookPageDTO);
	public int selectCount();
	public BookDTO getone(int bookno);
	public BookDTO addBook(BookDTO bookDTO);
	public void updateBook(BookDTO bookDTO);
	public void deleteBook(BookDTO bookDTO);
}

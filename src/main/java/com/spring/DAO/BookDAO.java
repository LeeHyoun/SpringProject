package com.spring.DAO;

import java.util.List;

import com.spring.DTO.BookDTO;
import com.spring.DTO.BookPageDTO;

public interface BookDAO {
	public List<BookDTO> selectList(int pg,BookPageDTO  bookPageDTO);
	public int selectCount();
	public BookDTO getone(int bookno);
	public BookDTO addBook(BookDTO bookDTO);

}

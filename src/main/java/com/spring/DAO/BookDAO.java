package com.spring.DAO;

import java.util.List;

import com.spring.DTO.BookDTO;
import com.spring.DTO.BookPageDTO;

public interface BookDAO {
	public List<BookDTO> selectList(int pg,BookPageDTO  bookPageDTO);
	public int selectCount();
	BookDTO getone(int bookno);
}

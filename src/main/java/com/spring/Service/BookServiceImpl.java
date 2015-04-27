package com.spring.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.DAO.BookDAO;
import com.spring.DTO.BookDTO;
import com.spring.DTO.BookPageDTO;

@Service
@Transactional
public class BookServiceImpl implements BookService {
	@Autowired
	BookDAO bookDAO;

	@Override
	@Transactional(readOnly=true)
	public int selectCount() {
		int count = bookDAO.selectCount();
		return count;
	}
	
	@Override
	@Transactional(readOnly=true)
	public List<BookDTO> selectList(int ipage, BookPageDTO  bookPageDTO) {
		return bookDAO.selectList(ipage, bookPageDTO);
	}
	
	@Override
	public BookDTO getone(int bookno) {
		
		return bookDAO.getone(bookno);
	}
}

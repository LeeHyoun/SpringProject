package com.spring.DAO;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.DTO.BookDTO;
import com.spring.DTO.BookPageDTO;

@Repository
public class BookDAOImpl implements BookDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	// BookMapper.xml - namespace="com.library.mybatis.Book."
	private static final String NS = "com.library.mybatis.Book."; 
	
	@Override
	public List<BookDTO> selectList(int pg, BookPageDTO  bookPageDTO) {
		int start = pg * 10 - 10 + 1;
		int end = pg * 10;
		
		bookPageDTO.setStart(start);
		bookPageDTO.setEnd(end);
		
		List<BookDTO> selectList = new ArrayList<BookDTO>();

	    selectList = sqlSession.selectList(NS + "selectList", bookPageDTO);

		return selectList;
	}

	@Override
	public int selectCount() {
		int count = sqlSession.selectOne(NS + "selectCount"); 
		return count;
	}
	
	@Override
	public BookDTO getone(int bookno) {
		BookDTO bookdto = new BookDTO(); 
		bookdto = sqlSession.selectOne(NS + "getone", bookno);
		return bookdto;
	}
	
	@Override
	public BookDTO addBook(BookDTO bookDTO) {
		sqlSession.insert(NS + "addBook", bookDTO);
		return bookDTO;
	}
}

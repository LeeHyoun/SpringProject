package com.spring.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.DTO.BookDTO;
import com.spring.DTO.BookPageDTO;
import com.spring.Service.BookService;

@Controller
public class BookController {
	
	@Autowired
	BookService bookService;
	
	final static int BLOCK = 5; 
	final static int RECORD = 10; 
	
	
	@RequestMapping(value="/", method={RequestMethod.GET, RequestMethod.POST})
	public String list(
			@RequestParam(value="page", required=false, defaultValue="1") int ipage, 
			@ModelAttribute BookPageDTO bookPageDTO,
			Model model) throws Exception{
		
		int count = bookService.selectCount(); 
		int pageCount = count / RECORD;
		System.out.println(count);
		if(count % 5 > 0) pageCount++; 
		List<BookDTO> list = bookService.selectList(ipage, bookPageDTO); 
		System.out.println(list.size());
		int prevPage = ((ipage-1)/BLOCK)+1; 
		int nextPage = ((ipage-1)/BLOCK)+BLOCK; 
		
		bookPageDTO.setPrevPage(prevPage);
		bookPageDTO.setNextPage(nextPage);
		bookPageDTO.setPageCount(pageCount);
		bookPageDTO.setPage(ipage);
		
		model.addAttribute("BLOCK", BLOCK);
		model.addAttribute("list", list);
		model.addAttribute("bookPageDTO",bookPageDTO);
		
		return "booklist";
	}
	
	//도서상세보기
	@ResponseBody
	@RequestMapping(value="/detailbook",method={RequestMethod.GET, RequestMethod.POST})
	public BookDTO detailbook(@RequestParam(value="bookNo") int bookNo) throws Exception{
		return bookService.getone(bookNo);//선택도서번호에 해당하는 도서리스트 가져오기
	}
	
	@RequestMapping(value="/write", method={RequestMethod.POST})
	public String write(
			@ModelAttribute BookDTO bookDTO,
			Model model) throws Exception {
		System.out.println(bookDTO.toString());
		bookService.addBook(bookDTO);
		
		return "/";
	}
}

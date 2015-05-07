package com.spring.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.dto.UsrDTO;
import com.spring.service.UsrService;

@Controller
public class UsrController {
	
	@Autowired
	UsrService usrService;
	
	@RequestMapping(value = "/usrlogin", method = RequestMethod.POST  )
	public String login(HttpServletRequest request,
			@RequestParam("usrId") String usrId,
			@RequestParam("usrPw") String usrPw) throws Exception {
			
			System.out.println("로그인 아이디 : " + usrId);
			
			UsrDTO usr = usrService.getUsr(usrId);

			if (usrPw.equals(usr.getUsrPw())) {
				HttpSession session = request.getSession();
				session.setAttribute("usr", usr);
				//System.out.println(usr); //읽어온 데이터 확인.
				return "forward:/list";
			}else{			
				return "loginform";
			}
	}
	
	
	@RequestMapping(value = "/logout", method =  RequestMethod.POST)
	public String logout(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("usrId") String usrId,
			Model model) throws Exception {

		HttpSession session = request.getSession();
		session.setAttribute("usrid", usrId);
		session.removeAttribute("usrid");
		session.invalidate();

		return "redirect:/joinform";
	}
	
	@RequestMapping( value = "/joinform", method = RequestMethod.GET)
	public String join(){
		return "loginform"	;
	}
}

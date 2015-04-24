package com.spring.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter("/LoginFilter")
public class LoginFilter implements Filter {

	/**
	 * Default constructor. 
	 */
	public LoginFilter() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpSession session = httpRequest.getSession(false);

		httpRequest.setCharacterEncoding("UTF-8");
		boolean login = false;
		if(session != null)
		{
			if(session.getAttribute("MEMBERID") != null && session.getAttribute("MEMBERPWD") != null)
			{
				login = true;    // 세션변수가  null이 아닐경우 true로 설정.
			}
		}

		if(login)
		{
			// 세션변수가 null이 아닐경우, 필터 체인을 거친 후, 요청한 페이지로 이동한다.
			chain.doFilter(request, response);
		}
		else
		{
			// 세션변수가 null일 경우, 로그인 폼으로 이동한다.
			RequestDispatcher dispatcher = request.getRequestDispatcher("/kame_chbk/chap21/loginForm.jsp");
			dispatcher.forward(request, response);
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}

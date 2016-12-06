package com.cyq7on.servlet;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ServletDemo
 */

public class ServletDemo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		super.init();
		System.out.println("ServletDemo init");
	}

	@Override
	public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.service(req, res);
		System.out.println("ServletDemo service");
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ServletContext context = getServletContext();
		context.setAttribute("key", "I am from ServletDemo");
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ServletDemo2");
		dispatcher.forward(req, resp);
		// 获取ServletDemo的配置参数
		String value = getInitParameter("key");
		System.out.println(value);
		// 获取全局的配置参数
		String contextValue = context.getInitParameter("context_key");
		System.out.println(contextValue);
		String pathA = context.getRealPath("/WEB-INF/a.properties");
		Properties properties = new Properties();
		properties.load(new FileInputStream(pathA));
		System.out.println(properties.getProperty("this"));
		String pathB = context.getRealPath("/WEB-INF/classes/b.properties");
		properties.load(new FileInputStream(pathB));
		System.out.println(properties.getProperty("this")); 
		String pathC = context.getRealPath("/WEB-INF/classes/com/cyq7on/servlet/c.properties");
		properties.load(new FileInputStream(pathC));
		System.out.println(properties.getProperty("this")); 
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
}

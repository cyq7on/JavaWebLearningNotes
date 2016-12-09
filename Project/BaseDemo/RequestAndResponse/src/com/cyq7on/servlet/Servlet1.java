package com.cyq7on.servlet;

import java.beans.PropertyDescriptor;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.net.URLDecoder;
import java.util.Enumeration;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cyq7on.entity.User;

/**
 * Servlet implementation class Servlet1
 */
@WebServlet("/Servlet1")
public class Servlet1 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
//		response.sendRedirect("https://www.taobao.com");
//		ServletOutputStream outputStream = response.getOutputStream();
//		outputStream.write(new String("込込heihei").getBytes());
//		PrintWriter writer = response.getWriter();
//		writer.write(new String("込込heihei"));
		ServletInputStream inputStream = request.getInputStream();
		PrintWriter writer = response.getWriter();
		byte[] b = new byte[1024];
		int len = 0;

		while((len = inputStream.readLine(b, 0, b.length))!= -1) {
			String info = URLDecoder.decode(new String(b,0,len),"UTF-8");
			writer.write(info);
			System.out.println(info);
		}
		/*while((len = inputStream.read(b))!= -1) {
			String info = new String(b,0,len);
			writer.write(info);
			System.out.println(info);
		}*/
		writer.close();
		inputStream.close();
	}

	private void request2(HttpServletRequest request) {
		Map<String, String[]> map = request.getParameterMap();
		User user = new User();
		try {
			for (Entry<String, String[]> entry : map.entrySet()) {
				String name = entry.getKey();
				String[] values = entry.getValue();
				PropertyDescriptor descriptor = new PropertyDescriptor(name, User.class);
				Method method = descriptor.getWriteMethod();
				if (values.length == 1) {
					method.invoke(user, values[0]);
				} else {
					method.invoke(user, (Object)values);
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(user);
	}

	private void request1(HttpServletRequest request) {
		System.out.println(request.getMethod());
		System.out.println(request.getRequestURI());
		System.out.println(request.getRequestURL());
		System.out.println(request.getContextPath());
		String query = request.getQueryString();
		if(query == null) {
			System.out.println("query is null");
		}else {
			System.out.println("query is " + query);
		}
		Enumeration<String> headerNames = request.getHeaderNames();
		while (headerNames.hasMoreElements()) {
			String header = headerNames.nextElement();
			System.out.println(header + ":" + request.getHeader(header));
		}
	}
}

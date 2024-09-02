package cn.techtutorial.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.techtutorial.connection.DbCon;
import cn.techtutorial.dao.*;
import cn.techtutorial.model.*;

@WebServlet("/user-login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			String email = request.getParameter("login-email");
			String password = request.getParameter("login-password");

			UserDao udao = new UserDao(DbCon.getConnection());
			User user = udao.userLogin(email, password);
			if (email.equals("admin@gmail.com") && password.equals("admin")) {
				// Redirect admin to adminDashboard.jsp without creating a session
				response.sendRedirect("adminDashboard.jsp");
			} else {
				if (user != null) {
					// Normal user login
					HttpSession session = request.getSession();
					session.setAttribute("auth", user);
					// Set session timeout to 30 minutes (in seconds)
					session.setMaxInactiveInterval(30 * 60);
					response.sendRedirect("index.jsp");
				} else {
					out.println("<script type=\"text/javascript\">");
					out.println("alert('User or password incorrect');");
					out.println("location='login.jsp';");
					out.println("</script>");
				}

			}

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}

	}
}

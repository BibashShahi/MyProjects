package cn.techtutorial.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.techtutorial.connection.DbCon;
import cn.techtutorial.dao.UserDao;
import cn.techtutorial.model.User;

@WebServlet("/user-register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String name = request.getParameter("register-name");
            String email = request.getParameter("register-email");
            String password = request.getParameter("register-password");

            // Create a new user object with the provided details
            User newUser = new User(0, name, email, password);

            // Insert the new user into the database
            UserDao userDao = new UserDao(DbCon.getConnection());
            boolean registrationSuccess = userDao.registerUser(newUser);

            if (registrationSuccess) {
                // You can also redirect the user to a login page or any other page
                response.sendRedirect("login.jsp");
            } else {
                out.println("Failed to register user");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}

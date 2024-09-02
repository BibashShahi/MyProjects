package cn.techtutorial.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import cn.techtutorial.connection.DbCon;
import cn.techtutorial.dao.UserDao;
import cn.techtutorial.model.User;

@WebServlet("/userList")
public class UserListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Create a UserDao instance
            UserDao userDao = new UserDao(DbCon.getConnection());

            // Retrieve all users from the database
            List<User> userList = userDao.getAllUsers();
            // log
            System.out.println("UserListServlet: userList: " + userList);

            // Set the userList as a request attribute
            request.setAttribute("userList", userList);

            // Forward the request to the userList.jsp page
            request.getRequestDispatcher("/userList.jsp").forward(request, response);
        } catch (ClassNotFoundException e) {
            // Handle ClassNotFoundException
            e.printStackTrace();
        } catch (SQLException e) {
            // Handle SQLException
            e.printStackTrace();
        }
    }
}

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
import cn.techtutorial.dao.OrderDao;
import cn.techtutorial.model.Order;

@WebServlet("/OrderListServlet")
public class OrderListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Create an OrderDao instance
            OrderDao orderDao = new OrderDao(DbCon.getConnection());

            // Retrieve all orders from the database
            List<Order> orders = orderDao.getAllOrders();

            // Set the orders as a request attribute
            request.setAttribute("orders", orders);

            // Forward the request to the orderList.jsp page
            request.getRequestDispatcher("/orderList.jsp").forward(request, response);
        } catch (ClassNotFoundException e) {
            // Handle ClassNotFoundException
            e.printStackTrace();
        } catch (SQLException e) {
            // Handle SQLException
            e.printStackTrace();
        }
    }
}

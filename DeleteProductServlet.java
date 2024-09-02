package cn.techtutorial.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.techtutorial.connection.DbCon;
import cn.techtutorial.dao.ProductDao;

@WebServlet("/delete-product")
public class DeleteProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the ID of the product to be deleted from the request parameter
        int productId = Integer.parseInt(request.getParameter("productId"));

        // Create a ProductDao instance
        ProductDao productDao = null; // Initialize the productDao variable

        try {
            productDao = new ProductDao(DbCon.getConnection());
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle exception
        }

        boolean deleted = false; // Initialize the deleted variable

        // If productDao is initialized successfully, proceed with deletion
        if (productDao != null) {
            deleted = productDao.deleteProduct(productId);
        } else {
            // Handle case where productDao initialization failed
            // Redirect or display an error message
        }

        if (deleted) {
            // Product deleted successfully
            response.sendRedirect("productList.jsp"); // Redirect to products page
        } else {
            // Product deletion failed
            response.getWriter().println("Failed to delete product.");
        }
    }
}

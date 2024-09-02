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
import cn.techtutorial.model.Product;

@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form data
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        String image = request.getParameter("image");

        // Create a Product object
        Product product = new Product();
        product.setName(name);
        product.setCategory(category);
        product.setPrice(price);
        product.setImage(image);

        try {
            ProductDao productDao = new ProductDao(DbCon.getConnection());
            boolean added = productDao.addProduct(product);

            if (added) {
                // Product added successfully
                response.sendRedirect("productList.jsp");
            } else {
                // Product addition failed
                response.getWriter().println("Failed to add product.");
            }
        } catch (ClassNotFoundException e) {
            // Handle ClassNotFoundException
            e.printStackTrace();
        } catch (SQLException e) {
            // Handle SQLException
            e.printStackTrace();
        }
    }
}
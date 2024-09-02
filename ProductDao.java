package cn.techtutorial.dao;

import java.sql.*;
import java.util.*;

import cn.techtutorial.model.Cart;
import cn.techtutorial.model.Product;

public class ProductDao {
    private Connection con;

    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public ProductDao(Connection con) {
        super();
        this.con = con;
    }

    public List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();
        try {
            query = "SELECT * FROM products";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setCategory(rs.getString("category"));

                // Check if price column value is null
                double price = rs.getDouble("price");
                if (!rs.wasNull()) {
                    product.setPrice(price);
                } else {
                    // Handle null price value here
                    // For example, set a default price or log a message
                    product.setPrice(0.0); // Setting a default price of 0.0
                    System.out.println("Null price found for product with ID: " + product.getId());
                }

                product.setImage(rs.getString("image"));
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return productList;
    }

    public boolean addProduct(Product product) {
        String query = "INSERT INTO products (name, category, price, image) VALUES (?, ?, ?, ?)";
        try {
            // NullPointerException may occur here if con or pst is null
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, product.getName());
            pst.setString(2, product.getCategory());
            pst.setDouble(3, product.getPrice());
            pst.setString(4, product.getImage());

            // Execute the query
            int rowsAffected = pst.executeUpdate();
            return rowsAffected > 0; // If rowsAffected > 0, insertion was successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Insertion failed
        }
    }

    public Product getSingleProduct(int id) {
        Product row = null;
        try {
            query = "select * from products where id=? ";

            pst = this.con.prepareStatement(query);
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                row = new Product();
                row.setId(rs.getInt("id"));
                row.setName(rs.getString("name"));
                row.setCategory(rs.getString("category"));
                row.setPrice(rs.getDouble("price"));
                row.setImage(rs.getString("image"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }

        return row;
    }

    // delete
    public boolean deleteProduct(int id) {
        boolean flag = false;
        try {
            query = "delete from products where id=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, id);
            pst.executeUpdate();
            flag = true;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return flag;
    }

    public double getTotalCartPrice(ArrayList<Cart> cartList) {
        double sum = 0;
        try {
            if (cartList.size() > 0) {
                for (Cart item : cartList) {
                    query = "select price from products where id=?";
                    pst = this.con.prepareStatement(query);
                    pst.setInt(1, item.getId());
                    rs = pst.executeQuery();
                    while (rs.next()) {
                        sum += rs.getDouble("price") * item.getQuantity();
                    }

                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return sum;
    }

    public List<Cart> getCartProducts(ArrayList<Cart> cartList) {
        List<Cart> book = new ArrayList<>();
        try {
            if (cartList.size() > 0) {
                for (Cart item : cartList) {
                    query = "select * from products where id=?";
                    pst = this.con.prepareStatement(query);
                    pst.setInt(1, item.getId());
                    rs = pst.executeQuery();
                    while (rs.next()) {
                        Cart row = new Cart();
                        row.setId(rs.getInt("id"));
                        row.setName(rs.getString("name"));
                        row.setCategory(rs.getString("category"));
                        row.setPrice(rs.getDouble("price") * item.getQuantity());
                        row.setQuantity(item.getQuantity());
                        book.add(row);
                    }

                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return book;
    }
}

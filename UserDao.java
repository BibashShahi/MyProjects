package cn.techtutorial.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import cn.techtutorial.model.*;

public class UserDao {
    private Connection con;

    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public UserDao(Connection con) {
        this.con = con;
    }

    public User userLogin(String email, String password) {
        User user = null;
        try {
            query = "select * from users where email=? and password=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            rs = pst.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));

            }
        } catch (SQLException e) {
            System.out.print(e.getMessage());
        }
        return user;
    }

    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        try {
            query = "SELECT * FROM users";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                userList.add(user);
            }
        } catch (SQLException e) {
            System.out.print(e.getMessage());
        }
        return userList;
    }

    public User getUserById(int id) {
        User user = null;
        try {
            query = "SELECT * FROM users WHERE id=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, id);
            rs = pst.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
            }
        } catch (SQLException e) {
            System.out.print(e.getMessage());
        }
        return user;
    }

    // update
    public boolean updateUser(User user) {
        try {
            query = "UPDATE users SET name=?, email=? WHERE id=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, user.getName());
            pst.setString(2, user.getEmail());
            pst.setInt(3, user.getId());
            int rowsAffected = pst.executeUpdate();
            // If rowsAffected > 0, update was successful
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.print(e.getMessage());
            return false; // Update failed
        }
    }

    public boolean registerUser(User newUser) {
        try {
            query = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
            pst = this.con.prepareStatement(query);
            pst.setString(1, newUser.getName());
            pst.setString(2, newUser.getEmail());
            pst.setString(3, newUser.getPassword());
            int rowsAffected = pst.executeUpdate();
            // If rowsAffected > 0, insertion was successful
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.print(e.getMessage());
            return false; // Insertion failed
        }
    }

}

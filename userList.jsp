<%@page import="cn.techtutorial.connection.DbCon"%>
<%@page import="cn.techtutorial.dao.UserDao"%>
<%@page import="cn.techtutorial.model.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
    // Get all users from the database
    UserDao userDao = new UserDao(DbCon.getConnection());
    List<User> users = userDao.getAllUsers();
    // Set the list of users as a request attribute
    request.setAttribute("users", users);
%>

<!DOCTYPE html>
<html>
<head>
    <%@include file="/includes/head.jsp"%>
    <title>User List</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

    <div class="container">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Ecommerce Admin Panel</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" aria-current="page" href="adminDashboard.jsp">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="productList.jsp">Products</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="orderList.jsp">Orders</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="userList.jsp">Users</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Settings</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <h2 class="mt-4 mb-4">User List</h2>
       <table class="table table-striped">
    <thead>
        <tr>
            <th scope="col">User ID</th>
            <th scope="col">Name</th>
            <th scope="col">Email</th>
        </tr>
    </thead>
    <tbody>
        <%
            if (!users.isEmpty()) {
                for (User user : users) {
            %>
            <tr>
                <td><%= user.getId() %></td>
                <td><%= user.getName() %></td>
                <td><%= user.getEmail() %></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="3">There are no users available.</td>
            </tr>
            <%
            }
        %>
    </tbody>
</table>

    </div>

    <%@include file="/includes/footer.jsp"%>

    <!-- Bootstrap JS (optional) -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

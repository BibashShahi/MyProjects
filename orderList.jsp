<%@page import="cn.techtutorial.connection.DbCon"%>
<%@page import="cn.techtutorial.dao.OrderDao"%>
<%@page import="cn.techtutorial.model.Order"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
    // Get all orders from the database
    OrderDao orderDao = new OrderDao(DbCon.getConnection());
    List<Order> orders = orderDao.getAllOrders();
    // Set the list of orders as a request attribute
    request.setAttribute("orders", orders);
%>

<!DOCTYPE html>
<html>
<head>
    <%@include file="/includes/head.jsp"%>
    <title>Order List</title>
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
                        <a class="nav-link" href="login.jsp">Logout</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <h2 class="mt-4 mb-4">Order List</h2>
        <ul class="list-group">
            <%
                if (!orders.isEmpty()) {
                    for (Order order : orders) {
                %>
                <li class="list-group-item">Order ID: <%= order.getOrderId() %>,  Quantity: <%= order.getQunatity() %>, Date: <%= order.getDate() %></li>
                <%
                    }
                } else {
                    out.println("<li class='list-group-item'>There are no orders available.</li>");
                }
            %>
        </ul>
    </div>

    <%@include file="/includes/footer.jsp"%>

    <!-- Bootstrap JS (optional) -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

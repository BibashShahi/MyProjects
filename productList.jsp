<%@page import="cn.techtutorial.connection.DbCon"%>
<%@page import="cn.techtutorial.dao.ProductDao"%>
<%@page import="cn.techtutorial.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("person", auth);
    }
    ProductDao pd = new ProductDao(DbCon.getConnection());
    List<Product> products = pd.getAllProducts();
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list != null) {
        request.setAttribute("cart_list", cart_list);
    }
%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/includes/head.jsp"%>
<title>Ecommerce</title>
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
                        <a class="nav-link active" href="productList.jsp" >Products</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="orderList.jsp">Orders</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="userList.jsp">Users</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="card-header my-3">Items List
                            <a class="btn" href="addProduct.jsp">Add a product</a>

    </div>
    
    <div class="row">
        <%
            if (!products.isEmpty()) {
                for (Product p : products) {
            %>
         <div class="col-md-3 my-3">
    <div class="card w-100">
        <img class="card-img-top" src="<%= p.getImage() %>" alt="Card image cap">
        <div class="card-body">
            <h5 class="card-title"><%= p.getName() %></h5>
            <h6 class="price">Price: $<%= p.getPrice() %></h6>
            <h6 class="category">Category: <%= p.getCategory() %></h6>
            <div class="mt-3 d-flex justify-content-between">
                <!-- cart and Buy Now buttons -->
                <%-- <a class="btn btn-dark" href="add-to-cart?id=<%= p.getId() %>">cart</a> --%>
                <%-- <a class="btn btn-primary" href="order-now?quantity=1&id=<%= p.getId() %>">Buy Now</a> --%>
                
                <!-- Delete product form -->
                <form action="delete-product" method="post" style="display: inline;">
                    <input type="hidden" name="productId" value="<%= p.getId() %>">
                    <button type="submit" class="btn btn-danger">Delete</button>
                </form>
            </div>
        </div>
    </div>
</div>

            <%
                }
            } else {
                out.println("There are no products available.");
            }
        %>
    </div>
</div>

<%@include file="/includes/footer.jsp"%>

<!-- Bootstrap JS (optional) -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

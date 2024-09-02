<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="cn.techtutorial.model.User" %>
<%@ page import="cn.techtutorial.dao.UserDao" %>
<%@ page import="cn.techtutorial.connection.DbCon" %>
<%@ page import="java.util.*" %>

<%
    // Check if the form is submitted
    if (request.getMethod().equalsIgnoreCase("post")) {
        // Retrieve form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Update the user's information in the database
        UserDao userDao = new UserDao(DbCon.getConnection());
        User auth = (User) request.getSession().getAttribute("auth");
        if (auth != null) {
            User user = userDao.getUserById(auth.getId());
            if (user != null) {
                // Update user object with new data
                user.setName(name);
                user.setEmail(email);
                // Check if password is provided and not empty
                if (password != null && !password.isEmpty()) {
                    user.setPassword(password);
                }
                // Update user in the database
                boolean updated = userDao.updateUser(user);
                if (updated) {
                    // User updated successfully
                    out.println("<div class=\"alert alert-success\" role=\"alert\">Profile updated successfully</div>");
                } else {
                    // Failed to update user
                    out.println("<div class=\"alert alert-danger\" role=\"alert\">Failed to update profile</div>");
                }
            } else {
                // User not found in the database
                out.println("<div class=\"alert alert-danger\" role=\"alert\">User not found</div>");
            }
        } else {
            // User not authenticated
            response.sendRedirect("login.jsp");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <!-- Custom CSS -->
    <style>
        .container {
            margin-top: 50px;
        }
    </style>
</head>
<body>
    <div class="container">
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
	<div class="container">
		<a class="navbar-brand" href="index.jsp">Ecommerce</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
	
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
				<li class="nav-item"><a class="nav-link" href="cart.jsp">Cart <span class="badge badge-danger">${cart_list.size()}</span> </a></li>
				<%
			
				%>
				<li class="nav-item"><a class="nav-link " href="orders.jsp">Orders</a></li>
				<li class="nav-item"><a class="nav-link active" href="profile.jsp">Profile</a></li>
								<li class="nav-item"><a class="nav-link" href="about.jsp">About Us</a></li>


				<li class="nav-item"><a class="nav-link" href="log-out">Logout</a></li>
				<%
			
				%>
			</ul>
		</div>
	</div>
</nav>
    
        <% 
            User auth = (User) request.getSession().getAttribute("auth");
            if (auth == null) {
                response.sendRedirect("login.jsp"); // Redirect to login page if user is not logged in
            } else {
                UserDao userDao = new UserDao(DbCon.getConnection());
                User user = userDao.getUserById(auth.getId()); // Assume getUserById method retrieves user info from DB
        %>
        <!-- User Profile Section -->

        <div class="row">
            <div class="col-md-6 mx-auto">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h3 class="card-title">User Profile</h3>
                    </div>
                    <div class="card-body">
                        <!-- Display user profile information -->
                        <p><strong>Name:</strong> <%= user.getName() %></p>
                        <p><strong>Email:</strong> <%= user.getEmail() %></p>
                        <!-- Update Profile Form -->
                        <form action="profile.jsp" method="post">
                            <!-- Input fields for updating profile info -->
                            <div class="form-group">
                                <label for="name">Name</label>
                                <input type="text" class="form-control" id="name" name="name" value="<%= user.getName() %>">
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() %>">
                            </div>
                            <div class="form-group">
                                <label for="password">New Password</label>
                                <input type="password" class="form-control" id="password" name="password">
                            </div>
                            <button type="submit" class="btn btn-primary">Update</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
    </div>
    <!-- Bootstrap JS -->

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-PFkdzVnq8o1r2jT3UP+us/bx71frl14KtefwC7Et41sBCD6+saXVzAplfXfF13IS" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-pzjw8f+Y1PGIdWmJoW+9H5L5qU6B9SKt98D1oc5+w9hxN4Z+V0nE4VmR4Q==" crossorigin="anonymous"></script>
</body>
</html>

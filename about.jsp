<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp"%>

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
				<li class="nav-item"><a class="nav-link" href="orders.jsp">Orders</a></li>
				<li class="nav-item"><a class="nav-link" href="profile.jsp">Profile</a></li>
								<li class="nav-item"><a class="nav-link" href="about.jsp">About Us</a></li>


				<li class="nav-item"><a class="nav-link" href="log-out">Logout</a></li>
				<%
			
				%>
			</ul>
		</div>
	</div>
</nav>

    <div class="row">
        <div class="col-md-12">
            <h2>About Us</h2>
            <p>Welcome to our Ecommerce website. We aim to provide high-quality products and excellent customer service.</p>
            <p>Contact us:</p>
            <ul class="list-unstyled">
                <li><i class="bi bi-telephone"></i> Phone: +123456789</li>
                <li><i class="bi bi-envelope"></i> Email: example@example.com</li>
            </ul>
            <p>Feel free to reach out to us for any inquiries or feedback.</p>
        </div>
    </div>
    
</div>

<%@ include file="/includes/footer.jsp"%>

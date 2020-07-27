<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Order Details - Evergreen BookStore Administration</title>
<link rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	
	<div align="center">
		<h2 class="pageheading">Order details. Order ID: ${order.orderId}</h2>
	</div>
	
	<c:if test="${message != null}">
	<div align="center">
		<h4 class="message">${message}</h4>
	</div>
	</c:if>
	
	<div align="center">
		<h2>Order Overview:</h2>
		<table>
			<tr>
				<td><b>Ordered by:</b></td>
				<td>${order.customer.fullname}</td>
			</tr>
				
			<tr>
				<td><b>Book copies:</b></td>
				<td>${order.bookCopies}</td>
			</tr>
			
			<tr>
				<td><b>Total amount:</b></td>
				<td><fmt:formatNumber value="${order.total}" type="currency" /></td>
			</tr>
			
			<tr>
				<td><b>Recipient name:</b></td>
				<td>${order.recipientName}</td>
			</tr>
			 
			<tr>
				<td><b>Recipient phone:</b></td>
				<td>${order.recipientPhone}</td>
			</tr>
			
			<tr>
				<td><b>Payment method:</b></td>
				<td>${order.paymentMethod}</td>
			</tr>
			
			<tr>
				<td><b>Shipping address:</b></td>
				<td>${order.shippingAddress}</td>
			</tr>
			
			<tr>
				<td><b>Order status:</b></td>
				<td>${order.status}</td>
			</tr>
			
			<tr>
				<td><b>Order date:</b></td>
				<td>${order.orderDate}</td>
			</tr>
			
		</table>
	</div>
	
	<div align="center">
		<h2>Ordered Books</h2>
		<table border="1">
			<tr>
				<th>Index</th>
				<th>Book Title</th>
				<th>Author</th>
				<th>Price</th>
				<th>Quantity</th>
				<th>Subtotal</th>
			</tr>
			
			<c:forEach var="orderDetail" items="${order.orderDetails}" varStatus="status">
				<tr>
					<td>${status.index + 1}</td>
					<td>
						<img style="vertical-align: middle;" src="data:image/jpg;base64,${orderDetail.book.base64Image}" width="48" height ="64" />
						${orderDetail.book.title}</td>
					<td>${orderDetail.book.author}</td>
					<td><fmt:formatNumber value="${orderDetail.book.price}" type="currency" /></td>
					<td>${orderDetail.quantity}</td>
					<td><fmt:formatNumber value="${orderDetail.subtotal}" type="currency" /></td>
				</tr>
			</c:forEach>
				<tr>
					<td colspan="4" align="right">
						<b><i>TOTAL:</i></b>
					</td>
					<td>
						${order.bookCopies}
					</td>
					<td>
						<b><fmt:formatNumber value="${order.total}" type="currency" /></b>
					</td>
				</tr>
		</table>
	</div>
	
	<div align="center">
	<br/>
		<a href="edit_order?id=${order.orderId}">Edit this Order</a>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="">Delete this Order</a>
	</div>
	

	<jsp:directive.include file="footer.jsp" />
	<script>
	$(document).ready(function(){
		$(".deleteLink").each(function() {
			$(this).on("click", function (){
				orderId= $(this).attr("id");
				if(confirm('Are you sure you want to delete the review with ID: ' + reviewId + ' ?')) {
					
					window.location = 'delete_review?id=' + reviewId;
				}
			});
		});
	});
	</script>
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Place an Order - Online Book Store</title>
<link rel="stylesheet" href="css/style.css">
<script type="text/javascript" src="js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
</head>
<body>
<jsp:directive.include file="header.jsp" />
	<div align="center">
		<c:if test="${message != null}">
	<div align="center">
		<h4 class="message">${message}</h4>
	</div>
	</c:if>
		
		<c:set var="cart" value="${sessionScope['cart']}"/>
		
		<c:if test="${cart.totalItems == 0}">
			<h2>There are no items in your cart!</h2>
		</c:if>
		
		<c:if test="${cart.totalItems > 0}">
					<div>
					<h2>Review Your Order Details <a href="view_cart">Edit</a></h2>
						<table border="1">
						<tr>
							<th>Num</th>
							<th colspan="2">Book</th>
							<th>Author</th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Subtotal</th>
							<th>
								
							</th>
						</tr>
						<c:forEach items="${cart.items}" var="item" varStatus="status">
							<tr>
								<td>${status.index+1}</td>
								<td>
								<img class="book-small" src="data:image/jpg;base64,${item.key.base64Image}" />
								</td>
								<td>
									<span id="book-title">${item.key.title}</span>
								</td>
								<td>${item.key.author}</td>
								<td><fmt:formatNumber value="${item.key.price}" type="currency" /></td>
								<td>
									<input type="text" name="quantity${status.index+1}" value="${item.value}" size="5" readonly="readonly"/>
								</td>
								
								<td><fmt:formatNumber value="${item.value * item.key.price}" type="currency" /></td>
							</tr>
						</c:forEach>
						
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td><b>${cart.totalQuantity} book(s)</b></td>
							<td>Total:</td>
							<td colspan="2"><b><fmt:formatNumber 
							value="${cart.totalAmount}" type="currency"/></b></td>
						</tr>
					</table>
					<h2>Your Shipping Information</h2>
					<form id="orderForm" action="place_order" method="post">
						<table>
							<tr>
								<td>Recipient Name:</td>
								<td><input type="text" name="recipientName" value="${loggedCustomer.fullname}"></td>
							</tr>
							
							<tr>
								<td>Recipient Phone:</td>
								<td><input type="text" name="recipientPhone" value="${loggedCustomer.phone}"></td>
							</tr>
							
							<tr>
								<td>Address:</td>
								<td><input type="text" name="address" value="${loggedCustomer.address}"></td>
							</tr>
							
							<tr>
								<td>City:</td>
								<td><input type="text" name="city" value="${loggedCustomer.city}"></td>
							</tr>
							
							<tr>
								<td>Zipcode:</td>
								<td><input type="text" name="zipcode" value="${loggedCustomer.zipcode}"></td>
							</tr>
							
							<tr>
								<td>Country:</td>
								<td><input type="text" name="country" value="${loggedCustomer.country}"></td>
							</tr>
						</table>
						<div>
							<h2>Payment</h2>
							Choose your payment method:
							&nbsp;&nbsp;&nbsp;
							<select name="paymentMethod">
								<option value="Cash on delivery">Cash on delivery</option>
							</select>
						</div>
						<div>
					<table class="normal">
					<tr><td>&nbsp;</td></tr>
						<tr>
							<td><button type="submit" >Place an Order</button></td>
							<td><a href="${pageContext.request.contextPath}">Continue Shopping</a></td>
						</tr>
					</table>
				</div>		
					</form>
				</div>
				
		</c:if>
		
	</div>
	<jsp:directive.include file="footer.jsp" />
</body>

<script type="text/javascript">

$(document).ready(function() {
	$("#clearCart").click(function (){
		window.location = 'clear_cart';
	});
	
	$("#orderForm").validate({
		rules: {
			recipientName: "required",
			recipientPhone: "required",
			address: "required",
			city: "required",
			zipcode: "required",
			country: "required"
		},
		
		messages: {
			recipientName: "Please enter a name!",
			recipientPhone: "Please enter a phone number!",
			address: "Please enter an address!",
			city: "Please enter a city!",
			zipcode: "Please enter a zipcode!",
			country: "Please enter a country!"
		}
	});
});

</script>

</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create New Customer</title>
<link rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="../js/jquery.validate.min.js"></script>




</head>
<body>
	<jsp:directive.include file="header.jsp" />
	
	<div align="center">
		<h2 class="pageheading">
			<c:if test="${customer != null}">
			Edit Customer
			</c:if>
		
		<c:if test="${customer == null}">
			Create New Customer
			</c:if>
		
		</h2>
	</div>
	
	<div align="center">
	<c:if test="${customer != null}">
		<form action="update_customer" method="post" id="customerForm" >
		<input type="hidden" name="customerId" value="${customer.customerId}" >
	</c:if>
	<c:if test="${customer == null}">
		<form action="create_customer" method="post" id="customerForm" >
	</c:if>
		<table class="form">
			
			<tr>
				<td align="right">E-mail Address:</td>
				<td align="left"><input type="text" id="email" name="email" size="45" value="${customer.email}"/></td>
			</tr>
			
			<tr>
				<td align="right">Full name:</td>
				<td align="left"><input type="text" id="fullName" name="fullName" size="45" value="${customer.fullname}" /></td>
			</tr>
			
			<tr>
				<td align="right">Password:</td>
				<td align="left"><input type="password" id="password" name="password" size="45" value="${customer.password}" /></td>
			</tr>
			
			<tr>
				<td align="right">Confirm Password:</td>
				<td align="left"><input type="password" id="confirmPassword" name="confirmPassword"  size="45" value="${customer.password}" /></td>
			</tr>
			
			<tr>
				<td align="right">Phone number:</td>
				<td align="left">
				<input type="text" id="phone" name="phone" size="45" value="${customer.phone}"/>
				
				</td>
			</tr>
			
			<tr>
			 	<td align="right">Address:</td>
				<td align="left"><input type="text" id="address" name="address" size="45" value="${customer.address}"/></td>
			</tr>
			
			<tr>
				<td align="right">City:</td>
				<td align="left"><input type="text" name="city" id="city" size="45" value="${customer.city}" />
				</td>
			</tr>
			
			<tr>
			 	<td align="right">Zip Code:</td>
				<td align="left"><input type="text" id="zipcode" name="zipcode" size="10" value="${customer.zipcode}"/></td>
			</tr>
			
			<tr>
			 	<td align="right">Country:</td>
				<td align="left"><input type="text" id="country" name="country" size="45" value="${customer.country}"/></td>
			</tr>
			
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td colspan="2" align="center">
					<button type="submit">Save</button>&nbsp;&nbsp;&nbsp;
					<button id="buttonCancel" >Cancel</button>
				</td>
			</tr>
		</table>
		</form>
	</div> 
	
	<jsp:directive.include file="footer.jsp" />
</body>
<script type="text/javascript">

$(document).ready(function() {
 
	$("#customerForm").validate({
		rules: {
			email: { 
				required: true,
				email: true
			},
			fullName: "required",
			password: "required",
			confirmPassword: {
				required: true,
				equalTo: "#password"
			},
			phone: "required",
			address: "required",
			city: "required",
			zipcode: "required",
			country: "required",
	},
			
		messages: {
			email: {
				required: "Please enter an e-mail address!",
				email: "Please enter a valid e-mail address!"
			},
			fullName: "Please enter a full name!",
			password: "Please enter a password!",
			confirmPassword: {
				required: "Please confirm the password!",
				equalTo: "Passwords don't match!"
			},
			phone: "Please enter a phone number!",
			address: "Please enter an address!",
			city: "Please enter a city!",
			zipcode: "Please enter a valid zipcode!",
			country: "Please enter a country!"
		}
	});
	$("#buttonCancel").click(function (){
		history.go(-1);
	});
});

</script>

</html>
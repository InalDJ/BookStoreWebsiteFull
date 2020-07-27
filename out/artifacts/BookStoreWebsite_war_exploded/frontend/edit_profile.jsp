<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sign in as a Customer</title>
<link rel="stylesheet" href="css/style.css">
<script type="text/javascript" src="js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>

</head>
<body>
	<jsp:directive.include file="header.jsp" />
	
	<div align="center">
		<h2 class="pageheading">
		Edit my profile
	
		</h2>
	</div>
	
	<div align="center">
		<form action="update_profile" method="post" id="customerForm" >
		<table class="form">
			
			<tr>
				<td align="right">E-mail Address:</td>
				<td align="left"><b>${loggedCustomer.email} (Cannot be changed)</b></td>
			</tr>
			
			<tr>
				<td align="right">Full name:</td>
				<td align="left"><input type="text" id="fullName" name="fullName" size="45" value="${loggedCustomer.fullname}"/></td>
			</tr>
			
			<tr>
				<td align="right">Phone number:</td>
				<td align="left">
				<input type="text" id="phone" name="phone" size="45" value="${loggedCustomer.phone}"/>
				</td>
			</tr>
			
			<tr>
			 	<td align="right">Address:</td>
				<td align="left"><input type="text" id="address" name="address" size="45" value="${loggedCustomer.address}"/></td>
			</tr>
			
			<tr>
				<td align="right">City:</td>
				<td align="left"><input type="text" name="city" id="city" size="45" value="${loggedCustomer.city}" /></td>
			</tr>
			
			<tr>
			 	<td align="right">Zip Code:</td>
				<td align="left"><input type="text" id="zipcode" name="zipcode" size="10" value="${loggedCustomer.zipcode}"/></td>
			</tr>
			
			<tr>
			 	<td align="right">Country:</td>
				<td align="left"><input type="text" id="country" name="country" size="45" value="${loggedCustomer.country}" /></td>
			</tr>
			
			<tr>
				<td colspan="2" align="center">
					<i>Leave password fields blank if you don't want to change your password!</i>
				</td>
			</tr>
			
			<tr>
				<td align="right">Password:</td>
				<td align="left"><input type="password" id="password" name="password" size="45" /></td>
			</tr>
			
			<tr>
				<td align="right">Confirm Password:</td>
				<td align="left"><input type="password" id="confirmPassword" name="confirmPassword"  size="45" /></td>
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
			confirmPassword: {
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
			confirmPassword: {
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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Profile - Online  Books Store</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	
	<div align="center">
		<br/>
			<h2>Welcome, ${loggedCustomer.fullname} Page</h2>
				<br/>
	
	
	 	<table class="normal" >
	 		<tr>
	 			<td><b>E-mail Address:</b></td>
	 			<td>${loggedCustomer.email}</td>
	 		</tr>
	 		
	 		<tr>
	 			<td><b>Full name:</b></td>
	 			<td>${loggedCustomer.fullname}</td>
	 		</tr>
	 		
	 		<tr>
	 			<td><b>Phone number:</b></td>
	 			<td>${loggedCustomer.phone}</td>
	 		</tr>
	 		
	 		<tr>
	 			<td><b>Address:</b></td>
	 			<td>${loggedCustomer.address}</td>
	 		</tr>
	 		
	 		<tr>
	 			<td><b>City :</b></td>
	 			<td>${loggedCustomer.city}</td>
	 		</tr>
	 		
	 		<tr>
	 			<td><b>Zipcode:</b></td>
	 			<td>${loggedCustomer.zipcode}</td>
	 		</tr>
	 		
	 		<tr>
	 			<td><b>Country:</b></td>
	 			<td>${loggedCustomer.country}</td>
	 		</tr>
	 		
	 		<tr>
	 			<td align="center" colspan="2">
	 				<b><a href = "edit_profile">Edit My Profile</a></b>
	 			</td>
	 		</tr>
	 		
	 	</table>
	 </div>
	<jsp:directive.include file="footer.jsp" />
</body>
</html>
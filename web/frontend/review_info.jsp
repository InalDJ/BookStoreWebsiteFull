<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Write a review - Online Book Store</title>
<link rel="stylesheet" href="css/style.css">
<script type="text/javascript" src="js/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.js"></script>
</head>
<body>
<jsp:directive.include file="header.jsp" />
	<div align="center">
		<form id="reviewForm">
			<table class="normal" width="60%">
				<tr>
					<td><h2>You've already written a review for this book!</h2></td>
					<td>&nbsp;</td>
					<td><h2>${loggedCustomer.fullname}</h2></td>
				</tr>
				<tr>
					<td colspan="3"><hr/></td>
				</tr>
				<tr>
					<td>
						<span id="book-title">${book.title}<br/></span>
						<img class="book_large" src="data:image/jpg;base64,${book.base64Image}"/>
					</td>
					<td>
						 <div id="rateYo"></div>
						<br/>
						<input type="text"  name="headline" size="60" readonly="readonly" value="${review.headline}"/> 
						<br/>
						<br/>
						<textarea  name="comment" cols="70" rows="10" readonly="readonly" value="${review.comment}"/></textarea>
					</td>
				</tr>
								
			</table>
		</form>
	</div>
	<jsp:directive.include file="footer.jsp" />
</body>



<script type="text/javascript">

$(document).ready(function() {
		 $("#rateYo").rateYo({
		    starWidth: "40px",
		    fullStar:true,
		    rating: ${review.rating},
		    readOnly: true
		  });
	});

</script>

</html>
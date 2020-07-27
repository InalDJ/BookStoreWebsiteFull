<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Reviews - Evergreen BookStore Administration</title>
<link rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	
	<div align="center">
		<h2 class="pageheading">Review Management</h2>
	</div>
	
	<c:if test="${message != null}">
	<div align="center">
		<h4 class="message">${message}</h4>
	</div>
	</c:if>
	
	<div align="center">
		<table border="1" cellpadding="5">
			<tr>
				<th>Index</th>
				<th>ID</th>
				<th>Book</th>
				<th>Rating</th>
				<th>Headline</th>
				<th>Customer</th>
				<th>Reviewed on</th>
				<th>Actions</th>
			</tr>
			<c:forEach var="review" items="${listReviews}" varStatus="status">
			<tr>
				<td>${status.index + 1}</td>
				<td>${review.reviewId}</td>
				<td>${review.book.title}</td>
				<td>${review.rating}</td>
				<td>${review.headline}</td>
				<td>${review.customer.fullname}</td>
				<td><fmt:formatDate pattern ='MM/dd/yyyy' value='${review.reviewTime}' /></td>
				<td>
					<a href="edit_review?id=${review.reviewId}">Edit</a> &nbsp;
					<a href="javascript:void(0);" class ="deleteLink" id="${review.reviewId}">Delete</a> &nbsp;
				</td>
			</tr>
			</c:forEach>
			
		</table>
	</div>
	

	<jsp:directive.include file="footer.jsp" />
	<script>
	$(document).ready(function(){
		$(".deleteLink").each(function() {
			$(this).on("click", function (){
				reviewId= $(this).attr("id");
				if(confirm('Are you sure you want to delete the review with ID: ' + reviewId + ' ?')) {
					
					window.location = 'delete_review?id=' + reviewId;
				}
			});
		});
	});
	</script>
	
</body>
</html>
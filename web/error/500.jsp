<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Internal Server Error</title>
</head>
<body>
	<div align="center">
	<img src="${pageContext.request.contextPath}/images/BookstoreLogo.png" />
	</div>
	<div align="center">
		<h2>Sorry, the server has encountered an error while fulfilling your request. Please come back later or contact our administrators!</h2>
	</div>
	<div align="center">
		<a href="javascript:history.go(-1);" >Go Back</a>
	</div>
</body>
</html>
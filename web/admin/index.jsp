<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Evergreen BookStore Administration</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
<jsp:directive.include file="header.jsp" />

<div align="center">
    <h2 class="pageheading">Administrative Dashboard</h2>
</div>

<div align="center">
    <hr width="60%" />
    <h2 class="pageheading"> Quick Actions:</h2>
    <b>
        <a href="new_book">New Book</a> &nbsp;
        <a href="user_form.jsp">New User</a> &nbsp;
        <a href="category_form.jsp">New Category</a> &nbsp;
        <a href="customer_form.jsp">New Customer</a> &nbsp;
    </b>
</div>

<div align ="center">
    <h2 class="pageheading">Recent Sales:</h2>
</div>

<div align ="center">
    <h2 class="pageheading">Recent Reviews:</h2>
</div>

<div align ="center">
    <h2 class="pageheading">Statistics:</h2>
</div>
<jsp:directive.include file="footer.jsp" />
</body>
</html>
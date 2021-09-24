<%@ page contentType="text/html;  charset=utf-8" language="java" %>
<%@ include file="/includes/taglibs.jsp" %>
<html>
<head>
<title>${title}</title>
</head>
<body>
<c:if test="${null==currentUser}">
	<script>
		window.location.href="${base}/login.jsp";
	</script>
</c:if>
</body> 
</html>
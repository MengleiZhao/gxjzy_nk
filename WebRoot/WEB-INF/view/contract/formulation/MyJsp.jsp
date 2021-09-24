<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
<script type="text/javascript">
$.ajax({
	type:'post',
	url:'${base}/Rece/office',
	success:function(data){
		document.write(data);
	}
})
</script>
</head>
<body>

</body>
</html>

<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<body>
<form id="ClientPage" method="post" action="http://SSO.CN.GOV/SSOServer/SSOServer.aspx">
<input type="hidden" name="AppCode" value="CNpinganjianshe"/>
<input type="hidden" name="ClientUrl" value="http://31.0.128.159/cn_zzww/SSOLogin.do"/>
<input type="hidden" name="ClientParams" value=""/>
<input type="hidden" name="SIDK" value=""/>
<input type="hidden" name="SIDV" value=""/>
</form>
<script type="text/javascript">
	document.getElementById("ClientPage").submit();
</script>
</body>
</html>
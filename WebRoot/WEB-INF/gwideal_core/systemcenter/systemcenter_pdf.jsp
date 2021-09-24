<%@ page language="java" import="java.util.*,java.io.*"
	pageEncoding="UTF-8"%>

<html>
<body>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
    + request.getServerName() + ":" + request.getServerPort()
    + path + "/";
String location = request.getAttribute("location").toString();
%>

<%
	out.clear();
	out = pageContext.pushBody();
	response.setContentType("application/pdf");
	  

	try {
		String strPdfPath = new String(location);
		//判断该路径下的文件是否存在
		File file = new File(strPdfPath);
		if (file.exists()) {
			DataOutputStream temps = new DataOutputStream(
					response.getOutputStream());
			DataInputStream in = new DataInputStream(
					new FileInputStream(strPdfPath));

			byte[] b = new byte[2048];
			while ((in.read(b)) != -1) {
				temps.write(b);
				temps.flush();
			}

			in.close();
			temps.close();
		} else {
			out.print(strPdfPath + " 文件不存在!");
		}
		out.clear();
		//自动下载
		//response.setHeader("Content-Disposition","attachment;filename="+"3333");
	} catch (Exception e) {
		out.println(e.getMessage());
	}
%>

</body>
</html>

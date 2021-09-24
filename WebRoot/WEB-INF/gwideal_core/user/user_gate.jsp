<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp" %>
<%@ include file="/includes/links.jsp" %>
<html>
	<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/>
<title><@s.text name="title" /></title> 
	
	</head>

	<frameset  border="0"  frameborder="NO" style="border:0px; " name="gate_frame" framespacing="0"  cols="200,*" noresize >
		<frame id="leftTree" name="leftTree"  frameborder="NO" style="border:0px #3278C0 solid;border-right:3px;" marginwidth="0" marginheight="0" src="${base}/sys/treeDepart.action?treeType=guideTree"  scrolling="auto"  noresize  target="content"/>
		<frame id="content" name="content" src="${base}/commons/remark.jsp?infoURL=/sys/user/user_remark.jsp" frameborder="NO" style="border:0px #3278C0 solid"  scrolling="auto" target="self" />
	</frameset>

</html>   
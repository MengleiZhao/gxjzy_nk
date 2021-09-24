<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/>
<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="gwideal" uri="/gwideal-tags" %>
<%@ taglib prefix="s" uri="/s-tags" %>





<c:if test='${pageContext.request.contextPath=="/"}' >
	<c:set var="base" value=""/>
</c:if>
<c:if test='${pageContext.request.contextPath!="/"}' >
	<c:set var="base" value="${pageContext.request.contextPath}"/>
</c:if>
<c:set var="title" value="行政内部管理系统"/>


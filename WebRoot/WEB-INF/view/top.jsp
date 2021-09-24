<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="gwideal" uri="/gwideal-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>

<link href="${base}/resource-now/css/style.css" rel="stylesheet" type="text/css" />


<script type="text/javascript">
$(function(){	
	//顶部导航切换
	$(".nav li a").click(function(){
		$(".nav li a.selected").removeClass("selected")
		$(this).addClass("selected");
	})	
})	
</script>

<style type="text/css">
	.nav li img{
		height: 45px;width: 45px;
	}
</style>
</head>

<body style="background:url(images/topbg.gif) repeat-x;">

    <div class="topleft">
    <a href="main.html" target="_parent"><img src="${base}/resource-now/images/logo.png" title="系统首页" /></a>
    </div>
        
    <ul class="nav">
    <li><a id="top-index" href="index.html" target="rightFrame" class="">
      <img src="${base}/resource-now/images/ico01.png" title="首页" />
      <h2>首页</h2></a></li>
    <li><a id="top-jsc" href="jsc.html" target="rightFrame" class="">
      <img src="${base}/resource-now/images/i07.png" title="管理驾驶舱" />
      <h2>管理驾驶舱</h2></a></li>
    <li><a id="top-ysgl" href="ys-xmk-list.html" target="rightFrame" class="">
      <img src="${base}/resource-now/images/icon03.png" title="预算管理" />
      <h2>预算管理</h2></a></li>
    <li><a id="top-srgl" href="sr-srdj-list.html" target="rightFrame">
      <img src="${base}/resource-now/images/icon05.png" title="收入管理" />
      <h2>收入管理</h2></a></li>
    <li><a id="top-zcugl" href="zcu-zcsq-list.html"  target="rightFrame">
      <img src="${base}/resource-now/images/i06.png" title="支出管理" />
      <h2>支出管理</h2></a></li>
    <li><a id="top-cggl" href="cg-apply-list.html" target="rightFrame">
      <img src="${base}/resource-now/images/i04.png" title="采购管理" />
      <h2>采购管理</h2></a></li>
    <li><a id="top-htgl" href="ht-htba-list.html"  target="rightFrame">
      <img src="${base}/resource-now/images/i02.png" title="合同管理" />
      <h2>合同管理</h2></a></li>
    <li><a id="top-zcagl" href="zca-zcrk-list.html"  target="rightFrame">
      <img src="${base}/resource-now/images/i05.png" title="资产管理" />
      <h2>资产管理</h2></a></li>
    </ul>
            
    <div class="topright">    
    <ul>
    <li><span><img src="${base}/resource-now/images/help.png" title="帮助"  class="helpimg"/></span><a href="#">帮助</a></li>
    <li><a href="#">关于</a></li>
    <li><a href="login.jsp" target="_parent">退出</a></li>
    </ul>
     

    
    </div>
<script type="text/javascript">
		var index = document.getElementById('top-index');
		var jsc = document.getElementById('top-jsc');
		var ysgl = document.getElementById('top-ysgl');
		var srgl = document.getElementById('top-srgl');
		var zcugl = document.getElementById('top-zcugl');
		var htgl = document.getElementById('top-htgl');
		var cggl = document.getElementById('top-cggl');
		var zcagl = document.getElementById('top-zcagl');
		var jsxmgl = document.getElementById('top-jsxmgl');
		index.addEventListener('click',function(){window.parent.postMessage('left-index.html','*');})
		jsc.addEventListener('click',function(){window.parent.postMessage('left-jsc.html','*');})
		ysgl.addEventListener('click',function(){window.parent.postMessage('left-ysgl.html','*');})
		srgl.addEventListener('click',function(){window.parent.postMessage('left-srgl.html','*');})
		zcugl.addEventListener('click',function(){window.parent.postMessage('left-zcugl.html','*');})
		htgl.addEventListener('click',function(){window.parent.postMessage('left-htgl.html','*');})
		cggl.addEventListener('click',function(){window.parent.postMessage('left-cggl.html','*');})
		zcagl.addEventListener('click',function(){window.parent.postMessage('left-zcagl.html','*');})
		jsxmgl.addEventListener('click',function(){window.parent.postMessage('left-jsxmgl.html','*');})
</script>
</body>
</html>

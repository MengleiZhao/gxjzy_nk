<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.braker.core.manager.impl.FunctionMngImpl"%>
<%@page import="com.braker.core.model.Function"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links-base.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<title>欢迎使用行政内控管理系统</title>


<!-- <style type="text/css">
.topna li{float:left;height:88px; text-align:center;}
*{margin: 0;padding: 0}
	body{font-size: 12px;font-family:"微软雅黑";letter-spacing:1px}
	ul,li{list-style: none;}
	a:link,a:visited{text-decoration: none;color: #bad5e7;}
	.list{width: 153px;/* border-bottom:solid 1px #316a91 */;margin:0 auto 0 auto;}
	.list ul li{background-color:/* #467ca2 */; /* border:solid 1px #316a91 */; border-bottom:0;}
	.list ul li a{padding-left: 10px;color:#bad5e7; font-size:12px; display: block; height:51px;line-height: 51px;position: relative;}
	.list ul li .inactive{ background:url(${base}/resource-modality/${themenurl}/sjx1.png) no-repeat 134px center;}
	.list ul li .inactives{background:url(${base}/resource-modality/${themenurl}/sjx2.png) no-repeat 134px center;}
	
	.list ul li ul{display: none;}
	.list ul li ul li { border-left:0; border-right:0; background-color:#1688be/* #6196bb */; border-color:#1688be/* #467ca2 */;width: 153px;}
	.list ul li ul li ul{display: none;}
	.list ul li ul li a{ padding-left:22px;height: 40px;line-height: 40px;background-color: #1688be}
	.list ul li ul li ul li { background-color:#d6e6f1; border-color:#6196bb; }
	.last{ background-color:#d6e6f1; border-color:#6196bb; }
	.list ul li ul li ul li a{/* color:#316a91; */ padding-left:34px;height: 40px;line-height: 40px;background-color: #1688be}
</style> -->



</head>



<body>
	<div id="hiddenDiv" style="display:none;position:fixed;z-index:999;margin-top:47px; width: 222px;height: 344px;" >
		<jsp:include page="skin.jsp"/> 
	</div>
	<div id="container">
		<div id="hd">
			<div class="hd-top">
				<h1 class="logo">
					<a href="javascript:;" class="logo-icon"></a>
				</h1>
				<div style="color: #ffffff; float:right;font-size: 12px;margin-top: 15px;">
					<div style="float: left;margin-top: 9px">
						<jsp:include page="nav/wel-nav.jsp" />	
					</div>
					<div style="float: left;">
						<img id="xiaoxitixing" onMouseOver="mouseOverTop(xiaoxitixing)" onMouseOut="mouseOutTop(xiaoxitixing)" style="vertical-align:middle;width: 71px" src="${base}/resource-modality/${themenurl}/skin_/1xiaoxitixing.png" />
					</div>
					<div style="float: left;">
						|<img id="shezhi" onMouseOver="mouseOverTop(shezhi)" onMouseOut="mouseOutTop(shezhi)" style="vertical-align:middle;width: 71px" src="${base}/resource-modality/${themenurl}/skin_/1shezhi.png" />
					</div>
					<div id="pifu" style="float: left;">
						|<img id="pifua" onMouseOver="mouseOverTop(pifua)" onMouseOut="mouseOutTop(pifua)" style="vertical-align:middle;width: 71px" src="${base}/resource-modality/${themenurl}/skin_/1pifu.png" />
					</div>
					<div style="float: left;">
						|<a href="${base}/logout.do" class="close-btn exit"><img id="tuichu" onMouseOver="mouseOverTop(tuichu)" onMouseOut="mouseOutTop(tuichu)" style="vertical-align:middle;width: 71px;height: " src="${base}/resource-modality/${themenurl}/skin_/1tuichu.png" />&nbsp;&nbsp;</a>
					</div>
				</div>
			</div>
			
			<div class="hd-bottom">
				<div class="nav-wrap" align="left">
					<ul class="topna">
						<jsp:include page="nav/top-nav.jsp" />		
					</ul>
				</div>
			</div>
			
		</div>

        	<div id="bd">
			<div class="sidebar">
					<div class="list">
						<div id="zcglnav" class="leftnav" style="display: none">
						<ul class="nav">
							<jsp:include page="nav/zcgl-nav.jsp" />
						</ul>
						</div>
							
						<div id="htglnav" class="leftnav" style="display: none"> 
							<ul class="nav">
								<jsp:include page="nav/htgl-nav.jsp" />
							</ul>
						</div>
							
						<div id="ysglnav" class="leftnav" style="display: none">
							<ul class="nav">
								<jsp:include page="nav/ysgl-nav.jsp" />
							</ul>
						</div>
						<div id="zcaglnav" class="leftnav" style="display: none">
							<ul class="nav">
								<jsp:include page="nav/zcagl-nav.jsp" />
							</ul>
						</div>
						
						<div id="cgglnav" class="leftnav" style="display: none">
							<ul class="nav">
								<jsp:include page="nav/cggl-nav.jsp" />
							</ul>
						</div>
						<div id="srglnav" class="leftnav" style="display: none">
							<ul class="nav">
								<jsp:include page="nav/srglnav-nav.jsp" />
							</ul>
						</div>
						<div id="xtglnav" class="leftnav" style="display: none">
							<ul class="nav">
								<jsp:include page="nav/xtgl-nav.jsp" />
							</ul>
						</div>
					</div>
					
			</div>
			
			<div class="main">
				<div class="title">
					<i class="sidebar-show"></i>
					<ul class="tab ue-clear">

					</ul>
					<i class="tab-more"></i> <i class="tab-close"></i>
				</div>
				<div class="content"></div>
			</div>
		</div>
	</div>

	
<script>
(function(){

  var title = document.getElementById('pifu');
  var hiddenDiv = document.getElementById('hiddenDiv');
  var timer = null;
  
  hiddenDiv.onmouseover = title.onmouseover = function(){
      if(timer) clearTimeout(timer);
      
      hiddenDiv.style.display = 'block';
  }
  
    
 hiddenDiv.onmouseout = title.onmouseout = function(){
    timer = setTimeout(function(){
      hiddenDiv.style.display = 'none';
    },400);
    
  }

})();
</script>  
	
<script type="text/javascript" src="${base}/resource-modality/js/nav.js"></script>
<script type="text/javascript" src="${base}/resource-modality/js/Menu.js"></script>
<script type="text/javascript" src="${base}/resource-modality/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript">
function test() {
	alert('c');
}

$(document).ready(function () {
	var x = $("#pifu").offset().left;
    $("#hiddenDiv").css("margin-left",x-140);
});


var menu = new Menu({
	defaultSelect : $('.nav').find('li[data-id="0"]')
});


	
function mouseOverTop(pk){
	var src = $("#"+pk.id).attr("src");
	src = src.replace(/1/, "2");
	$("#"+pk.id).attr("src",src);
}
	
function mouseOutTop(pk) {
	var src = $("#"+pk.id).attr("src");
	src = src.replace(/2/, "1");
	$("#"+pk.id).attr("src",src);
}
	
	
//等陆自动加载首页
$(document).ready(function(){
	var a = $(".toptu");
	var id = $(a[0]).attr("id");
	id = id.replace(/t/, "");
	
	var src = $("#t"+id).attr("src");
	src = src.replace(/0/, "3");
	$("#t"+id).attr("src",src);
	
	/* openLeft(id); */
	$('.inactive').click(function(){
			if($(this).siblings('ul').css('display')=='none'){
				$(this).parent('li').siblings('li').children('a').removeClass('inactives');
				$(this).addClass('inactives');
				$(this).siblings('ul').slideDown(100).children('li');
				if($(this).parents('li').siblings('li').children('ul').css('display')=='block'){
					$(this).parents('li').siblings('li').children('ul').parent('li').children('a').removeClass('inactives');
					$(this).parents('li').siblings('li').children('ul').slideUp(100);
				}
			}else{
				//控制自身变成+号
				$(this).removeClass('inactives');
				//控制自身菜单下子菜单隐藏
				$(this).siblings('ul').slideUp(100);
				//控制自身子菜单变成+号
				$(this).siblings('ul').children('li').children('ul').parent('li').children('a').addClass('inactives');
				//控制自身菜单下子菜单隐藏
				$(this).siblings('ul').children('li').children('ul').slideUp(100);
				//控制同级菜单只保持一个是展开的（-号显示）
				$(this).siblings('ul').children('li').children('a').removeClass('inactives');
			}
		})
});
	
//top图片鼠标移入事件
function mouseOver(a) {
	var src = $("#t"+a).attr("src");
	src = src.replace(/0/, "2");
	$("#t"+a).attr("src",src);
}
//top图片鼠标移出事件
function mouseOut(a) {
	var src = $("#t"+a).attr("src");
	src = src.replace(/2/, "0");
	$("#t"+a).attr("src",src);
}
	
//转变top页的图片
function closeTop() {
	$("#bd").height($(window).height() - $("#hd").height()-3);
	$("iframe").height($("#bd").height() - $(".tab").height()-8);
	var a = $(".toptu");
	for(var i=0;i<a.length;i++){
	    var src = $(a[i]).attr("src");
	    src = src.replace(/3/, "0");
	    $(a[i]).attr("src",src);
    }
}	
	
//转变top页的图片
function openLeft(a) {
	var src = $("#t"+a).attr("src");
	src = src.replace(/2/, "3");
	$("#t"+a).attr("src",src);
	
	
	
}

//左边菜单显示
function leftChange(nav) {
	$('.leftnav').css('display','none');
	$('#'+nav).css('display','');
}


//左侧菜单点击修改颜色和点
function changeColor(a) {
	
	$(".siji").each(function(){					//三级菜单
		$(this).css("background-color","#1688be");
		$(this).css("color","#bad5e7");
	});
	$(".sanji").each(function(){				//四级菜单
		$(this).css("background-color","#1688be");
		$(this).css("color","#bad5e7");
	});
	
	$("#siji1").css("background-color","#1688be");
	if($(a).attr('class')=="sanji"){
		$("#siji1").css("color","#bad5e7");
	}
	$("#siji2").css("background-color","#1688be");
	if($(a).attr('class')=="sanji"){
		$("#siji2").css("color","#bad5e7");
	}
	$("#siji3").css("background-color","#1688be");
	if($(a).attr('class')=="sanji"){
		$("#siji3").css("color","#bad5e7");
	}
	
	$(a).css("background-color","#52ace0");
	$(a).css("color","#ffffff");
	
	
	$(".siji").each(function(){
		$(this).children().attr("src", "${base}/resource-modality/${themenurl}/dian1.png");
	});
	$(".sanji").each(function(){
		$(this).children().attr("src", "${base}/resource-modality/${themenurl}/dian1.png");
	});
	$(a).children().attr("src", "${base}/resource-modality/${themenurl}/dian2.png");
	
}

function siji(a) {
	$(a).css("color","#ffffff");
}

function erji(a,name) {
	if(name=='xmkgl'){
		$("#bd").height($(window).height() - $("#hd").height()-3+200);
		$("iframe").height($("#bd").height() - $(".tab").height()-8);
	}else{
		$("#bd").height($(window).height() - $("#hd").height()-3);
		$("iframe").height($("#bd").height() - $(".tab").height()-8);
	}
	
	$(".inactive").each(function(){					//二级菜单
		$(this).css("color","#bad5e7");
	});
	$(a).css("color","#ffffff");
}


</script>
</body>
</html>

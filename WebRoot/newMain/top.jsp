<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div style="float: left;margin:13px 0 0 10px;" border="0">
<img src="${base}/resource-modality/${themenurl}/skin_/logo2.png" style="height: 40px;width: 312px">
</div>
<!-- 系统头部导航菜单 -->
<div style="color: #ffffff; float:right;font-size: 12px;margin-top: 15px;">
	<div style="float: left;margin-top: 12px" id="welcomeInfo">
		<jsp:include page="../main/nav/wel-nav.jsp" />&nbsp;
	</div>
	<%-- <div style="float: left;">
		<img id="xiaoxitixing" onMouseOver="mouseOverTop(xiaoxitixing)" onMouseOut="mouseOutTop(xiaoxitixing)" style="vertical-align:middle;width: 71px" src="${base}/resource-modality/${themenurl}/skin_/1xiaoxitixing.png" />
	</div> --%>
	<div style="float: left;margin-top: 3px">
		|
		<a>
			<img id="shezhi" onMouseOver="mouseOverTop(shezhi)" 
			onclick="editPwd();"
			onMouseOut="mouseOutTop(shezhi)" style="vertical-align:middle;" src="${base}/resource-modality/${themenurl}/skin_/1shezhi.png" />
		</a>
		|
		<a href="#" onclick="panduan()" class="close-btn exit">
			<img id="tuichu" onMouseOver="mouseOverTop(tuichu)" onMouseOut="mouseOutTop(tuichu)" style="vertical-align:middle;" src="${base}/resource-modality/${themenurl}/skin_/1tuichu.png"/>&nbsp;&nbsp;
		</a>
	</div>
	<%-- <div id="pifu" style="float: left;">
		|<img id="pifua" onMouseOver="mouseOverTop(pifua)" onMouseOut="mouseOutTop(pifua)" style="vertical-align:middle;width: 71px" src="${base}/resource-modality/${themenurl}/skin_/1pifu.png" />
	</div> --%>
	<div style="float: left;">
	</div>
</div>

<div style="width: 70%;height:45px;margin-top: 68px;overflow-y:hidden;">
<!-- 导航菜单--首页 -->
	<gwideal:perm url="/index/indexStreetPart"> 
	<div style="width: 68px;float: left;border: 0px">
	<a id="top-index" target="rightFrame" onclick="closeTop(),openLeft(517),leftChange('synav'),addTabs('系统首页','${base}/index/indexStreetPart');">
	<img style="height: 45px;vertical-align:bottom" class="toptu" id="t517" src="${base}/resource-modality/${themenurl}/skin_/sy0.png" onMouseOver="indexMouseOver(517)" onMouseOut="indexMouseOut(517)"/>
	</a>
	</div>		
	</gwideal:perm>
	
	
	<!-- 管理驾驶舱 -->
	<%-- <gwideal:perm url="/gljsctop"> 
	<div style="width: 95px;float: left;border: 0px">
	<a id="top-index" target="rightFrame" onclick="closeTop(),openLeft(518),leftChange('jscnav')">
	<img style="height: 45px;vertical-align:bottom" class="toptu" id="t518" src="${base}/resource-modality/${themenurl}/skin_/gljsc0.png" onMouseOver="indexMouseOver(518)" onMouseOut="indexMouseOut(518)"/>
	</a>
	</div>		
	</gwideal:perm> --%>
	<!-- 导航菜单--预算管理 -->
	<gwideal:perm url="/ysgltop"> 
	<div style="width: 84px;float: left;border: 0px">
	<a id="top-index" target="rightFrame" onclick="closeTop(),openLeft(519),leftChange('ysglnav');">
	<img style="height: 45px;vertical-align:bottom" class="toptu" id="t519" src="${base}/resource-modality/${themenurl}/skin_/ysgl0.png" onMouseOver="indexMouseOver(519)" onMouseOut="indexMouseOut(519)"/>
	</a>
	</div>		
	</gwideal:perm> 
	<!-- 导航菜单--收入管理 -->
	<gwideal:perm url="/srgltop"> 
	<div style="width: 83px;float: left;border: 0px">
	<a id="top-index" target="rightFrame" onclick="closeTop(),openLeft(520),leftChange('srglnav')">
	<img style="height: 45px;vertical-align:bottom" class="toptu" id="t520" src="${base}/resource-modality/${themenurl}/skin_/srgl0.png" onMouseOver="indexMouseOver(520)" onMouseOut="indexMouseOut(520)"/>
	</a>
	</div>		
	</gwideal:perm>
	 <!-- 导航菜单--支出管理 -->
	<gwideal:perm url="/zcgltop"> 
	<div style="width: 80px;float: left;border: 0px">
	<a id="top-index" target="rightFrame" onclick="closeTop(),openLeft(521),leftChange('zcglnav')">
	<img style="height: 45px;vertical-align:bottom" class="toptu" id="t521" src="${base}/resource-modality/${themenurl}/skin_/zcgl0.png" onMouseOver="indexMouseOver(521)" onMouseOut="indexMouseOut(521)"/>
	</a>
	</div>		
	</gwideal:perm>
	 <!-- 导航菜单--采购管理 -->
	<gwideal:perm url="/cggltop"> 
	<div style="width: 85px;float: left;border: 0px">
	<a id="top-index" target="rightFrame" onclick="closeTop(),openLeft(522),leftChange('cgglnav')">
	<img style="height: 45px;vertical-align:bottom" class="toptu" id="t522" src="${base}/resource-modality/${themenurl}/skin_/cggl0.png" onMouseOver="indexMouseOver(522)" onMouseOut="indexMouseOut(522)"/>
	</a>
	</div>		
	</gwideal:perm> 
	<!-- 导航菜单--合同管理-->
	<gwideal:perm url="/htgltop"> 
	<div style="width: 82px;float: left;border: 0px">
	<a id="top-index" target="rightFrame" onclick="closeTop(),openLeft(523),leftChange('htglnav')">
	<img style="height: 45px;vertical-align:bottom" class="toptu" id="t523" src="${base}/resource-modality/${themenurl}/skin_/htgl0.png" onMouseOver="indexMouseOver(523)" onMouseOut="indexMouseOut(523)"/>
	</a>
	</div>		
	</gwideal:perm> 
	<!-- 导航菜单--资产管理 -->
	<%-- <gwideal:perm url="/zicgltop"> 
	<div style="width: 87px;float: left;border: 0px">
	<a id="top-index" target="rightFrame" onclick="closeTop(),openLeft(524),leftChange('zcaglnav')">
	<img style="height: 45px;vertical-align:bottom" class="toptu" id="t524" src="${base}/resource-modality/${themenurl}/skin_/zcagl0.png" onMouseOver="indexMouseOver(524)" onMouseOut="indexMouseOut(524)"/>
	</a>
	</div>		
	</gwideal:perm> --%>
	<!-- 导航菜单--基础数据管理 -->
	<gwideal:perm url="/jcsjgltop"> 
	<div style="width: 108px;float: left;border: 0px">
	<a id="top-index" target="rightFrame" onclick="closeTop(),openLeft(526),leftChange('jcsjglnav')">
	<img style="height: 45px;vertical-a lign:bottom" class="toptu" id="t526" src="${base}/resource-modality/${themenurl}/skin_/jcsjgl0.png" onMouseOver="indexMouseOver(526)" onMouseOut="indexMouseOut(526)"/>
	</a>
	</div>		
	</gwideal:perm>
	<!-- 导航菜单--系统管理 -->
	<gwideal:perm url="/xtgltop"> 
	<div style="width: 91px;float: left;border: 0px">
	<a id="top-index" target="rightFrame" onclick="closeTop(),openLeft(525),leftChange('xtglnav')">
	<img style="height: 45px;vertical-align:bottom" class="toptu" id="t525" src="${base}/resource-modality/${themenurl}/skin_/xtgl0.png" onMouseOver="indexMouseOver(525)" onMouseOut="indexMouseOut(525)"/>
	</a>
	</div>		
	</gwideal:perm>
	
</div>

<script type="text/javascript">
function editPwd(){
	var win=creatWin('修改密码',420,415,'icon-search','/user/editPwd');
	win.window('open');
}

//top图片鼠标移入事件
function indexMouseOver(a) {
	var src = $("#t"+a).attr("src");
	src = src.replace(/0/, "2");
	$("#t"+a).attr("src",src);
}
//top图片鼠标移出事件
function indexMouseOut(a) {
	var src = $("#t"+a).attr("src");
	src = src.replace(/2/, "0");
	$("#t"+a).attr("src",src);
}

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
//转变top页的图片
function closeTop() {
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
	src = src.replace(/0/, "3");
	$("#t"+a).attr("src",src);
}
//左边菜单显示
function leftChange(nav) {
	if($('#'+nav).css('display')=='none'){
		$('.leftnav').css('display','none');
		$('#'+nav).css('display','');
		
		$(".menu-accordion div").css("display","none");//收起所有菜单
		
		$(".menu-accordion").find("img[class='menu_zksq']").attr("src","${base}/resource-modality/${themenurl}/left/zk.png");//+-全部换成+
		
		//切换到系统菜单
		if($("#system_menu").css("display")=="none"){//如果系统菜单隐藏的话
			$("#system_menu").animate({width:'toggle'},100,function(){
				//改变菜单头部的系统菜单个人菜单显示
				$("#menu_top").css("background-image","url(${base}/resource-modality/${themenurl}/left/dt1.png)");
				$("#xtcd-png").attr("src","${base}/resource-modality/${themenurl}/left/xtcd2.png");
				$("#kjcd-png").attr("src","${base}/resource-modality/${themenurl}/left/kjcd1.png");
			});
		}
	};
}
</script>

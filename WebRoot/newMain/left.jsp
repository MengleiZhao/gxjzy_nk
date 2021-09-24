<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
.leftnav {background-color: #0170a4}
</style>
<div style="width: 100%;height: 48px;text-align: center;">
	<!-- 切换按钮  -->
	<div id="menu_top" style="width: 104px;height: 48px;margin:0 auto;background: url('${base}/resource-modality/${themenurl}/left/dt1.png');cursor: pointer;" onclick="changeMenu(this)">
		<div style="text-align: center;vertical-align:middle;"> 
			<table style="width: 100%;">
				<tr style="height: 57px;">
					<td style="width: 50%">
						<img id="xtcd-png" src="${base}/resource-modality/${themenurl}/left/xtcd2.png" title="系统菜单"/>
					</td>
					<td style="width: 50%">
						<img id="kjcd-png" src="${base}/resource-modality/${themenurl}/left/kjcd1.png" title="快捷菜单"/>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>

<div style="width: 310px">
	<!-- 系统菜单  -->
	<div id="system_menu" style="width: 155px;float: left;">
		<!-- 首页  -->
		<div id="synav" class="leftnav" style="display: none">
			<jsp:include page="nav-new/sy-nav.jsp" />
		</div>
		
		<!-- 管理驾驶舱  -->
		<div id=jscnav class="leftnav" style="display: none">
			<jsp:include page="nav-new/gljsc-nav.jsp" />		
		</div>
		
		<!-- 预算管理  -->
		<div id="ysglnav" class="leftnav" style="display: none">
			<jsp:include page="nav-new/ysgl-nav.jsp" />		
		</div>
		
		<!-- 支出管理  -->
		<div id="zcglnav" class="leftnav" style="display: none">
			<jsp:include page="nav-new/zcgl-nav.jsp" />
		</div>
		
		<!-- 收入管理  -->
		<div id="srglnav" class="leftnav" style="display: none">
			<jsp:include page="nav-new/srgl-nav.jsp" />
		</div>
		
		<!-- 采购管理  -->
		<div id="cgglnav" class="leftnav" style="display: none">
			<jsp:include page="nav-new/cggl-nav.jsp" />
		</div>
		
		<!-- 合同管理  -->
		<div id="htglnav" class="leftnav" style="display: none">
			<jsp:include page="nav-new/htgl-nav.jsp" />
		</div>
		
		<!-- 资产管理  -->
		<div id="zcaglnav" class="leftnav" style="display: none">
			<jsp:include page="nav-new/zcagl-nav.jsp" />
		</div>
		
		<!-- 基础数据管理  -->
		<div id="jcsjglnav" class="leftnav" style="display: none">
			<jsp:include page="nav-new/jcsjgl-nav.jsp" />
		</div>
		
		<!-- 系统管理  -->
		<div id="xtglnav" class="leftnav" style="display: none">
			<jsp:include page="nav-new/xtgl-nav.jsp" />
		</div>
	
	</div>

	<!-- 用户个人快捷菜单  -->
	<div id="personal_menu" style="width: 155px;float: left;">
		<div>
			<jsp:include page="nav-new/ksrk-nav.jsp"/>
		</div>
	</div>
</div>

<script type="text/javascript">
//等陆自动加载首页
$(document).ready(function(){
	var a = $(".toptu");
	var id = $(a[0]).attr("id");
	id = id.replace(/t/, "");
	
	var src = $("#t"+id).attr("src");
	src = src.replace(/0/, "3");
	$("#t"+id).attr("src",src);
	
	leftChange('synav');
	
});

//切换系统菜单和个人菜单
function changeMenu(obj) {
	$("#system_menu").animate({width:'toggle'},100,function(){
		var url = $(obj).css("background-image");
		url = url.substring(url.length-9,url.length-2);
		if(url=="dt1.png"){
			$(obj).css("background-image","url(${base}/resource-modality/${themenurl}/left/dt2.png)");
			$("#xtcd-png").attr("src","${base}/resource-modality/${themenurl}/left/xtcd1.png");
			$("#kjcd-png").attr("src","${base}/resource-modality/${themenurl}/left/kjcd2.png");
		} else {
			$(obj).css("background-image","url(${base}/resource-modality/${themenurl}/left/dt1.png)");
			$("#xtcd-png").attr("src","${base}/resource-modality/${themenurl}/left/xtcd2.png");
			$("#kjcd-png").attr("src","${base}/resource-modality/${themenurl}/left/kjcd1.png");
		}
	});
}



var headers = ["H1","H2","H3","H4","H5","H6"];	//菜单级数，如果有需要可以继续添加

//!!!重要  [触发事件的是"H1","H2","H3","H4","H5","H6"等对象，但是实际发生变化的是他的第一个兄弟节点即一个div，可在菜单jsp页面看到]
$(".menu-accordion").click(function(e) {		//点击触发事件（e是event的意思为jq自带的参数）
	var target = e.target,						//获得触发事件对象（与this有点像但是不同）
	name = target.nodeName.toUpperCase();		//获取触发事件对象的节点名称（nodeName）并转化成大写（toUpperCase）
	
	if($.inArray(name,headers) > -1) {			//$.inArray()函数用于在数组中查找指定值，并返回它的索引值（如果没有找到，则返回-1），这里代表在headers数组中查找点击对象的节点名称
	  	var subItem = $(target).next();			//获取触发事件对象的下一个兄弟对象（是一个div在整个控件中起到包住子菜单的作用） !!!重要[这里获取的就是那个实际发生隐藏显示的div]
	  
	 	 /** 在当前深度或更高的位置向上滑动所有元素（目标除外 ）**/
	  	var depth = $(subItem).parents().length;	//查找subItem对象的所有祖先元素个数，不限于父元素
	  	var allAtDepth = $(".menu-accordion div").filter(function() { //筛选div对象集合（filter()用于过滤array中的一些值，通过带入的函数返回的ture 或false 保留或去除，返回一个新的array）
		  	//$(this)的祖先节点数（就是当前遍历div的祖先节点）  >= 触发事件对象的第一个兄弟节点的对象（也是一个div见上面的注释）的祖先节点  && this（当前遍历div）!= subItem对象 
		  	if($(this).parents().length >= depth && this !== subItem.get(0)) {
		   		return true; //这里的用意是  !!!重要  [ 返回除了subItem对象（div）之外的所有所有更下级的div（因为一次只能展开同一分支上的div，现在展开同一分支上的div一定比subItem对象拥有更多的祖先节点，而这些展开的div就是要收起来的）]
		   	}
	  	});
	  	$(allAtDepth).slideUp("fast",function() {
	  		$(this).prev().children("img[class='menu_zksq']").attr("src","${base}/resource-modality/${themenurl}/left/zk.png");
	  	});	//收起所有筛选出来的div（slideUp()函数是以滑动方式隐藏元素，fast是参数），后面跟着的方法是将菜单的-转化成+
	  
	  	/** 滑动切换目标内容 **/
	  	if($(subItem).prop("className")=="opened-for-codepen"){	//div的class为opened-for-codepen就是说明它包含了子菜单
	  		//切换点击的菜单的子菜单的隐藏状态（slideToggle()函数是通过使用滑动效果，在显示和隐藏状态之间切换，fast是参数）
			subItem.slideToggle("fast",function() {
				var src = $(this).prev().children("img[class='menu_zksq']").attr("src");
				if(src.substring(src.length-6,src.length-4)=="zk"){//这里也是切换+-的状态，+的换成-的，-的换成+的
					src = src.replace(/zk/, "sq");//展开改为收起
			  		$(this).prev().children("img[class='menu_zksq']").attr("src",src);
				} else {
					src = src.replace(/sq/, "zk");//收起改为展开
			  		$(this).prev().children("img[class='menu_zksq']").attr("src",src);
				}
		  	});
			subItem.children(":first").trigger("click");// !!!重要 [这里意思是如果包含子菜单，则触发子菜单的点击事件，这样可以一次性联动到最底层的菜单，不需要把这行注掉就OK]
	  	} else {//div的class不是opened-for-codepen就是说明它是最底层的菜单
	  		$(".menu-accordion").find(".click-color").removeClass("click-color");//去除所有的选中颜色
	  		$(target).addClass("click-color");//给选中的菜单添加选中的颜色(需要配合联动方法一起，不然有点问题)
	  	}
	}

});

/* 给所有有子菜单的div加上展开样式的 */
; (function($, window, document, undefined) {
	$(".opened-for-codepen").prev().append("<img class='menu_zksq' style='float:right;margin:0 auto;transform: translateY(70%);' src='${base}/resource-modality/${themenurl}/left/zk.png'>");
})(jQuery, window, document);

//展开收起按钮的触发事件
$(".menu_zksq").click(function(){
	$(this).parent().click();
});
</script>


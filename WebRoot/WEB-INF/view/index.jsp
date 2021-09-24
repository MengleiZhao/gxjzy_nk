<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/includes/taglibs.jsp"%>
<head>
    <title>${title}</title>
	<link rel="stylesheet" type="text/css" href="${base}/resource/admin/css/layout.css"/>
	<link rel="stylesheet" type="text/css" href="${base}/resource/admin/css/reset.css"/>
    <link rel="stylesheet" id="easyuiTheme" type="text/css" href="${base}/resource/ui/themes/default/easyui.css"/>
	<link rel="stylesheet" type="text/css" href="${base}/resource/ui/themes/icon.css"/>
	<script type="text/javascript" src="${base}/resource/ui/jquery.min.js"></script>
	<script type="text/javascript" src="${base}/resource/js/chinaz.js"></script>
	<script type="text/javascript" src="${base}/resource/js/jquery.js"></script>
    <%-- <script type="text/javascript" src="${base}/resource/highcharts/highcharts.js"></script> --%>
    <script type="text/javascript" src="${base}/resource/js/pic.js"></script>
    <script type="text/javascript" src="${base}/resource/ui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${base}/resource/ui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="${base}/resource/custom/custom.js"></script>
	<style type="text/css">
		.float_div{position: relative;width: 299px;height: 199px;margin: 50px auto;} 
        .float_div div{position: absolute;background: rgba(0,0,0,.6);bottom:0;width: 100%; text-align: center;height: 28px;font-size: 14px;color: #fff;line-height: 28px}
        .float_div i{right: 0;position: absolute;top:1px;}
        .float_div i img{width: 15px;height:15px;}
        .float_div img{width:299px;height:200px;}
        .tree-file{background: url('${base}/resource/admin/images/user.png') no-repeat;}
	</style>
</head>
<body>
	<!-- 飘窗 -->
	<c:if test="${indexFloat!=null && floatPicture!=null}">
		<div class="float_div" id="float_div" style="position: fixed; z-index: 10;" onmouseover="stopFloat()" onmouseout="reStartFloat()">
			<a href="${base}/xxfb/view/${indexFloat.id}" target="_blank">
			<img src="${base}/upload/jyyw${fn:replace(floatPicture.fileUrl,'\\','/')}">
			</a>
			<i><img class="" src="${base}/resource/images/closeFloat.jpg" onclick="closeFloatWindow()" onmouseover="changeCursor(this)"></i>
			<div>${floatTitle}</div>
		</div>
	</c:if>
<div id="custom_window"></div>
<div class="container clearfix">
	<div class="ssb clearfix">
	    <div class="gzh r">
	        <div class="xzc"><img src="${base}/resource/admin/images/gzh-01.png" style="width: 54px;height: 73px"></div>
	        <div class="bnm"><img src="${base}/resource/admin/images/jdt-02.png"></div>
	    </div>
    </div>
 <div class="banner">
  <div class="bv">
    <div class="gly">${currentUser.name} 欢迎登录！<a href="javascript:void(0);" onclick="javascript:window.open('${base}/user/editPwd');" style="text-decoration: underline;color: #fff;">修改密码</a>&nbsp;<a href="javascript:exit();" style="color: #fff;">注销</a></div>
    <div class="nav">
      <ul class="clearfix">
        <a href="${base}/index.do"  style="color:#fff;"><li style="margin-left: 0;"><span>首页</span></li></a><a href="${base}/stat/tjhz" target="_blank"><li><span>综合统计</span></li></a><a href="${base}/stat/rytjhz" target="_blank"><li><span>综合查询</span></li></a><a href="${base}/sqmynews/wlyq" target="_blank"><li><span>舆情分析</span></li></a><a href="${base}/rkxx/rkDetail" target="_blank"><li><span>街镇情况</span></li></a>    
     </ul>  
    </div>
    
  </div>
   
 </div>
    
<div class="content clearfix">
 <div class="content-left l clearfix">
    <div class="zzw clearfix">
     <div class="l zzw-l">
    <div class="jdtt">
     <div id="chinaz">
        <div class="banner-btn">
            <a href="javascript:;" class="prevBtn" rel="nofollow"><i></i></a>
            <a href="javascript:;" class="nextBtn" rel="nofollow"><i></i></a>
        </div>
	 <ul class="banner-img">
	               <c:forEach items="${articlexwList}" var="article" varStatus="i" end="3">
                     <li>
          			 <img  alt="${article.title}" src="${base}/upload/jyyw${fn:replace(article.fileUrl,'\\','/')}" />
                     <a href="javascript:void(0);" onclick="javascript:window.open('${base}/xxfb/view/${article.id}');"><p>${article.title}</p></a><span></span>
                     </li>
                     </c:forEach>
	</ul>
</div>
    <ul class="banner-circle" id="banner-circle">
         <c:forEach items="${articlexwList}" var="article" varStatus="i" end="3">
         <c:if test="${i.index==0}">
		 <li class="selected">
			<a href="javascript:;" rel="nofollow">
			<img src="${base}/upload/jyyw${fn:replace(article.fileUrl,'\\','/')}"></a>
		 </li>
		 </c:if>
		 <c:if test="${i.index>0}">
		 <li>
		 	<a href="javascript:;" rel="nofollow">
			<img src="${base}/upload/jyyw${fn:replace(article.fileUrl,'\\','/')}"></a>
		 </li>
		 </c:if>
		 </c:forEach>
	</ul>
     </div>    
        
        
     </div>
    <div class="r zzw-r">
      <div class="tit clearfix"><span class="s1 l">长宁区政法综治网</span><span class="r gd"><a href="javascript:void(0);" onclick="javascript:view('${base}/xxfb/list','type.code','CNQZFZZW','','');">更多>></a></span></div> 
        <div class="ztnr">
          <c:forEach items="${articlezfList}" var="article" varStatus="i" end="1">
          	<c:if test="${i.index==0}">
          		<a href="javascript:void(0);" onclick="javascript:window.open('${base}/xxfb/view/${article.id}');">
	          		<div class="bt">
	          			<c:if test="${fn:length(article.title)>25}">${fn:substring(article.title, 0, 25)}...</c:if>
	          			<c:if test="${fn:length(article.title)<=25}">${article.title}</c:if>
	          		</div>
          		</a>
          	  	<span class="nr">
          	  	<a href="javascript:void(0);" class="nr" onclick="javascript:window.open('${base}/xxfb/view/${article.id}');">
          	  		<c:if test="${fn:length(article.contentText)>135}">${fn:substring(article.contentText, 0, 135)}...</c:if>
          	  		<c:if test="${fn:length(article.contentText)<=135}">${article.contentText}</c:if>
          	  	</a>
          	  	</span>
          	</c:if>
          </c:forEach>
              <ul class="clearfix nr-1">
                     <c:forEach items="${articlezfList}" var="article" varStatus="i" end="5">
                     <c:if test="${i.index>0}">
                     <li>
                     <span class="cvb">></span>
                     	 <span style="color: #bf4109;font-style: normal;">[${article.channelName}]</span>	
                         <a href="javascript:void(0);" onclick="javascript:window.open('${base}/xxfb/view/${article.id}');">
                         <c:if test="${fn:length(article.title)>20}">${fn:substring(article.title, 0, 20)}...</c:if>
                         <c:if test="${fn:length(article.title)<=20}">${article.title}</c:if>
                         </a>
                     </li>
                     </c:if>
                  </c:forEach>
                      
                    </ul>
        </div>
    </div>
    </div>
     <s:controller url="/indexPart1"/>
     <s:controller url="/indexPart2"/>
     <s:controller url="/indexPart3"/>
     <s:controller url="/indexPart4"/>
 </div>
 <div class="content-right r">
   <div class="gztz">
     <div class="tit clearfix"><span class="s1 l">工作通知</span><span class="r gd"><a href="javascript:void(0);" onclick="javascript:view('${base}/xxfb/list','type.code','GZTZ','','');">更多>></a></span></div>
      <ul class="clearfix nr-1">
                  <c:forEach items="${articletzList}" var="article" varStatus="i" end="2">
                     <li>
                     <span class="cvb">></span>
                         <a href="javascript:void(0);" onclick="javascript:window.open('${base}/xxfb/view/${article.id}');">
                         <c:if test="${fn:length(article.title)>20}">${fn:substring(article.title, 0, 20)}...</c:if>
                         <c:if test="${fn:length(article.title)<=20}">${article.title}</c:if>
                         </a>
                     </li>
                  </c:forEach>
      </ul> 
   </div> 
   <div class="gztz clearfix">
     <div class="tit clearfix"><span class="s1 l">工作提示</span><span class="r gd"><a href="javascript:void(0);" onclick="javascript:view('${base}/xxfb/list','type.code','GZTS','','');">更多>></a></span></div>
     <div class="l wu"><a href="javascript:void(0);"  title ="待办任务" style="color: #42920c;" onclick="javascript:window.open('${base}/activiti/process/taskList');">${activeTaskCount}</a></div> 
     <div class="l df" style="width:70%;'">
         <ul class="clearfix nr-1" style="margin-top:5px">
                     <c:forEach items="${articletsList}" var="article" varStatus="i" end="2">
                     <li>
                     <span class="cvb">></span>
                        <c:if test="${article.isMdjf!='1'}">
                           <a href="javascript:void(0);" onclick="javascript:window.open('${base}/xxfb/view/${article.id}');">
	                            <c:if test="${fn:length(article.title)>15}">${fn:substring(article.title, 0, 15)}...</c:if>
	                            <c:if test="${fn:length(article.title)<=15}">${article.title}</c:if>
	                        </a>
                        </c:if>
                        <c:if test="${article.isMdjf=='1'}">
                             <a href="javascript:void(0);" onclick="javascript:window.open('${base}/jcxx/view/${article.id}');">
	                            <c:if test="${fn:length(article.title)>15}">${fn:substring(article.title, 0, 15)}...</c:if>
	                            <c:if test="${fn:length(article.title)<=15}">${article.title}</c:if>
	                        </a>
                        </c:if>   
                     </li>
                  </c:forEach>
      </ul>  
     </div>  
   </div>
    <div class="sj-1 clearfix">
      <a href="javascript:void(0);" onclick="javascript:viewQjPazs();"><div class="l sj01" onclick="viewQjPazs();">
      	  <c:forEach items="${pazsSeason.list}" var="pazs">
          	<c:if test="${pazs.season=='1'}"><c:set var="season" value="第一季度"/></c:if>
          	<c:if test="${pazs.season=='2'}"><c:set var="season" value="第二季度"/></c:if>
          	<c:if test="${pazs.season=='3'}"><c:set var="season" value="第三季度"/></c:if>
          	<c:if test="${pazs.season=='4'}"><c:set var="season" value="第四季度"/></c:if>
          </c:forEach>
          <div class="tit">平安指数[${season}]</div>
          <div class="d1">${pazsData[0]}</div>
          <div class="d2">${pazsData[1]}&nbsp;&nbsp;${pazsData[2]}</div>
      </div></a>
      <a href="javascript:void(0);" onclick="javascript:viewGzaqg();"><div class="r sj02" >
            <div class="tit">公众安全感[${aqgYear}]</div>
            <div class="d1">长宁区  ${aqgArea}</div>
            <div class="d2">全   市 ${aqgCity}</div> 
     </div></a>
       
    </div>
    <s:controller url="/indexPart5"/>
    <div class="nav">
       <ul class="clearfix">
         <li><a href="${base}/dwxx/list" target="_blank"><img src="${base}/resource/admin/images/sydw-01.png"></a></li><li class="zc"><a href="${base}/fwxx/list" target="_blank"><img src="${base}/resource/admin/images/syfw-01.png"></a></li><li><a href="javascript:void(0);"  onclick="javascript:window.open('http://31.0.169.94:7070/cnrk');"><img src="${base}/resource/admin/images/syrk-01.png"></a></li> 
       </ul>
        <ul class="clearfix">
         <li><a href="javascript:void(0);" onclick="javascript:dzxc();"><img src="${base}/resource/admin/images/dzcx-01.png"></a></li><li class="zc"><a href="javascript:void(0);" onclick="javascript:dzrz();"><img src="${base}/resource/admin/images/dzrz-01.png"></a></li> <li><a href="javascript:void(0);" onclick="javascript:dztz();"><img src="${base}/resource/admin/images/dztz-01.png"></a></li>  
       </ul>
        <ul class="clearfix">
         <li><a href="javascript:void(0);" onclick="javascript:sftj();"><img src="${base}/resource/admin/images/rmtj-01.png"></a></li><li class="mj"><a href="${base}/dwhmc/list" target="_blank"><img src="${base}/resource/admin/images/pamj-01.png"></a></li>  
       </ul>
         <ul class="clearfix">
         <li><a href="javascript:void(0);" onclick="javascript:hyInnovate();"><img src="${base}/resource/admin/images/yjzh-01.png"></a></li><li class="zc"><a href="javascript:void(0);" onclick="javascript:cxjl();"><img src="${base}/resource/admin/images/cxjl-01.png"></a></li> <li><a href="javascript:void(0);" onclick="javascript:window.open('http://31.0.169.94:7070/cnrk/login_gis.action');"><img src="${base}/resource/admin/images/dzdt-01.png"></a></li>  
       </ul>
         <ul class="clearfix">
         <li><a href="${base}/fxpg/list" ><img src="${base}/resource/admin/images/shwdgz-01.png"></li></a><li class="zc"><img src="${base}/resource/admin/images/fxyp-01.png"></li> <li><a href="javascript:void(0);" onclick="javascript:grid();"><img src="${base}/resource/admin/images/wghgl-01.png"></a></li>  
       </ul>
    </div>
    <div class="gztz">
      <div class="tit-2"><span class="l s1">网络舆情</span><span class="r gd"><a href="${base}/sqmynews/list" target="_blank">更多>></a></span></div>
      <ul class="clearfix nr-1" style="margin-top:5px">
      <c:forEach items="${sqmyList.list}" var="news" varStatus="i" end="2">
           <li><span class="cvb">></span><a href="javascript:void(0);" onclick="javascript:window.open('${base}/sqmynews/view/${news.id}');">                         <c:if test="${fn:length(news.title)>25}">${fn:substring(news.title, 0, 25)}...</c:if>
           <c:if test="${fn:length(news.title)<=25}">${news.title}</c:if>
           </a></li>
      </c:forEach>
      </ul> 
    </div>
    <div class="txl">
        <div class="tit-2 clearfix"><span class="l s1">通讯录</span></div>
    	<div class="right clearfix"  id="right" style="height: 242px;">
    	<div class="easyui-layout" fit="true">
       		<div data-options="region:'west',split:false"  style="width:390px;background: url('${base}/resource/admin/images/txl-02.png') no-repeat;border: none;">
				<ul id="userTree" class="easyui-tree" data-options="url:'${base}/user/StreetContactsTree',animate:true"></ul>
			</div>
		</div>
    	</div>
    </div>
 </div>
</div>    
</div>
<form id="viewForm" name="f1" action="" method="post" target="_blank">
<input type="hidden" id="name1" name=""/>
<input type="hidden" id="name2" name=""/>
</form>
<script type="text/javascript">
	/**
	 *控制飘窗 
	 */
	var isMoving = 1;
	var intervalX = 1, intervalY = 1;
	var posX = 0, posY = 0;
	var interval = 1;
	var floatDivObj = document.getElementById("float_div");
	if(null!=floatDivObj){
		window.setInterval("float()", 30);
		function float() {
			if(isMoving == 1){
				posX += (interval * intervalX);
				posY += (interval * intervalY);
				$(".float_div").css("top", posY);
				$(".float_div").css("left", posX);
				if (posX < 1 || (posX + floatDivObj.offsetWidth) > $(window).width()) {
					intervalX = -intervalX;
				}
				if (posY < 1 || (posY + floatDivObj.offsetHeight + 5) > $(window).height()) {
					intervalY = -intervalY;
				}
			}
		}
	}
	function stopFloat(){
		isMoving = 0;
	}
	function reStartFloat(){
		isMoving = 1;
	}
 	function viewGzaqg(){
 		//var win=creatStreetWin('公众安全感',900,500,'icon-search','${base}/gzaqg/view');
 		var win=creatStreetWin('公众安全感',1020,410,'icon-search','${base}/gzaqg/viewChart');
 		win.window('open');
 	}
 	function exit(){
 		if(confirm("确认注销吗?")){
 			location.href='${base}/logout.do';
 		}
 	}
 	function dzxc(){
 		window.open('http://31.0.169.34:9090/cn_inspect/loginZzwwAccount.action?accountNo=${currentUser.accountNo}&zzwwUserKey=${currentUser.keyCode}');
 	}
 	function dzrz(){
 		window.open('http://31.0.169.94:7447/cnelog/zzwwLogin.jsp?user_name=${currentUser.accountNo}&zzwwUserKey=${currentUser.keyCode}');
 	}
 	function dztz(){
 		window.open('http://31.0.132.212:8080/jwhjf/check.do?accountNo=${currentUser.accountNo}&keyCode=${currentUser.keyCode}');
 	}
 	function sftj(){
 		window.open('http://31.0.179.101/cndtj');
 	}
 	function hyInnovate(){
 		window.open('http://31.0.155.244:8080/huayang_innovate/loginAccount.action?accountNo=${currentUser.accountNo}&password=${currentUser.accountNo}');
 	}
 	function cxjl(){
 		window.open('http://31.0.132.206:8080/cn_xyxxpt/ptLoginController/ddLogin?UserIdentity=${currentUser.accountNo}');
 	}
 	function grid(){
 		window.open('http://10.231.3.6/CityGrid/LogOn.aspx');
 	}
 	function viewQjPazs(){
 		var win=creatStreetWin('平安指数',820,420,'icon-search','${base}/qjpazs/view');
 		win.window('open');
 	}
 	function viewPacjMore(){
 		var win=creatStreetWin('平安创建',435,285,'icon-search','${base}/qjpazs/pacj');
 		win.window('open');
 	}
	function viewSftjArticle(id){
		window.open("${base}/sftjArticle/view/"+id);
	}
 	function view(url,name1,value1,name2,value2){
 		$("#viewForm").attr("action",url);
 		$("#name1").attr("name",name1);
 		$("#name1").val(value1);
 		$("#name2").attr("name",name2);
 		$("#name2").val(value2);
 		$("#viewForm").submit();
 	}
 	function closeFloatWindow(){
		$("#float_div").hide();
	}
 	function changeCursor(obj){
 		 obj.style.cursor='pointer';
 	}
</script>
</body>
</html>





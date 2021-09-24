﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<style>
.box-a,.box-b{width:24%;height:100%;background:rgba(255,255,255,1);margin-left: 7px;border:2px solid rgba(219,222,229,1);border-radius:4px;float: left}
.box-a{border: 1px solid #DBDEE5;}
/* .box-a:hover{

            -webkit-box-shadow: #ccc 0px 5px 5px;

            -moz-box-shadow: #ccc 0px 5px 5px;

            box-shadow: #ccc 0px 5px 5px;  } */
.box-b{border: 1px solid #DBDEE5;}
/* .box-b:hover{

            -webkit-box-shadow: #ccc 0px 5px 5px;

            -moz-box-shadow: #ccc 0px 5px 5px;

            box-shadow: #ccc 0px 5px 5px;  } */
.box-c{width:48.7%;
		height:100%;
		background:rgba(255,255,255,1);
		border:1px solid rgba(219,222,229,1);
		border-radius:4px;
		margin-left: 7px;
		float: left;
		margin-top: 7px;
		}
.box-d{width:38.3%;
		height:100%;
		background:rgba(255,255,255,1);
		border:1px solid rgba(219,222,229,1);
		border-radius:4px;
		float: left;
		margin-left: 8px;
		margin-top: 7px;
		}
</style>
<style>
.box-a1{width:50%;
		height:100%;
		background:rgba(253,202,104,1);
		opacity:0.5;
		border-radius:4px 4px 4px 4px;
		float: left;
}
.box-a2{width:50%;
		height:100%;
		background:rgba(94,215,163,1);
		opacity:0.5;
		border-radius:4px 4px 4px 4px;
		float: left;
}
.box-a3{width:50%;
		height:100%;
		background:rgba(0,126,255,1);
		opacity:0.5;
		border-radius:4px 4px 4px 4px;
		float: left;
}
.box-a4{width:50%;
		height:100%;
		background:rgba(250,71,61,1);
		opacity:0.5;
		border-radius:4px 4px 4px 4px;
		float: left;
}
.tonggao{width:48.7%;
				height:100%;
				background:rgba(255,255,255,0.99);
				border:1px solid rgba(219,222,229,1);
				border-radius:4px;
				margin-left: 7px;	
				margin-top: 7px;
}
.zhidu{width:48.7%;
				height:100%;
				background:rgba(255,255,255,0.99);
				border:1px solid rgba(219,222,229,1);
				border-radius:4px;
				margin-left: 7px;
				margin-top: 7px;
}
.jixiao{width:18.3%;
		height:100%;
		background:rgba(255,255,255,0.99);
		border:1px solid rgba(227,229,235,1);
		border-radius:4px;
		margin-top: 7px;
		margin-left: 7px;
}
</style>
 <style>
    .fl{ float: left; }
    .fr{ float: right; }
    .tagcloud a{ position: absolute; margin-top:20px; top: 0; left: 0;  display: block; padding: 5px 20px; color: #333; 
    	font-size: 12px; border: 1px solid #e6e7e8; border-radius: 18px; background-color: #fff; 
    	text-decoration: none; white-space: nowrap;
        /*-o-box-shadow: 6px 4px 8px 0 rgba(151,142,136,.34);
        -ms-box-shadow: 6px 4px 8px 0 rgba(151,142,136,.34);
        -moz-box-shadow: 6px 4px 8px 0 rgba(151,142,136,.34);
        -webkit-box-shadow: 6px 4px 8px 0 rgba(151,142,136,.34);
         box-shadow: 6px 4px 8px 0px rgba(151,142,136,.34); */
        -ms-filter:"progid:DXImageTransform.Microsoft.Shadow(Strength=4,Direction=135, Color='#000000')";/*兼容ie7/8*/
        filter: progid:DXImageTransform.Microsoft.Shadow(color='#969696', Direction=125, Strength=9);
      /*strength是阴影大小，direction是阴影方位，单位为度，可以为负数，color是阴影颜色 （尽量使用数字）使用IE滤镜实现盒子阴影的盒子必须是行元素或以行元素显示（block或inline-block;）*/
    }
    .tagcloud a:hover{ color: #3385cf; }
  </style>
  <style type="text/css">
.div1 { font-size: 30px; }
.div2 { font-size: 25px; }
.div3 { font-size: 18px; }
.div4 { font-size:36px;}
.div4:hover { font-size: 40px; }

.link a{display:block;padding:10px 10px 30px 0px;}
.link a:hover{background:#newcolor;}
</style>
<style>

.list_lh{ height:100%;width:100%; overflow:hidden;}
.list_lh li{width:46%;height:70px; margin: 1% 1% 1% 1%}
.list_lh li a{display:block;width:100%;height:100%;margin-left: 0.5%;margin-top: 0.5%;}
.list_li{border:1px solid rgba(219,222,229,1);border-radius:4px;
}
.list_li:hover{
			border:1px solid rgba(0, 126, 255, 1);
</style>
<div id="1111" class="easyui-layout" style="background-color: #f0f5f7;height: 100%;width:100%; overflow:hidden;">
	<div style="width:99.9%; height: 20%;margin-top:0.5%;">
		<div id="taskNumsId" class="box-a" onmousemove="dbsxStart()" onmouseout="dbsxOver()">
		</div>
	
	<div id="countAlreadyId" class="box-b" onmousemove="ybsxStart()" onmouseout="ybsxOver()">
	</div>
	
	<div id="countFinishId" class="box-b" onmousemove="bjsxStart()" onmouseout="bjsxOver()">
	
	</div>
	
	<div id="countInforId" class="box-b" onmousemove="xxtxStart()" onmouseout="xxtxOver()">
	
	</div>
	</div>
	<div style="width:99.9%; height:77%;margin-top:0.2%;">
		<div id="tzgg" class="tonggao" style="float: left;">
		<img style="margin-left: 3%;margin-top: 2.3%;float: left;" src="${base}/resource-modality/${themenurl}/index/biaotitiao.png">
			<h4 style="padding-left:2%;padding-top:1.8%;font-size: 12px;color: #666666;float: left">
			通知公告
			</h4>
						<a style="padding-left:80%" href="#" onclick="tzggList()">
							<img style="margin-top: 2%;" id="quanbu0" src="${base}/resource-modality/${themenurl}/index/huisequanbu.png" onmousemove="quanbulan0()" onmouseout="quanbuhui0()" >
						</a>
			<hr style="margin-top: 1%;background-color: rgba(1,1,1,0);border-bottom: 1px #d9e3e7 solid;">
			<table id="noticeId" style="width:100%;height: 70%;display:table;min-height:70%;table-layout: fixed;">
			</table>
		</div>
		<div id="zdzx" class="zhidu" style="float: left;">
		<img style="margin-left: 3%;margin-top: 2.3%;float: left;" src="${base}/resource-modality/${themenurl}/index/biaotitiao.png">
			<h4 style="padding-left:2%;padding-top:1.8%;font-size: 12px;color: #666666;float: left;">
			制度中心</h4>
						<a style="padding-left:80%" href="#" onclick="zdzxList()">
							<img style="margin-top: 2%;" id="quanbu1" src="${base}/resource-modality/${themenurl}/index/huisequanbu.png" onmousemove="quanbulan1()" onmouseout="quanbuhui1()" >
						</a>
			<hr style="margin-top: 1%;background-color: rgba(1,1,1,0);border-bottom: 1px #d9e3e7 solid;">
			<table id="cheterId" style="width:100%;height: 70%;display:table;min-height:70%;table-layout: fixed;">
			</table>
		</div>
		</div>
	<%-- <div style="width:99.9%; height:40%;margin-top:0.1%;">
	<div class="box-c">
		<img style="margin-left: 3%;margin-top: 2.3%;float: left;" src="${base}/resource-modality/${themenurl}/index/biaotitiao.png">
		<h4 style="padding-left:5%;padding-top:1.8%;font-size: 12px;color: #666666;">
			我的报销总额</h4>
    		<hr style="margin-top: 1%;background-color: rgba(1,1,1,0);border-bottom: 1px #d9e3e7 solid;">
    		<div style="padding-top: 2%;width:65px;height:19px;border-radius:9px;float:right;color:#666666">&nbsp;单位：元</div>
				<table style="width:70%; height:20%;line-height: 190%;margin-bottom: 1%;">
					<thead style="width: 100%;height: 100%">
                		<tr style="width: 100%;height: 100%">
		                    <th style="padding-left:2%;width: 100%;height: 100%">我的近期报销</th>
                		</tr>
            		</thead>
				</table>
					<div style="width:70%;float: left;height: 100%">						
						<div style="width:100%;height:100%;">
						<!-- 页面链接 -->
							<jsp:include page="/newMain/index-apply-marquee.jsp"></jsp:include>
						</div>					
					</div>
					<br>
					<table id="apply_table" style="margin-right:1%;width:29%;height:80%;float: right;">
					</table>
		</div>
		<div class="box-c">
		<img style="margin-left: 3%;margin-top: 2.3%;float: left;" src="${base}/resource-modality/${themenurl}/index/biaotitiao.png">
		<h4 style="padding-left:5%;padding-top:1.8%;font-size: 12px;color: #666666;">
			我的借款</h4>
				<hr style="margin-top: 1%;background-color: rgba(1,1,1,0);border-bottom: 1px #d9e3e7 solid;">
				<div style="padding-top: 2%;width:65px;height:19px;border-radius:9px;float:right;color:#666666">&nbsp;单位：元</div>
				<table style="width:70%; height:20%;line-height: 190%;margin-bottom: 1%;">
					<thead style="width: 100%;height: 100%">
                		<tr style="width: 100%;height: 100%">
		                    <th style="padding-left:2%;width: 100%;height: 100%">我的近期借款</th>
                		</tr>
            		</thead>
				</table>
				<div style="width:70%;float: left;height: 100%">
							<div style="width:100%;height:100%;">
								<jsp:include page="/newMain/index-loan-marquee.jsp"></jsp:include>
							</div>
					</div>
					<br>
					<table id="loan_table" style="margin-right:1%;width:29%;height:80%;float: right;">
					</table>
		</div>
		<div class="box-d">
			<img style="margin-left: 2%;margin-top: 2.7%;float: left;" src="${base}/resource-modality/${themenurl}/index/biaotitiao.png">
			<h4 style="padding-left:4%;padding-top:2%;font-size: 12px;color: #666666;">我的资产</h4>
			<hr style="margin-top: 1.6%;background-color: rgba(1,1,1,0);border-bottom: 1px #d9e3e7 solid">
			<table style="width: 475px;height: 190px; display: block;">
				<tr style="width: 65px;height: 190px;float:left;display: block;">
					<td id="assetsNumberId" style="width: 65px;height: 190px;display: block;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:rgba(102,102,102,1);margin-top:4px;">
						&nbsp;&nbsp;&nbsp;我的资产<br><br>&nbsp;&nbsp;&nbsp;共计
					</td>
				</tr>
				<tr  style="width:400px; height: 170px;float: left">
						<td class="tagcloud fl" style="width: 400px;height: 150px;min-width:400px;min-height: 150px;">
							<c:forEach var="assets" items="${assets}">
								<a href="#" onclick="ledger_fixed_detail('0','${assets.tarlCode}')">${assets.tarlNmae}</a>
						</c:forEach>
						</td>
				</tr>
			</table>
		</div>
		</div>
	</div> --%>
		<input hidden="hidden"  value="${themenurl}" id="themenurlId">
	</div>
<script type="text/javascript">
var scrnwidth = $(document).width();

//通知公告 
notice();
function notice(){
	$.ajax({
		url: base+ "/index/notice",
		type : 'post',
		async : true,
		dataType:'json',
	    contentType:'application/json;charset=UTF-8',
		success : function(json) {
				var html = "";
				var html2 = "";
				var html3 = "";
				var html5 = "";
				if(json!=null&&json.length>0){
				for( var i=0; i<json.length;i++){
					var noticeTitle = json[i].noticeTitle;
					var noticeId = json[i].noticeId;
					var releaseTime = zcsjFormat(json[i].releaseTime);
					var discrepancyTime = json[i].discrepancyTime;
					html += "<tr style=\"width:100%;\">";
					html += "<td style=\"valign=top;padding-left:20px;width:70%;overflow: hidden;text-overflow: ellipsis;white-space: nowrap\"><a href=\"#\" onclick=\"openNotice('"+noticeId+"')\" style=\"color: #666666\">"+noticeTitle+"</a></td>";
					if(discrepancyTime>7){
					html += "<td style=\"width:10%\"></td>";
					}else{
					html += "<td style=\"width:10%\"><img src=\"${base}/resource-modality/${themenurl}/index/new.png\"></td>";
					}
					html += "<td align=\"left\" style=\"width:20%\">"+releaseTime+"</td>";
					html += "</tr>";
				
				}								
				}
				 $("#noticeId").html(html); 
				 //获取当前table可见tr的length 根据length来添加空的tr				 
				 /* if($("#noticeId>tbody").children("tr:visible").length == 1){
					 html2 += "<tr style=\"width:100%;height:20%\"><td></td></tr>";	
					 html2 += "<tr style=\"width:100%;height:20%\"><td></td></tr>";
					 html2 += "<tr style=\"width:100%;height:20%\"><td></td></tr>";
					 $("#noticeId").append(html2);
				 }else if($("table#noticeId tr:visible").length == 2) {
						html3 += "<tr style=\"width:100%;height:20%\"><td></td></tr>";
						html3 += "<tr style=\"width:100%;height:20%\"><td></td></tr>";
						$("#noticeId").append(html3);  
					}else if($("table#noticeId tr:visible").length == 3) {
						html5 += "<tr style=\"width:100%;height:20%\"><td></td></tr>";
						$("#noticeId").append(html5);  
					} */	
		}		
	});

}


//制度中心
cheter();
function cheter(){
	$.ajax({
		url: base+ "/index/cheter",
		type : 'post',
		async : true,
		dataType:'json',
	    contentType:'application/json;charset=UTF-8',
		success : function(json) {
				var html = "";
				var html2 = "";
				var html3 = "";
				var html5 = "";
				if(json!=null&&json.length>0){
				for( var i=0; i<json.length;i++){
					var fileName = json[i].fileName;
					var systemId = json[i].systemId;
					var releseTime = zcsjFormat(json[i].releseTime);
					var discrepancyTime = json[i].discrepancyTime;
					html += "<tr style=\"width:100%;\">";
					html += "<td style=\"padding-left:20px;width:70%;overflow: hidden;text-overflow: ellipsis;white-space: nowrap\"><a href=\"#\" onclick=\"openPDF('"+fileName+"','"+systemId+"')\" style=\"color: #666666\">"+fileName+"</a></td>";
					if(discrepancyTime>7){
					html += "<td style=\"width:10%\"></td>";
					}else{
					html += "<td style=\"width:10%\"><img src=\"${base}/resource-modality/${themenurl}/index/new.png\"></td>";
					}
					html += "<td align=\"left\" style=\"width:20%\">"+releseTime+"</td>";
					html += "</tr>";
				}
				}
				$("#cheterId").append(html);
				//获取当前table可见tr的length 根据length来添加空的tr				 
				 /* if($("#cheterId>tbody").children("tr:visible").length == 1){
					 html2 += "<tr style=\"width:100%;height:20%\"><td></td></tr>";	
					 html2 += "<tr style=\"width:100%;height:20%\"><td></td></tr>";
					 html2 += "<tr style=\"width:100%;height:20%\"><td></td></tr>";
					 $("#cheterId").append(html2);
				 }else if($("table#cheterId tr:visible").length == 2) {
						html3 += "<tr style=\"width:100%;height:20%\"><td></td></tr>";
						html3 += "<tr style=\"width:100%;height:20%\"><td></td></tr>";
						$("#cheterId").append(html3);  
					}else if($("table#cheterId tr:visible").length == 3) {
						html5 += "<tr style=\"width:100%;height:20%\"><td></td></tr>";
						$("#cheterId").append(html5);  
					} */	
		}
	});
}
//资产总数
assetsNumber()
function assetsNumber(){
	$.ajax({
		url: base+ "/index/assetsNumber",
		type : 'post',
		async : true,
		dataType:'json',
	    contentType:'application/json;charset=UTF-8',
		success : function(json) {
				var html = "";
				if(json!=null&&json.length>0){
				for( var i=0; i<json.length;i++){
					var tarlNmaeNumber = json[i].tarlNmaeNumber;
					html += "<a class=\"div4\" href=\"#\" onclick=\"queryFixedAssets()\" style=\"margin-top:14px; float:left;font-family:MicrosoftYaHei;font-weight:400;color:rgba(0,126,255,1);\" >";
					html += "&nbsp;"+tarlNmaeNumber+"";
					html += "</a>";
				}
				}
				$("#assetsNumberId").append(html);
		}
	});
}
//待办事项加载
taskNums();
function taskNums(){
	$.ajax({
		url: base+ "/index/taskNums",
		type : 'post',
		async : true,
		dataType:'json',
	    contentType:'application/json;charset=UTF-8',
		success : function(json) {
				var html = "";
					var taskNums = json[0];
					html += "<div style=\"width:2%;height: 100%;background:rgba(255,255,255,0.99);float: left;\"><img id=\"dbsxId\"  onmousemove=\"dbsxStart()\" onmouseout=\"dbsxOver()\" class=\"box-a1\" src=\"${base}/resource-modality/${themenurl}/index/daiban0.png\"></div>";
					html += "<a href=\"#\" onclick=\"detailDb()\" style=\"display:block; font-size:18px;font-family:MicrosoftYaHei;line-height:10px;width:98%;height:100%;color:#666666FF\">";
					if(scrnwidth >1300){
					html += "<img src=\"${base}/resource-modality/${themenurl}/index/dbsx.png\" style=\"vertical-align: top;width: 25%;height: 60%;margin:8%;float: left;\">";
					}else{
					html += "<img src=\"${base}/resource-modality/${themenurl}/index/dbsx0.png\" style=\"vertical-align: top;width: 25%;height: 35%;margin:8%;float: left;\">";
					}
					html += "<span style=\"margin-left: 25%;margin-top:8%;float: left;\">待办事项</span>";
					html += "<span style=\"font-size: 30px; font-family:MicrosoftYaHei;line-height: 90px;margin-left:30%;color: red;\" id=\"symenu_dbsx\">";
					if(taskNums==null){
					html += "0</span></a>";
					}else{
					html += ""+taskNums+"</span></a>";
					}
				$("#taskNumsId").append(html);
		}
	});
}
//已办事项加载
countAlready();
function countAlready(){
	$.ajax({
		url: base+ "/index/countAlready",
		type : 'post',
		async : true,
		dataType:'json',
	    contentType:'application/json;charset=UTF-8',
		success : function(json) {
				var html = "";
					var countAlready = json[0];
					html += "<div style=\"width:2%;height: 100%;background:rgba(255,255,255,0.99);float: left;\"><img id=\"ybsxId\" class=\"box-a2\" onmousemove=\"ybsxStart()\" onmouseout=\"ybsxOver()\" src=\"${base}/resource-modality/${themenurl}/index/yiban0.png\"></div>";
					html += "<a href=\"#\" onclick=\"detailYb()\" style=\"display:block; font-size:18px;font-family:MicrosoftYaHei;line-height:10px;width:98%;height:100%;color:#666666FF\">";
					if(scrnwidth >1300){
					html += "<img src=\"${base}/resource-modality/${themenurl}/index/ybsx.png\" style=\"vertical-align: top;width: 25%;height: 60%;margin:8%;float: left;\">";
					}else{
					html += "<img src=\"${base}/resource-modality/${themenurl}/index/ybsx0.png\" style=\"vertical-align: top;width: 25%;height: 35%;margin:8%;float: left;\">";
					}
					html += "<span style=\"margin-left: 25%;margin-top:8%;float: left;\">已办事项</span>";
					html += "<span style=\"font-size: 30px; font-family:MicrosoftYaHei;line-height: 90px;margin-left:30%;color:#FDCA68;\" id=\"symenu_ybsx\">";
					if(countAlready==null){
					html += "0</span></a>";
					}else{
					html += ""+countAlready+"</span></a>";
					}
				$("#countAlreadyId").append(html);
		}
	});
}
//办结事项加载
countFinish();
function countFinish(){
	$.ajax({
		url: base+ "/index/countFinish",
		type : 'post',
		async : true,
		dataType:'json',
	    contentType:'application/json;charset=UTF-8',
		success : function(json) {
				var html = "";
					var countFinish = json[0];
					html += "<div style=\"width:2%;height: 100%;background:rgba(255,255,255,0.99);float: left;\"><img id=\"bjsxId\" class=\"box-a3\" onmousemove=\"bjsxStart()\" onmouseout=\"bjsxOver()\" src=\"${base}/resource-modality/${themenurl}/index/banjie0.png\"></div>";
					html += "<a href=\"#\" onclick=\"detailBj()\" style=\"display:block; font-size:18px;font-family:MicrosoftYaHei;line-height:10px;width:98%;height:100%;color:#666666FF\">";
					if(scrnwidth >1300){
					html += "<img src=\"${base}/resource-modality/${themenurl}/index/bjsx.png\" style=\"vertical-align: top;width: 25%;height: 60%;margin:8%;float: left;\">";
					}else{
					html += "<img src=\"${base}/resource-modality/${themenurl}/index/bjsx0.png\" style=\"vertical-align: top;width: 25%;height: 35%;margin:8%;float: left;\">";
					}
					html += "<span style=\"margin-left: 25%;margin-top:8%;float: left;\">办结事项</span>";
					html += "<span style=\"font-size: 30px; font-family:MicrosoftYaHei;line-height: 90px;margin-left:30%;color:#5ED7A3;\" id=\"symenu_bjsx\">";
					if(countFinish==null){
					html += "0</span></a>";
					}else{
					html += ""+countFinish+"</span></a>";
					}
				$("#countFinishId").append(html);
		}
	});
}
//消息加载

var newsUpdate = 0;
countInfor();
function countInfor(){
	$.ajax({
		url: base+ "/index/countInfor",
		type : 'post',
		async : true,
		dataType:'json',
	    contentType:'application/json;charset=UTF-8',
		success : function(json) {
					var html = "";
					var countInfor = json;
					newsUpdate = json;
					html += "<div style=\"width:2%;height: 100%;background:rgba(255,255,255,0.99);float: left;\"><img id=\"xxtxId\" class=\"box-a4\" onmousemove=\"xxtxStart()\" onmouseout=\"xxtxOver()\" src=\"${base}/resource-modality/${themenurl}/index/xiaoxi0.png\"></div>";
					html += "<a href=\"#\" onclick=\"xiaoxi()\" style=\"display:block; font-size:18px;font-family:MicrosoftYaHei;line-height:10px;width:98%;height:100%;color:#666666FF\">";
					if(scrnwidth >1300){
					html += "<img src=\"${base}/resource-modality/${themenurl}/index/xxtx.png\" style=\"vertical-align: top;width: 25%;height: 60%;margin:8%;float: left;\">";
					}else{
					html += "<img src=\"${base}/resource-modality/${themenurl}/index/xxtx0.png\" style=\"vertical-align: top;width: 25%;height: 35%;margin:8%;float: left;\">";
					}
					html += "<span style=\"margin-left: 25%;margin-top:8%;float: left;\">消息</span>";
					html += "<span style=\"font-size: 30px; font-family:MicrosoftYaHei;line-height: 90px;margin-left:30%;color: #007EFFFF;\" id=\"symenu_xx\">";
					if(countInfor==null){
					html += "0</span></a>";
					}else{
					html += ""+countInfor+"</span></a>";
					}
				$("#countInforId").append(html);
				if(newsUpdate!=0){
				var loginType = '${loginType}';
				if(loginType =="0"){
					skipNews();
				}
				}
		}
	});
}

function skipNews(){
	msg='<div style=" overflow:hidden;margin-top: 15%;width: 65%;margin-left: 30%;">您当前有'+'<font size="4" color="red">'+newsUpdate+'</font>'+'条未读消息！<br><br><input type="button" style="text-align:right;margin-left: 17%;" value="查看消息"  onclick="xiaoxi()" id="ckxxs"/></div>';
	$.messager.show(
			{
				title:'系统提示',
				msg:msg,
				height:'200',
				width:'300',
				timeout:5000,
				showType:'slide'
			}
	   );
}

//查看消息信息
$("#ckxxs").click(function(){
	var win = parent.creatSearchDataWin('未读消息', 970,580, 'icon-search', "/PrivateInfor/unRead");
	win.window('open');
});
</script>
<script type="text/javascript">

/* //-----延迟加载----
var isflag1=false;
var isflag2=false;
$('#tt').tabs({
	onSelect:function(title){
		if("我的报销总额"==title && isflag1==false){
			countAndSumApply();
			applyMarquee();
			isflag1=true;
		}
		if("我的借款"==title && isflag1==true && isflag2==false){
			amountOfBorrowings();
			loanMarquee();
			isflag2=true;
		}
    }
}); */
countAndSumApply();
//applyMarquee();
function countAndSumApply(){
	$.ajax({
		url: base+ "/index/countAndSumApply",
		type : 'post',
		async : true,
		dataType:'json',
	    contentType:'application/json;charset=UTF-8',
		success : function(json) {
				var html = "";
				if(json!=null&&json.length>0){
				for( var i=0; i<json.length;i++){
					var sumAmount = json[i].sumAmount;
					var countId = json[i].countId;
					html += "<tr style=\"width:51px;height:15px;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:rgba(153,153,153,1);\">";
					html += "<td align=\"right\" style=\"padding-top: 60px;\">报销总金额</td>";
					html += "</tr>";
					html += "<tr style=\"width:220px;height:33px;font-size:36px;font-family:MicrosoftYaHei;font-weight:400;color:rgba(137,196,240,1);\">";
					html += "<td align=\"right\" style=\"height:36px;\" ><a  onclick=\"detailApplyForReimbursement()\" style=\"font-family:MicrosoftYaHei;font-weight:bold;color:rgba(94,215,163,1)\" href=\"#\" class=\"div2\" ><span>¥</span>"+fomatMoney(sumAmount,2)+"</a></td>";
					html += "</tr>";
					html += "<br>";
					html += "<tr style=\"width:220px;height:13px;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:rgba(153,153,153,1);\">";
					html += "<td style=\"width:220px;height:13px;padding-bottom:30px;\" align=\"right\"><a style=\"font-family:MicrosoftYaHei;font-weight:400;color:rgba(153,153,153,1);\" onclick=\"detailApplyForReimbursement()\" href=\"#\">累计报销&nbsp;"+countId+"&nbsp;笔数</a></td>";
					html += "</tr>";
				}
				}
				$("#apply_table").append(html);
		}
	});
}
amountOfBorrowings();
function amountOfBorrowings(){
	$.ajax({
		url: base+ "/index/amountOfBorrowings",
		type : 'post',
		async : true,
		dataType:'json',
	    contentType:'application/json;charset=UTF-8',
		success : function(json) {
				var html = "";
				if(json!=null&&json.length>0){
				for( var i=0; i<json.length;i++){
					var sumLAmount = json[i].sumLAmount;
					var countLId = json[i].countLId;
					html += "<tr style=\"width:51px;height:15px;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:rgba(153,153,153,1);\">";
					html += "<td align=\"right\" style=\"padding-top: 60px;\">借款总额</td>";
					html += "</tr>";
					html += "<tr style=\"width:220px;height:33px;font-size:36px;font-family:MicrosoftYaHei;font-weight:400;color:rgba(137,196,240,1);\">";
					html += "<td align=\"right\" style=\"height:36px;\" ><a  onclick=\"detailBorrowMoney()\" style=\"font-family:MicrosoftYaHei;font-weight:bold;color:#FF88C2\" href=\"#\" class=\"div2\" ><span>¥</span>"+fomatMoney(sumLAmount,2)+"</a></td>";
					html += "</tr>";
					html += "<br>";
					html += "<tr style=\"width:220px;height:13px;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:rgba(153,153,153,1);\">";
					html += "<td style=\"width:220px;height:13px;padding-bottom:30px;\" align=\"right\"><a style=\"font-family:MicrosoftYaHei;font-weight:400;color:rgba(153,153,153,1);\" onclick=\"detailBorrowMoney()\" href=\"#\">累计借款&nbsp;"+countLId+"&nbsp;笔数</a></td>";
					html += "</tr>";
				}
				}
				$("#loan_table").append(html);
		}
	});
}
function quanbuhui1(){
	var themenurl=$('#themenurlId').val();
	$("#quanbu1").attr("src",base+"/resource-modality/"+themenurl+"/index/huisequanbu.png");
}
function quanbulan1(){
	var themenurl=$('#themenurlId').val();
	$("#quanbu1").attr("src",base+"/resource-modality/"+themenurl+"/index/quanbu.png");
}
function quanbuhui0(){
	var themenurl=$('#themenurlId').val();
	$("#quanbu0").attr("src",base+"/resource-modality/"+themenurl+"/index/huisequanbu.png");
}
function quanbulan0(){
	var themenurl=$('#themenurlId').val();
	$("#quanbu0").attr("src",base+"/resource-modality/"+themenurl+"/index/quanbu.png");
}
//资产查看
function ledger_fixed_detail(id,tarlCode) {
			var win = parent.creatSearchDataWin('资产查看', 1030,580, 'icon-search',"/Rece/detail1/"+id+"?tarlCode="+tarlCode+"");
			win.window('open');
	}
//查看报销明细
function queryDetail(dName,id){
	//直接报销
	if(dName=="0"){
		var win = parent.creatWin(' ', 1060,580, 'icon-search', "/directlyReimburse/edit?id="+id+"&editType=0");
	}else{
		//申请报销1
		win = parent.creatWin(' ', 1060, 580, 'icon-search', "/reimburse/edit?id="+id+"&editType=0");
	}
	win.window('open');
}
//查看借款明细
function queryBorrow(id){
	var win = parent.creatSearchDataWin(' ', 1010,580, 'icon-search', "/loan/edit?id="+id+"&editType=0");
	win.window('open');
}
//查看资产明细
function queryFixedAssets(){
	var win = parent.creatSearchDataWin('资产明细', 1010,580, 'icon-search', "/Rece/fixedlist1");
	win.window('open');
}
//查看代办信息
function detailDb(){
	var win = parent.creatSearchDataWin('待办事项',1010,580,'icon-search',"/index/taskList?listType=3");
	win.window('open');
}
//查看已办信息
function detailYb(){
	var win = parent.creatSearchDataWin('已办事项', 1010,580, 'icon-search', "/index/taskList?listType=4");
	win.window('open');
}
//查看办结信息
function detailBj(){
	var win = parent.creatSearchDataWin('办结事项', 1010,580, 'icon-search', "/index/taskList?listType=5");
	win.window('open');
}
//查看消息信息
function xiaoxi(){
	var win = parent.creatSearchDataWin('未读消息', 970,580, 'icon-search', "/PrivateInfor/List");
	win.window('open');
}
//查看本年度报销额信息明细
function detailApplyForReimbursement(){
	var win = parent.creatSearchDataWin(' ', 1010,580, 'icon-search', "/reimburseLedger/list1?");
	win.window('open');
}
//查看本年度借款额信息明细
function detailBorrowMoney(){
	var win = parent.creatSearchDataWin(' ', 1010,580, 'icon-search', "/loanLedger/list1");
	win.window('open');
}
/* //加载tab页
flashtab('1111'); */

//用户添加快速入口
function ksrkadd() {
	var win = parent.creatWin('设置', 840, 475, 'icon-search', "/index/indexShortcut");
	win.window('open');
}

//查看通知公告
function openNotice(noticeId) {
	//window.open(base + "/notice/detail/"+noticeId);
	 var win=parent.creatSearchDataWin('通知公告-查看',1300,630,'icon-search',"/notice/detail/"+noticeId);
	 win.window('open');
}
//查看制度
function openPDF(fileName,systemId){
	window.open(base+'/systemcentergl/viewPDF?systemId='+systemId,'open');
	/* window.open(base+"/systemcentergl/viewPDF/"+fileName,"open"); */
}
//通知公告列表
function tzggList(){
	var win=parent.creatSearchDataWin('通知公告',1300,630,'icon-search',"/notice/list?menuMark=fromIndex");
	 win.window('open');
}
//制度列表
function zdzxList(){
	window.open(base + "/systemcentergl/list?typeStr=All");
}
</script>
<script type="text/javascript">
	//消息推送 更新待办事项数字 更新待办菜单列表
	var url1 = window.location.host;//localhost:8080
	var url2 = base;//nkgl
	var websocket;
	if ('WebSocket' in window) {
		
        //websocket = new WebSocket("ws://localhost:8080/nkgl/socket");
        websocket = new WebSocket("ws://" + url1 + url2 + "/socket");
    }
    else if ('MozWebSocket' in window) {
        //websocket = new MozWebSocket("ws://localhost:8080/nkgl/socket");
        websocket = new MozWebSocket("ws://" + url1 + url2 + "/socket");
    }
    else {
        //websocket = new SockJS("http://localhost:8080/nkgl/socket");
        websocket = new SockJS("ws://" + url1 + url2 + "/socket");
    }
	websocket.onopen = function(event) {
		/* console.log("WebSocket:已连接");
		console.log(event); */
	};
	websocket.onmessage = function(event) {
		var data = event.data.split(',');
		//重新变更待办数字
		$('#symenu_dbsx').html(data[0]);
		$('#symenu_ybsx').html(data[1]);
		$('#symenu_bjsx').html(data[2]);
		$('#symenu_xx').html(data[3]);
		//alert("WebSocket:收到一条消息" + data);
		//更新待办菜单列表
		$('#task_dg0').datagrid('reload');
		var type=data[4];
		if(type !=0){
			var msg="";
			if(type==2){
				msg='<div style=" overflow:hidden;margin-top: 15%;width: 65%;margin-left: 30%;">您当前有'+'<font size="4" color="red">'+1+'</font>'+'条新待办任务！<br><br><input type="button" style="text-align:right;margin-left: 17%;" value="查看待办" id="ckdb"/></div>';
			}
			if(type==1){
				msg='<div style=" overflow:hidden;margin-top: 15%;width: 65%;margin-left: 30%;">您当前有'+'<font size="4" color="red">'+1+'</font>'+'条新消息！<br><br><input type="button" style="text-align:right;margin-left: 17%;" value="查看消息"  id="ckxx"/></div>';
			}
			if(type==3){
				msg='<div style=" overflow:hidden;margin-top: 15%;width: 65%;margin-left: 30%;">您当前有'+'<font size="4" color="red">'+data[3]+'</font>'+'条未读消息！<br><br><input type="button" style="text-align:right;margin-left: 17%;" value="查看消息"  onclick="xiaoxi()" id="ckxxs"/></div>';
			}
			$.messager.show(
					{
						title:'系统提示',
						msg:msg,
						height:'200',
						width:'300',
						timeout:5000,
						showType:'slide'
					}
			   );
		}
		//查看代办信息
		$("#ckdb").click(function(){
			var win = parent.creatSearchDataWin('待办事项',1010,580,'icon-search',"/index/taskList?listType=3");
			win.window('open');
		});
		//查看消息信息
		$("#ckxx").click(function(){
			var win = parent.creatSearchDataWin('未读消息', 970,580, 'icon-search', "/PrivateInfor/List");
			win.window('open');
		});
	};
	websocket.onerror = function(event) {
		/* console.log("WebSocket:发生错误 ");
		console.log(event); */
	};
	websocket.onclose = function(event) {
		/* console.log("WebSocket:已关闭");
		console.log(event); */
	}
	
</script>
<script>
function show(){
document.getElementById("div").style.display="";
//alert(document.getElementById("div").style.display)
}
function hidden(){
document.getElementById("div").style.display="none";
//alert(document.getElementById("div").style.display)
}
function show1(){
document.getElementById("div1").style.display="";
//alert(document.getElementById("div").style.display)
}
function hidden(){
document.getElementById("div1").style.display="none";
//alert(document.getElementById("div").style.display)
}
</script>
<script type="text/javascript">
    /*3D标签云*/
    tagcloud({
    	aglin:"top",
    	minwidth: "375",
   		 minheight: "160",
        selector: ".tagcloud",  //元素选择器
        fontsize: 16,       //基本字体大小, 单位px
        radius: 45,         //滚动半径, 单位px
        mspeed: "normal",   //滚动最大速度, 取值: slow, normal(默认), fast
        ispeed: "normal",   //滚动初速度, 取值: slow, normal(默认), fast
        direction:180,     //初始滚动方向, 取值角度(顺时针360): 0对应top, 90对应left, 135对应right-bottom(默认)...
        keep: false          //鼠标移出组件后是否继续随鼠标滚动, 取值: false, true(默认) 对应 减速至初速度滚动, 随鼠标滚动
    });
</script>
<script type="text/javascript">
//代办、已办、办结、消息事项鼠标经过金额放大
function dbsxStart(){
	$("#dbsxId").css("width","100%");
}
function dbsxOver(){
	$("#dbsxId").css("width","50%");
}

function ybsxStart(){
	$("#ybsxId").css("width","100%");
}
function ybsxOver(){
	$("#ybsxId").css("width","50%");
}

function bjsxStart(){
	$("#bjsxId").css("width","100%");
}
function bjsxOver(){
	$("#bjsxId").css("width","50%");
}

function xxtxStart(){
	$("#xxtxId").css("width","100%");
}
function xxtxOver(){
	$("#xxtxId").css("width","50%");
}
//时间格式化
function zcsjFormat(val) {
	//alert(val)
    var t, y, m, d, h, i, s;
    if(val==null){
  	  return "未填写";
    }
    t = new Date(val)
    y = t.getFullYear();
    m = t.getMonth() + 1;
    d = t.getDate();
    h = t.getHours();
    i = t.getMinutes();
    s = t.getSeconds();
    // 可根据需要在这里定义时间格式  
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) ;
}

</script>
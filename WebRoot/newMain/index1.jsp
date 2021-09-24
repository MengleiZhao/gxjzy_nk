﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!-- 页面跑马灯 -->
<script type="text/javascript" src="${base}/resource-now/js/scroll.js"></script>
<style>
.box-a,.box-b{width:292px;height:110px;background:rgba(255,255,255,1);margin-left: 7px;border:2px solid rgba(219,222,229,1);border-radius:4px;float: left}
.box-a{border: 1px solid #DBDEE5;margin-top: 7px;}
.box-a:hover{

            -webkit-box-shadow: #ccc 0px 5px 5px;

            -moz-box-shadow: #ccc 0px 5px 5px;

            box-shadow: #ccc 0px 5px 5px;  }
.box-b{border: 1px solid #DBDEE5;margin-top: 6px;}
.box-b:hover{

            -webkit-box-shadow: #ccc 0px 5px 5px;

            -moz-box-shadow: #ccc 0px 5px 5px;

            box-shadow: #ccc 0px 5px 5px;  }
.box-c{width:717px;
		height:221px;
		background:rgba(255,255,255,1);
		border:1px solid rgba(219,222,229,1);
		border-radius:4px;
		margin-left: 7px;
		float: left;
		margin-top: 7px;
		}
.box-d{width:471px;
		height:221px;
		background:rgba(255,255,255,1);
		border:1px solid rgba(219,222,229,1);
		border-radius:4px;
		float: left;
		margin-left: 7px;
		margin-top: 7px;
		}
</style>
<style>
.box-a1{width:4px;
		height:110px;
		background:rgba(253,202,104,1);
		opacity:0.9;
		border-radius:4px 4px 4px 4px;
		float: left;
}
.box-a2{width:4px;
		height:110px;
		background:rgba(94,215,163,1);
		opacity:0.9;
		border-radius:4px 4px 4px 4px;
		float: left;
}
.box-a3{width:4px;
		height:110px;
		background:rgba(0,126,255,1);
		opacity:0.9;
		border-radius:4px 4px 4px 4px;
		float: left;
}
.box-a4{width:4px;
		height:110px;
		background:rgba(250,71,61,1);
		opacity:0.9;
		border-radius:4px 4px 4px 4px;
		float: left;
}
.tonggao{width:476px;
				height:185px;
				background:rgba(255,255,255,0.99);
				border:1px solid rgba(219,222,229,1);
				border-radius:4px;
				margin-left: 7px;	
				margin-top: 7px;
}
.zhidu{width:476px;
				height:185px;
				background:rgba(255,255,255,0.99);
				border:1px solid rgba(219,222,229,1);
				border-radius:4px;
				margin-left: 7px;
				margin-top: 7px;
}
.jixiao{width:227px;
		height:184px;
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
.div2:hover { font-size: 36px; }
.div3 { font-size: 18px; }
.div3:hover { font-size: 20px; }
.div4 { font-size:36px;}
.div4:hover { font-size: 40px; }

.link a{display:block;padding:10px 10px 30px 0px;}
.link a:hover{background:#newcolor;}
</style>
<style>
.box{ width:210px;}
.bcon{ width:210px; border:1px solid #fff;}

.list_lh{ height:207px; overflow:hidden;}
.list_lh li{width: 207px;height: 64px;}
.list_lh li p{ height:64px;width:207px;}
.list_lh li p a{ display:block;height:64px;width:207px;margin-left: 10px;margin-top: 9px;}
.list_li{border:1px solid rgba(219,222,229,1);border-radius:4px;
}
.list_li:hover{
			border:1px solid rgba(0, 126, 255, 1);
</style>
<div id="1111" class="easyui-layout" style="background-color: #f0f5f7;height: 100%; overflow: hidden;">
	
	<div  class="box-a" onmousemove="dbsxStart()" onmouseout="dbsxOver()" >
	<div class="box-a1" style="background: url('${base}/resource-modality/${themenurl}/index/daiban0.png');"></div>
		<a href="#" onclick="detailDb()" style="display:block; font-size:18px;font-family:MicrosoftYaHei;line-height:10px;width:289px;height:120px;position:absolute;color:#666666FF">
			<img src="${base}/resource-modality/${themenurl}/index/dbsx.png" style="vertical-align: top; position:absolute; left:32px; top:15px; "><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;待办事项
		<br>
		<br>
		<br>
		<br>
		<span id="dbsxId" onmousemove="dbsxStart()" onmouseout="dbsxOver()" class="div1" style="font-family:MicrosoftYaHei;margin-left: 215px;color: red;" id="symenu_dbsx">
			<c:if test="${empty taskNums[0]}">
                   0
			</c:if>
			${taskNums[0] }
		</span></a>
	</div>
	
	<div onmousemove="ybsxStart()" onmouseout="ybsxOver()"  class="box-b">
	<div class="box-a2" style="background: url('${base}/resource-modality/${themenurl}/index/yiban0.png');"></div>
	<a href="#"  onclick="detailYb()" style="display: inline-block;width:289px;height:120px;font-size:18px;font-family:MicrosoftYaHei;line-height:10px;position:absolute;color:#666666FF">
			<img src="${base}/resource-modality/${themenurl}/index/ybsx.png" style="position:absolute;left:32px; top:15px; "/><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;已办事项
		<br>
		<br>
		<br>
		<br>
		<span id="ybsxId"  onmousemove="ybsxStart()" onmouseout="ybsxOver()" class="div1" style="font-family:MicrosoftYaHei;margin-left: 215px;color: #FDCA68FF" id="symenu_ybsx">
			<c:if test="${empty countAlready[0]}">
				0
			</c:if>
			${countAlready[0]}
		</span>
		</a>
	</div>
	
	<div  onmousemove="bjsxStart()" onmouseout="bjsxOver()" class="box-b" >
	<div class="box-a3" style="background: url('${base}/resource-modality/${themenurl}/index/banjie0.png');"></div>
	<a href="#"  onclick="detailBj()" class="active" style="display: inline-block;width:289px;height:120px;font-size:18px;font-family:MicrosoftYaHei;line-height:10px;position:absolute;color:#666666FF">
			<img src="${base}/resource-modality/${themenurl}/index/bjsx.png" style="position:absolute; left:32px; top:15px; "/><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;办结事项
		<br>
		<br>
		<br>
		<br>
		<span id="bjsxId" onmousemove="bjsxStart()" onmouseout="bjsxOver()" class="div1"  style="font-family:MicrosoftYaHei;margin-left: 215px;color: #5ED7A3FF" id="symenu_bjsx">
			<c:if test="${empty countFinish[0]}">0</c:if>
			${countFinish[0] }
		</span>
		</a>
	</div>
	
	<div onmousemove="xxtxStart()" onmouseout="xxtxOver()" class="box-b" >
	<div class="box-a4" style="background: url('${base}/resource-modality/${themenurl}/index/xiaoxi0.png');"></div>
	<a href="#" id="" onclick="xiaoxi()" style="display: inline-block;width:289px;height:120px;font-size:18px;font-family:MicrosoftYaHei;line-height:10px;position:absolute;color:#666666FF">
			<img src="${base}/resource-modality/${themenurl}/index/xxtx.png" style="position:absolute; left:32px; top:15px; "/><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;消息
		<br>
		<br>
		<br>
		<br>
		<span id="xxtxId" onmousemove="xxtxStart()" onmouseout="xxtxOver()" class="div1"  style="font-family:MicrosoftYaHei;margin-left: 215px;color: #007EFFFF" id="symenu_xx">
			<c:if test="${empty countInfor}">0</c:if>
			${countInfor }
		</span>
		</a>
	</div>
	<div style="clear:both;"></div>
	<div class="box-c">
		<%-- <a href="#" onclick="tzggList()"style="position:absolute;left:700px;width:76px;top:138px;">
		<img src="${base}/resource-modality/${themenurl}/index/quanbu.png">
		</a> --%>
		<div id="tt" class="easyui-tabs" style="width:710px;height:215px;margin: 5px">
    		<div title="我的报销总额" style="padding:10px;display:none;overflow:hidden;">
    		<div style="width:65px;height:19px;border-radius:9px;float:right;color:#666666">&nbsp;单位：元</div>
				<table style="width:445px;">
					<thead>
                		<tr>
		                    <th>我的近期报销</th>
                		</tr>
            		</thead>
				</table>
				<table style="width:460px;height: 128px ;float: left;padding-top: 4px">
						<tr>
						<td style="width: 207px;height: 64px;">
<div class="box">
	<div class="bcon">
		<div class="list_lh">
			<ul>
				<li onmousemove="largen0()" onmouseout="recover0()" class="list_li" style="margin-bottom:5px" >
					<p>
						<c:if test="${empty bxze[0]}">暂无报销数据</c:if>
						<c:if test="${!empty bxze[0]}">
						<a href="#" style="font-size:12px;font-family:MicrosoftYaHei;font-weight:bold; color:#666666" onclick="queryDetail('${bxze.get(0).dName}','${bxze.get(0).id}')">
							<c:if test="${bxze.get(0).dName==0}">直接报销</c:if>
							<c:if test="${bxze.get(0).dName==1}">通用报销</c:if>
							<c:if test="${bxze.get(0).dName==2}">会议报销</c:if>
							<c:if test="${bxze.get(0).dName==3}">培训报销</c:if>
							<c:if test="${bxze.get(0).dName==4}">差旅报销</c:if>
							<c:if test="${bxze.get(0).dName==5}">接待报销</c:if>
							<br><span id="apply0" class="div3" onmousemove="largen0()" onmouseout="recover0()" style="float: left;display:block;width:115px;height:20px ;padding-top:10px;font-family:MicrosoftYaHei;font-weight:bold;color:#666666;">¥${bxze.get(0).fAmount}</span>
							<span style="padding-top:15px;display:block;font-weight:400;width:80px;height:20px ;font-size:12px;font-family:MicrosoftYaHei;color:#999999;float: right;margin-right: 10px">${bxze.get(0).fReqTime.toString().substring(0,10)}</span>
						</a>
						</c:if>
					</p>
				</li>
				<li onmousemove="largen2()" onmouseout="recover2()" class="list_li" style="margin-bottom:5px" >
					<p>
					<c:if test="${empty bxze[2]}">暂无报销数据</c:if>
						<c:if test="${!empty bxze[2]}">
						<a href="#" style="font-size:12px;font-family:MicrosoftYaHei;font-weight:bold; color:#666666" onclick="queryDetail('${bxze.get(2).dName}','${bxze.get(2).id}')">
							<c:if test="${bxze.get(0).dName==0}">直接报销</c:if>
							<c:if test="${bxze.get(0).dName==1}">通用报销</c:if>
							<c:if test="${bxze.get(0).dName==2}">会议报销</c:if>
							<c:if test="${bxze.get(0).dName==3}">培训报销</c:if>
							<c:if test="${bxze.get(0).dName==4}">差旅报销</c:if>
							<c:if test="${bxze.get(0).dName==5}">接待报销</c:if>
							<br><span id="apply2" class="div3" onmousemove="largen2()" onmouseout="recover2()" style="float: left;display:block;width:115px;height:20px ;padding-top:10px;font-family:MicrosoftYaHei;font-weight:bold;color:#666666;">¥${bxze.get(2).fAmount}</span>
							<span style="padding-top:15px;display:block;width:80px;font-weight:400;height:20px ;font-size:12px;font-family:MicrosoftYaHei;color:#999999;float: right;margin-right: 10px">${bxze.get(2).fReqTime.toString().substring(0,10)}</span>
						</a>
						</c:if>
					</p>
				</li>
				<li onmousemove="largen4()" onmouseout="recover4()" class="list_li" style="margin-bottom:5px" >
					<p>
					<c:if test="${empty bxze[4]}">暂无报销数据</c:if>
						<c:if test="${!empty bxze[4]}">
						<a href="#" style="font-size:12px;font-family:MicrosoftYaHei;font-weight:bold; color:#666666" onclick="queryDetail('${bxze.get(4).dName}','${bxze.get(4).id}')">
							<c:if test="${bxze.get(0).dName==0}">直接报销</c:if>
							<c:if test="${bxze.get(0).dName==1}">通用报销</c:if>
							<c:if test="${bxze.get(0).dName==2}">会议报销</c:if>
							<c:if test="${bxze.get(0).dName==3}">培训报销</c:if>
							<c:if test="${bxze.get(0).dName==4}">差旅报销</c:if>
							<c:if test="${bxze.get(0).dName==5}">接待报销</c:if>
							<br><span id="apply4" class="div3" onmousemove="largen4()" onmouseout="recover4()"style="float: left;display:block;width:115px;height:20px ;padding-top:10px;font-family:MicrosoftYaHei;font-weight:bold;color:#666666;">¥${bxze.get(4).fAmount}</span>
							<span style="padding-top:15px;display:block;width:80px;font-weight:400;height:20px ;font-size:12px;font-family:MicrosoftYaHei;color:#999999;float: right;margin-right: 10px">${bxze.get(4).fReqTime.toString().substring(0,10)}</span>
						</a>
						</c:if>
					</p>
				</li>
				<li onmousemove="largen6()" onmouseout="recover6()"  class="list_li" style="margin-bottom:5px" >
					<p>
					<c:if test="${empty bxze[6]}">暂无报销数据</c:if>
						<c:if test="${!empty bxze[6]}">
						<a href="#" style="font-size:12px;font-family:MicrosoftYaHei;font-weight:bold; color:#666666" onclick="queryDetail('${bxze.get(6).dName}','${bxze.get(6).id}')">
							<c:if test="${bxze.get(0).dName==0}">直接报销</c:if>
							<c:if test="${bxze.get(0).dName==1}">通用报销</c:if>
							<c:if test="${bxze.get(0).dName==2}">会议报销</c:if>
							<c:if test="${bxze.get(0).dName==3}">培训报销</c:if>
							<c:if test="${bxze.get(0).dName==4}">差旅报销</c:if>
							<c:if test="${bxze.get(0).dName==5}">接待报销</c:if>
							<br><span id="apply6" class="div3" onmousemove="largen6()" onmouseout="recover6()" style="float: left;display:block;width:115px;height:20px ;padding-top:10px;font-family:MicrosoftYaHei;font-weight:bold;color:#666666;">¥${bxze.get(6).fAmount}</span>
							<span style="padding-top:15px;display:block;width:80px;font-weight:400;height:20px ;font-size:12px;font-family:MicrosoftYaHei;color:#999999;float: right;margin-right: 10px">${bxze.get(6).fReqTime.toString().substring(0,10)}</span>
						</a>
						</c:if>
					</p>
				</li>
			</ul>
			
		</div>
	</div>	
</div>
</td>
<td>
		<div class="box">
	<div class="bcon">
		<div class="list_lh">
			<ul>
				<li onmousemove="largen1()" onmouseout="recover1()" class="list_li" style="margin-bottom:5px" >
					<p>
					<c:if test="${empty bxze[1]}">暂无报销数据</c:if>
						<c:if test="${!empty bxze[1]}">
						<a href="#" style="font-size:12px;font-family:MicrosoftYaHei;font-weight:bold; color:#666666" onclick="queryDetail('${bxze.get(1).dName}','${bxze.get(1).id}')">
							<c:if test="${bxze.get(0).dName==0}">直接报销</c:if>
							<c:if test="${bxze.get(0).dName==1}">通用报销</c:if>
							<c:if test="${bxze.get(0).dName==2}">会议报销</c:if>
							<c:if test="${bxze.get(0).dName==3}">培训报销</c:if>
							<c:if test="${bxze.get(0).dName==4}">差旅报销</c:if>
							<c:if test="${bxze.get(0).dName==5}">接待报销</c:if>
							<br><span id="apply1" class="div3" onmousemove="largen1()" onmouseout="recover1()" style="float: left;display:block;width:115px;height:20px ;padding-top:10px;font-family:MicrosoftYaHei;font-weight:bold;color:#666666;">¥${bxze.get(1).fAmount}</span>
							<span style="padding-top:15px;display:block;width:80px;font-weight:400;height:20px ;font-size:12px;font-family:MicrosoftYaHei;color:#999999;float: right;margin-right: 10px">${bxze.get(1).fReqTime.toString().substring(0,10)}</span>
						</a>
						</c:if>
					</p>
				</li>
				<li  onmousemove="largen3()" onmouseout="recover3()" class="list_li" style="margin-bottom:5px" >
					<p>
					<c:if test="${empty bxze[3]}">暂无报销数据</c:if>
						<c:if test="${!empty bxze[3]}">
						<a href="#" style="font-size:12px;font-family:MicrosoftYaHei;font-weight:bold; color:#666666" onclick="queryDetail('${bxze.get(3).dName}','${bxze.get(3).id}')">
							<c:if test="${bxze.get(0).dName==0}">直接报销</c:if>
							<c:if test="${bxze.get(0).dName==1}">通用报销</c:if>
							<c:if test="${bxze.get(0).dName==2}">会议报销</c:if>
							<c:if test="${bxze.get(0).dName==3}">培训报销</c:if>
							<c:if test="${bxze.get(0).dName==4}">差旅报销</c:if>
							<c:if test="${bxze.get(0).dName==5}">接待报销</c:if>
							<br><span id="apply3" class="div3" onmousemove="largen3()" onmouseout="recover3()"  style="float: left;display:block;width:115px;height:20px ;padding-top:10px;font-family:MicrosoftYaHei;font-weight:bold;color:#666666;">¥${bxze.get(3).fAmount}</span>
							<span style="padding-top:15px;display:block;width:80px;font-weight:400;height:20px ;font-size:12px;font-family:MicrosoftYaHei;color:#999999;float: right;margin-right: 10px">${bxze.get(3).fReqTime.toString().substring(0,10)}</span>
						</a>
						</c:if>
					</p>
				</li>
				<li onmousemove="largen5()" onmouseout="recover5()" class="list_li" style="margin-bottom:5px" >
					<p>
					<c:if test="${empty bxze[5]}">暂无报销数据</c:if>
						<c:if test="${!empty bxze[5]}">
						<a href="#" style="font-size:12px;font-family:MicrosoftYaHei;font-weight:bold; color:#666666" onclick="queryDetail('${bxze.get(5).dName}','${bxze.get(5).id}')">
							<c:if test="${bxze.get(0).dName==0}">直接报销</c:if>
							<c:if test="${bxze.get(0).dName==1}">通用报销</c:if>
							<c:if test="${bxze.get(0).dName==2}">会议报销</c:if>
							<c:if test="${bxze.get(0).dName==3}">培训报销</c:if>
							<c:if test="${bxze.get(0).dName==4}">差旅报销</c:if>
							<c:if test="${bxze.get(0).dName==5}">接待报销</c:if>
							<br><span id="apply5" class="div3" onmousemove="largen5()" onmouseout="recover5()" style="float: left;display:block;width:115px;height:20px ;padding-top:10px;font-family:MicrosoftYaHei;font-weight:bold;color:#666666;">¥${bxze.get(5).fAmount}</span>
							<span style="padding-top:15px;display:block;width:80px;font-weight:400;height:20px ;font-size:12px;font-family:MicrosoftYaHei;color:#999999;float: right;margin-right: 10px">${bxze.get(5).fReqTime.toString().substring(0,10)}</span>
						</a>
						</c:if>
					</p>
				</li>
				<li onmousemove="largen7()" onmouseout="recover7()"  class="list_li" style="margin-bottom:5px" >
					<p>
						<c:if test="${empty bxze[7]}">暂无报销数据</c:if>
						<c:if test="${!empty bxze[7]}">
						<a href="#" style="font-size:12px;font-family:MicrosoftYaHei;font-weight:bold; color:#666666" onclick="queryDetail('${bxze.get(7).dName}','${bxze.get(7).id}')">
							<c:if test="${bxze.get(0).dName==0}">直接报销</c:if>
							<c:if test="${bxze.get(0).dName==1}">通用报销</c:if>
							<c:if test="${bxze.get(0).dName==2}">会议报销</c:if>
							<c:if test="${bxze.get(0).dName==3}">培训报销</c:if>
							<c:if test="${bxze.get(0).dName==4}">差旅报销</c:if>
							<c:if test="${bxze.get(0).dName==5}">接待报销</c:if>
							<br><span id="apply7" class="div3" onmousemove="largen7()" onmouseout="recover7()" style="float: left;display:block;width:115px;height:20px ;padding-top:10px;font-family:MicrosoftYaHei;font-weight:bold;color:#666666;">¥${bxze.get(7).fAmount}</span>
							<span style="padding-top:15px;display:block;width:80px;font-weight:400;height:20px ;font-size:12px;font-family:MicrosoftYaHei;color:#999999;float: right;margin-right: 10px">${bxze.get(7).fReqTime.toString().substring(0,10)}</span>
						</a>
						</c:if>
					</p>
				</li>
			</ul>
			
		</div>
	</div>	
</div>		
</td>			
									<%-- <marquee dir="auto" offsetParent="216px" onmouseover=this.stop() onmouseout=this.start() scrolldelay=10 width="216px" height="56px" direction="up" scrollamount="1">
								<c:forEach var="bxze" items="${bxze}" begin="0" end="3" >
								<td  class="box-b1" onclick="queryDetail('${bxze.dName}','${bxze.id}')">
									<div style="width:166px;height:12px;font-size:12px;padding-top: 6px;font-family:MicrosoftYaHei;font-weight:bold;color:#666666;">
										<c:if test="${bxze.dName==0}">&nbsp;&nbsp;&nbsp;直接报销</c:if>
										<c:if test="${bxze.dName==1}">&nbsp;&nbsp;&nbsp;通用报销</c:if>
										<c:if test="${bxze.dName==2}">&nbsp;&nbsp;&nbsp;会议报销</c:if>
										<c:if test="${bxze.dName==3}">&nbsp;&nbsp;&nbsp;培训报销</c:if>
										<c:if test="${bxze.dName==4}">&nbsp;&nbsp;&nbsp;差旅报销</c:if>
										<c:if test="${bxze.dName==5}">&nbsp;&nbsp;&nbsp;接待报销</c:if>
									</div>
									<br>
									<div align="left" style="float:left;width:110px;height:17px;"><a href="#"class="div3" style="color:#666666;font-family:MicrosoftYaHei;font-weight:bold;">&nbsp;&nbsp;<span>¥</span>${bxze.fAmount}</a>
									</div>
									<div align="right"  style="margin-top:2px; float:left; width:90px;height:17px;font-size:12px;font-family:MicrosoftYaHei;color:#999999">${bxze.fReqTime.toString().substring(0,10)}</div>
								</td>
								</c:forEach>
								</marquee> --%>
						</tr>
					</table>
					<table style="width:220px;height:145px;float: right;">
						<tr style="width:51px;height:15px;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:rgba(153,153,153,1);">
								<br><td align="right">报销总金额</td>
						</tr>
						<tr style="width:220px;height:33px;font-size:36px;font-family:MicrosoftYaHei;font-weight:400;color:rgba(137,196,240,1);">
								<td align="right" style="height:36px;" ><a  onclick="detailApplyForReimbursement()" style="font-family:MicrosoftYaHei;font-weight:bold;color:rgba(94,215,163,1)" href="#" class="div2" ><span>¥</span>${count.get(0).sumAmount}</a></td>
						</tr>
						<tr style="width:220px;height:13px;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:rgba(153,153,153,1);">
								<td style="width:220px;height:13px;padding-bottom:30px;" align="right"><a style="font-family:MicrosoftYaHei;font-weight:400;color:rgba(153,153,153,1);" onclick="detailApplyForReimbursement()" href="#">累计报销&nbsp;${count.get(0).countId}&nbsp;笔数</a></td>
						</tr>
					</table>
    		</div>
		    <div title="我的借款" style="overflow:hidden;padding:10px;display:none;overflow:hidden;">
				<div style="width:65px;height:19px;border-radius:9px;float:right;color:#666666">&nbsp;单位：元</div>
				<table style="width:460px;">
					<thead>
                		<tr>
		                    <th>我的近期借款</th>
                		</tr>
            		</thead>
				</table>
				<table style="width:460px;height: 128px ;float: left;padding-top: 4px">
						<tr>
							<td style="width: 207px;height: 64px;">
								<div class="box">
	<div class="bcon">
		<div class="list_lh">
			<ul>
				<li onmousemove="loanStart0()" onmouseout="loanOver0()" class="list_li" style="margin-bottom:5px" >
					<p>
					<c:if test="${empty basicInfos[0]}">暂无借款数据</c:if>
						<c:if test="${!empty basicInfos[0]}">
						<a href="#" style="font-size:12px;font-family:MicrosoftYaHei;font-weight:bold; color:#666666" onclick="queryBorrow('${basicInfos.get(0).lId}')">
							${basicInfos.get(0).loanPurpose}
							<br><span id="loan0" onmousemove="loanStart0()" onmouseout="loanOver0()" class="div3" style="float: left;display:block;width:115px;height:20px ;padding-top:10px;font-family:MicrosoftYaHei;font-weight:bold;color:#666666;">¥${basicInfos.get(0).lAmount}</span>
							<span style="padding-top:15px;display:block;width:80px;height:20px ;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:#999999;float: right;margin-right: 10px">${basicInfos.get(0).reqTime.toString().substring(0,10)}</span>
						</a>
						</c:if>
					</p>
				</li>
				<li  onmousemove="loanStart2()" onmouseout="loanOver2()"  class="list_li" style="margin-bottom:5px" >
					<p>
						<c:if test="${empty basicInfos[2]}">暂无借款数据</c:if>
						<c:if test="${!empty basicInfos[2]}">
						<a href="#" style="font-size:12px;font-family:MicrosoftYaHei;font-weight:bold; color:#666666" onclick="queryBorrow('${basicInfos.get(2).lId}')">
							${basicInfos.get(2).loanPurpose}
							<br><span id="loan2" onmousemove="loanStart2()" onmouseout="loanOver2()" class="div3" style="float: left;display:block;width:115px;height:20px ;padding-top:10px;font-family:MicrosoftYaHei;font-weight:bold;color:#666666;">¥${basicInfos.get(2).lAmount}</span>
							<span style="padding-top:15px;display:block;width:80px;height:20px ;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:#999999;float: right;margin-right: 10px">${basicInfos.get(2).reqTime.toString().substring(0,10)}</span>
						</a>
						</c:if>
					</p>
				</li>
				<li onmousemove="loanStart4()" onmouseout="loanOver4()"  class="list_li" style="margin-bottom:5px" >
					<p>
						<c:if test="${empty basicInfos[4]}">暂无借款数据</c:if>
						<c:if test="${!empty basicInfos[4]}">
						<a href="#" style="font-size:12px;font-family:MicrosoftYaHei;font-weight:bold; color:#666666" onclick="queryBorrow('${basicInfos.get(4).lId}')">
							${basicInfos.get(4).loanPurpose}
							<br><span id="loan4" onmousemove="loanStart4()" onmouseout="loanOver4()"  class="div3" style="float: left;display:block;width:115px;height:20px ;padding-top:10px;font-family:MicrosoftYaHei;font-weight:bold;color:#666666;">¥${basicInfos.get(4).lAmount}</span>
							<span style="padding-top:15px;display:block;width:80px;height:20px ;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:#999999;float: right;margin-right: 10px">${basicInfos.get(4).reqTime.toString().substring(0,10)}</span>
						</a>
						</c:if>
					</p>
				</li>
				<li onmousemove="loanStart6()" onmouseout="loanOver6()"  class="list_li" style="margin-bottom:5px" >
					<p>
					<c:if test="${empty basicInfos[6]}">暂无借款数据</c:if>
						<c:if test="${!empty basicInfos[6]}">
						<a href="#" style="font-size:12px;font-family:MicrosoftYaHei;font-weight:bold; color:#666666" onclick="queryBorrow('${basicInfos.get(6).lId}')">
							${basicInfos.get(6).loanPurpose}
							<br><span id="loan6" onmousemove="loanStart6()" onmouseout="loanOver6()"  class="div3" style="float: left;display:block;width:115px;height:20px ;padding-top:10px;font-size:18px;font-family:MicrosoftYaHei;font-weight:bold;color:#666666;">¥${basicInfos.get(6).lAmount}</span>
							<span style="padding-top:15px;display:block;width:80px;height:20px ;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:#999999;float: right;margin-right: 10px">${basicInfos.get(6).reqTime.toString().substring(0,10)}</span>
						</a>
						</c:if>
					</p>
				</li>
			</ul>
		</div>
	</div>	
</div>
</td>
<td>
								<div class="box">
	<div class="bcon">
		<div class="list_lh">
			<ul>
				<li onmousemove="loanStart1()" onmouseout="loanOver1()"  class="list_li" style="margin-bottom:5px" >
					<p>
						<c:if test="${empty basicInfos[1]}">暂无借款数据</c:if>
						<c:if test="${!empty basicInfos[1]}">
						<a href="#" style="font-size:12px;font-family:MicrosoftYaHei;font-weight:bold; color:#666666" onclick="queryBorrow('${basicInfos.get(1).lId}')">
							${basicInfos.get(1).loanPurpose}
							<br><span id="loan1" onmousemove="loanStart1()" onmouseout="loanOver1()"  class="div3" style="float: left;display:block;width:115px;height:20px ;padding-top:10px;font-size:18px;font-family:MicrosoftYaHei;font-weight:bold;color:#666666;">¥${basicInfos.get(1).lAmount}</span>
							<span style="padding-top:15px;display:block;width:80px;height:20px ;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:#999999;float: right;margin-right: 10px">${basicInfos.get(1).reqTime.toString().substring(0,10)}</span>
						</a>
						</c:if>
					</p>
				</li>
				<li onmousemove="loanStart3()" onmouseout="loanOver3()"  class="list_li" style="margin-bottom:5px" >
					<p>
						<c:if test="${empty basicInfos[3]}">暂无借款数据</c:if>
						<c:if test="${!empty basicInfos[3]}">
						<a href="#" style="font-size:12px;font-family:MicrosoftYaHei;font-weight:bold; color:#666666" onclick="queryBorrow('${basicInfos.get(3).lId}')">
							${basicInfos.get(3).loanPurpose}
							<br><span id="loan3" onmousemove="loanStart3()" onmouseout="loanOver3()"  class="div3" style="float: left;display:block;width:115px;height:20px ;padding-top:10px;font-size:18px;font-family:MicrosoftYaHei;font-weight:bold;color:#666666;">¥${basicInfos.get(3).lAmount}</span>
							<span style="padding-top:15px;display:block;width:80px;height:20px ;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:#999999;float: right;margin-right: 10px">${basicInfos.get(3).reqTime.toString().substring(0,10)}</span>
						</a>
						</c:if>
					</p>
				</li>
				<li onmousemove="loanStart5()" onmouseout="loanOver5()"  class="list_li" style="margin-bottom:5px" >
					<p>
						<c:if test="${empty basicInfos[5]}">暂无借款数据</c:if>
						<c:if test="${!empty basicInfos[5]}">
						<a href="#" style="font-size:12px;font-family:MicrosoftYaHei;font-weight:bold; color:#666666" onclick="queryBorrow('${basicInfos.get(5).lId}')">
							${basicInfos.get(5).loanPurpose}
							<br><span id="loan5" onmousemove="loanStart5()" onmouseout="loanOver5()"  class="div3" style="float: left;display:block;width:115px;height:20px ;padding-top:10px;font-size:18px;font-family:MicrosoftYaHei;font-weight:bold;color:#666666;">¥${basicInfos.get(5).lAmount}</span>
							<span style="padding-top:15px;display:block;width:80px;height:20px ;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:#999999;float: right;margin-right: 10px">${basicInfos.get(5).reqTime.toString().substring(0,10)}</span>
						</a>
						</c:if>
					</p>
				</li>
				<li onmousemove="loanStart7()" onmouseout="loanOver7()"  class="list_li" style="margin-bottom:5px" >
					<p>
						<c:if test="${empty basicInfos[7]}">暂无借款数据</c:if>
						<c:if test="${!empty basicInfos[7]}">
						<a href="#" style="font-size:12px;font-family:MicrosoftYaHei;font-weight:bold; color:#666666" onclick="queryBorrow('${basicInfos.get(7).lId}')">
							${basicInfos.get(7).loanPurpose}
							<br><span id="loan7" onmousemove="loanStart7()" onmouseout="loanOver7()"  class="div3" style="float: left;display:block;width:115px;height:20px ;padding-top:10px;font-size:18px;font-family:MicrosoftYaHei;font-weight:bold;color:#666666;">¥${basicInfos.get(7).lAmount}</span>
							<span style="padding-top:15px;display:block;width:80px;height:20px ;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:#999999;float: right;margin-right: 10px">${basicInfos.get(7).reqTime.toString().substring(0,10)}</span>
						</a>
						</c:if>
					</p>
				</li>
			</ul>
		</div>
	</div>	
</div>
</td>
						
						
								<%-- <c:forEach var="basicInfos" items="${basicInfos}" begin="0" end="3">
								<td id="apply" style="cursor: pointer;" class="box-b1" onclick="queryBorrow('${basicInfos.lId}')">
									<div style="width:166px;height:12px;font-size:12px;padding-top: 6px;font-family:MicrosoftYaHei;font-weight:bold;color:#666666;">
									&nbsp;&nbsp;&nbsp;${basicInfos.loanPurpose}
									</div>
									<br>
									<div align="left" style="float:left;width:110px;height:17px;">&nbsp;<a href="#"class="div3" style="color:#666666;font-family:MicrosoftYaHei;font-weight:bold;"><span>¥</span>${basicInfos.lAmount}</a></div>
									<div align="right"  style="margin-top:2px; float:left; width:90px;height:17px;font-size:12px;font-family:MicrosoftYaHei;font-weight:bold;color:#999999">${basicInfos.reqTime.toString().substring(0,10)}</div>
								</td>
								</c:forEach> --%>
						</tr>
					</table>
					<table style="width:220px;height:145px;float: right;">
						<tr style="width:51px;height:13px;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:rgba(153,153,153,1);">
								<br><td align="right">借款总额</td>
						</tr>
						<tr style="width:220px;height:33px;font-size:36px;font-family:MicrosoftYaHei;font-weight:400;color:rgba(137,196,240,1);">
								<td style="width:220px;height:33px;" align="right"><a  href="#" onclick="detailBorrowMoney()" style="font-family:MicrosoftYaHei;font-weight:bold;color:rgba(94,215,163,1)" class="div2"><span>¥</span>${amountOfBorrowings.get(0).sumLAmount}</a></td>
						</tr>
						<tr style="width:220px;height:13px;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:rgba(153,153,153,1);">
								<td style="width:220px;height:13px;padding-bottom: 30px" align="right"><a  href="#" onclick="detailBorrowMoney()" style="font-family:MicrosoftYaHei;color:rgba(153,153,153,1);">累计借款&nbsp;${amountOfBorrowings.get(0).countLId}&nbsp;笔数</a></td>
						</tr>
					</table>
		    </div>
		</div>
		</div>
	
		<div class="box-d">
			<%-- <a href="#" onclick="tzggList11()" style="position:absolute;left:1130px;width:76px;top:138px;">
				<img src="${base}/resource-modality/${themenurl}/index/quanbu.png">
			</a> --%>
			<img style="position:absolute;left:750px;top:140px;" src="${base}/resource-modality/${themenurl}/index/biaotitiao.png">
			<h4 style="position:absolute;left:740px;top:136px;padding-left:20px;font-size: 12px;color: #666666;">我的资产</h4>
			<hr style="margin-top: 38px;border-top: 1px solid #eee;border-bottom: 1px solid #fff;">
			<table id="tt" style="width: 475px;height: 190px; display: block;">
				<tr style="width: 65px;height: 190px;float:left;display: block;">
					<td style="width: 65px;height: 190px;display: block;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:rgba(102,102,102,1);margin-top:4px;">
						&nbsp;&nbsp;&nbsp;我的资产<br><br>&nbsp;&nbsp;&nbsp;共计
							<a class="div4" href="#" onclick="queryFixedAssets()" style="margin-top:14px; float:left;font-family:MicrosoftYaHei;font-weight:400;color:rgba(0,126,255,1);" >
								&nbsp;${assetsNumber.get(0).tarlNmaeNumber}
							</a>
					</td>
				</tr>
				<tr style="width:400px; height: 170px;float: left">
						<td class="tagcloud fl" style="width: 400px;height: 150px;min-width:400px;min-height: 150px;">
							<c:forEach var="assets" items="${assets}">
								<a href="#" onclick="ledger_fixed_detail('0','${assets.tarlCode}')">${assets.tarlNmae}</a>
						</c:forEach>
						</td>
				</tr>
				
			
			</table>
			<%-- <div id="tt" class="easyui-tabs" style="width:471px;height:221px;">
				<div title="我的资产" style="overflow:hidden;padding:20px;display:none;">
					<div class="tagcloud fl" style="margin: 1px 0px 0px 0px;min-width:430px;min-height: 200px;">
						<c:forEach var="assets" items="${assets}">
								<a href="#" onclick="ledger_fixed_detail('0','${assets.tarlCode}')">${assets.tarlNmae}</a>
						</c:forEach>
   					</div>
					
		    	</div>
			</div> --%>
		</div>
		
	<div style="margin: 0px 0px 0px 0px">
		<div id="tzgg" class="tonggao" style="float: left;">
		<img style="position:absolute;left:25px;top:368px;" src="${base}/resource-modality/${themenurl}/index/biaotitiao.png">
			<h4 style="position:absolute;left:14px;top:349px;padding-left:20px;font-size: 12px;color: #666666;">
			<br>
			通知公告
			</h4>
			<hr style="margin-top: 35px;border-top: 1px solid #eee;border-bottom: 1px solid #fff;">
			<table style="width:476px" cellpadding="0" cellspacing="0">
				<tr style="width: 400px;">
					<td align="right" style="position:absolute;padding-right: 20px;left:385px;width:76px;top:368px;">
						<a href="#" onclick="tzggList()">
							<img id="quanbu0" src="${base}/resource-modality/${themenurl}/index/huisequanbu.png" onmousemove="quanbulan0()" onmouseout="quanbuhui0()" >
						</a>
					</td>
				</tr>
				<br>
				<c:forEach items="${notice}" var="ni">
					<tr style="width: 476px ;height: 30px">
						<td style="padding-left:20px;width:350px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap"><a href="#" onclick="openNotice(${ni.noticeId})" style="color: #666666" >${ni.noticeTitle}</a></td>
						<td style="width:50px"><img src="${base}/resource-modality/${themenurl}/index/new.png"></td>
						<td align="left" style="width:76px">${ni.releaseTime.toString().substring(0,10)}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div id="zdzx" class="zhidu" style="float: left;">
		<img style="position:absolute;left:509px;top:368px;"src="${base}/resource-modality/${themenurl}/index/biaotitiao.png">
			<h4 style="position:absolute;left:500px;top:348px;padding-left:20px;font-size: 12px;color: #666666;">
			<br>
			制度中心</h4>
			<hr style="margin-top: 35px;border-top: 1px solid #eee;border-bottom: 1px solid #fff;">
			<table style="width: 476px;" cellpadding="0" cellspacing="0">
						<a style=" position:absolute; left:900px; top:367px; " href="#" onclick="zdzxList()">
							<img id="quanbu1" src="${base}/resource-modality/${themenurl}/index/huisequanbu.png" onmousemove="quanbulan1()" onmouseout="quanbuhui1()" >
						</a>
						<br>
				<c:forEach items="${cheter}" var="ci">
					<tr style="width: 476px;height: 30px;">
						<td style="padding-left:20px;width:350px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap"><a href="#" onclick="openCheter(${ci.systemId})" style="color: #666666">${ci.fileName}</a></td>
						<td style="width:50px"><img src="${base}/resource-modality/${themenurl}/index/new.png"></td>
						<td align="left" style="width:76px">${ci.releseTime.toString().substring(0,10)}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="jixiao" style="float: left;">
		<img style="position:absolute;left:994px;top:368px;" src="${base}/resource-modality/${themenurl}/index/biaotitiao.png">
		<table style="width:227px;height:146px;">
		
			<h4 style="position:absolute;left:983px;top:348px;padding-left:20px;font-size: 12px;color: #666666;width: 160px;white-space:nowrap" colspan="2">
			<br>
			上月综合绩效</h4>
			<hr style="margin-top: 35px;border-top: 1px solid #eee;border-bottom: 1px solid #fff;opacity:0.9;">
				<tr  style="width: 227px;height: 146px">
					<td align="center" style="width: 227px;height: 146px">
					
					<div align="center" style="width:200px;height:25px;background:rgba(244,248,250,1);border-radius:4px;">
						<a href="#" style="display:block; width:200px;height:25px;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:#999999;text-align: center; line-height: 25px;">优秀</a>
					</div>
					<div align="center" style="margin-top:4px;width:200px;height:46px;background:rgba(244,248,250,1);border:1px solid rgba(219,222,229,1);border-radius:4px;">
						<a href="#" style="display:block;width:200px;height:46px;font-size:18px;font-family:MicrosoftYaHei;font-weight:400;color:rgba(94,215,163,1);">良好<br>
							<span style="width:149px;height:13px;font-size:8px;font-family:MicrosoftYaHei;font-weight:400;color:rgba(153,153,153,1);">您的绩效很棒，继续加油哦！</span>
						</a>
					</div>
					<div align="center" style="margin-top:4px;width:200px;height:25px;background:rgba(244,248,250,1);border-radius:4px;">
						<a href="#" style="display:block;width:200px;height:25px;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:#999999;text-align: center; line-height: 25px;">一般</a>
					</div>
					<div align="center" style="margin-top:4px;width:200px;height:25px;background:rgba(244,248,250,1);border-radius:4px;">
						<a href="#" style="display:block;width:200px;height:25px;font-size:12px;font-family:MicrosoftYaHei;font-weight:400;color:#999999;text-align: center; line-height: 25px;">待改进</a>
					</div>
					</td>
				</tr>
			</table>
			<input hidden="hidden"  value="${themenurl}" id="themenurlId">
		</div>
	</div>
</div>

<script type="text/javascript">
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
			var win = creatWin('查看', 970,590, 'icon-search',"/Rece/detail1/"+id+"?tarlCode="+tarlCode+"");
			win.window('open');
	}
//查看报销明细
function queryDetail(dName,id){
	//直接报销
	if(dName==0){
		var win = parent.creatWin(' ', 970,580, 'icon-search', "/directlyReimburse/edit1?id="+id+"&editType="+dName);
	}else{
		//申请报销1
		win = parent.creatWin(' ', 970, 580, 'icon-search', "/reimburse/edit1?id="+id+"&editType=0");
	}
	win.window('open');
}
//查看借款明细
function queryBorrow(id){
	var win = parent.creatWin(' ', 970,580, 'icon-search', "/loan/edit?id="+id+"&editType=0");
	win.window('open');
}
//查看资产明细
function queryFixedAssets(){
	var win = parent.creatWin(' ', 970,580, 'icon-search', "/Rece/fixedlist1");
	win.window('open');
}
//查看代办信息
function detailDb(){
	var win = parent.creatWin(' ', 970,580, 'icon-search', "/index/taskList?listType=0");
	win.window('open');
}
//查看已办信息
function detailYb(){
	var win = parent.creatWin(' ', 970,580, 'icon-search', "/index/taskList?listType=1");
	win.window('open');
}
//查看办结信息
function detailBj(){
	var win = parent.creatWin(' ', 970,580, 'icon-search', "/index/taskList?listType=2");
	win.window('open');
}
//查看消息信息
function xiaoxi(){
	var win = parent.creatSearchDataWin(' ', 970,580, 'icon-search', "/PrivateInfor/unRead");
	win.window('open');
}
//查看本年度报销额信息明细
function detailApplyForReimbursement(){
	var win = parent.creatWin(' ', 970,580, 'icon-search', "/reimburseLedger/list1");
	win.window('open');
}
//查看本年度借款额信息明细
function detailBorrowMoney(){
	var win = parent.creatWin(' ', 970,580, 'icon-search', "/loanLedger/list1");
	win.window('open');
}
/* //加载tab页
flashtab('1111'); */

//用户添加快速入口
function ksrkadd() {
	var win = parent.creatWin('设置', 840, 475, 'icon-search', "/index/indexShortcut");
	win.window('open');
}


/* //加载待办信息
function reloaddb() {
	$('#indexdb').datagrid('reload');
}
function reloadyb() {
	$('#indexyb').datagrid('reload');
}
function reloadbj() {
	$('#indexbj').datagrid('reload');
} */


//查看通知公告
function openNotice(noticeId) {
	//window.open(base + "/notice/detail/"+noticeId);
	 var win=parent.creatWin('通知公告-查看',1300,630,'icon-search',"/notice/detail/"+noticeId);
	 win.window('open');
}
//查看制度
function openCheter(cheterId) {
	//window.open(base + "/systemcentergl/detail?id="+cheterId+"&fromSy=true");
	var win=parent.creatWin('制度中心-查看',650,500,'icon-search',"/systemcentergl/detail?id="+cheterId+"&fromSy=true");
	win.window('open');
}
//通知公告列表
function tzggList(){
	window.open(base + "/notice/list?menuMark=fromIndex");
}
//制度列表
function zdzxList(){
	window.open(base + "/systemcentergl/list?menuMark=fromIndex");
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
			if(type==1){
				msg='您当前有'+'<font size="4" color="red">'+5+'</font>'+'条新待办任务！<br><input type="button" style="text-align:center;" value="查看待办" id="ckdb"/>';
			}
			if(type==2){
				msg='您当前有'+'<font size="4" color="red">'+5+'</font>'+'条未读信息！<br><input type="button" class="" value="查看消息"  id="ckxx"/>';
			}
			$.messager.show(
					{
						title:'您有新的消息',
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
			var win = parent.creatSearchDataWin('未读消息', 970,580, 'icon-search', "/PrivateInfor/unRead");
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
$(document).ready(function(){
	$('.list_lh li:even').addClass('lieven');
});
$(function(){
	$("div.list_lh").myScroll({
		speed:40, //数值越大，速度越慢
		rowHeight:56, //li的高度
	});
});
//代办、已办、办结、消息事项鼠标经过金额放大
function dbsxStart(){
	$("#dbsxId").css("font-size","40px");
}
function dbsxOver(){
	$("#dbsxId").css("font-size","30px");
}

function ybsxStart(){
	$("#ybsxId").css("font-size","40px");
}
function ybsxOver(){
	$("#ybsxId").css("font-size","30px");
}

function bjsxStart(){
	$("#bjsxId").css("font-size","40px");
}
function bjsxOver(){
	$("#bjsxId").css("font-size","30px");
}

function xxtxStart(){
	$("#xxtxId").css("font-size","40px");
}
function xxtxOver(){
	$("#xxtxId").css("font-size","30px");
}

//报销事项鼠标经过金额放大
function largen0(){
	$("#apply0").css("font-size","20px");
}
function recover0(){
	$("#apply0").css("font-size","18px");
}

function largen1(){
	$("#apply1").css("font-size","20px");
}
function recover1(){
	$("#apply1").css("font-size","18px");
}

function largen2(){
	$("#apply2").css("font-size","20px");
}
function recover2(){
	$("#apply2").css("font-size","18px");
}

function largen3(){
	$("#apply3").css("font-size","20px");
}
function recover3(){
	$("#apply3").css("font-size","18px");
}

function largen4(){
	$("#apply4").css("font-size","20px");
}
function recover4(){
	$("#apply4").css("font-size","18px");
}

function largen5(){
	$("#apply5").css("font-size","20px");
}
function recover5(){
	$("#apply5").css("font-size","18px");
}

function largen6(){
	$("#apply6").css("font-size","20px");
}
function recover6(){
	$("#apply6").css("font-size","18px");
}
function largen7(){
	$("#apply7").css("font-size","20px");
}
function recover7(){
	$("#apply7").css("font-size","18px");
}
//借款事项鼠标经过金额放大
function loanStart0(){
	$("#loan0").css("font-size","20px");
}
function loanOver0(){
	$("#loan0").css("font-size","18px");
}
function loanStart1(){
	$("#loan1").css("font-size","20px");
}
function loanOver1(){
	$("#loan1").css("font-size","18px");
}
function loanStart2(){
	$("#loan2").css("font-size","20px");
}
function loanOver2(){
	$("#loan2").css("font-size","18px");
}
function loanStart3(){
	$("#loan3").css("font-size","20px");
}
function loanOver3(){
	$("#loan3").css("font-size","18px");
}
function loanStart4(){
	$("#loan4").css("font-size","20px");
}
function loanOver4(){
	$("#loan4").css("font-size","18px");
}
function loanStart5(){
	$("#loan5").css("font-size","20px");
}
function loanOver5(){
	$("#loan5").css("font-size","18px");
}
function loanStart6(){
	$("#loan6").css("font-size","20px");
}
function loanOver6(){
	$("#loan6").css("font-size","18px");
}
function loanStart7(){
	$("#loan7").css("font-size","20px");
}
function loanOver7(){
	$("#loan7").css("font-size","18px");
}


</script>
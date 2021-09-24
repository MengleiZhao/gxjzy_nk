<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<style>
	.tete
	{
	width:5px;
	height:60px;
	font-size:10px;
	text-align:center;
	color:#ffffff;
	transition: width 0.5s;
	-moz-transition: width 0.5s; /* Firefox 4 */
	-webkit-transition: width 0.5s; /* Safari 和 Chrome */
	-o-transition: width 0.5s; /* Opera */
	}
</style>

<div class="easyui-tabs">
	<div title="审批流程">
		<img src="${base}/resource-modality/${themenurl}/skin_/hengxian.png" style="margin: 0px 0px 11px 15px;width: 160px">
		<table cellpadding="0" cellspacing="0" border="0">
		<c:forEach items="${nodeConf}" var="li" varStatus="i">
			<tr><td>
			<table style="background-color: #f0f5f7;width: 175px;font-size: 12px;color: #666666"
				cellpadding="0" cellspacing="0" 
				onMouseOver="spOver(this,'${li.checkInfo.checkResult}a',${li.FNType})"
				onMouseOut="spOut(this)" title="${li.checkInfo.checkRemake}">
				<tr>
					<td rowspan="4" align="center" style="width: 35px;background-color: #ffffff">
						<c:if test="${li.checkInfo.checkResult=='0'}">
							<img src="${base}/resource-modality/${themenurl}/skin_/sptxwtg.png">
						</c:if>
						<c:if test="${li.checkInfo.checkResult=='1'}">
							<img src="${base}/resource-modality/${themenurl}/skin_/sptxtg.png">
						</c:if>
						<c:if test="${li.checkInfo.checkResult!='1'&&li.checkInfo.checkResult!='0'}">
							<img src="${base}/resource-modality/${themenurl}/skin_/sptxwsp.png">
						</c:if>
					</td>
					<td colspan="2" style="padding-top: 6px;height: 18px">&nbsp;&nbsp;${li.user.name}</td>
					<td rowspan="4">
						<div class="tete" style="float: right;background-color: 
							<c:if test="${li.checkInfo.checkResult=='0'}">#bb1b34</c:if>
							<c:if test="${li.checkInfo.checkResult=='1'}">#0eaf7c</c:if>
							<c:if test="${li.checkInfo.checkResult!='1'&&li.checkInfo.checkResult!='0'}">#999999</c:if>
						">
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="font-weight: bold;height: 18px">&nbsp;&nbsp;${li.user.depart.name}</td>
				</tr>
				<tr>
					<td colspan="2" style="height: 18px;padding-bottom: 6px;">
						&nbsp;&nbsp;${li.checkInfo.checkTime.toString().substring(0,16)}
					</td>
				</tr>
				<%-- <tr>
					<td style="height: 18px;width:100px;padding-bottom: 6px;" colspan="2">
						&nbsp;&nbsp;
						<a title="${li.checkInfo.checkRemake}" style="color: #666666">
						<c:if test="${li.checkInfo.checkRemake.length()>8}">
							${li.checkInfo.checkRemake.substring(0,8)}...
						</c:if>
						<c:if test="${li.checkInfo.checkRemake.length()<8}">
							${li.checkInfo.checkRemake}
						</c:if>
						</a>
					</td>
				</tr> --%>
			</table>
			</td></tr>
			<tr><td style="height: 10px"><img src="${base}/resource-modality/${themenurl}/skin_/spds.png" style="margin-left: 8px;"></td></tr>
		</c:forEach>
		<tr><td>
		<table style="background-color: #f0f5f7;width: 175px;font-size: 12px;color: #666666"
			cellpadding="0" cellspacing="0" onMouseOver="spOver(this,'-1a')" onMouseOut="spOut(this,'-1','0')">
			<tr>
				<td rowspan="4" align="center" style="width: 35px;background-color: #ffffff">
					<img src="${base}/resource-modality/${themenurl}/skin_/sptxtg.png">
				</td>
				<td colspan="2" style="padding-top: 6px;height: 18px">&nbsp;&nbsp;${bean.userName}</td>
				<td rowspan="4">
					<div class="tete" style="background-color:#0eaf7c;float: right;"></div>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="font-weight: bold;height: 18px">&nbsp;&nbsp;${bean.deptName}</td>
			</tr>
			<tr>
				<td colspan="2" style="height: 18px;padding-bottom: 6px">
					&nbsp;&nbsp;${bean.reqTime.toString().substring(0,16)}
				</td>
			</tr>
			<!-- <tr>
				<td style="padding-bottom: 6px;height: 18px">&nbsp;</td>
				<td style="padding-bottom: 6px;height: 18px">&nbsp;</td>
			</tr> -->
		</table>
		</td></tr>
		</table>
	</div>



	<div title="相关制度">
		<img src="${base}/resource-modality/${themenurl}/skin_/hengxian.png" style="margin: 0px 0px 10px 15px;width: 160px">
		<table class="ourtable2" style="width: 150px;margin-left: 14px;" cellpadding="0" cellspacing="0">
			<tr>
				<td style="height: 25px;"><input class="easyui-textbox"
					style="width:162px;"
					data-options="prompt: '搜索' ,icons: [{iconCls:'icon-sousuo',handler: function(e){}}]">
				</td>
			</tr>
			<c:forEach items="${cheterInfo}" var="li">
				<tr style="height: 30px;">
					<td><a style="color: #666666;margin-left: 5px;"
						id="file${li.systemId}" href="#"
						onclick="findSystemFile(${li.systemId})">${li.fileName}</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>

<script type="text/javascript">
	function spOut(t) {
		$(t).find('.tete').empty();
		$(t).find('.tete').css('width','5px');
	}
	function spOver(t,result,FNType) {
		$(t).find('.tete').css('width','15px');
		if(result=="-1a"){
			$(t).find('.tete').css('line-height','15px');
			$(t).find('.tete').append("发起流程");
		}
		if(result=="0a"){
			$(t).find('.tete').css('line-height','20px');
			$(t).find('.tete').append("未通过");
		}
		if(result=="1a"){
			$(t).find('.tete').css('line-height','30px');
			$(t).find('.tete').append("通过");
		}
		if(result=="a"){
			$(t).find('.tete').css('line-height','20px');
			$(t).find('.tete').append("待审批");
		}
		if(result!="0a"&&FNType=="3"&&result!="a"){
			$(t).find('.tete').css('line-height','20px');
			$(t).find('.tete').empty();
			$(t).find('.tete').append("已办结");
		};
			
	};
</script>

<%-- <table class="easyui-datagrid"  style="width:550px;height:auto"
data-options="
url: '${base}/applyCheck/history/${bean.gId}',
method: 'post',
striped : true,
nowrap : false,
">
<thead>
	<tr>
		<th data-options="field:'cId',hidden:true"></th>
		<th data-options="field:'userName',width:130">审批人姓名</th>
		<th data-options="field:'checkTime',width:130,formatter: ChangeDateFormat">审批时间</th>
		<th data-options="field:'checkResult',width:130,formatter:YJ">审批意见</th>
		<th data-options="field:'checkRemake',width:160">审批内容</th>
	</tr>
</thead>
</table>

<script type="text/javascript">
//时间格式化
function ChangeDateFormat(val) {
	//alert(val)
	var t, y, m, d, h, i, s;
	if (val == null) {
		return "";
	}
	t = new Date(val)
	y = t.getFullYear();
	m = t.getMonth() + 1;
	d = t.getDate();
	h = t.getHours();
	i = t.getMinutes();
	s = t.getSeconds();
	// 可根据需要在这里定义时间格式  
	return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
}

function YJ(val) {
	if(val==1){
		return "通过";
	} else if(val==0){
		return "不通过";
	}
}
</script> --%>

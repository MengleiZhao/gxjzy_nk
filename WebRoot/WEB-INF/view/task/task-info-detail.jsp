<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<div class="win-div">
<form id="inforDeatil" action="${base}/Maintain/saveRegistration" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 429px;">
		<div class="win-left-div" style="width: 800px" data-options="region:'west',split:true">
			<div class="win-left-top-div" style="height: 350px;">
			<input hidden="hidden" id="ifid" value="${bean.ifID }">
			<input hidden="hidden" id="fType" value="${bean.fType }">
			<input hidden="hidden" id="fUrl2" value="${bean.fUrl2 }">
			<input hidden="hidden" id="fUrl1" value="${bean.fUrl1 }">
			<input hidden="hidden" id="fSendTime" value="${bean.fSendTime }">
			<input hidden="hidden" id="MfMessageStauts" value="${bean.fMessageStauts }">
				<div class="easyui-accordion" style="width:772px;margin-left: 25px;">
					<div title="" data-options="iconCls:'',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
						<table class="ourtable" cellpadding="0" cellspacing="0">
							<tr style="height: 30px;margin-left: 40px">
								<td colspan="2">
									<span style="font-weight:bold;font-size: 16px">${bean.fTitle}</span>
									<c:if test="${bean.fMessageStauts ==0}">
										<img id="starIcon" onclick="starSet(${bean.ifID })" src="${base}/resource-modality/${themenurl}/button/star1.png">
									</c:if>
									<c:if test="${bean.fMessageStauts ==1}">
										<img id="starIcon" onclick="starSet(${bean.ifID })" src="${base}/resource-modality/${themenurl}/button/star2.png">
									</c:if>
								</td >
							</tr>
							<tr style="height: 20px;margin-top: 20px;">
								<td style="width: 80px;padding-top: 20px;">发送人</td>
								<td style="padding-top: 20px;">
									<sapn >${bean.fSendUser }</sapn>
								</td>
							</tr>
							<tr  style="height: 20px">
								<td style="width: 80px;padding-top: 7px;">接收时间</td>
								<td style="padding-top: 7px;">
									<span  id="sendTime"></span>
								</td>
							</tr>
							<tr  style="height: 20px">
								<td style="width: 80px;padding-top: 7px;">收件人</td>
								<td style="padding-top: 7px;">
									<span >${bean.recipient}</span>
								</td>
							</tr>
							<tr style="margin-top: 18px;height: 30px">
								<td colspan="2">
									<img style="width: 750px;margin-bottom: 5px;" src="${base}/resource-modality/${themenurl}/MessageLine.png"><br>
								</td>
							</tr>
							<c:if test="${empty bean.fUrl1 }">
							<tr style="margin-top: 17px">
								<td colspan="2">
									<span style="white-space:normal;margin-right: 20px; ">${bean.fMessage}</span>  
								</td>
							</tr>
							</c:if>
							<c:if test="${!empty bean.fUrl1 }">	
							<tr style="margin-top: 17px">
								<td colspan="2">
									<span style="white-space:normal;margin-right: 20px; ">
										<a href="#" style="color:blue" onclick="finishProXX()">
											${bean.fMessage}
										</a>
									</span>  
								</td>
							</tr>
							</c:if>	
						</table>
					</div>
				</div>			
			</div>
			
			<div class="win-left-bottom-div">
				<c:if test="${openType=='chuli'}">
					<a href="javascript:void(0)" onclick="process(${bean.ifID })">
						<img src="${base}/resource-modality/${themenurl}/button/chuli1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
				</c:if>
				<c:if test="${detailType=='detail'}">
					<a href="javascript:void(0)" onclick="closeWindow()">
						<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</c:if>
				<c:if test="${detailType=='ledger'}">
					<a href="javascript:void(0)" onclick="closeFirstWindow()">
						<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</c:if>
			</div>
		</div>
	
		<%-- <div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../../check_system.jsp" />
		</div> --%>
	</div>
</form>
</div>
<script type="text/javascript">

setSendTime();
//设置星标
function starSet(id) {
	var fMessageStauts = $('#MfMessageStauts').val();
	if (fMessageStauts == 0) {
		$('#starIcon').attr('src',base+"/resource-modality/${themenurl}/button/star2.png");
		$('#MfMessageStauts').val("1");
		fMessageStauts=1;
	} else if (fMessageStauts == 1) {
		$('#starIcon').attr('src',base+"/resource-modality/${themenurl}/button/star1.png");
		$('#MfMessageStauts').val("0");
		fMessageStauts=0;
	}
	//传输到后台改变数据库状态
	$.ajax({ 
		type: 'POST', 
		url: '${base}/PrivateInfor/updateMessageStauts/'+id+'?fMessageStauts='+fMessageStauts,
		dataType: 'json', 
		success: function(data){ 
			if(data.success){
				//$.messager.alert('系统提示',data.info,'info');
				//$('#'+tabid).datagrid('reload');
			}else{
				//$.messager.alert('系统提示',data.info,'error');
			}
		} 
	}); 
	
}
$(function(){
	
})
//关闭方法重写新增刷新列表页面
function closeWindow(){
	$('#custom_window').empty();
	$("#custom_window").window('close');
	$('#infTab').datagrid('reload');
	$('#starTab').datagrid('reload');
}
//设置时间
function setSendTime(){
   	var val = $('#fSendTime').val();
    var t, y, m, d, h, i, s;
    if(val==null){
  	  return "";
    }
    t = new Date(val);
    y = t.getFullYear();
    m = t.getMonth() + 1;
    d = t.getDate();
    h = t.getHours();
    i = t.getMinutes();
    s = t.getSeconds();
    // 可根据需要在这里定义时间格式  
    val=y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) + ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i);
    $('#sendTime').html(val);
}
function process(id){
	var fType = $('#fType').val();	
	var fUrl2 = $('#fUrl2').val();	
	var fUrl1 = $('#fUrl1').val();	
	if("3"==fType){
		//退回
		var win=creatWin('修改',970,580,'icon-search',fUrl2);
		//var win=creatWin('修改',970,580,'icon-search','/PrivateInfor/process/'+id+"?furl="+fUrl2);
		win.window('open');
	}else if("2"==fType){
		//查看
		var win=creatWin('查看',970,580,'icon-search',fUrl1);
		//var win=creatWin('查看',970,580,'icon-search','/PrivateInfor/process/'+id+"?furl="+fUrl1);
		win.window('open');
	}
}

//抽取专家消息查看详情
function record_detailMsg(val){
	var win=creatFirstWin('专家记录',800,620,' ','/expertgl/recordDetailJsp?idArr='+val);
	win.window('open');
}
//结项
function finishProXX(proId) {
	var url = '${bean.fUrl1}';
	var win = parent.creatWin('预算项目完结申请表', 970, 580, 'icon-search', url);
	win.window('open');
}

</script>
</body>
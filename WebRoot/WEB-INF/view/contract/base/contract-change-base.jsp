<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
	<div title="变更信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
		<table class="window-table" style="margin-top: 10px;width: 695px" cellspacing="0" cellpadding="0">
			<tr class="trbody">
				<td class="td1"><span class="style1">*</span>&nbsp;原合同编号</td>
				<td colspan="4">
					<input class="easyui-textbox" id="F_fContCodeOld" name="fContCodeOld" readonly="readonly" required="required" data-options="validType:'length[1,50]'" style="width: 587px;height: 30px;" value="${Upt.fContCodeOld}"/>
				</td>
			</tr>	
			<tr class="trbody">
				<td class="td1"><span class="style1">*</span>&nbsp;原合同名称</td>
				<td colspan="4">
					<input class="easyui-textbox" id="F_fContNameOld" name="fContNameOld" readonly="readonly" required="required" data-options="validType:'length[1,50]'" style="width: 587px;height: 30px;" value="${Upt.fContNameOld}"/>
				</td>
			</tr>	
			<tr class="trbody">
				<td class="td1"><span class="style1">*</span>变更合同编号</td>
				<td colspan="4">
					<input class="easyui-textbox" id="F_fUptCode" name="fUptCode" readonly="readonly" required="required" data-options="validType:'length[1,50]'" style="width: 587px;height: 30px;" value="${Upt.fUptCode}"/>
				</td>
			</tr>	
			<tr class="trbody">
				<td class="td1"><span class="style1">*</span>变更合同名称</td>
				<td colspan="4">
					<input class="easyui-textbox" id="F_fContName" name="fContName" required="required" data-options="validType:'length[1,50]'" style="width: 587px;height: 30px;" value="${Upt.fContName}"/>
				</td>
			</tr>	
			<tr class="trbody">
				<td class="td1" ><span class="style1">*</span>&nbsp;变更内容</td>
				<td colspan="4">
					<input class="easyui-textbox" id="Upt_fUptReason" name="fUptReason" data-options="validType:'length[1,200]',multiline:true" style="width:587px;height:70px;margin-top: 10px;" value="${Upt.fUptReason }"/>
				</td>
			</tr>
			<tr class="trbody">
				<td class="td1" ><span class="style1">*</span>&nbsp;所属部门</td>
				<td>
					<input class="easyui-textbox" id="Upt_fDeptName" readonly="readonly" value="${Upt.fDeptName }" name="fDeptName" style="width: 240px;height: 30px;" data-options="editable:false,required:true">
				</td>
				<td class="td1" ><span class="style1">*</span>&nbsp;申请人</td>
				<td>
					<input class="easyui-textbox" id="Upt_fOperator" readonly="readonly" value="${Upt.fOperator }" name="fOperator" style="width: 240px;height: 30px;" data-options="editable:false,required:true">
				</td>
			</tr>
			<tr class="trbody">
				<td class="td1">
					<span class="style1">*</span>变更合同文本
					<input type="file" multiple="multiple" id="fhtbg" onchange="upladFileParams(this,'htbg','htgl01','progressNumberhtbg','percenthtbg','tdhtbg','htbgfiles','progidhtbg')" hidden="hidden" accept=".pdf">
					<input type="text" id="htbgfiles" name="htbgfiles" hidden="hidden">
				</td>
				<td colspan="4" id="tdhtbg">
					<a onclick="$('#fhtbg').click()" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					<span style="color: red">&nbsp;&nbsp;&nbsp;注：请上传变更合同（pdf格式，以变更合同编号命名）</span>
					<div id="progidhtbg" style="background:#EFF5F7;width:300px;height:10px;margin-top:0px;display: none" >
					<div id="progressNumberhtbg" style="background:#3AF960;width:0px;height:10px" >
					</div>文件上传中...&nbsp;&nbsp;<font id="percenthtbg">0%</font></div></br>
					<c:forEach items="${changeAttaList}" var="att">
						<c:if test="${att.serviceType=='htbg' }">
							<div class="htbg" style="margin-top: 0px;margin-bottom: 10px;">
								<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<img style="vertical-align:bottom;margin-bottom: 10px;" src="${base}/resource-modality/${themenurl}/sccg.png">
								&nbsp;&nbsp;&nbsp;&nbsp;
								<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
							</div>
						</c:if>
					</c:forEach>
				</td>

			</tr>
		</table>
	</div>
</div>
<c:if test="${Upt.fContUptType=='HTFL-01'}">
	<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
		<div title="变更后采购清单" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
			<%@ include file="../base/contract-change-cgconf-mingxi.jsp" %>
		</div>
	</div>
	<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
		<div title="付款计划" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
			<%@ include file="../base/contract-change-plan.jsp" %>
		</div>
	</div>
</c:if>
<c:if test="${Upt.fContUptType=='HTFL-02'}">
	<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
		<div title="变更后收款计划" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
			<%@ include file="../base/contract-change-proceeds-plan.jsp" %>
		</div>
	</div>
</c:if>
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
	<div title="附件信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
		<table class="window-table" style="margin-top: 10px;width: 695px" cellspacing="0" cellpadding="0">
			<tr >
				<td class="td1" style="width:50px;">
					附件
					<input type="file" multiple="multiple" id="fhtbgOther" onchange="upladFileParamsOther(this,'htbgOther','htgl01','progressNumberhtbgOther','percenthtbgOther','tdhtbgOther','htbgOtherfiles','progidhtbgOther')" hidden="hidden">
					<input type="text" id="htbgOtherfiles" name="htbgOtherfiles" hidden="hidden">
				</td>
				<td colspan="4" id="tdhtbgOther">
					<a onclick="$('#fhtbgOther').click()" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					<div id="progidhtbgOther" style="background:#EFF5F7;width:300px;height:10px;margin-top:0px;display: none" >
					<div id="progressNumberhtbgOther" style="background:#3AF960;width:0px;height:10px" >
					</div>文件上传中...&nbsp;&nbsp;<font id="percenthtbgOther">0%</font></div></br>
					<c:forEach items="${changeAttaList}" var="att">
						<c:if test="${att.serviceType=='htbgOther' }">
							<div class="htbgOther" style="margin-top: 0px;margin-bottom: 10px;">
								<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<img style="vertical-align:bottom;margin-bottom: 10px;" src="${base}/resource-modality/${themenurl}/sccg.png">
								&nbsp;&nbsp;&nbsp;&nbsp;
								<a id="${att.id}" class="fileUrlhtbgOther" href="#" style="color:red" onclick="deleteAttacOther(this)">删除</a>
							</div>
						</c:if>
					</c:forEach>
				</td>
			</tr>
		</table>
	</div>
</div>
<c:if test="${openType!='Cadd' }">
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
	<div title="审批记录" data-options="collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
		<jsp:include page="../../check_history_bg.jsp" />
	</div>
</div>
</c:if>
<script type="text/javascript">

function onClickCellPlan(index, field){
	if (editIndex != index){
		if (endEditingPlan()){
			$('#change-upt-datagrid').datagrid('selectRow', index)
					.datagrid('beginEdit', index);
			var ed = $('#change-upt-datagrid').datagrid('getEditor', {index:index,field:field});
			if (ed){
				($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
			}
			editIndex = index;
		} else {
			setTimeout(function(){
				$('#change-upt-datagrid').datagrid('selectRow', editIndex);
			},0);
		}
	}
}
function appendPlan1(){
	if (endEditingPlan()){
		$('#change-upt-datagrid').datagrid('appendRow',{});
		editIndex = $('#change-upt-datagrid').datagrid('getRows').length-1;
		$('#change-upt-datagrid').datagrid('selectRow', editIndex)
				.datagrid('beginEdit', editIndex);
	}
}
function removeitPlan1(){
	if (editIndex == undefined){return}
	$('#change-upt-datagrid').datagrid('cancelEdit', editIndex)
			.datagrid('deleteRow', editIndex);
	editIndex = undefined;
}
var editIndex = undefined;
function endEditingPlan(){
	if (editIndex == undefined){return true}
	if ($('#change-upt-datagrid').datagrid('validateRow', editIndex)){
		$('#change-upt-datagrid').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function getPlan1(){
	$('#change-upt-datagrid').datagrid('acceptChanges');
	var rows = $('#change-upt-datagrid').datagrid('getRows');
	var entities= '';
	for(i = 0;i < rows.length;i++){
	 entities = entities  + JSON.stringify(rows[i]) + ',';  
	}
	entities = '[' + entities.substring(0,entities.length -1) + ']';
	return entities;
}


//这个是通用的上传方法3
//文件上传
function upladFileParamsOther(obj,serviceType,pathNum,progressNumberid,percentid,tdfid,filesid,progid) {
this.percentid=percentid;
this.progressNumberid=progressNumberid;
this.tdfid=tdfid;
this.serviceType=serviceType;
this.filesid=filesid;
this.progid=progid;
var files = obj.files;
var size=files[0].size;
if(size==0){
	  alert("不允许上传空文件");
	  return false;
}
var formData = new FormData();
//判断有没有选中附件信息
if(files==null || files=="null"|| files.length==0){
	  alert("请选择附件上传");
	  return false;
}
//把所有的附件都存入变量，准备传给后台
for(var i=0; i< files.length; i++){
	 formData.append("attFiles",files[i]);   
} 
//初始化进度条为0

$("#"+progid).show();
$("#"+percentid).html(0 + '%');
$("#"+progressNumberid).css("width",""+0+"px");   
// 接收上传文件的后台地址 
var url = base + "/attachment/uploadAtt?serviceType="+serviceType+"&pathNum="+pathNum;          
//1.创建XMLHttpRequest组建    
xmlHttpRequest = createXmlHttpRequest();  
//回调函数
xmlHttpRequest.onreadystatechange = callbackParamsOther;
//post请求
xmlHttpRequest.open("post", url, true);
xmlHttpRequest.onload = function () {
  // alert("上传完成!");
};
//调用线程监听上传进度
xmlHttpRequest.upload.addEventListener("progress", progressFunctionParamsOther, false);
//把文件数据发送出去
xmlHttpRequest.send(formData);
//清空value （作用：删除文件后再上传同一个文件，onchange方法不调用）
event.target.value=null;
}
	//监听进度线程，生成进度条
function progressFunctionParamsOther(evt) {
if (evt.lengthComputable) {
	  //evt.loaded：文件上传的大小   evt.total：文件总的大小                    
    var percentComplete = Math.round((evt.loaded) * 100 / evt.total);    
    //加载进度条，同时显示信息          
    $("#"+percentid).html(percentComplete + '%');
    //percentComplete*2  这个2是根据总像素大小来改变的，如果是300px就 *3
    $("#"+progressNumberid).css("width",""+percentComplete*3+"px");   
}
} 
//回调函数
function callbackParamsOther() {
  //5。接收响应数据
  //判断对象的状态是交互完成
  if (xmlHttpRequest.readyState == 4) {
      //判断http的交互是否成功
      if (xmlHttpRequest.status == 200) {
          //获取服务器段输出的纯文本数据
          var responseText = xmlHttpRequest.responseText;
          //文本数据转换成json
          var jsonResponse = JSON.parse(responseText);
	    	 if(jsonResponse.success==true){
	    		    //获取controller 返回的对象信息
			        var datainfo = jsonResponse.info;
	    		    //如果上传了多个文件，返回的string就有多个，使用逗号分割，现在截取
	    		 	var infoArray = datainfo.split(',');	
	    		 	for(var i=0; i< infoArray.length; i++){
	    		 		var info = infoArray[i];
	    		 		var inf = info.split('@');
	    		 		var id = inf[0];//附件id
	    		 		var name = inf[1];//附件名称
				        $('#'+tdfid).append(
			    			"<div class='"+serviceType+"' style='margin-top: 5px;'>"+
			    				"<a href='"+base+"/attachment/download/"+id+"' style='color: #666666;font-weight: bold;'>"+name+"</a>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;"+
			    				"<img style='vertical-align:middle' src='"+base+"/resource-modality/img/sccg.png'>"+
			    				"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/img/scsb.png'>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;<a id='"+id+"' class='fileUrl"+serviceType+"' href='#' style='color:red' onclick='deleteAttacOther(this)'>删除</a><div>"
			    		);
	    		 		
	    		 	}
	    		 	//放入附件id
	    			var s="";
	    			$(".fileUrl"+serviceType).each(function(){ 
	    				s=s+$(this).attr("id")+",";
	    			});
	    			$("#"+filesid).val(s);
	    			$("#"+progid).hide();
	    	} else {
	    		$('#'+tdfid).append(
  				"<div style='margin-top: 5px;'>"+
  					"<a href='#' style='color: #666666;font-weight: bold;'>"+filename[filename.length-1]+"</a>"+
  					"&nbsp;&nbsp;&nbsp;&nbsp;"+
  					"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/img/sccg.png'>"+
  					"<img style='vertical-align:middle' src='"+base+"/resource-modality/img/scsb.png'>"+
  					"&nbsp;&nbsp;&nbsp;&nbsp;<a id='fail' class='fileUrl"+serviceType+"' href='#' style='color:red' onclick='deleteAttacOther(this)'>删除</a><div>"
  			);
	    		$("#"+progid).hide();
	    	}
      } else {
          alert("上传失败");
      }
  }
}
//附件删除
function deleteAttacOther(obj,mark){
	if(confirm("确认删除吗？")){
		$.ajax({ 
			type: 'POST', 
			url: base+'/attachment/delete/'+obj.id,
			dataType: 'json',  
			success: function(data){ 
				if(data.success){
					$.messager.alert('系统提示',data.info,'info');
					$(obj).parent().remove();
					if(mark=='zdsy'){
						//如果是制度索引新增
						$('#systemcenter_add_uploadbtn').show();
					}
				}else{
					$.messager.alert('系统提示',data.info,'error');
				}
			} 
		}); 
	}
}
  
</script>
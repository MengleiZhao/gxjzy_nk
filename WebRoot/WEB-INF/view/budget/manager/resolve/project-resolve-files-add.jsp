<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div style="width: 536px;height: 225px;border: 1px #d9e3e7 solid;">
<form id="projectResolveFiles" action="${base}/resolve/filesUpdate" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div style="width: 536px;height: 180px" borger="0">
		<table id="projectResolveFilesTable" class="ourtable" style="width: 536px;height: 110px">
			<tr class="trbody">
				<td class="td1" valign="top" style="padding-top: 25px">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;附件
					<input type="file" multiple="multiple" id="yskzsfj" onchange="upladFile(this,'ysgl03','ysgl03')" hidden="hidden">
					<input type="text" id="files" name="files" hidden="hidden">
					<input type="hidden" name="FProId" id="id" value="${id}"/>
				</td>
				<td colspan="4" id="tdf" valign="top" style="padding-top: 25px">
					<c:if test="${openType=='add'||openType=='edit'}">
					<a onclick="$('#yskzsfj').click()" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>
					
					<c:if test="${hasFile!='true'&&openType=='detail' }">
						<span>当前没有选择任何附件</span>
					</c:if>
					
					<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
						<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
				 		</div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font>
					 </div>
					<c:forEach items="${projectResolveAttaList}" var="att">
						<c:if test="${att.serviceType=='ysgl03' }">
							<div style="">
							<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<c:if test="${openType=='add'||openType=='edit'}">
							<img style="vertical-align:middle" src="${base}/resource-modality/${themenurl}/sccg.png">
							&nbsp;&nbsp;&nbsp;&nbsp;
								<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
							</c:if>
							</div>
						</c:if>
					</c:forEach>
				</td>
			</tr>				
		</table>
	</div>	
	<div class="win-left-bottom-div" style="height: 30px;line-height: 47px">
		<c:if test="${openType=='add'||openType=='edit'}">
			<a href="javascript:void(0)" onclick="projectResolveFilesSave()">
			<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>&nbsp;&nbsp;
		</c:if>
		<a href="javascript:void(0)" onclick="closeWindow()">
		<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
	</div>
</form>
</div>
<script type="text/javascript">
function projectResolveFilesSave(){
	$('#projectResolveFiles').form('submit', {
		onSubmit: function(){ 
				flag=$(this).form('enableValidation').form('validate');
				if(flag){
					$.messager.progress();
				}else {
					openAccordion();
				}
				return flag;
			}, 
			success:function(data){
				if(flag){
					$.messager.progress('close');
				}
				data=eval("("+data+")");
				if(data.success){
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					$('#projectResolveFiles').form('clear');
					$("#projectResolveFilesTable").datagrid('reload'); 
				}else{
					$.messager.alert('系统提示', data.info, 'error');
				}
			} 
		});	
}
</script>
</body>
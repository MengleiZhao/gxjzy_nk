<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="cheter_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 379px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div" style="height: 300px;width: 650px">
				<div id="easyAcc" class="easyui-accordion" style="width:600px;margin-left: 20px;">
					<!-- 第一个div -->
					<div title="制度信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
						<table  class="ourtable" cellpadding="0" cellspacing="0" style="width: 550px">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>文件名称</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_fileName"  name="fileName"  style="width:450px;height:30px;" data-options="validType:'length[1,50]'" value="${bean.fileName}"/>
									<input type="hidden" name="systemId" id="F_systemId" value="${bean.systemId}"/><!--隐藏域  -->
									<input type="hidden" name="releseUser" id="F_releseUser" value="${bean.releseUser}"/><!--隐藏域  -->
									<input type="hidden" name="releseTime" id="F_releseTime" value="${bean.releseTime}"/><!--隐藏域  -->
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>所属模块</td>
								<td colspan="4">
									<input class="easyui-textbox" type="text" id="F_belong"  name="belong"  required="required" data-options="validType:'length[1,50]'" style="width:450px;height:30px;" value="${bean.belong}"/>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1">
									&nbsp;&nbsp;附件
									<input type="file" multiple="multiple" id="f" onchange="upladFile(this,null,'jcsj01')" hidden="hidden">
									<input type="text" id="files" name="files" hidden="hidden">
								</td>
								<td colspan="4" id="tdf">
									<a onclick="$('#f').click()" style="font-weight: bold;" href="#">
										<img src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
									</a>
									<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
								        <div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
								        </div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
						    	    </div>
									<c:forEach items="${attac}" var="att">
										<div style="margin-top: 10px;">
											<a href='#' style="color: #666666;font-weight: bold;">${att.originalName}</a>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
										</div>
									</c:forEach>
									</td>
								</tr>
							</table>
						</div>
					</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveCheter()">
				<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/${themenurl}/button//guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<%-- <div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div> --%>
	</div>
</form>
</div>
<script type="text/javascript">
//保存
function saveCheter() {
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);
	
	
	//提交
	$('#cheter_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}else{
				//校验不通过，就打开第一个校验失败的手风琴
				openAccordion();
			}
			return flag;
		},
		url : base + '/systemcentergl/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				//$("#cheter_form").form("clear");
				 $("#cheter_tab").datagrid("reload");
			} else {
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#cheter_form').form('clear');
			}
		}
	});	
}

</script>
</body>
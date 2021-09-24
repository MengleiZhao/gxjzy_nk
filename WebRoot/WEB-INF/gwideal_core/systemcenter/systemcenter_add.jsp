<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="cheter_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 260px;">
		<div data-options="region:'center',split:true ">
						
					<!--隐藏域  id -->
					<input type="hidden" name="systemId" id="F_systemId" value="${bean.systemId}"/>
					<input type="hidden" name="attachment.id" id="F_attachmentId" value="${bean.attachment.id}"/>
					
					<table  class="ourtable" cellpadding="0" cellspacing="0" style="width: 580px;margin-top:10px; padding-left:15px; ">
						<tr class="trbody" style="height: 46px;">
							<td class="td1"><span class="style1">*</span>&nbsp;文档名称</td>
							<td colspan="4">
								<input class="easyui-textbox" id="cheter_add_fileName" name="fileName" value="${bean.fileName }"  style="width:453px;height:30px;" data-options="validType:'length[1,500]',required:true" />
							</td>
						</tr>
						<tr class="trbody" style="height:64px;" valign="top">
							<td class="td1">&nbsp;&nbsp;附件
								<input type="file" id="f" onchange="hint(this,value)" hidden="hidden">
								<input type="text" id="files" name="files" hidden="hidden">
							</td>
							<td id="tdf" colspan="4">
								<c:set var="salary" value="${edit}"/>
								<c:if test="${salary==null}">
									<a id="systemcenter_add_uploadbtn" onclick="$('#f').click()" style="font-weight: bold; " href="#">
										<img src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
									</a>
								</c:if>
								<c:if test="${salary!=null}">
									<a id="systemcenter_add_uploadbtn" onclick="$('#f').click()" style="font-weight: bold; display: none" href="#">
										<img src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
									</a>
								</c:if>
								
								<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
							        <div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
							        </div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
					    	    </div>
								<c:forEach items="${attac}" var="att">
									<div style="margin-top: 10px;">
										<a href='#' style="color: #666666;font-weight: bold;" id="attName">${att.originalName}</a>
										&nbsp;&nbsp;&nbsp;&nbsp;
										<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
										&nbsp;&nbsp;&nbsp;&nbsp;
										<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttacment(this)">删除</a>
									</div>
								</c:forEach>
								</td>
							</tr>
						<tr class="trbody" >
							<td class="td1"><span class="style1">*</span>&nbsp;所属模块</td>
							<td>
								<select class="easyui-combobox" type="text" id="cheter_add_belong"  name="belong" data-options="required:false,editable:false" 
									style="width:160px" >
									<option value="${bean.belong }">${bean.belong }</option>
									<option value="0">-请选择-</option>
									<option value="预算管理">预算管理</option>
									<option value="收入管理">收入管理</option>
									<option value="支出管理">支出管理</option>
									<option value="采购管理">采购管理</option>
									<option value="合同管理">合同管理</option>
									<option value="资产管理">资产管理</option>
								</select>
							</td>
							
							<td style="width:20px;"></td>
							
							<td class="td1"><span class="style1">*</span>&nbsp;文档编码</td>
							<td>
								<input class="easyui-textbox" type="text" id="cheter_add_helpNum"  name="helpNum" value="${bean.helpNum }" readonly="readonly" required="required" style="width:160px"  />
							</td>
						</tr>
						
						<tr class="trbody" >
							<td class="td1"><span class="style1">*</span>&nbsp;上传人</td>
							<td>
								<input class="easyui-textbox" type="text" id="cheter_add_releseUser"  name="releseUser" value="${bean.releseUser }" readonly="readonly" required="required" style="width:160px"  />
							</td>
							<td style="width:20px;"></td>
							<td class="td1"><span class="style1">*</span>&nbsp;上传时间</td>
							<td>
								<input class="easyui-datebox" type="text" id="cheter_add_releseTime"  name="releseTime" value="${bean.releseTime }" required="required" editable="false" style="width:160px"  />
							</td>
						</tr>
					</table>
					<br>
			<div style="text-align: center; margin-top: 10px;">
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
function deleteAttacment(t){
	deleteAttac(t,'zdsy');
	$("#systemcenter_add_uploadbtn").css("display", "block");
}

function hint(t,v){
	var type=v.substr(v.lastIndexOf(".")).toLowerCase();
	if(type!=".pdf"){
		alert("请上传pdf格式的文件！");
		return;
	}
	upladFile(t,'zdsy',null,'zdsy');
}
//保存
function saveCheter() {
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);
	
	var files=$("#files").val();
	if(files==""){
		alert("请上传附件！");
		return;
	}
	//校验
	if($('#cheter_add_belong').combobox('getValue')==0){
		alert('请选择所属模块！');
		return;
	}
	
	
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
				if(data.info!='该文档名称已经存在，请修改！'){
					closeWindow();
					$('#cheter_form').form('clear');
				}
			}
		}
	});	
}

</script>
</body>
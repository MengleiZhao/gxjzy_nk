<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<script type="text/javascript">

//保存
function savePayment(saveType) {
	
	//流程状态
	$('#flowStatus').val(saveType);
	
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);
	
	
	//提交
	$('#payment_add_form').form('submit', { 
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}else{
				
			}
			return flag;
		},
		url : base + '/payment/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$("#dg_payment_list").datagrid("reload");
			} else {
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#payment_add_form').form('clear');
			}
		} 
	});	
}
//弹出选择借款单页面
function changePayMent (){
	var win = creatFirstWin('选择借款单',860,580,'icon-search','/payment/choicePayMent');
	win.window('open');
}
</script>

<form id="payment_add_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
			<div  style="width:700px;height:300px">
				<div class="window-left-top-div">
					<!-- 隐藏域 --> 
					<!-- 主键ID --><input type="hidden" name="id" value="${bean.id}" />
					<!-- 附件名称 --><input type="hidden" name="fileName" value="${bean.fileName}" />
					<!-- 流程状态 --><input type="hidden" id="flowStatus" name="flowStatus" value="${bean.flowStatus}" />
					
					<!-- 基本信息 -->
					<div id="sqsqjbxx" style="overflow:auto;">
					
						<div class="window-title">还款信息</div>
						
						<%-- <table class="window-table window-table-readonly" cellspacing="0" cellpadding="0">
							<tr>
								<td class="window-table-td1"><p>申请人:</p></td>
								<td class="window-table-td2"><p>${bean.userName}</p></td>
								
								<td class="window-table-td1"><p>申请部门:</p></td>
								<td class="window-table-td2"><p>${bean.deptName}</p></td>
							</tr>
							
							<tr>
								<td class="window-table-td1"><p>申请时间:</p></td>
								<td colspan="3"><p id="req_time">${bean.reqTime}</p></td>
							</tr>
						
						</table> --%>
					
						<table class="window-table" cellspacing="0" cellpadding="0">
							
							<tr class="trbody">
								<td class="window-table-td1"><span class="style1">*</span>借款单</td>
								<td class="window-table-td2">
									<a href="#" onclick="changePayMent()">
										<input class="easyui-textbox" id="code" name="code" style="width: 200px; height: 25px;" data-options="prompt:'单击选择借款单',iconCls:'icon-sousuo'" value="${bean.code}" >
									</a>
								</td>
								
								<td class="window-table-td1"><span class="style1">*</span>还款金额</td>
								<td class="window-table-td2">
									<input class="easyui-numberbox" id="payAmount" name="payAmount" style="width: 200px; height: 25px;" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]"
									value="${bean.payAmount}" >
								</td>
							</tr>
							
								
							<tr class="trbody">
								<td class="window-table-td1"><span class="style1">*</span>还款人</td>
								<td class="window-table-td2">
									<input class="easyui-textbox" id="payPerson" name="payPerson" style="width: 200px; height: 25px;" data-options=""
									value="${bean.payPerson}" >
								</td>
								
								<td class="window-table-td1"><span class="style1">*</span>还款时间</td>
								<td class="window-table-td2" colspan="3">
									<input class="easyui-datebox" id="payTime" name="payTime" style="width: 200px; height: 25px;" data-options=""
									value="${bean.payTime}" >
								</td>
							</tr>
							
						</table>
						
						<table>
							<tr class="trbody">
								<!-- 附件框 -->
								<td class="window-table-td1">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;附件
									<input type="file" multiple="multiple" id="f" onchange="upladFile(this,null,'zcgl02')" hidden="hidden">
									<input type="text" id="files" name="files" hidden="hidden">
								</td>
								<td colspan="4" id="tdf">
									<!-- 上传按钮 -->
									<a onclick="$('#f').click()" style="font-weight: bold;" href="#">
										<img style="vertical-align:bottom;margin-left: 7px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
									</a>
									<!-- 上传进度 -->
									<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
										<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
										 </div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
									</div>
									<!-- 附件列表 -->
									<c:forEach items="${attaList}" var="att">
										<div style="margin-top: 10px;">
										<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
										&nbsp;&nbsp;&nbsp;&nbsp;
										<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
										&nbsp;&nbsp;&nbsp;&nbsp;
										<c:if test="${opeType!='detail' }">
											<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
										</c:if>
										</div>
									</c:forEach>
								</td>
							</tr>
						</table>
					</div>
					
					<!-- 审批记录 -->
					<%-- <div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../../check_history.jsp" />												
					</div> --%>
			</div>
			<div class="window-left-bottom-div">
			
				<c:if test="${opeType!='detail' }">
					<a href="javascript:void(0)" onclick="savePayment(1)">
					<img src="${base}/resource-modality/${themenurl}/button/tijiao1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;
					<%-- <a href="javascript:void(0)" onclick="savePayment(2)">
					<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp; --%>
				
				</c:if>
			
				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				<%-- &nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=支出管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a> --%>
			</div>
		</div>
		
		<%-- <div class="window-right-div" style="width:254px;height: auto;padding-bottom: 20px;">
			<jsp:include page="../../check_system.jsp" />
		</div> --%>
		
	</div>
</form>

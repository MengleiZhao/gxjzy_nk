<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="re_capital_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="" style="width:662px;margin-left: 20px">
						<div title="借款单信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
							<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
								<tr>
									<td class="td1"><span class="style1">*</span>借款单号</td>
									<td class="td2">
										<input id="F_lCode" name="lCode"  class="easyui-textbox" type="text" readonly="readonly" required="required"  style="width: 200px" value="${loanbean.lCode}"/>
										<!-- 隐藏域 --> 
									    <input type="hidden" name="lId" id="F_lId" value="${loanbean.lId}"/><!--借款单id -->
									    <input type="hidden" name="indexId" id="F_indexId" value="${loanbean.indexId}"/><!--借款指标的id -->
									</td>
									<td class="td4"></td>
									<td class="td1"><span class="style1">*</span>借款金额</td>
									<td class="td2">
										<input id="F_lAmount" name="lAmount"  class="easyui-textbox" readonly="readonly" data-options="iconWidth: 22,icons: [{iconCls:'icon-yuan',handler: function(e){}}]" style="width: 200px" value="${loanbean.lAmount}" />
									</td>
								</tr>
								<tr>
									<td class="td1"><span class="style1">*</span>借款指标</td>
									<td class="td2">
										<input id="F_indexName" name="indexName" class="easyui-textbox" type="text" readonly="readonly" required="required"  style="width: 200px" value="${loanbean.indexName}"/>
									</td>
									<td style="width: 0px"></td>
									<td class="td1"><span class="style1">*</span>借款类型</td>
									<td class="td2">
										<c:if test="${loanbean.indexType=='0'}">
											<input id="F_indexType" name="indexType" class="easyui-textbox" readonly="readonly"  style="width: 200px" value="基本支出指标" />
										</c:if>
										<c:if test="${loanbean.indexType=='1'}">
											<input id="F_indexType" name="indexType" class="easyui-textbox" readonly="readonly"  style="width: 200px" value="项目支出指标" />
										</c:if>
									</td>
								</tr>
								<tr>
									<td class="td1"><span class="style1">*</span>借款人</td>
									<td class="td2">
										<input id="F_userName" name="userName" class="easyui-textbox" type="text" readonly="readonly" required="required"  style="width: 200px" value="${loanbean.userName}"/>
									</td>
									<td style="width: 0px"></td>
									<td class="td1"><span class="style1">*</span>借款时间</td>
									<td class="td2">
										<input id="F_reqTime" name="reqTime"  class="easyui-datebox" readonly="readonly"  style="width: 200px" value="${loanbean.reqTime}" />
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1"><span class="style1">*</span>借款用途</td>
									<td colspan="4">
										<input id="F_loanPurpose" name="loanPurpose"  class="easyui-textbox" readonly="readonly" style="width: 555px" value="${loanbean.loanPurpose}"/>
									</td>
								</tr>
								<tr>
									<td class="td1"><span class="style1">*</span>预计冲账时间</td>
									<td class="td2" colspan="4">
										<input id="F_estChargeTime" name="estChargeTime" class="easyui-datebox" type="text" readonly="readonly" required="required"  style="width: 200px" value="${loanbean.estChargeTime}"/>
									</td>
								</tr>
							</table>
						</div>							
						<div title="借款人信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
							<jsp:include page="../../expend/payee-info-detail.jsp" />
						</div>							
						<div title="还款信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
							<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
								<tr>
									<td class="td1"><span class="style1">*</span>登记人</td>
									<td class="td2">
										<input id="F_foperateUser" name="foperateUser" class="easyui-textbox" type="text" readonly="readonly" required="required"   style="width: 200px" value="${repaybean.foperateUser}"/>
									</td>
									<td class="td4"></td>
									<td class="td1"><span class="style1">*</span>还款时间</td>
									<td class="td2">
										<input id="F_foperateTime" name="foperateTime"  required="required"  class="easyui-datebox" style="width: 200px" value="${repaybean.foperateTime}" />
									</td>
								</tr>
								<tr>
									<td class="td1"><span class="style1">*</span>还款金额</td>
									<td class="td2" colspan="4">
										<input id="F_famount" name="famount"  class="easyui-textbox" required="required"  data-options="iconWidth: 22,icons: [{iconCls:'icon-yuan',handler: function(e){}}]" style="width: 200px" value="${repaybean.famount}" />
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1">
										&nbsp;&nbsp;附件
										<input type="file" multiple="multiple" id="f" onchange="upladFile(this,null,'srgl01')" hidden="hidden">
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
												<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
												&nbsp;&nbsp;&nbsp;&nbsp;
												<img src="${base}/resource-modality/${themenurl}/sccg.png">
												&nbsp;&nbsp;&nbsp;&nbsp;
												<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
											</div>
										</c:forEach>
										</td>
								</tr>
								<tr></tr>
								<tr></tr>
								
							</table>
						</div>							
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveRepayMent()">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
	</div>
</form>
</div>
	<script type="text/javascript">
	//保存
	function saveRepayMent() {	
		
		//附件的路径地址
		var s="";
		$(".fileUrl").each(function(){
			s=s+$(this).attr("id")+",";
		});
		$("#files").val(s);
		
		//提交
		$('#re_capital_save_form').form('submit', {
			onSubmit : function() {
				flag = $(this).form('enableValidation').form('validate');
				if (flag) {
					$.messager.progress();
				}
				return flag;
			},
			url : base + '/srcapital/save',
			success : function(data) {
				if (flag) {
					$.messager.progress('close');
				}
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					$("#re_capital_save_form").form("clear"); 
					$("#capitalTab").datagrid("reload");
				} else {
					$.messager.alert('系统提示', data.info, 'error');
					closeWindow();
					$('#re_capital_save_form').form('clear');
				}
			}
		}); 	
	}
	
	
	</script>
</body>
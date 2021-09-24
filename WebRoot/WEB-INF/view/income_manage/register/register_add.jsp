<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<form id="re_arrive_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 451px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div" id="easyAcc">
			<!-- 隐藏域 --> 
			<!-- 主键id --><input type="hidden" name="fincomeId" id="F_fincomeId" value="${bean.fincomeId}"/>
			<!-- 数据状态 --><input type="hidden" id="F_fstauts" name="fstauts" value="${bean.fstauts}" />
			<!-- 立项单id --><input type="hidden" id="fBusiId" name="fBusiId" value="${bean.fBusiId}" />
			<!-- 审批状态 -->
			<input type="hidden" id="F_fFlowStatus" name="fFlowStauts" value="${bean.fFlowStauts }" />
			<!-- 申请部门id -->
			<input type="hidden" id="F_fDeptId" name="fregisterDepartId" value="${bean.fregisterDepartId }" />
			<!-- 下节点审批人id -->
			<input type="hidden" name="fUserCode" value="${bean.fUserCode }" />
			<!-- 下节点审批人姓名 -->
			<input type="hidden" name="fUserName" value="${bean.fUserName }" />
			<!-- 下节点编码 -->
			<input type="hidden" name="fNCode" value="${bean.fNCode }" />
				<div class="easyui-accordion"  style="margin-left: 20px;margin-right: 20px;">
					<div title="基本信息" data-options="collapsible:false" style="overflow:auto;">
						<table class="win-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;登记编号</td>
								<td class="td2">
									<input id="F_fincomeNum" class="easyui-textbox" type="text" readonly="readonly" required="required" name="fincomeNum" data-options="validType:'length[1,30]'" style="width: 212px" value="${bean.fincomeNum}"/>
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;登记日期</td>
								<td class="td2">
									<input class="easyui-datebox" id="F_fregisterTime" name="fregisterTime" readonly="readonly" required="required" data-options="validType:'length[1,30]',editable:false" style="width: 212px" value="${bean.fregisterTime}"/>
								</td>			
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;登记部门</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fregisterDepart" name="fregisterDepart" readonly="readonly" required="required" data-options="validType:'length[1,30]',editable:false" style="width: 212px" value="${bean.fregisterDepart}"/>
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;登记人</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fregisterPerson" name="fregisterPerson" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 212px" value="${bean.fregisterPerson}"/>
									<input hidden="hidden" id="F_fregisterPersonId" name="fregisterPersonId" value="${bean.fregisterPersonId}"/>
								</td>
							</tr>
										
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;立项项目名称</td>
								<td class="td2" onclick="chooseProject()" colspan="4">
									<input id="fproName" class="easyui-textbox" type="text" name="fproName" data-options="editable:false" required="required" style="width: 555px" value="${bean.fproName}"/>
								</td>
							</tr>
										
							<tr class="trbody">	
								<td class="td1"><span class="style1">*</span>收费标准</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_fPlanPrice" name="fPlanPrice" readonly="readonly" required="required" data-options="validType:'length[1,500]',multiline:true" style="width: 555px; height: 70px" value="${bean.fPlanPrice}"/>
								</td>
							</tr>
							<tr style="height: 5px;"></tr>
							<tr class="trbody">	
								<td class="td1"><span class="style1">*</span>收费依据</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_fProPlan" name="fProPlan" readonly="readonly" required="required" data-options="validType:'length[1,500]',multiline:true" style="width: 555px; height: 70px" value="${bean.fProPlan}"/>
								</td>
							</tr>
							<tr style="height: 5px;"></tr>
							<tr class="trbody">	
								<td class="td1">论证资料</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_fRemark" name="fRemark" readonly="readonly" data-options="validType:'length[1,500]',multiline:true" style="width: 555px; height: 70px" value="${bean.fRemark}"/>
								</td>
							</tr>
							<%-- <tr style="height: 5px;"></tr>
							<tr class="trbody">	
								<td class="td1"><span class="style1">*</span>依据及简要说明</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_fRemark" name="fRemark" required="required" data-options="validType:'length[1,500]',multiline:true" style="width: 555px; height: 70px" value="${bean.fRemark}"/>
								</td>
							</tr> --%>
							
							
							
							<tr class="trbody">
								<td class="td1">
									&nbsp;&nbsp;附件
									<input type="file" multiple="multiple" id="f_business" onchange="upladFile(this, 'business', 'business01')" hidden="hidden">
									<input type="text" id="files" name="files" hidden="hidden">
								</td>
								<td colspan="4" id="tdf">
									<a onclick="$('#f_business').click()" style="font-weight: bold;" href="#">
										<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
									</a>
									<c:forEach items="${businessAttaList }" var="att">
										<c:if test="${att.serviceType=='business' }">
										<div style="margin-top: 10px;">
											<a href='${base}/attachment/download/${att.id }' style="color: #666666;font-weight: bold;">${att.originalName }</a>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<a id="${att.id }" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
										</div>
										</c:if>
									</c:forEach>
									<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
										<div id="progressNumber" style="background:#3AF960;width:0px;height:10px"></div>
										文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>			
					<!-- 来款明细-->
				<div  class="easyui-accordion"  style="margin-left: 20px;margin-right: 20px;">
					<div title="应收款项明细" data-options="collapsible:false"
						style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px">
						<jsp:include page="mingxi_list.jsp" /> 
						</div>
					</div>
				</div>
			</div>
			
			<div class="win-left-bottom-div" style="margin-top: 15px;">
				<a href="javascript:void(0)" onclick="saveIncome(0)">
					<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveIncome(1)">
					<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		<div class="window-right-div" style="width:254px;height: auto">
			<jsp:include page="../../check_system.jsp" />
		</div>
	</div>
</form>
<script type="text/javascript">
	$(document).ready(function(){
		var myDate = new Date();
		myDate = myformatter(myDate);
		$('#F_fregisterTime').textbox().textbox('setValue',myDate);
	});
	
	//选择项目
	function chooseProject(){
		var win = creatFirstWin('选择-立项项目', 740, 580, 'icon-search', '/srregister/choosePxProject');
		win.window('open');
	}
	
	
	//保存
	function saveIncome(flowStauts) {
		//设置数据状态
		$('#F_fstauts').val(flowStauts);
		//设置审批状态
		$('#F_fFlowStatus').val(flowStauts);
		accept1();
		var rows2 = $('#mingxi-dg').datagrid('getRows');
		var mingxiJson = "";
		for (var i = 0; i < rows2.length; i++) {
			mingxiJson = mingxiJson + JSON.stringify(rows2[i]) + ",";
		}
		$('#mingxiJson').val(mingxiJson);
	 	//提交
		$('#re_arrive_form').form('submit', {
			onSubmit : function() {
				flag = $(this).form('enableValidation').form('validate');
				if (flag) {
					$.messager.progress();
				}
				return flag;
			},
			url : base + '/srregister/save',
			success : function(data) {
				if (flag) {
					$.messager.progress('close');
				}
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$("#re_arrive_form").form("clear");  //带着新增完毕不能查询
					$("#registerTab").datagrid("reload");
					closeWindow();
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});  
	}
</script>
</body>
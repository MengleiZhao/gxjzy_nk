<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="confplan_add_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="" style="width:662px;margin-left: 20px">
					<div title="下达信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;审核人</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fapproveUserName" name="fapproveUserName" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fapproveUserName}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>&nbsp;审核时间</td>
								<td class="td2">
									<input class="easyui-datebox" id="F_fapproveTime" name="fapproveTime" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fapproveTime}"/>
								</td>
							</tr>
							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>&nbsp;审核意见</td>
								<td colspan="4">
									<textarea class="textbox-text" id="F_fapproveIdea" name="fapproveIdea" readonly="readonly" required="required" oninput="textareaNum(this,'textareaNum3')" autocomplete="off" style="width:555px;height:70px;resize:none">${bean.fapproveIdea }</textarea>
								</td>
							</tr>
						</table>
					</div>
					<!-- 第一个div -->
					<div title="配置计划信息" id="pzjhdiv" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" collapsible="false" class="ourtable" border="0">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;采购计划编号</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_flistNum" name="flistNum" readonly="readonly" required="required" data-options="validType:'length[1,50]'" style="width:200px;" value="${bean.flistNum}"/>
								</td>
								<td class="td4">
									<!--隐藏域  -->
									<!-- 上报阶段  1：一上   2：二上 -->
									<input type="hidden" id="cgconfplan_list_freportStage" name="freportStage" value="${bean.freportStage }" />
									
									<!-- 主键 -->					<input type="hidden" name="fplId" id="F_fplId" value="${bean.fplId}"/>
									<!-- 当前申报人id -->			<input type="hidden" name="freqUserId" value="${bean.freqUserId}" />
									<!-- 当前申报部门id -->		<input type="hidden" name="freqDeptId" value="${bean.freqDeptId}" />
									
									<!-- 采购的选择状态  -->			<input type="hidden" name="fisChecked" id="F_fisChecked" value="${bean.fisChecked}" />
									<!-- 数据状态  -->				<input type="hidden" name="fstauts" id="F_fstauts" value="${bean.fstauts}" />
									<!-- 配置申请的审批状态  -->		<input type="hidden" name="fcheckStauts" id="F_fcheckStauts" value="${bean.fcheckStauts}"/>
									
									<!-- 项目支出明细id -->		<input type="hidden" name="pid" id="F_pid" value="${bean.pid}" />
									<!-- 项目支出明细编码  -->		<input type="hidden" name="expCode" id="F_expCode" value="${bean.expCode}" />
									<!-- 项目支出明细科目编码  -->		<input type="hidden" name="subCode" id="F_subCode" value="${bean.subCode}" />
									
									<!-- 指标id -->				<input type="hidden" name="indexId" id="F_indexId" value="${bean.indexId}" />
									<!-- 指标编码 -->				<input type="hidden" name="indexCode" id="F_indexCode" value="${bean.indexCode}" />
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;申请部门</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_freqDept" name="freqDept" readonly="readonly" required="required" data-options="validType:'length[1,25]'" style="width: 200px" value="${bean.freqDept}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>&nbsp;申请日期</td>
								<td class="td2">
									<input class="easyui-datebox" id="F_freqTime" name="freqTime" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.freqTime}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>&nbsp;配置采购类型</td>
								<td class="td2">
									<select class="easyui-combobox" id="F_fprocurType" name="fprocurType" readonly="readonly" required="required" style="width: 200px;" data-options="editable:false,panelHeight:'auto'" validType="selectValueRequired['#test']">
										<option value="A10" <c:if test="${bean.fprocurType=='A10'}">selected="selected"</c:if>>货物</option>
										<option value="A20" <c:if test="${bean.fprocurType=='A20'}">selected="selected"</c:if>>工程</option>
										<option value="A30" <c:if test="${bean.fprocurType=='A30'}">selected="selected"</c:if>>服务</option>
										<option value="A40" <c:if test="${bean.fprocurType=='A40'}">selected="selected"</c:if>>办公用品及耗材</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>&nbsp;申请人</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_freqLinkMen" name="freqLinkMen" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.freqLinkMen}"/>
								</td>
								<td class="td4"></td>
								<td class="td1">&nbsp;&nbsp;联系人电话</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_flinkTel" name="flinkTel" readonly="readonly" style="width: 200px" value="${bean.flinkTel}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>&nbsp;预算明细</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_subName" name="subName" readonly="readonly" required="required" data-options="icons: [{iconCls:'icon-sousuo'}]" style="width: 555px" value="${bean.subName}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>&nbsp;预算金额</td>
								<td class="td2">
									<input class="easyui-numberbox" id="F_outAmount" name="outAmount" readonly="readonly" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]" style="width: 200px" value="${bean.outAmount}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>&nbsp;一上申报金额</td>
								<td class="td2">
									<input class="easyui-numberbox" id="F_purFirstAmount" name="purFirstAmount" readonly="readonly" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]" style="width: 200px" value="${bean.purFirstAmount}"/>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;支出项目</td>
								<td colspan="4">
									<a onclick="openIndex()">
										<input class="easyui-textbox" id="F_indexName" name="indexName" data-options="prompt: '选择指标',editable:false,icons: [{iconCls:'icon-sousuo'}]" style="width: 555px;" value="${bean.indexName}"/>
									</a>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>&nbsp;指标可用金额</td>
								<td class="td2">
									<input class="easyui-numberbox" id="F_syAmount" name="syAmount" readonly="readonly" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]" style="width: 200px" value="${bean.syAmount}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>&nbsp;二上申报金额</td>
								<td class="td2">
									<input class="easyui-numberbox" id="F_purSecondAmount" name="purSecondAmount" readonly="readonly" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]" style="width: 200px" value="${bean.purSecondAmount}"/>
								</td>
							</tr>
							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>&nbsp;配置申请内容</td>
								<td colspan="4">
									<textarea class="textbox-text" id="F_freqContent" name="freqContent" readonly="readonly" oninput="textareaNum(this,'textareaNum1')" autocomplete="off" style="width:555px;height:70px;resize:none">${bean.freqContent }</textarea> 
								</td>
							</tr>
							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px">&nbsp;&nbsp;备注</td>
								<td colspan="4">
									<textarea class="textbox-text" id="F_fremark" name="fremark" readonly="readonly" oninput="textareaNum(this,'textareaNum2')" autocomplete="off" style="width:555px;height:70px;resize:none">${bean.fremark }</textarea>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1">附件</td>
								<td colspan="4">
									<c:if test="${!empty attac}">
										<c:forEach items="${attac}" var="att">
											<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a></br>
										</c:forEach>
									</c:if>
									<c:if test="${empty attac}">
										<span style="color:#999999">暂未上传附件</span>
									</c:if>
								</td>
							</tr>
						</table>
					</div>
					<!-- 第二个div -->
					<div title="配置采购商品清单"  id="pzcgspqddiv" data-options="collapsed:false,collapsible:false,iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
				  		<%@include file="../mingxi/cgconf_plan.jsp" %>												
					</div>
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveConfplan(21)">
					<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				<%-- &nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=资产管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a> --%>
			</div>
		</div>
	
		<div class="win-right-div" id="check-system-tab" data-options="region:'east',split:true">
			<jsp:include page="../../../check_system.jsp" />
		</div>
	</div>
</form>
</div>
<script type="text/javascript">
$(document).ready(function() {  //更改采购类型清空商品清单
		/* $('#F_fprocurType').combobox({
			onChange:function(newVal, oldVal) {
				if(newVal != oldVal){
			    	var rows = $('#dg').datagrid('getRows');
					 if(rows == ''){
						return;
					}else {
						$.messager.confirm('提示','您所选择的采购类型与商品清单的商品不一致，是否确定使用新的采购类型?',function(r){
						    if (r){//清空清单信息 重新选择
						    	for (var i = rows.length - 1; i >= 0; i--) {
				                   	 	var index = $('#dg').datagrid('getRowIndex', rows[i]);
				                    	$('#dg').datagrid('deleteRow', index);
				               		 }
						   		 }
						    });
						$.messager.confirm({
						    width:380,
						    height:180, 
						    title:'提示',
						    msg:'您所选择的采购类型与商品清单的商品不一致，是否确定使用新的采购类型？',
						    fn:function(r) {
						    	if(r){//确定 清空商品清单
						    		for (var i = rows.length - 1; i >= 0; i--) {
				                   	 	var index = $('#dg').datagrid('getRowIndex', rows[i]);
				                    	$('#dg').datagrid('deleteRow', index);
				               		}
						    	}else {//取消  不操作
						    		return;
						    	}
							}
						});
					} 
				}
			}
		}); */
});

//保存
function saveConfplan(fcheckStauts) {
	//设置审批状态
	$('#F_fcheckStauts').val(fcheckStauts);
	
	//在后台反序列话成采购明细Json的对象集合
	getMingxiJson();
	
	//二上申报金额
	var purSecondAmount = $('#F_purSecondAmount').val();
	if(purSecondAmount == "" || purSecondAmount == "0.00"){
		alert("请配置采购商品清单！");
		return;
	}
	
	//送审状态
	if(fcheckStauts == '21'){
		var purSecondAmount = parseFloat($('#F_purSecondAmount').numberbox('getValue'));
		var syAmount = parseFloat($('#F_syAmount').numberbox('getValue'));
		//判断指标可用金额
		if(isNaN(syAmount)){
			alert("请选择支出项目！");
			return;
		}
		//比较二上申报金额与指标可用金额
		if(purSecondAmount > syAmount){
			alert("二上申报金额不得大于指标可用金额，请重新填写！");
			return;
		}
	}
	
	//提交
	$('#confplan_add_form').form('submit', {
		onSubmit:function() {
			flag = $(this).form('enableValidation').form('validate');
			if(flag) {
				$.messager.progress();
			}else {
				//校验不通过，就打开第一个校验失败的手风琴
				openAccordion();
			}
			return flag;
		},
		url:base + '/cgconfplan/secondSave',
		success:function(data) {
			if(flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if(data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#confplan_tab').datagrid('reload');
				$('#indexdb').datagrid('reload');
				closeWindow();
			}else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});  
}

//打开指标选择页面
function openIndex() {
	var win = creatFirstWin('类型选择', 840, 580, 'icon-search', '/cgconfplan/chooseIndex');
	win.window('open');
}

//刷新流程
$('#F_purSecondAmount').numberbox({
	onChange:function(){
		//主键id
		var plId = $('#F_fplId').val();
		//二上申报金额（明细赋值）
		var purSecondAmount = $('#F_purSecondAmount').numberbox('getValue');
		$('#check-system-tab').load('${base}/cgconfplan/secondRefreshProcess?fplId='+plId+'&purSecondAmount='+purSecondAmount);
	}
});
</script>
</body>
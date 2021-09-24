<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="confplan_add_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="" style="width:662px;margin-left: 20px">
					<!-- 第一个div -->
					<div title="基本信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" collapsible="false" class="ourtable" border="0">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;采购计划编号</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_flistNum"  name="flistNum"  style="width:200px;" readonly="readonly" required="required" data-options="validType:'length[1,50]'" value="${bean.flistNum}"/>
								</td>
								<td class="td4">
									<!-- 隐藏域 -->
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
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;申请部门</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_freqDept"  name="freqDept" readonly="readonly" required="required" data-options="validType:'length[1,25]'" style="width: 200px" value="${bean.freqDept}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>&nbsp;申请日期</td>
								<td class="td2">
									<input class="easyui-datebox" type="text" id="F_freqTime"   name="freqTime" readonly="readonly" required="required" data-options="editable:false,validType:'length[1,20]'" style="width: 200px" value="${bean.freqTime}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>&nbsp;配置采购类型</td>
								<td class="td2">
									<select class="easyui-combobox" id="F_fprocurType"  name="fprocurType" required="required" style="width: 200px;" data-options="editable:false,panelHeight:'auto'" validType="selectValueRequired['#test']">
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
									<input class="easyui-textbox" id="F_freqLinkMen"  name="freqLinkMen"   readonly="readonly" required="required"  data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.freqLinkMen}"/>
								</td>
								<td class="td4"></td>
								<td class="td1">&nbsp;&nbsp;联系人电话</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_flinkTel"  name="flinkTel"  style="width: 200px" value="${bean.flinkTel}"/>
								</td>
							</tr>
							<tr >
								<td class="td1"><span class="style1">*</span>&nbsp;预算明细</td>
								<td colspan="4">
									<a onclick="chooseExpend()">
										<input class="easyui-textbox" id="F_subName" name="subName" data-options="prompt:'选择预算支出明细',editable:false,icons: [{iconCls:'icon-sousuo'}]" style="width: 555px" value="${bean.subName}"/>
									</a>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>&nbsp;预算金额</td>
								<td class="td2">
									<input class="easyui-numberbox" id="F_outAmount"  name="outAmount" readonly="readonly" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]" style="width: 200px" value="${bean.outAmount}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>&nbsp;一上申报金额</td>
								<td class="td2">
									<input class="easyui-numberbox" id="F_purFirstAmount"  name="purFirstAmount" readonly="readonly" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]" style="width: 200px" value="${bean.purFirstAmount}"/>
								</td>
							</tr>
							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>&nbsp;申请理由</td>
								<td colspan="4">
									<textarea name="freqContent"  id="F_freqContent"  class="textbox-text" required="required" oninput="textareaNum(this,'textareaNum1')" autocomplete="off"   style="width:555px;height:70px;resize:none">${bean.freqContent }</textarea> 
								</td>
							</tr>
							<c:if test="${openType=='add'||openType=='edit'}">
								<tr>
									<td align="right" colspan="5" style="padding-right: 0px;">
									可输入剩余数：<span id="textareaNum1" class="200">
										<c:if test="${empty bean.freqContent}">200</c:if>
										<c:if test="${!empty bean.freqContent}">${200-bean.freqContent.length()}</c:if>
									</span>
									</td>
								</tr>
							</c:if>
							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px">&nbsp;&nbsp;备注</td>
								<td colspan="4">
									<textarea name="fremark"  id="F_fremark"  class="textbox-text"  oninput="textareaNum(this,'textareaNum2')" autocomplete="off"   style="width:555px;height:70px;resize:none">${bean.fremark }</textarea>
									<%-- <input class="easyui-textbox" type="text" id="F_fremark"  name="fremark"  data-options="validType:'length[1,250]',multiline:true"   style="width:555px;height:70px;" value="${bean.fremark}"/> --%>
								</td>
							</tr>
							<c:if test="${openType=='add'||openType=='edit'}">
								<tr>
									<td align="right" colspan="5" style="padding-right: 00px;">
									可输入剩余数：<span id="textareaNum2" class="200">
										<c:if test="${empty bean.fremark}">200</c:if>
										<c:if test="${!empty bean.fremark}">${200-bean.fremark.length()}</c:if>
									</span>
									</td>
								</tr>
							</c:if>
							<tr class="trbody">
								<td class="td1">
									&nbsp;&nbsp;附件
									<input type="file" multiple="multiple" id="f" onchange="upladFile(this,'cggl','cggl01')" hidden="hidden">
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
						</table>
					</div>
					<!-- 第二个div -->
					<div title="配置采购商品清单"  id="pzcgspqddiv" data-options="collapsed:false,collapsible:false,iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
				  		<%@include file="../mingxi/cgconf_plan.jsp" %>												
					</div>
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveConfplan(0)">
					<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveConfplan(1)">
					<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a><%-- &nbsp;&nbsp;
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
$(document).ready(function () {  
		//更改采购类型清空商品清单
		/* $("#F_fprocurType").combobox({
			onChange: function (newVal,oldVal) {
				if(newVal!=oldVal){
			    	var rows = $("#dg").datagrid("getRows");
					 if(rows==""){
						return false;
					}else{
						/* $.messager.confirm('提示','您所选择的采购类型与商品清单的商品不一致，是否确定使用新的采购类型?',function(r){
						    if (r){//清空清单信息 重新选择
						    	for (var i = rows.length - 1; i >= 0; i--) {
				                   	 	var index = $('#dg').datagrid('getRowIndex', rows[i]);
				                    	$('#dg').datagrid('deleteRow', index);
				               		 }
						   		 }
						    }); */
						/*$.messager.confirm({
						    width: 380,
						    height: 180, 
						    title: '提示',
						    msg: '您所选择的采购类型与商品清单的商品不一致，是否确定使用新的采购类型？',
						    fn: function (r) {
						    	if (r){//确定 清空商品清单
						    		for (var i = rows.length - 1; i >= 0; i--) {
				                   	 	var index = $('#dg').datagrid('getRowIndex', rows[i]);
				                    	$('#dg').datagrid('deleteRow', index);
				               		 }
						    	   }else{//取消  不操作
						    		  return false;
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
	//设置数据状态
	$('#F_fstauts').val(fcheckStauts);
	
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);
	
	//在后台反序列话成采购明细Json的对象集合
	getMingxiJson();
	
	/* //校验
	//项目支出明细是否被重复选择
	var pid = $('#F_pid').val();
	var checkFlag = 0;	//重复标记 0-未重复	1-重复
	$.ajax({ 
		type: 'POST',
		async: false, 	//取消异步
		url: '${base}/cgconfplan/checkPid?pid='+pid,
		dataType: 'json',
		contentType: "application/json;charset=UTF-8",
		success: function(data){
			if(data.success){
				checkFlag = 0;	
			}else {
				checkFlag = 1;
			}
		} 
	});
	if(checkFlag == 1){
		alert("此项目支出明细已被关联，请勿重复上报!");
		return;
	} */
	
	//一上申报金额
	var purFirstAmount = $('#F_purFirstAmount').val();
	if(purFirstAmount == "" || purFirstAmount == "0.00"){
		alert("请配置采购商品清单！");
		return;
	}
	
	//送审状态
	if(fcheckStauts == '1'){
		var purFirstAmount = parseFloat($('#F_purFirstAmount').numberbox('getValue'));
		var outAmount = parseFloat($('#F_outAmount').numberbox('getValue'));
		//判断预算金额
		if(isNaN(outAmount)){
			alert("请选择预算明细！");
			return;
		}
		//比较采购预算金额与预算明细金额
		if(purFirstAmount > outAmount){
			alert("一上申报金额不得大于预算金额，请重新填写！");
			return;
		}
	}
	
	//提交
	$('#confplan_add_form').form('submit', {
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
		url : base + '/cgconfplan/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#confplan_tab').datagrid('reload');
				$('#indexdb').datagrid('reload');
				closeWindow();
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});  
}

//打开选择预算支出明细页面
function chooseExpend(){
	var win = parent.creatFirstWin('预算', 840, 580, 'icon-search', '/cgconfplan/probyProLibType');
	win.window('open');
}

//刷新流程
$('#F_fprocurType').combobox({
	onChange:function(){
		//采购类型
		var fprocurType = $('#F_fprocurType').combobox('getValue');
		$('#check-system-tab').load('${base}/cgconfplan/refreshProcess?fprocurType='+fprocurType);
	}
});
</script>
</body>
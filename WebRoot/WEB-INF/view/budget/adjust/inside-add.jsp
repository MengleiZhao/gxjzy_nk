<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
		
<body>
<div class="win-div">
<form id="inside_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 609px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div" style="height: 450px;">
				<div class="easyui-accordion" data-options="" id="easyAcc" style="width:662px;margin-left: 20px">
					<div title="指标调整信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
						<div id="" style="margin-top: 10px;">
							<table cellpadding="0" cellspacing="0" class="ourtable">
								<tr class="trbody">
									<td class="td1"><span class="style1">*</span>&nbsp;调整类型</td>
									<td class="td2">
										<input class="easyui-combobox" style="width: 200px;" id="changeType" name="changeType" data-options="editable:false,valueField: 'value',
                   								    textField: 'label',
                                                    data: [{
                                                        label: '内部预算指标调剂',
                                                        value: 'NBYSZBTJ'
                                                        <c:if test="${bean.changeType == 'NBYSZBTJ' or  empty bean.changeType}">,selected:true</c:if>
                                                    },{
                                                        label: '年终追加项目',
                                                        value: 'BMYSZBTZ'
                                                        <c:if test="${bean.changeType == 'BMYSZBTZ'}">,selected:true</c:if>
                                                    },{
                                                        label: '外部预算指标调整',
                                                        value: 'WBYSZBTZ'
                                                        <c:if test="${bean.changeType == 'WBYSZBTZ'}">,selected:true</c:if>
                                                    }],
                                                    onSelect: function(rec){
                                                        changeType(rec);
                                                    }">
									</td>
									<td class="td1"><span class="style1">*</span>&nbsp;指标类型</td>
									<td class="td2">
										<input class="easyui-combobox" id="indexType" name="indexType" style="width: 200px;height: 30px;margin-left: 10px " data-options="editable:false,url:'${base}/Formulation/lookupsJson?parentCode=YSLX&selected=${bean.indexType}',method:'POST',valueField:'code',textField:'text'">
									</td>
								</tr>
								<tr class="trbody" id="hideTr">
									<td class="td1"><span class="style1">*</span>&nbsp;是否跨部门调整</td>
									<td class="td2">
										<input type="radio" name="isAcrossDept"  readonly="readonly" <c:if test="${bean.isAcrossDept=='1'}">checked="checked"</c:if> value="1" onclick="acrossYes()">是
         								<input type="radio" name="isAcrossDept"  readonly="readonly" <c:if test="${bean.isAcrossDept!='1'}">checked="checked"</c:if> value="0" onclick="acrossNo()">否
									</td>
									<td class="td4" colspan="3"></td>
								</tr>
							</table>
						</div>
						<div style="height:30px">
							<span><strong>调增指标:</strong></span>
						</div>
						<div>
							<jsp:include page="inside/zbdr.jsp" />
						</div>
						</br>
						<div style="height:30px">
							<span><strong>调减指标:</strong></span>
						</div>
						<div>
							<jsp:include page="inside/zbdc.jsp" />
						</div>
						<div id="jbxx" style="margin-top: 10px;">
							<table cellpadding="0" cellspacing="0" class="ourtable">
								<tr class="trbody">
									<td class="td1"><span class="style1">*</span>&nbsp;申请人</td>
	
									<td class="td2"><input style="width: 200px;" id=""
										name="opUser" class="easyui-textbox"
										value="${bean.opUser}" readonly="readonly"></input>
									</td>
									
									<td class="td4">
										<!-- 主键ID --><input type="hidden" name="inId" value="${bean.inId}" />
										<!-- 调减部门ID --><input type="hidden" id="insideDeptId" name="insideDeptId" value="${bean.insideDeptId}" />
										<!-- 编码 --><input type="hidden" name="inCode" value="${bean.inCode}" />
										<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="insideflowStauts" />
										<!-- 申请状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="insideStauts" />
										<!-- 调减指标使用类型 --><input type="hidden" name="proUseType" value="${bean.proUseType}" id="proUseType" />
										<!-- 调整金额 --><input type="hidden" name="amount" value="${bean.amount}" id="amount" />
									</td>
	
									<td class="td1"><span class="style1">*</span>&nbsp;申请日期</td>
									<td class="td2"><input style="width: 200px;"
										id="insideOpTime" name="opTime" class="easyui-datebox"
										value="${bean.opTime}" readonly="readonly"></input>
									</td>
								</tr>
								
								<%-- <tr class="trbody" hidden="hidden" id="tjbm">
									<td class="td1">&nbsp;&nbsp;调减部门</td>
									<c:if test="${openType=='add' }">
										<td colspan="4">
											<input class="easyui-combobox" style="width: 555px;" id="inside_departId" name="insideDeptId" data-options="editable:false,panelHeight:'auto',
												url:'${base}/depart/chooseDepart',
												method:'POST',
												valueField:'code',
												textField:'text',
												onSelect: function(rec){
													$('#inside_departName').val(rec.text);
												}
												"/>
										</td>	
									</c:if>
									<c:if test="${openType=='edit' }">
										<td colspan="4">
											<input class="easyui-combobox" style="width: 555px;" id="inside_departId" name="insideDeptId" data-options="editable:false,panelHeight:'auto',
												url:'${base}/depart/chooseDepart?selected=${bean.insideDeptId }',
												method:'POST',
												valueField:'code',
												textField:'text',
												onSelect: function(rec){
													$('#inside_departName').val(rec.text);
												}
												"/>
										</td>
									</c:if>
									
									<td class="td4">
										<!-- 调减部门名称 --><input type="hidden" id="inside_departName" value="" />
									</td>
								</tr> --%>
								<tr style="height: 70px;">
									<td class="td1" valign="top">&nbsp;&nbsp;申请事由</td>
									<td colspan="4">
										<%-- <input class="easyui-textbox" data-options="multiline:true" name="appDesc" style="width:555px;height:60px" value="${bean.appDesc}"> --%>
										
										<textarea name="appDesc" class="textbox-text" oninput="textareaNum(this,'textareaNum1')"
										autocomplete="off"  style="width:555px;height:60px;resize:none">${bean.appDesc }</textarea>
									</td>
								</tr>
								<tr>
									<td align="right" colspan="5">
									可输入剩余数：<span id="textareaNum1" class="200">200</span>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<div class="easyui-accordion" data-options="" style="width:662px;margin-left: 20px">
				<div title="附件信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
					<table cellpadding="0" cellspacing="0" class="ourtable">
						<tr>
							<td class="td1" style="width:55px;text-align: left"><!-- <span class="style1">*</span> -->
								附件
								<input type="file" multiple="multiple" id="f" onchange="upladFile(this,null,'zcgl01')" hidden="hidden">
								<input type="text" id="files" name="files" hidden="hidden">
							</td>
							<td colspan="3" id="tdf">
								&nbsp;&nbsp;
								<a onclick="$('#f').click()" style="font-weight: bold;  " href="#">
									<img style="vertical-align:bottom;margin-bottom: 5px;" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
								</a>
								<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
									<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
									 </div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
								</div>
								<c:forEach items="${attaList}" var="att">
									<div style="margin-top: 5px;">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<img style="margin-top: 5px;" src="${base}/resource-modality/${themenurl}/sccg.png">
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
				<a href="javascript:void(0)" onclick="saveInside(0)">
					<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveInside(1)">
					<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<%-- <a href="${base }/systemcentergl/list?typeStr=预算管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a> --%>
			</div>
		</div>
	
		<div class="win-right-div" id="check-system-table" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div>
	</div>
</form>
</div>	
	
<script type="text/javascript">
var index = 0;
function acrossYes(){
	deleteAllRows();
	$('#snum1').textbox('setValue',0.00);
	$('#snum2').textbox('setValue',0.00);
	$('#snum3').textbox('setValue',0.00);
}
function acrossNo(){
	deleteAllRows();
	$('#snum1').textbox('setValue',0.00);
	$('#snum2').textbox('setValue',0.00);
	$('#snum3').textbox('setValue',0.00);
}
function changeType(res){
	deleteAllRows();
	if(res.value == 'NBYSZBTJ'){
		$("#hideTr").show();
	}else{
		$("#hideTr").hide();
	}
	if(index != 0){
		$('#snum1').textbox('setValue',0.00);
		$('#snum2').textbox('setValue',0.00);
		$('#snum3').textbox('setValue',0.00);
	}
	index++;
	$('#check-system-table').load('${base}/insideAdjust/refreshProcess?fpPype='+res.value+'&id=${bean.inId}');
}

$(document).ready(function() {
	//设值调整时间
	if ($("#insideOpTime").textbox().textbox('getValue') == "") {
		$("#insideOpTime").textbox().textbox('setValue', 'date');
	}
});

//保存
function saveInside(flowStauts) {
	var num = parseFloat($('#snum2').textbox('getValue'));
	var snum = parseFloat($('#snum3').textbox('getValue'));
	if(num==0||snum!=0){
		alert('请核对调入调出金额');
	} else {
		$('#zbdc').datagrid('acceptChanges');
		$('#zbdr').datagrid('acceptChanges');
		
		
		// 在后台反序列话成调入调出指标的Json对象集合
		
		var rows1 = $('#zbdc').datagrid('getRows');
		var j1 = "";
		for (var i = 0; i < rows1.length; i++) {
			j1 = j1 + JSON.stringify(rows1[i]) + ",";
		}
		
		var rows2 = $('#zbdr').datagrid('getRows');
		var j2 = "";
		for (var i = 0; i < rows2.length; i++) {
			j2 = j2 + JSON.stringify(rows2[i]) + ",";
		}
		if(rows1[0].indexType != rows2[0].indexType){
			alert("基本支出指标和项目支出指标间不可调整!");
			return;
		}
		$('#insideDcJson').val(j1);
		$('#insideDrJson').val(j2);
		
		//设置审批状态
		$('#insideflowStauts').val(flowStauts);
		//设置申请状态
		$('#insideStauts').val(flowStauts);

		//提交
		$('#inside_save_form').form('submit', {
			onSubmit : function() {
				flag = $(this).form('enableValidation').form('validate');
				if (flag) {
					$.messager.progress();
				}
				return flag;
			},
			url : base + '/insideAdjust/save',
			success : function(data) {
				if (flag) {
					$.messager.progress('close');
				}
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					$('#insideTab').datagrid('reload');
					$('#indexdb').datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
					/* closeWindow();
					$('#inside_save_form').form('clear'); */
				}
			}
		});
	}
	
}

//刷新流程
$("#inside_departId").combobox({
	onChange:function(){
		//所有行
		var rows = $("#zbdc").datagrid("getRows");
		//行数为空，没有选择调减指标
		if(rows == ''){
			$('#inside_departId').combobox('setValue', '');
			alert("请先选择指标！");
			return;
		}
		
		//调减部门名称
		var insideDeptName = $("#inside_departName").val();
		//更新页面上的调减部门
		for(i = 0; i < rows.length; i++){
			$('#zbdc').datagrid('updateRow',{
				index: i,
				row: {
					deptName: insideDeptName
				}
			});
		}
		//调减部门id
		var insideDeptId = $("#inside_departId").val();
		$("#check-system-table").load("${base}/insideAdjust/refreshProcess?insideDeptId="+insideDeptId);
	}
});

function deleteAllRows(){
	var item = $('#zbdc').datagrid('getRows');//获取类表中全部数据
	if (item) {
		for (var i = item.length - 1; i >= 0; i--) {
			var index = $('#zbdc').datagrid('getRowIndex', item[i]);
			$('#zbdc').datagrid('deleteRow', index);
		}
	};
	var rows = $('#zbdr').datagrid('getRows');//获取类表中全部数据
	if (rows) {
		for (var i = rows.length - 1; i >= 0; i--) {
			var indexT = $('#zbdr').datagrid('getRowIndex', rows[i]);
			$('#zbdr').datagrid('deleteRow', indexT);
		}
	};
}
</script>
</body>


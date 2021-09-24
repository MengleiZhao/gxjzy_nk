<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="purchase_check_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search">采购批次编号&nbsp;
					<input id="check_fpCode" name="fpCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;采购名称
					<input id="check_fpName" name="fpName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;申请部门
					<input id="check_fDeptName" name="fDeptName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
				<%-- &nbsp;&nbsp;采购方式&nbsp;
					<input id="check_fpMethodStr" name="fpMethod.code"  class="easyui-combobox" style="width: 150px; height:25px;" data-options="url:'${base}/lookup/lookupsJson?parentCode=PURCHASE_METHOD',method:'get',valueField:'code',textField:'text',editable:false" /> --%>
					
					<%-- &nbsp;&nbsp;组织形式
									<c:if test="${empty bean.fpId}">
										<input id="F_fOrgType" name="fOrgType.code"  class="easyui-combobox" style="width: 100px; height:25px;" data-options="url:'${base}/lookup/lookupsJson?parentCode=CGORG_TYPE',method:'get',valueField:'code',textField:'text',editable:false" />
									</c:if>
									<c:if test="${!empty bean.fpId}">
										<input id="F_fOrgType" name="fOrgType.code"   class="easyui-combobox" style="width: 100px; height:25px;" data-options="url:'${base}/lookup/lookupsJson?parentCode=CGORG_TYPE&selected=${bean.fOrgType.code}',method:'get',valueField:'code',textField:'text',editable:false"  />
									</c:if>
								&nbsp;&nbsp;采购方式
									<c:if test="${empty bean.fpId}">
									<input id="F_fpMethod" name="fpMethod.code"  class="easyui-combobox" style="width: 100px; height:25px;" data-options="url:'${base}/lookup/lookupsJson?parentCode=FSCGFS',method:'get',valueField:'code',textField:'text',editable:false" />
									</c:if>
									<c:if test="${!empty bean.fOrgType.code && bean.fOrgType.code=='CGORG_TYPE_1'}">
										<input id="F_fpMethod" name="fpMethod.code"   class="easyui-combobox" style="width: 100px; height:25px;" 
										data-options="url:'${base}/lookup/lookupsJson?parentCode=JZCGFS&selected=${bean.fpMethod.code}',
										method:'get',valueField:'code',textField:'text',editable:false"  />
									</c:if>
									<c:if test="${!empty bean.fOrgType.code && bean.fOrgType.code=='CGORG_TYPE_2'}">
										<input id="F_fpMethod" name="fpMethod.code"   class="easyui-combobox" style="width: 100px; height:25px;" 
										data-options="url:'${base}/lookup/lookupsJson?parentCode=FSCGFS&selected=${bean.fpMethod.code}',
										method:'get',valueField:'code',textField:'text',editable:false"  />
									</c:if> --%> 
					
					&nbsp;&nbsp;<a href="#" onclick="queryCgsqCheck();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearCgsqCheckTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>			
			</tr>
		</table>
	</div>



	<div style="margin: 0 10px 0 10px;height: 445px;">	
		<table id="cgcheck_list" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/cgcheck/cgcheckPage',
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'fpId',hidden:true"></th>
					<th data-options="field:'number',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'fpCode',align:'center'" style="width: 15%">采购批次编号</th>
					<th data-options="field:'fpName',align:'center',resizable:false,sortable:true" style="width: 17%">采购名称</th>
					<th
						data-options="field:'fpAmount',align:'center',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}"
						style="width: 15%">采购金额[元]</th>
					<th
						data-options="field:'fUserName',align:'center',resizable:false,sortable:true"
						style="width: 10%">申请人</th>
					<th
						data-options="field:'fDeptName',align:'center',resizable:false,sortable:true"
						style="width: 10%">申请部门</th>
					<th
						data-options="field:'fReqTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat"
						style="width: 10%">申请时间</th>
					<!-- <th
						data-options="field:'fpMethod',align:'center',resizable:false,sortable:true"
						style="width: 10%">采购方式</th> -->
					<th
						data-options="field:'fCheckStauts',align:'center',resizable:false,sortable:true,formatter:formatPrice"
						style="width: 10%">审批状态</th>
					<th
						data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ"
						style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>



</div>
<script type="text/javascript">
	//显示搜索
	function spreadcheck() {
		$('#helpTrcheck').css("display", "");
		$('#retractcheck').css("display", "");
		$('#spreadcheck').css("display", "none");
	}
	//隐藏搜索
	function retractcheck() {
		$('#helpTrcheck').css("display", "none");
		$('#retractcheck').css("display", "none");
		$('#spreadcheck').css("display", "");
	}

	//设置审批状态
	var c;
	function formatPrice(val, row) {
		c = val;
		if (val == 0) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</a>';
		} else if (val == -1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</a>';
		} else if (val == 9) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
		} else {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
		}
	}

	//操作栏创建
	function CZ(val, row) {
		if (c == 9) {
			return null;
		} else {
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
					'<a href="#" onclick="checkCgsqApply(' + row.fpId + ')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/check1.png">'+
					'</a></td></tr></table>';
		}
	}
	
	//跳转审批页面
	function checkCgsqApply(id) {
		var win = creatWin('审批', 1105, 580, 'icon-search', "/cgcheck/check?id="+ id);
		win.window('open');
	}		
		
	//点击查询
	function queryCgsqCheck() {
		$('#cgcheck_list').datagrid('load', {
			fpCode:$('#check_fpCode').val(),
			fpName:$('#check_fpName').val(),
			fDeptName:$('#check_fDeptName').val(),
		});
	}
	//清除查询条件
	function clearCgsqCheckTable() {
		$("#check_fpCode").textbox('setValue','');
		$("#check_fpName").textbox('setValue','');
		$("#check_fDeptName").textbox('setValue','');
		$('#cgcheck_list').datagrid('load',{});//清空以后，重新查一次
	}
</script>
</body>
</html>


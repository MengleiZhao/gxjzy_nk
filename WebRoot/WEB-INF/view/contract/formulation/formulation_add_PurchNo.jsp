<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td>&nbsp;&nbsp;&nbsp;采购批次号</td> 
					<td>
						<input id="CF_add_PN_fpCode" name="" style="width: 200px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td>&nbsp;&nbsp;&nbsp;采购金额</td> 
					<td>
						<input id="CF_add_PN_fpAmount" name="" style="width: 200px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td>
						<a href="javascript:void(0)" onclick="queryCF();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')">
						</a>
					</td>
					<td >&nbsp;
						<a href="javascript:void(0)" onclick="clearCF();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"
									onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')">
						</a>
					</td>
				</tr>
			</table>           
		</div>
		<div class="list-table">
			<!-- <th data-options="field:'ck',checkbox:true"></th> -->
			<table id="CF_add_PN_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/cgsqsp/cgsqPageChoose?fCheckStauts=9',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'fpId',hidden:true"></th>
						<th data-options="field:'number',align:'center'" style="width: 5%">序号</th>
						<th data-options="field:'fpCode',align:'center'" style="width: 20%">采购批次编号</th>
						<th data-options="field:'fpName',align:'center',resizable:false,sortable:true" style="width: 23%">采购名称</th>
						<th data-options="field:'fbidAmount',align:'right',formatter:bidamount,resizable:false,sortable:true" style="width: 15%">中标金额[元]</th>
						<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" style="width: 15%">申报部门</th>
						<th data-options="field:'fReqTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">申报时间</th>
						<!-- <th data-options="field:'fpMethod',align:'center',resizable:false,sortable:true" style="width: 10%">采购方式</th> -->
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CGCZ"  width="10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
		<div style="text-align: left;height: 20px">
			<span style="color:#ff6800">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✧温馨提示：双击数据选择</span>
		</div>
	</div>
	


<script type="text/javascript">
//分页样式调整
$(function(){
	$("#CF_add_PN_dg").datagrid({
		onDblClickRow:function(index, row){
			var row = $('#CF_add_PN_dg').datagrid('getSelected');
			var selections = $('#CF_add_PN_dg').datagrid('getSelections');
			if (row != null && selections.length == 1) {
				$.messager.progress();
				$.ajax({ 
					url: base+"/Formulation/detailcg?id="+row.fpId, 
					success: function(data){
				$("#F_fPurchNo").val(row.fpId);
				$("#F_fPurchName").textbox('setValue',row.fpName+" 【 "+row.fpCode+" 】"); 
				//$("#F_fcAmount").numberbox('setValue',data); 
				$("#totalAmount").val(row.fbidAmount==null?0.00:row.fbidAmount);
				//$('#F_fcAmountMax').textbox('setValue',convertCurrency(data));
				$('#F_indexId').val(row.indexId);
				$('#F_proDetailId').val(row.proDetailId);
				queryCGMX(row.fpId);
				queryCGWinning(row.fpId);
				closeFirstWindow();
			    }});
			} else {
				$.messager.alert('系统提示', '请选择一条数据！', 'info');
			} 
		}
	});
});


function formatPrice(val,row){
	if (val =="1"){
		return "公开招标";
	} else if(val =="2"){
		return "待邀请招标";
	} else if(val =="3"){
		return "竞争性谈判";
	} else if(val =="4"){
		return"单一来源采购";
	}
}
function bidamount(val,row){
	return  val==null?'未填写中标金额':val;
}
function CGCZ(val,row){
	return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="CGCZ_detail(' + row.fpId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a></td></tr></table>';
}	
function CGCZ_detail(id) {
	var win = creatSecondWin('采购单', 1115, 580, 'icon-search',"/cgsqsp/detail?id=" + id+'&openType=detail');
	win.window('open');
}
function PitchOn(id){
	var row = $('#CF_add_PN_dg').datagrid('getSelected');
	var selections = $('#CF_add_PN_dg').datagrid('getSelections');
	if (row != null && selections.length == 1) {
		$("#F_fPurchNo").textbox('setValue',row.fpId); 
		$("#F_fcAmount").textbox('setValue',(row.fpAmount)); 
		closeFirstWindow();
	} else {
		$.messager.alert('系统提示', '请选择一条数据！', 'info');
	}
}
function queryCF(){  
	$('#CF_add_PN_dg').datagrid('load',{ 
		fpCode:$('#CF_add_PN_fpCode').textbox('getValue'),
		fpAmount:$('#CF_add_PN_fpAmount').textbox('getValue'),
		forgtype:$('#F_fOrgType').val()
	} ); 
}
function clearCF(){
	$("#CF_add_PN_fpCode").textbox('setValue','');
	$("#F_fOrgType").combobox('setValue','');
	$("#CF_add_PN_fpAmount").textbox('setValue','');
	$('#CF_add_PN_dg').datagrid('load',{//清空以后，重新查一次
	});
}

</script>
</body>
</html>


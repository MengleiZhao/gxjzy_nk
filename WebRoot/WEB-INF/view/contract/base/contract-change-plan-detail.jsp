<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-table" style="margin-top: 10px;">
<table id="change-plan-detail-dg" class="easyui-datagrid" style="width:695px;margin-top: 10px;" cellspacing="0" cellpadding="0"
	data-options="
		singleSelect: true,
		striped:true,
		url:'${base}/Change/uptPlanJson?fId_U=${Upt.fId_U}',
		rownumbers:true,
		toolbar:'#change-plan-detail-tb',
	">
	<thead>
			<tr>
				<th data-options="field:'fReceProperty',align:'center',width:154" >付款性质</th>
				<th data-options="field:'fRecePlanTime',align:'center',width:154,formatter: ChangeDateFormat" >预计付款时间</th>
				<th data-options="field:'fRecePlanAmount',align:'center',width:174" >预计付款金额(元)</th>
				<th data-options="field:'fReceCondition',align:'center',width:174" >付款条件</th>
			</tr>
	</thead>
</table>
	<div id="change-plan-detail-tb" style="height:30px;padding-bottom: 8px;">
		<span style="margin-left:8px;color: red;">总额:</span>&nbsp;&nbsp;<input class="easyui-numberbox" readonly="readonly" id="totalUptAmountshow" data-options="icons: [{iconCls:'icon-yuan'}],precision:2"  style="height:30px;margin-left:20px;color: red;width:200px;">
		<input hidden="hidden" id="totalUptAmount"/>
	</div>
</div>

<script type="text/javascript">
//完成后计算总额并设置
$('#change-plan-detail-dg').datagrid({
	onLoadSuccess : function(data){
		//console.log(data.rows);
		var rows = data.rows;
		var amount = 0.00;
		for(var i = 0 ;i<rows.length; i++){
			amount = parseFloat(amount) + parseFloat(rows[i].fRecePlanAmount);
		}
		$('#totalUptAmount').val(amount);
		$('#totalUptAmountshow').numberbox('setValue',amount);
	}
})
</script>
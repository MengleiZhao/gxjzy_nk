<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">

	<table id="international_traveling_expense_id" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#traveling_expense_id',
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/internationalTravelingExpense?gId=${applyBean.gId}',
	</c:if>
	<c:if test="${empty applyBean.gId}">
	url: '',
	</c:if>
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	
	">
		<thead>
			<tr>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'timeStart',width:110,align:'center',editor:{type:'datebox', options:{ editable:false}},formatter:ChangeDateFormat1">出发日期</th>
				<th data-options="field:'timeEnd',width:110,align:'center',editor:{type:'datebox',options:{ editable:false}},formatter:ChangeDateFormat1">到达日期</th>
				<th data-options="field:'startCity',width:115,align:'center',editor:{type:'textbox',options:{editable:true}}">出发地</th>
				<th data-options="field:'arriveCity',width:115,align:'center',editor:{type:'textbox',options:{editable:true}}">目的地</th>
				<th data-options="field:'vehicle',hidden:true,width:120,align:'center',editor:{type:'textbox',options:{editable:true,
							options:{
								onChange:onChange1
							}}}">交通工具</th>
				<th data-options="field:'vehicleText',width:130,align:'center',editor:{
							editable:true,
							type:'combotree',
							filter: function(q, row){
									var opts = $(this).combotree('options');
									return row[opts.textField].indexOf(q) == 0;
								},
							options:{
								required:true,
								valueField:'code',
								textField:'text',
								method:'post',
								url:base+'/vehicle/comboboxJson?selected=JTGJ06',
								onClick: reloadSubsidies,
								<!-- onHidePanel:reloadSubsidies -->
							}}">交通工具</th>
				<th data-options="field:'applyAmount',width:100,align:'center',editor:{type:'numberbox',options:{editable:true,precision:2 }}">申请费用</th>
				<th data-options="field:'trainSubsidies',hidden:true,width:170,align:'center',editor:{type:'numberbox',options:{editable:true,precision:2}}">其中国际列车补助（美元）</th>
			</tr>
		</thead>
	</table>
	<div id="traveling_expense_id" style="height:30px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">国际旅费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span id="applyTravelingExpense"><fmt:formatNumber groupingUsed="true" value="${abroad.travelMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>
<script type="text/javascript">

function reloadSubsidies(node){
	
    	var row = $('#international_traveling_expense_id').datagrid('getSelected');
    	var rindex = $('#international_traveling_expense_id').datagrid('getRowIndex', row); 
    	var ed = $('#international_traveling_expense_id').datagrid('getEditor',{
    		index:rindex,
    		field : 'trainSubsidies'  
    	});
    	var ed1 = $('#international_traveling_expense_id').datagrid('getEditor',{
    		index:rindex,
    		field : 'vehicle'  
    	});
    	$(ed1.target).textbox('setValue',node.id);
		if(node.id =='38'){
    	$("#international_traveling_expense_id").datagrid('showColumn', "trainSubsidies");
    	 $(ed.target).numberbox('enable');
    	$(ed.target).numberbox('setValue',0);
		}else{
			$(ed.target).numberbox('disable');
		}
}
function onChange1(newVal,oldVal){
	
    	var row = $('#international_traveling_expense_id').datagrid('getSelected');
    	var rindex = $('#international_traveling_expense_id').datagrid('getRowIndex', row); 
    	var ed = $('#international_traveling_expense_id').datagrid('getEditor',{
    		index:rindex,
    		field : 'trainSubsidies'  
    	});
		if(newVal =='38'){
    	$("#international_traveling_expense_id").datagrid('showColumn', "trainSubsidies");
    	 $(ed.target).numberbox('enable');
    	$(ed.target).numberbox('setValue',0);
		}else{
			$(ed.target).numberbox('disable');
		}
}


//时间格式化
function ChangeDateFormat1(val) {
	
	var t, y, m, d, h, i, s;
	if (val == null || val == "") {
		return "";
	}
	t = new Date(val);
	y = t.getFullYear();
	m = t.getMonth() + 1;
	d = t.getDate();
	h = t.getHours();
	i = t.getMinutes();
	s = t.getSeconds();
	// 可根据需要在这里定义时间格式  
	return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
}
</script>
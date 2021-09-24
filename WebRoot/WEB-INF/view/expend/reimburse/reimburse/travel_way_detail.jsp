<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-top:10px;padding-top: 0px;margin-left: 0px;">
	<table id="travel-way-dg" class="easyui-datagrid" style="width:707px;height:auto;"
	data-options="
	toolbar: '#dmp',
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/getTravelWay?gId=${applyBean.gId}&travelType=GWCG',
	</c:if>
	<c:if test="${empty applyBean.gId}">
	url: '',
	</c:if>
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	singleSelect: true,
	">
	<thead>
		<tr>
			<th data-options="field:'fOId',hidden:true"></th>			
			<th data-options="field:'gId',hidden:true"></th>			
			<th data-options="field:'fStartDate',required:'required',align:'center',width:140,editor:{type:'datebox'},formatter:travelWayDateFormat">出发日期</th>
			<th data-options="field:'fEndDate',required:'required',align:'center',width:140,editor:{type:'datebox'},formatter:travelWayDateFormat">到达日期</th>
			<th data-options="field:'departurePlace',required:'required',align:'center',width:138,editor:'textbox'">出发地</th>
			<th data-options="field:'destination',required:'required',align:'center',width:138,editor:'textbox'">目的地</th>
			<th data-options="field:'vehicle',width:160,align:'center',
					editor:{type:'combobox',options:{valueField:'id',textField:'text',data:[
	                	{id:'飞机',text:'飞机'},
	                	{id:'火车',text:'火车'},
	                	{id:'轮船',text:'轮船'},
	                	{id:'其他',text:'其他'}],
	                	prompt:'-请选择-',panelHeight:'atuo',editable: false}}">交通工具</th>
			<th data-options="field:'vehicleLevel',width:160,align:'center',editor:{type:'textbox',options:{editable:true}}">交通工具级别</th>
			<th data-options="field:'travelPersonnel',width:142,align:'center',editor:{type:'textbox',options:{editable:true}}">出行人员</th>
		</tr>
	</thead>
</table>
</div>
<script type="text/javascript">

//接待人员表格添加删除，保存方法
	var editIndexWay = undefined;
	function endEditingWay() {
		if (editIndexWay == undefined) {
			return true
		}
		if ($('#travel-way-dg').datagrid('validateRow', editIndexWay)) {
			//下面三行，是在增加一行的时候，防止原来的一行的值变成code
			/* var tr = $('#travel-way-dg').datagrid('getEditors', editIndexWay);
			var text=tr[3].target.textbox('getText');
			if(text!='--请选择--'){
				tr[3].target.textbox('setValue',text);
			} */
			$('#travel-way-dg').datagrid('endEdit', editIndexWay);
			editIndexWay = undefined;
			return true;
		} else {
			return false;
		}
	}
	
	function appendWay() {
		if (endEditingWay()) {
			$('#travel-way-dg').datagrid('appendRow', {});
			editIndexWay = $('#travel-way-dg').datagrid('getRows').length - 1;
			$('#travel-way-dg').datagrid('selectRow', editIndexWay).datagrid('beginEdit',editIndexWay);
		}
	}
	function removeitWay() {
		if (editIndexWay == undefined) {
			return
		}
		$('#travel-way-dg').datagrid('cancelEdit', editIndexWay).datagrid('deleteRow',
				editIndexWay);
		editIndexWay = undefined;
	}
	function travelWayAccept() {
		if (endEditingWay()) {
			$('#travel-way-dg').datagrid('acceptChanges');
		}
	}
	
	function travelWayJson(){
		travelWayAccept();
		var rows1 = $('#travel-way-dg').datagrid('getRows');
		var travelWay = "";
		for (var i = 0; i < rows1.length; i++) {
			travelWay = travelWay + JSON.stringify(rows1[i]) + ",";
		}
		$('#travelWayJson').val(travelWay);
	}
	
	function travelWayDateFormat(val) {
		var t, y, m, d, h, i, s;
	    if(val==null || val==''){
	  	  return "";
	    }
	    t = new Date(val);
	    y = t.getFullYear();
	    m = t.getMonth() + 1;
	    d = t.getDate();
	    // 可根据需要在这里定义时间格式  
	    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
	}
</script>
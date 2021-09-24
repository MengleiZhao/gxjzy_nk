<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>



<div class="window-tab" style="margin-left: 0px;padding-top: 10px">


	<table id="reimb-meeting-mingxi" class="easyui-datagrid" style="width:693px;height:auto;"
	data-options="
	toolbar: '#appli-detail-tb',
	<c:if test="${operation=='add'}">
	url: '${base}/apply/mingxi?id=${applyBean.gId}',
	</c:if>
	<c:if test="${operation!='add'}">
	url: '${base}/apply/reimbmingxi?id=${bean.rId}',
	</c:if>
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:false,
	scrollbarSize:0,
	singleSelect: true,
	onClickRow: onClickRow1,
	">
	<thead>
		<tr>
			<c:if test="${operation!='add'}">
				<th data-options="field:'cId',hidden:true"></th>
			</c:if>
				<th data-options="field:'costDetail',required:'required',align:'center',width:170">费用名称</th>
				<th data-options="field:'standard',required:'required',align:'center',width:180">费用标准（元/人天）</th>
				<th data-options="field:'totalStandard',required:'required',align:'center',width:180">总额标准[元]</th>
			<c:if test="${empty detail}">
				<th data-options="field:'remibAmount',required:'required',align:'center',width:166,editor:{type:'numberbox',options:{onChange:addNum,precision:2,groupSeparator:','}}">报销金额[元]</th>
			</c:if>
			<c:if test="${!empty detail}">
				<th data-options="field:'remibAmount',required:'required',align:'center',width:166,formatter:listToFixed">报销金额[元]</th>
			</c:if>
		</tr>
	</thead>
	</table>
</div>
<%-- <c:if test="${empty detail}">
<div id="appli-detail-tb" style="height:30px">
	<a style="color: red;">申请总额：</a><input style="width: 100px;" id="num1" class="easyui-numberbox" value="${bean.amount}" readonly="readonly" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]"/>
	
	<!-- <a href="#" onclick="openbz()" style="color: blue">查看标准</a> -->
	<a href="javascript:void(0)" onclick="removeit()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="javascript:void(0)" onclick="append()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
</div>
</c:if>
<c:if test="${!empty detail}">
<div id="appli-detail-tb" style="height:30px">
	<a style="color: red;">申请总额：</a><input style="width: 100px;" class="easyui-numberbox" value="${bean.amount}" readonly="readonly"/>
</div>
</c:if> --%>

<script type="text/javascript">
//明细表格添加删除，保存方法
var editIndex = undefined;
function endEditing() {
	if (editIndex == undefined) {
		return true
	}
	if ($('#reimb-meeting-mingxi').datagrid('validateRow', editIndex)) {
		$('#reimb-meeting-mingxi').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow1(index) {
	
	if (editIndex != index) {
		if (endEditing()) {
			$('#reimb-meeting-mingxi').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndex = index;
		} else {
			$('#reimb-meeting-mingxi').datagrid('selectRow', editIndex);
		}
	}
}
function accept() {
	if (endEditing()) {
		$('#reimb-meeting-mingxi').datagrid('acceptChanges');
	}
}

//计算申请总额
function addNum(newValue,oldValue) {
		var row = $('#reimb-meeting-mingxi').datagrid('getSelected');//获得选择行
		var index=$('#reimb-meeting-mingxi').datagrid('getRowIndex',row);//获得选中行的行号
		var tr = $('#reimb-meeting-mingxi').datagrid('getEditors', index);
		var standar= parseFloat(row.totalStandard);//获得选中行的开支标准
		if(isNaN(standar)){
			standar=0;
		}
		/* if(parseFloat(newValue)>parseFloat(standar)){
			
			alert('报销金额不能大于开支标准，请核对！');
			tr[0].target.numberbox('setValue',0);
			newValue=0;
		} */
		
		var num = 0;
		var rows = $('#reimb-meeting-mingxi').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			if(i!=index){
				if(rows[i].remibAmount!=""&&rows[i].remibAmount!=null){
					num += parseFloat(rows[i].remibAmount);
				}
			}
		}
		if(newValue!=""&&newValue!=null) {
			num += parseFloat(newValue);
		}
		$('#reimburseAmount').val(num.toFixed(2));
		$('#reimbAmount_span').html(fomatMoney(num,2));
		$('#p_amount').html(fomatMoney(num,2)+"[元]");
				cx();
}
</script>

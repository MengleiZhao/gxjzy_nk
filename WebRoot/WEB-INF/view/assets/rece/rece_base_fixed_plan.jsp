<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${openType=='add'||openType=='edit'}">
	<th data-options="field:'fAssCode_RL',editor:'textbox',align:'center'" style="width: 15%">资产编号</th>
	<th data-options="field:'fAssName_RL',editor:'textbox',align:'center'" style="width: 15%">资产名称</th>
	<th data-options="field:'fAssSpecif_RL',editor:'textbox',align:'center'" style="width: 10%">规格型号</th>
	<th data-options="field:'fOldAddress',editor:'textbox',align:'center'" style="width: 15%">原存放地点</th>
	<th data-options="field:'fOldUser',editor:'textbox',align:'center'" style="width: 15%">原资产管理人</th>
	<th data-options="field:'fMeasUnit_RL',editor:'textbox',align:'center'" style="width: 15%">计量单位</th>
	<th data-options="field:'fReceNum_RL',editor:{type:'numberbox',options:{precision:2,onChange:sumAmount}},align:'center'" style="width: 15%">数量</th>
	<th data-options="field:'fSignPrice',editor:{type:'numberbox',options:{precision:2,onChange:sumAmount}},align:'right'" style="width: 15%">单价(元)</th>
	<th data-options="field:'fAmount',editor:{type:'numberbox',options:{precision:2,onChange:sumAcount,readonly:true}},align:'right'" style="width: 15%">总值(元)</th>
	<th data-options="field:'fNewAddress',editor:'textbox',align:'center'" style="width: 15%">新存放地点</th>
	<th data-options="field:'fNewUser',editor:'textbox',align:'center'" style="width: 15%">新资产管理人</th>
	<th data-options="field:'fRemark_RL',editor:'textbox',align:'left'" style="width: 20%">备注</th>
</c:if>
<c:if test="${openType=='detail'}">
	<th data-options="field:'fAssCode_RL',align:'center'" style="width: 15%">资产编号</th>
	<th data-options="field:'fAssName_RL',align:'center'" style="width: 15%">资产名称</th>
	<th data-options="field:'fAssSpecif_RL',align:'center'" style="width: 10%">规格型号</th>
	<th data-options="field:'fOldAddress',align:'center'" style="width: 15%">原存放地点</th>
	<th data-options="field:'fOldUser',align:'center'" style="width: 15%">原资产管理人</th>
	<th data-options="field:'fMeasUnit_RL',align:'center'" style="width: 15%">计量单位</th>
	<th data-options="field:'fReceNum_RL',align:'center'" style="width: 15%">数量</th>
	<th data-options="field:'fSignPrice',align:'right'" style="width: 15%">单价(元)</th>
	<th data-options="field:'fAmount',align:'right'" style="width: 15%">总值(元)</th>
	<th data-options="field:'fNewAddress',align:'center'" style="width: 15%">新存放地点</th>
	<th data-options="field:'fNewUser',align:'center'" style="width: 15%">新资产管理人</th>
	<th data-options="field:'fRemark_RL',align:'left'" style="width: 20%">备注</th>
</c:if>
<script type="text/javascript">
//填写总值的数据
function sumAmount(newValue,oldValue){
	var row = $('#Rece_low_add_plan').datagrid('getSelected');//获得选择行
	var index=$('#Rece_low_add_plan').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#Rece_low_add_plan').datagrid('getEditors', index);//获取选中行的数据
	var num = tr[6].target.numberbox('getValue');//获得数量
	var price = tr[7].target.numberbox('getValue');//获得单价
	tr[8].target.numberbox('setValue',num*price);//设置给后面一个
	/*	$('#R_fSumAmount').numberbox('setValue',null);//合计金额清零
 	var sumAmounct = $('#R_fSumAmount').numberbox('getValue');//获得合计金额
	if(null==sumAmounct||sumAmounct==''){
		sumAmounct=0.00;
	}
	sumAmounct = parseFloat(sumAmounct)+(num*price);//parseFloat
	$('#R_fSumAmount').numberbox('setValue',sumAmounct);//设置到合计金额 */
	
}
//总值校验是否正确
function sumAcount(newValue,oldValue){
	var row = $('#Rece_low_add_plan').datagrid('getSelected');//获得选择行
	var index=$('#Rece_low_add_plan').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#Rece_low_add_plan').datagrid('getEditors', index);//获取选中行的数据
	var num = tr[6].target.numberbox('getValue');//获得数量
	var price = tr[7].target.numberbox('getValue');//获得单价
	if((num*price)!=newValue){
		tr[8].target.numberbox('setValue',num*price);//设置值一个正确的值给总值
		
	}
	//设置总额
	var rows = $('#Rece_low_add_plan').datagrid('getRows');//获得选择行
	var num1 = 0;
	for (var i = 0; i < rows.length; i++) {
	  if (!isNaN(parseFloat(rows[i]['fAmount']))) {
	  	num1 += parseFloat(rows[i]['fAmount']);
	  }
	}
	var num = parseFloat(newValue);
	var numOld = parseFloat(row.fAmount);
	if (!isNaN(num)) {
		if (!isNaN(numOld) && isNaN(parseFloat(oldValue))) {
			return;
		} else {
			if (!isNaN(numOld)) {
				num1 = num1 + num - numOld;
			} else {
				num1 = num1 + num;
			}
		}
	}
	$('#R_fSumAmount').numberbox('setValue', num1);
}
</script>	

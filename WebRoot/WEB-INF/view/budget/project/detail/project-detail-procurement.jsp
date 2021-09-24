<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
	<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 990px">
		<div id="mingxiProIdDetail" title="政府采购明细表" data-options="collapsed:false,collapsible:false"style="overflow:auto;width: 980px">
		<div style="overflow:auto;margin-top: 0px;">
			<table id="pro_purchase_tab_detail_id" class="easyui-datagrid" style="width:980px;height:auto"
			data-options="
			singleSelect: true,
			<c:if test="${!empty bean.FProId}">
			url: '${base}/project/findByfProIdGetPur?id=${bean.FProId}&fIfSoftware=0',
			</c:if>
			<c:if test="${empty bean.FProId}">
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
						<th data-options="field:'fItemsDetail',align:'center'" style="width: 15%">品目明细</th>
						<th data-options="field:'fItemsCodeName',align:'center'" style="width: 15%">品目编码及名称</th>
						<th data-options="field:'fItemsCode',align:'center',hidden:true" style="width: 15%">品目编码</th>
						<th data-options="field:'fItemsName',align:'center',hidden:true" style="width: 15%">品目名称</th>
						<th data-options="field:'subName',width:160,align:'center'" style="width: 15%">经济分类科目</th>
						<th data-options="field:'subCode',align:'center',hidden:true" style="width: 15%">经济分类科目编码</th>
						<th data-options="field:'fIfThreeAssets',width:150,align:'center',formatter:isorno" style="width: 15%">是否新增三项资产</th>
						<th data-options="field:'fProcurementNum',align:'center'" style="width: 15%">采购数量</th>
						<th data-options="field:'fMeasurement',align:'center'" style="width: 15%">计量单位</th>
						<th data-options="field:'fUnitPrice',align:'center'" style="width: 15%">采购单价（元）</th>
						<th data-options="field:'fAmount',align:'center'" style="width: 15%">总计</th>
						<th data-options="field:'fPlanDate',align:'center',formatter:ChangeDateFormatProPur" style="width: 15%">计划采购日期</th>
						<th data-options="field:'fRefiningExplain',align:'center'" style="width: 15%">参数</th>
						<th data-options="field:'fAllocationStandard',align:'center'" style="width: 15%">采购配置标准</th>
					</tr>
				</thead>
			</table>
			</div>
	</div>
</div>
	<table cellpadding="0" cellspacing="0" style="width:990px;height:auto;margin-left: 20px;margin-right: 20px;">
		<tr class="trbody">
			<td style="float: left;margin-top: 20px" colspan="5">是否为一采多年项目
	     		<input type="radio" value="1" disabled="disabled" name="ifPurchaseManyYearsPro" <c:if test="${bean.ifPurchaseManyYearsPro=='1'}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;是
				&nbsp;&nbsp;
				<input type="radio" value="0" disabled="disabled" disabled="disabled" name="ifPurchaseManyYearsPro" <c:if test="${bean.ifPurchaseManyYearsPro=='0'||bean.ifPurchaseManyYearsPro==''||empty bean.ifPurchaseManyYearsPro}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;否
			</td>
		</tr>
	</table>

<div id="purManyYearsPro_toolbar_detail_Id" style="height:30px;width: 970px;margin-top: 15px;margin-left: 20px;margin-right: 20px;">
	<div style="height:30px;width: 970px;margin-top: 5px;color: red">
		采购总金额：<span style="color: red" id="purYearsTotalshow"><fmt:formatNumber groupingUsed="true" value="${bean.governmentPurAmount}" minFractionDigits="2" maxFractionDigits="2"/></span>元
	</div>
</div>
<table id="purManyYearsProTabDetailId" class="easyui-datagrid" style="width:980px;height:auto;margin-left: 20px;margin-right: 20px;"
			data-options="
			singleSelect: true,
			toolbar: '#purManyYearsPro_toolbar_detail_Id',
			rownumbers : true,
			url: '${base}/project/getPurchaseManyYearsPro?fProId=${bean.FProId}&fIfSoftware=0',
			method: 'post',
			">
				<thead>
					<tr>
						<th data-options="field:'purYear',align:'center'" style="width:33%">采购年度</th>
						<th data-options="field:'yearAmount',align:'center'" style="width:33%">年度预算安排金额</th>
						<th data-options="field:'fExplain',align:'center'" style="width:33%">说明</th>
					</tr>
				</thead>
</table>
<script type="text/javascript">

function isorno(val){
	if(val=='1'){
		return '是';
	}else if(val=='0'){
		return '否';
	}else{
		return '';
	}
}

//时间格式化
function ChangeDateFormatProPur(val) {
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
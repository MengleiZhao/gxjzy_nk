<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="/includes/taglibs.jsp"%>

<style type="text/css">
.pro_plan_th {
	background: #c1e3f2;
	font-weight: bold;
	color: #333333;
}
.pro_plan_table td {
	border-left:1px solid black;
	border-bottom:1px solid black;
	margin: 0;
	padding: 0
}
.pro_plan_input{
	border: 1px solid #fff;
	background-color: #f0f5f7;
	vertical-align: middle;
	width: 80px;
}
.pro_plan_input:read-only{ background-color: #f6f6f6;} 

</style>


	<table style="width:100%" class="a_table">
		<tr style="height: 15px">
			<td style=" text-align: left;">
				单位：元
			</td>
		</tr>
	</table>
	
	<table id="pro_plan_table" class="ystable">
		<tr style="text-align: center;">
			<th class="pro_plan_th" rowspan="2" style="width: 30px;">序号</th>
			<th class="pro_plan_th" rowspan="2">预算年度</th>
			<th class="pro_plan_th" rowspan="2">支出计划额度</th>
			<th class="pro_plan_th" colspan="3">年初预算</th>
			<th class="pro_plan_th" colspan="3">执行调整</th>
			<th class="pro_plan_th" colspan="3">全年预算</th>
			<th class="pro_plan_th" colspan="3">支出</th>
			<th class="pro_plan_th" colspan="3">年度剩余</th>
			<th class="pro_plan_th" colspan="3">实际年度剩余</th>
			<th class="" style="width:50px"></th>
		</tr>
		
		<tr style="text-align: center;">
			<th class="pro_plan_th" name="">财政拨款</th>
			<th class="pro_plan_th" name="">结转资金</th>
			<th class="pro_plan_th" name="">小计</th>
			<th class="pro_plan_th" name="">财政拨款</th>
			<th class="pro_plan_th" name="">结转资金</th>
			<th class="pro_plan_th" name="">小计</th>
			<th class="pro_plan_th" name="">财政拨款</th>
			<th class="pro_plan_th" name="">结转资金</th>
			<th class="pro_plan_th" name="">小计</th>
			<th class="pro_plan_th" name="">财政拨款</th>
			<th class="pro_plan_th" name="">结转资金</th>
			<th class="pro_plan_th" name="">小计</th>
			<th class="pro_plan_th" name="">财政拨款</th>
			<th class="pro_plan_th" name="">结转资金</th>
			<th class="pro_plan_th" name="">小计</th>
			<th class="pro_plan_th" name="">财政拨款</th>
			<th class="pro_plan_th" name="">结转资金</th>
			<th class="pro_plan_th" name="">小计</th>
		</tr>
		
		<c:if test="${!empty planList}">
		<c:forEach var="p" items="${planList}" varStatus="status">
		<tr class="gdzqTr">
			<td><span style="width: 30px;display: block;text-align: center;">${status.index+1}</span></td>
			<td><input class="pro_plan_input" value="${p.year}" readonly="readonly"/></td>
			<td><input class="pro_plan_input" value="${p.totalPlan}" readonly="readonly"/></td>
			<td><input class="pro_plan_input" value="${p.earlyAmount1}" readonly="readonly"/></td>
			<td><input class="pro_plan_input" value="${p.earlyAmount2}" readonly="readonly"/></td>
			<td><input class="pro_plan_input" value="${p.earlyTotal}" readonly="readonly"/></td>
			<td><input class="pro_plan_input" value="${p.adjustAmount1}" readonly="readonly"/></td>
			<td><input class="pro_plan_input" value="${p.adjustAmount2}" readonly="readonly"/></td>
			<td><input class="pro_plan_input" value="${p.adjustTotal}" readonly="readonly"/></td>
			<td><input class="pro_plan_input" value="${p.yearAmount1}" readonly="readonly"/></td>
			<td><input class="pro_plan_input" value="${p.yearAmount2}" readonly="readonly"/></td>
			<td><input class="pro_plan_input" value="${p.yearTotal}" readonly="readonly"/></td>
			<td><input class="pro_plan_input" value="${p.outAmount1}" readonly="readonly"/></td>
			<td><input class="pro_plan_input" value="${p.outAmount2}" readonly="readonly"/></td>
			<td><input class="pro_plan_input" value="${p.outTotal}" readonly="readonly"/></td>
			<td><input class="pro_plan_input" value="${p.leastAmount1}" readonly="readonly"/></td>
			<td><input class="pro_plan_input" value="${p.leastAmount2}" readonly="readonly"/></td>
			<td><input class="pro_plan_input" value="${p.leastTotal}" readonly="readonly"/></td>
			<td><input class="pro_plan_input" value="${p.actualAmount1}" readonly="readonly"/></td>
			<td><input class="pro_plan_input" value="${p.actualAmount2}" readonly="readonly"/></td>
			<td><input class="pro_plan_input" value="${p.actualTotal}" readonly="readonly"/></td>
		</tr>
		</c:forEach>
		</c:if>
	</table>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table class="easyui-datagrid"  style="width:100%;height:auto"
data-options="
url: '${base}/pfmlendgergl/mingxi?id=${bean.FProId}',
method: 'get'
">
<thead>
			<tr>
				<th data-options="field:'col4',align:'left'" style="width: 15%">指标名称</th>
				<th data-options="field:'col10',align:'left'" style="width: 13%">指标预算金额</th>
				<th data-options="field:'col7',align:'left'" style="width: 15%">本年度目标</th>
				<th data-options="field:'findexAmountYearActualb',align:'left'" style="width: 10%">实际完成值</th>
				<th data-options="field:'fexecRateb',align:'left'" style="width: 12%">完成率</th>
				<th data-options="field:'fdeviationDescb',align:'left'" style="width: 17%">偏差原因分析</th>
				<th data-options="field:'fremarkb',align:'left'" style="width: 18%">备注</th>
			</tr>
</thead>
</table>

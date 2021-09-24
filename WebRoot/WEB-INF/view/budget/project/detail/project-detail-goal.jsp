<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="acco_pro_add_jx" class="easyui-accordion" style="width:922px;margin-left: 20px">
	<div title="年度绩效信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
		<input type="hidden" value="${bean.goal.pid}" name="goal.pid">
		<table cellpadding="0" cellspacing="0" class="ourtable">
			<tr class="trbody">
				<td>年度资金总额（元）</td>
				<td>其中：</td>
				<td>财政拨款（元）</td>
				<td>其他资金（元）</td>
			</tr>
			<tr class="trbody">
				<td>
					<input class="easyui-numberbox" style="height:30px;width: 200px" value="${bean.goal.longTotal}" readonly="readonly"/>
				</td>
				<td colspan="2">
					<input class="easyui-numberbox" style="height:30px;width: 200px" value="${bean.goal.longAmount1}"  readonly="readonly"/>
				</td>
				<td>
					<input class="easyui-numberbox" style="height:30px;width: 200px" value="${bean.goal.longAmount2}"  readonly="readonly"/>
				</td>
			</tr>
			<tr class="trbody">
				<td colspan="4" class="td1" valign="top"><p style="margin-top: 8px">年度目标</p></td>
			</tr>
			<tr class="trbody">
				<td colspan="4">
					<input class="easyui-textbox" style="width:645px;height:70px"
					data-options="multiline:true,required:false,validType:'length[0,100]'"
					name="goal.longGoal" value="${bean.goal.longGoal}" readonly="readonly"/>
				</td>
			</tr>
		</table>
		
	</div>
	
	<div title="中期绩效信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
		<table cellpadding="0" cellspacing="0" class="ourtable">
		
			<tr class="trbody">
				<td>中期资金总额（元）</td>
				<td>其中：</td>
				<td>财政拨款（元）</td>
				<td>其他资金（元）</td>
			</tr>
			<tr class="trbody">
				<td>
					<input class="easyui-numberbox" style="height:30px;width: 200px" value="${bean.goal.midTotal}" readonly="readonly"/>
				</td>
				<td  colspan="2">
					<input class="easyui-numberbox" style="height:30px;width: 200px" value="${bean.goal.midAmount1}" readonly="readonly"/>
				</td>
				<td>
					<input class="easyui-numberbox" style="height:30px;width: 200px" value="${bean.goal.midAmount2}" readonly="readonly"/>
				</td>
			</tr>
		
			<tr class="trbody">
				<td colspan="4" class="td1" valign="top"><p style="margin-top: 8px">中期目标</p></td>
			</tr>
			<tr class="trbody">
				<td colspan="4">
					<input class="easyui-textbox" style="width:645px;height:70px" 
					data-options="multiline:true,required:false,
					validType:'length[0,100]'"
					name="goal.midGoal" value="${bean.goal.midGoal}" readonly="readonly"/>
				</td>
			</tr>
		</table>
	</div>
	
	<div title="绩效指标" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px; ">
		<div class="easyui-panel" closed="true" style="width:645px;">
		<table id="index-jx-dg" class="easyui-datagrid"  style="width:645px"
			data-options="striped:true,nowrap:false,rownumbers:true,scrollbarSize:0,singleSelect:true,method:'post',
			toolbar:'#index-jx-tb',url:'${base}/project/jxIndex?id=${bean.FProId}'">
		</table>
		<input type="hidden" id="jxmingxiJson" name="jxmingxi"/>
		</div>
	</div>
</div>

<script type="text/javascript">
$('#index-jx-dg').datagrid({
	columns:[[{field:'longName1',title:'一级指标',width:110,editor:{type:'textbox',options:{readonly:true}}},
		        {field:'longCode1',title:'code1',width:50,editor:'textbox',hidden:'true'},
		        {field:'longName2',title:'二级指标',width:110, editor:{type:'textbox',options:{readonly:true}}},
		        {field:'longCode2',title:'code2',width:50,editor:'textbox',hidden:'true'},
		        {field:'longName3',title:'三级指标',width:100,editor:'textbox'},
		        {field:'midAmount3',title:'中期指标值',width:150,editor:'textbox'},
		        {field:'longAmount3',title:'长期指标值',width:150,editor:'textbox'}]]

});
</script>

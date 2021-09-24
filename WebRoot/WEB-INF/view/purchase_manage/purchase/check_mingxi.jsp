<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table class="easyui-datagrid"  style="width:660px;height:auto"
data-options="
url: '${base}/cgsqsp/mingxi?id=${bean.fpId}',
method: 'get'
">
<thead>
	<tr>
		<!-- <th data-options="field:'ck',checkbox:true"></th> -->
		<th data-options="field:'fpId',hidden:true"></th>
		<th data-options="field:'num',align:'center',width:40">序号</th>
		<!-- <th data-options="field:'index',align:'center',formatter:formatter_index">序号</th> -->
		 <%-- <th data-options="field:'fmType',align:'left',width:102,
					editor:{
							editable:true,
							type:'combobox',
							options:{
								valueField:'code',
								textField:'text',
								method:'post',
								url:'${base}/lookup/lookupsJson?parentCode=ZCLX'
							}
						}">物品类型</th>  --%>
		<th data-options="field:'fmType',align:'left',width:102,editor:'textbox',formatter:formatter_leixing">物品类型</th>
		<th data-options="field:'fmName',align:'left',width:102,editor:'textbox'">物品名称</th>
		<th data-options="field:'fmSpecif',align:'left',width:82,editor:'textbox'">规格型号</th>
		<th data-options="field:'fmModel',align:'left',width:62,editor:'textbox'">计量单位</th>
		<th data-options="field:'fpNum',align:'left',width:62,editor:'numberbox'">采购数量</th>
		<th data-options="field:'fsignPrice',align:'left',width:62,editor:'numberbox'">单价[元]</th>
		<th data-options="field:'famount',align:'left',width:62,editor:'numberbox'">金额[元]</th>
		<th data-options="field:'fRemark',align:'left',width:100,editor:'textbox'">要求</th>
	</tr>
</thead>
</table>
<script type="text/javascript">
	function formatter_leixing(val,row){
		if(val=="ZCLX-01"){
			return "低值易耗品";
		}else if(val=="ZCLX-02"){
			return "固定资产";
		}else if(val=="ZCLX-03"){
			return "无形资产";
		}
	}
</script>
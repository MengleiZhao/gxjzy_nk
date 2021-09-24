<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
    <table id="filing-edit-plan-dg-detail" class="easyui-datagrid" style="width:700px;height:auto;"
			data-options="
				singleSelect: true,
				url: '${base}/Filing/finderReceivPlan?FcId='+${findById.fcId},
				method: 'post',
				scrollbarSize:0,
				rownumbers:true,
			">
		<thead>
			<tr>
				<th data-options="field:'col1',align:'center',
						editor:{
							editable:true,
							type:'combotree',
							options:{
								required:true,
								valueField:'text',
								textField:'text',
								validType:'selectValid',
								method:'post',
								url:'${base}/Expiration/lookupsJson?parentCode=FKXZ',
							}
						}"style="width: 19%">付款性质</th>
				<th data-options="field:'col4',align:'center',editor:{type:'datebox',options:{required:true,precision:1}}"style="width: 26%">预计付款时间</th>
				<th data-options="field:'col5',align:'center',editor:{type:'numberbox',options:{required:true,precision:2,onChange:setFsumMoney}}"style="width: 28%">预计付款金额(元)</th>
				<th data-options="field:'col3',editor:{type:'textbox',options:{required:true}},validType:'length[1,50]',align:'center'"style="width: 26%">付款条件</th>
			</tr>
		</thead>
	</table>
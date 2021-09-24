<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
	<div style="margin: 10px 10px 0 10px;height: 445px;">	
		<table id="cg_apply_Tab" class="easyui-datagrid"
		data-options="collapsible:true,url:'${base}/cgcheck/updatePage?fpId=${bean.fpId }',
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="rowspan:2,field:'fpId',hidden:true"></th>
					<th data-options="rowspan:2,field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="rowspan:2,field:'updateUserName',align:'center'" style="width: 15%">修改人</th>
					<th data-options="rowspan:2,field:'updateTime',align:'center',formatter: ChangeDateFormat" style="width: 20%">修改时间</th>
					<th data-options="rowspan:2,field:'projectName',align:'center'" style="width: 20%">修改项目</th>
					<th data-options="colspan:2,field:'projectName',align:'center'" style="width: 20%">修改前</th>
					<th data-options="colspan:2,field:'projectName',align:'center'" style="width: 20%">修改后</th>
				</tr>
				<tr>
					<th data-options="field:'method',align:'center',formatter: methodType" style="width: 10%">采购方式</th>
					<th data-options="field:'orgType',align:'center',formatter: orgTypeC" style="width: 10%">采购组织形式</th>
					<th data-options="field:'updateMethod',align:'center',formatter: methodType" style="width: 10%">采购方式</th>
					<th data-options="field:'updateOrgType',align:'center',formatter: orgTypeC" style="width: 10%">采购组织形式</th>
				</tr>
			</thead>
		</table>
	</div>
	
	
	<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="closeSecondWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
			</div>
<script type="text/javascript">
function methodType(val,row){
	if(val == 'GKZB'){
		return "公开招标";
	}else if(val == 'YQZB'){
		return "邀请招标";
	}else if(val == 'JZXCS'){
		return "竞争性磋商";
	}else if(val == 'JZXTP'){
		return "竞争性谈判";
	}else if(val == 'DYLYCG'){
		return "单一来源采购";
	}else if(val == 'WSCS'){
		return "网上超市";
	}else if(val == 'XYDDCG'){
		return "协议定点采购";
	}
}
function orgTypeC(val,row){
	if(val == 'JZCG'){
		return "集中采购";
	}else if(val == 'FSCG'){
		return "分散采购";
	}else if(val == 'ZXCG'){
		return "自行采购";
	}
}
</script>
</body>
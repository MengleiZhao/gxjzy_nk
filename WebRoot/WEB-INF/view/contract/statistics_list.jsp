<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<style type="text/css">
 .datagrid-cell {
     text-overflow: ellipsis;
 }
 /* 边框样式 */
.datagrid-body td{
  border-bottom: 1px dashed #ccc;
  border-right: 1px dashed #ccc;
}
.datagrid-htable tr td{
	border-right: 1px solid #fff;
	border-bottom: 1px solid #fff;
}
.progressbar-value,
.progressbar-value .progressbar-text {
  color: #000000;		
}	
</style>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
			<div class="list-table" style="height: 600px">
				<table id="contractTab" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/Ledger/statisticsJsonPagination',
					method:'post',fit:true,singleSelect: true,selectOnCheck: true,checkOnSelect:true,nowrap:false,striped: true">
					<thead>
						<tr>
							<th data-options="field:'0',align:'center',width:100" rowspan="4" >申请部门</th>
							<th data-options="field:'',align:'center',width:620" colspan="6" rowspan="3">综合情况</th>
							<th data-options="field:'',align:'center',width:620" colspan="17" >分类明细情况</th>
						</tr>
						<tr>
							<th data-options="field:'',align:'center'" colspan="9">新签合同</th>
							<th data-options="field:'',align:'center'" colspan="8">结转合同</th>
						</tr>
						<tr>
							<th data-options="field:'',align:'center'" colspan="4">采购类合同</th>
							<th data-options="field:'',align:'center'" colspan="4"  >收入类合同</th>
							<th data-options="field:'',align:'center'" >非经济类合同</th>
							<th data-options="field:'',align:'center'" colspan="4"  >采购类合同</th>
							<th data-options="field:'',align:'center'" colspan="4"  >收入类合同</th>
						</tr>
						<tr>
							<th data-options="field:'1',align:'center',width:140">新签合同份数（份）</th>
							<th data-options="field:'2',align:'center',width:120" >新签金额（元）</th>
							<th data-options="field:'3',align:'center',width:140">结转合同份数（份）</th>
							<th data-options="field:'4',align:'center',width:120" >结转金额（元）</th>
							<th data-options="field:'5',align:'center',width:150" >本年综合执行率（%）</th>
							<th data-options="field:'6',align:'center',width:120">综合执行率（%）</th>
							<th data-options="field:'7',align:'center',width:120" >合同份数（份）</th>
							<th data-options="field:'8',align:'center',width:120">合同金额（元）</th>
							<th data-options="field:'9',align:'center',width:120" >已付款金额（元）</th>
							<th data-options="field:'10',align:'center',width:120" >执行率（%）</th>
							<th data-options="field:'11',align:'center',width:120" >合同份数（份）</th>
							<th data-options="field:'12',align:'center',width:120">合同金额（元）</th>
							<th data-options="field:'13',align:'center',width:120" >已收入金额（元）</th>
							<th data-options="field:'14',align:'center',width:120" >执行率（%）</th>
							<th data-options="field:'15',align:'center',width:140">非经济类份数（份）</th>
							<th data-options="field:'16',align:'center',width:120" >合同份数（份）</th>
							<th data-options="field:'17',align:'center',width:120">合同金额（元）</th>
							<th data-options="field:'18',align:'center',width:120" >已付款金额（元）</th>
							<th data-options="field:'19',align:'center',width:120" >执行率（%）</th>
							<th data-options="field:'20',align:'center',width:120" >合同份数（份）</th>
							<th data-options="field:'21',align:'center',width:120">合同金额（元）</th>
							<th data-options="field:'22',align:'center',width:120" >已收入金额（元）</th>
							<th data-options="field:'23',align:'center',width:120">执行率（%）</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
</body>
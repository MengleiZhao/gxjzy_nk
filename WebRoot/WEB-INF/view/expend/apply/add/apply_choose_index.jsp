<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="win-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>

		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-search" class="queryth">
						&nbsp;&nbsp;支出项目名称&nbsp;
						<input id="apply_indexName" name="" style="width: 150px;height:25px;" class="easyui-textbox"/>
						
						&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="queryApply();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="clearTable();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"></a>
					</td>
				</tr>
			</table>
		</div>
		
		<div class="list-table">
			<div class="tab-wrapper" id="choice" style="height: 440px">
				<ul class="tab-menu">
					<li class="active" onclick="$('#basic-choose-tree').treegrid('reload'),tablist=1">基本支出</li>
					<li onclick="$('#pro-choose-tree').treegrid('reload'),tablist=2">项目支出</li> 
				</ul>
				
				<div class="tab-content">
					<div style="height: 400px">
						<table id="basic-choose-tree"  class="easyui-treegrid" style="width:100%;"
				            data-options="
				                url: '${base}/apply/treeIndex?indexType=0',
				                method: 'get',
				                rownumbers: true,
				                idField: 'id',
				                treeField: 'text',
				                method: 'get'
				            ">
				        	<thead>
				            	<tr>
        					        <th data-options="field:'text'" width="35%">支出预算事项</th>
        					        <th data-options="field:'departName'" width="35%">归口部门</th>
					                <th data-options="field:'col2',hidden:true" width="20%">可用金额（元）</th>
					                <th data-options="field:'col7'" width="30%">冻结金额（元）</th>
				            	</tr>
				        	</thead>
				    	</table> 
					</div>
					
					<div style="height: 400px">
						<table id="pro-choose-tree"  class="easyui-treegrid" style="width:100%;"
				            data-options="
				                url: '${base}/apply/treeIndex?indexType=1',
				                method: 'get',
				                rownumbers: true,
				                idField: 'id',
				                treeField: 'text',
				                method: 'get'
				            ">
					        <thead>
					            <tr>
					                <th data-options="field:'text'" width="35%">支出预算事项</th>
        					        <th data-options="field:'departName'" width="35%">归口部门</th>
					                <th data-options="field:'col2',hidden:true" width="20%">可用金额（元）</th>
					                <th data-options="field:'col7'" width="30%">冻结金额（元）</th>
					            </tr>
					        </thead>
					    </table> 
					</div>
				</div>
			</div>
		</div>
	</div>
	
<script type="text/javascript">

//初始化
$(function(){
	//tab
	flashtab('choice');
	//双击选择-基本支出
	initJbzc();
	//双击选择-项目支出
	initXmzc();
	//指标类型
	var tablist=1;
});

//清除查询条件
function clearTable() {
	$("#apply_indexName").textbox('setValue', '');
	queryApply();
}

//查询
function queryApply() {
	$("#basic-choose-tree").treegrid('load', {
		indexName:$("#apply_indexName").textbox('getValue').trim(),
	});
	$("#pro-choose-tree").treegrid('load', {
		indexName:$("#apply_indexName").textbox('getValue').trim(),
	});
}

//双击选择基本支出
function initJbzc(){
	$('#basic-choose-tree').treegrid({
		onDblClickRow:function(row){
			
			console.log(row);
			if (row.code == null) {
				alert('请选择具体的基本支出指标！');
				return;
			}
			
			//指标id
			$("#F_fBudgetIndexCode").val(row.col3);
			$("#Fc_fBudgetIndexCode").val(row.col3);//crc
			//项目明细id
			$("#F_proDetailId").val(row.id);
			//指标代码
			$("#m_fBIndexCode").val(row.code);
			//指标名称
			$("#F_fBudgetIndexName").textbox('setValue',row.col8+" 【 "+row.text+" 】");
			//指标类型
			$("#F_indexType").val(0);
			//采购指标代码
			$("#F_indexCode").val(row.col9);
			//采购指标名称
			$("#F_indexName").textbox('setValue',row.col8+" 【 "+row.text+" 】");
			//可用金额
			$("#F_fAvailableAmount").textbox('setValue',row.col2/10000);//crc
			//借款申请的可用金额
			$("#indexAmount").val(row.col2);//liad
			//直接报销可用金额
			$("#syjeamount").val(row.col2);//liad
			//预算项目ID
			$("#F_proId").val(row._parentId);
			
			/* //显示项目负责人 
			$("#F_proCharger").textbox('setValue',row.col1);
			$("#content_xmfzr").show();
			$("#title_xmfzr").show(); */
			if(row.isdepartment == '0'){
				$("#ktname").show();
			}else{
				$("#ktname").hide();
			}
			//可用金额
			if (row.col2!='null') {
				var syAmount=fomatMoney(row.col2,2);
				$('#p_syAmount').html(syAmount+" [元]");
				$('#syAmount').val(parseFloat(row.col2));
			}
			//批复金额
			if (row.col4!='null') {
				var pfAmount=fomatMoney(row.col4,2);
				$('#p_pfAmount').html(pfAmount+" [元]");
			}
			//批复时间
			if (row.col5!='null') {
				var date =(row.col5).substring(0,4);
				$('#p_pfDate').html(date);
			}
			//使用部门
			if (row.col6!='null') {
				$('#p_pfDepartName').html(row.col6);
			}
				$('#p_pfIndexType').html("基本预算");
			closeFirstWindow();
		}
	});	
	
}

//双击选择项目支出
function initXmzc(){
	$('#pro-choose-tree').treegrid({
		onDblClickRow:function(row){
			//console.log(row);
			if (row.code == null) {
				alert('请选择具体的项目指标！');
				return;
			}

			
			//指标id
			$("#F_fBudgetIndexCode").val(row.col3);
			$("#Fc_fBudgetIndexCode").val(row.col3);//crc
			//项目明细id
			$("#F_proDetailId").val(row.id);
			//指标代码
			$("#m_fBIndexCode").val(row.code);
			//指标名称
			$("#F_fBudgetIndexName").textbox('setValue',row.col8+" 【 "+row.text+" 】");
			//指标类型
			$("#F_indexType").val(1);
			//采购指标代码
			$("#F_indexCode").val(row.col9);
			//采购指标名称
			$("#F_indexName").textbox('setValue',row.col8+" 【 "+row.text+" 】");
			//可用金额
			$("#F_fAvailableAmount").textbox('setValue',row.col2/10000);//crc
			//借款申请的可用金额
			$("#indexAmount").val(row.col2);//liad
			//直接报销可用金额
			$("#syjeamount").val(row.col2);//liad
			//预算项目ID
			$("#F_proId").val(row._parentId);
			/* //显示项目负责人 
			$("#F_proCharger").textbox('setValue',row.col1);
			$("#content_xmfzr").show();
			$("#title_xmfzr").show(); */
			if(row.isdepartment == '0'){
				$("#ktname").show();
			}else{
				$("#ktname").hide();
			}
			//可用金额
			if (row.col2!='null') {
				var syAmount=fomatMoney(row.col2,2);
				$('#p_syAmount').html(syAmount+" [元]");
				$('#syAmount').val(parseFloat(row.col2));
			}
			//批复金额
			if (row.col4!='null') {
				var pfAmount=fomatMoney(row.col4,2);
				$('#p_pfAmount').html(pfAmount+" [元]");
			}
			//批复时间
			if (row.col5!='null') {
				var date =(row.col5).substring(0,4);
				$('#p_pfDate').html(date);
			}
			//使用部门
			if (row.col6!='null') {
				$('#p_pfDepartName').html(row.col6);
			}
			$('#p_pfIndexType').html("项目预算");
			/* if(4=='${type}'){
				//刷新右侧审批流
				$("#check_system_div").load("${base}/cgsqsp/refreshProcess?fpPype="+n+'&fUser='+userid);
			} */
			
			closeFirstWindow();
		}
	});	
	
}

function PitchOnC(){
	
	return;
	
	var row=null;
	if(tablist==1){
		row = $('#basic-choose-tree').datagrid('getSelected');
	}else if(tablist==2){
		row = $('#pro-choose-tree').datagrid('getSelected');
	}
	$("#F_fBudgetIndexCode").val(row.bId);
	$("#m_fBIndexCode").val(row.indexCode);
	$("#F_fBudgetIndexName").textbox('setValue',row.indexName);//支出事项申请-新增-预算指标
	if(row.indexType=='2'){
		$("#F_fBudgetIndexName").textbox('setValue',row.proCharger);//支出事项申请-新增-项目负责人
		$("#content_xmfzr").show();
		$("#title_xmfzr").show();
	}else{
		$("#F_fBudgetIndexName").textbox('setValue','');
		$("#content_xmfzr").hide();
		$("#title_xmfzr").hide();
	}
	$("#F_indexType").val(row.indexType);
	$("#F_fAvailableAmount").textbox('setValue',row.syAmount);
	closeFirstWindow();
}

function clickIndex(index, row) {
	$('#zbpfje').html(row.pfAmount);
	$('#zbsyje').html(row.syAmount);
	$('#zbdjje').html(row.djAmount);
}

//批复金额颜色
function pfcolor(val, row) {
	val = listToFixed(val, row);
	return '<span style="color:#5196d4">'+val+'</span>';
}

//剩余金额颜色
function sycolor(val, row) {
	val = listToFixed(val, row);
	return '<span style="color:#97cd5c">'+val+'</span>';
}

//冻结金额颜色
function djcolor(val, row) {
	val = listToFixed(val, row);
	return '<span style="color:#999999">'+val+'</span>';
}
</script>
</body>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="win-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<%-- <td class="top-table-search" class="queryth">预算指标名称&nbsp;
						<input class="easyui-textbox" id="confplan_indexName" name="indexName" style="width: 150px;height:25px;"/>
						&nbsp;
						<a href="javascript:void(0)" onclick="queryIndex();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')">
						</a>
						&nbsp;
						<a href="javascript:void(0)"  onclick="clearIndex();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')">
						</a>
					</td> --%>
				</tr>
			</table>
		</div>
		
		<div class="list-table">
			<div class="tab-wrapper" id="choose_index" style="height: 440px">
				<ul class="tab-menu">
					<li class="active" onclick="$('#basic-choose-tree').treegrid('reload'),tablist=0">基本支出指标</li>
					<li onclick="$('#pro-choose-tree').treegrid('reload'),tablist=1">项目指标</li> 
				</ul>
				
				<div class="tab-content">
					<div style="height: 400px">
						<table id="basic-choose-tree"  class="easyui-treegrid" style="width:100%;"
				        	data-options="
				                url: '${base}/cgconfplan/indexTree?indexType=0',
				                method: 'get',
				                rownumbers: true,
				                idField: 'id',
				                treeField: 'text',
				                method: 'get'
				            ">
				        	<thead>
				            	<tr>
        					        <th data-options="field:'text',align:'left'" width="40%">指标名称</th>
        					        <th data-options="field:'col7',align:'right'" width="21%">指标批复金额[元]</th>
					                <th data-options="field:'col8',align:'right'" width="21%">指标可用金额[元]</th>
					                <th data-options="field:'col9',align:'right'" width="21%">指标冻结金额[元]</th>
				            	</tr>
				        	</thead>
				    	</table> 
					</div>
					
					<div style="height: 400px">
						<table id="pro-choose-tree"  class="easyui-treegrid" style="width:97.5%;"
				            data-options="
				                url: '${base}/cgconfplan/indexTree?indexType=1',
				                method: 'get',
				                rownumbers: true,
				                idField: 'id',
				                treeField: 'text',
				                method: 'get'
				            ">
					        <thead>
					            <tr>
					                <th data-options="field:'text',align:'left'" width="40%">指标名称</th>
					                <th data-options="field:'col7',align:'right'" width="21%">指标批复金额[元]</th>
					                <th data-options="field:'col8',align:'right'" width="21%">指标可用金额[元]</th>
					                <th data-options="field:'col9',align:'right'" width="21%">指标冻结金额[元]</th>
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
	flashtab('choose_index');
	//双击选择-基本支出
	initJbzc();
	//双击选择-项目支出
	initXmzc();
	//指标类型
	var tablist = 0;
});

//清除查询条件
function clearIndex() {
	$('#confplan_indexName').textbox('setValue', '');
	queryIndex();
}

//查询
function queryIndex() {
	$('#basic-choose-tree').datagrid('load',{
		indexName : $('#confplan_indexName').textbox('getValue').trim(),
	});
	$('#pro-choose-tree').datagrid('load',{
		indexName : $('#confplan_indexName').textbox('getValue').trim(),
	});
}

//双击选择基本支出
function initJbzc(){
	$('#basic-choose-tree').treegrid({
		onDblClickRow:function(row){
			if (row.code == null) {
				alert('请选择具体的基本支出指标！');
				return;
			}
			
			$('#F_indexId').val(row.col1);//指标id
			$('#F_indexCode').val(row.col2);//指标编码
			$('#F_indexName').textbox('setValue', row.col3 + " 【 "+row.text+" 】");//指标名称
			
			$('#F_syAmount').numberbox('setValue', row.col8);//指标可用金额
			closeFirstWindow();
		}
	});	
}

//双击选择项目支出
function initXmzc(){
	$('#pro-choose-tree').treegrid({
		onDblClickRow:function(row){
			if (row.code == null) {
				alert('请选择具体的项目指标！');
				return;
			}
			
			$('#F_indexId').val(row.col1);//指标id
			$('#F_indexCode').val(row.col2);//指标编码
			$('#F_indexName').textbox('setValue', row.col3 + " 【 "+row.text+" 】");//指标名称
			
			$('#F_syAmount').numberbox('setValue', row.col8);//指标可用金额
			closeFirstWindow();
		}
	});	
}
</script>
</body>
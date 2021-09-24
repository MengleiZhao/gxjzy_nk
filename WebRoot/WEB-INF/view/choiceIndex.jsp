<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="win-div">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true" style="width: 600px">
			<div class="tab-wrapper" id="choice" style="height: 440px">
				<ul class="tab-menu">
					<li class="active" onclick="$('#basic-choose-tree').datagrid('reload'),tablist=1">基本支出指标</li>
					<li onclick="$('#pro-choose-tree').datagrid('reload'),tablist=2">项目支出指标</li>
				</ul>
				
				<div class="tab-content">
					<div style="height: 400px">
						<table id="basic-choose-tree"  class="easyui-datagrid" style="width:100%;"
				            data-options="
				                url: '${base}/quota/insideOrProject?indexType=0',onClickRow:clickIndex,
				            	collapsible:true,method:'post',fit:true,pagination:true,singleSelect: true,rownumbers:true,
								selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true,
				            ">
				        	<thead>
				            	<tr>
				                <th data-options="field:'bId',hidden:true"></th>
				                <th data-options="field:'indexName'" width="25%">预算指标名称</th>
				                <th data-options="field:'pfAmount',formatter:pfcolor" width="25%" >指标批复金额[万元]</th>
				                <th data-options="field:'syAmount',formatter:sycolor" width="25%" >指标剩余金额[万元]</th>
				                <th data-options="field:'djAmount',formatter:djcolor" width="25%" >指标冻结金额[万元]</th>
				            	</tr>
				        	</thead>
				    	</table> 
					</div>
					
					<div style="height: 400px">
						<table id="pro-choose-tree"  class="easyui-datagrid" style="width:100%;"
				            data-options="
				                url: '${base}/quota/insideOrProject?indexType=1',onClickRow:clickIndex,
				              	collapsible:true,method:'post',fit:true,pagination:true,singleSelect: true,rownumbers:true,
								selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true,
				            ">
				        	<thead>
				            	<tr>
				                <th data-options="field:'bId',hidden:true"></th>
				                <th data-options="field:'indexName'" width="25%">预算指标名称</th>
				                <th data-options="field:'pfAmount',formatter:pfcolor" width="25%" >指标批复金额[万元]</th>
				                <th data-options="field:'syAmount',formatter:sycolor" width="25%" >指标剩余金额[万元]</th>
				                <th data-options="field:'djAmount',formatter:djcolor" width="25%" >指标冻结金额[万元]</th>
				            	</tr>
				        	</thead>
				    	</table> 
					</div>
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="PitchOnC()">
				<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeFirstWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		
		<div class="win-right-div" data-options="region:'east',split:true" style="width: 190px">
			<table style="width: 100%">
				<tr>
					<td style="height: 28px;text-align: center;">指标使用情况</td>
				</tr>
				<tr>
					<td>
					<img  src="${base}/resource-modality/${themenurl}/skin_/hengxian.png" style="width: 148px;margin-left: 20px">
					</td>
				</tr>
				<tr>
				<td style="height: 31px;" id="bfb">
					<table style="margin-left: 20px">
						<tr><td>指标总额：<span id="zbpfje"></span>万元</td></tr>
						<tr><td>剩余金额：<span id="zbsyje"></span>万元</td></tr>
						<tr><td>冻结金额：<span id="zbdjje"></span>万元</td></tr>
						<tr><td>
							<img src="${base}/resource-modality/${themenurl}/skin_/hengxian.png" style="width: 148px;">
						</td></tr>
						<tr><td>预算不够啦？请调整指标预算！&nbsp;<a href="#" style="color: red">指标预算调整</a></td></tr>
					</table>
				</td>
			</tr>
			</table>
		</div>
	</div>
</div>
	
<script type="text/javascript">
flashtab('choice');

//选择指标
var tablist=1;
function PitchOnC(){
	var row=null;
	//判断选择的是基础指标还是项目指标
	if(tablist==1){
		//基本指标
		row = $('#basic-choose-tree').datagrid('getSelected');
	}else if(tablist==2){
		//项目指标
		row = $('#pro-choose-tree').datagrid('getSelected');
	}
	$("#F_fBudgetIndexCode").val(row.bId);//指标id
	$("#m_fBIndexCode").val(row.indexCode);//指标代码
	$("#F_fBudgetIndexName").textbox('setValue',row.indexName);//指标名称
	$("#F_indexType").val(row.indexType);//指标类型
	$("#F_fAvailableAmount").textbox('setValue',row.syAmount);//可用金额
	if(row.indexType=='2'){
		$("#content_xmfzr").textbox('setValue',row.proCharger);//项目负责人
		$("#content_xmfzr").show();//显示
		$("#title_xmfzr").show();
	}else{
		$("#content_xmfzr").textbox('setValue','');//项目负责人
		$("#content_xmfzr").hide();//隐藏
		$("#title_xmfzr").hide();
	}
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

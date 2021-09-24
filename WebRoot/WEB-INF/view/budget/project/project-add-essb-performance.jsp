<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

	<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 990px;height:auto">
		<div title="绩效目标申报" data-options="collapsed:false,collapsible:false"style="overflow:auto;width: 980px;height:auto">
			<table cellpadding="0" cellspacing="0">
	 			<tr class="trbody">
					<td class="td1-ys"><span class="style_must">*</span>&nbsp;年度</td>
	     			<td class="td2">
	     				<input class="easyui-textbox" data-options="required:false" style="height:30px; width: 300px" 
	     				id="project-add-year" name="year" value="${bean.year}" />
	     			</td>
	     			<td class="td3-ys" style="width: 35px;"></td>
					<td class="td1-ys"><span class="style_must">*</span>项目实施进展情况（含投资评审）</td>
	   				<td class="td2">
	   					<input class="easyui-textbox" data-options="required:false" style="height:30px; width: 300px" 
	     				id="project-add-implementProgress" name="implementProgress" value="${bean.implementProgress}" />
	   				</td>
				</tr>
	 			<tr class="trbody">
					<td class="td1-ys"><span class="style_must">*</span>&nbsp;年度绩效目标</td>
	     			<td class="td2">
	     				<input class="easyui-textbox" data-options="required:false" style="height:30px; width: 300px" 
	     				id="project-add-yearTarget" name="yearTarget" value="${bean.yearTarget}" />
	     			</td>
	     			<td class="td3-ys" style="width: 35px;"></td>
					<td class="td1-ys"><span class="style_must">*</span>&nbsp;中期绩效目标</td>
	   				<td class="td2">
	   					<input class="easyui-textbox" data-options="required:false" style="height:30px; width: 300px" 
	     				id="project-add-mediumTarget" name="mediumTarget" value="${bean.mediumTarget}" />
	   				</td>
				</tr>
			</table>
		<div style="overflow:auto;margin-top: 0px;">
			<table id="performanceEssb" class="easyui-datagrid" style="width:980px;height:auto"
						data-options="
						singleSelect: true,
						toolbar: '#performance_toolbar_essb_Id',
						rownumbers : true,
						url: '${base}/project/proIndexList?fProId=${bean.FProId}',
						method: 'post',
						onClickRow: onClickRow_performanceEssb,
						striped : true,
						nowrap : false,
						rownumbers:true,
						scrollbarSize:0
						">
						<thead>
					<tr>
						<th data-options="field:'tOneCode',align:'center',hidden:true,editor:{type:'textbox',options:{requerd:true}}" style="width: 15%">一级指标编码</th>
						<th data-options="field:'tOneName',align:'center',editor:{
					  					editable:true,
										type:'combotree',
										options:{
											valueField:'id',//编码
											textField:'text', //名称
											method:'post',
											validType:'selectValid',
											required:true,
											url: '${base}/PerformanceIndicator/performanceIndicatorJson',
											onSelect:function(item){
											
												if('-请选择-' == item.text){
													return false;
												}
												var index=$('#performanceEssb').datagrid('getRowIndex',$('#performanceEssb').datagrid('getSelected'));
												var tr = $('#performanceEssb').datagrid('getEditors', index);
												tr[0].target.textbox('setValue', item.id);
											}
										}
									}" style="width: 15%">一级指标</th>
						<th data-options="field:'tTwoCode',align:'center',hidden:true,editor:{type:'textbox',options:{}}" style="width: 15%">二级指标编码</th>
						<th data-options="field:'tTwoName',align:'center',editor:{
										type:'combotree',
										options:{
											valueField:'id',//编码
						  					editable:true,
											textField:'text', //名称
											method:'post',
											validType:'selectValid',
											onShowPanel:function(){
											
												var index=$('#performanceEssb').datagrid('getRowIndex',$('#performanceEssb').datagrid('getSelected'));
												var tr = $('#performanceEssb').datagrid('getEditors', index);
												var tOneCode = $('#performanceEssb').datagrid('getEditor',{
													index:index,
													field:'tOneCode'
												});
												var tTwoName = $('#performanceEssb').datagrid('getEditor',{
													index:index,
													field:'tTwoName'
												});
												var tOneCode = tOneCode.target.textbox('getValue');
												if(tOneCode==''){
													alert('请选择一级指标！');
													return false;
												}
												var url = base+'/PerformanceIndicator/performanceIndicatorTwoJson?id='+tOneCode;
   												$(tTwoName.target).combotree('reload', url);
											},
											onSelect:function(item){
												var index=$('#performanceEssb').datagrid('getRowIndex',$('#performanceEssb').datagrid('getSelected'));
												var tr = $('#performanceEssb').datagrid('getEditors', index);
												tr[2].target.textbox('setValue', item.id);
											}
										}
									}" style="width: 15%">二级指标</th>
							<th data-options="field:'indexContent',align:'center',editor:{type:'combobox',
									options:{
										hasDownArrow:true,
										editable:true,
										valueField:'text',
										textField:'text',
										method:'post',
										url:base+'/PerformanceIndicator/getPerformanceIndicator3'
									}
								}" style="width:43%">指标内容</th>
						<th data-options="field:'tIndexVal',align:'center',editor:{type:'textbox',options:{requerd:true}}" style="width: 27%">指标值</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="performance_toolbar_essb_Id" style="height:30px;width: 865px;margin-top: 5px;">
			<input type="hidden" id="totalityPerformanceJson" name="totalityPerformanceJson"/>
			<a style="float: right;" href="javascript:void(0)" onclick="expenddetailsremoveitEssb()"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
			<a style="float: right;">&nbsp;&nbsp;</a>
			<a style="float: right;" href="javascript:void(0)" onclick="performanceAppendEssb()"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
			<a style="float: right;">&nbsp;&nbsp;</a>
			<a style="float: right;" href="#" onclick="exportXmPerformanceEssb()">
				<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/daochu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a> 
		</div>
		<div style="color: red;margin-left: 20px">
			提示：产出指标中四个二级指标必须填写，效益指标二级指标中四选一必须填写一种，满意度必须填写，指标值必须量化。
		</div>
	</div>
</div>

<script type="text/javascript">

var performanceEditEssbIndex = undefined;
var expenddetailsCount=0;
var numIndex=0;
//添加一行
function performanceAppendEssb() {
	 if (performanceEndEditingEssb()) {
			$('#performanceEssb').datagrid('appendRow', {});
			beginIndex = $('#performanceEssb').datagrid('getRows').length - 1;
			$('#performanceEssb').datagrid('selectRow', beginIndex).datagrid('beginEdit', beginIndex);
			performanceEditEssbIndex=beginIndex;
		}
}
//删除一行
function expenddetailsremoveitEssb() {
	if (performanceEditEssbIndex == undefined) {
		alert('请点击要删除的行！');
		return;
	}
	$('#performanceEssb').datagrid('cancelEdit', performanceEditEssbIndex).datagrid('deleteRow',
			performanceEditEssbIndex);
	performanceEditEssbIndex = undefined;
	
}

//使列表结束编辑状态
function performanceAcceptEssb() {
	if (performanceEndEditingEssb()) {
		$('#performanceEssb').datagrid('acceptChanges');
	}
}
//结束编辑状态
function performanceEndEditingEssb() {
	if (performanceEditEssbIndex == undefined) {
		return true;
	}
	if ($('#performanceEssb').datagrid('validateRow', performanceEditEssbIndex)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#performanceEssb').datagrid('getEditors', performanceEditEssbIndex);
		var text1=tr[1].target.combotree('getText');
		if(text1!='--请选择--'){
			tr[1].target.combotree('setValue',text1);
		}
		var text3=tr[3].target.combotree('getText');
		if(text3!='--请选择--'){
			tr[3].target.combotree('setValue',text3);
		}
		var text4=tr[4].target.combobox('getText');
		if(text4!='--请选择--'){
			tr[4].target.combobox('setValue',text4);
		}
		$('#performanceEssb').datagrid('endEdit', performanceEditEssbIndex);
		performanceEditEssbIndex = undefined;
		return true;
	} else {
		return false;
	}
}
//行被点击事件
function onClickRow_performanceEssb(index) {
	if (performanceEditEssbIndex != index) {
		if (performanceEndEditingEssb()) {
			$('#performanceEssb').datagrid('selectRow', index).datagrid('beginEdit', index);
			performanceEditEssbIndex = index;
		} else {
			$('#performanceEssb').datagrid('selectRow', performanceEditEssbIndex);
		}
	}
}

//存入json
function getPerformanceJsonEssb(){
	performanceAcceptEssb();
	var rows = $('#performanceEssb').datagrid('getRows');
	var performance = "";
	for (var j = 0; j < rows.length; j++) {
		performance = performance + JSON.stringify(rows[j]) + ",";
	}
	$('#totalityPerformanceJson').val(performance);
}


function onLoadSuccessPerFormanceESSB(){
	$('#performanceEssb').datagrid('appendRow', {
		tOneCode:1,
		tOneName:'产出指标',
		tTwoCode:1,
		tTwoName:'产出数量'
	});
	$('#performanceEssb').datagrid('appendRow', {
		tOneCode:1,
		tOneName:'产出指标',
		tTwoCode:2,
		tTwoName:'产出质量'
	});
	$('#performanceEssb').datagrid('appendRow', {
		tOneCode:1,
		tOneName:'产出指标',
		tTwoCode:3,
		tTwoName:'产出时效'
	});
	$('#performanceEssb').datagrid('appendRow', {
		tOneCode:1,
		tOneName:'产出指标',
		tTwoCode:4,
		tTwoName:'产出成本'
	});
	$('#performanceEssb').datagrid('appendRow', {
		tOneCode:2,
		tOneName:'效益指标',
		tTwoCode:5,
		tTwoName:'经济效益'
	});
	$('#performanceEssb').datagrid('appendRow', {
		tOneCode:2,
		tOneName:'效益指标',
		tTwoCode:6,
		tTwoName:'社会效益'
	});
	$('#performanceEssb').datagrid('appendRow', {
		tOneCode:2,
		tOneName:'效益指标',
		tTwoCode:7,
		tTwoName:'生态效益'
	});
	$('#performanceEssb').datagrid('appendRow', {
		tOneCode:2,
		tOneName:'效益指标',
		tTwoCode:8,
		tTwoName:'可持续影响'
	});
	$('#performanceEssb').datagrid('appendRow', {
		tOneCode:3,
		tOneName:'满意度指标'
	});
}

//存入json
function getPerformanceJsonExportEssb(){
	performanceAcceptEssb();
	var rows = $('#performanceEssb').datagrid('getRows');
	var performance = "";
	for (var j = 0; j < rows.length; j++) {
		performance = performance + JSON.stringify(rows[j]) + ",";
	}
	$('#form_pro_export_essb_json').val(performance);
}

function exportXmPerformanceEssb(){
	if(confirm('是否导出？')){
		getPerformanceJsonExportEssb();
		$('#form_pro_export_performance_essb').attr('action','${base}/project/exportPerformance');
		$('#form_pro_export_performance_essb').submit();
	}
}
</script>
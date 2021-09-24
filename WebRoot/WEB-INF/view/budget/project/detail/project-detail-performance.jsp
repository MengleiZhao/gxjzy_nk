<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
	<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 990px;height:auto">
		<div id="mingxiJXMBDetail" title="绩效目标申报" data-options="collapsed:false,collapsible:false"style="overflow:auto;width: 980px;height:auto">
		<table cellpadding="0" cellspacing="0">
 			<tr class="trbody">
				<td class="td1-ys"><span class="style_must">*</span>&nbsp;年度</td>
     			<td class="td2">
     				<input class="easyui-textbox" data-options="required:false" style="height:30px; width: 300px" readonly="readonly"
     				id="project-add-year" name="year" value="${bean.year}" />
     			</td>
     			<td class="td3-ys" style="width: 35px;"></td>
				<td class="td1-ys"><span class="style_must">*</span>项目实施进展情况（含投资评审）</td>
   				<td class="td2">
   					<input class="easyui-textbox" data-options="required:false" style="height:30px; width: 300px"  readonly="readonly"
     				id="project-add-implementProgress" name="implementProgress" value="${bean.implementProgress}" />
   				</td>
			</tr>
 			<tr class="trbody">
				<td class="td1-ys"><span class="style_must">*</span>&nbsp;年度绩效目标</td>
     			<td class="td2">
     				<input class="easyui-textbox" data-options="required:false" style="height:30px; width: 300px"  readonly="readonly"
     				id="project-add-yearTarget" name="yearTarget" value="${bean.yearTarget}" />
     			</td>
     			<td class="td3-ys" style="width: 35px;"></td>
				<td class="td1-ys"><span class="style_must">*</span>&nbsp;中期绩效目标</td>
   				<td class="td2">
   					<input class="easyui-textbox" data-options="required:false" style="height:30px; width: 300px"  readonly="readonly"
     				id="project-add-mediumTarget" name="mediumTarget" value="${bean.mediumTarget}" />
   				</td>
			</tr>
		</table>
		<div style="overflow:auto;margin-top: 0px;">
			<table id="performanceDetail" class="easyui-datagrid" style="width:980px;height:auto"
						data-options="
						singleSelect: true,
						toolbar: '#performance_toolbar_detail_Id',
						rownumbers : true,
						url: '${base}/project/proIndexList?fProId=${bean.FProId}',
						method: 'post',
						striped : true,
						nowrap : false,
						rownumbers:true,
						scrollbarSize:0
						">
						<thead>
					<tr>
						<th data-options="field:'tOneCode',align:'center',hidden:true" style="width: 15%">一级指标编码</th>
						<th data-options="field:'tOneName',align:'center'" style="width: 18%">一级指标</th>
						<th data-options="field:'tTwoCode',align:'center',hidden:true" style="width: 15%">二级指标编码</th>
						<th data-options="field:'tTwoName',align:'center'" style="width: 18%">二级指标</th>
						<th data-options="field:'indexContent',align:'center'" style="width: 35%">指标内容</th>
						<th data-options="field:'tIndexVal',align:'center'" style="width: 27%">指标值</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="performance_toolbar_detail_Id" style="height:30px;width: 865px;margin-top: 5px;">
			<a style="float: right;" href="#" onclick="exportXmPerformanceDetail()">
				<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/daochu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a> 
		</div>
		<div style="color: red;margin-left: 20px">
		提示：产出指标中四个二级指标必须填写，效益指标二级指标中四选一必须填写一种，满意度必须填写，指标值必须量化。
		</div>
	</div>
</div>
<script type="text/javascript">

//存入json
function getPerformanceJsonExportDetail(){
	var rows = $('#performanceDetail').datagrid('getRows');
	var performance = "";
	for (var j = 0; j < rows.length; j++) {
		performance = performance + JSON.stringify(rows[j]) + ",";
	}
	$('#form_pro_export_detail_json').val(performance);
}


function exportXmPerformanceDetail(){
	if(confirm('是否导出？')){
		getPerformanceJsonExportDetail();
		$('#form_pro_export_performance_detail').attr('action','${base}/project/exportPerformance');
		$('#form_pro_export_performance_detail').submit();
	}
}
</script>
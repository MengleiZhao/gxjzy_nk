<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
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
				<!----------------------------- 报表2 执行过程界面 ------------------------------>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr id="data_index_top">
				<td class="top-table-search-pro">
					预算年度
					<select class="easyui-combobox" id="execute_second_three_year" style="width: 120px;height: 25px;" data-options="editable:false, panelHeight:'auto'">
						<c:forEach items="${yearList}" var="ye">
							<option value="${ye}" <c:if test="${ye == year}">selected="selected"</c:if>>&nbsp;${ye }</option>
						</c:forEach>
					</select>
					<c:if test="${sign==0}">
					&nbsp;&nbsp;申报阶段
					<select class="easyui-combobox" id="analysisType" name="analysisType" style="width: 120px;height: 25px;" data-options="editable:false, panelHeight:'auto'">
						<option value="1" selected="selected">一上</option>
						<option value="3">一下</option>
						<option value="4">二上</option>
						<option value="5">二下</option>
					</select>
					&nbsp;&nbsp;数据状态
					<select class="easyui-combobox" id="dataType" name="dataType" style="width: 120px;height: 25px;" data-options="editable:false, panelHeight:'auto'">
						<option value="1" selected="selected">过程</option>
						<option value="2">终稿</option>
					</select>
					</c:if>
					<%-- &nbsp;&nbsp;部门
					<input class="easyui-combotree" id="deptSelect" name="secondLevelCode" style="width: 500px;height: 25px;" data-options="url:'${base}/bData/deptTree',editable:false,multiple:true, panelHeight:'auto'">
						<option value="allDept">所有部门</option>
						<c:forEach var="i" items="${deptList}" varStatus="val">
							<option value="${i.id}">${i.name}</option>
						</c:forEach>
					</select> --%>
					&nbsp;&nbsp;<a href="#" onclick="data_collect_query();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clear_data_collect();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				<td align="right" style="padding-right: 10px;width:70px;">
					<a href="#" onclick="exportDataReportCollect();">
						<img src="${base}/resource-modality/${themenurl}/button/daochu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>   
	</div> 
	
	<div class="list-table">
		<table id="report_collect_three" class="easyui-datagrid" 
		data-options="collapsible:true,url:'${base}/bData/threeCollectDataByType?sign=${sign}',
			method:'post',fit:true,pagination:false,singleSelect: false,rownumbers:true,
		 selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:true,striped: true,fitColumns: true" >
			<thead>
				<tr frozen="true">	
					<th data-options="rowspan:2,field:'0',align:'center',resizbale:true" style="width: 15%">部门编码</th>
					<th data-options="rowspan:2,field:'1',align:'center',resizbale:true" style="width: 15%">部门</th>
					<th data-options="colspan:3,align:'center'" style="">基本支出</th>
					<th data-options="colspan:3,align:'center'" style="">项目支出</th>
					<th data-options="rowspan:2,field:'8',align:'right',resizbale:true,formatter:listToFixed" style="width: 10.5%">支出合计</th>
				</tr>
				<tr>
					<th data-options="field:'2',align:'right',resizable:true,formatter:listToFixed" style="width: 10%">日常基本</th>
					<th data-options="field:'3',align:'right',resizable:true,formatter:listToFixed" style="width: 10%">校级项目</th>
					<th data-options="field:'4',align:'right',resizable:true,formatter:listToFixed" style="width: 10%">基本合计</th>
					<th data-options="field:'5',align:'right',resizable:true,formatter:listToFixed" style="width: 10%">横向项目</th>
					<th data-options="field:'6',align:'right',resizable:true,formatter:listToFixed" style="width: 10%">财拨项目</th>
					<th data-options="field:'7',align:'right',resizable:true,formatter:listToFixed" style="width: 10%">项目合计</th>
				</tr>
			</thead>
		</table>
	</div>
</div>

<script type="text/javascript">
$(function(){
	$('#deptSelect').combotree({
		onCheck : function (node, checked){
			if(checked){
				//选中所有部门
				if(node.id==-1){
					var valArr = $('#deptSelect').combotree('tree').tree('getChecked');
					if(valArr.length>0){
						for (var i = 0; i < valArr.length; i++) {
							if(valArr[i].text!=node.text){
								$('#deptSelect').combotree('tree').tree('uncheck',valArr[i].target);
							}
						}
					}
				}else{
					var node = $('#deptSelect').combotree('tree').tree('find', -1);
					$('#deptSelect').combotree('tree').tree('uncheck',node.target);
				}
			}
		}
	});
});

function valMethod(val,row){
	if(val=='' || val==null){
		return;
	}
	return val.toFixed(2);
}
//点击查询
function data_collect_query() {
	//var deptList=new Array();
	//var checkVal=$('#deptSelect').combotree('tree').tree('getChecked');
	var year=$('#execute_second_three_year').combobox('getValue');
	if(${sign==0}){
		
		var analysisType = $('#analysisType').combobox('getValue');
		var dataType = $('#dataType').combobox('getValue');
		$('#report_collect_three').datagrid('load', {
			year:year,
			/* deptArr : deptList.join(',') */
			analysisType : analysisType,
			dataType:dataType
			
		});
	}else{
		$('#report_collect_three').datagrid('load', {
			year:year,
		});
	}
	/* if(checkVal.length>0){
		for (var i = 0; i < checkVal.length; i++) {
			deptList.push(checkVal[i].id);
		}
	}else{
		alert('请选择部门!');
		return;
	} */

}
//清除查询条件
function clear_data_collect() {
	addTabs('报表二','${base}/bData/threeCollectJsp?sign=${sign}');
}

//导出
function exportDataReportCollect(){
	var  time=ChangeDateFormat(new Date());
	var rows = $('#report_collect_three').datagrid('getRows');
		$('#report_collect_three').datagrid('toExcel', {
	    filename: '报表三.xls',
	    rows: rows,
	    worksheet: 'Worksheet'
	}); 
}
</script>
</body>


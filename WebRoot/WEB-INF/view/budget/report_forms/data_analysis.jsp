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
<script type="text/javascript" src="${base}/resource/office/datagrid-export.js"></script>
		<!----------------------------- 报表一 报表界面 ------------------------------>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr id="data_index_top">
				<td class="top-table-search-pro" style="width:95%">
					&nbsp;&nbsp;预算年度
					<select class="easyui-combobox" id="select_year" name="year" style="width: 120px;height: 25px;" data-options="editable:false, panelHeight:'auto'">
						<c:forEach items="${yearList}" var="ye">
							<option value="${ye}" <c:if test="${ye == year }">selected="selected"</c:if>>&nbsp;${ye }</option>
						</c:forEach>
					</select>
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
					&nbsp;&nbsp;校内项目
					<input id="school_project" name="secondLevelCode" type="checkbox" value="4003"></input>
					&nbsp;&nbsp;&nbsp;财政项目
					<input id="finance_project" name="secondLevelCode" type="checkbox" value="4001"></input>
					&nbsp;&nbsp;&nbsp;横向项目
					<input id="crosswise_project" name="secondLevelCode" type="checkbox" value="4002"></input>
					&nbsp;&nbsp;&nbsp;基本支出
					<input id="basic_expend" name="secondLevelCode" type="checkbox" value="XD-01"></input>
					
					
					&nbsp;&nbsp;<a href="#" onclick="data_analy_query();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clear_data_analy();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/clear1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				<td align="right" style="padding-right: 10px;width:70px;">
					<a href="#" onclick="exportDataAnalysis();">
						<img src="${base}/resource-modality/${themenurl}/button/daochu1.png"  onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>   
	</div>
	
	<div class="list-table">
		<table id="data_analysis" class="easyui-datagrid" 
		data-options="collapsible:true,url:'${base}/bData/sjfxlistByType?year=${year}',
			method:'post',fit:true,pagination:false,singleSelect: false,rowStyler:function(index,row){ if (row[2]=='合计'){ return 'background-color:#EFEFEF;color:black;font-weight:bold;'; }},
			onLoadSuccess:oneLoadSuccessMethod, selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:true,striped: true,fitColumns: true" >
				<%-- <thead>
					<tr>	
						<th data-options="rowspan:2,field:'0',align:'center',resizable:false,sortable:true," style="width: 5%">序号</th>
						<th data-options="rowspan:2,field:'1',align:'center',resizable:false,sortable:true," style="width: 8%">部门代码</th>
						<th data-options="rowspan:2,field:'2',align:'center',resizable:false,sortable:true," style="width: 14%">部门名称</th>
						<th data-options="rowspan:2,field:'3',align:'right',halign: 'center',resizable:false,sortable:true,styler: function (value, row, index)
						{ return 'background-color:#EFEFEF;color:red;font-weight:bold;'},formatter:nameMethod" style="width: 10%">合计</th>
						<c:forEach	var="i" items="${subjectList}" varStatus="val">
							<th data-options="align:'center'">${i.code}</th>
						</c:forEach>
					</tr>
					<tr>
						<c:forEach	var="i" items="${subjectList}" varStatus="val">
							<th data-options="field:'${val.index+4}',align:'right',halign: 'center',resizable:false,sortable:true,formatter:nameMethod" style="width: 10%">${i.name}</th>
						</c:forEach>
					</tr>
				</thead> --%>
			<thead>
				<tr>
					<th data-options="align:'center'" style="width: 10%">301</th>
					<th data-options="align:'center'" style="width: 10%">302</th>
					<th data-options="align:'center'" style="width: 10%">303</th>
					<th data-options="align:'center'" style="width: 10%">310</th>	
					<c:forEach	var="i" items="${subjectList}" varStatus="val">
						<th data-options="align:'center'">${i.code}</th>
					</c:forEach>
				</tr>
				<tr>
					<th data-options="field:'4',align:'right',halign: 'center',resizable:true,sortable:true,formatter:listToFixed" style="width: 10%">工资福利支出</th>
					<th data-options="field:'5',align:'right',halign: 'center',resizable:true,sortable:true,formatter:listToFixed" style="width: 10%">商品与服务支出</th>
					<th data-options="field:'6',align:'right',halign: 'center',resizable:true,sortable:true,formatter:listToFixed" style="width: 10%">对个人与家庭的补助</th>
					<th data-options="field:'7',align:'right',halign: 'center',resizable:true,sortable:true,formatter:listToFixed" style="width: 10%">资本性支出</th>
					<c:forEach	var="i" items="${subjectList}" varStatus="val">
						<th data-options="field:'${val.index+8}',align:'right',halign: 'center',resizable:true,sortable:true,formatter:listToFixed" style="width: 10%">${i.name}</th>
					</c:forEach>
				</tr>
			</thead>
			<thead frozen="true">
				<tr>	
					<th data-options="rowspan:2,field:'0',align:'center',resizable:false,sortable:true," style="width: 5%">序号</th>
					<th data-options="rowspan:2,field:'1',align:'center',resizable:true,sortable:true," style="width: 8%">部门代码</th>
					<th data-options="rowspan:2,field:'2',align:'center',resizable:true,sortable:true," style="width: 14%">部门名称</th>
					<th data-options="rowspan:2,field:'3',align:'right',halign: 'center',resizable:true,sortable:true,formatter:listToFixed" style="width: 10%">合计</th>
				</tr>
				<tr>
					
				</tr>
			</thead>
		</table>
	</div>
				
<!-- 
<form id="form_data_export" method="post" >
	<input type="hidden" id="data_index_export_indexCode" name="index_indexCode" value="">
</form>
 -->
</div>

<script type="text/javascript">
$(function (){
	$('#select_year').combobox({
		onChange:function (newVal,oldVal){
			addTabs('报表一','${base}/bData/dataAnalysisJsp?year='+newVal);
		}
	});
});
function oneLoadSuccessMethod(data){
	 $(this).datagrid('freezeRow',0);
}
function nameMethod(val,row){
	if(val=='' || val==null){
		return;
	}
	return val.toFixed(2);
}

//点击查询
function data_analy_query() {
	var year=$('#select_year').combobox('getValue');
	var analysisType = $('#analysisType').combobox('getValue');
	var dataType = $('#dataType').combobox('getValue');
	var  obj = document.getElementsByName("secondLevelCode");
	 var secondLevelCode=new Array();
	 for(var i in obj){
		 if(obj[i].checked){
			 secondLevelCode.push(obj[i].value);
		 }
	 }
	 if(year=='' && (secondLevelCode==null || secondLevelCode.length==0)){
		 alert('请勾选条件！');
		 return;
	 }
	
	$('#data_analysis').datagrid('load', {
		secondLevelCode : secondLevelCode,
		analysisType : analysisType,
		dataType : dataType
	});
}
//清除查询条件
function clear_data_analy() {
	 addTabs('报表一','${base}/bData/dataAnalysisJsp');
}

//导出
function exportDataAnalysis(){
	var  time=ChangeDateFormat(new Date());
	var rows = $('#data_analysis').datagrid('getRows');
		$('#data_analysis').datagrid('toExcel', {
	    filename: '报表一.xls',
	    rows: rows,
	    worksheet: 'Worksheet'
	}); 
}

</script>
</body>


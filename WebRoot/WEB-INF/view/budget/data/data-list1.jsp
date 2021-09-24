<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<style type="text/css">
 
 /* 边框样式 */
.datagrid-body td{
  border-bottom: 1px dashed #ccc;
  border-right: 1px dashed #ccc;
}
.datagrid-htable tr td{
	border-right: 1px solid #fff;
	border-bottom: 1px solid #fff;
}	
	
}
</style>

		<div style="height: 10px;background-color:#f0f5f7 "></div>

		<div class="list-top" >
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr id="data_year_top">
					<td class="top-table-search-pro">指标名称&nbsp;
						<input id="data_year_indexName" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;所属部门
						<input id="data_year_departName" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;<a href="#" onclick="data_year_query();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						<a href="#" onclick="data_year_clear();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<td align="right" style="padding-right: 10px">
						<a href="#" onclick="exportData1();">
							<img src="${base}/resource-modality/${themenurl}/button/daochu1.png" 
								onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu1.png')"
							/>
						</a>
					</td>
				</tr>
					
				<tr id="data_month_top" style="display: none;">
					<td class="top-table-search-pro">指标名称&nbsp;
						<input id="data_month_indexName" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;所属部门
						<input id="data_month_departName" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;年度
						<input id="data_month_years" name="" value="${currentYear}" style="width: 150px; height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;<a href="#" onclick="data_month_query();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						<a href="#" onclick="data_month_clear();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<td align="right" style="padding-right: 10px">
						<a href="#" onclick="exportData1();">
							<img src="${base}/resource-modality/${themenurl}/button/daochu1.png" 
								onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu1.png')"
							/>
						</a>
					</td>
				</tr>
				
			</table>           
		</div>
		<div class="list-table-tab">
			<div class="tab-wrapper" id="data-tab">
				<ul class="tab-menu">
					<li class="active"onclick="dataTabYearClick();">年报</li>
				    <li  onclick="dataTabMonthClick();">月报</li>
				</ul>
				<div class="tab-content">
					<div style="height: 440px">
					<table id="bData_dg1" class="easyui-datagrid" 
					data-options="collapsible:true,url:'${base}/bData/dataList1?currentYear=${currentYear }',
					method:'post',fit:true,pagination:false,singleSelect: true,striped: true,
					selectOnCheck: true">
						<thead>
							<tr>
								<th data-options="field:'id',hidden:true" rowspan="2"></th> 
								<th data-options="field:'pageOrder',align:'center'" width="5%" rowspan="2">序号</th>
								<th data-options="field:'indexName',align:'left',formatter:formatCellTooltip" width="14%" rowspan="2">指标名称</th>
								<th data-options="field:'departName',align:'left'" width="10%" rowspan="2">所属部门</th>
								<th data-options="field:'indexAmount',align:'center',formatter:isEmpty" width="6%" rowspan="2">指标额度</th>
								<th colspan="3">${yearNum1 }</th>
								<th colspan="3">${yearNum2 }</th>
								<th colspan="3">${yearNum3 }</th>
							
							</tr>
							<tr>
								<th data-options="field:'num0',align:'center',formatter:changeNum" width="9%">年累值</th>
								<th data-options="field:'cRate0',align:'center',formatter:format_hb0" width="7%">环比</th>
								<th data-options="field:'dRate0',align:'center',formatter:format_zxl0" width="7%">执行率</th>
								<th data-options="field:'num1',align:'center',formatter:changeNum" width="7%">年累值</th>
								<th data-options="field:'cRate1',align:'center',formatter:format_hb1" width="7%">环比</th>
								<th data-options="field:'dRate1',align:'center',formatter:format_zxl1" width="7%">执行率</th>
								<th data-options="field:'num2',align:'center',formatter:changeNum" width="7%">年累值</th>
								<th data-options="field:'cRate2',align:'center',formatter:format_hb2" width="7%">环比</th>
								<th data-options="field:'dRate2',align:'center',formatter:format_zxl2" width="7%">执行率</th>
							</tr>
						</thead>
					</table>
					</div>
					<div style="height: 440px">
					<table id="bData_dg2" class="easyui-datagrid" 
					data-options="collapsible:true,url:'${base}/bData/dataList2?years=${currentYear }',
					method:'post',fit:true,pagination:false,singleSelect: true,striped: true,
					selectOnCheck: true">
						<thead>
							<tr>
								<th data-options="field:'id',hidden:true" rowspan="2"></th> 
								<th data-options="field:'pageOrder',align:'center'" width="5%" rowspan="2">序号</th>
								<th data-options="field:'indexName',align:'left'" width="15%" rowspan="2">指标名称</th>
								<th data-options="field:'departName',align:'left'" width="10%" rowspan="2">所属部门</th>
								<th data-options="field:'indexAmount',align:'center',formatter:isEmpty" width="12%" rowspan="2">指标额度</th>
								<th colspan="2">1月</th>
								<th colspan="2">2月</th>
								<th colspan="2">3月</th>
								<th colspan="2">4月</th>
								<th colspan="2">5月</th>
								<th colspan="2">6月</th>
								<th colspan="2">7月</th>
								<th colspan="2">8月</th>
								<th colspan="2">9月</th>
								<th colspan="2">10月</th>
								<th colspan="2">11月</th>
								<th colspan="2">12月</th>
							
							</tr>
							<tr>
								<th data-options="field:'num1',align:'center',formatter:unitConversion" width="10%">月累执行额度</th>
								<th data-options="field:'lastNum1',align:'center',formatter:unitConversion" width="10%">同比执行额度</th>
								<th data-options="field:'num2',align:'center',formatter:unitConversion" width="10%">月累执行额度</th>
								<th data-options="field:'lastNum2',align:'center',formatter:unitConversion" width="10%">同比执行额度</th>
								<th data-options="field:'num3',align:'center',formatter:unitConversion" width="10%">月累执行额度</th>
								<th data-options="field:'lastNum3',align:'center',formatter:unitConversion" width="10%">同比执行额度</th>
								<th data-options="field:'num4',align:'center',formatter:unitConversion" width="10%">月累执行额度</th>
								<th data-options="field:'lastNum4',align:'center',formatter:unitConversion" width="10%">同比执行额度</th>
								<th data-options="field:'num5',align:'center',formatter:unitConversion" width="10%">月累执行额度</th>
								<th data-options="field:'lastNum5',align:'center',formatter:unitConversion" width="10%">同比执行额度</th>
								<th data-options="field:'num6',align:'center',formatter:unitConversion" width="10%">月累执行额度</th>
								<th data-options="field:'lastNum6',align:'center',formatter:unitConversion" width="10%">同比执行额度</th>
								<th data-options="field:'num7',align:'center',formatter:unitConversion" width="10%">月累执行额度</th>
								<th data-options="field:'lastNum7',align:'center',formatter:unitConversion" width="10%">同比执行额度</th>
								<th data-options="field:'num8',align:'center',formatter:unitConversion" width="10%">月累执行额度</th>
								<th data-options="field:'lastNum8',align:'center',formatter:unitConversion" width="10%">同比执行额度</th>
								<th data-options="field:'num9',align:'center'" width="10%">月累执行额度</th>
								<th data-options="field:'lastNum9',align:'center',formatter:unitConversion" width="10%">同比执行额度</th>
								<th data-options="field:'num10',align:'center',formatter:unitConversion" width="10%">月累执行额度</th>
								<th data-options="field:'lastNum10',align:'center',formatter:unitConversion" width="10%">同比执行额度</th>
								<th data-options="field:'num11',align:'center',formatter:unitConversion" width="10%">月累执行额度</th>
								<th data-options="field:'lastNum11',align:'center',formatter:unitConversion" width="10%">同比执行额度</th>
								<th data-options="field:'num12',align:'center',formatter:unitConversion" width="10%">月累执行额度</th>
								<th data-options="field:'lastNum12',align:'center',formatter:unitConversion" width="13%">同比执行额度</th>
							</tr>
						</thead>
					</table>
					</div>
				</div>
			</div>
		</div>	
		<!-- <div id="chartmain" style="margin: 0 10px 0 10px;height: 700px;" >
		
		</div> -->
		
<form id="form_data_export" method="post">
	<input type="hidden" id="data_year_export_indexName" name="year_indexName" value="">
	<input type="hidden" id="data_year_export_departName"  name="year_departName" value="">
	
	<input type="hidden" id="data_month_export_indexName" name="month_indexName" value="">
	<input type="hidden" id="data_month_export_departName"  name="month_departName" value="">
	<input type="hidden" id="data_month_export_years"  name="month_years" value="">
</form>

<script type="text/javascript">

flashtab('data-tab');
function changeNum(val){
	if (val=="null"){
	return "0.00";
	}else{	
	return Math.abs(val).toFixed(2);
	}
}
function unitConversion(val){	
	return (val/10000).toFixed(2);
	}

function exportData1(){
	if(confirm('是否按查询条件导出？')){
		var data_year_indexName=$('#data_year_indexName').val();
		var data_year_departName=$('#data_year_departName').val();
		$("#data_year_export_indexName").val(data_year_indexName);
		$("#data_year_export_departName").val(data_year_departName);
		
		var data_month_indexName=$('#data_month_indexName').val();
		var data_month_departName=$('#data_month_departName').val();
		var data_month_years=$('#data_month_years').val();
		$("#data_month_export_indexName").val(data_month_indexName);
		$("#data_month_export_departName").val(data_month_departName);
		$("#data_month_export_years").val(data_month_years);
		$('#form_data_export').attr('action','${base}/bData/exportData1');
		$('#form_data_export').submit();
	}
}
function format_hb0(val, row){
	var num =  Math.round(row.num0*100/row.num1);
	if (!isNaN(num)&&isFinite(num)) {
		return num+"%";
	}
	return "-";
}
function format_hb1(val, row){
	var num =  Math.round(row.num1*100/row.num2);
	if (!isNaN(num)&&isFinite(num)) {
		return num+"%";
	}
	return "-";
}
function format_hb2(val, row){
	
	return "-";
}
function format_zxl0(val, row){
	var num =  Math.round(row.num0*100/row.indexAmount);
	if (!isNaN(num)&&isFinite(num)) {
		return num+"%";
	}if(row.num0=="null"&&row.indexAmount!=="null"){
		return 0+"%";
	}
	return "-";
	//return Math.round(row.num0*100/row.indexAmount)+"%";
}
function format_zxl1(val, row){
	var num =  Math.round(row.num1*100/row.indexAmount);
	if (!isNaN(num)&&isFinite(num)) {
		return num+"%";
	}if(row.num1=="null"&&row.indexAmount!=="null"){
		return 0+"%";
	}
	return "-";
}
function format_zxl2(val, row){
	var num =  Math.round(row.num2*100/row.indexAmount);
	if (!isNaN(num)&&isFinite(num)) {
		return num+"%";
	}if(row.num2=="null"&&row.indexAmount!=="null"){
		return 0+"%";
	}
	return "-";
}

function generateChart(type){
	var option = {
			title : {
		        text: '机关建设及日常保障经费',
		        subtext: '预算分配情况',
		        left:'center'
		    },
            tooltip:{},
            legend:{
                data:['用户来源']
            },
            xAxis:{
                data:["办公室","干部处","宣传教育处","后勤处","文艺处","新闻出版处"]
            },
            yAxis:{

            },
            toolbox: {
		        show: true,
		        orient: 'vertical',
		        left: 'right',
		        top: 'center',
		        feature: {
		            //mark: {show: true},
		            //dataView: {show: true, readOnly: false},
		            magicType: {show: true, type: ['line', 'bar', 'stack', 'tiled']},
		            //magicType: {show: true, type: [  'stack' ]},
		            restore: {show: true},
		            //saveAsImage: {show: true}
		        }
		    },
            series:[{
                name:'预算额度',
                barWidth:50,
                type:type,
                data:[12000.00,9000.00,10000.00,11000.00,8000.00,4000.00],
                itemStyle:{
                	normal:{
                		color:'#83bff6'
                	}
                }
            }]
        };
        //初始化echarts实例
        var myChart = echarts.init(document.getElementById('chartmain'));
        //使用制定的配置项和数据显示图表
        myChart.setOption(option);
} 
</script>

<script type="text/javascript">
//分页样式调整
$(function(){
	//genePagination();
});
function genePagination(){
	var pager = $('#bData_dg1').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});	
}

function dataTabYearClick(){
	$("#bData_dg1").datagrid('reload');
	$("#data_year_top").show();
	$("#data_month_top").hide();
}
function dataTabMonthClick(){
	$("#bData_dg2").datagrid('reload');
	$("#data_year_top").hide();
	$("#data_month_top").show();
}

//年度查询
function data_year_query() {
	$('#bData_dg1').datagrid('load', {
		indexName:$('#data_year_indexName').val(),
		deptName:$('#data_year_departName').val()
	});
	
}

//年度清除查询条件
function data_year_clear() {
	$("#data_year_indexName").textbox('setValue','');
	$("#data_year_departName").textbox('setValue','');
	$('#bData_dg1').datagrid('load',{//清空以后，重新查一次
	});
}

//月份
//点击查询
	function data_month_query() {
		//alert($('#apply_time').val());
		$('#bData_dg2').datagrid('load', {
			indexName:$('#data_month_indexName').val(),
			deptName:$('#data_month_departName').val(),
			years:$('#data_month_years').val()
		});
	}
	//清除查询条件
	function data_month_clear() {
		/* $(".topTable :input[type='text']").each(function(){
			$(this).val("a");
		}); */
		$("#data_month_indexName").textbox('setValue','');
		$("#data_month_departName").textbox('setValue','');
		$("#data_month_years").textbox('setValue','');
		$('#bData_dg2').datagrid('load',{//清空以后，重新查一次
		});
	}
//判断指标额度是否为空
function isEmpty(num){
	if(num==null || num=="" || num=="null"){
		return "未填写";
	}
	return num;
}
</script>
</body>


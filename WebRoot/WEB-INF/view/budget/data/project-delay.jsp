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

<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search-pro" class="queryth">
					&nbsp;&nbsp;项目编号&nbsp;
					<input id="pro_delay_query_fproCode" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;项目名称&nbsp;
					<input id="pro_delay_query_fproName" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;所属部门&nbsp;
					<input id="pro_delay_query_deptName" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryProDelay();">
						<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearProDelay();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
			</tr>
		
		
			
		</table>   
	</div>



	<div class="list-table">
		<table id="pro_delay_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/proDelay/proDelayPageData?',
			method:'post',fit:true,pagination:true,pageSize:10,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true" >
				<thead>
					<tr>
						<th data-options="field:'fcId',hidden:true"></th>
						<th data-options="field:'dayNum',align:'center',formatter:warning" width="6%"></th>
						<th data-options="field:'num',align:'center'" width="5%">序号</th>
						<th data-options="field:'fProCode',align:'center'" width="10%">项目编号</th>
						<th data-options="field:'fProName',align:'center'" width="15%">项目名称</th>
						<th data-options="field:'fContAmount',align:'center'" width="10%">合同金额（万元）</th>
						<th data-options="field:'deptName',align:'center'" width="10%">所属部门</th>
						<th data-options="field:'fReceProperty',align:'center',formatter:format_fReceProperty" width="10%">付款性质</th>
						<th data-options="field:'fReceStage',align:'center'" width="10%">付款阶段</th>
						<th data-options="field:'fRecePlanTime',align:'center'" width="10%">计划付款时间</th>
						<th data-options="field:'delayDays',align:'center',styler:cellStyler" width="9%">剩余天数</th>
						<th data-options="field:'operation',align:'center',formatter:cz" width="5%">操作</th>
					</tr>
				</thead>
			</table>
	</div>
</div>




<script type="text/javascript">
//操作栏创建
 function cz(value, row, index){
	var btn =  "<table style='margin:0 auto;'><tr style='width: 105px; height:20px'>"
				+"<td style='width:25px;border:none;'><a href='javascript:void(0)' style='color:blue' onclick='contract_detail("+row.fcId+")'>" 
				+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/select1.png'>"
				+ "</a></td></tr></table>";
	return btn;
} 


//付款性质
function format_fReceProperty(val, row){
	if (val == 'FKXZ-01') {
		return '首款';
	} 
	if (val == 'FKXZ-02') {
		return '阶段款';
	}
	if (val == 'FKXZ-03') {
		return '验收款';
	}
	else if(val == 'FKXZ-04'){
		return '质保款';
	}
	return '';
}

function contract_detail(fcId) {
	var win = creatWin('合同信息', 720, 580, 'icon-search',"/Filing/detail/" + fcId);
	win.window('open');
}

/* //时间格式化
function ProListDateFormat(val) {
	//alert(val)
    var t, y, m, d, h, i, s;
    if(val==null){
  	  return "";
    }
    t = new Date(val);
    y = t.getFullYear();
    m = t.getMonth() + 1;
    d = t.getDate();
    h = t.getHours();
    i = t.getMinutes();
    s = t.getSeconds();
    // 可根据需要在这里定义时间格式  
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) ;
} */



//查询
function queryProDelay(){  
	var fProCode="pro_delay_query_fproCode";
	var fProName="pro_delay_query_fproName";
	var deptName="pro_delay_query_deptName";
	
	$("#pro_delay_dg").datagrid('load',{
		fProCode:$("#"+fProCode).textbox('getValue').trim(),
		fProName:$("#"+fProName).textbox('getValue').trim(),
		deptName:$("#"+deptName).textbox('getValue').trim(),
	});
}

//查询条件清除
function clearProDelay(){
	var fProCode="pro_delay_query_fproCode";
	var fProName="pro_delay_query_fproName";
	var deptName="pro_delay_query_deptName";
	
	$("#"+fProCode).textbox('setValue','');
	$("#"+fProName).textbox('setValue','');
	$("#"+deptName).textbox('setValue','');
	
	$("#pro_delay_dg").datagrid('load',{});
}


	function cellStyler(value, row, index) {
		if (value < 0) {
			return 'color:#BD2E40;font-weight: bold;';
		} else if (value <= 30) {
			return 'color:#FB7822;font-weight: bold;';
		} else if (value <= 60) {
			return 'color:#F0BF45;font-weight: bold;';
		} else {
			return 'color:#80C0FE;font-weight: bold;';
		}
	}

	function warning(val) {
		if (val < 0) {
			return "<img src='"+base+"/resource-modality/${themenurl}/cockpit/warning4.png'>";
		} else if (val <= 30) {
			return "<img src='"+base+"/resource-modality/${themenurl}/cockpit/warning3.png'>";
		} else if (val <= 60) {
			return "<img src='"+base+"/resource-modality/${themenurl}/cockpit/warning2.png'>";
		} else {
			return "<img src='"+base+"/resource-modality/${themenurl}/cockpit/warning1.png'>";
		}
	}
</script>
</body>


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
}
</style>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
		<tr id="data_index_top">
					<td class="top-table-search-pro">预算指标编码&nbsp;
						<input id="data_index_indexCode" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;预算指标名称
						<input id="data_index_indexName" name="" style="width: 150px; height:25px;" class="easyui-textbox" value="${test }"></input>
						&nbsp;&nbsp;年份
						<input id="data_index_years" name=""  value="${currentYear }" style="width: 150px; height:25px;" class="easyui-numberbox"></input>
						
						&nbsp;&nbsp;<a href="#" onclick="data_index_query();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						<a href="#" onclick="data_index_clear();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					
					<td align="right" style="padding-right: 10px;width:70px;">
						<a href="#" onclick="exportDataJd();">
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
			<div class="tab-wrapper" id="bExcess-tab2">
				
				<div class="tab-content">
				<div style="height: 440px">
					<table id="bExcessDg1" class="easyui-datagrid" 
					data-options="collapsible:true,url:'${base}/bExcess/excessList1?orderColumn=indexCode,indexName,deptName',
					method:'post',fit:true,pagination:false,singleSelect: true,scrollbarSize:0,onLoadSuccess: onLoadSuccess1,
					selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:true,striped: true,fitColumns:true,rownumbers:false," >
						<thead>
							<tr>	
								<th data-options="rowspan:2,field:'bId',hidden:true"></th>
								<th data-options="rowspan:2,field:'num',align:'center'" style="width: 5%">序号</th>
								<th data-options="rowspan:2,field:'indexName',align:'center',formatter:formatCellTooltip" style="width: 10%">预算指标名称</th>
								<th data-options="rowspan:2,field:'deptName',align:'center',formatter:formatCellTooltip" style="width: 8%">使用部门</th>
								<th data-options="rowspan:2,field:'pfAmount',align:'right',formatter:listToFixed" style="width: 8%">批复金额[万元]</th>
								<th data-options="rowspan:2,field:'xdAmount',align:'right',formatter:listToFixed" style="width: 10%">累计下达金额[万元]</th>
								<th data-options="rowspan:2,field:'syAmount',align:'right',formatter:SYAmount" style="width: 8%">剩余金额[万元]</th>
								<th data-options="colspan:2,align:'center'" style="width: 22%">支出金额[万元]</th>	
								<th data-options="rowspan:2,field:'zxjd',align:'center',formatter: zbzxjd" style="width: 6%">执行进度</th>
								<th data-options="rowspan:2,field:'years',align:'center'" style="width: 7%">预算年度</th>
								<th data-options="rowspan:2,field:'indexCode',align:'center'" style="width: 7%">预算指标编码</th>
								<th data-options="rowspan:2,field:'operation',align:'center',formatter: zbjdzbCz" style="width: 9%">操作</th>
							<tr>
								<th data-options="field:'zcAmount',align:'right',formatter:zcAmount" style="width: 11%">已支出金额[万元]</th>
								<th data-options="field:'djAmount',align:'right',formatter:listToFixed" style="width: 11%">其中：冻结金额[万元]</th>
						</thead>
					</table>
				</div>
				
			   	
				</div>
			</div>
		</div>	
	</div>

<form id="form_data_export" method="post" >
	<input type="hidden" id="data_index_export_indexCode" name="index_indexCode" value="">
	<input type="hidden" id="data_index_export_indexName"  name="index_indexName" value="">
	<input type="hidden" id="data_index_export_years"  name="index_years" value="">
	
	<input type="hidden" id="data_dept_export_indexCode" name="dept_indexCode" value="">
	<input type="hidden" id="data_dept_export_indexName"  name="dept_indexName" value="">
	<input type="hidden" id="data_dept_export_deptName"  name="dept_deptName" value="">
	<input type="hidden" id="data_dept_export_years"  name="dept_years" value="">
</form>


<script type="text/javascript">
//鼠标悬浮单元格提示信息  
function formatCellTooltip(value){  
    return "<span title='" + value + "'>" + value + "</span>";  
}  



flashtab("bExcess-tab2");
function exportDataJd(){
	if(confirm('是否按查询条件导出？')){
		var index_indexCode=$('#data_index_indexCode').val();
		var index_indexName=$('#data_index_indexName').val();
		var index_years=$('#data_index_years').val();
		$("#data_index_export_indexCode").val(index_indexCode);
		$("#data_index_export_indexName").val(index_indexName);
		$("#data_index_export_years").val(index_years);
		
		var dept_indexCode=$('#data_dept_indexCode').val();
		var dept_indexName=$('#data_dept_indexName').val();
		var dept_deptName=$('#data_dept_name').val();
		var dept_years=$('#data_dept_years').val();
		$("#data_dept_export_indexCode").val(dept_indexCode);
		$("#data_dept_export_indexName").val(dept_indexName);
		$("#data_dept_export_deptName").val(dept_deptName);
		$("#data_dept_export_years").val(dept_years);
		$('#form_data_export').attr('action','${base}/bExcess/exportData2');
		$('#form_data_export').submit();
	}
}


//指标状态设置
function indexStauts(val, row) {
	if(val==0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "未下达" + '</a>';
	} else if(val==1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已下达" + '</a>';
	} else {
		return null;
	}
}



//指标下达页面跳转
function indexTransmit(id) {
	var win = creatWin('预算指标下达', 540, 480, 'icon-search', '/transmit/transmit?bId='+id);
	win.window('open');
}

//指标执行进度
function zbzxjd(val, row) {
	var percent = 0.00;
	if (row.pfAmount !==0){
		percent = parseFloat(((row.xdAmount-row.djAmount-row.syAmount)/row.pfAmount)*100).toFixed(2);
	}
	//进度条
	if (percent <= 40) {
		var htmlstr = '<div class="easyui-progressbar progressbar" style="margin: 0 auto;width: 60px; height: 20px;background-color:#F0F5F7" value="'
				+ percent
				+ '" text="'
				+ percent
				+ '%">'
				+ '<div class="progressbar-text" style="width: 60px; height: 20px; line-height: 20px;">'
				+ percent
				+ '%</div>'
				+ '<div class="progressbar-value" style="width: '
				+ percent
				+ '%; height: 20px; line-height: 20px;">'
				+ '<div class="progressbar-text" style="width: 60px; height: 20px; line-height: 20px;background-color:#53CA22">'
				+ percent + '%</div>' + '</div>' + '</div>';
				}
		else if (percent <= 60) {
		var htmlstr = '<div class="easyui-progressbar progressbar" style="margin: 0 auto;width: 60px; height: 20px;background-color:#F0F5F7" value="'
			+ percent
			+ '" text="'
			+ percent
			+ '%">'
			+ '<div class="progressbar-text" style="width: 60px; height: 20px; line-height: 20px;">'
			+ percent
			+ '%</div>'
			+ '<div class="progressbar-value" style="width: '
			+ percent
			+ '%; height: 20px; line-height: 20px;">'
			+ '<div class="progressbar-text" style="width: 60px; height: 20px; line-height: 20px;background-color:#FFFF00">'
			+ percent + '%</div>' + '</div>' + '</div>';
		
		}		
		else if (percent <= 80) {
					var htmlstr = '<div class="easyui-progressbar progressbar" style="margin: 0 auto;width: 60px; height: 20px;background-color:#F0F5F7" value="'
						+ percent
						+ '" text="'
						+ percent
						+ '%">'
						+ '<div class="progressbar-text" style="width: 60px; height: 20px; line-height: 20px;">'
						+ percent
						+ '%</div>'
						+ '<div class="progressbar-value" style="width: '
						+ percent
						+ '%; height: 20px; line-height: 20px;">'
						+ '<div class="progressbar-text" style="width: 60px; height: 20px; line-height: 20px;background-color:#FF8C00">'
						+ percent + '%</div>' + '</div>' + '</div>';
					
				}			
				else if (percent <= 100) {
					var htmlstr = '<div class="easyui-progressbar progressbar" style="margin: 0 auto;width: 60px; height: 20px;background-color:#F0F5F7" value="'
						+ percent
						+ '" text="'
						+ percent
						+ '%">'
						+ '<div class="progressbar-text" style="width: 60px; height: 20px; line-height: 20px;">'
						+ percent
						+ '%</div>'
						+ '<div class="progressbar-value" style="width: '
						+ percent
						+ '%; height: 20px; line-height: 20px;">'
						+ '<div class="progressbar-text" style="width: 60px; height: 20px; line-height: 20px;background-color:#FF0000">'
						+ percent + '%</div>' + '</div>' + '</div>';
					
				}
				else if (percent > 100) {
					var htmlstr = '<div class="easyui-progressbar progressbar" style="margin: 0 auto;width: 60px; height: 20px;background-color:#F0F5F7" value="'
						+ percent
						+ '" text="'
						+ percent
						+ '%">'
						+ '<div class="progressbar-text" style="width: 60px; height: 20px; line-height: 20px;">'
						+ percent
						+ '%</div>'
						+ '<div class="progressbar-value" style="width: '
						+ percent
						+ '%; height: 20px; line-height: 20px;">'
						+ '<div class="progressbar-text" style="width: 60px; height: 20px; line-height: 20px;background-color:#A52A2A">'
						+ percent + '%</div>' + '</div>' + '</div>';
					
				}
	return htmlstr;

	}

	//支出金额
	function zcAmount(val, row) {
		return parseFloat(row.xdAmount - row.djAmount - row.syAmount)
				.toFixed(2);
	}

	//剩余金额
	function SYAmount(val, row) {
		return parseFloat(
				row.pfAmount - row.xdAmount + row.djAmount + row.syAmount)
				.toFixed(2);
	}

	//操作
	function zbjdzbCz(val, row) {
		var code = "'" + row.indexCode + "'";

		return '<table><tr style="width: 75px;height:20px;"><td style="width: 85px; border:none;">'
				+ '<a href="#" onclick="detailHistory('
				+ code
				+ ')" class="easyui-linkbutton" style="color:blue">'
				+ '分析'
				+ '</a></td>' +
				'</tr></table>';
	}

	function detailHistory(code) {
		var win = parent.creatCockFirstWin( '分析',800, 550,
				'icon-search', "/bExcess/analyse?code=" + code);
		win.window('open');
	}

	/* function detailOutcome(id) {
		var win = creatWin('支出明细查询', 540, 500, 'icon-search',
				'/transmit/transmit?bId=' + id);
		win.window('open');
	} */

	

	//按预算指标统计
	function data_index_query() {
		var years = $('#data_index_years').val();
		$('#bExcessDg1').datagrid('load', {
			indexCode : $('#data_index_indexCode').val(),
			indexName : $('#data_index_indexName').val(),
			years : $('#data_index_years').val(),
			search : 0
		});

	}
	//年度清除查询条件
	function data_index_clear() {
		$("#data_index_indexCode").textbox('setValue', '');
		$("#data_index_indexName").textbox('setValue', '');
		$("#data_index_years").textbox('setValue', '${currentYear }');
		$('#bExcessDg1').datagrid('load', {//清空以后，重新查一次
		});
	}

	

	//合并单元格
	function onLoadSuccess1(data) {

		//计算需要合并的单元格
		var merges = [];
		var rows = $("#bExcessDg1").datagrid('getRows');

		var a = 0;
		var length = 0;
		for (var i = 0; i < rows.length - 1; i++) {
			if (rows[i].indexName == rows[i + 1].indexName) {

				length++;
			} else if (rows[i].indexName !== rows[i + 1].indexName) {
				length = 0;
				a = i + 1;
			}
			var merge = {
				index : a,
				rowspan : length + 1
			};
			merges.push(merge);
		}
		//合并名称
		for (var i = 0; i < merges.length; i++)
			$(this).datagrid('mergeCells', {
				index : merges[i].index,
				field : 'indexName',
				rowspan : merges[i].rowspan
			});
		//合并序号
		for (var i = 0; i < merges.length; i++)
			$(this).datagrid('mergeCells', {
				index : merges[i].index,
				field : 'num',
				rowspan : merges[i].rowspan
			});

	}

	
</script>
</body>


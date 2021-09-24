<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="eval_tr_sup_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
			<td class="top-table-search">采购编码&nbsp;
					<input id="eval_cgsq_fpCode" name="fpCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;采购名称
					<input id="eval_cgsq_fpName" name="fpName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;<a href="#" onclick="queryEvalTrHis();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearEvalTrHisTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>
	</div>
		
		
		
		<div style="margin: 0 10px 0 10px;height: 445px;">	
			<table id="eval_tr_his_tab" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/evalsupplier/evaltrhisPage?wid=${fwid}',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'feId',hidden:true"></th>
						<th data-options="field:'fpId',hidden:true"></th>
						<th data-options="field:'fwId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" width="10%">序号</th>
						<th data-options="field:'fpCode',align:'left'" width="20%">采购编码</th>
						<th data-options="field:'fpName',align:'left'" width="15%">采购名称</th>
						<th data-options="field:'cgTime',align:'left',formatter: ChangeDateFormata" width="15%">采购时间</th>
						<th data-options="field:'fsupTime',align:'left',formatter: ChangeDateFormata" width="15%">评价时间</th>
						<th data-options="field:'fuserName',align:'left'" width="15%">评价人</th>
						<!-- <th data-options="field:'fdeptName',align:'left'" width="15%">评价人部门</th> -->
						<th data-options="field:'operation',align:'left',formatter:format_discussa" width="10%">操作</th>
				</tr>
				</thead>
			</table>
		</div>
	

</div>

	<script type="text/javascript">
	
	//分页样式调整
	$(document).ready(function() {
		var pager = $('#eval_tr_his_tab').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
		});	
	});
	

	//点击查询
	function queryEvalTrHis() {
		//alert($('#apply_time').val());
		$('#eval_tr_his_tab').datagrid('load', {
			fpCode:$('#eval_cgsq_fpCode').val(),
			fpName:$('#eval_cgsq_fpName').val()
		});
	}
	//清除查询条件
	function clearEvalTrHisTable() {
		/* $(".topTable :input[type='text']").each(function(){
			$(this).val("a");
		}); */
		$("#eval_cgsq_fpCode").textbox('setValue','');
		$("#eval_cgsq_fpName").textbox('setValue','');
		$('#eval_tr_his_tab').datagrid('load',{//清空以后，重新查一次
		});
	}
		//时间格式化
		function ChangeDateFormata(val) {
			//alert(val)
			var t, y, m, d, h, i, s;
			if (val == null) {
				return "";
			}
			t = new Date(val)
			y = t.getFullYear();
			m = t.getMonth() + 1;
			d = t.getDate();
			h = t.getHours();
			i = t.getMinutes();
			s = t.getSeconds();
			// 可根据需要在这里定义时间格式  
			return y + '-' + (m < 10 ? '0' + m : m) + '-'
					+ (d < 10 ? '0' + d : d);
		}	
	//操作栏创建
	function format_discussa(val,row) {		
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="tr_his_discuss_sup(' + row.feId + ')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td></tr></table>';	
	}
	function showA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function showB(obj){
		obj.src=base+'/resource-modality/${themenurl}/select2.png';
	}

	
	 //评价供应商
	 function tr_his_discuss_sup(id) {
		var win = parent.creatFirstWin(' 供应商评价', 768, 550, 'icon-search',"/evalsupplier/seeEvalSupplierDetai?id=" + id);
		win.window('open');
	} 
	
	 </script>
</body>


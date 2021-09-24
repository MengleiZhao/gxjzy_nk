<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div>
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table style="font-size: 12px;">
				<tr>
					<td class="top-table-search">采购批次编号&nbsp;
					<input id="basicinfo_fpCode" name="fpCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;采购名称
					<input id="basicinfo_fpName" name="fpName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;<a href="#" onclick="queryCginfo();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearCginfo();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				</tr>
			</table> 
		</div>		
		
		<div style="margin: 0 10px 0 10px;height: 250px;">	
			<table id="cq_tab" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/cgprocess/basicInfoPage',
			method:'post',fit:true,pagination:false,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'fpId',hidden:true"></th>
						<th data-options="field:'number',align:'center'" style="width: 5%">序号</th>
						<th data-options="field:'fpCode',align:'center'" style="width: 20%">采购批次编号</th>
						<th data-options="field:'fpName',align:'center',resizable:false,sortable:true" style="width: 25%">采购名称</th>
						<th data-options="field:'fpAmount',align:'right',resizable:false,sortable:true" style="width: 15%">采购金额[元]</th>
						<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" style="width: 10%">申报部门</th>
						<th data-options="field:'fReqTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">申报时间</th>
						<!-- <th data-options="field:'fpMethod',align:'left',resizable:false,sortable:true" style="width: 11%">采购方式</th> -->
						<!-- <th data-options="field:'fCheckStauts',align:'left',resizable:false,sortable:true,formatter:formatPrice" style="width: 10%">审批状态</th> -->
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" style="width: 10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>

		<div style="text-align: left;">
			<span style="color:#ff6800">&nbsp;&nbsp;&nbsp;&nbsp;✧温馨提示：请双击完成选择</span>
		</div>
		<div class="win-left-bottom-div" style="text-align: center;">
			<a href="javascript:void(0)" onclick="closeFirstWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
		</div>
	</div>
	<script type="text/javascript">
	
	//分页样式调整
	$(document).ready(function() {
		var pager = $('#cq_tab').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last']
		});	
		$("#cq_tab").datagrid({
			 onDblClickRow:function(index, row){
				 var row = $('#cq_tab').datagrid('getSelected');
					var selections = $('#cq_tab').datagrid('getSelections');
					if (row != null && selections.length == 1) {
						$("#F_fpCode").val(row.fpId);
						$("#F_fpCodeName").textbox('setValue', row.fpCode);
						closeFirstWindow();
					} else {
						$.messager.alert('系统提示', '请选择一条数据！', 'info');
					} 
			 }
		});
	});
	
	
	//点击查询
	function queryCginfo() {
		//alert($('#apply_time').val());
		$('#cq_tab').datagrid('load', {
			fpCode:$('#basicinfo_fpCode').val(),
			fpName:$('#basicinfo_fpName').val()
		});
	}
	//清除查询条件
	function clearCginfo() {
		/* $(".topTable :input[type='text']").each(function(){
			$(this).val("a");
		}); */
		$("#basicinfo_fpCode").textbox('setValue','');
		$("#basicinfo_fpName").textbox('setValue','');
		$('#cq_tab').datagrid('load',{//清空以后，重新查一次
		});
	}

		//时间格式化
		function ChangeDateFormat(val) {
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
		
	
	//设置审批状态
	/* var c;
	function formatPrice(val, row) {
		c = val;
		if (val == 0) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</a>';
		} else if (val == -1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</a>';
		} else if (val == 9) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
		} else {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
		}
	} */

	//操作栏创建
	function CZ(val,row) {		
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="tendering_detail(' + row.fpId + ')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td></tr></table>';
		
	}
	//查看
	function tendering_detail(id) {
		var win = creatWin(' ', 970, 580, 'icon-search',"/cgsqsp/ledgerdetail?id=" + id);
		win.window('open');

	} 
	function showA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function showB(obj){
		obj.src=base+'/resource-modality/${themenurl}/select2.png';
	}
		
	</script>
</body>
</html>


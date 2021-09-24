<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search-pro">项目编号&nbsp;
					<input id="monpro_code" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;项目名称
					<input id="monpro_name" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;申报部门
					<input id="monpro_FProAppliDepart" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					
					&nbsp;&nbsp;<a href="#" onclick="queryMonPro();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearMonProTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table> 
	</div>
		
		
		
	<div class="list-table">	
		<%-- <table id="monitor_pro_tab" 
			data-options="collapsible:true,url:'${base}/pfmmonitor/monitorprojectPage',
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>  --%>
			<table id="guibi_pro_tab" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/pfmmonitor/monitorprojectPage',
		method:'post',fit:true,pagination:true,singleSelect: false,scrollbarSize:0,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<!-- <th data-options="field:'fproId',hidden:true"></th>
					<th data-options="field:'pageOrder',align:'center'" width="5%">序号</th>
					<th data-options="field:'fproCode',align:'left'" width="20%">项目编号</th>
					<th data-options="field:'fproName',align:'left'" width="20%">项目名称</th>
					<th data-options="field:'commitAmount2',align:'left'" width="15%">财拨数</th>
					<th data-options="field:'fproAppliDepart',align:'left'" width="15%">承办处</th>
					<th data-options="field:'fproHead',align:'left'" width="15%">项目负责人</th>
					<th data-options="field:'operation',align:'left',formatter:format_oper" width="10%">操作</th> -->
					<th data-options="field:'fproId',hidden:true"></th>
					<th data-options="field:'pageOrder',align:'center'" width="3%">序号</th>
					<th data-options="field:'fproCode',align:'left'" width="17%">项目编号</th>
					<th data-options="field:'fproName',align:'left'" width="20%">项目名称</th>
					<th data-options="field:'fproAppliPeople',align:'center'" width="10%">申报人</th>
					<th data-options="field:'fproAppliDepart',align:'center'" width="12%">申报部门</th>
					<th data-options="field:'fproAppliTime',align:'center',resizable:false,sortable:true,formatter: ProListDateFormat" width="10%">申报时间</th>
					<th data-options="field:'fproBudgetAmount',align:'center'" width="13%">项目预算（万元）</th>
					<!-- <th data-options="field:'fflowStauts',align:'center',formatter:format_fflowStauts" width="7%">审批状态</th> -->
					<th data-options="field:'operation',align:'left',formatter:format_oper" width="10%">操作</th>
			<%-- 		<th data-options="field:'operation',align:'left',formatter:format_oper" width="<c:if test="${sbkLx=='xmsb' }">10%</c:if><c:if test="${sbkLx!='xmsb' }">20%</c:if>">操作</th>
			 --%></thead>
		</table>
	</div>
	

</div>

<script type="text/javascript">
	//设置审批状态
	var c;
	function formatStatus(val, row) {
		c = val;
		if (val == "滞后") {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 滞后" + '</a>';
		} else if (val == "正常") {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 正常" + '</a>';
		} else if(val == "提前") {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 提前" + '</a>';
		}
	}
	//点击查询
	 function queryMonPro() {
		$('#guibi_pro_tab').datagrid('load',{
			FProCode:$('#monpro_code').val(),
			FProName:$('#monpro_name').val(),
			FProAppliDepart : $('#monpro_FProAppliDepart').combobox('getText')
			
		});
	}
		//清除查询条件
		function clearMonProTable() {
			$("#monpro_name").textbox('setValue','');
			$("#monpro_code").textbox('setValue','');
			$("#monpro_FProAppliDepart").textbox('setValue','');
			$('#guibi_pro_tab').datagrid('load',{//清空以后，重新查一次
			});
		}
	

	//时间格式化
	function ProListDateFormat(val) {
		//alert(val)
	    var t, y, m, d, h, i, s;
	    if(val==null){
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
	    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) ;
	}	
	function format_fflowStauts(val, row) {
		if (val == 0) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">'
					+ " 暂存" + '</a>';
		} else if (val == 1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">'
					+ " 待审批" + '</a>';
		} else if (val == 2) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">'
					+ " 待审批" + '</a>';
		} else if (val == 3) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">'
					+ " 已审批" + '</a>';
		} else if (val == -1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">'
					+ " 已退回" + '</a>';
		}
	}
	//操作栏创建
	function format_oper(val, row) {
		var btn = "";
		btn = btn + "<table><tr style='width: 75px;height:20px'><td style='width: 25px'>";
		var btn1 = "<a href='#' onclick=selfMonitor_detail("+ row.fproId +") class='easyui-linkbutton'>"
		+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/select1.png'></a></td>"
		+ "<td style='width: 25px'>"
		+ "<a href='#' onclick='selfMonitor_update(" + row.fproId+ ")' class='easyui-linkbutton'>"
		+"<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/update1.png'></a></td>";
		btn = btn+btn1 + "</tr></table>";
		return btn;
	}

	function selfMonitor_update(id) {
		//var row = $('#storage_low_dg').datagrid('getSelected');
		var win = creatWin(' ', 760, 580, 'icon-search','/pfmmonitor/edit/' + id);
		win.window('open');
	}
	//查看项目详细信息
	function selfMonitor_detail(id){
		var win = creatWin(' ', 760,580, 'icon-search','/pfmmonitor/detail/'+id);
		win.window('open');
	}
 	
	
	</script>
</body>
</html>


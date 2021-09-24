<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-search" style="width: 650px" class="queryth">
						&nbsp;&nbsp;所属大项目名称&nbsp;
						<input id="query_bigName" style="width: 150px;height:25px;" class="easyui-textbox"/>
						
						&nbsp;&nbsp;子项目名称&nbsp;
						<input id="query_name" style="width: 150px;height:25px;" class="easyui-textbox"/> 
						
						&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="queryCF();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')">
						</a>
						<a href="#" onclick="clearTable();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<td>
						<a href="javascript:void(0)" onclick="select()">
							<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="closeFirstWindow()">
							<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
				</tr>
			</table>           
		</div>
			<div class="list-table" style="height: 480px;">
			<table id="choose_zxm_dg" 
				data-options="collapsible:true,url:'${base}/project/zxmPage',checkbox: true,
              	collapsible:true,method:'post',fit:true,pagination:true,singleSelect: false,
				selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'fProId',hidden:true"></th>
						<th data-options="field:'fproCode',align:'center'" width="20%">项目编号</th>
						<th data-options="field:'fproName',align:'center',formatter:formatCellTooltip" width="20%">子项目名称</th>
						<th data-options="field:'bigProName',align:'center',formatter:formatCellTooltip" width="25%">所属大项目名称</th>
						<th data-options="field:'fproBudgetAmount',align:'right',formatter:function(value,row,index){return fomatMoney(value,2);}" width="15%">项目预算[元]</th>
						<th data-options="field:'cz',align:'center',formatter:cz" width="10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
		<%-- <div class="win-left-bottom-div" style="height: 30px">
			<a href="javascript:void(0)" onclick="select()">
			<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>&nbsp;&nbsp;
			<a href="javascript:void(0)" onclick="closeSecondWindow()">
			<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
		</div> --%>
	</div>
	
<script type="text/javascript">
//查询
function queryCF() {
	$("#choose_zxm_dg").datagrid('load',{
		FProName:$("#query_name").textbox('getValue').trim(),
		bigProName:$("#query_bigName").textbox('getValue').trim(),
	});
}

//清除查询条件
function clearTable() {
	
	$("#query_name").textbox('setValue','');
	$("#query_bigName").textbox('setValue','');
	
	$("#choose_zxm_dg").datagrid('load',{});
}
 //双击选择页面
$('#choose_zxm_dg').datagrid({
	onDblClickRow: function(rowIndex, rowData){
		/* var i=${index};
		$('#people_'+i).val(rowData.name+"\xa0"+rowData.departName);
		//closeSecondWindow(); */
	}
}); 


	function select() {
		var ids = "";
		var rows = $('#choose_zxm_dg').datagrid('getSelections');
		if(rows.length<1){
			alert("请选择子项目");
		}else{
			for (var i = 0; i < rows.length; i++) {
				ids=ids+rows[i].fproId+",";
			}
			
			$.messager.progress();
			$.ajax({
				url : base + '/project/importZxm?ids='+ids,
				type : 'post',
				dataType : 'json',
				
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						closeFirstWindow();
						$.messager.progress('close');
						$('#pro_dg_2').datagrid('reload'); 
					} else {
						$.messager.alert('系统提示', data.info, 'error');
						$.messager.progress('close');
					}
				}
			});
		}
	}

	function cz(val, row) {
		var id = row.fproId;
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'
				+ '<a href="#" onclick="detail1('
				+ id
				+ ')" class="easyui-linkbutton">'
				+ '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'
				+ base
				+ '/resource-modality/${themenurl}/list/select1.png">'
				+ '</a></td></tr></table>';

	}
	function detail1(id) {
		var win = creatWin('查看-项目信息', 1230, 630, 'icon-search',
				'/project/detail/' + id);
		win.window('open');
	}
</script>
</body>
</html>


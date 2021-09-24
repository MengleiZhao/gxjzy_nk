<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
<style type="text/css">
.tabletop{margin: 0 10px 10px 10px;background-color: #fff;font-family: "微软雅黑"}
.queryth{text-align: right;}
</style>
</head>
<body style="background-color: #f0f5f7;text-align: center;">
	<div style="height: 10px;background-color:#f0f5f7 "></div>	
	<div class="tabletop" >
		<table class="topTable" style="width: 100%;font-size: 12px;height: 40px;">
				<tr>
					<td style="width: 90px;" class="queryth">物质编号：</td> 
					<td style="width: 140px">
						<input id="ledger_fAssCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td style="width: 90px;" class="queryth">资产名称：</td> 
					<td style="width: 140px">
						<input id="ledger_fAssName" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<%-- <td style="width: 90px;" class="queryth">资产类型：</td> 
					<td style="width: 140px">
						 <input id="ledger_fAssType" name="" style="width: 150px;height:25px;" data-options="url:'${base}/Handle/lookupsJson?parentCode=ZCLX',method:'POST',valueField:'code',textField:'text',editable:false" class="easyui-combobox"></input>
					</td> --%>
					<td style="width: 90px;" class="queryth">规格型号：</td> 
					<td style="width: 140px">
						<input id="ledger_fSPModel" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td style="width: 12px">
					</td>
					<td style="width: 24px;">
						<a href="javascript:void(0)"  onclick="queryStorage();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td style="width: 12px">
					</td>
					<td >
						<a href="javascript:void(0)"  onclick="clearTable();"><img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"></a>
					</td>
					<td style="width: 12px">
					</td>
					<%-- <td align="right">
						<a href="#" onclick="addCF()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)" ></a>
					</td> --%>
					<td style="width: 14px">
					</td>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
				
		</div>
		
		<div style="margin: 0 10px 0 10px;height: 420px;" >
			<table id="ledger_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/AssetsLedger/JsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fAssId',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'fAssName',align:'left',resizable:false,sortable:true" width="25%">资产名称</th>
						<th data-options="field:'fAssCode',align:'left'" width="20%">资产编号</th>
						<th data-options="field:'fSPModel',align:'left',resizable:false,sortable:true" width="20%">规格型号</th>
						<th data-options="field:'stockNum',align:'left'" width="10%" >库存数量</th>
						<th data-options="field:'fMeasUnit',align:'left'," width="10%" >计量单位</th>
						<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ" width="11%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	


<script type="text/javascript">
//分页样式调整
$(function(){
	var pager = $('#ledger_dg').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});			
});
//清除查询条件
function clearTable() {
	/* $(".topTable :input[type='text']").each(function(){
		$(this).val("");
	}); */
	$('#ledger_fAssCode').textbox('setValue',null);
	$('#ledger_fAssName').textbox('setValue',null);
	$('#ledger_fSPModel').textbox('setValue',null);
	$('#ledger_fAssType').textbox('setValue',null);
}
//鼠标移入图片替换
function mouseOver(img){
	var src = $(img).attr("src");
	src = src.replace(/1/, "2");
	$(img).attr("src",src);
}
	
function mouseOut(img) {
	var src = $(img).attr("src");
	src = src.replace(/2/, "1");
	$(img).attr("src",src);
}
	 function CheckYou() {
		var flag = true;
		var regu = "^[a-zA-Z\u4e00-\u9fa5]+$";
		 if(!regu.test($('#"ledger_fAssCode_R"').val()) && flag == true){
		    	alert("请输入中文或英文！");
		    	flag = false;
		    } 	
	} 
	var fs
	function formatPrice(val, row) {
		fs=val;
		if (val == 0) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</span>';
		} else if (val == 1) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</span>';
		}else if (val == 9) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</span>';
		}else if (val == 99) {
			return '<span style="color:#666666;">' + " 已删除" + '</span>';
		} else if (val == -1) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</span>';
		}
	}
	function CZ(val, row) {
		return '<a href="#" onclick="detail(' + row.fAssId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>   '
	}
	function showB(obj){
		obj.src=base+'/resource-modality/${themenurl}/select2.png';
	}
	function showA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function showC(obj){
		obj.src=base+'/resource-modality/${themenurl}/update2.png';
	}
	function showD(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/update1.png';
	}
	/* $(function() {
		//定义双击事件
		$('#ledger_dg').datagrid({
			onDblClickRow : function(rowIndex, rowData) {
				detailDemo();
			}
		});
	}); */
	function queryStorage() {
		$('#ledger_dg').datagrid('load', {
			fAssCode : $('#ledger_fAssCode').val(),
			fAssName : $('#ledger_fAssName').val(),
			fSPModel : $('#ledger_fSPModel').val(),
			fAssType : $('#ledger_fAssType').val()
		});
	}
	function addCF() {
		var win = creatWin('新增申请', 840, 450, 'icon-search',"/Alloca/add");
		win.window('open');
	}
	function detail(id) {
			var win = creatWin('查看', 840, 450, 'icon-search',"/AssetsLedger/detail/" + id);
			win.window('open');
	}
	/* function editCF() {
		var row = $('#ledger_dg').datagrid('getSelected');
		var selections = $('#ledger_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			var win = creatWin(' ', 840, 450, 'icon-search',
					"/Storage/edit/" + row.fAssId);
			win.window('open');
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		}
	} */
	function Alloca_update(id) {
		//var row = $('#ledger_dg').datagrid('getSelected');
		var win = creatWin('修改', 840, 450, 'icon-search',
				"/Alloca/edit/" + id);
		win.window('open');
	}
	function Alloca_delete(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/Alloca/delete/' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#ledger_dg').form('clear');
						$("#ledger_dg").datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	}
	function expListlawHelp() {
		//var win=creatWin('导出-法律服务接待登记表',400,120,'icon-search','/demo/exportList');
		//win.window('open');
		if (confirm("按当前查询条件导出？")) {
			var queryForm = document.getElementById("lawHelp_list_form");
			queryForm.setAttribute("action", "${base}/demo/expList");
			queryForm.submit();
		}
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
		return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
	}
	//在线帮助
	function helpDemo() {
		window.open("./resource/onlinehelp/zzzx/demo/help.html");
	}
	function test(val) {
		alert('test')
	}
	function formatOper(value, row, index) {
		return 'sfsdf';
		//return '<a href="#" onclick="test('+index+')">修改</a>';  
		//    return '<a href="javascript:void(0);" onclick="openviewzfrw(\''+row.person+'\',\''+row.data_status+'\')"><font color="blue">走访</font></a>'; 
	}
</script>
</body>
</html>


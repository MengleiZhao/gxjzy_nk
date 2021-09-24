<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr >
					<td class="top-table-search" >合同编号&nbsp;
						<input id="goldpay_fcCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;合同名称&nbsp;
						<input id="goldpay_fcTitle" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;退还状态&nbsp;
						<select id="goldpay_fMarginAmount" style="width: 150px;height:25px;" class="easyui-combobox" editable="false">
							<option selected="selected" value="">--请选择--</option>
							<option value="0">未退还</option>
							<option value="1">已退还</option>
						</select>
						&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="goldpay_query();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="goldpay_clearTable();"><img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
					
					
					</td> 
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
		</div>
		<div class="list-table">
			<table id="goldpay_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/GoldPay/JsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fcId',hidden:true"></th>
						<th data-options="field:'fPlanId',hidden:true">付款计划的id</th>
						<th data-options="field:'number',align:'center',resizable:false,sortable:true" width="5%">序号</th>
						<th data-options="field:'fcCode',align:'center',resizable:false,sortable:true" width="15%">合同编号</th>
						<th data-options="field:'fcTitle',align:'center',resizable:false,sortable:true" width="15%">合同名称</th>
						<th data-options="field:'fReqtIME',align:'center',formatter: ChangeDateFormat,resizable:false,sortable:true" width="8%" >合同申请日期</th>
						<th data-options="field:'fContStartTime',align:'center',formatter: ChangeDateFormat,resizable:false,sortable:true" width="8%" >合同开始日期</th>
						<th data-options="field:'fContEndTime',align:'center',formatter: ChangeDateFormat,resizable:false,sortable:true" width="8%" >合同结束日期</th>
						<th data-options="field:'fcAmount',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" width="10%">合同金额(万元)</th>
						<th data-options="field:'fMarginAmount',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" width="10%">保证金金额(元)</th>
						<th data-options="field:'fRecTime',align:'center',formatter: ChangeDateFormat,resizable:false,sortable:true" width="8%" >退还日期</th>
						<th data-options="field:'fPayStauts',align:'center',formatter:PayStauts,resizable:false,sortable:true" width="6%">退还状态</th>
						<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ" width="8%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>


<script type="text/javascript">
//清除查询条件
function goldpay_clearTable() {
	$('#goldpay_fcCode').textbox('setValue',null);
	$('#goldpay_fcTitle').textbox('setValue',null);
	$('#goldpay_fMarginAmount').combobox('setValue',null);
	$('#goldpay_fReqtIME').datebox('setValue',null);
	goldpay_query();
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

	var fs
	function PayStauts(val, row) {
		fs=val;
		if (val == 1) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">'  + " 已退还" + '</span>';
		}else if (val == 0) {
			return '<span style="color:red;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">'  + " 未退还" + '</span>';
		}
	}
	function ContStauts(val, row) {
		if (val == 1) {
			return '<span >' + "未备案" + '</span>';
		} else if (val == 9) {
			return '<span >' + "已备案" + '</span>';
		}else if (val == 3) {
			return '<span >' + "已结项" + '</span>';
		}else if (val == 5) {
			return '<span >' + "已归档" + '</span>';
		}else if (val == 7) {
			return '<span >' + "有纠纷" + '</span>';
		}
	}
	function formatPrice(val, row) {
		if (val == 0) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</span>';
		} else if (val == 1) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</span>';
		} else if (val == 9) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</span>';
		}else if (val == 99) {
			return '<span style="color:#666666;">' + " 已删除" + '</span>';
		}
	}
	function CZ(val, row) {
		if(fs==1){
			return '<a href="#" onclick="goldpay_detail(' + row.fcId+ ')" class="easyui-linkbutton"><img onmouseover="goldpayshowB(this)" onmouseout="goldpayshowA(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
		}else if(fs==0){
			return  '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'
					+'<a href="#" onclick="goldpay_detail(' + row.fcId+ ')" class="easyui-linkbutton"><img onmouseover="goldpayshowB(this)" onmouseout="goldpayshowA(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'
					+'</a>'+ '</td><td style="width: 25px">'
					+'<a href="#" onclick="returnGold(' + row.fcId+ ')" class="easyui-linkbutton"><img onmouseover="goldpayshowC(this)" onmouseout="goldpayshowD(this)" src="'+base+'/resource-modality/${themenurl}/list/returnGold1.png">' 
					+'</a></td></tr></table>';
		}
			
	}
	function goldpayshowB(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select2.png';
	}
	function goldpayshowA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function goldpayshowC(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/returnGold2.png';
	}
	function goldpayshowD(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/returnGold1.png';
	}
	/* $(function() {
		//定义双击事件
		$('#goldpay_dg').datagrid({
			onDblClickRow : function(rowIndex, rowData) {
				detailDemo();
			}
		});
	}); */
	function goldpay_query() {
		$('#goldpay_dg').datagrid('load', {
			fcCode : $('#goldpay_fcCode').val(),
			fcTitle : $('#goldpay_fcTitle').val(),
			fPayStauts : $('#goldpay_fMarginAmount').val(),
			fReqtIME : $('#goldpay_fReqtIME').val()
		});
	}
	function addCF() {
		var node = $('#goldpay_dg').datagrid('getSelected');
		var win = creatWin(' ', 970, 580, 'icon-search', '/Formulation/add');
		if (null != node) {
			win = creatWin(' ', 970, 580, 'icon-search',
					'/Formulation/add?departId=' + node.id);
		}
		win.window('open');
	}
	function returnGold(id) {
			var win = creatWin('质保金退还', 705, 580, 'icon-search',"/GoldPay/returnGold/" + id);
			win.window('open');
	}
	function goldpay_detail(id) {
			var win = creatWin('质保金管理', 705, 580, 'icon-search',"/GoldPay/detail/" + id);
			win.window('open');
	}
	/* function editCF() {
		var row = $('#goldpay_dg').datagrid('getSelected');
		var selections = $('#goldpay_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			var win = creatWin(' ', 970, 580, 'icon-search',
					"/Formulation/edit/" + row.fcId);
			win.window('open');
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		}
	} */
	function CF_update(id) {
		//var row = $('#goldpay_dg').datagrid('getSelected');
		console.log(id);
		var selections = $('#goldpay_dg').datagrid('getSelections');
		var win = creatWin(' ', 970, 580, 'icon-search',
				"/Formulation/edit/" + id);
		win.window('open');
	}
	function CF_delete(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/Formulation/delete/' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#CFAddEditForm').form('clear');
						$("#goldpay_dg").datagrid('reload');
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
</script>
</body>
</html>


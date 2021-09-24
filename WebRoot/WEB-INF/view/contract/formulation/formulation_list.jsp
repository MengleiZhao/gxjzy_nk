<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-search">合同编号&nbsp;
						<input id="c_fcCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;合同名称&nbsp;
						<input id="c_fcTitle" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;合同金额&nbsp;
						<input id="c_cAmountBegin"  name="" style="width: 150px;height:25px;" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" validType="numberBegin[c_cAmountEnd]" class="easyui-numberbox"></input>
						&nbsp;-&nbsp;
						<input id="c_cAmountEnd" name="" style="width: 150px;height:25px;" data-options="icons: [{iconCls:'icon-yuan'}],precision:2,groupSeparator:','" class="easyui-numberbox"></input>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="queryCF();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="clearTable();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"></a>
					</td> 
					<td align="right" style="padding-right: 10px">
					<a href="#"   onclick="addCF()" >
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/htndsq1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/htndsq2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/htndsq1.png')">
					</a>
					</td>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
		</div>
		
		<div class="list-table">
			<table id="CF_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Formulation/JsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<!-- <th data-options="field:'ck',checkbox:true"></th> -->
						<th data-options="field:'fcId',hidden:true"></th>
						<th data-options="field:'number',align:'center',resizable:false,sortable:true" width="5%">序号</th>
						<th data-options="field:'fcCode',align:'center',resizable:false,sortable:true" width="17%">合同编号</th>
						<th data-options="field:'fcTitle',align:'center',resizable:false,sortable:true" width="20%">合同名称</th>
						<th data-options="field:'fcAmount',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" width="10%">合同金额(元)</th>
						<th data-options="field:'fReqtIME',align:'center',formatter: ChangeDateFormat,resizable:false,sortable:true" width="9%" >申请日期</th>
						<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" width="10%">申请部门</th>
						<th data-options="field:'fOperator',align:'center',resizable:false,sortable:true" width="10%">申请人</th>
						<th data-options="field:'fFlowStauts',align:'center',resizable:false,sortable:true,formatter:formatPrice" width="10%">审批状态</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" width="10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
</div>	


<script type="text/javascript">
	//查询
	function queryCF() {
		var fs=$('#c_fFlowStauts').val();
		if(fs=="SPZT-01"){
			fs="-1";
		}else if(fs=="SPZT-02"){
			fs="0";
		}else if(fs=="SPZT-03"){
			fs="1";
		}else if(fs=="SPZT-04"){
			fs="9";
		}
		var amountEnd = $('#c_cAmountEnd').val();
		var amountBegin = $('#c_cAmountBegin').val();
		if((amountEnd!=null||amountEnd!='')&&(amountBegin!=null||amountBegin!='')){
			
		}
		
		$('#CF_dg').datagrid('load', {
			fcCode : $('#c_fcCode').val(),
			fcTitle : $('#c_fcTitle').val(),
			cAmountBegin : $('#c_cAmountBegin').val(),
			cAmountEnd : $('#c_cAmountEnd').val(),
			fFlowStauts : fs
		});
	}
	//清除查询条件
	function clearTable() {
		$('#c_fcCode').textbox('setValue',null);
		$('#c_fcTitle').textbox('setValue',null);
		$('#c_cAmountBegin').numberbox('setValue',null);
		$('#c_cAmountEnd').numberbox('setValue',null);
		$('#c_fFlowStauts').textbox('setValue',null);
		queryCF();
	}

	var fs
	function ContStauts(val, row) {
		fs=val;
		if (val == 1) { 
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 未备案" + '</span>';
		} else {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已备案" + '</span>';
		}
	}
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
		}else if (val == -4) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已撤回" + '</span>';
		}
	}
	function CZ(val, row) {
		if(fs==9){
			return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'+
					'<a href="#" onclick="detail(' + row.fcId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a></td></tr></table>';
		}
		if(fs==1){
			return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'+
					'<a href="#" onclick="detail(' + row.fcId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
					+'</td><td style="width: 25px">'+ '<a href="#" onclick="reCall(\'CF_dg\' ,'+ row.fcId+',\'/Formulation/reCall\''+')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">' + '</a>'
					+'</td></tr></table>';
		}
		return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="detail(' + row.fcId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
				+'</td><td style="width: 25px">'+ '<a href="#" onclick="CF_update(' + row.fcId
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>'
				+'</td><td style="width: 25px">'+'<a href="#" onclick="CF_delete(' + row.fcId
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">' + '</a>'
				+'</td></tr></table>';
	}
	//新增
	function addCF() {
		var win = creatWin('合同拟定申请', 1115, 580, 'icon-search', '/Formulation/add');
		win.window('open');
	}
	//查看
	function detail(id) {
		var win = creatWin('合同拟定明细', 1115, 580, 'icon-search','/Formulation/detail/'+id);
		win.window('open');
	}
	//修改
	function CF_update(id) {
		var win = creatWin('合同拟定-修改', 1115, 580, 'icon-search','/Formulation/edit/'+id);
		win.window('open');
	}
	//删除
	function CF_delete(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/Formulation/delete/'+id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#CFAddEditForm').form('clear');
						$("#CF_dg").datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	}
	
	/* function expListlawHelp() {
		var win=creatWin('导出-法律服务接待登记表',400,120,'icon-search','/demo/exportList');
		win.window('open');
		if (confirm("按当前查询条件导出？")) {
			var queryForm = document.getElementById("lawHelp_list_form");
			queryForm.setAttribute("action", "${base}/demo/expList");
			queryForm.submit();
		}
	} */
	
	/* //金额区间校验
	$('#c_cAmountBegin').numberbox({
		onChange : function(newValue,oldValue){
			var amountEnd = $('#c_cAmountEnd').val();
			if(amountEnd!=null||amountEnd!=''){
				if(newValue>amountEnd){
					$('#c_cAmountBegin').numberbox('setValue',null);
					alert("合同金额起始值不得大于截止值");
				}
			}
		}
	}) */
	/* $.extend($.fn.validatebox.defaults.rules, {
	    numberBegin: {
			validator: function(value,param){
				var end = $('#'+param[0].id).numberbox('getValue');
				if(end==null||end==""){
					return true;
				}else {
					return value == $(param[0].id).val();
				}
			},
			message: '起始值不得大于截止值'
	    }
	}); */
</script>
</body>


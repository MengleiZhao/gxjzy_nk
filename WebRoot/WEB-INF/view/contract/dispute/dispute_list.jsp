<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-search" class="queryth">合同编号&nbsp;
						<input id="dispute_fcCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;合同名称&nbsp;
						<input id="dispute_fcTitle" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;申请时间&nbsp;
						<input id="dispute_fReqtIME" name="" style="width: 150px;height:25px;"  class="easyui-datebox" editable="false"></input>
						&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="disput_query();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')">
						</a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="disput_clearTable();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td> 
					<td align="right" style="padding-right: 10px">
						<a href="#" onclick="change_add()" ><img src="${base}/resource-modality/${themenurl}/button/htjfxz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
					</td>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
				
			</table>
		</div>
		
		<div class="list-table">
			<table id="dispute_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Dispute/JsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<!-- <th data-options="field:'ck',checkbox:true"></th> -->
						<th data-options="field:'fcId',hidden:true"></th>
						<th data-options="field:'number',align:'center',resizable:false,sortable:true" width="5%">序号</th>
						<th data-options="field:'fcCode',align:'center',resizable:false,sortable:true" width="20%">合同编号</th>
						<th data-options="field:'fcTitle',align:'center',resizable:false,sortable:true" width="21%">合同名称</th>
						<th data-options="field:'fOperator',align:'center',resizable:false,sortable:true" width="10%">申请人</th>
						<th data-options="field:'fReqtIME',align:'center',formatter: ChangeDateFormat,resizable:false,sortable:true" width="15%" >申请日期</th>
						<th data-options="field:'fcAmount',align:'center',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" width="10%">合同金额(万元)</th>
						<th data-options="field:'fDisputeStatus',align:'center',resizable:false,sortable:true,formatter:ContStauts" width="10%">合同状态</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" width="10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	


<script type="text/javascript">
//清除查询条件
function disput_clearTable() {
	$('#dispute_fcCode').textbox('setValue',null);
	$('#dispute_fcTitle').textbox('setValue',null);
	$('#dispute_fcAmount').textbox('setValue',null);
	$('#dispute_fReqtIME').datebox('setValue',null);
	disput_query();
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
	/* function CheckYou() {
		var flag = true;
		var regu = "^[a-zA-Z\u4e00-\u9fa5]+$";
		 if(!regu.test($('#"e_fcCode"').val()) && flag == true){
		    	alert("请输入中文或英文！");
		    	flag = false;
		    } 	
	} */
	var s;
	function ContStauts(val, row) {
		s=val;
		if (s == null || s == 0 || row.fDisputeStatus== 'null') {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 无纠纷" + '</span>';
		}else if (s == 1) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 有纠纷" + '</span>';
		}
	}
	function formatPrice(val, row) {
		if (val == 0) {
			return '<span style="color:yellow;">' + "暂存" + '</span>';
		} else if (val == 1) {
			return '<span style="color:red;">' + "待审批" + '</span>';
		}
	}
	function CZ(val, row) {
		if(row.fDisputeStatus=='0' || row.fDisputeStatus== null || row.fDisputeStatus== 'null'){
		return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'
				+'<a href="#" onclick="detailInfo(' + row.fcId+ ')" class="easyui-linkbutton"><img onmouseover="disputeshowC(this)" onmouseout="disputeshowD(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>' 
				+'</td><td style="width: 25px">'
				+'<a href="#" onclick="updateDispute(' + row.fcId
				+ ')" class="easyui-linkbutton"><img  onmouseover="disputeshowB(this)" onmouseout="disputeshowA(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'
				+ '</a>'+ '</td><td style="width: 25px">'+
				'<a href="#" onclick="deleteApply(' + row.fcId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
				'</a></td></tr></table>';
		}
		if(row.fDisputeStatus=='1'){
		return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'
				+'<a href="#" onclick="detailInfo(' + row.fcId+ ')" class="easyui-linkbutton"><img onmouseover="disputeshowC(this)" onmouseout="disputeshowD(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'
				+ '</a></td></tr></table>';
		}
	}
	
	//删除
function deleteApply(id,type) {
	if (confirm("确认删除吗？")) {
		$.ajax({
			type : 'POST',
			url : '${base}/Dispute/delete?id=' + id,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#applyTab'+type).datagrid('reload');
					disput_query();
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
		
	}
}
	function disputeshowB(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/update2.png';
	}
	function disputeshowA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/update1.png';
	}
	function disputeshowC(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select2.png';
	}
	function disputeshowD(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function disput_query() {
		$('#dispute_dg').datagrid('load', {
			fcCode : $('#dispute_fcCode').val(),
			fcTitle : $('#dispute_fcTitle').val(),
			fcAmount : $('#dispute_fcAmount').val(),
			fReqtIME : $('#dispute_fReqtIME').val()
		});
	}
	function detailInfo(id) {
		var win = creatWin('查看', 780, 560, 'icon-search',"/Dispute/detail/" + id);
		win.window('open');
	}
	
	function change_add() {
	var win = creatFirstWin('合同信息', 970,550, 'icon-search',"/Dispute/popupht");
	win.window('open');
}
	function addDispute() {
		var node = $('#dispute_dg').datagrid('getSelected');
		var selections = $('#dispute_dg').datagrid('getSelections');
		
		if (node != null && selections.length == 1) {
			var win = creatWin('合同纠纷申请', 780, 560, 'icon-search',
					"/Dispute/add/" +node.fcId);
			win.window('open');
		} else {
			$.messager.alert('系统提示', '请先鼠标单击选择一条数据！', 'info');
		}
	}
	function updateDispute(id) {
	/* 	var node = $('#dispute_dg').datagrid('getSelected');
		var selections = $('#dispute_dg').datagrid('getSelections');
		if (node != null && selections.length == 1) { */
			var win = creatWin('合同纠纷', 780, 560, 'icon-search',
					"/Dispute/edit/" +id);
			win.window('open');
		/* } else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		} */
	}
	
	function CF_delete(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/Dispute/delete/' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$("#dispute_dg").datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
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


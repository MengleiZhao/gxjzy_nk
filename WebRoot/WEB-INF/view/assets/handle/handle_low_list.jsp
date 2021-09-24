<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-search">处置单号&nbsp;
						<input id="handle_low_fAssHandleCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;申请部门&nbsp;
						<input id="handle_low_fRecDept" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;申请人&nbsp;
						<input id="handle_low_fReqUser" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="reg_low_query();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')">
						</a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="reg_low_clearTable();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')">
						</a>
					</td>
					<td align="right" style="padding-right: 10px">
						<a href="#" onclick="reg_low_add()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)" ></a>
					</td>
					<%-- <td class="top-table-td1">资产处置单号：</td> 
					<td class="top-table-td2">
						<input id="handle_low_fAssHandleCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">处置物资名称：</td> 
					<td class="top-table-td2">
						<input id="handle_low_fRecDept" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">处置方式：</td> 
					<td class="top-table-td2">
						 <input id="handle_low_fReqUser" name="" style="width: 150px;height:25px;" data-options="url:'${base}/Handle/lookupsJson?parentCode=CZFS',method:'POST',valueField:'code',textField:'text',editable:false" class="easyui-combobox"></input>
					</td>
					<!-- <td class="top-table-td1">申请时间：</td> 
					<td class="top-table-td2">
						<input id="handle_low_fReqTime" name="" style="width: 150px;height:25px;" class="easyui-datebox"></input>
					</td> -->
					<td style="width: 12px">
					</td>
					<td style="width: 24px;">
						<a href="javascript:void(0)"  onclick="reg_low_query();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td style="width: 12px">
					</td>
					<td >
						<a href="javascript:void(0)"  onclick="reg_low_clearTable();"><img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"></a>
					</td>
					<td style="width: 12px">
					</td>
					<td align="right">
						<a href="#" onclick="reg_low_add()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)" ></a>
					</td>
					<td style="width: 14px">
					</td> --%>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
				
		</div>
		
		<div class="list-table">
			<table id="handle_low_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Handle/applicationJson?fAssType.code=ZCLX-01',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fId',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'fAssHandleCode',align:'center'" width="21%">处置单单号</th>
						<th data-options="field:'fRecDept',align:'center',resizable:false,sortable:true" width="15%">申请部门</th>
						<th data-options="field:'fReqUser',align:'center',resizable:false,sortable:true" width="15%">申请人</th>
						<th data-options="field:'fReqTime',align:'center',formatter: ChangeDateFormat" width="15%" >申请日期</th>
						<th data-options="field:'fFlowStauts',align:'center',formatter:formatPrice,resizable:false,sortable:true" width="15%">审批状态</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" width="15%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	


<script type="text/javascript">
//清除查询条件
function reg_low_clearTable() {
	$('#handle_low_fAssHandleCode').textbox('setValue',null),
	$('#handle_low_fRecDept').textbox('setValue',null),
	$('#handle_low_fReqTime').datebox('setValue',null),
	$('#handle_low_fReqUser').textbox('setValue',null),
	reg_low_query();
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
		 if(!regu.test($('#"allcoa_fAssCode_R"').val()) && flag == true){
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
	function CZFS(val, row) {
		if(val=='CZFS-01'){
			return '作废';
		}if(val=='CZFS-02'){
			return '变卖';
		}if(val=='CZFS-03')
			return '报损';
		if(val=='CZFS-04')
			return '遗失';
		else if(val=='CZFS-05')
			return '非转经';	
	}
	function CZ(val, row) {
		if(fs==9||fs==1){
			return '<table><tr style="width: 105px;height:20px"><td style="width: 25px">'
					+'<a href="#" onclick="reg_low_detail(' + row.fId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>   '
					+'</td></tr></table>';
		}else {
			return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'
					+'<a href="#" onclick="reg_low_detail(' + row.fId
					+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
					+'</td><td style="width: 25px">'
					+ '<a href="#" onclick="reg_low_update(' + row.fId
					+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>'
					+'</td><td style="width: 25px">'
					+'<a href="#" onclick="reg_low_delete(' + row.fId
					+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">' + '</a>'
					+'</td></tr></table>';
		}
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
	function reg_low_query() {
		$('#handle_low_dg').datagrid('load', {
			fAssHandleCode : $('#handle_low_fAssHandleCode').val(),
			fRecDept : $('#handle_low_fRecDept').val(),
			fReqTime : $('#handle_low_fReqTime').val(),
			fReqUser : $('#handle_low_fHandleKind').val()
		});
	}
	function reg_low_add() {
		var win = creatWin('处置申请', 970, 580, 'icon-search',"/Handle/addApplication?fAssType=ZCLX-01");
		win.window('open');
	}
	function reg_low_detail(id) {
			var win = creatWin('处置明细', 970, 580, 'icon-search',"/Handle/detail/"+id);
			win.window('open');
	}
	/* function editCF() {
		var row = $('#handle_low_dg').datagrid('getSelected');
		var selections = $('#handle_low_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			var win = creatWin(' ', 970,580, 'icon-search',
					"/Storage/edit/" + row.fId);
			win.window('open');
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		}
	} */
	function reg_low_update(id) {
		//var row = $('#handle_low_dg').datagrid('getSelected');
		var win = creatWin('处置-修改', 970,580, 'icon-search',
				"/Handle/edit/" + id);
		win.window('open');
	}
	function reg_low_delete(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/Handle/delete/' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#handle_low_dg').form('clear');
						$('#handle_low_dg').datagrid('reload');
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


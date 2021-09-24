<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-search">处置单号
						<input id="handle_reg_fAssHandleCode${fAssType }" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;资产名称&nbsp;
						<input id="handle_reg_fAssName${fAssType }" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;处置方式&nbsp;
						<input id="handle_reg_fHandleKind${fAssType }" name="" style="width: 150px;height:25px;" data-options="url:'${base}/Handle/lookupsJson?parentCode=CZFS',method:'POST',valueField:'code',textField:'text',editable:false" class="easyui-combobox"></input>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="handle_reg_query('${fAssType }');">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')">
						</a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="handle_reg_clearTable('${fAssType }');">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')">
						</a>
					</td>
					<td align="right" style="padding-right: 10px">
						<a href="#" onclick="handle_reg_add('${fAssType }')" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)" ></a>
					</td>
					<%-- <td class="top-table-td1">处置登记单号：</td> 
					<td class="top-table-td2">
						<input id="handle_reg_fAssHandleCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">登记人：</td> 
					<td class="top-table-td2">
						<input id="handle_reg_fAssName" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">处置方式：</td> 
					<td class="top-table-td2">
						 <input id="handle_reg_fHandleKind" name="" style="width: 150px;height:25px;" data-options="url:'${base}/Handle/lookupsJson?parentCode=CZFS',method:'POST',valueField:'code',textField:'text',editable:false" class="easyui-combobox"></input>
					</td>
					<td class="top-table-td1">登记日期：</td> 
					<td class="top-table-td2">
						<input id="reg_fRegTime" name="" style="width: 150px;height:25px;" class="easyui-datebox"></input>
					</td>
					<td style="width: 12px">
					</td>
					<td style="width: 24px;">
						<a href="javascript:void(0)"  onclick="handle_reg_query();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td style="width: 12px">
					</td>
					<td >
						<a href="javascript:void(0)"  onclick="handle_reg_clearTable();"><img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"></a>
					</td>
					<td style="width: 12px">
					</td>
					<td align="right">
						<a href="#" onclick="handle_reg_add()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)" ></a>
					</td>
					<td style="width: 14px">
					</td> --%>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
				
		</div>
		
		<div class="list-table">
			<table id="handle_registration_dg${fAssType }" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Handle/registrationJson?fAssType=${fAssType }',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fRegId',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'fAssHandleRegCode',align:'left'" width="20%">资产处置登记单号（流水号）</th>
						<th data-options="field:'fAssName',align:'left',resizable:false,sortable:true" width="10%">处置资产名称</th>
						<th data-options="field:'fAssCode',align:'left',resizable:false,sortable:true" width="10%">处置资产编号</th>
						<th data-options="field:'fRegKind',align:'left',formatter: CZFS" width="10%" >处置方式</th>
						<th data-options="field:'fRegUser',align:'left',resizable:false,sortable:true" width="10%">登记人</th>
						<th data-options="field:'fRegTime',align:'left',formatter: ChangeDateFormat" width="15%" >登记日期</th>
						<th data-options="field:'fRegAmount',align:'left',resizable:false,sortable:true" width="10%">变卖金额</th>
						<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ" width="11%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	


<script type="text/javascript">
//清除查询条件
function handle_reg_clearTable(val) {
	$('#handle_reg_fAssHandleCode'+val).textbox('setValue',null),
	$('#handle_reg_fAssName'+val).textbox('setValue',null),
	$('#handle_reg_fHandleKind'+val).combobox('setValue',null),
	handle_reg_query(val);
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
		}else if(val=='CZFS-02'){
			return '便卖';
		}
	}
	function CZ(val, row) {
		if(fs==9){
			return '<a href="#" onclick="reg_detail(' + row.fRegId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>   '
		}
		if(fs==1){
			return '<a href="#" onclick="reg_detail(' + row.fRegId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>   '
		}
		return '<a href="#" onclick="reg_detail(' + row.fRegId
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
				+'&nbsp;&nbsp;'+ '<a href="#" onclick="reg_update(' + row.fRegId
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>'
				+'&nbsp;&nbsp;'+'<a href="#" onclick="reg_delete(' + row.fRegId
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">' + '</a>';
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
	function showE(obj){
		obj.src=base+'/resource-modality/${themenurl}/delete2.png';
	}
	function showF(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/delete1.png';
	}
	function handle_reg_query(val) {
		$('#handle_registration_dg'+val).datagrid('load', {
			fAssHandleRegCode : $('#handle_reg_fAssHandleCode'+val).val(),
			fAssName : $('#handle_reg_fAssName'+val).val(),
			fRegKind : $('#handle_reg_fHandleKind'+val).val(),
		});
	}
	function handle_reg_add(val) {
		var win = creatWin('新增', 770,580, 'icon-search',"/Handle/registrationAdd?fAssType="+val);
		win.window('open');
	}
	function reg_detail(id) {
			var win = creatWin('查看', 770,580, 'icon-search',"/Handle/registrationDetail/" + id);
			win.window('open');
	}
	/* function editCF() {
		var row = $('#handle_registration_dg').datagrid('getSelected');
		var selections = $('#handle_registration_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			var win = creatWin(' ', 970,580, 'icon-search',
					"/Storage/edit/" + row.fRegId);
			win.window('open');
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		}
	} */
	function reg_update(id) {
		//var row = $('#handle_registration_dg').datagrid('getSelected');
		var win = creatWin('修改',770,580, 'icon-search',
				"/Handle/registrationEdit/" + id);
		win.window('open');
	}
	function reg_delete(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/Handle/registrationDelete/' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#handle_registration_dg').form('clear');
						$('#handle_registration_dg').datagrid('reload');
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
	//日期格式化
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
		// 可根据需要在这里定义日期格式  
		return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
	}
</script>
</body>
</html>


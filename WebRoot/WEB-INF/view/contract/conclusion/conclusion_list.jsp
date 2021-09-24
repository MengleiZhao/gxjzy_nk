<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr >
					<td class="top-table-td1" class="queryth">合同编号：</td> 
					<td class="top-table-td2">
						<input id="conclusion_fcCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1" class="queryth">合同名称：</td> 
					<td class="top-table-td2">
						<input id="conclusion_fcTitle" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1" class="queryth">合同金额：</td> 
					<td class="top-table-td2">
						<input id="conclusion_fcAmount" name="" style="width: 150px;height:25px;" data-options="icons: [{iconCls:'icon-wanyuan'}]" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1" class="queryth">申请时间：</td> 
					<td class="top-table-td2">
						<input id="conclusion_fReqtIME" name="" style="width: 150px;height:25px;"  class="easyui-datebox"></input>
					</td>
					<td style="width: 12px">
					</td>
					<td style="width: 12px">
						<a href="javascript:void(0)" onclick="conclusion_query();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png"onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td style="width: 12px">
					</td>
					<td >
						<a href="javascript:void(0)"  onclick="conclusion_clearTable();"><img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
					</td>
					<td style="width: 30px">
					</td>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>
		</div>
			<div class="list-table">
			<table id="conclusion_dg" 
			data-options="collapsible:true,url:'${base}/Conclusion/JsonPagination',
			method:'post',fit:true,pagination:true,toolbar:'#lawHelpTab',singleSelect: true,
			selectOnCheck: true,checkOnSelect: true,remoteSort:true,nowrap:false">
				<thead>
					<tr >
						<!-- <th data-options="field:'ck',checkbox:true"></th> -->
						<th data-options="field:'fcId',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="6%">序号</th>
						<th data-options="field:'fcCode',align:'left'" width="20%">合同编号</th>
						<th data-options="field:'fcTitle',align:'left',resizable:false,sortable:true" width="20%">合同名称</th>
						<th data-options="field:'fOperator',align:'left',resizable:false,sortable:true" width="10%">申请人</th>
						<th data-options="field:'fReqtIME',align:'left',formatter: ChangeDateFormat" width="15%" >申请日期</th>
						<th data-options="field:'fcAmount',align:'left',resizable:false,sortable:true" width="10%">合同金额(万元)</th>
						<th data-options="field:'fContStauts',align:'left',resizable:false,sortable:true,formatter:ContStauts" width="10%">状态</th>
						<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ" width="10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	


<script type="text/javascript">
//分页样式调整
$(function(){
	var pager = $('#conclusion_dg').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});			
});
//清除查询条件
function conclusion_clearTable() {
	$(".topTable :input[type='text']").each(function(){
		$(this).val("");
		$('#conclusion_fcCode').textbox('setValue',null);
		$('#conclusion_fcTitle').textbox('setValue',null);
		$('#conclusion_fcAmount').textbox('setValue',null);
		$('#conclusion_fReqtIME').textbox('setValue',null);
	});
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
	var fs;
	function ContStauts(val, row) {
		fs=val;
		if (val == 1) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 未备案" + '</span>';
		} else if (val == 9) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 未结项" + '</span>';
		}else if (val == 3) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已结项" + '</span>';
		}else if (val == 5) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已归档" + '</span>';
		}else if (val == 7) {
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
		if(fs==3){
			return '<a href="#" onclick="detailInfo(' + row.fcId+ ')" class="easyui-linkbutton"><img onmouseover="conclusionshowB(this)" onmouseout="conclusionshowA(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+ '</a>';
		}
		if(fs==7){
			return '<a href="#" onclick="detailInfo(' + row.fcId+ ')" class="easyui-linkbutton"><img onmouseover="conclusionshowB(this)" onmouseout="conclusionshowA(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+ '</a>';
		}
		if(fs==9){
		return 	'<a href="#" onclick="detailInfo(' + row.fcId
				+ ')" class="easyui-linkbutton"><img onmouseover="conclusionshowB(this)" onmouseout="conclusionshowA(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+ '</a>'
				+'&nbsp;&nbsp;&nbsp;&nbsp;'
				+'<a href="#" onclick="finishHT(' + row.fcId
				+ ')" class="easyui-linkbutton"><img onmouseover="conclusionshowC(this)" onmouseout="conclusionshowD(this)" src="'+base+'/resource-modality/${themenurl}/list/conclusion1.png">' + '</a>';
		}
	}
	function conclusionshowB(obj){
		obj.src=base+'/resource-modality/${themenurl}/select2.png';
	}
	function conclusionshowA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function conclusionshowC(obj){
		obj.src=base+'/resource-modality/${themenurl}/conclusion2.png';
	}
	function conclusionshowD(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/conclusion1.png';
	}
	/* $(function() {
		//定义双击事件
		$('#conclusion_dg').datagrid({
			onDblClickRow : function(rowIndex, rowData) {
				detailDemo();
			}
		});
	}); */
	function conclusion_query() {
		$('#conclusion_dg').datagrid('load', {
			fcCode : $('#conclusion_fcCode').val(),
			fcTitle : $('#conclusion_fcTitle').val(),
			fcAmount : $('#conclusion_fcAmount').val(),
			fReqtIME : $('#conclusion_fReqtIME').val()
		});
	}
	function detailInfo(id) {
		var selections = $('#conclusion_dg').datagrid('getSelections');
		var win = creatWin('合同结项', 970, 580, 'icon-search',"/Conclusion/detail/" + id);
		win.window('open');
	}
	function editCF() {
		var row = $('#conclusion_dg').datagrid('getSelected');
		var selections = $('#conclusion_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			var win = creatWin('合同结项', 970, 580, 'icon-search',
					"/Change/edit/" + row.fcId);
			win.window('open');
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		}
	}
	function finishHT(id) {
		//var row = $('#conclusion_dg').datagrid('getSelected');
		var selections = $('#conclusion_dg').datagrid('getSelections');
		var win = creatWin('合同结项', 970, 580, 'icon-search',
				"/Conclusion/edit/" + id);
		win.window('open');
	}
	function deleteCF() {
		var row = $('#conclusion_dg').datagrid('getSelected');
		var selections = $('#conclusion_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			if (confirm("确认删除吗？")) {
				$.ajax({
					type : 'POST',
					url : '${base}/Change/delete/' + row.fcId,
					dataType : 'json',
					success : function(data) {
						if (data.success) {
							$.messager.alert('系统提示', data.info, 'info');
							$("#conclusion_dg").datagrid('reload');
						} else {
							$.messager.alert('系统提示', data.info, 'error');
						}
					}
				});
			}
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		}
	}
	function CF_delete(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/Change/delete/' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$("#conclusion_dg").datagrid('reload');
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


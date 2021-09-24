<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-search">调拨单号&nbsp;
						<input id="allcoa_approval_fAssAllcoaCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;申请时间&nbsp;
						<input id="allcoa_approval_fReqTimeBegin" name="" style="width: 150px;height:25px;" class="easyui-datebox" editable="false"></input>
						&nbsp;-&nbsp;
						<input id="allcoa_fReqTimeEnd" name="" style="width: 150px;height:25px;" class="easyui-datebox" editable="false"></input>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="query_alloca_approval();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')">
						</a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="alloca_approval_clearTable();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')">
						</a>
					</td>
					<%-- <td class="top-table-td1">资产调拨单号：</td> 
					<td class="top-table-td2">
						<input id="allcoa_approval_fAssAllcoaCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">原使用部门：</td> 
					<td class="top-table-td2">
						<input id="allcoa_fTransDept" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">接收部门：</td> 
					<td class="top-table-td2">
						 <input id="allcoa_approval_fReqTimeEnd" name="" style="width: 150px;height:25px;" data-options="" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">申请时间：</td> 
					<td class="top-table-td2">
						<input id="allcoa_approval_fReqTimeBegin" name="" style="width: 150px;height:25px;" class="easyui-datebox"></input>
					</td>
					<td style="width: 12px">
					</td>
					<td style="width: 24px;">
						<a href="javascript:void(0)"  onclick="query_alloca_approval();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td style="width: 12px">
					</td>
					<td >
						<a href="javascript:void(0)"  onclick="alloca_approval_clearTable();"><img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"></a>
					</td>
					<td style="width: 12px">
					</td>
					<td align="right">
						<a href="#" onclick="StorageApp_add()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)" ></a>
					</td>
					<td style="width: 14px">
					</td> --%>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
				
		</div>
		
		<div class="list-table">
			<table id="allcoa_approval_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Alloca/approvalJsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fId_A',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'fAssAllcoaCode',align:'center'" width="15%">资产调拨单号（流水号）</th>
						<th data-options="field:'fOutDept',align:'center',resizable:false,sortable:true" width="12%">调出部门</th>
						<th data-options="field:'fOutTime',align:'center',formatter: ChangeDateFormatIndex,resizable:false,sortable:true" width="10%" >调出时间</th>
						<th data-options="field:'fInDept',align:'center',resizable:false,sortable:true" width="12%">调入部门</th>
						<th data-options="field:'fInTime',align:'center',formatter: ChangeDateFormatIndex,resizable:false,sortable:true" width="10%" >调入时间</th>
						<th data-options="field:'fReqTime',align:'center',formatter: ChangeDateFormatIndex,resizable:false,sortable:true" width="10%" >申请时间</th>
						<th data-options="field:'fAllocaRemark',align:'left'" width="13%" >资产内部转移原因</th>
						<th data-options="field:'fFlowStauts',align:'center',formatter:formatPrice,resizable:false,sortable:true" width="7%">审批状态</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" width="7%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	


<script type="text/javascript">
//清除查询条件
function alloca_approval_clearTable() {
	$('#allcoa_approval_fAssAllcoaCode').textbox('setValue',null),
	$('#allcoa_approval_fReqTimeBegin').datebox('setValue',null),
	$('#allcoa_approval_fReqTimeEnd').datebox('setValue',null),
	query_alloca_approval();
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
	function CZ(val, row) {
		if(fs==9||fs==-1){
			return '<a href="#" onclick="StorageApp_detail(' + row.fId_A+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>   '
		}
		if(fs==1){
			return '<a href="#" onclick="StorageApp_detail(' + row.fId_A
			+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
			+'&nbsp;&nbsp;'+ '<a href="#" onclick="alloca_app_sp(' + row.fId_A
			+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/approval1.png">' + '</a>';
	}
	}
	function showB(obj){
		obj.src=base+'/resource-modality/${themenurl}/select2.png';
	}
	function showA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function showC(obj){
		obj.src=base+'/resource-modality/${themenurl}/approval2.png';
	}
	function showD(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/approval1.png';
	}
	/* $(function() {
		//定义双击事件
		$('#allcoa_approval_dg').datagrid({
			onDblClickRow : function(rowIndex, rowData) {
				detailDemo();
			}
		});
	}); */
	function query_alloca_approval() {
		$('#allcoa_approval_dg').datagrid('load', {
			fAssAllcoaCode : $('#allcoa_approval_fAssAllcoaCode').val(),
			fReqTimeBegin : $('#allcoa_approval_fReqTimeBegin').val(),
			fReqTimeEnd : $('#allcoa_approval_fReqTimeEnd').val(),
		});
	}
	function StorageApp_add() {
		var win = creatWin('新增申请', 970,580, 'icon-search',"/Alloca/add");
		win.window('open');
	}
	function StorageApp_detail(id) {
			var win = creatWin('查看', 970,580, 'icon-search',"/Alloca/detail/" + id);
			win.window('open');
	}
	/* function editCF() {
		var row = $('#allcoa_approval_dg').datagrid('getSelected');
		var selections = $('#allcoa_approval_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			var win = creatWin(' ', 970,580, 'icon-search',
					"/Storage/edit/" + row.fId_A);
			win.window('open');
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		}
	} */
	function Alloca_update(id) {
		//var row = $('#allcoa_approval_dg').datagrid('getSelected');
		var win = creatWin('修改', 970,580, 'icon-search',
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
						$('#allcoa_approval_dg').form('clear');
						$("#allcoa_approval_dg").datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	}
	function alloca_app_sp(id) {
		var win=creatWin('审批',970,580,'icon-search','/Alloca/approvalAlloca/'+id);
		win.window('open');
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
	
	$("#allcoa_approval_fReqTimeBegin").datebox({
	    onSelect : function(beginDate){
	        $('#allcoa_fReqTimeEnd').datebox().datebox('calendar').calendar({
	            validator: function(date){
	            	return beginDate <= date;
	            }
	        });
	    }
	});
</script>
</body>
</html>


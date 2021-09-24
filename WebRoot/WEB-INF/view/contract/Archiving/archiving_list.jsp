<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table id="archiving_one" class="top-table" cellpadding="0" cellspacing="0">
				<tr >
					<td class="top-table-search" class="queryth">合同编号&nbsp;
						<input id="archiving_fcCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;合同名称&nbsp;
						<input id="archiving_fcTitle" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;归档状态&nbsp;
						<input id="archiving_fContStauts" name="" style="width: 150px;height:25px;" data-options="url:'${base}/Formulation/lookupsJson?parentCode=HTGDZT',method:'POST',valueField:'code',textField:'text',editable:false" class="easyui-combobox"></input>
						&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="archiving_query(0);">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="archiving_clearTable(0);">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					
					
					</td> 
					<tr id="helpTr" style="display: none;">
				</tr>
				</tr>
			</table>
			
			<table id="archiving_two" class="top-table" cellpadding="0" cellspacing="0" hidden="hidden">
				<tr >
					<td class="top-table-search" class="queryth">合同编号&nbsp;
						<input id="archiving_fcCode1" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;合同名称&nbsp;
						<input id="archiving_fcTitle1" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;归档状态&nbsp;
						<input id="archiving_fContStauts1" name="" style="width: 150px;height:25px;" data-options="url:'${base}/Formulation/lookupsJson?parentCode=HTGDZT',method:'POST',valueField:'code',textField:'text',editable:false" class="easyui-combobox"></input>
						&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="archiving_query(1);">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="archiving_clearTable(1);">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					
					
					</td> 
					<tr id="helpTr" style="display: none;">
				</tr>
				</tr>
			</table>
		</div>
		<div class="list-table-tab">
		
		<div class="tab-wrapper" id="Archiving-tab" >
		<ul class="tab-menu">
			<li class="active" onclick="cgReceive(0);">合同信息</li>
			<!-- <li onclick="cgReceive(1);">変更合同</li> -->
		</ul>
		<div class="tab-content">
			<div style="height: 440px;">
				<table id="archiving_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Archiving/JsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true" >
				<thead>
				<tr>
					<!-- <th data-options="field:'ck',checkbox:true"></th> -->
					<th data-options="field:'fcId',hidden:true"></th>
					<th data-options="field:'number',align:'center',resizable:false,sortable:true" width="5%">序号</th>
					<th data-options="field:'fcCode',align:'center',resizable:false,sortable:true" width="15%">合同编号</th>
					<th data-options="field:'fcTitle',align:'center',resizable:false,sortable:true" width="15%">合同名称</th>
					<th data-options="field:'fOperator',align:'center',resizable:false,sortable:true" width="9%">申请人</th>
					<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" width="9%">申请部门</th>
					<th data-options="field:'fReqtIME',align:'center',formatter: ChangeDateFormat,resizable:false,sortable:true" width="10%">申请日期</th>
					<th data-options="field:'fcAmount',align:'center',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" width="9%">合同金额(元)</th>
					<th data-options="field:'fgdStauts',align:'center',resizable:false,sortable:true,formatter:ContStauts" width="10%">归档状态</th>
					<th data-options="field:'fFlowStauts',align:'center',resizable:false,sortable:true,formatter:gdStauts" width="10%">审批状态</th>
					<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" width="9%">操作</th>
				</tr>
				</thead>
			</table>
		</div>
				
		<%-- <div style="height: 440px;">
			<table id="archiving_dgs" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Archiving/JsonPaginationbg',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<!-- <th data-options="field:'ck',checkbox:true"></th> -->
						<th data-options="field:'fId_U',hidden:true"></th>
						<th data-options="field:'number',align:'center',resizable:false,sortable:true" width="5%">序号</th>
						<th data-options="field:'fUptCode',align:'center',resizable:false,sortable:true" width="15%">変更合同编号</th>
						<th data-options="field:'fContName',align:'center',resizable:false,sortable:true" width="14%">変更合同名称</th>
						<th data-options="field:'fContNameOld',align:'center',resizable:false,sortable:true" width="10%">原合同名称</th>
						<th data-options="field:'fOperator',align:'center',resizable:false,sortable:true" width="8%">申请人</th>
						<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" width="9%">申请部门</th>
						<th data-options="field:'fReqTime',align:'center',formatter: ChangeDateFormat,resizable:false,sortable:true" width="8%">申请日期</th>
						<th data-options="field:'fAmount',align:'center',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" width="8%">合同金额(元)</th>
						<th data-options="field:'fgdstatus',align:'center',resizable:false,sortable:true,formatter:ContStauts" width="8%">归档状态</th>
						<th data-options="field:'gdbgspstatus',align:'center',resizable:false,sortable:true,formatter:gdbgStauts" width="8%">审批状态</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZBG" width="7%">操作</th>
					</tr>
				</thead>
			</table>
		</div> --%>
	</div>
		</div>
</div>
</div>	


<script type="text/javascript">
flashtab("Archiving-tab");
//清除查询条件
function archiving_clearTable(num) {
	if(num==0){
		$('#archiving_fcCode').textbox('setValue',null);
		$('#archiving_fcTitle').textbox('setValue',null);
		$('#archiving_fContStauts').combobox('setValue',null);
		}else if(num==1){
		$('#archiving_fcCode1').textbox('setValue',null);
		$('#archiving_fcTitle1').textbox('setValue',null);
		$('#archiving_fContStauts1').combobox('setValue',null);
		}
	archiving_query(num);
}

//tab标签页
		function cgReceive(num){
			if(num==0){
				$("#archiving_one").show();
				$("#archiving_two").hide();
				$("#archiving_dg").datagrid('reload');
			}else if(num==1){
				$("#archiving_one").hide();
				$("#archiving_two").show();
				$("#archiving_dgs").datagrid('reload');
			}
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
		if (val == 1) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已归档" + '</span>';
		}else {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 未归档" + '</span>';
		}
	}
	
	var s;
	function gdStauts(val, row) {
		s=val;
		if (val == 0) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 未发起" + '</span>';
		}else if (val == 1){
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 待审批" + '</span>';
		}else if(val == -1){
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 已退回" + '</span>';
		}else if(val == -4){
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 已撤回" + '</span>';
		}else{
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 已审批" + '</span>';
		}
	}
	
	var s;
	function gdbgStauts(val, row) {
		s=val;
		if (val == 0) {
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 未发起" + '</span>';
		}else if (val == 1){
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 待审批" + '</span>';
		}else if(val == -1){
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 已退回" + '</span>';
		}else if(val == -4){
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 已撤回" + '</span>';
		}else{
			return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 已审批" + '</span>';
		}
	}
	
	function CZ(val, row) {
		s = row.fgdStauts;
		if(s==0){
			return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'
			+'<a href="#" onclick="ArchivingHT(' + row.fcId
			+ ')" class="easyui-linkbutton"><img onmouseover="arvchivingshowC(this)" onmouseout="arvchivingshowD(this)" src="'+base+'/resource-modality/${themenurl}/list/archiving1.png">' + '</a>'+ '</td></tr></table>';
		}else if (s==1){
			return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'
			+'<a href="#" onclick="detailInfo(' + row.fcId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' 
			+'</a></td></tr></table>';
		}
		/* else if (s==-1 || s==-4){
			return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'
			+'<a href="#" onclick="detailInfo(' + row.fcId
			+ ')" class="easyui-linkbutton"><img onmouseover="arvchivingshowB(this)" onmouseout="arvchivingshowA(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+ '</a>'+ '</td><td style="width: 25px">'
			+'<a href="#" onclick="updateDispute(' + row.fcId
			+ ')" class="easyui-linkbutton"><img  onmouseover="disputeshowB(this)" onmouseout="disputeshowA(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'
			+ '</a>'+ '</td><td style="width: 25px">'
			+'<a href="#" onclick="deleteCF(' + row.fcId
			+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'
			+'</a> </td></tr></table>';
		}else{
			return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'
			+'<a href="#" onclick="detailInfo(' + row.fcId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' 
			+'</a>'+'</td></tr></table>';
		} */
	}
	
	function CZBG(val, row) {
		s = row.gdbgspstatus;
		if(s==0){
			return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'
			+'<a href="#" onclick="ArchivingHTbg(' + row.fId_U
			+ ')" class="easyui-linkbutton"><img onmouseover="arvchivingshowC(this)" onmouseout="arvchivingshowD(this)" src="'+base+'/resource-modality/${themenurl}/list/archiving1.png">' + '</a>'+ '</td></tr></table>';
		}else if (s==1){
			return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'
			+'<a href="#" onclick="detailInfobg(' + row.fId_U+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' 
			+'</a></td><td style="width: 25px">'+ '<a href="#" onclick="reCall(\'archiving_dgs\' ,'+ row.fId_U+',\'/Archiving/reCall\''+')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">' + '</a>'
			+'</td></tr></table>';
		}else if (s==-1 || s==-4){
			return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'
			+'<a href="#" onclick="detailInfobg(' + row.fId_U
			+ ')" class="easyui-linkbutton"><img onmouseover="arvchivingshowB(this)" onmouseout="arvchivingshowA(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+ '</a>'+ '</td><td style="width: 25px">'
			+'<a href="#" onclick="updateDisputeBg(' + row.fId_U
			+ ')" class="easyui-linkbutton"><img  onmouseover="disputeshowB(this)" onmouseout="disputeshowA(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'
			+ '</a>'+ '</td><td style="width: 25px">'
			+'<a href="#" onclick="deleteCF(' + row.fId_U
			+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'
			+'</a> </td></tr></table>';
		}else{
			return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'
			+'<a href="#" onclick="detailInfobg(' + row.fId_U+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' 
			+'</a>'+'</td></tr></table>';
		}
	}
	function arvchivingshowB(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select2.png';
	}
	function arvchivingshowA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function arvchivingshowC(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/archiving2.png';
	}
	function arvchivingshowD(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/archiving1.png';
	}
	/* $(function() {
		//定义双击事件
		$('#archiving_dg').datagrid({
			onDblClickRow : function(rowIndex, rowData) {
				detailDemo();
			}
		});
	}); */
	
	function updateDispute(id) {
				var win = creatWin('合同归档修改', 1080, 580, 'icon-search',
						"/Archiving/edit/" +id);
				win.window('open');
		}
	function updateDisputeBg(id) {
				var win = creatWin('合同归档修改', 1080, 580, 'icon-search',
						"/Archiving/editbg/" +id);
				win.window('open');
		}
	
	function archiving_query(num) {
		if(num==0){
		var fcs = $('#archiving_fContStauts').val();
		if('HTGDZT-01'==fcs){
			fcs='unfiled';
		}else if('HTGDZT-02'==fcs){
			fcs='1';
		}
			$('#archiving_dg').datagrid('load', {
			fcCode : $('#archiving_fcCode').val(),
			fcTitle : $('#archiving_fcTitle').val(),
			fgdStauts : fcs,
			fcAmount : $('#archiving_fcAmount').val()
		});
			}else if(num==1){
			var fcs = $('#archiving_fContStauts1').val();
			if('HTGDZT-01'==fcs){
			fcs='unfiled';
		}else if('HTGDZT-02'==fcs){
			fcs='1';
		}
			$('#archiving_dgs').datagrid('load', {
			fUptCode : $('#archiving_fcCode1').val(),
			fContName : $('#archiving_fcTitle1').val(),
			fgdstatus : fcs,
			//fcAmount : $('#archiving_fcAmount').val()
		});
			}
	}
	function addCF() {
			var win = creatWin('合同归档', 1080, 580, 'icon-search',
					"/Archiving/fProCodejsonPagination/");
			win.window('open');
	}
	
	function detailInfo(id) {
		var win = creatWin('合同归档明细', 790, 580, 'icon-search',"/Archiving/detail/" + id);
		win.window('open');
	}
	function detailInfobg(id) {
		var win = creatWin('合同归档明细', 1080, 580, 'icon-search',"/Archiving/detailbg/" + id);
		win.window('open');
	}
	function ArchivingHT(id) {
		//var row = $('#archiving_dg').datagrid('getSelected');
		var selections = $('#archiving_dg').datagrid('getSelections');
		var win = creatWin('合同归档申请', 790, 580, 'icon-search',
				"/Archiving/edit/" + id);
		win.window('open');
	}
	function ArchivingHTbg(id) {
		//var row = $('#archiving_dg').datagrid('getSelected');
		var selections = $('#archiving_dg').datagrid('getSelections');
		var win = creatWin('合同归档申请', 1080, 580, 'icon-search',
				"/Archiving/editbg/" + id);
		win.window('open');
	}
	function editCF() {
		var row = $('#archiving_dg').datagrid('getSelected');
		var selections = $('#archiving_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			var win = creatWin('合同归档', 1080, 580,  'icon-search',
					"/Archiving/edit/" + row.fcId);
			win.window('open');
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		}	
	}
	function deleteCF(id) {
		/* var row = $('#archiving_dg').datagrid('getSelected');
		var selections = $('#archiving_dg').datagrid('getSelections'); */
		/* if (row != null && selections.length == 1) { */
			if (confirm("确认删除吗？")) {
				$.ajax({
					type : 'POST',
					url : '${base}/Archiving/delete/' + id,
					dataType : 'json',
					success : function(data) {
						if (data.success) {
							$.messager.alert('系统提示', data.info, 'info');
							$("#archiving_dg").datagrid('reload');
						} else {
							$.messager.alert('系统提示', data.info, 'error');
						}
					}
				});
			}
			/*}  else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		} */
	}
	function CF_delete(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/Archiving/deletebg/' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$("#archiving_dgs").datagrid('reload');
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


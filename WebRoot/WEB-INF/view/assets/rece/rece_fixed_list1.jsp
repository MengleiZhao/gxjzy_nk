<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<link rel="stylesheet" type="text/css" href="${base}/resource/ui/themes/cockpit/cockpit.css">
<script type="text/javascript">
var base='${base}';
var queryYear = '${year}';
var queryDepartId = '${departId}';
</script>

<style type="text/css">
.datagrid-body{
	height: 358px;
}
</style>
<div class="easyui-layout" style="width:100%;height:100%; 
  	background: #fff;">
  	<div data-options="region:'north'" style="height:73px; ">
	<div style="height:100% ">
		<table cellpadding="0" cellspacing="0" style="height: 100%; width:100%;">
				<tr>
						<td style="text-align:center;width: 70%;  padding-right: 10px;">
							<span style="font-size: 12px; color: #182C4D;">领用单号：</span>
								<input id="rece_fixed_fAssReceCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
							<span style="font-size: 12px; color: #182C4D;">审批状态：</span>
								<select id="rece_fixed_fFlowStauts_R" name="" style="width: 150px;height:25px; "editable="false" class="easyui-combobox">
									<option value="">--请选择--</option>
									<option value="9">已审批</option>
									<option value="1">待审批</option>
									<option value="-1">已退回</option>
									<option value="0">暂存</option>
								</select>
							<span style="font-size: 12px; color: #182C4D;">领用时间：</span>
								<input id="rece_fixed_fReceTimeBegin" name="" style="width: 150px;height:25px;" class="easyui-datebox"></input>&nbsp;-&nbsp;
								<input id="rece_fixed_fReceTimeEnd" name="" style="width: 150px;height:25px;" class="easyui-datebox"></input>
						</td>
					</tr>
					<tr>
					<td style="text-align:right; width: 100%;  padding-right: 10px;padding-top: 10px;">
						<a href="javascript:void(0)"  onclick="rece_fixed_query();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')">
						</a>
						<a href="javascript:void(0)"  onclick="rece_fixed_clearTable();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')">
						</a>
						<a href="#" onclick="rece_fixed_add()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)" >
						</a>
					</td>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
					</div>
		</div>
		<!-- 列表区 -->
	<div data-options="region:'center'">
  	<div style="height: 100%; width:98%; margin-left: 1%;">
		<table id="rece_fixed_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Rece/JsonPagination?fAssType=ZCLX-02',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fId_R',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'fAssReceCode',align:'left'" width="20%">资产领用单号（流水号）</th>
						<th data-options="field:'fReceDept',align:'left',resizable:false,sortable:true" width="15%">领用部门</th>
						<th data-options="field:'fReceUser',align:'left',resizable:false,sortable:true" width="15%">领用人</th>
						<th data-options="field:'fReceTime',align:'left',formatter: ChangeDateFormat" width="15%" >领用时间</th>
						<!-- <th data-options="field:'fReceRemark',align:'left',resizable:false,sortable:true" width="15%">领用原因</th> -->
						<th data-options="field:'fOtherRemark',align:'left',resizable:false,sortable:true" width="15%">其他需求</th>
						<th data-options="field:'fFlowStauts_R',align:'left',formatter:formatPrice,resizable:false,sortable:true" width="10%">审批状态</th>
						<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ" width="6%">操作</th>
					</tr>
				</thead>
			</table>
	</div>
	</div>
		 <!-- 导航区 -->
  <div data-options="region:'south'" style="height:40px; ">
  		<div style="text-align: center;">
			<%-- <a href="javascript:void(0)" onclick="goback()">
				<img src="${base}/resource-modality/${themenurl}/button/fanhui1.png"
					onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/fanhui2.png')"
					onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/fanhui1.png')"
				/>
			</a> --%>
			&nbsp;&nbsp;
			<a href="javascript:void(0)" onclick="closeSearchDateWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
		</div>
  </div>

</div>
<script type="text/javascript">
//清除查询条件
function rece_fixed_clearTable() {
	$('#rece_fixed_fAssReceCode').textbox('setValue',null),
	$('#rece_fixed_fFlowStauts_R').combobox('setValue',null),
	$('#rece_fixed_fReceTimeBegin').datebox('setValue',null),
	$('#rece_fixed_fReceTimeEnd').datebox('setValue',null),
	rece_fixed_query();
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
		 if(!regu.test($('#"rece_fixed_fAssReceCode"').val()) && flag == true){
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
		if(fs==1||fs==9){
			return '<a href="#" onclick="rece_fixed_detail(' + row.fId_R+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>   '
		}
		if(fs==0||fs==-1){
			//return '<a href="#" onclick="rece_fixed_detail(' + row.fId_R+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>   '
			return '<a href="#" onclick="rece_fixed_detail(' + row.fId_R
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
				+'&nbsp;&nbsp;'+ '<a href="#" onclick="Rece_fixed_update(' + row.fId_R
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>'
				+'&nbsp;&nbsp;'+'<a href="#" onclick="rece_fixed_delete(' + row.fId_R
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">' + '</a>';
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
	/* $(function() {
		//定义双击事件
		$('#rece_fixed_dg').datagrid({
			onDblClickRow : function(rowIndex, rowData) {
				detailDemo();
			}
		});
	}); */
	function rece_fixed_query() {
		$('#rece_fixed_dg').datagrid('load', {
			fAssReceCode : $('#rece_fixed_fAssReceCode').val(),
			fFlowStauts_R : $('#rece_fixed_fFlowStauts_R').val(),
			fReceTimeBegin : $('#rece_fixed_fReceTimeBegin').val(),
			fReceTimeEnd : $('#rece_fixed_fReceTimeEnd').val()
		});
	}
	function rece_fixed_add() {
		var win = creatWin('新增', 970,580, 'icon-search',"/Rece/addFixed");
		win.window('open');
	}
	function rece_fixed_detail(id) {
			var win = creatWin('查看', 970,580, 'icon-search',"/Rece/detail/" + id);
			win.window('open');
	}
	/* function editCF() {
		var row = $('#rece_fixed_dg').datagrid('getSelected');
		var selections = $('#rece_fixed_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			var win = creatWin(' ', 970,580, 'icon-search',
					"/Storage/edit/" + row.fId_R);
			win.window('open');
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		}
	} */
	function Rece_fixed_update(id) {
		//var row = $('#rece_fixed_dg').datagrid('getSelected');
		var win = creatWin('修改', 970,580, 'icon-search',
				"/Rece/edit/" + id);
		win.window('open');
	}
	function rece_fixed_delete(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/Rece/delete/' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#rece_fixed_dg').form('clear');
						$("#rece_fixed_dg").datagrid('reload');
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
	
	$("#rece_fixed_fReceTimeBegin").datebox({
	    onSelect : function(beginDate){
	        $('#rece_fixed_fReceTimeEnd').datebox().datebox('calendar').calendar({
	            validator: function(date){
	                return beginDate <= date;
	            }
	        });
	    }
	});
</script>
</body>
</html>


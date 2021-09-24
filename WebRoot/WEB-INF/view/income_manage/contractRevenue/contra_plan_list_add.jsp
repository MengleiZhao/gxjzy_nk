<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table id="register_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="add_proceeds()">
						<img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="list-table">
			<table id="enforcing_plan_dg" 
			data-options="collapsible:true,url:'${base}/proceedsPlan/planJsonPagination/${id}',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fPId',hidden:true"></th>
						<th data-options="field:'fContId',hidden:true"></th>
						<th data-options="field:'fProceedsProperty',align:'center'" width="15%">收款性质</th>
						<th data-options="field:'fProceedsCondition',align:'center',resizable:false" width="15%">收款条件</th>
						<th data-options="field:'fProceedsAmount',align:'right',resizable:false" width="15%">预计收款金额(元)</th>
						<th data-options="field:'fProceedsTime',align:'center',formatter: ChangeDateFormat" width="15%" >预计收款日期</th>
						<th data-options="field:'fcqyj',align:'center',resizable:false,formatter:satuts" width="10%">超期预警</th>
						<th data-options="field:'payStauts',align:'center',resizable:false,formatter:RPsatuts" width="15%">收款状态</th>
						<th data-options="field:'name',align:'left',resizable:false,formatter:CZ" width="15%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	<div class="window-left-bottom-div" style="margin-top:10px">
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
	</div>
</div>	


<script type="text/javascript">
//分页样式调整
$(function(){
	var pager = $('#enforcing_plan_dg').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});			
});
//清除查询条件
function clearTable() {
	$(".topTable :input[type='text']").each(function(){
		$(this).val("");
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
function paytype(val, row) {
	if (val == "FKXZ-01") {
		return '<span >' + "首款" + '</span>';
	} else if (val == "FKXZ-02") {
		return '<span >' + "阶段款" + '</span>';
	}else if (val == "FKXZ-03") {
		return '<span >' + "验收款" + '</span>';
	}else if (val == "FKXZ-04") {
		return '<span >' + "质保款" + '</span>';
	}
}
  function satuts(val, row) {
	if (row.fcqyj == "0") {
		return '<span >' + "未超期" + '</span>';
	}if (row.fcqyj == "1") {
		return '<span >' + "将要超期" + '</span>';
	}
	if (row.fcqyj == "2") {
		return '<span >' + "已超期" + '</span>';
	}
}  

	/* function CheckYou() {
		var flag = true;
		var regu = "^[a-zA-Z\u4e00-\u9fa5]+$";
		 if(!regu.test($('#"e_fcCode"').val()) && flag == true){
		    	alert("请输入中文或英文！");
		    	flag = false;
		    } 	
	} */

	//设置审批状态
	var c;
 	function RPsatuts(val, row) {
		c = val;
		if(val == ""||val == null) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "未收款" + '</a>';
		} else if (val == 0) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "暂存" + '</a>';
		} else if (val == -1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">&nbsp;&nbsp;' + "未通过" + '</a>';
		} else if (val == 9&&row.fStauts_R != 1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "审核通过" + '</a>';
		} else  if (row.fStauts_R == 1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已收款" + '</a>';
		}  else  if (val == -4) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已撤回" + '</a>';
		} else{
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "收款审核中" + '</a>';
		}
	} 
	function CZ(val, row) {
		var a = ${show};
		if(a == '1'){
		if(row.payStauts==''||row.payStauts == null){
			return '<a href="#" onclick="pay(' + ${id}+ ',' + row.fPId + ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)"  src="'+base+'/resource-modality/${themenurl}/list/shoukuan1.png">' + '</a>';
		}else if(row.payStauts==0||row.payStauts==-1||row.payStauts==-4){
			return '<a href="#" onclick="enforcing_plan_detail(' + ${id}+ ',' + row.fPId + ')" class="easyui-linkbutton"><img onmouseover="enforcing_plan_showB(this)" onmouseout="enforcing_plan_showA(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
			+'&nbsp;&nbsp;'
			+'<a href="#" onclick="edit(' + ${id}+ ',' + row.fPId + ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>';
		}else if(row.payStauts==9||row.payStauts==2||row.payStauts==99){
			return '<a href="#" onclick="enforcing_plan_detail(' + ${id}+ ',' + row.fPId + ')" class="easyui-linkbutton"><img onmouseover="enforcing_plan_showB(this)" onmouseout="enforcing_plan_showA(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>';
		}else {
			return '<a href="#" onclick="enforcing_plan_detail(' + ${id}+ ',' + row.fPId + ')" class="easyui-linkbutton"><img onmouseover="enforcing_plan_showB(this)" onmouseout="enforcing_plan_showA(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
			+'&nbsp;&nbsp;'
			+'<a href="#" onclick="reCall(\'enforcing_plan_dg\',' + row.fPId + ',\'/proceedsPlan/ReCall\')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png"></a>';
		}
		}else{
			return '<a href="#" onclick="enforcing_plan_detail(' + ${id}+ ',' + row.fPId + ')" class="easyui-linkbutton"><img onmouseover="enforcing_plan_showB(this)" onmouseout="enforcing_plan_showA(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>';
		}
	}
	function enforcing_plan_showA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function enforcing_plan_showB(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select2.png';
	}
	function enforcing_plan_showD(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/pay2.png';
	}
	function enforcing_plan_showC(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/pay1.png';
	}
	/* $(function() {
		//定义双击事件
		$('#enforcing_plan_dg').datagrid({
			onDblClickRow : function(rowIndex, rowData) {
				detailDemo();
			}
		});
	}); */
	function detailDemo() {
		var row = $('#enforcing_plan_dg').datagrid('getSelected');
		var selections = $('#enforcing_plan_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			var win = creatWin('查看-合同拟定', 600, 600, 'icon-search',
					"/demo/detail/" + row.id);
			win.window('open');
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		}
	}
	function pay(Id,fPlanId) {
		$.ajax({ 
			type: 'POST', 
			url: '${base}/proceedsPlan/getUptStatus?id='+fPlanId,
			dataType: 'json', 
			success: function(data){ 
				if(data=='2'){
					$.messager.alert('系统提示','该合同正在发生变更，无法发起收款','info');
					return false;
				}else{
					var win = creatFirstWin('合同收款申请', 1115, 580, 'icon-search',"/proceedsPlan/add?id=" + fPlanId+"&fPlanId="+Id);
					win.window('open');
				}
			} 
		}); 	
		
	}
	function edit(id,fPlanId) {
		var win = creatFirstWin('合同收款申请-修改', 1115, 580, 'icon-search',"/proceedsPlan/edits?id=" + id+"&fPlanId="+fPlanId);
		win.window('open');
	} 
	
	function add_proceeds() {
		var win = creatFirstWin('合同收款申请-新增', 1115, 580, 'icon-search',"/proceedsPlan/insert?id=" + ${id});
		win.window('open');
	}
	function enforcing_plan_detail(id,fPlanId) {
		var win = creatFirstWin('合同收款明细', 1115, 580, 'icon-search',"/proceedsPlan/detailPro?id=" + id+"&fPlanId="+fPlanId);
		win.window('open');
	}
	/* //查看申请
	function edit(id,reimburseType,fPlanId) {
		var win = creatFirstWin('付款申请', 840, 450, 'icon-search', '/reimburseCheck/check?id='+id+'&reimburseType='+reimburseType+'&fPlanId='+fPlanId+'&payId=0');
		win.window('open');
	}
	function deleteCF() {
		var row = $('#enforcing_plan_dg').datagrid('getSelected');
		var selections = $('#enforcing_plan_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			if (confirm("确认删除吗？")) {
				$.ajax({
					type : 'POST',
					url : '${base}/Enforcing/delete/' + row.fPlanId,
					dataType : 'json',
					success : function(data) {
						if (data.success) {
							$.messager.alert('系统提示', data.info, 'info');
							$("#enforcing_plan_dg").datagrid('reload');
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
				url : '${base}/Enforcing/delete/' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$("#enforcing_plan_dg").datagrid('reload');
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
	} */
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


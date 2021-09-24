<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr >
					<td class="top-table-search" class="queryth">维修登记单&nbsp;
						<input id="reg_tMianRegCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;操作人&nbsp;
						<input id="reg_fMainRegUser" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;操作时间&nbsp;
						<input id="reg_fRegTimeStart" name="" style="width: 150px;height:25px;" class="easyui-datebox"></input>
						&nbsp;-&nbsp;
						<input id="reg_fRegTimeEnd" name="" style="width: 150px;height:25px;" class="easyui-datebox"></input>
						&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="maintain_fixed_query();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="maintain_fixed_clearTable();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<td align="right" style="padding-right: 10px">
						<a href="#" onclick="maintain_fixed_add()" >
							<img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
		</div>
		
		<div class="list-table">
			<table id="miantain_fixed_reg_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Maintain/registrationJson',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fRegID',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'tMianRegCode',align:'left',resizable:false,sortable:true," width="15%">维修登记单号</th>
						<th data-options="field:'mainWhether',align:'left',resizable:false,sortable:true," width="10%" >是否产生费用</th>
						<th data-options="field:'fRegAmount',align:'center',resizable:false,sortable:true" width="10%" >维修费用</th>
						<th data-options="field:'fRegTime',align:'center',formatter: ChangeDateFormat" width="10%">操作时间</th>
						<th data-options="field:'fMainRegUser',align:'center',resizable:false,sortable:true" width="10%" >操作人名称</th>
						<th data-options="field:'fMainRegDept',align:'center',resizable:false,sortable:true" width="10%" >操作部门名称</th>
						<th data-options="field:'fMainResult',align:'left',resizable:false,sortable:true" width="20%">维修结果</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" width="10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	


<script type="text/javascript">
//清除查询条件
function maintain_fixed_clearTable() {
	$('#reg_tMianRegCode').textbox('setValue',null),
	$('#reg_fMainRegUser').textbox('setValue',null),
	$('#reg_fRegTimeStart').datebox('setValue',null),
	$('#reg_fRegTimeEnd').datebox('setValue',null);
	maintain_fixed_query();
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
		 if(!regu.test($('#"reg_tMianRegCode"').val()) && flag == true){
		    	alert("请输入中文或英文！");
		    	flag = false;
		    } 	
	} 
	var fs
	function formatPrice(val, row) {
		fs=val;
		if (val == 0) {
			return '<span style="color:blue;">' + "暂存" + '</span>';
		} else if (val == 1) {
			return '<span style="color:red;">' + "待审批" + '</span>';
		}else if (val == 9) {
			return '<span style="color:green;">' + "已审批" + '</span>';
		}else if (val == 99) {
			return '<span style="color:black;">' + "已删除" + '</span>';
		} else if (val == -1) {
			return '<span style="color:red;">' + "已退回" + '</span>';
		}
	}
	function CZ(val, row) {
		return 	'<a href="#" onclick="maintain_reg_detail(' + row.fRegID+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
				+'&nbsp;&nbsp;'
				+'<a href="#" onclick="maintain_reg_update(' + row.fRegID
				+ ')" class="easyui-linkbutton"><img <img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>'
				+'&nbsp;&nbsp;'
				+'<a href="#" onclick="maintain_reg_delete(' + row.fRegID
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
	function maintain_fixed_query() {
		$('#miantain_fixed_reg_dg').datagrid('load', {
			tMianRegCode : $('#reg_tMianRegCode').val(),
			fMainRegUser : $('#reg_fMainRegUser').val(),
			fRegTimeStart : $('#reg_fRegTimeStart').val(),
			fRegTimeEnd : $('#reg_fRegTimeEnd').val()
		});
	}
	function maintain_fixed_add() {
		var node = $('#miantain_fixed_reg_dg').datagrid('getSelected');
		var win = creatWin('维修登记单',760,580, 'icon-search', '/Maintain/addReg');
		if (null != node) {
			win = creatWin('维修登记单', 760,580, 'icon-search',
					'/Maintain/addReg');
		}
		win.window('open');
	}
	function maintain_reg_detail(id) {
			var win = creatWin('查看',760,580, 'icon-search',"/Maintain/detailReg/" + id);
			win.window('open');
	}
	function maintain_fixed_Reg(id) {
			var win = creatWin('维修登记',970,580, 'icon-search',"/Maintain/registration/" + id);
			win.window('open');
	}
	/* function editCF() {
		var row = $('#miantain_fixed_reg_dg').datagrid('getSelected');
		var selections = $('#miantain_fixed_reg_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			var win = creatWin(' ', 970,580, 'icon-search',
					"/Maintain/edit/" + row.fcId);
			win.window('open');
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		}
	} */
	function maintain_reg_update(id) {
		//var row = $('#miantain_fixed_reg_dg').datagrid('getSelected');
		var selections = $('#miantain_fixed_reg_dg').datagrid('getSelections');
		var win = creatWin('修改', 760,580, 'icon-search',
				"/Maintain/editReg/" + id);
		win.window('open');
	}
	function maintain_reg_delete(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/Maintain/deleteReg/' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#CFAddEditForm').form('clear');
						$("#miantain_fixed_reg_dg").datagrid('reload');
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
	
	$("#reg_fRegTimeStart").datebox({
	    onSelect : function(beginDate){
	        $('#reg_fRegTimeEnd').datebox().datebox('calendar').calendar({
	            validator: function(date){
	                return beginDate <= date;
	            }
	        });
	    }
	});
</script>
</body>
</html>


<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab">

	<table id="rpt" class="easyui-datagrid" style="width:660px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#rph',
	<c:if test="${!empty receptionBean.jId}">
	url: '${base}/apply/recep?id=${receptionBean.jId}',
	</c:if>
	<c:if test="${empty receptionBean.jId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRowR,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'travelRId',hidden:true"></th>
				<th data-options="field:'receptionPeopName',width:200,align:'center'">姓名</th>
				<th data-options="field:'position',width:200,align:'center'">职务/级别</th>
				<th data-options="field:'jDremake',width:233,align:'center'">备注</th>
			</tr>
		</thead>
	</table>
	<c:if test="${empty detail}">
	<div id="rph" style="height:30px;padding-top : 8px">
	<%-- 	<a href="javascript:void(0)" onclick="removeitR()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendR()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a> --%>
	</div>
	</c:if>
	<input type="hidden" id="recePeopJson" name="recePeop" />
</div>
<script type="text/javascript">

//接待人员表格添加删除，保存方法
	var editIndex = undefined;
	function endEditingR() {
		if (editIndex == undefined) {
			return true
		}
		if ($('#rpt').datagrid('validateRow', editIndex)) {
			var rph = $('#rpt').datagrid('getEditor', {
				index : editIndex,
				field : 'costDetail'
			});
			$('#rpt').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRowR(index) {
		if (editIndex != index) {
			if (endEditingR()) {
				$('#rpt').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex = index;
			} else {
				$('#rpt').datagrid('selectRow', editIndex);
			}
		}
	}
	function appendR() {
		if (endEditingR()) {
			$('#rpt').datagrid('appendRow', {});
			editIndex = $('#rpt').datagrid('getRows').length - 1;
			$('#rpt').datagrid('selectRow', editIndex).datagrid('beginEdit',editIndex);
		}
	}
	function removeitR() {
		if (editIndex == undefined) {
			return
		}
		$('#rpt').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
				editIndex);
		editIndex = undefined;
	}
	function acceptR() {
		if (endEditingR()) {
			$('#rpt').datagrid('acceptChanges');
		}
	}
	
	
/* 	//重新计算开支标准
	function countkzbz() {
		accept();
		//获得接待人数（有几行就是接待多少人）
		var rownum = $('#rpt').datagrid('getRows').length;
		//修改明细表中的开支标准
		var rows = $('#appli-detail-dg').datagrid('getRows');
		for(var i=0;i<rows.length;i++) {
			var tr = $('#appli-detail-dg').datagrid('getEditors', i);
			//获得每一行的开支标准
			var kzbz=rows[i].standard;
			//设置开支标准
			onClickRow(i);
			tr[1].target.textbox('setValue', parseFloat(kzbz*rownum));
			accept();
		}
	} */
</script>
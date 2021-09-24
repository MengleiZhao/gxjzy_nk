<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab">
	<table id="abroad-people-dg" class="easyui-datagrid" 
	style="width:655px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#dmp',
	<c:if test="${!empty abroad.faId}">
	url: '${base}/apply/abroadPeople?id=${abroad.faId}',
	</c:if>
	<c:if test="${empty abroad.faId}">
	url: '',
	</c:if>
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'frId',hidden:true"></th>
				<!-- <th data-options="field:'',hidden:true">序号</th> -->
				<th data-options="field:'travelPeopName',width:150,align:'center',editor:{type:'textbox',options:{}}">姓名</th>
				<th data-options="field:'idCard',width:150,align:'center',editor:{type:'textbox',options:{}}">护照号</th>
				<th data-options="field:'position',width:150,align:'center',editor:'textbox'">职务</th>
				<th data-options="field:'phoneNum',width:150,align:'center',editor:'textbox'">联系方式</th>
			</tr>
		</thead>
	</table>
	<input type="hidden" id="abroadPeople" name="abroadPeople" />
</div>
	
	
<script type="text/javascript">

//接待人员表格添加删除，保存方法
	var editIndex = undefined;
	function endEditingR() {
		if (editIndex == undefined) {
			return true
		}
		if ($('#abroad-people-dg').datagrid('validateRow', editIndex)) {
			var dmp = $('#abroad-people-dg').datagrid('getEditor', {
				index : editIndex,
				field : 'costDetail'
			});
			$('#abroad-people-dg').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRowR(index) {
		if (editIndex != index) {
			if (endEditingR()) {
				$('#abroad-people-dg').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex = index;
			} else {
				$('#abroad-people-dg').datagrid('selectRow', editIndex);
			}
		}
	}
	function appendR() {
		if (endEditingR()) {
			$('#abroad-people-dg').datagrid('appendRow', {});
			editIndex = $('#abroad-people-dg').datagrid('getRows').length - 1;
			$('#abroad-people-dg').datagrid('selectRow', editIndex).datagrid('beginEdit',editIndex);
		}
	}
	function removeitR() {
		if (editIndex == undefined) {
			return
		}
		$('#abroad-people-dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
				editIndex);
		editIndex = undefined;
	}
	function acceptR() {
		if (endEditingR()) {
			$('#abroad-people-dg').datagrid('acceptChanges');
		}
	}
	
	
/* 	//重新计算开支标准
	function countkzbz() {
		accept();
		//获得接待人数（有几行就是接待多少人）
		var rownum = $('#abroad-people-dg').datagrid('getRows').length;
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
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="index_reim_tab_id" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	url: '${base}/reimburse/budgetMessageList?rId=${bean.rId}',
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'pID',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'rId',hidden:true"></th>
				<th data-options="field:'fCostName',width:210,align:'center'">费用名称</th>
				<th data-options="field:'fCostTheir',width:210,align:'center'">费用所属</th>
				<th data-options="field:'fCostClassifyShow',width:246,align:'center',editor:{
							editable:true,
							type:'combotree',
							options:{
								required:true,
								valueField:'fProId',
								textField:'fProName',
								method:'post',
                                onShowPanel:onShowPanelClassify,
								onSelect:onSelectClassify,
							}}">预算分类</th>
				<th data-options="field:'fCostAmount',hidden:true,editor:{type:'numberbox',options:{editable:false}}"></th>
				<th data-options="field:'fIndexId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fProDetailId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fIndexType',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fIndexName',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fIndexPFAmount',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fIndexKYAmount',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fBudgetYear',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fCostClassify',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
			</tr>
		</thead>
	</table>
</div>
<script type="text/javascript">
//接待人员表格添加删除，保存方法
var editIndexReimIndex = undefined;
function endEditingIndexReim() {
	if (editIndexReimIndex == undefined) {
		return true;
	}
	if ($('#index_reim_tab_id').datagrid('validateRow', editIndexReimIndex)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#index_reim_tab_id').datagrid('getEditors', editIndexReimIndex);
		var text0=tr[0].target.combotree('getText');
		if(text0!='--请选择--'){
			tr[0].target.combotree('setValue',text0);
		}
		$('#index_reim_tab_id').datagrid('endEdit', editIndexReimIndex);
		userdata();
		editIndexReimIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowReimIndex(index) {
	if (editIndexReimIndex != index) {
		if (endEditingIndexReim()) {
			$('#index_reim_tab_id').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndexReimIndex = index;
		} else {
			$('#index_reim_tab_id').datagrid('selectRow', editIndexReimIndex);
		}
	}
}
function acceptIndexReim() {
	if (endEditingIndexReim()) {
		$('#index_reim_tab_id').datagrid('acceptChanges');
	}
}

function onShowPanelClassify(){
	var row = $('#index_reim_tab_id').datagrid('getSelected');
	var rindex = $('#index_reim_tab_id').datagrid('getRowIndex', row);
	var fCostClassifyShow = $('#index_reim_tab_id').datagrid('getEditor',{
		index:rindex,
		field : 'fCostClassifyShow'  
	});
	$(fCostClassifyShow.target).combotree('setValue', '');
	var number = '';
	if(row.fCostName=="差旅费"){
		number = '30211';
	}
	if(row.fCostName=="会务费"){
		number = '30215';
	}
	if(row.fCostName=="培训费"){
		number = '30216';
	}
	var url = base+'/apply/getProName?number='+number;
   	$(fCostClassifyShow.target).combotree('reload', url);
}
function onSelectClassify(datas){
	var row = $('#index_reim_tab_id').datagrid('getSelected');
	var rindex = $('#index_reim_tab_id').datagrid('getRowIndex', row);
	var number = '';
	if(row.fCostName=="差旅费"){
		number = '30211';
	}
	if(row.fCostName=="会务费"){
		number = '30215';
	}
	if(row.fCostName=="培训费"){
		number = '30216';
	}
	$.ajax({
		type:'post',
		async:false,
		dataType:'json',
		url:base+'/apply/getSubjectDetail?proId='+datas.id+'&subCode='+number,
		success:function(data){
			var fProDetailId = $('#index_reim_tab_id').datagrid('getEditor',{
				index:rindex,
				field:'fProDetailId'  
			});
			var fIndexId = $('#index_reim_tab_id').datagrid('getEditor',{
				index:rindex,
				field:'fIndexId'  
			});
			var fIndexName = $('#index_reim_tab_id').datagrid('getEditor',{
				index:rindex,
				field:'fIndexName'  
			});
			var fIndexPFAmount = $('#index_reim_tab_id').datagrid('getEditor',{
				index:rindex,
				field:'fIndexPFAmount'  
			});
			var fIndexKYAmount = $('#index_reim_tab_id').datagrid('getEditor',{
				index:rindex,
				field:'fIndexKYAmount'  
			});
			var fIndexType = $('#index_reim_tab_id').datagrid('getEditor',{
				index:rindex,
				field:'fIndexType'
			});
			var fBudgetYear = $('#index_reim_tab_id').datagrid('getEditor',{
				index:rindex,
				field:'fBudgetYear'
			});
			var fCostClassify = $('#index_reim_tab_id').datagrid('getEditor',{
				index:rindex,
				field:'fCostClassify'
			});
			var fCostClassifyShow = $('#index_reim_tab_id').datagrid('getEditor',{
				index:rindex,
				field:'fCostClassifyShow'
			});
			if(data.length>0){
				if(data[0].syAmount<row.fCostAmount){
					alert('预算金额不足！');
					$(fCostClassify.target).textbox('setValue', '');
					$(fCostClassifyShow.target).combotree('setValue', '');
					return false;
				}
				$(fIndexKYAmount.target).textbox('setValue', data[0].syAmount);
				$(fProDetailId.target).textbox('setValue', data[0].pid);
				$(fIndexId.target).textbox('setValue', data[0].bId);
				$(fIndexName.target).textbox('setValue', data[0].activity);
				$(fIndexPFAmount.target).textbox('setValue', data[0].xdAmount);
				$(fIndexType.target).textbox('setValue', data[0].fProOrBasic);
				$(fBudgetYear.target).textbox('setValue', data[0].years);
				$(fCostClassify.target).textbox('setValue', datas.id);
			}else{
				$(fProDetailId.target).textbox('setValue', '');
				$(fIndexId.target).textbox('setValue', '');
				$(fIndexName.target).textbox('setValue', '');
				$(fIndexPFAmount.target).textbox('setValue', '');
				$(fIndexKYAmount.target).textbox('setValue', '');
				$(fIndexType.target).textbox('setValue', '');
				$(fCostClassify.target).textbox('setValue', '');
				$(fCostClassifyShow.target).combotree('setValue', '');
				$(fBudgetYear.target).textbox('setValue', '');
			}
		}
	});
}

function onLoadSuccessIndex() {
	//计算需要合并的单元格
	var merges = [];
	var rows = $("#index_reim_tab_id").datagrid('getRows');
	var a = 0;
	var length = 0;
	for (var i = 0; i < rows.length - 1; i++) {
		if (rows[i].fCostName == rows[i + 1].fCostName) {
			length++;
		} else if (rows[i].fCostName !== rows[i + 1].fCostName) {
			length = 0;
			a = i + 1;
		}
		var merge = {
			index : a,
			rowspan : length + 1
		};
		merges.push(merge);
	}

	//合并单元格
	for (var i = 0; i < merges.length; i++){
		$("#index_reim_tab_id").datagrid('mergeCells', {
			index : merges[i].index,
			field : 'fCostName',
			rowspan : merges[i].rowspan
		});
	}

}

function indexJsonReim(){
	acceptIndexReim();
	var rows2 = $('#index_reim_tab_id').datagrid('getRows');
	var indexPeop = "";
	if(rows2==''){
		return false;
	}else{
		for (var i = 0; i < rows2.length; i++) {
			indexPeop = indexPeop + JSON.stringify(rows2[i]) + ",";
		}
		$('#indexPeopJson').val(indexPeop);
		return true;
	}
}
</script>
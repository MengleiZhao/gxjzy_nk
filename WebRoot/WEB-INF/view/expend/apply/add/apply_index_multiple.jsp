<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="index_tab_id" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#index_toolbar_Id',
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/budgetMessageList?gId=${bean.gId}',
	</c:if>
	<c:if test="${empty bean.gId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRowIndex,
	</c:if>
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
				<th data-options="field:'fCostClassifyShow',width:253,align:'center',editor:{
							editable:true,
							type:'combotree',
							options:{
								valueField:'fProId',
								textField:'fProName',
								method:'post',
                                onShowPanel:onShowPanelClassify,
								onSelect:onSelectClassify,
								onHidePanel:onHidePanel
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
	<input type="hidden" id="indexPeopJson" name="indexJsons" />
</div>
<script type="text/javascript">
//接待人员表格添加删除，保存方法
var editIndexIndex = undefined;
function endEditingIndex() {
	if (editIndexIndex == undefined) {
		return true;
	}
	if ($('#index_tab_id').datagrid('validateRow', editIndexIndex)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#index_tab_id').datagrid('getEditors', editIndexIndex);
		var text0=tr[0].target.combotree('getText');
		if(text0!='--请选择--'){
			tr[0].target.combotree('setValue',text0);
		}
		$('#index_tab_id').datagrid('endEdit', editIndexIndex);
		userdata();
		editIndexIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowIndex(index) {
	if (editIndexIndex != index) {
		if (endEditingIndex()) {
			$('#index_tab_id').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndexIndex = index;
		} else {
			$('#index_tab_id').datagrid('selectRow', editIndexIndex);
		}
	}
}
function appendIndex() {
	if (endEditingIndex()) {
		$('#index_tab_id').datagrid('appendRow', {
		});
		editIndexIndex = $('#index_tab_id').datagrid('getRows').length - 1;
		$('#index_tab_id').datagrid('selectRow', editIndexIndex).datagrid('beginEdit',editIndexIndex);
	}
}
function removeitIndex() {
	if (editIndexIndex == undefined) {
		return
	}
	$('#index_tab_id').datagrid('cancelEdit', editIndexIndex).datagrid('deleteRow',
			editIndexIndex);
	editIndexIndex = undefined;
}
function acceptIndex() {
	if (endEditingIndex()) {
		$('#index_tab_id').datagrid('acceptChanges');
	}
}

function onShowPanelClassify(){
	var row = $('#index_tab_id').datagrid('getSelected');
	var rindex = $('#index_tab_id').datagrid('getRowIndex', row);
	var fCostClassifyShow = $('#index_tab_id').datagrid('getEditor',{
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
	var row = $('#index_tab_id').datagrid('getSelected');
	var rindex = $('#index_tab_id').datagrid('getRowIndex', row);
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
			var fProDetailId = $('#index_tab_id').datagrid('getEditor',{
				index:rindex,
				field:'fProDetailId'  
			});
			var fIndexId = $('#index_tab_id').datagrid('getEditor',{
				index:rindex,
				field:'fIndexId'  
			});
			var fIndexName = $('#index_tab_id').datagrid('getEditor',{
				index:rindex,
				field:'fIndexName'  
			});
			var fIndexPFAmount = $('#index_tab_id').datagrid('getEditor',{
				index:rindex,
				field:'fIndexPFAmount'  
			});
			var fIndexKYAmount = $('#index_tab_id').datagrid('getEditor',{
				index:rindex,
				field:'fIndexKYAmount'  
			});
			var fIndexType = $('#index_tab_id').datagrid('getEditor',{
				index:rindex,
				field:'fIndexType'
			});
			var fBudgetYear = $('#index_tab_id').datagrid('getEditor',{
				index:rindex,
				field:'fBudgetYear'
			});
			var fCostClassify = $('#index_tab_id').datagrid('getEditor',{
				index:rindex,
				field:'fCostClassify'
			});
			var fCostClassifyShow = $('#index_tab_id').datagrid('getEditor',{
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

function onHidePanel(){
	var row = $('#index_tab_id').datagrid('getSelected');
	var rindex = $('#index_tab_id').datagrid('getRowIndex', row);
	var rows = $("#index_tab_id").datagrid('getRows');
	if(rows==''||rindex==undefined){
		
		return;
	}
	var fpPype = $('#travelType').combobox('getValue');
	var flag =0;
	var fProDetailId = $('#index_tab_id').datagrid('getEditor',{
		index:rindex,
		field:'fProDetailId'  
	});
	var fIndexId = $('#index_tab_id').datagrid('getEditor',{
		index:rindex,
		field:'fIndexId'  
	});
	var fIndexName = $('#index_tab_id').datagrid('getEditor',{
		index:rindex,
		field:'fIndexName'  
	});
	var fIndexPFAmount = $('#index_tab_id').datagrid('getEditor',{
		index:rindex,
		field:'fIndexPFAmount'  
	});
	var fIndexKYAmount = $('#index_tab_id').datagrid('getEditor',{
		index:rindex,
		field:'fIndexKYAmount'  
	});
	var fIndexType = $('#index_tab_id').datagrid('getEditor',{
		index:rindex,
		field:'fIndexType'
	});
	var fBudgetYear = $('#index_tab_id').datagrid('getEditor',{
		index:rindex,
		field:'fBudgetYear'
	});
	var fCostClassify = $('#index_tab_id').datagrid('getEditor',{
		index:rindex,
		field:'fCostClassify'
	});
	var fCostClassifyShow = $('#index_tab_id').datagrid('getEditor',{
		index:rindex,
		field:'fCostClassifyShow'
	});
	if(rows!=''||rows!=null){
		var indexId =$(fIndexId.target).textbox('getValue');
		var indexType =$(fIndexType.target).textbox('getValue');
		if(indexId!=''&&indexId!=null){
			
			var num =0;
			if(indexType==1){
				num=num+1;
				flag=1;
			}
			for (var i = 0; i < rows.length - 1; i++) {
				if(rindex!=i){
					
					if(rows[i].fIndexType==1){
						flag=1;
						if(rows[i].fIndexId!=''&&rows[i].fIndexId!=null&&rows[i].fIndexId!=indexId){
							num=num+1;
						}
					}
				}
				
			}
			if(num>1){
				alert("项目预算指标数量超出，请重新选择！");
				$(fProDetailId.target).textbox('setValue', '');
				$(fIndexId.target).textbox('setValue', '');
				$(fIndexName.target).textbox('setValue', '');
				$(fIndexPFAmount.target).textbox('setValue', '');
				$(fIndexKYAmount.target).textbox('setValue', '');
				$(fIndexType.target).textbox('setValue', '');
				$(fCostClassify.target).textbox('setValue', '');
				$(fCostClassifyShow.target).combotree('setValue', '');
				$(fBudgetYear.target).textbox('setValue', '');
				return;
			}
			if(flag==1&&indexType==1){
				$('#check_system_div').load('${base}/apply/refreshApplyProcess?applyType='+fpPype+'&indexId='+indexId+'');
			}else if(flag==0&&indexType==0){
				
				$('#check_system_div').load('${base}/apply/refreshApplyProcess?applyType='+fpPype+'&indexId='+indexId+'');
			}
		}
		
	}
}

function onLoadSuccessIndex() {
	//计算需要合并的单元格
	var merges = [];
	var rows = $("#index_tab_id").datagrid('getRows');
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
		$("#index_tab_id").datagrid('mergeCells', {
			index : merges[i].index,
			field : 'fCostName',
			rowspan : merges[i].rowspan
		});
	}

}
function getTeacherTravelAmonut(){
	var rows = $('#rec-other-dg').datagrid('getRows');
    var num1 = 0;
    for(var i=0;i<rows.length;i++){
		num1+=addNumTeacherCost(rows,i);
		
	}
    return num1;
}

function getStudentTravelAmonut(){
	var rows = $('#rec-other-dg').datagrid('getRows');
    var num1 = 0;
    for(var i=0;i<rows.length;i++){
    	num1+=addNumStudentCost(rows,i);
	}
    return num1;
}

function indexJson(){
	acceptIndex();
	var rows2 = $('#index_tab_id').datagrid('getRows');
	var indexPeop = "";
	if(rows2==''){
		return false;
	}else{
		for (var i = 0; i < rows2.length; i++) {
			var travelType = $("#travelType").combobox('getValue');
			if(travelType=='GWCC'){
				
				var travelAmount = parseFloat($("#travelAmount").val());
				if(!isNaN(travelAmount)&&travelAmount!=0){
					var teacherTravelCost =getTeacherTravelAmonut();
					 if(teacherTravelCost!=0&&(rows2[0].fCostClassifyShow==''||rows2[0].fCostClassifyShow==null)){
						 alert("请选择差旅费（教师费用）的预算分类");
						 return false;
					}
					 var studentTravelCost =getStudentTravelAmonut();
					 if(studentTravelCost!=0&&(rows2[1].fCostClassifyShow==''||rows2[1].fCostClassifyShow==null)){
						 alert("请选择差旅费（学生费用）的预算分类");
						 return false;
					}
				}
				var rows = $('#rec-others-dg').datagrid('getRows');
				if(rows!=''){
					if((rows[0].fStudentCost!=''&&rows[0].fStudentCost!=null&&rows[0].fStudentCost!=0)&&(rows2[3].fCostClassifyShow==''||rows2[3].fCostClassifyShow==null)){
						 alert("请选择会务费（学生费用）的预算分类");
						 return false;
					}
					if((rows[0].fTeacherCost!=''&&rows[0].fTeacherCost!=null&&rows[0].fTeacherCost!=0)&&(rows2[2].fCostClassifyShow==''||rows2[2].fCostClassifyShow==null)){
						 alert("请选择会务费（教师费用）的预算分类");
						 return false;
					}
					if((rows[1].fStudentCost!=''&&rows[1].fStudentCost!=null&&rows[1].fStudentCost!=0)&&(rows2[5].fCostClassifyShow==''||rows2[5].fCostClassifyShow==null)){
						 alert("请选择培训费（学生费用）的预算分类");
						 return false;
					}
					if((rows[1].fTeacherCost!=''&&rows[1].fTeacherCost!=null&&rows[1].fTeacherCost!=0)&&(rows2[4].fCostClassifyShow==''||rows2[4].fCostClassifyShow==null)){
						 alert("请选择培训费（教师费用）的预算分类");
						 return false;
					}
				}
			}
			indexPeop = indexPeop + JSON.stringify(rows2[i]) + ",";
		}
		$('#indexPeopJson').val(indexPeop);
		return true;
	}
}
</script>
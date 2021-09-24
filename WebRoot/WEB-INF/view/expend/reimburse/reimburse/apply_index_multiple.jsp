<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="index_reim_tab_id" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#index_toolbar_Id',
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/budgetMessageList?gId=${applyBean.gId}',
	</c:if>
	<c:if test="${!empty bean.rId&&operation=='edit'}">
	url: '${base}/reimburse/budgetMessageList?rId=${bean.rId}',
	</c:if>
	onClickRow: onClickRowReimIndex,
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	onLoadSuccess:onLoadSuccessProInfo
	">
		<thead>
			<tr>
				<th data-options="field:'pID',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'rId',hidden:true"></th>
				<th data-options="field:'fCostName',width:220,align:'center'">费用名称</th>
				<th data-options="field:'fCostClassifyShow',width:216,align:'center',editor:{
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
				<th data-options="field:'fCostAmount',align:'center',width:210,editor:{type:'numberbox',options:{editable:false}}">报销金额</th>
				<th data-options="field:'fIndexId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fProDetailId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fIndexType',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fIndexName',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fIndexPFAmount',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fIndexKYAmount',hidden:true,align:'center',width:160,editor:{type:'textbox',options:{editable:false}}">可用额度</th>
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
		editIndexReimIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowReimIndex(index) {
	var row = $('#index_reim_tab_id').datagrid('getSelected');
	if(row.fCostName=="差旅费"){
		if (editIndexReimIndex != index) {
			if (endEditingIndexReim()) {
				$('#index_reim_tab_id').datagrid('selectRow', index).datagrid('beginEdit',index);
				editIndexReimIndex = index;
			} else {
				$('#index_reim_tab_id').datagrid('selectRow', editIndexReimIndex);
			}
		}
	}else{
		$('#index_reim_tab_id').datagrid('selectRow', editIndexReimIndex);
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

function onLoadSuccessProInfo(data){
	if('${operation}'=='add'){
		acceptIndexReim();
		var indexRows = $("#index_reim_tab_id").datagrid('getRows');
		for(var i = indexRows.length-1 ; i >= 0 ; i--){
			$('#index_reim_tab_id').datagrid('deleteRow',i);
		}
		$('#index_reim_tab_id').datagrid('appendRow', {
			fCostName:'差旅费',
			fCostAmount:0,
			fCostClassify:'',
			fIndexId:'',
			fIndexType:''
		});
		$('#index_reim_tab_id').datagrid('appendRow', {
			fCostName:'培训费',
			fCostAmount:0,
			fCostClassify:'',
			fIndexType:''
		});
		
		var proDetailId = '${applyBean.proDetailId}';
		var amount = '${applyBean.amount}';
		$.ajax({
			type:'post',
			async:false,
			dataType:'json',
			url:base+'/apply/getProDetail?proDetailId='+proDetailId+'&subCode=30216',
			success:function(datas){
				var indexRowss = $("#index_reim_tab_id").datagrid('getRows');
				for (var h = 0; h < indexRowss.length; h++) {
					var number="";
					
					if(indexRowss[h].fCostName=="培训费"){
						$('#index_reim_tab_id').datagrid('updateRow',{
							index: h,
							row: {
								fIndexKYAmount: datas[0].syAmount,
								fCostAmount: amount,
								fProDetailId: datas[0].pid,
								fIndexId: datas[0].bId,
								fIndexName: datas[0].activity,
								fIndexPFAmount: datas[0].xdAmount,
								fIndexType: datas[0].fProOrBasic,
								fBudgetYear: datas[0].years,
								fCostClassify: datas[0].pid,
								fCostClassifyShow: datas[0].activity
							}
						});
					}
				}
				
				for (var m = 0; m < indexRowss.length; m++) {
					if(indexRowss[m].fCostName=="培训费"){
						var fCostAmount = isNaN(parseFloat(indexRowss[m].fCostAmount))?0:parseFloat(indexRowss[m].fCostAmount);
						var syAmount = isNaN(parseFloat(indexRowss[m].fIndexKYAmount))?0:parseFloat(indexRowss[m].fIndexKYAmount);
						if(syAmount<fCostAmount){
							alert('当前预算培训费可用金额不足！');
							return false;
						}
					}
				}

			}
		});
	}
	
	if('${operation}'=='edit'){
		if(data.rows.length>0){
			for (var i = 0; i < data.rows.length; i++) {
				var number="";
				if(data.rows[i].fCostName=="差旅费"){
					number = '30211';
				}
				if(data.rows[i].fCostName=="培训费"){
					number = '30216';
				}
				$.ajax({
					type:'post',
					async:false,
					dataType:'json',
					url:base+'/apply/getSubjectDetail?proId='+data.rows[i].fCostClassify+'&subCode='+number,
					success:function(datas){
						
						if(datas.length==0){
							return false;
						}
						$('#index_reim_tab_id').datagrid('updateRow',{
							index: i,
							row: {
								fIndexKYAmount: datas[0].syAmount
							}
						});
						var fCostAmount = isNaN(parseFloat(data.rows[i].fCostAmount))?0:parseFloat(data.rows[i].fCostAmount);
						var syAmount = isNaN(parseFloat(datas[0].syAmount))?0:parseFloat(datas[0].syAmount);
						if(syAmount<fCostAmount){
							alert('当前预算'+data.rows[i].fCostName+'可用金额不足！');
							return false;
						}
					}
				});
			}
		}
		
	}
}


function indexAmountName(){
	acceptIndexReim();
	var trainMoney = $("#trainMoney").numberbox('getValue');
	var outsideAmount = $("#outsideAmount").val();
	var cityAmount = $("#cityAmount").val();
	var hotelAmount = $("#hotelAmount").val();
	var foodAmount = $("#foodAmount").val();
	var meetTrainAmount = $("#meetTrainAmount").val();
	if(trainMoney=='NaN'||trainMoney==''||trainMoney==undefined||trainMoney==null){
		trainMoney=0;
	}
	if(outsideAmount=='NaN'||outsideAmount==''||outsideAmount==undefined||outsideAmount==null){
		outsideAmount=0;
	}
	if(cityAmount=='NaN'||cityAmount==''||cityAmount==undefined||cityAmount==null){
		cityAmount=0;
	}
	if(hotelAmount=='NaN'||hotelAmount==''||hotelAmount==undefined||hotelAmount==null){
		hotelAmount=0;
	}
	if(foodAmount=='NaN'||foodAmount==''||foodAmount==undefined||foodAmount==null){
		foodAmount=0;
	}
	if(meetTrainAmount=='NaN'||meetTrainAmount==''||meetTrainAmount==undefined||meetTrainAmount==null){
		meetTrainAmount=0;
	}

    var rowsIndex = $('#index_reim_tab_id').datagrid('getRows');
    for (var i = 0; i < rowsIndex.length; i++) {
		if(rowsIndex[i].fCostName=='培训费'){
			$('#index_reim_tab_id').datagrid('updateRow',{
				index: i,
				row: {
					fCostAmount: parseFloat(hotelAmount)+parseFloat(trainMoney)
				}
			});
		}
		if(rowsIndex[i].fCostName=='差旅费'){
			$('#index_reim_tab_id').datagrid('updateRow',{
				index: i,
				row: {
					fCostAmount: parseFloat(foodAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)
				}
			});
		}
    }
    
    var flag = true;
    for (var i = 0; i < rowsIndex.length; i++) {
		if(rowsIndex[i].fIndexKYAmount<rowsIndex[i].fCostAmount){
			flag = false;
		}
    }
    if(!flag){
    	alert('当前指标可用额度不足，请调整指标额度！');
		return false;
    }
}
</script>
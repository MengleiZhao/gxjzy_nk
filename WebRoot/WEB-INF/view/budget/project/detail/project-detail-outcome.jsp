<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="pro_outcomes_table_id" class="easyui-datagrid" 
	style="width:990px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#rpl',
	url: '${base}/project/findByfProIdGetDetail?id=${bean.FProId}',
	method: 'post',
	striped : true,
	<c:if test="${!empty checkPeople}">
	onClickRow: onClickRowProOutcomes,
	</c:if>
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	onLoadSuccess:onLoadSuccesscapitalSourceCodeAndAmountArr,
	">
		<thead>
			<tr>
				<th data-options="field:'activity',width:110,align:'center'">具体业务</th>
				<th data-options="field:'funSubName',width:160,align:'center'">功能分类科目</th>
				<th data-options="field:'funSubCode',hidden:true">功能分类科目编号</th>
				<th data-options="field:'subName',width:160,align:'center'">经济分类科目</th>
				<th data-options="field:'subCode',hidden:true,width:150,align:'center'">经济分类科目编号</th>
				<th data-options="field:'capitalSourceName',width:160,align:'center',editor:{type:'combotree',options:{
								valueField:'code',
								textField:'text',
								cascadeCheck:true,
								checkbox:true,
								prompt:'由预算主办会计选择',
								method:'post',
								editable:false,
								url:base+'/project/tree',
								onClick:setCapitalSourceCode
							}}">资金来源</th>
				<th data-options="field:'capitalSourceCode',hidden:true,width:150,align:'center',editor:{type:'textbox',options:{onChange:onChangeSourceCode}}">资金来源编号</th>
				<th data-options="field:'outAmount',width:130,align:'center'">支出金额(元)</th>
				<th data-options="field:'actDesc',width:125,align:'center'">备注</th>
			</tr>
		</thead>
	</table>
	<div id="rpl" style="height:30px;padding-top : 8px">
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a style="text-align: right;">
			合计金额：<span style="color: red" id="outcomeTotalshow"><fmt:formatNumber groupingUsed="true" value="${bean.FProBudgetAmount}" minFractionDigits="2" maxFractionDigits="2"/></span>元
		</a>		
	</div>
</div>
<script type="text/javascript">
function getOutcomeJsons(){
	accept1();
	var rows = $('#pro_outcomes_table_id').datagrid('getRows');
	var outcomeJson = "";
	if(rows==''){
		return false;
	}
	var flag1 = true;
	for (var y = 0; y < rows.length; y++) {
		if(rows[y].capitalSourceName==''||rows[y].capitalSourceCode==''){
			flag1 = false;
		}
	}
	if(!flag1){
		return false;
	}
	for (var i = 0; i < rows.length; i++) {
		outcomeJson += JSON.stringify(rows[i]);
		if (i < rows.length - 1) {
			outcomeJson += ",";
		}
	}
	$('#outcomeJson').val(outcomeJson);
	return true;
}

//表格添加删除，保存方法
	var editIndex1 = undefined;
	function endEditing1() {
		if (editIndex1 == undefined) {
			return true
		}
		if ($('#pro_outcomes_table_id').datagrid('validateRow', editIndex1)) {
			var tr = $('#pro_outcomes_table_id').datagrid('getEditors', editIndex1);
			var text0=tr[0].target.combotree('getText');
			if(text0!='--请选择--'){
				tr[0].target.combotree('setValue',text0);
			}
			$('#pro_outcomes_table_id').datagrid('endEdit', editIndex1);
			editIndex1 = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRowProOutcomes(index) {
		if (editIndex1 != index) {
			if (endEditing1()) {
				$('#pro_outcomes_table_id').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex1 = index;
			} else {
				$('#pro_outcomes_table_id').datagrid('selectRow', editIndex1);
			}
		}
	}
	function accept1() {
		if (endEditing1()) {
			$('#pro_outcomes_table_id').datagrid('acceptChanges');
		}
	}
	
	function setCapitalSourceCode(rec){
		var row = $('#pro_outcomes_table_id').datagrid('getSelected');
		var rindex = $('#pro_outcomes_table_id').datagrid('getRowIndex', row); 
		var code = $('#pro_outcomes_table_id').datagrid('getEditor',{
			index:rindex,
			field : 'capitalSourceCode'  
		});
		$(code.target).textbox('setValue', rec.id);
	}



function onChangeSourceCode(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	var row = $('#pro_outcomes_table_id').datagrid('getSelected');
	var rindex = $('#pro_outcomes_table_id').datagrid('getRowIndex', row); 
	$('#zijinlaiyuan').css('display','');
	$.parser.parse('#zijinlaiyuan');
	var data = capitalSourceCodeAndAmountArr(rindex,newVal);
	$('#fundssourceDetail').datagrid('loadData',data);
}


//计算资金来源和合计金额
function capitalSourceCodeAndAmountArr(index,code){
	
	var rows = $('#pro_outcomes_table_id').datagrid('getRows');
	var arr = new Array();
	var capitalSourceCodes = $('#pro_outcomes_table_id').datagrid('getEditor',{
		index:index,
		field : 'capitalSourceCode'  
	});
	var capitalSourceNames = $('#pro_outcomes_table_id').datagrid('getEditor',{
		index:index,
		field : 'capitalSourceName'  
	});
	var idAndName = {};
	idAndName.code = $(capitalSourceCodes.target).textbox('getValue');
	idAndName.name = $(capitalSourceNames.target).textbox('getText');
	idAndName.amount = isNaN(parseFloat(rows[index].outAmount))?0:parseFloat(parseFloat(rows[index].outAmount));
	arr.push(idAndName);
	for (var i = 0; i < rows.length; i++){
		if(i!=index){
			var capitalSourceCode = rows[i].capitalSourceCode;
			var capitalSourceName = rows[i].capitalSourceName;
			var outAmount = rows[i].outAmount;
			var idAndName = {};
			idAndName.code = capitalSourceCode;
			idAndName.name = capitalSourceName;
			idAndName.amount = outAmount;
			arr.push(idAndName);
		}
	}
	var b = [];//记录数组a中的id 相同的下标
    for(var h = 0; h < arr.length;h++){
        for(var j = arr.length-1;j>h;j--){
            if(arr[h].code == arr[j].code){
            	arr[h].amount = (parseFloat(arr[h].amount) + parseFloat(arr[j].amount)).toString();
                b.push(j);
            }
        }
    }
    for(var k = 0; k<b.length;k++){
        arr.splice(b[k],1);
    }
	var idAndNames = new Array();
    for (var m = 0; m < arr.length; m++) {
			var zijin = {};
			zijin.fundsSourceText = arr[m].name;
			zijin.fundsSource = arr[m].code;
			zijin.amount = arr[m].amount;
			idAndNames.push(zijin);
	}
    var idAndNameJsons = '';
	for (var y = 0; y < idAndNames.length; y++) {
		idAndNameJsons += JSON.stringify(idAndNames[y]);
		if (y < idAndNames.length - 1) {
			idAndNameJsons += ",";
		}
	}
    $('#fundJson').val(idAndNameJsons);
    globalVariable = idAndNames;
	return idAndNames;
}
var globalVariable = new Array();
//计算资金来源和合计金额
function onLoadSuccesscapitalSourceCodeAndAmountArr(){
	var rows = $('#pro_outcomes_table_id').datagrid('getRows');
	var arr = new Array();
	for (var i = 0; i < rows.length; i++){
			var capitalSourceCode = rows[i].capitalSourceCode;
			var capitalSourceName = rows[i].capitalSourceName;
			var outAmount = rows[i].outAmount;
			var idAndName = {};
			idAndName.code = capitalSourceCode;
			idAndName.name = capitalSourceName;
			idAndName.amount = outAmount;
			arr.push(idAndName);
	}
	var b = [];//记录数组a中的id 相同的下标
    for(var h = 0; h < arr.length;h++){
        for(var j = arr.length-1;j>h;j--){
            if(arr[h].code == arr[j].code){
            	arr[h].amount = (parseFloat(arr[h].amount) + parseFloat(arr[j].amount)).toString();
                b.push(j);
            }
        }
    }
    for(var k = 0; k<b.length;k++){
        arr.splice(b[k],1);
    }
	var idAndNames = new Array();
	var idAndNamesAmount = 0;
    for (var m = 0; m < arr.length; m++) {
			var zijin = {};	 
			zijin.fundsSourceText = arr[m].name;
			zijin.fundsSource = arr[m].code;
			zijin.amount = arr[m].amount;
			idAndNames.push(zijin);
			idAndNamesAmount  += isNaN(parseFloat(arr[m].amount))?0:parseFloat(arr[m].amount);
	}
    $('#outcomeTotalshow').html(idAndNamesAmount.toFixed(2));
    globalVariable = idAndNames;
    var idAndNameJsons = '';
	for (var y = 0; y < idAndNames.length; y++) {
		idAndNameJsons += JSON.stringify(idAndNames[y]);
		if (y < idAndNames.length - 1) {
			idAndNameJsons += ",";
		}
	}
    $('#fundJson').val(idAndNameJsons);
    $('#fundssource').datagrid('loadData',globalVariable);
	return idAndNames;
}

function onLoadSuccessOutcomesDetail(){
	//总金额
	var totalFsumMoney = 0;
	var rows = $('#pro_outcomes_table_id').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		totalFsumMoney+=addNumOutcomesDetail(rows,i);
	}
	totalFsumMoney=parseFloat(totalFsumMoney);
	$('#outcomeTotalshow').html(totalFsumMoney.toFixed(2));
}

//未编辑或者已经编辑完毕的行
function addNumOutcomesDetail(rows,index){
	//获取资金来源中金额列的值
	var amount = rows[index]['outAmount'];
	//若转换后金额列的值为NaN
	if(!isNaN(parseFloat(amount))){
		return parseFloat(amount); 
	}
	return 0.00;
}

</script>
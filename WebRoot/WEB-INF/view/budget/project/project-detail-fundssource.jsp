<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="fundssourceDetail" class="easyui-datagrid" style="width:870px;height:auto"
			data-options="
			singleSelect: true,
			striped:true,
			<c:if test="${empty checkPeople}">
			url: '${base}/project/fundssource?FProId=${bean.FProId}',
			</c:if>
			rownumbers : true,
			method: 'post',
			">
			<thead>
					<tr>
						<th data-options="field:'fundsSource',hidden:true,width:180,align:'center',editor:'textbox'">资金来源编码</th>
						<th data-options="field:'fundsSourceText',width:180,align:'center',editor:'textbox'" style="width: 51%">资金来源名称</th>
						<th data-options="field:'amount',width:250,align:'center',editor:'numberbox'" style="width: 51%">金额[元]</th>
					</tr>
			</thead>
</table>
<div id="project-add-fundssource-tb" style="height:auto;float:right;">
	<input type="hidden" id="fundsJson" name="fundsJson"/>
	预算金额：<span style="color: red"  id="pro_add_FProBudgetAmount_show">${bean.FProBudgetAmount}</span><span style="margin-right: 5px;">元，</span>
	大写金额：<span style="color: red"  id="pro_add_UP_FProBudgetAmount"></span>
</div>
<script type="text/javascript">
var fundsEditIndex = undefined;
var selectVal = null;
var selectCode = null;
var numFund=0;

function showtext(row){
	//console.log(row);
	return row;
}
function showcode(){
	return selectCode;
}

function fundsappend() {//未配置采购类型不可添加采购清单
	 if (fundsEndEditing()) {
			$('#fundssourceDetail').datagrid('appendRow', {fundsSource:selectCode,fundsSourceText:selectVal,amount:0});
			fundsEditIndex = $('#fundssourceDetail').datagrid('getRows').length - 1;
			$('#fundssourceDetail').datagrid('selectRow', fundsEditIndex).datagrid('beginEdit',
					fundsEditIndex);
		}

	//页面随滚动条置底
	/* var div = document.getElementById('westDiv');
	div.scrollTop = div.scrollHeight; */
}

//计算总额
function setFsumMoney(newValue,oldValue) {
	if(newValue==undefined || oldValue==undefined){
		return false;
	}
	//总金额
	var totalFsumMoney = 0;
	//编辑列金额
	var fsumMoney = 0;
	//获取编辑行
	var index = $('#fundssourceDetail').datagrid('getRowIndex',$('#fundssourceDetail').datagrid('getSelected'));
	//获取总行数
	var rows = $('#fundssourceDetail').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		if(i==index){	//若当前循环行为编辑行，将修改值赋予编辑列金额
			fsumMoney=parseFloat(newValue);
		}else{			//若当前循环行不为编辑行，合计之前编辑列的金额
			totalFsumMoney+=addNum(rows,i);
		}  
	 
	}
	totalFsumMoney=(parseFloat(totalFsumMoney)+parseFloat(fsumMoney))/10000;
	totalFsumMoney=parseFloat(totalFsumMoney);
	$('#pro_add_FProBudgetAmount').textbox('setValue',totalFsumMoney.toFixed(6));
	$('#pro_add_FProBudgetAmount_show').html(totalFsumMoney.toFixed(6));
}
//未编辑或者已经编辑完毕的行
function addNum(rows,index){
	//获取资金来源中金额列的值
	var amount = rows[index]['amount'];
	//若转换后金额列的值为NaN
	if(!isNaN(parseFloat(amount))){
		return parseFloat(amount); 
	}
	return 0.00;
}


//删除一行
function fundsremoveit() {
	if (fundsEditIndex == undefined) {
		return
	}
	$('#fundssourceDetail').datagrid('cancelEdit', fundsEditIndex).datagrid('deleteRow',
			fundsEditIndex);
	fundsEditIndex = undefined;
	setFsumMoney(0,0);
}
//使列表结束编辑状态
function fundsaccept() {
	if(fundsEndEditing()){
		$('#fundssourceDetail').datagrid('acceptChanges');
	}
}
//资金来源表格结束编辑状态
function fundsEndEditing() {
	if (fundsEditIndex == undefined) {
		return true;
	}
	if ($('#fundssourceDetail').datagrid('validateRow', fundsEditIndex)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		$('#fundssourceDetail').datagrid('endEdit', fundsEditIndex);
		fundsEditIndex = undefined;
		return true;
	} else {
		return false;
	}
}
//行被点击事件
function onClickRow(index) {
	if (fundsEditIndex != index) {
		if (fundsEndEditing()) {
			$('#fundssourceDetail').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			fundsEditIndex = index;
		} else {
			$('#fundssourceDetail').datagrid('selectRow', fundsEditIndex);
		}
	}
}

function getFundJson(){
	fundsaccept();
	
	var rows = $('#fundssourceDetail').datagrid('getRows');
	var fundJson = "";
	for (var i = 0; i < rows.length; i++) {
		fundJson +=  JSON.stringify(rows[i]);
		if (i < rows.length - 1) {
			fundJson += ",";
		}
	}
	$('#fundJson').val(fundJson);
	return true;
}
</script>

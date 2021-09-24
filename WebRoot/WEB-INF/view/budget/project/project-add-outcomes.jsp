<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="pro_outcomes_table" class="easyui-datagrid" 
	style="width:870px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#rpl',
	<c:if test="${!empty bean.FProId}">
	url: '${base}/project/findByfProIdGetDetail?id=${bean.FProId}',
	</c:if>
	<c:if test="${empty bean.FProId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRowProOutcomes,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'activity',width:110,align:'center',editor:{type:'textbox'}">具体业务</th>
				<th data-options="field:'funSubName',width:160,align:'center',editor:{type:'combotree',options:{
								valueField:'code',
								textField:'text',
								editable: true,
								method:'post',
								url:base+'/apply/comboboxJsons?parentCode=GNFLKM',
								onSelect:setFunSubCode,
							}}">功能分类科目</th>
				<th data-options="field:'funSubCode',hidden:true,editor:'textbox'">功能分类科目编号</th>
				<th data-options="field:'subName',width:160,align:'center'
								,editor:{type:'textbox',options:{editable:false,icons:[{iconCls:'icon-add',handler: function(e){
									     var row = $('#pro_outcomes_table').datagrid('getSelected');
									     var index = $('#pro_outcomes_table').datagrid('getRowIndex',row);
									     chooseOutSubName(index)
									     }}]}}">经济分类科目</th>
				<th data-options="field:'subCode',hidden:true,width:150,align:'center',editor:'textbox'">经济分类科目编号</th>
				<th data-options="field:'capitalSourceName',width:160,align:'center',editor:{type:'combotree',options:{
								valueField:'code',
								textField:'text',
								prompt:'请预算主办会计选择',
								method:'post',
								editable:false,
								readonly:true,
								url:base+'/apply/comboboxJsons?parentCode=ZJLY',
								onSelect:setCapitalSourceCode
							}}">资金来源</th>
				<th data-options="field:'capitalSourceCode',hidden:true,width:150,align:'center',editor:{type:'textbox',options:{onChange:onChangeSourceCode}}">资金来源编号</th>
				<th data-options="field:'outAmount',width:130,align:'center',editor:{type:'numberbox',options:{onChange:setOutcomesMoney,precision:2}}">支出金额(元)</th>
				<th data-options="field:'actDesc',width:125,align:'center',editor:'textbox'">备注</th>
			</tr>
		</thead>
	</table>
	<c:if test="${empty detail}">
	<div id="rpl" style="height:30px;padding-top : 8px">
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="removeitOutcomeTable()" id="rrmoveid" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendOutcomeTable()" id="raddid" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>

		<a href="#" id="index-imput" onclick="projectOutcomeImput()">
			<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/daoru1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
		<a href="${base}/project/outcomeDownload" id="index-imput">
			<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/mbxz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			<input type="hidden" id="outcomeTotal" name="outcomeTotal" value="${bean.FProBudgetAmount}"> 
		</a>
		<a style="text-align: right;">
			合计金额：<span style="color: red" id="outcomeTotalshow"><fmt:formatNumber groupingUsed="true" value="${bean.FProBudgetAmount}" minFractionDigits="2" maxFractionDigits="2"/></span>元
		</a>		
	</div>
	</c:if>
	<input type="hidden" id="outcomeJson" name="outcomeJson" />
</div>

	
<script type="text/javascript">
function getOutcomeJson(){
	accept1();
	var rows = $('#pro_outcomes_table').datagrid('getRows');
	var outcomeJson = "";
	if(rows==''){
		return false;
	}
	var flag1 = true;
	for (var y = 0; y < rows.length; y++) {
		if(rows[y].activity==''||rows[y].funSubName==''||rows[y].subName==''||rows[y].outAmount==''){
			flag1 = false;
		}
	}
	if(!flag1){
		return false;
	}
	for (var i = 0; i < rows.length; i++) {
		outcomeJson = outcomeJson + JSON.stringify(rows[i]) + ",";
	}
	$('#outcomeJson').val(outcomeJson);
	return true;
}

function isorno(val){
	if(val=='1'){
		return '是';
	}else if(val=='0'){
		return '否';
	}else{
		return val;
	}
}
//表格添加删除，保存方法
	var editIndex1 = undefined;
	function endEditing1() {
		if (editIndex1 == undefined) {
			return true
		}
		if ($('#pro_outcomes_table').datagrid('validateRow', editIndex1)) {
			var tr = $('#pro_outcomes_table').datagrid('getEditors', editIndex1);
			var text1=tr[1].target.combotree('getText');
			if(text1!='--请选择--'){
				tr[1].target.combotree('setValue',text1);
			}
			var text5=tr[5].target.combotree('getText');
			if(text5!='--请选择--'){
				tr[5].target.combotree('setValue',text5);
			}
			$('#pro_outcomes_table').datagrid('endEdit', editIndex1);
			editIndex1 = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRowProOutcomes(index) {
		if (editIndex1 != index) {
			if (endEditing1()) {
				$('#pro_outcomes_table').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex1 = index;
			} else {
				$('#pro_outcomes_table').datagrid('selectRow', editIndex1);
			}
		}
	}
	function appendOutcomeTable() {
		if (endEditing1()) {
			$('#pro_outcomes_table').datagrid('appendRow', {});
			editIndex1 = $('#pro_outcomes_table').datagrid('getRows').length - 1;
			$('#pro_outcomes_table').datagrid('selectRow', editIndex1).datagrid('beginEdit',editIndex1);
		}
	}
	function removeitOutcomeTable() {
		if (editIndex1 == undefined) {
			return
		}
		$('#pro_outcomes_table').datagrid('cancelEdit', editIndex1).datagrid('deleteRow',
				editIndex1);
		editIndex1 = undefined;
		allRowsProMingXiAmount();
	}
	function accept1() {
		if (endEditing1()) {
			$('#pro_outcomes_table').datagrid('acceptChanges');
		}
	}
	
	function setFunSubCode(rec){
		var row = $('#pro_outcomes_table').datagrid('getSelected');
		var rindex = $('#pro_outcomes_table').datagrid('getRowIndex', row); 
		var ed = $('#pro_outcomes_table').datagrid('getEditor',{
			index:rindex,
			field : 'funSubCode'  
		});
		$(ed.target).textbox('setValue', rec.code);
	}
	function setSubCode(rec){
		var row = $('#pro_outcomes_table').datagrid('getSelected');
		var rindex = $('#pro_outcomes_table').datagrid('getRowIndex', row); 
		var administrationLevelCode = $('#pro_outcomes_table').datagrid('getEditor',{
			index:rindex,
			field : 'administrationLevelCode'  
		});
			$(administrationLevelCode.target).textbox('setValue', rec.code);
	}
	function setCapitalSourceCode(rec){
		var row = $('#pro_outcomes_table').datagrid('getSelected');
		var rindex = $('#pro_outcomes_table').datagrid('getRowIndex', row); 
		var code = $('#pro_outcomes_table').datagrid('getEditor',{
			index:rindex,
			field : 'capitalSourceCode'  
		});
		$(code.target).textbox('setValue', rec.code);
	}

//弹出支出明细导入页面
function projectOutcomeImput(){
	var fProOrBasic = '${bean.FProOrBasic}';
	var win = creatFirstWin('支出明细导入', 500, 200, 'icon-search', '/project/outcomeImput?fProOrBasic='+fProOrBasic);
	win.window('open');
}

function chooseOutSubName(rIndex){
	var ejProCode="";
	var code = '';
	var fProOrBasic = '${bean.FProOrBasic}';
	var planStartYear = $('#pro_add_planStartYear').numberbox('getValue');
	if(planStartYear==''||planStartYear==null||planStartYear==undefined){
		alert('请先填写计划开始执行年份');
		return false;
	}
	var win=creatFirstWin('选择-经济分类科目',600,550,'icon-search','/project/toChooseKm?rIndex='+rIndex+'&fProOrBasic='+fProOrBasic+'&ejProCode='+ejProCode+'&code='+code+'&ejplanStartYear='+planStartYear);
	win.window('open');
}
function chooseOutFun(rIndex){
	var win=creatFirstWin('选择-功能分类科目',600,550,'icon-search','/project/toChooseFun?rIndex='+rIndex);
	win.window('open');
}
function chooseOutCS(rIndex){
	var win=creatFirstWin('选择-功能分类科目',600,550,'icon-search','/project/toChooseCapitalSource?rIndex='+rIndex);
	win.window('open');
}

function onChangeSourceCode(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	
	var flag = comparativeAnalysis(newVal);
	if(flag){//如果资金来源表没有这个类型，就添加一行
			var row = $('#pro_outcomes_table').datagrid('getSelected');
			var rindex = $('#pro_outcomes_table').datagrid('getRowIndex', row); 
			var outAmount = $('#pro_outcomes_table').datagrid('getEditor',{
				index:rindex,
				field : 'outAmount'  
			});
			var capitalSourceName = $('#pro_outcomes_table').datagrid('getEditor',{
				index:rindex,
				field : 'capitalSourceName'
			});
			var capitalSourceCode = $('#pro_outcomes_table').datagrid('getEditor',{
				index:rindex,
				field : 'capitalSourceCode'  
			});
			var amount = isNaN(parseFloat($(outAmount.target).numberbox('getValue')))?0:parseFloat($(outAmount.target).numberbox('getValue'));
			var name = $(capitalSourceName.target).combotree('getValue');
			var code = $(capitalSourceCode.target).textbox('getValue');
			$('#fundssource').datagrid('appendRow',{
				fundsSource:selectCode,
				fundsSourceText:selectVal,
				amount:0
			});
			fundsEditIndex = $('#fundssource').datagrid('getRows').length - 1;
			$('#fundssource').datagrid('appendRow',{
				fundsSource:code,
				fundsSourceText:name,
				amount:amount
			});
			fundsEditIndex = $('#fundssource').datagrid('getRows').length - 1;
	}else{//如果资金来源表有这个类型，就更新当前行的金额
		var rows = $('#fundssource').datagrid('getRows');
		for (var i = 0; i < rows.length; i++) {
			if(newVal==rows[i].fundsSource){
				var row = $('#pro_outcomes_table').datagrid('getSelected');
				var rindex = $('#pro_outcomes_table').datagrid('getRowIndex', row); 
				var amountNum = capitalSourceCodeAndAmountArr(rindex,code);
				$('#fundssource').datagrid('updateRow',{
					index: i,
					row: {
						amount:amountNum
					}
				});
			}
		}
	}
}

function comparativeAnalysis(data){
	
	var flag = true;
	var rows = $('#fundssource').datagrid('getRows');
	for (var i = 0; i < rows.length; i++) {
		if(data==rows[i].fundsSource){
			flag = false;
		}
	}
	return flag;
}

//计算资金来源和合计金额
function capitalSourceCodeAndAmountArr(index,code){
	var arr = new Array();
	var outAmounts = $('#pro_outcomes_table').datagrid('getEditor',{
		index:index,
		field : 'outAmount'  
	});
	var capitalSourceCodes = $('#pro_outcomes_table').datagrid('getEditor',{
		index:index,
		field : 'capitalSourceCode'  
	});
	var idAndName = {};
	idAndName.code = $(capitalSourceCodes.target).textbox('getValue');
	idAndName.amount = isNaN(parseFloat($(outAmounts.target).numberbox('getValue')))?0:parseFloat($(outAmounts.target).numberbox('getValue'));
	arr.push(idAndName);
	var rows = $('#pro_outcomes_table').datagrid('getRows');
	for (var i = 0; i < rows.length; i++){
		if(i!=index){
			var capitalSourceCode = rows[i].capitalSourceCode;
			var outAmount = rows[i].outAmount;
			var idAndName = {};
			idAndName.code = capitalSourceCode;
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
    var amountss = 0;
    for (var m = 0; m < arr.length; m++) {
		if(code==arr[m].code){
			amountss = arr[m].amount;
		}
	}
	return amountss;
}

//计算总额
function setOutcomesMoney(newValue,oldValue) {
	if(newValue==undefined || oldValue==undefined){
		return false;
	}
	//总金额
	var totalFsumMoney = 0;
	//编辑列金额
	var fsumMoney = 0;
	//获取编辑行
	var index = $('#pro_outcomes_table').datagrid('getRowIndex',$('#pro_outcomes_table').datagrid('getSelected'));
	//获取总行数
	var rows = $('#pro_outcomes_table').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		if(i==index){	//若当前循环行为编辑行，将修改值赋予编辑列金额
			fsumMoney=parseFloat(newValue);
		}else{			//若当前循环行不为编辑行，合计之前编辑列的金额
			totalFsumMoney+=addNumOutcomes(rows,i);
		}  
	 
	}
	totalFsumMoney=(parseFloat(totalFsumMoney)+parseFloat(fsumMoney));
	totalFsumMoney=parseFloat(totalFsumMoney);
	$('#pro_add_FProBudgetAmount').textbox('setValue',totalFsumMoney.toFixed(2));
	$('#outcomeTotalshow').html(totalFsumMoney.toFixed(2));
}
//未编辑或者已经编辑完毕的行
function addNumOutcomes(rows,index){
	//获取资金来源中金额列的值
	var amount = rows[index]['outAmount'];
	//若转换后金额列的值为NaN
	if(!isNaN(parseFloat(amount))){
		return parseFloat(amount); 
	}
	return 0.00;
}

function allRowsProMingXiAmount(){
	//总金额
	var totalFsumMoney = 0;
	var rows = $('#pro_outcomes_table').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
			totalFsumMoney+=addNumOutcomes(rows,i);
	}
	
	totalFsumMoney = parseFloat(totalFsumMoney);
	$('#pro_add_FProBudgetAmount').numberbox('setValue',totalFsumMoney.toFixed(2));
	$('#outcomeTotalshow').html(totalFsumMoney.toFixed(2));
}


//导入数据后计算总额
function exportOutcomesMoney(){
	//总金额
	var totalFsumMoney = 0;
	var rows = $('#pro_outcomes_table').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		totalFsumMoney+=addNumOutcomes(rows,i);
	}
	totalFsumMoney=parseFloat(totalFsumMoney);
	$('#pro_add_FProBudgetAmount').textbox('setValue',totalFsumMoney.toFixed(2));
	$('#outcomeTotalshow').html(totalFsumMoney.toFixed(2));
}
</script>
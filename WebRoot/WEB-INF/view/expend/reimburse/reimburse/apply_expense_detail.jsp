<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<input type="hidden" id="gIdHidden" value="${applyBean.gId}">
	<table id="apply_expense_detail_tab_id" class="easyui-datagrid" style="width:407px;height:auto"
	data-options="
	singleSelect: true,
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/getExpenseDetail?gId=${applyBean.gId}',
	</c:if>
	<c:if test="${empty applyBean.gId}">
	url: '',
	</c:if>
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	onBeforeLoad:getExpenseData
	">
		<thead>
			<tr>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'expenseName',width:177,align:'center'">费用名称</th>
				<th data-options="field:'applyAmount',width:200,align:'center'">申请金额</th>
			</tr>
		</thead>
	</table>
</div>
<script type="text/javascript">
	
	var editIndexExpense = undefined;
	
	function endEditingExpense() {
		if (editIndexExpense == undefined) {
			return true;
		}
		
		if ($('#apply_expense_detail_tab_id').datagrid('validateRow', editIndexExpense)) {
			$('#apply_expense_detail_tab_id').datagrid('endEdit', editIndexExpense);
			editIndexExpense = undefined;
			return true;
		} else {
			return false;
		}
	}

	function getExpenseData(){
		var gIdHidden = $('#gIdHidden').val();
		var expenseArr = ['国际旅费','国外城市间交通费','住宿费','伙食费','公杂费','宴请费用','其他费用'];
		for (var i in expenseArr) {
			$('#apply_expense_detail_tab_id').datagrid('insertRow',{
			    index: Number(i),   // 索引从0开始
			    row: {
			    	gId: gIdHidden,
			    	expenseName: expenseArr[i]
			    }
			});
		}
	}
	
	function applyAmountEdit(index, field, value){
		/* $('#apply_expense_detail_tab_id').datagrid('beginEdit', index);
        var ed = $(this).datagrid('getEditor', {index:index,field:field});
        $(ed.target).focus(); */
        if(sign==1){
    		if (editIndexExpense != index) {
    			if (endEditingExpense()) {
    				/* $('#apply_expense_detail_tab_id').datagrid('selectRow', index).datagrid('beginEdit',
    						index); */
    				$('#apply_expense_detail_tab_id').datagrid('beginEdit', index);
    				editIndexExpense = index;
    			} else {
    				$('#apply_expense_detail_tab_id').datagrid('selectRow', editIndexExpense);
    			}
    		}
    	}else{
    		alert("请先保存出访计划！");
    		return false;
    	}
	}
	
	function acceptExpense() {
		if (endEditingExpense()) {
			$('#apply_expense_detail_tab_id').datagrid('acceptChanges');
		}
	}
	
	function expenseDetailJson(){
		acceptExpense();
		var expenseRows = $('#apply_expense_detail_tab_id').datagrid('getRows');
		// 国际旅费
		var travel = JSON.stringify(expenseRows[0]);
		$('#travelJson').val(travel);
		// 国外城市间交通费
		var outsideTraffic = JSON.stringify(expenseRows[1]);
		$('#outsideTrafficJson').val(outsideTraffic);
		// 住宿费
		var hotelJson = JSON.stringify(expenseRows[2]);
		$("#hotelJson").val(hotelJson);
		// 伙食费
		var foodObj = new Object();
		foodObj.gId = expenseRows[3].gId;
		foodObj.fApplyAmount = expenseRows[3].applyAmount;
		var foodJson = JSON.stringify(foodObj);
		$("#foodJson").val(foodJson);
		// 公杂费
		var feeObj = new Object();
		feeObj.gId = expenseRows[4].gId;
		feeObj.fApplyAmount = expenseRows[4].applyAmount;
		var feeJson = JSON.stringify(feeObj);
		$("#feeJson").val(feeJson);
		// 宴请费用
		var feteObj = new Object();
		feteObj.gId = expenseRows[5].gId;
		feteObj.fApplyAmount = expenseRows[5].applyAmount;
		var feteJson = JSON.stringify(feteObj);
		$('#feteJson').val(feteJson);
		// 其他费用
		var otherObj = new Object();
		otherObj.gId = expenseRows[6].gId;
		otherObj.fCost = expenseRows[6].applyAmount;
		var otherJson = JSON.stringify(otherObj);
		$('#otherJson').val(otherJson);
	}
	
	function outAmounts(newVal,oldVal){
		if(newVal==undefined || oldVal==undefined){
			return false;
		}
		if(newVal==''){
			newVal=0.00;
		}
		
		var rows = $('#apply_expense_detail_tab_id').datagrid('getRows');
		var index = $('#apply_expense_detail_tab_id').datagrid('getRowIndex',$('#apply_expense_detail_tab_id').datagrid('getSelected'));
		var num1 = 0;
		for(var i=0;i<rows.length;i++){
			if(i==index){
				num1+=parseFloat(newVal);
			}else{
				num1+=addNumsOut(rows,i);
			}
		}
		$("#applyAmountAbroad").html(num1.toFixed(2) + "元");
		$('#applyAmount').val(num1.toFixed(2));
	}
	
	function addNumsOut(rows,index){
		var num=0;
		if(rows[index].applyAmount!=''&&rows[index].applyAmount!='NaN'&&rows[index].applyAmount!=undefined){
			num = parseFloat(rows[index].applyAmount);
		}else{
			num =0;
		}
		return num;
	}
</script>
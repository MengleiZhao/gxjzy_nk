<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<div  data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:755px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="window-left-top-div">
			<form id="reimburse_save_form" method="post"  enctype="multipart/form-data" style="height: 0px">
				<!-- 隐藏域 --> 
				<!-- 主键ID --><input type="hidden" name="rId" value="${bean.rId}" id="rId"/>
				<!-- 报销单号 --><input type="hidden" name="rCode" value="${bean.rCode}"/>
				<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="reimburseFlowStauts" />
				<!-- 报销状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="reimburseStauts" />
				<%-- <!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
				<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" /> --%>
				<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
				<!-- 报销类型 --><input type="hidden" id="reimburseTypeHi" value="${bean.type}" name="type"/>
				<!-- 报销类型 --><input type="hidden" id="reimburseAmount" name="amount" value="${bean.amount}"/>
				<!-- 指标ID --><input type="hidden" name="indexId" value="${applyBean.indexId}" id=""/>
				<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="indexType"/>
				<!-- 报销人 --><input type="hidden" name="userName" value="${bean.userName}" id="input_userName"/>
				<!-- 报销部门 --><input type="hidden" name=deptName value="${bean.deptName}" id="input_deptName"/>
				<div id="panelID" class="easyui-panel" data-options="closed:true">
				<!-- 项目支出明细ID --><input type="hidden" name="proDetailId" value="${bean.proDetailId}" id="proDetailId"/>
				<input type="hidden" id="json1" name="form1" />
				<input type="hidden" id="json2" name="form2" />
				<input type="hidden" id="json3" name="form3" />
				<input type="hidden" id="json4" name="form4" />
				<input type="hidden" id="json5" name="form5" />
				<input type="hidden" id="json6" name="form6" />
				<input type="hidden" id="applyAmount" name="applyAmount" value="${applyBean.amount}" />
				
				</div>
			
				
				</form>		
				<div class="tab-wrapper" id="reimburse-abroad-add">
					<ul class="tab-menu">
						<li class="active" onclick="onclickreimburset()">报销单</li>
						<li onclick="onclickdetail()" >申请单</li>
					</ul>
					<div class="tab-content">
						<div title="报销单" style="width: 737px" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="reimburse_abroadInfo_detail.jsp" />
						</div>
						<div title="申请单" style="margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="apply_detail_abroad.jsp" />
						</div>
					</div>
				</div>
		
			</div>
			
			<div class="window-left-bottom-div">
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=支出管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		<c:if test="${bean.type!=1 }">
			<div class="window-right-div" data-options="region:'east',split:true">
				<jsp:include page="../../../check_system.jsp" />
			</div>
		</c:if>
	</div>
</div>
<script type="text/javascript">


flashtab('reimburse-abroad-add');

//防止不停重新加载
var abroadcount = 0;
function onclickreimburset(){
	if(abroadcount>0){
		abroadcount+=1;
		return false;
	}else {
		abroadcount+=1;
		$('#abroad-plan-dg-reim').datagrid('reload');
		$('#international_traveling_expense_id-reim').datagrid('reload');
		$('#apply_outside_traffic_tab_id-reim').datagrid('reload');
		$('#hoteltabApply-reim').datagrid('reload');
		$('#foodtab-reim').datagrid('reload');
		$('#rec-fee-dg-reim').datagrid('reload');
		$('#rec-fete-dg-reim').datagrid('reload');
		$('#rec-other-dg-reim').datagrid('reload');
		$('#check-history-dg').datagrid('reload');
		return true;
	}
}
var abroadDetailcount = 0;
function onclickdetail(){
	if(abroadDetailcount>=1){
		abroadDetailcount+=1;
		return false;
	}else {
		abroadDetailcount+=1;
		$('#abroad-plan-dg').datagrid('reload');
		$('#abroad-person-detail-dg').datagrid('reload');
		$('#travel-way-dg').datagrid('reload');
		$('#apply_expense_detail_tab_id').datagrid('reload');
		$('#international_traveling_expense_id').datagrid('reload');
		$('#apply_outside_traffic_tab_id').datagrid('reload');
		$('#hoteltabApply').datagrid('reload');
		$('#foodtab').datagrid('reload');
		$('#rec-fee-dg').datagrid('reload');
		$('#rec-fete-dg').datagrid('reload');
		$('#rec-other-dg').datagrid('reload');
		$('#check-history-reim-apply-dg').datagrid('reload');
		return true;
	}
}
//冲销借款
function cx(){
	var num1=parseFloat($('#input_jkdamonut').val());
	var num2=parseFloat($('#reimburseAmount').val());
	var num3=parseFloat($('#applyAmount').val());
	if(isNaN(num1)&&!isNaN(num2)){
		 $('#skAccount').numberbox('setValue',num2.toFixed(2));
	}
	if(!isNaN(num1)&&!isNaN(num2)){
		if(num2<num1){
			var num4=num1-num2;
			 $('#cxAmount').html(fomatMoney(num2,2)+" [元]");
			 $('#syAmount').html(fomatMoney(num4,2)+" [元]");
			 $('#skAccount').numberbox('setValue',0);
		}else{
			$('#cxAmount').html(fomatMoney(num1,2)+" [元]");
			$('#syAmount').html(fomatMoney(0,2)+" [元]");
			$('#skAccount').numberbox('setValue',(num2-num1).toFixed(2));
		}
	}
	if(!isNaN(num2)){
		if(num2<num3){
			var num5=num3-num2;
			$('#ghAmount').html(fomatMoney(num5,2)+" [元]");
		}else{
			$('#ghAmount').html(fomatMoney(0,2)+" [元]");
		}
	}
}

function jk(){
	var cxjk = $('input[name="withLoan"]:checked').val();
	var num2=parseFloat($('#reimburseAmount').val());
	var num3=parseFloat($('#applyAmount').val());
	if(cxjk==1){
	var num1=parseFloat(${bean.loan.leastAmount});
	if(!isNaN(num1)&&!isNaN(num2)){
		if(num2<num1){
			var num4=num1-num2;
			 $('#cxAmount').html(fomatMoney(num2,2)+" [元]");
			 $('#syAmount').html(fomatMoney(num4,2)+" [元]");
		}else{
			$('#cxAmount').html(fomatMoney(num1,2)+" [元]");
			$('#syAmount').html(fomatMoney(0,2)+" [元]");
		}
	}
	}
	if(!isNaN(num2)){
		if(num2<num3){
			var num5=num3-num2;
			$('#ghAmount').html(fomatMoney(num5,2)+" [元]");
		}else{
			$('#ghAmount').html(fomatMoney(0,2)+" [元]");
		}
	}
}

function onSelect2(date) {
	endday2 = date;
	startday2 = new Date(startday2);
	var d = (endday2 - startday2) / 86400000 + 1;
	if (d > 0) {
		$('#duration').numberbox("setValue", d);
	} else {
		$('#duration').numberbox("setValue", "");
	}
}
//显示详细信息手风琴页面
$(document).ready(function() {
	jk();
	//是否显示 冲销借款信息
	var cxjk = $('input[name="withLoan"]:checked').val();
	if(cxjk==1){
		$('#jk').show();
	} else {
		$('#jk').hide();
		$('#input_jkdamonut').val(0);
	}
	var fupdateStatus = $('input[name="fupdateStatus"]:checked').val();
	if(fupdateStatus==1){
		$('#radiofupdate').show();
		$('#fupdateStatusid').val(1);
	} else {
		$('#radiofupdate').hide();
		$('#fupdateStatusid').val(0);
	}
	var cxjk = '${abroadEdit.fDiningPlace}';
	if(cxjk==1){
		$('#feteCostId').show();
		$("#fDiningPlaceId1").attr("checked",true);
	} else {
		$('#feteCostId').hide();
		$("#fDiningPlaceId2").attr("checked",true);
	}
	//设置申请金额
	var applyAmount = $("#applyAmount").val();
	if(applyAmount !=""){
		$('#applyAmount_span').html(fomatMoney(applyAmount,2)+" [元]");
	}

	var h = $("#reimburseTypeHi").textbox().textbox('getValue');
	if (h != "") {
		$('#reimburseType').textbox().textbox('setValue', h);
		$('#reimburseType').textbox().attr('readonly', true);
	}
	
	if (h == 1) {
		$('#spbxhyxx').remove();
		$('#spbxpxxx').remove();
		$('#spbxclxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwyc').remove();
		$('#spbxgwcg').remove();
		/* $("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息'); */
	}
	if (h == 2) {//会议
		$('#spbxpxxx').remove();
		$('#spbxclxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwyc').remove();
		$('#spbxgwcg').remove();
	}
	if (h == 3) {//培训
		$('#spbxhyxx').remove();
		$('#spbxclxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwyc').remove();
		$('#spbxgwcg').remove();
	}
	if (h == 4) {//差旅
		$('#spbxhyxx').remove();
		$('#spbxpxxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwyc').remove();
		$('#spbxgwcg').remove();
	}
	if (h == 5) {//接待
		$('#spbxhyxx').remove();
		$('#spbxpxxx').remove();
		$('#spbxclxx').remove();
		$('#spbxgwyc').remove();
		$('#spbxgwcg').remove();
	}
	if (h == 6) {//公务用车
		$('#spbxhyxx').remove();
		$('#spbxpxxx').remove();
		$('#spbxclxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwcg').remove();
	}
	if (h == 7) {//公务出国
		$('#spbxhyxx').remove();
		$('#spbxpxxx').remove();
		$('#spbxclxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwyc').remove();
	}
	$("#input_jkdbh").textbox({
		onChange: function(newValue, oldValue) {
			cx();
		}
	});
});

function selectCxjk(){
	var cxjk = $('input[name="withLoan"]:checked').val();
	if(cxjk==1){
		$('#jk').show();
	} else {
		$('#jk').hide();
		$('#input_jkdamonut').val(0);
		cx();
	}
}

//保存
function saveReimburse(flowStauts) {
	 ;
	var jsonStr1 = $("#form1").serializeJson();
	var jsonStr2 = $("#form2").serializeJson();
	var jsonStr3 = $("#form3").serializeJson();
	var jsonStr4 = $("#form4").serializeJson();
	var jsonStr5 = $("#form5").serializeJson();
	/* console.dir(jsonStr); 
	var formDataArr = $('form[id="hotel0"]').serializeArray();
	console.dir(formDataArr); 
	var formDataArr1 = $('form[id="hotel1"]').serializeArray();
	console.dir(formDataArr1);  */
	var applyAmount1 = $("#applyAmount1").val();
	var nums = $("#nums").val();
	var num3 = $("#num3").val();
	//设置审批状态
	$('#reimburseFlowStauts').val(flowStauts);
	//设置报销状态
	$('#reimburseStauts').val(flowStauts);
	if(parseFloat(nums)>parseFloat(num3)){
		var rows = $('#rmxdg').datagrid('getRows');
		for (var i = 0; i < rows.length; i++) {
			if(rows[i].standard!="据实列支"&&rows[i].standard!=null){
				if(parseFloat(rows[i].reimbSum)>parseFloat(rows[i].standard)){
					alert("报销金额不能超过支出标准！")
					return;
				}
			}
		}
			var win=creatFirstWin(' ',360,280,'icon-search','/reimburse/overfulfil?standard='+num3+"&amount="+nums+"&applyAmount="+applyAmount1+"&sts="+flowStauts);
			win.window('open');
		}else{
	// 在后台反序列话成明细Json的对象集合
	
	$('#json1').val(jsonStr1);
	$('#json2').val(jsonStr2);
	$('#json3').val(jsonStr3);
	$('#json4').val(jsonStr4);
	$('#json5').val(jsonStr5);
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);


	var h = $("#reimburseTypeHi").textbox().textbox('getValue');
	
	//提交
	$('#reimburse_save_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				//如果校验通过，则进行下一步
				$.messager.progress();
			}else{
				//校验不通过，就打开第一个校验失败的手风琴
				openAccordion();
			}
			return flag;
		},
		url : base + '/reimburse/save',
		success : function(data) {
			 ;
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#reimburse_save_form').form('clear');
				$('#reimburseTab'+h).datagrid('reload');
				$('#indexdb').datagrid('reload');
				closeWindow();
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
		}
}





//寻找相关制度
function findSystemFile(id) {
	$.ajax({ 
		url: base+"/cheter/systemFind?id="+id, 
		success: function(data){
			data=data.replace('\"','');
			data=data.replace('\"','');
			window.open(data);
    }});
}


//打开借款单选择页面
function chooseJkd(){
	var win = creatFirstWin('借款单选择', 840, 450, 'icon-search', '/loan/choose?menuType=fromBxsq');
	win.window('open');
	cx();
}

		
</script>

</body>


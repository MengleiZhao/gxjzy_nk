<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<div  data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:755px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px">
			<div class="window-left-top-div">
				<form id="reimburse_check_form" method="post" style="height: 0px;" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
					<!-- 隐藏域 --> 
					<!-- 主键ID --><input type="hidden" name="rId" value="${bean.rId}" id="rId"/>
					<!-- 报销单号 --><input type="hidden" name="rCode" value="${bean.rCode}" id="rCode"/>
					<!-- 收款人主键ID --><input type="hidden" name="pId" value="${payeeBean.pId}"/>
					<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="reimburseFlowStauts" />
					<!-- 报销状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="reimburseStauts" />
					<!-- 下环节处理人姓名 --><input type="hidden" id="input_userName2" name="userName2" value="${bean.userName2}" />
					<!-- 下环节处理人编码 --><input type="hidden" name="fuserId" id="fuserId" value="${bean.fuserId}" />
					<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
					<!-- 报销类型 --><input type="hidden" id="reimburseTypeHi" value="${bean.type}"/>
					<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id=""/>
					<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id=""/>
					<!-- 报销类型 --><input type="hidden" name="type" value="${bean.type}" />
					<!-- 报销金额 --><input type="hidden" id="reimburseAmount" name="amount" value="${bean.amount}" />
					<!-- 审批结果 -->
		    		<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
		    		<!-- 审批意见 -->
				    <input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
				    <!-- 审批附件 -->
				    <input type="hidden" name="spjlFile" id="spjlFile" value=""/>
			 		<input type="hidden" id="applyAmount" name="applyAmount" value="${applyBean.amount}" />
				</form>
			 		<div class="tab-wrapper" id="reimburse-comminfo-add">
						<ul class="tab-menu">
							<li class="active" onclick="onclickcommset()">报销单</li>
							<li onclick="onclickcommsetdeatil()" >申请单</li>
						</ul>
						<div class="tab-content">
							<div title="报销单" style="margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
								<jsp:include page="../reimburse/reimburse_comm_onlydetail.jsp" />
							</div>
							<div title="申请单" style="overflow:auto;margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
								<jsp:include page="../reimburse/apply_comm_detail.jsp" />
							</div>
						</div>
					</div>
			</div>
			
			<div class="window-left-bottom-div">
				<a href="javascript:void(0)" onclick="openCheckWin('审批意见','1')">
					<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="openCheckWin('审批意见','0')">
					<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<%-- <c:if test="${bean.type==1 }">
					<a href="javascript:void(0)" onclick="openCheckWin('审批意见','2')">
						<img src="${base}/resource-modality/${themenurl}/button/tybzz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;
				</c:if> --%>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		<div class="window-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../../check_system.jsp" />
		</div>
	</div>
</div>
	
<script type="text/javascript">
flashtab('reimburse-comminfo-add');
//防止不停重新加载
var itineraryurlcount = 0;
function onclickcommset(){
	if(itineraryurlcount>0){
		itineraryurlcount+=1;
		return false;
	}else {
		itineraryurlcount+=1;
		$('#reimburse_itinerary_tab_id').datagrid('reload');
		return true;
	}
}
var detaiurlcount = 0;
function onclickcommsetdeatil(){
	if(detaiurlcount>=1){
		detaiurlcount+=1;
		return false;
	}else {
		detaiurlcount+=1;
		$('#check-history-dg-comm').datagrid('reload');
		$('#appli-detail-dg').datagrid('reload');
		return true;
	}
}
//冲销借款
function cx(){
	var num1=parseFloat($('#input_jkdamonut').val());
	var num2=parseFloat($('#reimburseAmount').val());
	var num3=parseFloat($('#applyAmount').val());
	if(isNaN(num1)&&!isNaN(num2)){
		 $('#skAccount').numberbox('setValue',num2);
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
	zzAmount();
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
	var win = creatFirstWin('借款单选择', 840, 550, 'icon-search', '/loan/choose?menuType=fromBxsq');
	win.window('open');
	cx();
}
//转账金额
function  zzAmount(){
	var num1=parseFloat($('#input_jkdamonut').val());
	var num2=parseFloat($('#reimburseAmount').val());
	var num3=parseFloat($('#applyAmount').val());
	if(isNaN(num1)){
		num1=0;
	}
	if(isNaN(num2)){
		num2=0;
	}
	if(isNaN(num3)){
		num3=0;
	}
	$("#skAccount").numberbox().numberbox('setValue',num1+num2);
}
function chooseUserid(){
	var win=creatSecondWin('选择归口部门',860,580,'icon-search','/user/chooseNextRole'); 
	win.window('open');
}
//审批
function check(result) {
	//$('#input_userName2').val($('#userName2').textbox('getValue'));//下级审批人名称
	
	var applyType = $('#reimburseTypeHi').val();
	/* if(1==applyType){
		//通用事项申请
		var userName2 = $('#userName2').textbox('getValue');
		if( result==1 && userName2==""){
			alert('请先选择下级审批人');
			return false;
		}
	} */
	$("#fcheckResult").val(result);
	$("#reimburseFlowStauts").val(result);
	var applyAmount1 = $("#applyAmount1").val();
	var nums = $("#nums").val();
	var num3 = $("#num3").val();
	if(result=='1' || result=='2'){
		if(parseFloat(nums)>parseFloat(num3)){
			var win=creatFirstWin(' ',360,280,'icon-search','/reimburse/overfulfils?standard='+num3+"&amount="+nums+"&applyAmount="+applyAmount1.toFixed(2)+"&sts="+result);
			win.window('open');
		}else{
		
		$('#reimburse_check_form').form('submit', {
			onSubmit : function() {
				
				/* flag = $(this).form('enableValidation').form('validate');
				if (flag) { */
					$.messager.progress();
				/* }
				return flag; */
			},
			url : base + '/reimburseCheck/checkResult',
			success : function(data) {
				
				/* if (flag) { */
					$.messager.progress('close');
				/* } */
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					$('#reimburse_check_form').form('clear');
					$('#reimburseCheckTab').datagrid('reload'); 
					$("#indexdb").datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
		
	}
	}else{
		$('#reimburse_check_form').form('submit', {
			onSubmit : function() {
				/* flag = $(this).form('enableValidation').form('validate');
				if (flag) { */
					$.messager.progress();
				/* }
				return flag; */
			},
			url : base + '/reimburseCheck/checkResult',
			success : function(data) {
					$.messager.progress('close');
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					$('#reimburse_check_form').form('clear');
					$('#reimburseCheckTab').datagrid('reload'); 
					$("#indexdb").datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
}
</script>
</body>


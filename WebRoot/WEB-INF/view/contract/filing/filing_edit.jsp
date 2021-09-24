<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="signinfo" action="${base}/Filing/otherSave" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true" style="width: 718px;">
			<div class="win-left-top-div" style="width: 718px;">
				<input type="hidden" name="fcId" id="F_fcId" value="${bean.fcId}"/>
	    		<input type="hidden" name="fUserName" id="F_fUserName" value="${bean.fUserName}"/>
	    		<input type="hidden" name="fUserCode" id="F_fUserCode" value="${bean.fUserCode}"/>
	    		<input type="hidden" name="fProCode" id="F_fProCode" value="${bean.fProCode}"/>
	    		<input type="hidden" name="fNCode" id="F_fNCode" value="${bean.fNCode}"/>
	    		<input type="hidden" name=fContStauts id="F_fContStauts" value="${bean.fContStauts}"/>
	    		<input type="hidden" name="fOperatorId" id="F_fOperatorId" value="${bean.fOperatorId}"/>
					<div class="tab-wrapper" id="contract-filling-edit">
						<ul class="tab-menu">
							<li class="active">合同信息</li>
							<li id="ss">签约方信息</li>
							<c:if test="${bean.fcType=='HTFL-01'}"><li onclick="$('#filing-edit-plan-dg').datagrid('reload')">付款计划</li></c:if>
							<!-- <li onclick="$('#check-history-dg').datagrid('reload')">审批记录</li> -->
						</ul>
						
						<div class="tab-content">
							<div title="合同信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
								<%@ include file="../base/contract-formulation-base2.jsp" %>
							</div>
							<div title="签约方信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
								<%@ include file="../base/contract-formulation-sign-base.jsp" %>
							</div>
							<c:if test="${bean.fcType=='HTFL-01'}">
								<div title="付款计划" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
									<%@ include file="../base/contract-filing-edit-plan.jsp" %>
								</div>
							</c:if>
							<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
								<jsp:include page="../../check_history.jsp" />												
							</div>
						</div>
				
					</div>
			</div>
			
			<div class="win-left-bottom-div">
				<c:if test="${openType=='Fadd'||openType=='Fedit'}">
					<a href="javascript:void(0)" <c:if test="${bean.fcType=='HTFL-01'}">onclick="filingEditForm();"</c:if> <c:if test="${bean.fcType!='HTFL-01'}">onclick="filingEditForm1();"</c:if>>
						<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
				</c:if>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<%-- <div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div> --%>
	</div>
</form>
</div>
<script type="text/javascript">
flashtab('contract-filling-edit');
var num=0;

$('#filing-edit-plan-dg').datagrid({
	onBeforeLoad : function (param){
		if(num>2){
			return false;
		}else{
			num=num+1;
			return true;
		}
	}
});
	
	$('#F_fcType').combobox({  
        onChange:function(newValue,oldValue){  
    	var sel2=$('#F_fcType').combobox('getValue');
    	if(sel2=="HTFL-01"){
    		$('#cg1').show();
    		$('#cg2').show();
    		//$('#cg2').hide();
    		//$('#F_fPurchNo').next(".textbox").show();
		}else{
    		$('#cg1').hide();
    		$('#cg2').hide();
    		//$('#cg2').show();
    		//$('#F_fPurchNo').next(".textbox").hide();
		} 
        }
    }); 
	function filingEditForm(){
		
		var f1= $('#htwbfiles').val();
		if(''==f1){
			alert('请上传合同文本!');
			return;
		}
	    var s="";
		$(".fileUrl1").each(function(){
			s=s+$(this).attr("id")+",";
		});
		$("#files1").val(s);
		var s1="";
		$(".fileUrl2").each(function(){
			s1=s1+$(this).attr("id")+",";
		});
		
		var type= $("#F_fcType").combobox('getValue');
		var signName= $("#f_fSignName").textbox('getValue');//签约方名称
		var signType= $("#finish_fSignType").combobox('getValue');//签约方类型
		var concUser= $("#f_fConcUser").textbox('getValue');//联系人
		var concTel= $("#f_fConcTel").numberbox('getValue');//联系电话
		var bankName= $("#f_fBankName").textbox('getValue');//开户银行
		var cardNo= $("#f_fCardNo").textbox('getValue');//银行账户
		$("#files2").val(s1);
		var plan = getPlan();
		if((''==plan||null==plan||'[]'==plan)&&type=='HTFL-01'){
			alert("请填写付款计划！");
		}else if(bankName==''||signName==''||signType==''||concUser==''||concTel==''||cardNo==''){
			alert("请填写完整签约方信息！");
		}else {
			
			var totalAmount=$("#totalAmount").val();
			var F_fcAmount=$("#F_fcAmount").val();
			if(parseFloat(totalAmount) !=parseFloat(F_fcAmount)){
				$.messager.alert('系统提示',"付款计划总金额应等于合同金额", 'info');
				return false;
			}
			//console.log($('#a_fFileSrc1').val());
	    	$('#signinfo').form('submit', {
					onSubmit:function(param){ 
						param.planJson=plan;
						flag=$(this).form('enableValidation').form('validate');
						if(flag){
							$.messager.progress();
						}
						return flag;
					}, 
					url:'${base}/Filing/otherSave',
					type:'post',
					/* data:{'fFileSrc':$('#a_fFileSrc').val()}, */
					success:function(data){
						if(flag){
							$.messager.progress('close');
						}
						data=eval("("+data+")");
						if(data.success){
							$.messager.alert('系统提示', data.info, 'info');
							closeWindow();
							$('#filing_dg').form('clear');
							$('#filing_dg').datagrid('reload'); 
						}else{
							$.messager.alert('系统提示', data.info, 'error');
							closeWindow();
							$('#filing_dg').form('clear');
						}
					} 
				});		
			}
		}
	
	
	
	function filingEditForm1(){
		var f1= $('#htwbfiles').val();
		if(''==f1){
			alert('请上传合同文本!');
			return;
		}
	    var s="";
		$(".fileUrl1").each(function(){
			s=s+$(this).attr("id")+",";
		});
		$("#files1").val(s);
		var s1="";
		$(".fileUrl2").each(function(){
			s1=s1+$(this).attr("id")+",";
		});
		$("#files2").val(s1);
		//console.log($('#a_fFileSrc1').val());
    	$('#signinfo').form('submit', {
				onSubmit:function(){ 
					
					flag=$(this).form('enableValidation').form('validate');
					if(flag){
						$.messager.progress();
					}
					return flag;
				}, 
				url:'${base}/Filing/otherSave',
				type:'post',
				/* data:{'fFileSrc':$('#a_fFileSrc').val()}, */
				success:function(data){
					if(flag){
						$.messager.progress('close');
					}
					data=eval("("+data+")");
					if(data.success){
						$.messager.alert('系统提示', data.info, 'info');
						closeWindow();
						$('#filing_dg').form('clear');
						$('#filing_dg').datagrid('reload'); 
					}else{
						$.messager.alert('系统提示', data.info, 'error');
						closeWindow();
						$('#filing_dg').form('clear');
					}
				} 
			});		
		}
	
		function fPurchNo_DC(){
			//var node=$('#filing_dg').datagrid('getSelected');
			var win=creatFirstWin('选择-采购订单号',750,550,'icon-add','/PurchaseApply/PurchNoList');
			win.window('open');
		}
		function quota_DC(){
			//var node=$('#filing_dg').datagrid('getSelected');
			var win=creatFirstWin('选择-预算指标编号',750,550,'icon-add','/BudgetIndexMgr/contract_list');
			win.window('open');
		}
		
	</script>
</body>
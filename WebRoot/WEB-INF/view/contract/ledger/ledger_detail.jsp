<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="apply_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="fcId" id="dispute_fcId" value="${bean.fcId}"/>
	    		<input type="hidden" name="fFlowStauts" id="dispute_fFlowStauts" value="${bean.fFlowStauts}"/>
	    		<input type="hidden" name="fContStauts" id="dispute_fContStauts" value="${bean.fContStauts}"/>
	    		<input type="hidden" name="fUserName" id="dispute_fUserName" value="${bean.fUserName}"/>
	    		<input type="hidden" name="fUserCode" id="dispute_fUserCode" value="${bean.fUserCode}"/>
	    		
	    		<div class="tab-wrapper" id="contract-ledger-detail">
						<ul class="tab-menu">
							<li class="active">合同信息</li>
							<li>签约方信息</li>
							<c:if test="${bean.fcType=='HTFL-01'}"><li onclick="$('#filing-edit-plan-dg').datagrid('reload')">付款计划</li></c:if>
							<c:if test="${!empty Upt.fContUptType}"><li onclick="$('#change-upt-datagrid').datagrid('reload')">变更表</li></c:if>
							<c:if test="${!empty dispute.fDisId||!empty dispute.fDisResult}"><li>纠纷表</li></c:if>
							<c:if test="${!empty goldPay.fPayAmount}"><li>退还表</li></c:if>
							<c:if test="${!empty end.fEndType}"><li>终止表</li></c:if>
							<li onclick="$('#check-history-dg').datagrid('reload')">审批记录</li>
						</ul>
						
						<div class="tab-content">
							<div title="合同信息" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'">
								<%@ include file="../base/contract-formulation-base2.jsp" %>
							</div>
							<div title="签约方信息" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'">
								<%@ include file="../base/contract-formulation-sign-base-detail.jsp" %>
							</div>
							<c:if test="${bean.fcType=='HTFL-01'}">
								<div title="付款计划" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
									<%@ include file="../base/contract-filing-edit-plan-detail.jsp" %>
								</div>
							</c:if>
							<c:if test="${!empty Upt.fContUptType}">
								<div title="变更表" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
									<%@ include file="../base/contract-change-base-detail.jsp" %>
								</div>
							</c:if>
							<c:if test="${!empty dispute.fDisId||!empty dispute.fDisResult}">
								<div title="纠纷信息" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
									<%@ include file="../base/contract-dispute-base-detail.jsp" %>
								</div>
							</c:if>
							<c:if test="${!empty goldPay.fPayAmount}">
								<div title="退还信息" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
									<%@ include file="../base/contract-goldpay-base-detail.jsp" %>
								</div>
							</c:if>
							<c:if test="${!empty end.fEndType}">
								<div title="合同终止" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
									<%@ include file="../base/contract-ending-base-detail.jsp" %>
								</div>
							</c:if>
							<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
								<jsp:include page="../../check_history.jsp" />												
							</div>
						</div>
				
					</div>
	    		
	    		
			
		
			</div>
			
			<div class="win-left-bottom-div">
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
flashtab('contract-ledger-detail');

	$(document).ready(function(){ 
		var id=$('#Upt_fId_U').val();
		if(id ==null||id==""){
			$("#acc").accordion().accordion('remove','变更表');
		}
	});
	/* $(function() {
		new TextMagnifier({
			inputElem : '.inputElem4',
			align : 'right',
			splitType : [ 3, 3, 3, 3, 3, 3, 3 ],
		});
	});	 */
	
	function disputeSaveForm(){
		
		/* var a = $(".file_U");
		var srcs;
	    for(var i=0;i<a.length;i++){
			if(i==0){
				srcs=a[i].text;
			}else{
				srcs =srcs+','+a[i].text;
			}
			$('#dispute_fi1').val(srcs);
	    }   
		 */
		var plan = getPlan();
    	$('#disputetInfo').form('submit', {
				onSubmit:function(param){ 
					param.planJson=plan;
					 flag=$(this).form('enableValidation').form('validate');
				}, 
				url:'${base}/Dispute/save',
				type:'post',
				/* data:{'fFileSrc':$('#dispute_fFileSrc').val()}, */
				success:function(data){
					if(flag){
						$.messager.progress('close');
					}
					data=eval("("+data+")");
					if(data.success){
						$.messager.alert('系统提示', data.info, 'info');
						closeWindow();
						$('#dispute_dg').form('clear');
						$('#dispute_dg').datagrid('reload'); 
					}else{
						$.messager.alert('系统提示', data.info, 'error');
						closeWindow();
						$('#dispute_dg').form('clear');
					}
				} 
			});		
		}
		function fPurchNo_DC(){
			//var node=$('#dispute_dg').datagrid('getSelected');
			var win=creatFirstWin('选择-采购订单号',750,550,'icon-add','/PurchaseApply/PurchNoList');
			win.window('open');
		}
		function quota_DC(){
			//var node=$('#dispute_dg').datagrid('getSelected');
			var win=creatFirstWin('选择-预算指标编号',750,550,'icon-add','/BudgetIndexMgr/contract_list');
			win.window('open');
		}
		var c =0;
		function upt_upFile() {
			/* console.log(document.getElementById("upt_fFileSrc1"));
			var src = getFilePath();
			alert(getFilePath()); */
			c ++;
			var src = $('#upt_fFileSrc1').val();
			/* var srcs =src+','+$('#upt_fi1').val();
			$('#upt_fi1').val(srcs); */
			$('#upt__f1').append("<div id='c"+c+"'><a href='#' class='file_U' style='color: #3f7f7f;font-weight: bold;'>"+src+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a style='color: red;' href='#' onclick='deleteF1(c"+c+")'>删除</a></div>");
		} 
		function deleteF1(val){
			var child=document.getElementById(val.id);
			child.parentNode.removeChild(child);
		}
	</script>
</body>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<form id="enforcing_add_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
<div class="win-div">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="fcId" id="dispute_fcId" value="${bean.fcId}"/>
	    		<input type="hidden" name="fFlowStauts" id="dispute_fFlowStauts" value="${bean.fFlowStauts}"/>
	    		<input type="hidden" name="fContStauts" id="dispute_fContStauts" value="${bean.fContStauts}"/>
	    		<input type="hidden" name="fUserName" id="dispute_fUserName" value="${bean.fUserName}"/>
	    		<input type="hidden" name="fUserCode" id="dispute_fUserCode" value="${bean.fUserCode}"/>
	    		<input type="hidden" name="fOperatorId" id="F_fOperatorId" value="${bean.fOperatorId}"/>
	    		<div class="tab-wrapper" id="contract-enforcing-add">
						<ul class="tab-menu">
							<li class="active">合同信息</li>
							<li>签约方信息</li>
							<li onclick="$('#filing-edit-plan-dg').datagrid('reload')">付款计划</li>
							<c:if test="${!empty Upt.fContUptType}"><li onclick="$('#change-upt-datagrid').datagrid('reload')">变更表</li></c:if>
							<c:if test="${!empty dispute.fDisId||!empty dispute.fDisResult}"><li>纠纷信息</li></c:if>
							<li>付款信息</li>
							<%-- <c:if test="${!empty archiving.fToPosition}"><li>归档位置</li></c:if> --%>
							<c:if test="${checkHistory=='1'}"><li onclick="$('#appli-detail-dg-cont').datagrid('reload')">审批记录</li></c:if>
						</ul>
						
						<div class="tab-content">
							<div title="合同信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
								<%@ include file="../base/contract-formulation-base.jsp" %>
							</div>
							<div title="签约方信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
								<%@ include file="../base/contract-formulation-sign-base.jsp" %>
							</div>
							<div title="付款计划" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
								<%@ include file="../base/contract-filing-edit-plan.jsp" %>
							</div>
							<c:if test="${!empty Upt.fContUptType}">
								<div title="变更表" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
									<%@ include file="../base/contract-change-base.jsp" %>
								</div>
							</c:if>
							<c:if test="${!empty dispute.fDisId||!empty dispute.fDisResult}">
								<div title="纠纷信息" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
									<%@ include file="../base/contract-dispute-base.jsp" %>
								</div>
							</c:if>
							<div title="付款信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
								<table cellpadding="0" cellspacing="0" class="ourtable" style="margin-left: 20px">
									<tr class="trbody">
										<td class="td1" >付款名称</td>
										<td>
											<input id=""  class="easyui-textbox" readonly="readonly"  name="" style="width: 150px;" value="${payBean.fRecStage}"/>
										</td>
										<td class="td4">
											<input hidden="hidden" id="F_stauts" name ="stauts">
											<input hidden="hidden" id="F_flowStauts" name ="flowStauts">
											<input hidden="hidden" value="${contBean.payId}" name="payId">
											<input type="hidden" name="payCode" id="F_payCodeId" value="${contBean.payCode}"/>
										</td>
										<td class="td1" >计划付款时间</td>
										<td>
											<input id=""  class="easyui-datebox" readonly="readonly"  name="" style="width: 150px;" value="${payBean.fRecePlanTime}"/>
										</td>
									</tr>
								
									<tr class="trbody">
										<td class="td1" >计划付款金额</td>
										<td>
											<input  class="easyui-textbox" readonly="readonly"  name="" style="width: 150px;" value="${payBean.fRecePlanAmount}"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1" >是否达到付款条件</td>
										<td>
											<input checked="checked" type="radio" value="1" name="outCheckResult"/>是
											<input type="radio" value="0" name="outCheckResult"/>否
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1" >实际付款金额</td>
										<td colspan="4">
											<input id=""  class="easyui-numberbox" data-options="validType:'length[1,20]',icons: [{iconCls:'icon-yuan'}],precision:2"  name="fReceAmount" style="width: 150px;" value="${payBean.fRecePlanAmount}"/>
										</td>
									</tr>
									<tr class="trbody">
											<td class="td1">
												附件
												<input type="file" multiple="multiple" id="fhtzx" onchange="upladFileParams(this,'fhtzx','htgl01','progressNumberhtbgfhtzx','percentfhtzx','tdfhtzx','fhtzxFiles','progidfhtzx')" hidden="hidden">
												<input type="text" id="fhtzxFiles" name="fhtzxFiles" hidden="hidden">
											</td>
											<td colspan="4" id="tdfhtzx">
												<c:if test="${openType=='add'||openType=='edit'}">
												<a onclick="$('#fhtzx').click()" style="font-weight: bold;" href="#">
													<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
												</a>
												</c:if>
												<div id="progidfhtzx" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
												<div id="progressNumberhtbgfhtzx" style="background:#3AF960;width:0px;height:10px" >
												</div>文件上传中...&nbsp;&nbsp;<font id="percentfhtzx">0%</font></div></br>
												<c:forEach items="${enforciongAttaList}" var="att">
													<c:if test="${att.serviceType=='fhtzx' }">
														<div style="margin-top: 10px;">
														<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
														&nbsp;&nbsp;&nbsp;&nbsp;
														<c:if test="${openType=='add'||openType=='edit'}">
														<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
														&nbsp;&nbsp;&nbsp;&nbsp;
															<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
														</c:if>
														</div>
													</c:if>
												</c:forEach>
											</td>
										</tr>
								</table>
							</div>
							<c:if test="${checkHistory=='1'}">
							<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
								<jsp:include page="../../check_history.jsp" />												
							</div>
							</c:if>
						</div>
				
					</div>
			</div>
			
			<div class="win-left-bottom-div">
				<c:if test="${openType=='add'||openType=='edit'}">
					<a href="javascript:void(0)" onclick="saveEnforcing('${payBean.fPlanId}')">
						<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;
				</c:if>
				<a href="javascript:void(0)" onclick="closeFirstWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div>
	</div>
</div>
</form>
<script type="text/javascript">
	
flashtab('contract-enforcing-add');	
	
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
	
	//保存申请信息
	function saveEnforcing(fPlanId){
		$('#F_flowStauts').val(1);
		$('#F_stauts').val(1);
    	$('#enforcing_add_form').form('submit', {
				onSubmit:function(param){ 
	//				param.planJson=plan;
					flag=$(this).form('enableValidation').form('validate');
					if(flag){
						$.messager.progress();
					}
					return flag;
				}, 
				url:'${base}/Enforcing/save?fPlanId='+fPlanId,
				type:'post',
				success:function(data){
					if(flag){
						$.messager.progress('close');
					}
					data=eval("("+data+")");
					
					if(data.success){
						$.messager.alert('系统提示', data.info, 'info');
						$('#enforcing_plan_dg').datagrid('reload'); 
						$('#enforcing_add_form').form('clear');
						$("#indexdb").datagrid('reload');
						closeFirstWindow();
						closeWindow();
					}else{
						$.messager.alert('系统提示', data.info, 'error');
						$('#enforcing_add_form').form('clear');
						closeFirstWindow();
					}
				} 
			});		
		}
		function fPurchNo_DC(){
			//var node=$('#c_c_dg').datagrid('getSelected');
			var win=creatFirstWin('选择-采购订单号',750,550,'icon-add','/PurchaseApply/PurchNoList');
			win.window('open');
		}
		function quota_DC(){
			//var node=$('#c_c_dg').datagrid('getSelected');
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
		//时间格式化
		function ChangeDateFormat(val) {
			//alert(val)
			var t, y, m, d, h, i, s;
			if (val == null) {
				return "";
			}
			t = new Date(val)
			y = t.getFullYear();
			m = t.getMonth() + 1;
			d = t.getDate();
			h = t.getHours();
			i = t.getMinutes();
			s = t.getSeconds();
			// 可根据需要在这里定义时间格式  
			return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
		}
	</script>
</body>
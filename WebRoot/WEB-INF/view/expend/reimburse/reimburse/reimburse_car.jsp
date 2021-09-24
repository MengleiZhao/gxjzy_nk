<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div  data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:755px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px">
			<div class="window-left-top-div">
				<form id="reimburse_save_form" style="height: 0px;" method="post"  enctype="multipart/form-data">
				<!-- 隐藏域 --> 
				<!-- 主键ID --><input type="hidden" name="rId" value="${bean.rId}" id="rId"/>
				<!-- 申请单流水号 --><input type="hidden" name="gCode"<c:if test="${operation=='add' }">value="${applyBean.gCode}"</c:if><c:if test="${operation=='edit' }">value="${bean.gCode}"</c:if> />
				<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="reimburseFlowStauts" />
				<!-- 报销状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="reimburseStauts" />
				<%-- <!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
				<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" /> --%>
				<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
				<!-- 报销类型 --><input type="hidden" id="reimburseTypeHi" value="${bean.type}" name="type"/>
				<!-- 报销金额 --><input type="hidden" id="reimburseAmount" name="amount" <c:if test="${operation=='edit' }">value="${bean.amount}"</c:if><c:if test="${operation=='add'}">value="${applyBean.amount}"</c:if> />
				<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id=""/>
				<!-- 预算指标名称 --><input type="hidden" id="indexName" name="indexName" value="${bean.indexName}" />
				<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="indexType"/>
				<!-- 报销人 --><input type="hidden" name="userName" value="${bean.userName}" id="input_userName"/>
				<!-- 报销部门 --><input type="hidden" name=deptName value="${bean.deptName}" id="input_deptName"/>
				<!-- 项目支出明细ID --><input type="hidden" name="proDetailId" <c:if test="${operation=='edit' }">value="${bean.proDetailId}"</c:if><c:if test="${operation=='add'}">value="${applyBean.proDetailId}"</c:if> id="proDetailId"/>
				<!-- 摘要 --><input type="hidden" id="gName" name="gName" <c:if test="${operation=='edit' }">value="${bean.gName}"</c:if><c:if test="${operation=='add'}">value="${applyBean.gName}"</c:if> />
				<!-- 是否有冲销借款 --><input type="hidden" name="withLoan" value="${bean.withLoan}" id="withLoan"/>
				<!-- 是否调整 --><input type="hidden" name="fupdateStatus" value="${bean.fupdateStatus}" id="fupdateStatusid"/>
				<!-- 调整说明 --><input type="hidden" name="fupdateReason" value="${bean.fupdateReason}" id="fupdateReason"/>
				<!-- 调整说明 --><input type="hidden" name="reimburseReason" <c:if test="${operation=='edit' }"> value="${bean.reimburseReason}"</c:if><c:if test="${operation=='add'}"> value="${applyBean.reason}"</c:if>  id="reimburseReason"/>
				<input id="input_jkdid" hidden="hidden" value="${bean.loan.lId}" name="loan.lId"/>
				<input id="input_jkdamonut" value="${bean.loan.lAmount}" hidden="hidden"  />
				<input type="hidden" id="applyAmount" name="applyAmount" value="${applyBean.amount}" />
				<!-- 冲销金额 -->
				<input id="cxAmounts" value="${bean.cxAmount}" name="cxAmount" hidden="hidden"  />
				<input type="hidden" id="arry" name="arry" value="" />
				<!-- 费用明细json -->
				<input type="hidden" id="reimburseCartJson" name="reimburseCartJson"/>
				<!-- 收款人json -->
				<input type="hidden" id="payerinfoJson" name="payerinfoJson"/>
				<!-- 转账金额 -->
				<input type="hidden" id="payeeAmount"/>
				<!-- 应转账金额转账金额 -->
				<input type="hidden" id="skAmount"/>
				<!-- 附件信息 -->
				<input type="text" id="files" name="files" hidden="hidden">
				</form>
					<div class="tab-wrapper" id="reimburse-carinfo-add">
						<ul class="tab-menu">
							<li class="active" onclick="onclickreimburset()">报销单</li>
							<li onclick="onclickdetail()" >申请单</li>
						</ul>
						<div class="tab-content">
							<div title="报销单" style="margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
								<jsp:include page="reimburse_carinfo.jsp" />
							</div>
							<div title="申请单" style="overflow:auto;margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
								<jsp:include page="apply_carinfo_detail.jsp" />
							</div>
						</div>
					</div>
			</div>
			
			<div class="window-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveReimburse(0)">
					<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveReimburse(1)">
					<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
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
flashtab('reimburse-carinfo-add');
var itineraryurlcount = 0;
function onclickreimburset(){
	if(itineraryurlcount>0){
		itineraryurlcount+=1;
		return false;
	}else {
		itineraryurlcount+=1;
		$('#reimburse_cart').datagrid('reload');
		/* $('#reimburse_itinerary_tab_id').datagrid('reload');
		$('#reimbursein_city_tab_id').datagrid('reload');
		$('#reimbursein_hoteltab').datagrid('reload');
		$('#reimbursein_foodtab').datagrid('reload');
		$('#payer_info_tab').datagrid('reload'); */
		return true;
	}
}
var detaiurlcount = 0;
function onclickdetail(){
	if(detaiurlcount>=1){
		detaiurlcount+=1;
		return false;
	}else {
		detaiurlcount+=1;
		$('#apply_cart').datagrid('reload');
		/* $('#tracel_itinerary_tab_id_detail').datagrid('reload');
		$('#outside_traffic_tab_id_detail').datagrid('reload');
		$('#hoteltab_detail').datagrid('reload');
		$('#foodtab_detail').datagrid('reload'); */
		return true;
	}
}
</script>

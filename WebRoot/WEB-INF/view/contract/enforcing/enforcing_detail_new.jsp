<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div  data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:755px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px">
			<div class="window-left-top-div">
				<div class="tab-wrapper" id="reimburse-contract-detail">
					<ul class="tab-menu">
						<li class="active" onclick="onclickreimburset()">付款内容</li>
						<li onclick="fcTypeOnClik()" >原合同信息</li>
						<c:if test="${bean.fUpdateStatus==1 }"><li onclick="onclickUpt()" >变更合同信息</li></c:if>
					</ul>
					<div class="tab-content">
						<div title="付款内容" style="margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="enforcing_detail_base.jsp" />
						</div>
						<div title="原合同信息"  style="margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="../formulation/formulation_detail_base.jsp" /> 
						</div>
						<c:if test="${bean.fUpdateStatus==1 }">
						<div title="变更合同信息"  style="margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
							<%@ include file="../base/contract-change-base-detail.jsp" %>
						</div>
						</c:if>
					</div>
				</div>
			</div>
			
			<div class="window-left-bottom-div">
				<a href="javascript:void(0)" onclick="closeFirstWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=支出管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		<div class="window-right-div" data-options="region:'east',split:true">
				<jsp:include page="../../check_system.jsp" />
		</div>
	</div>
</div>

<script type="text/javascript">
flashtab('reimburse-contract-detail');

//防止不停重新加载
var itineraryurlcount = 0;
function onclickreimburset(){
	if(itineraryurlcount>0){
		itineraryurlcount+=1;
		return false;
	}else {
		itineraryurlcount+=1;
		$('#check-history-dg').datagrid('reload');
		return true;
	}
}
var detaiurlcount = 0;
function onclickchange(){
	if(detaiurlcount>=1){
		detaiurlcount+=1;
		return false;
	}else {
		detaiurlcount+=1;
		$('#contract-cgconfig-detail-dg').datagrid('reload');
		$('#change-plan-detail-dg').datagrid('reload');
		return true;
	}
}
var detaiurlcount1 = 0;
function onclickcontract(){
	if(detaiurlcount1>=1){
		detaiurlcount1+=1;
		return false;
	}else {
		detaiurlcount1+=1;
		fcTypeOnClik();
		$('#filing-edit-plan-dg-detail').datagrid('reload');
		$('#plan_contract_dg_detail').datagrid('reload');
		return true;
	}
}
</script>

</body>


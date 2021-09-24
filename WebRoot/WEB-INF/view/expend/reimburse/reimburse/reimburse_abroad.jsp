<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<div  data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:755px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="window-left-top-div">
				<div class="tab-wrapper" id="reimburse-abroad-add">
					<ul class="tab-menu">
						<li class="active" onclick="onclickreimburset()">报销单</li>
						<li onclick="onclickdetail()" >申请单</li>
					</ul>
					<div class="tab-content">
						<div title="报销单" style="width: 737px" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="reimburse_abroadInfo.jsp" />
						</div>
						<div title="申请单" style="margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="apply_detail_abroad.jsp" />
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
flashtab('reimburse-abroad-add');

//防止不停重新加载
var abroadcount = 0;
function onclickreimburset(){
	if(abroadcount>0){
		abroadcount+=1;
		return false;
	}else {
		abroadcount+=1;
		$('#abroad-person-dg').datagrid('reload');
		$('#abroad-plan-dg-reim').datagrid('reload');
		$('#international_traveling_expense_id-reim').datagrid('reload');
		$('#apply_outside_traffic_tab_id-reim').datagrid('reload');
		$('#hoteltabApply-reim').datagrid('reload');
		$('#foodtab-reim').datagrid('reload');
		$('#rec-fee-dg-reim').datagrid('reload');
		$('#rec-fete-dg-reim').datagrid('reload');
		$('#rec-other-dg-reim').datagrid('reload');
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
		$('#apply_expense_detail_tab_id').datagrid('reload');
		$('#abroad-person-detail-dg').datagrid('reload');
		$('#abroad-plan-dg').datagrid('reload');
		$('#travel-way-dg').datagrid('reload');
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
</script>
</body>
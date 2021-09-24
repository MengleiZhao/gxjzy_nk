<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="apply_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="tab-wrapper" id="contract-expiration-detail">
						<ul class="tab-menu">
							<li class="active">合同信息</li>
							<li>签约方信息</li>
							<c:if test="${bean.fcType=='HTFL-01'}"><li onclick="$('#filing-edit-plan-dg').datagrid('reload')">付款计划</li></c:if>
							<c:if test="${!empty Upt.fContUptType}"><li onclick="$('#change-upt-datagrid').datagrid('reload')">变更表</li></c:if>
							<c:if test="${!empty dispute.fDisId||!empty dispute.fDisResult}"><li>纠纷信息</li></c:if>
							<%-- <c:if test="${!empty archiving.fToPosition}"><li>归档位置</li></c:if> --%>
							<c:if test="${!empty goldPay.fPayAmount}"><li>退还信息</li></c:if>
							<li onclick="$('#check-history-dg').datagrid('reload')">审批记录</li>
						</ul>
						
						<div class="tab-content">
							<div title="合同信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
								<%@ include file="../base/contract-formulation-base2.jsp" %>
							</div>
							<div title="签约方信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
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
							<%-- <c:if test="${!empty archiving.fToPosition}">
								<div title="归档位置" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
									<%@ include file="../base/contract-archiving-base.jsp" %>
								</div>
							</c:if> --%>
							<c:if test="${!empty goldPay.fPayAmount}">
								<div title="退还信息" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
									<%@ include file="../base/contract-goldpay-base-detail.jsp" %>
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
flashtab('contract-expiration-detail');
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
		//时间格式化
		function ChangeDateFormat1(val) {
			//alert(val)
		    var t, y, m, d, h, i, s;
		    if(val==null){
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
		    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) + ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i) + ':' + (s < 10 ? '0' + s : s);
		}
	</script>
</body>
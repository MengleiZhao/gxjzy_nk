<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<style type="text/css">
 /* 边框样式 */
.datagrid-body td{
  border-bottom: 1px dashed #ccc;
  border-right: 1px dashed #ccc;
}
.datagrid-htable tr td{
	border-right: 1px solid #fff;
	border-bottom: 1px solid #fff;
}	
}
.datagrid-footer td{
 border-bottom: 1px dashed #ccc;
  border-right: 1px dashed #ccc;
}
.datagrid-footer tr td{
border-right: 1px dashed #ccc;
	border-bottom: 1px dashed #ccc;
	color: red
}
</style>
<div class="win-div">
<form id="voucherDetailFrom" action="" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;width: 1035px">
		<div class="win-left-div" data-options="region:'west',split:true"  style="width: 1035px">
			<div class="win-left-top-div" style="width: 1035px">
				<input type="hidden" name="fid" id="fid" value="${bean.fid}"/>
				<div class="easyui-accordion" style="width:1010px;margin-left: 15px;">
					<div title="" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
						<table class="ourtable" cellpadding="0" cellspacing="0" style="width: 1000px">
							<tr class="trbody">
								<td colspan="6">
									<h6 style="margin-left:47%;font-size: 18px" >记账凭证</h6>
								</td>								
							</tr>
							<tr class="trbody">
								<td style="width: 60px">&nbsp;凭证号：</td>
								<td>
									<span>${bean.fVoucher}</span>
								</td>
								<td style="width: 400px">&nbsp;</td>
								<td style="width: 90px;text-align: right;">&nbsp;&nbsp;生成日期：</td>
								<td style="width: 80px;text-align: right;">
									<span id="v_createTime">${bean.createTime}</span>
								</td>
							</tr>
						</table>	
					</div>
					<div title="" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:0px;">
			        	<%@ include file="voucher_detail_plan.jsp" %>
					</div>
					<%-- <div title="" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
						<table class="ourtable" cellpadding="0" cellspacing="0" >
							<tr style="height: 20px">
								<td style="width: 120px"><span style="font-weight: bold;">合计借方金额(元)：</span></td>
								<td >
									<span>${bean.fDebitAllAMount}</span>
								</td>
							</tr>
							<tr style="height: 20px">
								<td ><span style="font-weight: bold;">合计贷方金额(元)：</span></td>
								<td>
									<span id="v_createTime">${bean.fCreditAllAmoount}</span>
								</td>
							</tr>
					</table>
					</div> --%>
				</div>			
			</div>
			<div class="win-left-bottom-div">
				<c:if test="${openType=='add'||openType=='edit'}">
					<a href="javascript:void(0)" onclick="voucherDetailFrom();">
						<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="ReceLowFormSS()">
						<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
				</c:if>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<%-- <a href="${base }/systemcentergl/list?typeStr=资产管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a> --%>
			</div>
		</div>
	</div>
</form>
</div>
<script type="text/javascript">
$(function(){
	$('#v_createTime').html(ChangeDateFormat($('#v_createTime').html()));
});


//时间格式化
function ChangeDateFormat(val) {
	var t, y, m, d, h, i, s;
	if (val == null) {
		return "";
	}
	t = new Date(val);
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
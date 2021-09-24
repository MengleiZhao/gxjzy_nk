<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<style type="text/css">
.panel-header{
	height: 20px;
}
</style>
<form id="bid_detail_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 10px;">
			<div class="win-left-top-div">
				<div class="tab-wrapper" id="yx-tab">
					<ul class="tab-menu" >
						<li class="active">过程登记</li>
					    <li onclick="onclick_cggl_detail()">采购申请</li>
					</ul>
					<div class="tab-content">
						<div title="中标登记" style="margin-bottom:35px;width: 737px" >
							<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
								<!--第1个div  -->
								<div title="供应商信息"  id="gysxxdiv"  data-options="collapsed:false,collapsible:false" style="overflow:auto;">
									<jsp:include page="course_gys_detail.jsp" />
								</div>
							</div>
						</div>
					
						<div title="采购申请" style="margin-bottom:35px;width: 737px" >
							<%@ include file="../purchase/cggl_detail_base.jsp" %>
						</div>
					</div>
				</div>
			</div>
			
			<div class="window-left-bottom-div" style="margin-top: 55px;">
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	</div>
</form>
</div>
<script type="text/javascript">
//加载tab页
flashtab('yx-tab');

var cggl_detailcount = 0;
function onclick_cggl_detail(){
	if(cggl_detailcount>=1){
		detaiurlcount+=1;
		return false;
	}else {
		cggl_detailcount+=1;
		$('#plan_dg').datagrid('reload'); 
		$('#check-history-dg-cg').datagrid('reload'); 
		return true;
	}
}

//合同详情
function detail(id) {
	var win = creatWin('合同拟定申请', 970, 580, 'icon-search', '/Formulation/detail/'+id);
	win.window('open');
}
</script>
</body>
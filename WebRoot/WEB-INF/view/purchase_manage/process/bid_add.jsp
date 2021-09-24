<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 10px;">
			
				<div class="win-left-top-div">
					<div class="tab-wrapper" id="yx-tab">
						<ul class="tab-menu">
							<li class="active" >中标登记</li>
						    <li onclick="onclickCGSQDetail()">采购申请</li>
						</ul>
						<div class="tab-content">
								<div title="中标登记" style="margin-bottom:35px;width: 740px"  >
									<div class="easyui-accordion" style="margin-right: 20px;">
										<!--第1个div  -->
										<div title="供应商信息"  id="gysxxdiv" data-options="collapsed:false,collapsible:false" style="overflow:hidden;">
											<jsp:include page="course_gys.jsp" />
										</div>
									</div>
									<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
										<div title="采购结果"  id="cgjgdiv" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
											<jsp:include page="course_gys_plan_mingxi.jsp" />
										</div>
									</div> --%>
								</div>
							<div title="采购申请" style="margin-bottom:35px;width: 737px" >
								<!-- 第3个div -->
								<jsp:include page="../purchase/cggl_detail_base.jsp" />
							</div>
						</div>
					</div>
				</div>	
			
			<div class="window-left-bottom-div" style="margin-top: 55px;">
				<a href="javascript:void(0)" onclick="saveBid(2)">
					<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveBid(1)">
					<img src="${base}/resource-modality/${themenurl}/button/tijiao1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
			</div>
		</div>
	</div>
<script type="text/javascript">
//加载tab页
flashtab('yx-tab');
	
//保存
function saveBid(status) {
	
	var jsonStr1 = $("#supplierForm").serializeJson();
	
	$('#json1').val(jsonStr1);
	if(jsonStr1 == null || jsonStr1 == ''){
		alert("请填写供应商信息！");
		return;
	}
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){	
		s=s+$(this).attr("id")+",";
	});
	if(s==""){
		alert("请上传附件！");
		return;
	}
	$("#files").val(s);
	//提交
	$('#bid_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}else {
				//校验不通过，就打开第一个校验失败的手风琴
				openAccordion();
			}
			return flag;
		},
		url : base + '/cgprocess/save?fbidStauts='+status,
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				 $('#course_regist_div').datagrid('reload');
				 closeWindow();
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
}
var urlcountCGSQ = 0;
function onclickCGSQDetail(){
	if(urlcountCGSQ>=1){
		urlcountCGSQ+=1;
		return false;
	}else {
		urlcountCGSQ+=1;
		$('#plan_dg').datagrid('reload');
		$('#check-history-dg-cg').datagrid('reload');
		return true;
	}
}
</script>
</body>
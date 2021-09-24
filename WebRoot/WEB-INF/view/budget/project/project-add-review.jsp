<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<style>
select{width: 200px}
</style>


<body>
<div class="win-div">
<form id="project_add_form_review" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 559px;">
		<div style="width: 1065px" class="win-left-div-ys" data-options="region:'west',split:true">
			<div class="win-left-top-div-ys">
				<div class="tab-wrapper" id="project-detail-tab">
					<ul class="tab-menu">
						<li class="active">项目信息</li>
						<li class="FProAccording">立项依据</li>
						<li class="FExplain" >项目实施方案</li>
						<li onclick="onClickOutcomeDetail()" >项目支出明细（测算过程）</li>
						<li onclick="onClickJXMBDetail()" >绩效目标申报</li>
						<c:if test="${bean.fprocurementStatus=='1'}">
						<li onclick="onClickZfDetail()" ">政府采购明细表</li>
						</c:if>
						<c:if test="${bean.ifInvolveNetworkSoftware=='1'}">
						<li onclick="onClickZfSEDetail()" ">信息及软件采购明细表</li>
						</c:if>
						<li onclick="$('#check-history-dg').datagrid('reload')">审批记录</li>
					</ul>
					
					<div class="tab-content" style="width: 1045px">
						<div title="项目信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						   	<%@ include file="project-detail-base-review.jsp" %>
						</div> 
						 
						<div title="立项依据" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						   	<%@ include file="../project/detail/project-detail-lxyj.jsp" %>
						</div> 
						
						<div title="项目实施方案" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						    <%@ include file="../project/detail/project-detail-xmssfa.jsp" %>
						</div> 
						
						<div title="项目支出明细" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							<%@ include file="../project/detail/project-detail-outcome.jsp" %>
						</div> 
												 	
						<div title="绩效目标申报表" data-options="iconCls:'icon-xxlb'" style="margin-bottom:35px;">
							<jsp:include page="../project/detail/project-detail-performance.jsp" />
						</div>
						<c:if test="${bean.fprocurementStatus=='1'}">
						<div title="政府采购明细表" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="../project/detail/project-detail-procurement.jsp" />
						</div> 
						</c:if>
						<c:if test="${bean.ifInvolveNetworkSoftware=='1'}">
						<div title="政府采购明细表（信息网络及软件购置更新）" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="../project/detail/project-detail-procurement_SE.jsp" />
						</div> 
						</c:if>						
						<div title="审批记录"  style="overflow-x:hidden;margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						 	<%@ include file="../project/project-add-history.jsp" %>
						</div>
					</div>
			
				</div>
			</div>
			
			<div class="win-left-bottom-div-ys">
				<a href="javascript:void(0)" onclick="saveProject()">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png"
						onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/baocun2.png')"
						onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/baocun1.png')"
					/>
				</a>
				&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png"
						onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/guanbi2.png')"
						onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/guanbi1.png')"
					/>
				</a>
			</div>
		</div>
	</div>
</form>
</div>
<script type="text/javascript">
	flashtab('project-detail-tab');
	
	function validateProjectAdd(stepName){
		if(stepName=='项目基本信息'){
			return validateProjectAddBase();
		} else if(stepName=''){
			
		}
		return true;
	}
	
	function validateProjectAddBase(){
		//验证项目属性
		if ($('#project_add_FProName').textbox('getValue')==''){
			alert('请填写项目名称！');
			return false;
		} else if ($('#pro_add_FProBudgetAmount').numberbox('getValue')=='') {
			alert('请填写项目预算金额！');
			return false;
		}  else if ($("input[name='FProcurementYn']:checked").val()==undefined) {
			alert('请选择是否采购！');
			return false;
		} else if ($('#project_add_FProClass').combobox('getValue')=='') {
			alert('请选择项目类别！');
			return false;
		} else if($("input[name='FProcurementYn']:checked").val()==1 && isNaN(parseInt($('#input_cgje').numberbox('getValue'))) ){
			alert('请填写采购金额！');
			return false;
		}
		
		return true;
	}
	
	//验证预算总额 = 采购金额 + 支出总额
	function validateProMoney(){
		
		var num1 = $('#pro_add_FProBudgetAmount').numberbox('getValue');
		
		var num2 = 0;
		var cg=true;
		if($("input[name='FProcurementYn']:checked").val()==1){
			num2 = $('#input_cgje').numberbox('getValue');	
		}else{
			cg=false;
		}
		
		$('#project-add-outcome-treegrid').datagrid('acceptChanges');
		var num3 = updateRow_pro_total();
		
		if(parseInt(num1) != parseInt(num2) + parseInt(num3)){
			if(cg==true){
				alert("请确保 '项目预算金额' 等于 '采购金额' 和 '项目支出明细总额 ' 之和！");
			}else{
				alert("请确保 '项目预算金额' 等于 '项目支出明细总额 '！");
			}
			return false;
		}
		return true;
	}
	
	//保存 saveType,暂存zc，申报sb
	function saveProject(){
		$('#project_add_form_review').form('submit', {
   				onSubmit: function(param){
   					$.messager.progress();
   				}, 
   				url:base+'/projectReview/saveReviewBigProName', 
   				success:function(data){
 					$.messager.progress('close');
   					data=eval("("+data+")");
   					if(data.success){
   						$.messager.alert('系统提示', data.info, 'info');
   						closeWindow();
   						$('#project_add_form_review').form('clear');
   						clearProList('project-review-table');
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   					}
   				} 
   			});		
	}
	
	//项目申报页面导出
	function proExport(){
		var id = $('#F_fProId').val();
		window.location.href = base + "/project/proExport?id=" + id;
	}
	
	//审批修改记录
	function updRecord(){
		var proId = $('#F_fProId').val();
		var win = creatFirstWin('修改记录', 700, 500, 'icon-search', '/project/checkUpdateRecord?id='+proId);
		win.window('open');
	}
	
	var jxmbcountDetail = 0;
	function onClickJXMBDetail(){
		
		if(jxmbcountDetail>=1){
			jxmbcountDetail+=1;
			return false;
		}else {
			jxmbcountDetail+=1;
			$('#mingxiJXMBDetail').css('display','');
			$.parser.parse('#mingxiJXMBDetail');
			$('#performanceDetail').datagrid('reload');
			return true;
		}
	}
	var proOutcomeCountDetail = 0;
	function onClickOutcomeDetail(){
		
		if(proOutcomeCountDetail>=1){
			proOutcomeCountDetail+=1;
			return false;
		}else {
			proOutcomeCountDetail+=1;
			$('#proOutcomeIdDetail').css('display','');
			$.parser.parse('#proOutcomeIdDetail');
			$('#pro_outcomes_table_id').datagrid('reload');
			return true;
		}
	}
	
	var ZfcountDetail = 0; 
	function onClickZfDetail(){
		
		if(ZfcountDetail>=1){
			ZfcountDetail+=1;
			return false;
		}else{
			ZfcountDetail+=1;
			setTimeout(function (){
			$.parser.parse('#mingxiProIdDetail');
			}, 500);
			$('#purManyYearsProTabDetailId').datagrid('reload');
			return true;
		}
	}
	
	var ZfSEcountDetail = 0; 
	function onClickZfSEDetail(){
		
		if(ZfSEcountDetail>=1){
			ZfSEcountDetail+=1;
			return false;
		}else {
			ZfSEcountDetail+=1;
			setTimeout(function (){
				$.parser.parse('#mingxiProIdSEDetail');
			}, 500);
			$('#purManyYearsProTabSEId').datagrid('reload');
			return true;
		}
	}

	
</script>
</body>
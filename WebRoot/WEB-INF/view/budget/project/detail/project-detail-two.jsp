<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<style>
select{width: 200px}
</style>


<body>
<div class="win-div">
<form id="project_add_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 559px;">
		<div class="win-left-div-ys" data-options="region:'west',split:true">
			<div class="win-left-top-div-ys">
				<div class="tab-wrapper" id="project-detail-tab">
					<ul class="tab-menu">
						<li class="active">基本支出信息</li>
						<li onclick="$('#pro_outcomes_detail_table').datagrid('reload')">基本支出明细（测算过程）</li>
						<c:if test="${bean.fprocurementStatus=='1'}">
						<li onclick="$.parser.parse('#mingxiPurId');$('#pro_purchase_detail_tab_id').datagrid('reload');$('#purManyYearsProTabDetailId').datagrid('reload')">政府采购明细</li>
						</c:if>
						<li onclick="$('#check-history-dg').datagrid('reload')">审批记录</li>
					</ul>
					
					<div class="tab-content">
						<div title="基本支出信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						   	<%@ include file="project-detail-base-two.jsp" %>
						</div> 
						 	
						<div title="基本支出明细" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							<%@ include file="project-detail-outcome-two.jsp" %>
						</div>
						
						<c:if test="${bean.fprocurementStatus=='1'}">
 						<div id="mingxiPurId" title="政府采购明细表" style="margin-bottom:35px;width: 860px" data-options="iconCls:'icon-xxlb'">
							<%@ include file="project-detail-procurement-two.jsp" %>
						</div> 
						</c:if>
						
						<div title="审批记录"  style="overflow-x:hidden;margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						 	<%@ include file="../project-add-history.jsp" %>
						</div>
					</div>
			
				</div>
			</div>
			
			<div class="win-left-bottom-div-ys">
				<a href="${base}/project/print?openType=0&id=${bean.FProId}" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/dy1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="basicExpenditureExport()">
					<img src="${base}/resource-modality/${themenurl}/button/daochu1.png"
						onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu2.png')"
						onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu1.png')"
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
	
		<div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../../check_system.jsp" />
		</div>
	</div>
</form>
</div>
<script type="text/javascript">
	/* //页面置顶
	$(function(){
		var div = document.getElementById('container');
		div.scrollTop = 0;
	}); */
	flashtab('project-detail-tab');
	
	function validateProjectAdd(stepName){
		if(stepName=='项目基本信息'){
			return validateProjectAddBase();
		} else if(stepName=''){
			
		}
		return true;
	}
	
	function validateProjectAddBase(){
		/* //验证预算额不大于控制数
		var controlAmount = $('#pro_add_provideAmount1').numberbox('getValue');
		if(controlAmount!=''){
			var num1 = $('#pro_add_FProBudgetAmount').numberbox('getValue');
			if(num1>controlAmount){
				alert('请确保"项目预算金额"不大于"一下控制财拨数"金额！');
				return false;
			}
		} */
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
	function saveProject(saveType){
		if (validateProjectAddBase()==false) {
			return;
		} 
		//alert(2) */
		/* if (validateProMoney()==false) {
			return;
		} */
		setAccoFile();//立项依据附件
		setPlanFile();//实施方案附件
		//setAttaPath('file_pro_acco','path_pro_acco');//上传附件
		//setAttaPath('file_pro_plan','path_pro_plan');
		/* var outcome = getOutcome();//需保存的基本支出科目
		var plan = getPlan();//项目计划
		var longAim = getLongAim();
		var longIndex = getLongIndex();
		var yearAim = getYearAim();
		var yearIndex = getYearIndex(); */
		$('#project_add_form').form('submit', {
   				onSubmit: function(param){
   					param.saveType = saveType;
   					/* param.outcomeJson = outcome;
   					param.planJson = plan;
   					param.longAimJson = longAim;
   					param.longIndexJson = longIndex;
   					param.yearAimJson = yearAim;
   					param.yearIndexJson = yearIndex; */
   				 	flag=$(this).form('enableValidation').form('validate');
   					if(flag){
   						$.messager.progress();
   					}
   					return flag; 
   				}, 
   				url:base+'/project/save', 
   				success:function(data){
   					if(flag){
   						$.messager.progress('close');
   					}
   					data=eval("("+data+")");
   					if(data.success){
   						$.messager.alert('系统提示', data.info, 'info');
   						closeWindow();
   						$('#project_add_form').form('clear');
   						$("#pro_dg").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   						/* closeWindow();
   						$('#project_add_form').form('clear'); */
   					}
   				} 
   			});		
	}
	
	//基本支出申报页面导出
	function basicExpenditureExport(){
		var id = $('#F_fProId').val();
		window.location.href = base + "/project/basicExpenditureExport?id=" + id;
	}
</script>
</body>
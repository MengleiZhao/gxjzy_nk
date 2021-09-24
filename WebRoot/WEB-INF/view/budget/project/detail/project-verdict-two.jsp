<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<style>
select{width: 200px}
</style>
<body>
<div class="win-div">
<form id="project_verdict_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 559px;">
		<div style="width: 1065px" class="win-left-div-ys" data-options="region:'west',split:true">
		 <!-- 审批附件 -->
		 <input type="hidden" name="spjlFiles" id="spjlFile" value=""/>	
		<!-- 项目id -->
		<input type="hidden" id="F_fProId" name="FProId" value="${bean.FProId}"/>
		<!-- 数据状态 -->
		<input type="hidden" id="F_Stauts" name="FStauts" value="${bean.FStauts}"/>
		<!-- 审批状态 -->
		<input type="hidden" id="F_FFlowStauts" name="FFlowStauts" value="${bean.FFlowStauts}"/>
		<!-- 资金来源json -->
		<input type="hidden" id="fundJson" name="fundJson"  />
		<!-- 基本支出明细 -->
		<input type="hidden" id="outcomeJson" name="outcomeJson"  />
		<!-- 项目预算周期 -->
		<input type="hidden"  name="FProBudgetCycle" value="1"/>
			<div class="win-left-top-div-ys">
				<div class="tab-wrapper" id="project-check-tab">
					<ul class="tab-menu">
						<li class="active" onclick="onclickProBase()">项目信息</li>
						<li onclick="onclickProMingXi();">项目支出明细（测算过程）</li>
						<c:if test="${bean.fprocurementStatus=='1'}">
						<li onclick="$.parser.parse('#mingxiPurId');$('#pro_purchase_detail_tab_id').datagrid('reload')">政府采购明细</li>
						</c:if>
						<li onclick="$('#check-history-dg').datagrid('reload')">审批记录</li>
					</ul>
					
					<div class="tab-content" style="width: 1045px">
						<c:if test="${bean.FProOrBasic==0}">
							<div title="项目信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							   	<%@ include file="../project-detail-base-two.jsp" %>
							</div> 
						</c:if>
						<div title="基本支出明细" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							<%@ include file="project-detail-outcome-two.jsp" %>
						</div>
						<c:if test="${bean.fprocurementStatus=='1'}">
 						<div id="mingxiPurId" title="政府采购明细表" style="margin-bottom:35px;width: 860px" data-options="iconCls:'icon-xxlb'">
							<%@ include file="project-detail-procurement.jsp" %>
						</div> 
						</c:if>
						<div title="审批记录"  style="overflow-x:hidden;margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						 	<%@ include file="../project-add-history.jsp" %>
						</div>
					</div>
				</div>
			</div>
			
			<div class="win-left-bottom-div-ys">
				<%-- <a href="javascript:void(0)" onclick="updRecord()">
					<img src="${base}/resource-modality/${themenurl}/button/xgjl1.png"
						onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/xgjl2.png')"
						onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/xgjl1.png')"
					/>
				</a> --%>
				<a href="#" onclick="saveProjectVer('1')">
						<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				<a href="#" onclick="saveProjectVer('0')">
					<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				<input type="hidden" name="fcheckResult" id="fcheckResult"/>
				<input type="hidden" name="fcheckRemake" id="fcheckRemake"/>
			</div>
		</div>
	
		<div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../../check_system.jsp" />
		</div>
	</div>
</form>
</div>
<script type="text/javascript">
	flashtab('project-check-tab');
	//防止不停重新加载
	var proMingXiCount = 0;
	function onclickProMingXi(){
		
		if(proMingXiCount>=1){
			proMingXiCount+=1;
			return false;
		}else {
			proMingXiCount+=1;
			$('#pro_outcomes_detail_table').datagrid('reload')
			return true;
		}
	}
	var proBaseCount = 0;
	function onclickProBase(){
		
		$('#fundssourceDetail').css('display','');
		$.parser.parse('#zijinlaiyuan');
		  window.setTimeout(function (){
			  $('#fundssource').datagrid('loadData',globalVariable);
			  },500);
		
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
		var proOrBasic = '${bean.FProOrBasic}';
	   	if(proOrBasic==1){
	   		if($('#fProAccordingId').val()==''){
				alert('请填立项依据！');
				return false;
			}
	   		if($('#project_add_firstLevel').combobox('getValue')==''){
				alert('请选择一级分类名称！');
				return false;
			}
	   		if($('#project_add_secondLevel').combobox('getValue')==''){
				alert('请选择二级分类！');
				return false;
			} 
	   	}else{
	   		//基本支出项目
	   		if($('#project_add_base_secondLevel').combobox('getValue')==''){
				alert('请选择二级分类！');
				return false;
			} 
	   	}
	   	
		//验证项目属性
		if ($('#project_add_FProName').textbox('getValue')==''){
			alert('请填写项目名称！');
			return false;
		}  
		if ($('#pro_add_FProBudgetAmount').numberbox('getValue')=='') {
			alert('请填写资金来源！');
			return false;
		}
		if($('#pro_add_planStartYear').numberbox('getValue')==''){
			$('#pro_add_planStartYear').numberbox('setValue', new Date().getFullYear()+1);
			alert("开始执行年份不能为空！");
			return false;
		}
		/* if ($('#project_add_FProClass').combobox('getValue')=='') {
			alert('请选择项目类别！');
			return false;
		} */
		  
		return true;
	}
	
	//校验不通过，就打开第一个校验失败的标签页
	function openInvalidTab(tabid){
		//获取所有标签页
		var $wrapper = $('#'+tabid),
			$allTabs = $wrapper.find('.tab-content > div'),
			$tabMenu = $wrapper.find('.tab-menu li');
			
		for(var i=0;i<$allTabs.length;i++){
			var forflag = true;
			//获取标签页标记
			var datab = $allTabs[i].getAttribute('data-tab');
			var inputs = $('div[data-tab="'+datab+'"] input');
			
			$('div[data-tab="'+datab+'"] input').each(function() {
				//打开校验不通过的标签
				if($(this).hasClass("validatebox-invalid")){
					$('li[data-tab="'+datab+'"]').click();
					//打开该标签页
					/*$getWrapper = $(this).closest($wrapper);
					$getWrapper.find($allTabs).css('display','none');
					$getWrapper.find($allTabs).filter('[data-tab='+datab+']').css('display','block');*/
					//更改标签头
					/*var lili= $('li[data-tab="'+datab+'"]');
					$getWrapper.find($tabMenu).removeClass('active');
					$('li[data-tab="'+datab+'"]').addClass('active');*/
					
					forflag=false;
					return false;
				}
			});
			
			if(forflag==false){
				return forflag;
			}
			
		}
		//循环每个标签页
	}
	
	//审批
	function saveProjectVer(iftg){
		var verify = true;
		$.ajax({
			type:'post',
			dataType:'json',
			url:base+'/project/verifyCheckTime', 
			data:{fDataType:iftg},
			async : false,
			success:function(data){
				verify=data;
			}
		});
		if(iftg==1){
			if(!verify){//校验是否 超过审批时间
				alert('超出审批时间，不允许审批！');
				return false;
			}
		}
		getOutcomeJsons();
		if('${checkPeople}'!=''){
			var rows = $('#pro_outcomes_detail_table').datagrid('getRows');
			var flag = true;
			for (var i = 0; i < rows.length; i++) {
				if(rows[i].capitalSourceName==''){
					flag = false;
					break;
				}
			}
			if(!flag){
				alert('请在项目支出明细（测算过程）标签页中，填写资金来源信息！');
				return false;
			}
		}
		if(1==iftg){//通过情况下
			//校验经济分类科目有没有填写
			var subCode = $('.pro_add_outcome_subCode');
			for (var i = 0; i < subCode.length; i++) {
				var valcode = subCode[i].value;
				if(valcode==''){
					alert("经济分类科目不允许为空，请检查是否已选择经济分类科目！");
					return;
				}
				if(valcode.length<4){
					alert("经济分类科目请选择二级指标！");
					return;
				}
			}
		}
		var url = encodeURI('/project/checkRemake?type=xmsb&result='+iftg+"&listid=${listid}");
		var win = creatFirstWin('审批意见', 560, 500, 'icon-search',url);
		win.window('open');
	}
	
	//审批修改记录
	function updRecord(){
		var proId = $('#F_fProId').val();
		var win = creatFirstWin('修改记录', 700, 500, 'icon-search', '/project/checkUpdateRecord?id='+proId);
		win.window('open');
	}
	
	
</script>
</body>
</html>
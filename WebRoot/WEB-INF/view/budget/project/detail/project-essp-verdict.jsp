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
		<!-- 资金来源json -->
		<input type="hidden" id="fundJson" name="fundJson"  />
		<!-- 基本支出明细 -->
		<input type="hidden" id="outcomeJson" name="outcomeJson"  />
		<!-- 项目预算周期 -->
		<input type="hidden"  name="FProBudgetCycle" value="1"/>
			<div class="win-left-top-div-ys">
				<div class="tab-wrapper" id="project-essp-tab">
					<ul class="tab-menu">
						<li class="active" onclick="onclickProBase()">项目信息</li>
							<li class="FProAccording">立项依据</li>
							<li class="FExplain" >项目实施方案</li>
						<li onclick="onClickOutcomeCheck();">项目支出明细（测算过程）</li>
						<li onclick="onClickJXMBCheck()" >绩效目标申报</li>
						<c:if test="${bean.fprocurementStatus=='1'}">
						<li onclick="onClickZfCheck()" ">政府采购明细表</li>
						</c:if>
						<c:if test="${bean.ifInvolveNetworkSoftware=='1'}">
						<li onclick="onClickZfSECheck()" ">信息及软件采购明细表</li>
						</c:if>
						<li onclick="$('#check-history-dg').datagrid('reload')">审批记录</li>
					</ul>
					
					<div class="tab-content" style="width: 1045px">
						<div title="项目信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						   	<%@ include file="project-detail-base.jsp" %>
						</div> 
						 
						<div title="立项依据" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						   	<%@ include file="project-detail-lxyj.jsp" %>
						</div> 
						
						<div title="项目实施方案" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						    <%@ include file="project-detail-xmssfa.jsp" %>
						</div> 
						
						<div title="项目支出明细" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							<%@ include file="project-detail-outcome.jsp" %>
						</div> 
												 	
						<div title="绩效目标申报表" data-options="iconCls:'icon-xxlb'" style="margin-bottom:35px;">
							<jsp:include page="project-detail-performance.jsp" />
						</div>
						<c:if test="${bean.fprocurementStatus=='1'}">
						<div title="政府采购明细表" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="project-detail-procurement.jsp" />
						</div> 
						</c:if>
						<c:if test="${bean.ifInvolveNetworkSoftware=='1'}">
						<div title="政府采购明细表（信息网络及软件购置更新）" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="project-detail-procurement_SE.jsp" />
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

<form id="form_pro_export_performance_detail" method="post" enctype="multipart/form-data">
	<input id="form_pro_export_detail_proId" type="hidden" name="proId" value="${bean.FProId}">
	<input id="form_pro_export_detail_json" type="hidden" name="jsonPerformance">
</form>
</div>
<script type="text/javascript">

flashtab('project-essp-tab');

//1通过 0不通过
function saveProjectVer(iftg){
	var verify = true;
	$.ajax({
		type:'post',
		dataType:'json',
		url:base+'/project/verifyCheckTime', 
		data:{fDataType:2},
		async : false,
		success:function(data){
			verify=data;
		}
	});
	if(!verify){//校验是否 超过审批时间
		alert('超出审批时间，不允许审批！');
		return false;
	}
	getOutcomeJsons();
	if('${checkPeople}'!=''){
		var rows = $('#pro_outcomes_table_id').datagrid('getRows');
		var flag = true;
		for (var i = 0; i < rows.length; i++) {
			if(rows[i].capitalSourceName==''||rows[i].capitalSourceName==null||rows[i].capitalSourceName=="null"){
				flag = false;
				break;
			}
		}
		if(!flag){
			alert('请在项目支出明细（测算过程）标签页中，填写资金来源信息！');
			return false;
		}
	}
	var data = '${bean.FProId}';
	var win = creatFirstWin('审批意见',580, 500, 'icon-search', '/declare/checkRemake?type=essp&result='+iftg+'&data1='+data);
	win.window('open');
}

	var proBaseCount = 0;
	function onclickProBase(){
		$('#fundssource').css('display','');
		$.parser.parse('#zijinlaiyuanDetail');
		  window.setTimeout(function (){
			  $('#fundssource').datagrid('loadData',globalVariable);
			  },500);
		
	}
	function validateProjectAddBase(){
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
	
	//审批修改记录
	function updRecord(){
		var proId = $('#F_fProId').val();
		var win = creatFirstWin('修改记录', 700, 500, 'icon-search', '/project/checkUpdateRecord?id='+proId);
		win.window('open');
	}
	
	
	var jxmbcountDetail = 0;
	function onClickJXMBCheck(){
		
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
	function onClickOutcomeCheck(){
		
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
	function onClickZfCheck(){
		
		if(ZfcountDetail>=1){
			ZfcountDetail+=1;
			return false;
		}else{
			ZfcountDetail+=1;
			setTimeout(function (){
			$.parser.parse('#mingxiProIdDetail');
			}, 100);
			$('#purManyYearsProTabDetailId').datagrid('reload');
			return true;
		}
	}
	
	var ZfSEcountDetail = 0; 
	function onClickZfSECheck(){
		
		if(ZfSEcountDetail>=1){
			ZfSEcountDetail+=1;
			return false;
		}else {
			ZfSEcountDetail+=1;
			setTimeout(function (){
				$.parser.parse('#mingxiProIdSEDetail');
			}, 100);
			$('#purManyYearsProTabSEId').datagrid('reload');
			return true;
		}
	}
	
</script>
</body>
</html>








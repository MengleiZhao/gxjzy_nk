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
		<div class="win-left-div-ys" data-options="region:'west',split:true">
		<!-- 审批附件 --><input type="hidden" name="spjlFiles" id="spjlFile" value=""/>	
			<div class="win-left-top-div-ys">
				<div class="tab-wrapper" id="project-check-tab">
					<ul class="tab-menu">
						<li class="active">项目信息</li>
						<c:if test="${bean.FProOrBasic==2}">
							<li class="FProAccording">立项依据</li>
							<li class="FExplain" >项目实施方案</li>
						</c:if>
						<!-- <li>项目支出计划</li> -->
						<li>项目支出明细</li>
						<li onclick="$('#check-history-dg').datagrid('reload')">审批记录</li>
					</ul>
					
					<div class="tab-content">
						<c:if test="${bean.FProOrBasic==0}">
							<div title="项目信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							   	<%@ include file="../project-add-base-two.jsp" %>
							</div> 
						</c:if>
						<c:if test="${bean.FProOrBasic==2}">
							<div title="项目信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							   	<%@ include file="../project-add-base-big.jsp" %>
							</div>
						</c:if>
						
						<c:if test="${bean.FProOrBasic==2}">
							<div title="立项依据" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							   	<%@ include file="../project-add-lxyj.jsp" %>
							</div> 
							
							<div title="项目实施方案" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							    <%@ include file="../project-add-xmssfa.jsp" %>
							</div>
						</c:if> 
						        	
						<%-- <div title="项目支出计划" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						    <%@ include file="project-detail-plan.jsp" %>
						</div> --%>
						 	
						<div title="项目支出明细" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							<%@ include file="../project-add-outcome.jsp" %>
						</div> 
						
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
	   	if(proOrBasic==1||proOrBasic==2){
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
		if ($('#pro_add_bigProId').combobox('getValue')=='') {
			alert('请选择大项目！');
			return false;
		}    
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
		/* //验证
		if(iftg=='false'){
			var suggest = $('#pro_verdict_suggest').textbox('getValue');
			if(suggest==''){
				alert('请填写审批意见！');
				return;
			}
		} */
		
		/* //设置状态
		var FFlowStauts = parseInt($('#pro_verdict_FFlowStauts').val());
		if (iftg=='true') {
			FFlowStauts = FFlowStauts + 1;
			$('#pro_verdict_FFlowStauts').val(FFlowStauts)
			if(FFlowStauts=='3'){
				$('#pro_verdict_FProLibType').val('2');
			};
			$('#pro_verdict_FOperation').val('yes');
		}else if (iftg=='false'){
			//FFlowStauts = FFlowStauts - 1;
			FFlowStauts = -1;
			$('#pro_verdict_FFlowStauts').val(FFlowStauts);
			$('#pro_verdict_FProLibType').val('1');
			$('#pro_verdict_FOperation').val('no');
		} */
		
		if(${bean.FProOrBasic==0}){
			//校验二级分类名称是否重复
			var year = $("#pro_add_planStartYear").val();			//开始执行年份
			var code = $("#project_base_ejxmdm").val();				//二级分类编码
			var FProCode = $("#project_add_FProCode").val();		//项目编号
			var checkFlag = 0;	
			//重复标记 0-未重复	1-重复
			$.messager.progress();
			$.ajax({ 
				type: 'POST',
				async: false, //取消异步
				url: '${base}/project/checkSecondLevelName?year='+year+'&code='+code+'&FProCode='+FProCode,
				dataType: 'json',
				contentType: "application/json;charset=UTF-8",
				success: function(data){
					if(data.success){
						$.messager.progress('close');
						checkFlag = 0;	
					}else{
						$.messager.progress('close');
						checkFlag = 1;
					}
				} 
			});
			if(checkFlag == 1){
				alert("你已提交过此二级分类名称，不能重复上报!")
				return ;
			}
		}
		
		if(${bean.FProOrBasic==1}||${bean.FProOrBasic==2}){
			//绩效指标
			getPerformanceJson();
		}
		
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
		
		//校验项目支出明细
		//支出金额不能为空或者0
		var subAmountList = $("#pro_outcome_table tr:not(:first)").find("td:eq(3)");
		for (var i = 0; i < subAmountList.length; i++)	{
			var subAmount = subAmountList[i].children[0].value;
			if(subAmount==0||subAmount==''){
				alert("项目明细中支出金额不允许为0或为空，请检查是否填写正确！");
				return;
			}
		}
		
		//校验
		$('#project_add_form').form('enableValidation').form('validate');
		//跳转到校验失败的标签页
		openInvalidTab('project-tab');
		if (validateProjectAddBase()==false) {
			var fundsEditIndex = $('#fundssource').datagrid('getRows').length - 1;
			$('#fundssource').datagrid('selectRow', fundsEditIndex).datagrid('beginEdit',
					fundsEditIndex);
			return;
		}
		
		//重新计算一遍支出明细总额
		autoCalTotal(null);
		if(parseFloat($('#outcomeTotal').val())!=parseFloat($('#pro_add_FProBudgetAmount').val())){
			alert("项目支出明细总额与项目预算金额不一致");
			return;
		}
		
		var win = creatFirstWin('审批意见', 560, 500, 'icon-search', '/project/checkRemake?type=xmsb&result='+iftg+"&listid=${listid}");
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
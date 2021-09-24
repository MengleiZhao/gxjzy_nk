<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<style>
select{width: 200px}
</style>
<body>
<div class="win-div">
<form id="project_essb_edit_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 559px;">
		<div style="width: 1065px" data-options="region:'west',split:true">
			<div class="win-left-top-div-ys">
				<div class="tab-wrapper" id="essb-edit-tab">
					<ul class="tab-menu">
						<li class="active">项目信息</li>
						<li class="FProAccording">立项依据</li>
						<li class="FExplain" >项目实施方案</li>
						<li onclick="onClickOutcomeEssb()" >项目支出明细（测算过程）</li>
						<li onclick="onClickJXMBEssb()" >绩效目标申报</li>
						<li id="zhengfuProId" onclick="onClickZfEssb()" style="display: none;">政府采购明细表</li>
						<li id="zhengfuProSEId" onclick="onClickZfSEEssb()" style="display: none;">信息及软件采购明细表</li>
						<c:if test="${operation!='add'}"><li onclick="$('#check-history-dg').datagrid('reload')">审批记录</li></c:if>
					</ul>
					
					<div class="tab-content" style="width: 1045px">
						<div title="项目信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						   	<%@ include file="project-add-essb-base.jsp" %>
						</div> 
						 
						<div  title="立项依据" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						   	<%@ include file="project-add-essb-lxyj.jsp" %>
						</div> 
						
						<div  title="项目实施方案" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						    <%@ include file="project-add-essb-xmssfa.jsp" %>
						</div>
						        	
						<div id="proOutcomeEssbId" title="项目支出明细" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							<%@ include file="project-add-essb-outcome.jsp" %>
						</div> 
												 	
						<div id="project-add-performance-essb" title="绩效目标申报表" data-options="iconCls:'icon-xxlb'" style="margin-bottom:35px;">
							<jsp:include page="project-add-essb-performance.jsp" />
						</div>
						<div id="mingxiProEssbId" title="政府采购明细表" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="project-add-essb-procurement.jsp" />
						</div> 
						<div id="mingxiProIdEssbSE" title="政府采购明细表（信息网络及软件购置更新）" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="project-add-essb-procurement_SE.jsp" />
						</div> 
						
						<c:if test="${operation!='add'}">
						<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow-x:hidden;margin-top: 10px;">
							<%@ include file="project-add-history.jsp" %>											
						</div>
						</c:if>
					</div>
				</div>
			</div>
			
			<div class="win-left-bottom-div-ys">
					<a href="javascript:void(0)" onclick="saveEsProject('zc')">
						<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png"
							onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/zhanchun2.png')"
							onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/zhanchun1.png')"
						/>
					</a> 
				&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="saveEsProject('sb')">
						<img src="${base}/resource-modality/${themenurl}/button/songshen1.png"
							onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/songshen2.png')"
							onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/songshen1.png')"
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
		<div class="win-right-div" style="height: 570px;" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div>
	</div>
</form>

<form id="form_pro_export_performance_essb" method="post" enctype="multipart/form-data">
	<input id="form_pro_export_essb_proId" type="hidden" name="proId" value="${bean.FProId}">
	<input id="form_pro_export_essb_json" type="hidden" name="jsonPerformance">
</form>
</div>
<script type="text/javascript">
//加载tab页
flashtab_pro_add_essb('essb-edit-tab');
function flashtab_pro_add_essb(tabid) {
	var $wrapper = $('#'+tabid),
		$allTabs = $wrapper.find('.tab-content > div'),
		$tabMenu = $wrapper.find('.tab-menu li');
		$line = $('<div class="line"></div>').appendTo($tabMenu);
	
	$allTabs.not(':first-of-type').hide();  
	$tabMenu.filter(':first-of-type').find(':first').width('100%');
	
	$tabMenu.each(function(i) {
	  $(this).attr('data-tab', 'tab'+i);
	});
	
	$allTabs.each(function(i) {
	  $(this).attr('data-tab', 'tab'+i);
	});
	
	$tabMenu.on('click', function() {
	  var dataTab = $(this).data('tab');
	  if(dataTab=='tab5'){
		  //点击绩效分页时候，打开绩效指标手风琴（解决绩效指标datagrid不显示的bug）
		  $('#acco_pro_add_jx').accordion('select','绩效指标');
	  }
	  
	  $getWrapper = $(this).closest($wrapper);
	  
	  $getWrapper.find($tabMenu).removeClass('active');
	  $(this).addClass('active');
	  
	  $getWrapper.find('.line').width(0);
	  $(this).find($line).animate({'width':'100%'}, 'fast');
	  $getWrapper.find($allTabs).hide();
	  $getWrapper.find($allTabs).filter('[data-tab='+dataTab+']').show();
	});
}

function validateProjectAdd(stepName){
	if(stepName=='项目基本信息'){
		return validateProjectAddBase();
	} else if(stepName=''){
		
	}
	return true;
}
	
	function validateProjectAddBase(){
		if(${bean.zxmId==null||bean.zxmId==''}){
			if(parseFloat($('#pro_add_provideAmount1').val())!=parseFloat($('#pro_add_FProBudgetAmount').val())){
				alert("项目控制金额与项目预算金额不一致");
				return false;
			}
			if(parseFloat($('#outcomeTotal').val())!=parseFloat($('#pro_add_FProBudgetAmount').val())){
				alert("项目支出明细总额与项目预算金额不一致");
				return false;
			}
		}
		//验证项目属性
		if ($('#project_add_FProName').textbox('getValue')==''){
			alert('请填写项目名称！');
			return false;
		} else if ($('#pro_add_FProBudgetAmount').numberbox('getValue')=='') {
			alert('请填写项目预算金额！');
			return false;
		}
		return true;
	}
	
	//保存 saveType,暂存zc，申报sb
	function saveEsProject(saveType){

		//项目支出明细
		accept1Essb();
		getOutcomeJsonEssb();
		//绩效指标
		performanceAcceptEssb();
		getPerformanceJsonEssb();
		//政府采购明细表
		acceptpurchaseReimEssb();
		purchasePeopJsonReimEssb();
		//政府采购明细表页面中的一采多年明细
		purManyYearsProAcceptEssb();
		getPurManyYearsProJsonEssb();
		//政府采购明细表
		acceptpurchaseReimSEEssb();
		purchasePeopJsonReimSEEssb();
		//政府采购明细表页面中的一采多年明细
		purManyYearsProAcceptSEEssb();
		getPurManyYearsProJsonSEEssb();
		
		if('sb'==saveType){
			var provideAmount1 =isNaN(parseFloat($('#provideAmount1').numberbox('getValue')))?0:parseFloat($('#provideAmount1').numberbox('getValue'));
			var totalFsumMoney = 0;
			var rows = $('#pro_outcomes_table_essb_id').datagrid('getRows');
			for(var i=0;i<rows.length;i++){
				totalFsumMoney+=addNumOutcomesEssb(rows,i);
			}
			totalFsumMoney=parseFloat(totalFsumMoney);
			var proApplyType = $('#pro_add_proApplyType').val();
			if(proApplyType!='1'){
				if(provideAmount1<totalFsumMoney){
					alert('支出明细金额要小于等于一下控制金额，请核对后提交！');
					return false;
				}
			}
			
			//设置数据状态
			$('#F_Stauts').val(1);
			//设置审批状态
			$('#F_FFlowStauts').val(31);
			
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
			$('#project_essb_edit_form').form('enableValidation').form('validate');
			//跳转到校验失败的标签页
			openInvalidTab('project-tab');
			
			var verify = true;
			$.ajax({
				type:'post',
				dataType:'json',
				url:base+'/project/verifyToCheckTime', 
				data:{fDataType:1},
				async : false,
				success:function(data){
					verify=data;
				}
			});
			if(!verify){//校验是否 超过申报
				alert('不在申报时间，不允许申报！');
				return false;
			}
			//绩效目标校验
			var fprocurementStatus = $('input[name="fprocurementStatus"]:checked').val();//是不是政府采购
			var ifPurchaseManyYearsPro = $('input[name="ifPurchaseManyYearsPro"]:checked').val();//是不是政府采购一采多年
			var ifInvolveNetworkSoftware = $('input[name="ifInvolveNetworkSoftware"]:checked').val();//是不是政府采购是否涉及信息网络及软件购置更新
			var ifPurchaseManyYearsSEPro = $('input[name="ifPurchaseManyYearsSEPro"]:checked').val();//是不是政府采购是否涉及信息网络及软件购置更新一采多年
			var purchasePeopJson = $('#purchasePeopJson').val();
			if(fprocurementStatus=='1'&& purchasePeopJson==''){
				alert('请填写政府采购明细表！');
				return false;
			}
			var purManyYearsProJson = $('#purManyYearsProJson').val();
			if(ifPurchaseManyYearsPro=='1'&& purManyYearsProJson==''){
				alert('请填写政府采购一采多年明细表！');
				return false;
			}
			var purchasePeopJsonSE = $('#purchasePeopJsonSE').val();
			if(ifInvolveNetworkSoftware=='1'&& purchasePeopJsonSE==''){
				alert('请填写政府采购涉及信息网络及软件购置更新明细表！');
				return false;
			}
			var purManyYearsProJsonSE = $('#purManyYearsProJsonSE').val();
			if(ifPurchaseManyYearsSEPro=='1'&& purManyYearsProJsonSE==''){
				alert('请填写政府采购涉及信息网络及软件购置更新一采多年明细表！');
				return false;
			}
			
			var performanceRows = $('#performanceEssb').datagrid('getRows');
			var year = $('#project-add-year').textbox('getValue');
			var implementProgress = $('#project-add-implementProgress').textbox('getValue');
			var yearTarget = $('#project-add-yearTarget').textbox('getValue');
			if(year==''){
				alert('请填写绩效年度！');
				return false;
			}
			if(implementProgress==''){
				alert('请填写项目实施进展情况（含投资评审）!');
				return false;
			}
			if(yearTarget==''){
				alert('请填写年度绩效目标!');
				return false;
			}
			if(performanceRows.length<=0){
				alert('请添加绩效目标');
				return false;
			}else{
				var FProBudgetAmount = $('#pro_add_FProBudgetAmount').val();
				var mediumTarget = $('#project-add-mediumTarget').textbox('getValue');
				if(FProBudgetAmount>=2000000 || ifInvolveNetworkSoftware=='1'){
					if(mediumTarget==''){
						alert('请填写中期绩效目标!');
						return false;
					}
				}
					for (var i = 0; i < performanceRows.length; i++) {
						if(performanceRows[i].tOneName==''||performanceRows[i].tOneName==null||performanceRows[i].tOneName==undefined||
							performanceRows[i].tTwoName==''||performanceRows[i].tTwoName==null||performanceRows[i].tTwoName==undefined||
							performanceRows[i].tIndexVal==''||performanceRows[i].tIndexVal==null||performanceRows[i].tIndexVal==undefined){
						
							if(performanceRows[i].tOneName=='满意度' && (performanceRows[i].tTwoName=='' || performanceRows[i].tTwoName==null)){
								
							}else{
								alert('绩效目标请填写完整');
								return false;
							}
						}
					}
					var chanchu = 0;
					var chanchu1 = 0;
					var chanchu2 = 0;
					var chanchu3 = 0;
					var chanchu4 = 0;
					var xiaoguo = 0;
					var manyidu = 0;
					for (var y = 0; y < performanceRows.length; y++) {
						if(performanceRows[y].tOneName=='产出指标'){
							if(chanchu1==0&&performanceRows[y].tTwoName=='产出数量'){
								chanchu+=1;
								chanchu1+=1;
							}
							if(chanchu2==0&&performanceRows[y].tTwoName=='产出质量'){
								chanchu+=1;
								chanchu2+=1;
							}
							if(chanchu3==0&&performanceRows[y].tTwoName=='产出时效'){
								chanchu+=1;
								chanchu3+=1;
							}
							if(chanchu4==0&&performanceRows[y].tTwoName=='产出成本'){
								chanchu+=1;
								chanchu4+=1;
							}
						}
						if(performanceRows[y].tOneName=='效益指标'){
							if(performanceRows[y].tTwoName=='经济效益'||performanceRows[y].tTwoName=='社会效益'||performanceRows[y].tTwoName=='生态效益'||performanceRows[y].tTwoName=='可持续影响'){
								xiaoguo += 1;
							}
						}
						if(performanceRows[y].tOneName=='满意度指标'){
							manyidu += 1;
						}
					}
					
					if(chanchu<4){
						alert('产出指标四个二级指标必需填写！');
						return false;
					}
					if(xiaoguo<1){
						alert('效果指标二级指标必需填写一项！');
						return false;
					}
					if(manyidu<1){
						alert('满意度指标必需填写！');
						return false;
					}
			}
		}else if('zc'==saveType){
			//设置数据状态
			$('#F_Stauts').val(0);
			//设置审批状态
			$('#F_FFlowStauts').val(30);
			
			var firstLevelCode = $("#project_add_firstLevel").combobox('getValue');
			var ejxmdm = $("#project_add_secondLevel").combobox('getValue');
			if(firstLevelCode==''||firstLevelCode=='--请选择--'){
				alert("请选择'所属一级分类名称'!");
				return;
			}
			if(ejxmdm==''||ejxmdm=='--请选择--'){
				alert("请选择'二级分类名称'!");
				return;
			}
		}
		$('#project_essb_edit_form').form('submit', {
				onSubmit: function(param){
					param.saveType = saveType;
					if(saveType=='sb'){
	   				 	flag=$(this).form('enableValidation').form('validate');
	   					if(flag){
	   						$.messager.progress();
	   					}
	   					return flag; 
   					}else{
	   					$.messager.progress();
   					}
				}, 
				url:base+'/declare/essb', 
				success:function(data){
					if(saveType=='sb'){
	   					if(flag){
	   						$.messager.progress('close');
	   					}
   					}else {
	   					$.messager.progress('close');
   					}
					data=eval("("+data+")");
					if(data.success){
						$.messager.alert('系统提示', data.info, 'info');
						$('#project-essb-table').datagrid('reload'); 
						$('#indexdb').datagrid('reload');
						closeWindow();
					}else{
						$.messager.alert('系统提示', data.info, 'error');
					}
				} 
			});	
	}
	
	var ZfcountEssb = 0; 
	function onClickZfEssb(){
		if(ZfcountEssb>=1){
			ZfcountEssb+=1;
			return false;
		}else{
			ZfcountEssb+=1;
			$('#mingxiProEssbId').css('display','');
			$.parser.parse('#mingxiProEssbId');
			setTimeout(function (){
				$.parser.parse('#mingxiProEssbId');
				}, 100);
			$('#pro_purchase_tab_essb_id').datagrid('reload');
			return true;
		}
	}
	
	var ZfSEcountEssb = 0; 
	function onClickZfSEEssb(){
		if(ZfSEcountEssb>=1){
			ZfSEcountEssb+=1;
			return false;
		}else {
			ZfSEcountEssb+=1;
			$('#mingxiProIdEssbSE').css('display','');
			setTimeout(function (){
				$.parser.parse('#mingxiProIdEssbSE');
				}, 100);
			$('#pro_purchase_tab_SE_id').datagrid('reload');
			return true;
		}
	}
	
	var jxmbcountEssb = 0;
	function onClickJXMBEssb(){
		if(jxmbcountEssb>=1){
			jxmbcountEssb+=1;
			return false;
		}else {
			jxmbcountEssb+=1;
			$('#project-add-performance-essb').css('display','');
			$('#performanceEssb').datagrid('reload');
			setTimeout(function (){
				$.parser.parse('#project-add-performance-essb');
				}, 100);
			setTimeout(function (){
				if('${operation}'=='add'){
					onLoadSuccessPerFormanceESSB();
				}
				}, 1000);
			return true;
		}
	}
	
	var proOutcomeCountEssb = 0;
	function onClickOutcomeEssb(){
		
		if(proOutcomeCountEssb>=1){
			proOutcomeCountEssb+=1;
			return false;
		}else {
			proOutcomeCountEssb+=1;
			$('#proOutcomeEssbId').css('display','');
			setTimeout(function (){
			$.parser.parse('#proOutcomeEssbId');
			}, 100);
			return true;
		}
	}
</script>
</body>

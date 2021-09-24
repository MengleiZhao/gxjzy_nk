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
		<div style="width: 1065px" class="win-left-div-ys" data-options="region:'west',split:true">
			<div class="win-left-top-div-ys">
				<!-- 一级分类名 -->
		     		<input type="hidden" id="add_FirstLevelName" name="firstLevelName" <c:if test="${bean.FProOrBasic==0}"> value="经常性支出项目" </c:if>/>
		     		<!-- 二级分类名 -->
		     		<input type="hidden" id="add_secondLevelName" name="secondLevelName" value="${bean.secondLevelName}"/>
					<!-- 项目id -->
					<input type="hidden" id="F_fProId" name="FProId" value="${bean.FProId}"/>
					<!-- 数据状态 -->
					<input type="hidden" id="F_Stauts" name="FStauts" value="${bean.FStauts}"/>
					<!-- 审批状态 -->
					<input type="hidden" id="F_FFlowStauts" name="FFlowStauts" value="${bean.FFlowStauts}"/>
					<!-- 项目预算周期 -->
					<input type="hidden"  name="FProBudgetCycle" value="1"/>
					<!-- 预算支出类型 -->
					<input type="hidden" id="project_add_FProOrBasic" onchange="FProOrBasicChange(${bean.FProOrBasic})" name="FProOrBasic" value="${bean.FProOrBasic}"/>
		     		<!-- 政府采购金额 -->
		     		<input type="hidden" id="pro_add_governmentPurAmount"  name="governmentPurAmount" value="${bean.governmentPurAmount}"/>
		     		<!-- 项目负责人id -->
		     		<input type="hidden" id="pro_add_FProHeadId"  name="FProHeadId" value="${bean.FProHeadId}"/>
		     		<!-- 项目分类代码 -->
		     		<input type="hidden" id="project_base_ejxmdm" name="secondLevelCode" value="${bean.secondLevelCode}"/>
				<div class="tab-wrapper" id="project-tab">
					<ul class="tab-menu">
						<li class="active" onclick="acceptpurchaseReim();$('#zijinlaiyuan').css('display','');$.parser.parse('#zijinlaiyuan');$('#fundssource').datagrid('reload');">基本支出信息</li>
						<li onclick="fundsEndEditing();acceptpurchaseReim();$('#jibenmingxi').css('display','');$.parser.parse('#jibenmingxi');$('#pro_outcomes_table').datagrid('reload');">基本支出明细（测算过程）</li>
						<li id="zhengfuId" onclick="onClickZf()" style="display: none;">政府采购明细表</li>
						<c:if test="${operation!='add'}"><li onclick="$('#check-history-dg').datagrid('reload')">审批记录</li></c:if>
					</ul>
					
					<div class="tab-content" style="width: 1045px">
						<div title="基本支出信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						   	<jsp:include page="project-add-base-two.jsp" />
						</div> 
						 	
						<div id="jibenmingxi" title="基本支出明细" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							<%@ include file="project-add-outcomes.jsp" %>
						</div> 
						 	
						<div id="mingxiId" title="政府采购明细表" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="project-add-procurement-two.jsp" />
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
				<c:if test="${(empty bean.FFlowStauts) or bean.FFlowStauts==0 or bean.FFlowStauts==-11 or bean.FFlowStauts=='-14' }">
					<a href="javascript:void(0)" onclick="saveProject('zc')">
						<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png"
							onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/zhanchun2.png')"
							onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/zhanchun1.png')"
						/>
					</a> 
				</c:if>
				&nbsp;&nbsp;
				<c:if test="${(empty bean.FFlowStauts) or bean.FFlowStauts<3}">
					<a href="javascript:void(0)" onclick="if(confirm('是否送审,送审之后将由下一环节审批，审批期间将无法修改')){saveProject('sb');}">
						<img src="${base}/resource-modality/${themenurl}/button/songshen1.png"
							onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/songshen2.png')"
							onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/songshen1.png')"
						/>
					</a> 
				</c:if>
				<c:if test="${operation!='add'}">
					&nbsp;&nbsp;
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
				</c:if>
				&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="if(confirm('是否退出编辑，如您已编辑部分信息，建议您暂存')){closeWindow();}">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png"
						onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/guanbi2.png')"
						onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/guanbi1.png')"
					/>
				</a>
			</div>
		</div>
	
		<div class="win-right-div" id="check_system_div"  data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div>
	</div>
</form>
</div>
<script type="text/javascript">
	//加载tab页
	flashtab_pro_add('project-tab');
	function flashtab_pro_add(tabid) {
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
	   	}else {
	   		//基本支出项目
	   		if($('#project_add_base_secondLevel').combobox('getValue')==''){
				alert('请选择二级分类！');
				return false;
			} 
	   	}
	   	
		//验证项目属性
		if($('#project_add_FProName').textbox('getValue')==''){
			alert('请填写项目名称！');
			return false;
		}  
		if($('#pro_add_FProBudgetAmount').numberbox('getValue')=='') {
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
	
	//保存 saveType,暂存zc，申报sb
	function saveProject(saveType){
		getOutcomeJson();//获取基本支出明细数据
		var flag = purchasePeopJsonReim();//获取政府采购明细
		var fprocurementStatus = $('input[name="fprocurementStatus"]:checked').val();
		if(fprocurementStatus=='1'){
			if(!flag){
				alert('政府采购需要填写政府采购明细！');
				return false;
			}
		}
		var ifPurchaseManyYearsPro = $('input[name="ifPurchaseManyYearsPro"]:checked').val();//是不是政府采购一采多年
		//政府采购明细表页面中的一采多年明细
		getPurManyYearsProJson();
		var purManyYearsProJson = $('#purManyYearsProJson').val();
		if(ifPurchaseManyYearsPro=='1'&& purManyYearsProJson==''){
			alert('请填写政府采购一采多年明细表！');
			return false;
		}
		if("zc"==saveType){
			//设置数据状态
			$('#F_Stauts').val(0);
			//设置审批状态
			$('#F_FFlowStauts').val(0);
		}else if("sb"==saveType){
			//设置数据状态
			$('#F_Stauts').val(1);
			//设置审批状态
			$('#F_FFlowStauts').val(11);
			
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
		} 

		$('#project_add_form').form('submit', {
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
   				url:base+'/project/save', 
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
   					//	$('#project_add_form').form('clear');
   						$('#pro_dg_2').datagrid('reload'); 
   						$('#indexdb').datagrid('reload');
   						closeWindow();
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   					}
   				} 
   			});		
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
	
	//基本支出申报页面导出
	function basicExpenditureExport(){
		var id = $('#F_fProId').val();
		window.location.href = base + "/project/basicExpenditureExport?id=" + id;
	}
	
	var Zfcount = 0; 
	function onClickZf(){
		if(Zfcount>=1){
			Zfcount+=1;
			return false;
		}else{
			Zfcount+=1;
			$('#mingxiId').css('display','');
			$.parser.parse('#mingxiId');
			$('#pro_purchase_tab_id').datagrid('reload');
			return true;
		}
	}
</script>
</body>
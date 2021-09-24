<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<style>
select{width: 200px}
</style>

<body>
<div class="win-div">
<form id="project_add_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${expr.xjdbm}" />
	<!-- 流程id  --><input type="hidden" id="flowId"  value="${fpId}"/>
	<!-- 下一级审批节点  --><input type="hidden" id="nextKey"  value="${expr.xjdbm}"/>
	<div class="easyui-layout" style="height: 559px;">
		<div class="win-left-div-ys" data-options="region:'west',split:true">
			<div class="win-left-top-div-ys">
				
				<div class="tab-wrapper" id="project-transfer-tab">
					<ul class="tab-menu">
						<li class="active">项目信息</li>
						<!-- <li>立项依据</li> -->
						<!-- <li>项目实施方案</li> -->
						<!-- <li>项目支出计划</li> -->
						<!-- <li>项目支出明细</li> -->
						<!-- <li>项目支出绩效目标</li> -->
					</ul>
					
					<div class="tab-content">
						<div title="项目信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						   	<%@ include file="../detail/project-detail-base-edit.jsp" %>
						</div> 
						 
						<%-- <div title="立项依据" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						   	<%@ include file="../detail/project-detail-lxyj.jsp" %>
						</div>  --%>
						
						<%-- <div title="项目实施方案" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						    <%@ include file="../detail/project-detail-xmssfa.jsp" %>
						</div> --%>
						        	
						<%-- <div title="项目支出计划" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						    <%@ include file="../project-add-plan.jsp" %>
						</div> --%>
						 	
						<%-- <div title="项目支出明细" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							<%@ include file="../detail/project-detail-outcome.jsp" %>
						</div>  --%>
						
						<%-- <div title="项目支出绩效目标" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						     <%@ include file="../project-add-goal.jsp" %>
						</div> --%>
					</div>
			
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveProject(0);">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"/>
				</a> 
				&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveProject(1);">
					<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"/>
				</a> 
				&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow();">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"/>
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
//加载tab页
flashtab_pro_add('project-transfer-tab');
	
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

function validateProjectAddBase(){
	return true;
}
	
//保存 saveType,暂存zc，申报sb
function saveProject(flowStauts){
	debugger
	//校验
	$('#project_add_form').form('enableValidation').form('validate');
	//跳转到校验失败的标签页
	openInvalidTab('project-tab');
	if (validateProjectAddBase()==false) {
		return;
	} 

	$('#project_add_form').form('submit', {
  				onSubmit: function(param){
  				 	flag=$(this).form('enableValidation').form('validate');
  					if(flag){
  						$.messager.progress();
  					}
  					return flag; 
  				}, 
  				url:base+'/project/oversave?flowStauts='+flowStauts, 
  				success:function(data){
  					if(flag){
  						$.messager.progress('close');
  					}
  					data=eval("("+data+")");
  					if(data.success){
  						$.messager.alert('系统提示', data.info, 'info');
  						$('#project_add_form').form('clear');
  						$("#pro_dg_${listid }").datagrid('reload'); 
  						closeWindow();
  					}else{
  						$.messager.alert('系统提示', data.info, 'error');
  					}
  				} 
  			});		
}
//寻找相关制度
function findSystemXmFile(id) {
	$.ajax({ 
		url: base+"/project/systemFind?id="+id, 
		success: function(data){
			data=data.replace('\"','');
			data=data.replace('\"','');
			window.open(data);
    }});
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
</script>
</body>
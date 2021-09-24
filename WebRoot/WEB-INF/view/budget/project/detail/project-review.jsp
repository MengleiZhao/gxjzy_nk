<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>



</head>
<body>



<div class="win-div">
<form id="project_review_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 559px;">
		<div class="win-left-div-ys" data-options="region:'west',split:true">
			<div class="win-left-top-div-ys">
				<div class="tab-wrapper" id="project-check-tab">
					<ul class="tab-menu">
						<li class="active">项目信息</li>
						<li>立项依据</li>
						<li>项目实施方案</li>
						<!-- <li>项目支出计划</li> -->
						<li>项目支出明细</li>
						<!-- <li>项目支出绩效目标</li> -->
						<li onclick="$('#check-history-dg').datagrid('reload')">审批记录</li>
					</ul>
					
					<div class="tab-content">
						<div title="项目信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						   	<%@ include file="project-detail-base.jsp" %>
						</div> 
						 
						<div title="立项依据" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						   	<%@ include file="project-detail-lxyj.jsp" %>
						</div> 
						
						<div title="项目实施方案" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						    <%@ include file="project-detail-xmssfa.jsp" %>
						</div> 
						        	
						<%-- <div title="项目支出计划" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						    <%@ include file="project-detail-plan.jsp" %>
						</div> --%>
						 	
						<div title="项目支出明细" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							<%@ include file="project-detail-outcome.jsp" %>
						</div> 
						<div title="审批记录"  style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						 	<%@ include file="../../../check_history.jsp" %>
						</div>
					<%-- 	<div title="项目支出绩效目标" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						     <%@ include file="project-detail-goal.jsp" %>
						</div> --%>
					</div>
				</div>
			</div>
			
			<div class="win-left-bottom-div-ys">
				<a href="javascript:void(0)" onclick="saveProject('review')">
						<img src="${base}/resource-modality/${themenurl}/button/baocun1.png"
							onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/baocun2.png')"
							onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/baocun1.png')"
						/>
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
	
	//保存 saveType,复核review
	function saveProject(saveType){
		$('#project_review_form').form('submit', {
   				onSubmit: function(param){
   					param.saveType = saveType;
   				 	flag=$(this).form('enableValidation').form('validate');
   					if(flag){
   						$.messager.progress();
   					}
   					return flag; 
   				}, 
   				url:base+'/project/saveReview', 
   				success:function(data){
   					if(flag){
   						$.messager.progress('close');
   					}
   					data=eval("("+data+")");
   					if(data.success){
   						$.messager.alert('系统提示', data.info, 'info');
   						/* if(saveType!='zc'){
   						} */
   						closeWindow();
   						$('#project_review_form').form('clear');
   						$("#pro_tz_dg").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   						/* closeWindow();
   						$('#project_review_form').form('clear'); */
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
	</script>

</body>
</html>


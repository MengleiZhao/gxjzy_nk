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
<form id="" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 559px;">
		<div class="win-left-div-ys" data-options="region:'west',split:true">
			<div class="win-left-top-div-ys">
				
				<div class="tab-wrapper" id="project-yssp-tab">
					<ul class="tab-menu">
						<li class="active">项目信息</li>
						<li>立项依据</li>
						<li>项目实施方案</li>
						<li>项目支出计划</li>
						<li>项目支出明细</li>
						<li>项目支出绩效目标</li>
					</ul>
					
					<div class="tab-content">
						<div title="项目信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						   	<%@ include file="detail/project-detail-base.jsp" %>
						</div> 
						 
						<div title="立项依据" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						   	<%@ include file="detail/project-detail-lxyj.jsp" %>
						</div> 
						
						<div title="项目实施方案" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						    <%@ include file="detail/project-detail-xmssfa.jsp" %>
						</div> 
						        	
						<div title="项目支出计划" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						    <%@ include file="detail/project-detail-plan.jsp" %>
						</div>
						
						<div title="项目支出明细" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							<%@ include file="detail/project-detail-outcome.jsp" %>
						</div> 
						
						<div title="项目支出绩效目标" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
						      <%@ include file="detail/project-detail-goal.jsp" %>
						</div>
					</div>
			
				</div>
			</div>
			
			<div class="win-left-bottom-div-ys">
			
				<a href="#" onclick="saveProjectVer('1')">
						<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				<a href="#" onclick="saveProjectVer('0')">
					<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				 <a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				<input type="hidden" name="checkResult" id="proCheckResult"/>
				<input type="hidden" name="checkRemake" id="proCheckRemake"/>
			</div>
		</div>
	
		<div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div>
	</div>
</form>
</div>




	<script type="text/javascript">
	
	flashtab('project-yssp-tab');
	
	//1通过 0不通过
	function saveProjectVer(iftg){
		
		/* var win = creatFirstWin('审批意见', 560, 370, 'icon-search', '/project/checkRemake?type=yssp&result='+iftg);
		win.window('open'); */
		var data = '${bean.FProId}';
		
		var win = creatFirstWin('审批意见', 560, 500, 'icon-search', '/declare/checkRemake?type=yssp&result='+iftg+'&data1='+data);
		win.window('open');
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


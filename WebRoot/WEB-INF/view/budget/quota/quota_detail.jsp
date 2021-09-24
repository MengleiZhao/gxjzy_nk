<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" style="width:662px;margin-left: 20px">
					<div title="指标信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;归属部门</td>

								<td class="td2">
									<!-- 隐藏域 --> 
									<!-- 主键ID --><input type="hidden" name="bId" value="${bean.bId}" />
									<!-- 指标类型 --><input type="hidden" name="indexType" value="0"/>
									<input type="hidden" id="quota_add_deptName" name="deptName" value="${bean.deptName}"/>
									<input id="project_add_departCombobox"  readonly="readonly"   name="deptCode"
						     		class="easyui-combobox" style="height:30px;width: 200px"
						     		data-options="url:'${base}/depart/getDepartCombobox?selected=${bean.deptCode}',method:'get',valueField:'code',textField:'text',editable:false,validType:'selectValid'"  />
								</td>	
								
								<td class="td3"></td>

								<td class="td1"><span class="style1">*</span>&nbsp;部门编码</td>
								<td class="td2">
									<input style="width: 200px;" id="quota_add_deptCode"  class="easyui-textbox"
									value="${bean.deptCode}" readonly="readonly"/>
								</td>
							</tr>
							
							<c:if test="${bean.indexType==1 }">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;一级名称</td>
						     	<td class="td2">
						     		<input  class="easyui-textbox" style="width: 200px"
						     		value="${bean2.firstLevelName}" readonly="readonly"/>
						     	</td>
						     	
								<td class="td3"></td>
								
								<td class="td1"><span class="style1">*</span>&nbsp;一级代码</td>
								<td class="td2">
						     		<input class="easyui-textbox" id="project_add_yjxmdm" readonly="readonly"  value="${bean2.firstLevelCode }" style="width: 200px"/>
						     	</td>
							</tr>
							</c:if>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;二级名称</td>

								<td class="td2">
									<input type="hidden" id="project_add_expItemName"  name="expItemName" value="${bean.expItemName}"/>
									<%-- <input id="project_add_subject2Combobox"  readonly="readonly" name="expItemCode"
						     		class="easyui-combobox" style="height:30px;width: 200px"
						     		data-options="url:'${base}/project/getSubject2ByPm1?selected=${bean.expItemCode}&pml=1',method:'get',valueField:'code',textField:'text',editable:false,validType:'selectValid'"  /> --%>
						     		
						     		<input class="easyui-textbox" style="width: 200px;" readonly="readonly" 
		  							id="project_add_subject2Combobox" name="expItemCode" value="${bean2.secondLevelName}"/>
								</td>	
								<td class="td3"></td>
								<td class="td1"><span class="style1">*</span>&nbsp;二级代码</td>
								<td class="td2">
									<input  id="project_add_expItemCode" style="width: 200px;"  class="easyui-textbox"
									value="${bean.expItemCode}" readonly="readonly"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;项目名称</td>
								<td class="td2">
									<input style="width: 200px;" id="project_add_indexName" class="easyui-textbox" readonly="readonly" name="indexName" value="${bean.indexName}"/>
								</td>	
								<td class="td3"></td>
								<td class="td1"><span class="style1">*</span>&nbsp;项目编码</td>
								<td class="td2">
									<input type="hidden" id="project_add_expItemCode2"  value="${bean.expItemCode2}"/>
									<input id="project_add_indexCode"  style="width: 200px;"  class="easyui-textbox" name="indexCode"
									value="${bean.indexCode}" readonly="readonly"/>
								</td>
							</tr>
						
							<tr class="trbody">
							
							<td class="td1"><span class="style1">*</span>&nbsp;指标金额</td>

								<td class="td2">
									<c:if test="${bean.indexType==0 }"><input style="width: 200px;" id="pfzAmount" name="pfzAmount"  required="required"  class="easyui-numberbox"
									data-options="precision:2,iconWidth: 30,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]" 
									value="${bean.pfAmount}" readonly="readonly"/></c:if>
									
									<c:if test="${bean.indexType==1 }"><input style="width: 200px;" id="pfzAmount" name="pfzAmount"  required="required"  class="easyui-numberbox"
									data-options="precision:2,iconWidth: 30,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]" 
									value="${bean.pfAmount}" readonly="readonly"/></c:if>
								</td>
								
								<td class="td3"></td>
								<td class="td1"><span class="style1">*</span>&nbsp;指标类型</td>
								<td class="td2">
									<c:if test="${bean.indexType==0 }"><input style="width: 200px;"  class="easyui-textbox" value="基本指标" readonly="readonly"/></c:if>
									<c:if test="${bean.indexType==1 }"><input style="width: 200px;"  class="easyui-textbox" value="项目指标" readonly="readonly"/></c:if>
								</td>	
								
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;预算年度</td>
								<td class="td2">
									<input style="width: 200px;" name="years" class="easyui-numberbox"
									value="${bean.years}" readonly="readonly"/>
								</td>
								<td class="td3"></td>
							</tr>
						</table>
					</div>
					
					<c:if test="${bean.indexType==1 }">
					<div title="资金来源" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow-x:hidden;margin-top: 10px;">
						<jsp:include page="../project/detail/project-detail-fundssource.jsp" />
					</div>
					</c:if>
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
<%-- 		<div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="applyIndex.jsp" />
		</div> --%>
	</div>
</form>
</div>

<script type="text/javascript">
//部门下拉框事件
$('#project_add_departCombobox').combobox({
    onChange:function(newValue,oldValue){
    	//设置隐藏值
        $('#quota_add_deptName').val($('#project_add_departCombobox').combobox('getText'));
    	//设置显示值
    	$('#quota_add_deptCode').textbox('setValue',$('#project_add_departCombobox').combobox('getValue'));
    	//setIndexCode();
    }
});
</script>

</body>
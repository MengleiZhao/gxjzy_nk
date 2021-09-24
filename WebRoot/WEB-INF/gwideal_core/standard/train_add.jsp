<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>

<style type="text/css">
/* .td1{
	width:200px;
	text-align:right;
}
input{
	width:100px;
} */
/* .sfwj{
	/* display:none; */
} */
</style>

<div class="win-div">
<form id="hotelstd_add_form" action="${base}/hotelStandard/save?outType=train" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="id" id="hotelstd_add_id" value="${bean.id}"/>
					<div class="easyui-accordion" style="width:662px;margin-left: 20px;">
								
						<div title="住宿费" data-options="iconCls:'icon-xxlb',collapsed:true,collapsible:true" style="overflow:auto;margin-top:10px;">
							<table class="ourtable" cellpadding="0" cellspacing="0">
								<tr class="trbody">
									<td class="td1">费用标准</td>
									<td colspan="3">
										<input id="hotelstd_add_costHotel" name="costHotel" value="${bean.costHotel }"
											class="easyui-numberbox" data-options=""/>
									</td>
								</tr>
							</table>
						</div>
								
						<div title="伙食费" data-options="iconCls:'icon-xxlb',collapsed:true,collapsible:true" style="overflow:auto;margin-top:10px;">
							<table class="ourtable" cellpadding="0" cellspacing="0">
								<tr class="trbody">
									<td class="td1">费用标准</td>
									<td colspan="3">
										<input id="hotelstd_add_costFood" name="costFood" value="${bean.costFood }"
											class="easyui-numberbox" data-options=""/>
									</td>
								</tr>
							</table>
						</div>
								
						<div title="资料、交通费" data-options="iconCls:'icon-xxlb',collapsed:true,collapsible:true" style="overflow:auto;margin-top:10px;">
							<table class="ourtable" cellpadding="0" cellspacing="0">
								<tr class="trbody">
									<td class="td1">费用标准</td>
									<td colspan="3">
										<input id="hotelstd_add_costBook" name="costBook" value="${bean.costBook }"
											class="easyui-numberbox" data-options=""/>
									</td>
								</tr>
							</table>
						</div>
								
						<div title="其他费用" data-options="iconCls:'icon-xxlb',collapsed:true,collapsible:true" style="overflow:auto;margin-top:10px;">
							<table class="ourtable" cellpadding="0" cellspacing="0">
								<tr class="trbody">
									<td class="td1">费用标准</td>
									<td colspan="3">
										<input id="hotelstd_add_costOther" name="costOther" value="${bean.costOther }"
											class="easyui-numberbox" data-options=""/>
									</td>
								</tr>
							</table>
						</div>
								
						<div title="师资费" data-options="iconCls:'icon-xxlb',collapsed:true,collapsible:true" style="overflow:auto;margin-top:10px;">
							<table class="ourtable" cellpadding="0" cellspacing="0">
								<tr class="trbody">
									<td class="td1" style="width:180px;">副高级技术职称专业人员</td>
									<td colspan="3">
										<input id="hotelstd_add_costTeach3" name="costTeach3" value="${bean.costTeach3 }"
											class="easyui-numberbox" data-options=""/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1">正高级技术职称专业人员</td>
									<td colspan="3">
										<input id="hotelstd_add_costTeach2" name="costTeach2" value="${bean.costTeach2 }"
											class="easyui-numberbox" data-options=""/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1">院士、全国知名专家</td>
									<td colspan="3">
										<input id="hotelstd_add_costTeach1" name="costTeach1" value="${bean.costTeach1 }"
											class="easyui-numberbox" data-options=""/>
									</td>
								</tr>
							</table>
						</div>
								
								
					</div>			
			</div>
			
			<div class="win-left-bottom-div">
				<c:if test="${openType=='add'||openType=='edit'}">
				<a href="javascript:void(0)" onclick="saveBean();">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				</c:if>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	</div>
</form>
</div>
<script type="text/javascript">
$(function(){
	
});
function saveBean(){
	$('#hotelstd_add_form').form('submit', {
		onSubmit: function(){ 
			flag=$(this).form('enableValidation').form('validate');
			if(flag){
				$.messager.progress();
			}
			return flag;
		}, 
		success:function(data){
			if(flag){
				$.messager.progress('close');
			}
			data=eval("("+data+")");
			if(data.success){
				$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$('#hotelstd_add_form').form('clear');
				$('#hotestd_dg').datagrid('reload'); 
			}else{
				$.messager.alert('系统提示', data.info, 'error');
			}
		} 
	});		
}
</script>
</body>
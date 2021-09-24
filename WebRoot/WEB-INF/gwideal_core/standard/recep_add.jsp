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
<form id="hotelstd_add_form" action="${base}/hotelStandard/save?outType=recep" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="id" id="hotelstd_add_id" value="${bean.id}"/>
					<div class="easyui-accordion" style="width:662px;margin-left: 20px;">
								
								
						<div title="伙食费" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
							<table class="ourtable" cellpadding="0" cellspacing="0">
								<tr class="trbody">
									<td class="td1" style="width:150px;">正餐费用</td>
									<td colspan="3">
										<input id="hotelstd_add_costFood1" name="costFood1" value="${bean.costFood1 }"
											class="easyui-numberbox" data-options=""/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1">早餐费用</td>
									<td colspan="3">
										<input id="hotelstd_add_costFood2" name="costFood2" value="${bean.costFood2 }"
											class="easyui-numberbox" data-options=""/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1">宴请费用</td>
									<td colspan="3">
										<input id="hotelstd_add_costFood3" name="costFood3" value="${bean.costFood3 }"
											class="easyui-numberbox" data-options=""/>
									</td>
								</tr>
							</table>
						</div>
						
						
						<div title="伙食费(外宾)" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
							<table class="ourtable" cellpadding="0" cellspacing="0">
								<tr class="trbody">
									<td class="td1" style="width:150px;">正、副部长级人员出面举办的宴会</td>
									<td colspan="3">
										<input id="hotelstd_add_costFood4" name="costFood4" value="${bean.costFood4 }"
											class="easyui-numberbox" data-options=""/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1">厅局级及以人员出面举办的宴会</td>
									<td colspan="3">
										<input id="hotelstd_add_costFood5" name="costFood5" value="${bean.costFood5 }"
											class="easyui-numberbox" data-options=""/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1">冷餐</td>
									<td colspan="3">
										<input id="hotelstd_add_costFood6" name="costFood6" value="${bean.costFood6 }"
											class="easyui-numberbox" data-options=""/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1">酒会</td>
									<td colspan="3">
										<input id="hotelstd_add_costFood7" name="costFood7" value="${bean.costFood7 }"
											class="easyui-numberbox" data-options=""/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1">茶会</td>
									<td colspan="3">
										<input id="hotelstd_add_costFood8" name="costFood8" value="${bean.costFood8 }"
											class="easyui-numberbox" data-options=""/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1">日常伙食</td>
									<td colspan="3">
										<input id="hotelstd_add_costFood9" name="costFood9" value="${bean.costFood9 }"
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
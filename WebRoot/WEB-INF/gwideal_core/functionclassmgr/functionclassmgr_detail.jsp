<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="function_class_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 309px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div" style="height: 200px">
				<div class="easyui-accordion" style="width:662px;margin-left: 20px;">
					<div title="功能分类科目信息" id="djdxqDiv" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
						<table class="ourtable">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>科目名称</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fecName" readonly="readonly" name="fecName"  required="required" data-options="validType:'length[1,20]'" style="width: 150px" value="${bean.fecName}"/>
									<input type="hidden" name="fmId" id="F_fmId" value="${bean.fmId}"/><!--隐藏域  -->
								</td>
								<td style="width: 50px">&nbsp;</td>
								<td class="td1"><span class="style1">*</span>科目编码</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fecCode" readonly="readonly" name="fecCode"  required="required" data-options="validType:'length[1,20]'" style="width: 150px" value="${bean.fecCode}"/>
								</td>
							</tr>			
							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>科目说明</td>
								<td colspan="4">
									<input class="easyui-textbox" type="text" id="F_fecDesc" readonly="readonly" name="fecDesc"  data-options="validType:'length[1,50]',multiline:true"  style="width:510px;height:70px;" value="${bean.fecDesc}"/>
								</td>
							</tr>		
	
						</table>
					</div>
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/img/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<%-- <div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div> --%>
	</div>
</form>
</div>
<script type="text/javascript">
	//保存
	function saveSupplier() {
		//提交
		$('#function_class_form').form('submit', {
			onSubmit : function() {
				flag = $(this).form('enableValidation').form('validate');
				if (flag) {
					$.messager.progress();
				}
				return flag;
			},
			url : base + '/finctionclassmgrgl/save',
			success : function(data) {
				if (flag) {
					$.messager.progress('close');
				}
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					//$("#function_class_form").form("clear");
					 $("#function_class_tab").datagrid("reload");
				} else {
					$.messager.alert('系统提示', data.info, 'error');
					closeWindow();
					$('#function_class_form').form('clear');
				}
			}
		});	
	}
		
	</script>
</body>
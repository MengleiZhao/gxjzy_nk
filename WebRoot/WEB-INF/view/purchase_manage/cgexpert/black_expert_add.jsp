<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="expert_black_add_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 420px;">
		<div class="win-left-div" data-options="region:'west',split:true" style="width:470px;">
			<div style="height: 360px;">
				<div class="easyui-accordion" data-options="" id="" style="width:438px;margin-left: 20px;">
					<table cellpadding="0" cellspacing="0"  border="0">
						<tr>
							<td colspan="4">
								<a style="color: #bb1b34;font-size: 20px;">确认要移入黑名单吗?</a>
							</td>
						</tr>
						<tr>
							<td class="td1" colspan="4"><span class="style1">*</span>移入原因描述（必填）</td>
						</tr>
						<tr style=" width: 430px;height: 70px;">
							<td colspan="4">
								<textarea name="fblackDesc"  id="F_fblackDesc"  class="textbox-text"  oninput="textareaNum(this,'textareaNum1')" autocomplete="off"   style="width:430px;height:70px;resize:none">${bean.fblackDesc }</textarea> 
     					
								<%-- <input class="easyui-textbox" type="text" id="F_fblackDesc"  name="fblackDesc"  data-options="prompt: '200字以内' ,validType:'length[1,200]',multiline:true"   style="width:430px;height:70px;" value="${bean.fblackDesc}"/>
								 --%>
								<input type="hidden" name="feId" value="${feid}" /><!--隐藏域  专家库的主键id  -->
								<input type="hidden" name="fFlag" value="2" /><!--隐藏域  移ru黑名单标识  -->
								
							</td>
						</tr>
						<tr>
							<td align="right" colspan="6" style="padding-right: 00px;">
							可输入剩余数：<span id="textareaNum1" class="200">
								<c:if test="${empty bean.fblackDesc}">200</c:if>
								<c:if test="${!empty bean.fblackDesc}">${200-bean.fblackDesc.length()}</c:if>
							</span>
							</td>
						</tr>
						<tr style="height: 50px">
							<td colspan="2">
								<hr style="color: #b1b1b1;height:1px;border:none;border-top:1px solid #b1b1b1;"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
			
			<div style="border: 0px;height: 45px;line-height: 45px;text-align: center;">
				<a href="javascript:void(0)" onclick="saveBlackExpert()">
				<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;

				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		<div class="win-right-div" id="check_system_div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div>
	</div>
</form>
</div>
	<script type="text/javascript">
	//保存
	function saveBlackExpert() {
		 //提交
		$('#expert_black_add_form').form('submit', {
			onSubmit : function() {
				flag = $(this).form('enableValidation').form('validate');
				if (flag) {
					$.messager.progress();
				}
				return flag;
			},
			url : base + '/blackexpertgl/moveintoblack',
			success : function(data) {
				if (flag) {
					$.messager.progress('close');
				}
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					//$("#expert_black_add_form").form("clear");
					 $("#expert_tab").datagrid("reload");
				} else {
					$.messager.alert('系统提示', data.info, 'error');
					closeWindow();
					$('#expert_black_add_form').form('clear');
				}
			}
		}); 	
	}
		
	</script>
</body>
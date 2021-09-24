<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="easyui-layout" fit="true">
<form id="purchase_cata_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div style="width:660px;border-color: #dce5e9;margin-left: 20px">
		<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
			<tr>
				<td class="td1"><span class="style1">*</span>目录名称</td>
				<td class="td2">
					<input class="easyui-textbox" type="text" id="F_fpurName"  name="fpurName"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fpurName}"/>
					<input type="hidden" name="fId" id="F_fId" value="${bean.fId}"/><!--隐藏域  -->
				</td>
				<td style="width: 0px"></td>
				<td class="td1"><span class="style1">*</span>目录编码</td>
				<td class="td2">
					<input class="easyui-textbox" type="text" id="F_fpurCode"  name="fpurCode"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fpurCode}"/>
				</td>
			</tr>
			<tr>
				<td class="td1"><span class="style1">*</span>目录级别</td>
				<td class="td2">
					<select class="easyui-combobox" id="F_flevel" name="flevel" required="required" readonly="readonly"  style="width: 200px;" data-options="editable:false,panelHeight:'auto'">
						<option value="1" <c:if test="${bean.flevel=='1'}">selected="selected"</c:if>>一级科目</option>
						<option value="2" <c:if test="${bean.flevel=='2'}">selected="selected"</c:if>>二级科目</option>
						<option value="3" <c:if test="${bean.flevel=='3'}">selected="selected"</c:if>>三级科目</option>
					</select>
				</td>
				<td style="width: 0px"></td>
				<td class="td1"><span class="style1">*</span>上级目录编码</td>
				<td class="td2">
					<input class="easyui-textbox" type="text" id="F_fpPurCode"  name="fpPurCode"  readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fpPurCode}"/>
				</td>
			</tr>
			<tr>
				<td class="td1"><span class="style1">*</span>计量单位</td>
				<td class="td2" colspan="3">
					<input class="easyui-textbox" type="text" id="F_fmeasureUnit"  name="fmeasureUnit"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fmeasureUnit}"/>
				</td>
			</tr>
			<tr style="height: 70px;">
				<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>备注</td>
				<td colspan="4">
					 <textarea name="fremark"  id="F_fremark"  class="textbox-text"  oninput="textareaNum(this,'textareaNum1')" autocomplete="off"   style="width:555px;height:70px;resize:none">${bean.fremark }</textarea>
					<%-- <input class="easyui-textbox" type="text" id="F_fremark"  name="fremark"  data-options="validType:'length[1,50]',multiline:true"  style="width:555px;height:70px;" value="${bean.fremark}"/> --%>
				</td>
			</tr>
			<tr>
				<td align="right" colspan="5" style="padding-right: 0px;">
				可输入剩余数：<span id="textareaNum1" class="200">
					<c:if test="${empty bean.fremark}">200</c:if>
					<c:if test="${!empty bean.fremark}">${200-bean.fremark.length()}</c:if>
				</span>
				</td>
			</tr>
		</table>
	</div>
					
		
		
			
	<div  style="height: 91px;width: 100%; border: 0px;text-align: center;line-height: 91px" >
		<a href="javascript:void(0)" onclick="saveSupplier()">
			<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>&nbsp;&nbsp;&nbsp;
		<a href="javascript:void(0)" onclick="closeWindow()">
			<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
	</div>
</form>
</div>
<script type="text/javascript">
//保存
function saveSupplier() {
	//提交
	$('#purchase_cata_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}
			return flag;
		},
		url : base + '/purchaseCatagl/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				//$("#purchase_cata_form").form("clear");
				$('#CgCataTree').tree('reload');//重新加载tree
				$("#purchase_cata_tab").datagrid("reload");
			} else {
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#purchase_cata_form').form('clear');
			}
		}
	});	
}
	
</script>
</body>


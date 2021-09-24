<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
	<tr>
		<td class="td1">代理机构</td>
		<td class="td2">
				<input class="easyui-textbox" type="text" id="F_fagentName" readonly="readonly" name="fagentName" data-options="validType:'length[1,20]'" style="width: 200px" value="${br.fagentName}"/>
		</td>
		
		<td class="td4"></td>
		
		<td class="td1">法人代表</td>
		<td class="td2">
				<input class="easyui-textbox" type="text" id="F_ftendUser" readonly="readonly" name="ftendUser" data-options="validType:'length[1,20]'" style="width: 200px" value="${br.ftendUser}"/>
		</td>
	</tr>
	
	
	<tr>
		<td class="td1">联系人</td>
		<td class="td2">
				<input class="easyui-textbox" type="text" id="F_fagentUser" readonly="readonly" name="fagentUser" data-options="validType:'length[1,20]'" style="width: 200px" value="${br.fagentUser}"/>
		</td>
		
		<td style="width: 0px"></td>
		
		<td class="td1">联系人电话</td>
		<td class="td2">
				<input class="easyui-textbox" type="text" id="F_fagentUserTel" readonly="readonly" name="fagentUserTel" data-options="validType:'tel'" style="width: 200px" value="${br.fagentUserTel}"/>
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1">代理机构地址</td>
		<td colspan="4">
			<input class="easyui-textbox" type="text" id="F_fagentAddr" readonly="readonly" name=fagentAddr data-options="validType:'length[1,100]'" style="width:555px;" value="${br.fagentAddr}"/>
		</td>
	</tr>
	<tr style="height: 78px;">
		<td class="td1" valign="top">备注</td>
		<td colspan="4">
			<textarea name="fagentFax"  id="F_fagentFax"  class="textbox-text"  oninput="textareaNum(this,'textareaNum2')" autocomplete="off"   style="width:555px;height:70px;resize:none">${br.fagentFax }</textarea>
			<%-- <input class="easyui-textbox" type="text" id="F_fagentFax" readonly="readonly" name="fagentFax" data-options="validType:'length[1,200]',multiline:true"   style="width:555px;height:70px;" value="${br.fagentFax}"/>
		 --%>
		</td>
	</tr>
	<c:if test="${operType=='add'||operType=='edit' }">
		<tr>
			<td align="right" colspan="6" style="padding-right: 00px;">
			可输入剩余数：<span id="textareaNum2" class="200">
				<c:if test="${empty br.fagentFax}">200</c:if>
				<c:if test="${!empty br.fagentFax}">${200-br.fagentFax.length()}</c:if>
			</span>
			</td>
		</tr>
	</c:if>
</table>
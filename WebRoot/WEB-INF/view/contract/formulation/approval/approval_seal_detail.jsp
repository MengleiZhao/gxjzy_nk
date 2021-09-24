<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="win-div">
<form id="ApprovalSealForm" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" style="width: 780px" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" style="width:662px;margin-left: 20px">
					<div title="盖章信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;">
						<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
							<tr>
								<td class="td1"><span class="style1">*</span>&nbsp;盖章人</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_AppUserName" name="fappUserName" readonly="readonly" required="required" data-options="validType:'length[1,30]'" style="width: 200px" value="${siBean.fappUserName }"/>
								</td>
								<td class="td4">
									<!-- 盖章类主键 --><input type="hidden" id="F_SId" name="fsId" value="${siBean.fsId }"/>
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;盖章时间</td>
								<td class="td2">
									<input class="easyui-datebox" id="F_AppTime" name="fappTime" readonly="readonly" required="required" data-options="validType:'length[1,30]'" style="width: 200px" value="${siBean.fappTime }"/>
								</td>
							</tr>
							
							<tr>
								<td class="td1"><span class="style1">*</span>&nbsp;印鉴类型</td>
								<td class="td2">
									<input class="easyui-combobox" id="F_SealType" name="fsealType" readonly="readonly" required="required" style="width: 200px" data-options="editable:false,panelHeight:'auto',url:'${base}/Formulation/lookupsJson?parentCode=HTGZLX&selected=${siBean.fsealType}',method:'POST',valueField:'code',textField:'text',editable:false,validType:'selectValid'"/>
								</td>
								<td class="td4">&nbsp;</td>
								<td class="td1"><span class="style1">*</span>&nbsp;印鉴名称</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_SealName" name="fsealName" readonly="readonly" required="required" data-options="validType:'length[1,30]'" style="width: 200px" value="${siBean.fsealName }"/>
								</td>
							</tr>
							
							<tr style="height: 70px;">
								<td class="td1" valign="top">&nbsp;&nbsp;备注</td>
								<td colspan="4">
									<textarea class="textbox-text" id="F_Remark" name="fremark" readonly="readonly" oninput="textareaNum(this,'textareaNum1')" autocomplete="off" style="width:555px;height:70px;resize:none">${siBean.fremark }</textarea>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="closeFirstWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		
		<%-- <div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../../check_system.jsp" />
		</div> --%>
	</div>
</form>
</div>
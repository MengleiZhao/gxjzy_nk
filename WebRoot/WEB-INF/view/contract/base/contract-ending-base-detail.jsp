<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
					<div class="easyui-accordion" data-options="multiple:true" style="width:662px;margin-left: 0px;">
						<div title="" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
							<input hidden="hidden" type="text" id="end_fEndId" name="fEndId" value="${end.fEndId}"/>
							<input hidden="hidden" type="text" id="end_stauts" name="stauts" value="${end.stauts}"/>
							<input hidden="hidden" type="text" id="end_endStauts" name="endStauts" value="${end.endStauts}"/>
							<input hidden="hidden" type="text" id="end_fEndCode" name="fEndCode" value="${end.fEndCode}"/>
							<input hidden="hidden" type="text" id="end_fEndUserIds" name="fEndUserId" value="${end.fEndUserId}"/>
							<input hidden="hidden" type="text" id="end_fEndDept" name="fEndDept" value="${end.fEndDept}"/>
							<input hidden="hidden" type="text" id="end_fcontId" name="fcontId" value="${end.fcontId}"/>
							<input hidden="hidden" type="text" id="remakeValue" name="fremark" />
							<table cellpadding="0" cellspacing="0"  class="ourtable">
								<tr class="trbody">
									<td class="td1"><span class="style1">*</span>&nbsp;申请人</td>
									<td class="td2">
										<input class="easyui-textbox" readonly="readonly" required="required" id="end_fEndUser" type="text" name="fEndUser" data-options="validType:'length[1,20]',precision:0"   style="width: 200px" value="${end.fEndUser}">
									</td>
									<td class="td4">&nbsp;</td>
									<td class="td1"><span class="style1">*</span>&nbsp;申请时间</td>
									<td class="td2">
										<input id="end_fEndTime"  class="easyui-datebox" readonly="readonly" required="required" name="fEndTime"  style="width: 200px" value="${end.fEndTime}"/>
									</td>
								</tr>
								<tr class="trbody" style="height: 110px;" >
									<td class="td1" ><span class="style1">*</span>&nbsp;终止原因</td>
									<td colspan="4">
										<input class="easyui-textbox" readonly="readonly" required="required" type="text" id="end_fEndRemark" name="fEndRemark" data-options="validType:'length[1,100]',multiline:true"   style="width:555px;height:100px" value="${end.fEndRemark}"/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1"><span class="style1">*</span>&nbsp;终止类型</td>
									<td>
										<input class="easyui-combobox" readonly="readonly" required="required" id="end_fEndType" name="fEndType" style="width: 200px" data-options="editable:false,panelHeight:'auto',url:'${base}/Formulation/lookupsJson?parentCode=HTZZ&selected=${end.fEndType}',method:'POST',valueField:'code',textField:'text',editable:false,validType:'selectValid'">
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1">
										&nbsp;&nbsp;附件
										<input type="file" multiple="multiple" id="fhtzz" onchange="upladFileParams(this,'htzz','htgl01','progressNumberhtbghtzz','percenthtzz','tdfhtzz','endingFiles','progidhtzz')" hidden="hidden">
										<input type="text" id="endingFiles" name="endingFiles" hidden="hidden">
									</td>
									<td colspan="4" id="tdfhtzz">
										<%-- <c:if test="${openType=='Endadd'||openType=='Endedit'}">
										<a onclick="$('#fhtzz').click()" style="font-weight: bold;" href="#">
											<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
										</a>
										</c:if>
										<div id="progidhtzz" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
										<div id="progressNumberhtbghtzz" style="background:#3AF960;width:0px;height:10px" >
										</div>文件上传中...&nbsp;&nbsp;<font id="percenthtzz">0%</font></div></br> --%>
										<c:forEach items="${endingAttaList}" var="att">
											<c:if test="${att.serviceType=='htzz' }">
												<div style="margin-top: 10px;">
													<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
													&nbsp;&nbsp;&nbsp;&nbsp;
													<%-- <c:if test="${openType=='Endadd'||openType=='Endedit'}">
													<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
													&nbsp;&nbsp;&nbsp;&nbsp;
														<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
													</c:if> --%>
												</div>
											</c:if>
										</c:forEach>
									</td>
								</tr>
							</table>
						</div>
					</div>
<script type="text/javascript">

</script>
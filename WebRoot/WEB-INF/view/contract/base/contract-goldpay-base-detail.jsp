<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
					<div class="easyui-accordion" data-options="multiple:true" style="width:662px;margin-left: 0px;">
						<div  data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
							<table cellpadding="0" cellspacing="0"  class="ourtable">
								<tr class="trbody">
									<td class="td1"><span class="style1">*</span>&nbsp;付款金额</td>
									<td>
										<input id="goldpay_fPayAmount" required="required" class="easyui-numberbox"  readonly="readonly" name="fPayAmount" data-options="validType:'length[1,20]',icons: [{iconCls:'icon-yuan'}],precision:2" style="width: 200px" 
											<c:if test="${openType=='Gdetail'}">value="${goldPay.fPayAmount}"</c:if>
											<c:if test="${openType=='Gedit'}">value="${bean.fMarginAmount}"</c:if>
											<c:if test="${openType=='detail'}">value="${goldPay.fPayAmount}"</c:if>
										/>
									</td>
									<td class="td4">&nbsp;</td>
									<td class="td1"><span class="style1">*</span>&nbsp;保证金类型</td>
									<td>
										<input class="easyui-combobox" id="goldpay_fWarType" readonly="readonly" required="required" name="fWarType" style="width: 200px" data-options="editable:false,panelHeight:'auto',url:'${base}/Formulation/lookupsJson?parentCode=HTBZJLX&selected=${goldPay.fWarType}',method:'POST',valueField:'code',textField:'text',editable:false,validType:'selectValid'">
									</td>
								</tr>
								<tr class="trbody" style="height: 110px">
									<td class="td1"><span class="style1">*</span>&nbsp;付款说明</td>
									<td colspan="4" >
										<input  class="easyui-textbox" readonly="readonly" required="required" id="Dis_fPayRemark" name="fPayRemark" data-options="validType:'length[1,200]',multiline:true" style="width: 555px;height:100px;" value="${goldPay.fPayRemark}"/>
									</td>
								</tr>
								<!-- <tr class="trbody">
									<td class="td1">付款说明</td>
									<td colspan="4">
										<input  type="text" id="xxx" oninput="nihao(this)"  style="width: 505px;height:100px" }"/>
									</td>
								</tr> -->
								<tr class="trbody">
										<td class="td1">
											&nbsp;&nbsp;附件
											<input type="file" multiple="multiple" id="fhtbzj" onchange="upladFileParams(this,'htbzj','htgl01','progressNumberhtbzj','percenthtbzj','tdfhtbzj','fhtbzjFiles','progidhtbzj')" hidden="hidden">
											<input type="text" id="fhtbzjFiles" name="fhtbzjFiles" hidden="hidden">
										</td>
										<td colspan="4" id="tdfhtbzj">
											<%-- <c:if test="${openType=='Gadd'||openType=='Gedit'}">
											<a onclick="$('#fhtbzj').click()" style="font-weight: bold;" href="#">
												<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
											</a>
											</c:if> --%>
											<div id="progidhtbzj" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
											<div id="progressNumberhtbzj" style="background:#3AF960;width:0px;height:10px" >
											</div>文件上传中...&nbsp;&nbsp;<font id="percenthtbzj">0%</font></div></br>
											<c:forEach items="${goldAttaList}" var="att">
												<c:if test="${att.serviceType=='htbzj' }">
													<div style="margin-top: 10px;">
														<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
														&nbsp;&nbsp;&nbsp;&nbsp;
														<%-- <c:if test="${openType=='Gadd'||openType=='Gedit'}">
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
$('#Dis_fPayRemark').textbox({
	onChange :function (newVal,oldVal){
	}
}); 
/* function nihao(val){
	console.log(val.textLength)
} */


</script>
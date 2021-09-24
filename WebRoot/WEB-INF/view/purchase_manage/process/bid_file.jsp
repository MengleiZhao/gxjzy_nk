<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
	<div class="window-div">
		<div class="window-left-div" style="width:370px;height: 370px;border: 1px solid #D9E3E7;margin-top: 10px;">
			<div class="win-left-top-div">
				<div class="tab-wrapper" id="yx-tab">
					<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
						<div title="采购登记附件" style="margin-bottom:35px;width: 737px" >
							<table>
								<tr>
									<td class="td1" style="width:60px;">
										附件
										<input type="file" multiple="multiple" id="f" onchange="upladFile(this,'supplier','cggl01')" hidden="hidden">
									</td>
									<td colspan="3" id="tdf">
										<c:forEach items="${brAttac}" var="att">
											<c:if test="${att.serviceType=='supplier'}">
												<div style="margin-top: 0px;">
													<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
												</div>
											</c:if>	
										</c:forEach>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="window-left-bottom-div" >
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
			
		</div>
	</div>
</body>
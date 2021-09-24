<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<form id="cgsq_apply_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div">
				<!-- 隐藏域 --> 
				<input type="hidden" name="nCode" value="${bean.nCode}"/>
				<input type="hidden" name="fpId"  value="${bean.fpId}"/>
				<input type="hidden" id="F_fUser"  name="fUser"  value="${bean.fUser}"/>
				<input type="hidden" name="fplId" id="F_fplId" value="${bean.fplId}"/><!-- 配置计划的主键id（读取） -->
				<input type="hidden" name="fCheckStauts" id="F_fCheckStauts" value="${bean.fCheckStauts}"/><!--采购审批状态  -->
				<input type="hidden" name="fStauts" id="F_fStauts" value="${bean.fStauts}"/><!--采购数据的删除状态  -->
				<input type="hidden" name="fIsReceive" id="F_fIsReceive" value="${bean.fIsReceive}"/><!--验收状态  -->
				<input type="hidden" name="fbidStauts" id="F_fbidStauts" value="${bean.fbidStauts}"/><!--中标状态  -->
				<input type="hidden" name="fpayStauts" id="F_fpayStauts" value="${bean.fpayStauts}"/><!--付款申请的审批状态  -->
				<input type="hidden" name="fevalStauts" id="F_fevalStauts" value="${bean.fevalStauts}"/><!--供应商的评价状态  -->
				<input type="hidden" name="indexId" id="F_fBudgetIndexCode" value="${bean.indexId}"/><!-- 指标ID -->
				<input type="hidden" name="indexType" id="F_indexType" value="${bean.indexType}"/><!--采购指标type  -->
				<input type="hidden" name="orgType" id="orgType" value="${bean.orgType}"/><!--采购组织形式  -->
				<!-- 项目支出明细ID --><input type="hidden" id="F_proDetailId" name="proDetailId" value="${bean.proDetailId}"/>
				<!-- 可用金额  --><input type="hidden" id="syAmount" value="${bean.syAmount}"/>
				<!-- 批复金额  --><input type="hidden" id="pfAmount" value="${bean.pfAmount}"/>
				<!-- 批复时间  --><input type="hidden" id="pfDate"  value="${bean.pfDate}"/>
				<!-- 流程id  --><input type="hidden" id="flowId"  value="${fpId}"/>
				<!-- 服务流程id  --><input type="hidden" id="hwfpId"  value="${fpId}"/>
				<!-- 工程流程id  --><input type="hidden" id="gcfpId"  value="${gcfpId}"/>
				<!-- 下一级审批节点  --><input type="hidden" id="nextKey"  value="${bean.nCode}"/>
				<!--历史审批节点  --><input type="hidden" id="historyNodes"  value="${historyNodes}"/>
				<!-- 是否集中采购 --><input type="hidden"  id="isZc" value="${isZc}"/>
				
				<!-- 预算信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="预算信息" data-options="collapsible:false" style="overflow:auto;height: 150px;margin-left: 0px;">				
						<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width: 707px">
							<tr class="trbody">
								<td style="width: 70px;text-align: left;"><span class="style1">*</span> 支出项目</td>
								<td colspan="3" style="">
									<a onclick="openIndex()" href="#">
									<input class="easyui-textbox" style="width: 642px;height: 30px;"
									name="indexName" value="${bean.indexName}" id="F_fBudgetIndexName"
									data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
									</a>
								</td>
							</tr>
						</table>	
						<table class="window-table-readonly" cellspacing="0" cellpadding="0" style="margin-left: 0px;width:707px;height: 50px;">
								<tr>
									<td class="window-table-td1"><p>批复金额：</p></td>
									<td class="window-table-td2"><p id="p_pfAmount">${bean.pfAmount}元</p></td>
									
									<td class="window-table-td1"><p>预算年度：</p></td>
									<td class="window-table-td2"><p id="p_pfDate">${bean.pfDate}</p></td>
								</tr>
								
								<tr>
									<td class="window-table-td1"><p>可用额度：</p></td>
									<td class="window-table-td2"><p id="p_syAmount">${bean.syAmount}元</p></td>
									
									<%-- <td class="window-table-td1"><p>累计支出:</p></td>
									<td class="window-table-td2"><p id="p_syAmount">${bean.syAmount}万元</p></td> --%>
								</tr>
						</table>				
					</div>
				</div>
				
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="采购信息" data-options=" collapsible:false" style="overflow:auto;">
						<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
							<tr class="trbody" hidden="hidden">
								<td class="td1" style="width: 70px"><span class="style1">*</span>&nbsp;采购批次编号</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fpCode" readonly="readonly" name="fpCode"  style="width:220px;height: 30px" value="${bean.fpCode}"/>
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;申请时间</td>
								<td class="td2">
									<input class="easyui-datebox" class="dfinput" id="F_fReqTime" name="fReqTime" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 220px;height: 30px" value="${bean.fReqTime}"/>
								</td>			
								
							</tr>
	
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;申请部门</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fDeptName" readonly="readonly" required="required" name="fDeptName" data-options="validType:'length[1,20]'" style="width: 220px;height: 30px" value="${bean.fDeptName}"/>
								</td>
								
								<td class="td1"><span class="style1">*</span>&nbsp;申请人</td>
								<td class="td2">
									<input id="F_fUserName" class="easyui-textbox" type="text" readonly="readonly" required="required" name="fUserName" data-options="validType:'length[1,20]'" style="width: 220px;height: 30px" value="${bean.fUserName}"/>
								</td>
								
							</tr>
							
							<tr class="trbody">
								<td class="td1" style="width:70px;"><span class="style1">*</span>&nbsp;是否政府采购</td>
								<td class="td2">
         							<input type="radio" name="fIsGovern"  readonly="readonly" <c:if test="${bean.fIsGovern=='1'}">checked="checked"</c:if> value="1" onclick="governYes()">是
         							<input type="radio" name="fIsGovern"  readonly="readonly" <c:if test="${bean.fIsGovern!='1'}">checked="checked"</c:if> value="0" onclick="governNo()">否
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1" style="width:70px;"><span class="style1">*</span>&nbsp;是否进口</td>
								<td class="td2">
         							<input type="radio" name="fIsImp"  readonly="readonly" <c:if test="${bean.fIsImp=='1'}">checked="checked"</c:if> value="1" onclick="impYes()">是
         							<input type="radio" name="fIsImp"  readonly="readonly" <c:if test="${bean.fIsImp!='1'}">checked="checked"</c:if> value="0" onclick="impNo()">否
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1" ><span class="style1">*</span>&nbsp;是否订立合同</td>
								<td class="td2">
									<input type="radio" name="fIsContract"  readonly="readonly" <c:if test="${bean.fIsContract!='0'}">checked="checked"</c:if> value="1">是
         							<input type="radio" name="fIsContract"  readonly="readonly" <c:if test="${bean.fIsContract=='0'}">checked="checked"</c:if> value="0">否
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;采购名称</td>
								<td colspan="4">
									<input class="easyui-textbox" type="text" id="F_fpName"  name="fpName" required="required" data-options="validType:'length[1,20]'" style="width: 576px;height: 30px" value="${bean.fpName}"/>
								</td>
							</tr>
							
							<tr class="trbody">
								
								<td class="td1"><span class="style1">*</span>&nbsp;采购金额</td>
								<td class="td2">
									<input class="easyui-numberbox" id="F_fpAmount"  name="fpAmount" required="required" data-options="validType:'length[1,20]',iconWidth: 22,icons: [{iconCls:'icon-yuan'}]" style="width: 220px;height: 30px" value="${bean.fpAmount}"/>
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;采购方式</td>
								<td class="td2">
									<select class="easyui-combobox" id="F_fpMethod"  name="fpMethod" required="required" data-options="editable:false,validType:'length[1,20]'" style="width: 220px;height: 30px">
										<option value="">--请选择--</option>
										<option value="GKZB" <c:if test="${bean.fpMethod=='GKZB'}">selected="selected"</c:if>>公开招标</option>
										<option value="YQZB" <c:if test="${bean.fpMethod=='YQZB'}">selected="selected"</c:if>>邀请招标</option>
										<option value="JZXCS" <c:if test="${bean.fpMethod=='JZXCS'}">selected="selected"</c:if>>竞争性磋商</option>
										<option value="JZXTP" <c:if test="${bean.fpMethod=='JZXTP'}">selected="selected"</c:if>>竞争性谈判</option>
										<option value="DYLYCG" <c:if test="${bean.fpMethod=='DYLYCG'}">selected="selected"</c:if>>单一来源采购</option>
										<option value="WSCS" <c:if test="${bean.fpMethod=='WSCS'}">selected="selected"</c:if>>网上超市</option>
										<option value="XYDDCG" <c:if test="${bean.fpMethod=='XYDDCG'}">selected="selected"</c:if>>协议定点采购</option>
									</select>
								</td>
							</tr> 
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;采购组织形式</td>
									<td class="td2" id="org1" hidden="hidden">
										<select class="easyui-combobox" id="orgType1" required="required" style="width: 220px;height: 30px" data-options="editable:false,panelHeight:'auto'" validType="selectValueRequired['#test']">
											<option value="">--请选择--</option>
											<option value="JZCG" <c:if test="${bean.orgType=='JZCG'}">selected="selected"</c:if>>集中采购</option>
											<option value="FSCG" <c:if test="${bean.orgType=='FSCG'}">selected="selected"</c:if>>分散采购</option>
										</select>	
									</td>
									<td class="td2" id="org2">
										<select class="easyui-combobox" id="orgType2" required="required" style="width: 220px;height: 30px" data-options="editable:false,panelHeight:'auto'" validType="selectValueRequired['#test']">
											<option value="">--请选择--</option>
											<option value="ZXCG" <c:if test="${bean.orgType=='ZXCG'}">selected="selected"</c:if>>自行采购</option>
										</select>
									</td>
								<td class="td1"><span class="style1">*</span>&nbsp;采购品目目录</td>
								<td class="td2">
										<select class="easyui-combobox" id="fItems" name="fItems" required="required" style="width: 220px;height: 30px" data-options="editable:false,panelHeight:'auto'" validType="selectValueRequired['#test']">
											<option value="">--请选择--</option>
											<option value="A" <c:if test="${bean.fItems=='A'}">selected="selected"</c:if>>货物</option>
											<option value="B" <c:if test="${bean.fItems=='B'}">selected="selected"</c:if>>工程</option>
											<option value="C" <c:if test="${bean.fItems=='C'}">selected="selected"</c:if>>服务</option>
											<%-- <option value="A40" <c:if test="${bean.fItems=='A40'}">selected="selected"</c:if>>办公用品及耗材</option> --%>
										</select>												
								</td>
							</tr>
	
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;采购品目明细</td>
								<td colspan="4">
								<a onclick="chooseItems()" href="#">
									<input class="easyui-textbox" type="text" id="fItemsDetail"  name="fItemsDetail" readonly="readonly" data-options="prompt: '选择细目' ,icons: [{iconCls:'icon-sousuo'}]"  style="width: 576px;height: 30px" value="${bean.fItemsDetail}"/>
								</a>
								</td>
								<input type="hidden" name="fItemsDetailIds" id="fItemsDetailIds" value="${bean.fItemsDetailIds}"/>
							</tr>
	
							
						 	
							
							<tr>
								<td class="td1" valign="top"><span class="style1">*</span>&nbsp;申请理由</td>
								<td colspan="4">
									<textarea name="fRemark"  id="F_fRemark"  class="textbox-text"   style="width:570px;height:70px;resize:none;border-radius: 5px;border: 1px solid #D9E3E7; margin-top:5px; margin-bottom:0px;">${bean.fRemark}</textarea>
								</td>
							</tr>
							
							
							<tr>
								<td class="td1" style="width:75px;">
									采购清单 <input type="file" multiple="multiple" id="cgqd" accept=".xlsx,.xls"
									onchange="upladFileMoreParams(this,'cgqd','cggl02','cgqdprogressNumber','cgqdpercent','cgqdtdf','cgqdfiles','cgqdprogid','cgqdfileUrl')" hidden="hidden"> <input
									type="text" id="cgqdfiles" name="cgqdfiles" hidden="hidden"></td>
								<td colspan="3" id="cgqdtdf">&nbsp;&nbsp; <a onclick="$('#cgqd').click()"
									style="font-weight: bold;  " href="#"> <img
										style="vertical-align:bottom;margin-bottom: 5px;"
										src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"
										onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
									</a>
									&nbsp;&nbsp; 
									<%-- <a style="font-weight: bold;  " href="${base }/cgsqsp/cgqdDownload"> 
										<img style="vertical-align:bottom;margin-bottom: 5px;" src="${base}/resource-modality/${themenurl}/button/mbxz1.png"
										onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
									</a> --%>
									<div id="cgqdprogid"
										style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none">
										<div id="cgqdprogressNumber"
											style="background:#3AF960;width:0px;height:10px"></div>
										文件上传中...&nbsp;&nbsp;<font id="cgqdpercent">0%</font>
									</div> <c:forEach items="${attac}" var="att">
									<c:if test="${att.serviceType=='cgqd' }">
										<div style="margin-top: 5px;">
											<a href='${base}/attachment/download/${att.id}'
												style="color: #666666;font-weight: bold;">${att.originalName}</a>
											&nbsp;&nbsp;&nbsp;&nbsp; <img style="margin-top: 5px;"
												src="${base}/resource-modality/${themenurl}/sccg.png">
											&nbsp;&nbsp;&nbsp;&nbsp; <a id="${att.id}" class="cgqdfileUrl" href="#"
												style="color:red" onclick="deleteAttac(this)">删除</a>
										</div>
									</c:if>
									</c:forEach>
								</td>
							</tr>
							
							<tr>
								<td class="td1" style="width:75px;">
									需求文件<input type="file" multiple="multiple" id="xqwj" accept=".pdf"
									onchange="upladFileMoreParams(this,'xqwj','cggl02','xqwjprogressNumber','xqwjpercent','xqwjtdf','xqwjfiles','xqwjprogid','xqwjfileUrl')" hidden="hidden"> 
									<input type="text" id="xqwjfiles" name="xqwjfiles" hidden="hidden">
									
								</td>
								<td colspan="3" id="xqwjtdf">
									&nbsp;&nbsp; 
									<a onclick="$('#xqwj').click()" style="font-weight: bold;  " href="#"> 
										<img style="vertical-align:bottom;margin-bottom: 5px;" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"
										onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
									</a>
									&nbsp;&nbsp; 
									<%--<a style="font-weight: bold;  " href="${base }/cgsqsp/xqwjDownload"> 
										<img style="vertical-align:bottom;margin-bottom: 5px;" src="${base}/resource-modality/${themenurl}/button/mbxz1.png"
										onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
									</a> --%>
									<div id="xqwjprogid"
										style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none">
										<div id="xqwjprogressNumber"
											style="background:#3AF960;width:0px;height:10px"></div>
										文件上传中...&nbsp;&nbsp;<font id="xqwjpercent">0%</font>
									</div> <c:forEach items="${attac}" var="att">
									<c:if test="${att.serviceType=='xqwj' }">
										<div style="margin-top: 5px;">
											<a href='${base}/attachment/download/${att.id}'
												style="color: #666666;font-weight: bold;">${att.originalName}</a>
											&nbsp;&nbsp;&nbsp;&nbsp; <img style="margin-top: 5px;"
												src="${base}/resource-modality/${themenurl}/sccg.png">
											&nbsp;&nbsp;&nbsp;&nbsp; <a id="${att.id}" class="xqwjfileUrl" href="#"
												style="color:red" onclick="deleteAttac(this)">删除</a>
										</div>
									</c:if>
									</c:forEach>
								</td>
							</tr>
							
							<tr>
								<td class="td1" style="width:75px;"><span class="style1" id="hedeSpan" hidden="hidden">*</span>&nbsp;
									论证报告 <input type="file" multiple="multiple" id="lzbg" accept=".pdf"
									onchange="upladFileMoreParams(this,'lzbg','zcgl01','lzbgprogressNumber','lzbgpercent','lzbgtdf','lzbgfiles','lzbgprogid','lzbgfileUrl')" hidden="hidden"> <input
									type="text" id="lzbgfiles" name="lzbgfiles" hidden="hidden"></td>
								<td colspan="3" id="lzbgtdf">&nbsp;&nbsp; <a onclick="$('#lzbg').click()"
									style="font-weight: bold;  " href="#"> <img
										style="vertical-align:bottom;margin-bottom: 5px;"
										src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"
										onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
								</a>
									<div id="lzbgprogid"
										style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none">
										<div id="lzbgprogressNumber"
											style="background:#3AF960;width:0px;height:10px"></div>
										文件上传中...&nbsp;&nbsp;<font id="lzbgpercent">0%</font>
									</div> <c:forEach items="${attac}" var="att">
									<c:if test="${att.serviceType=='lzbg' }">
										<div  style="margin-top: 5px;">
											<a href='${base}/attachment/download/${att.id}'
												style="color: #666666;font-weight: bold;">${att.originalName}</a>
											&nbsp;&nbsp;&nbsp;&nbsp; <img style="margin-top: 5px;"
												src="${base}/resource-modality/${themenurl}/sccg.png">
											&nbsp;&nbsp;&nbsp;&nbsp; <a id="${att.id}" class="lzbgfileUrl" href="#"
												style="color:red" onclick="deleteAttac(this)">删除</a>
										</div>
									</c:if>
									</c:forEach>
								</td>
							</tr>
							
							<tr id="hideTr" hidden="hidden">
								<td class="td1" style="width:75px;">
									工程量清单 <input type="file" multiple="multiple" id="gclqd"
									onchange="upladFileMoreParams(this,'gclqd','zcgl01','gclqdprogressNumber','gclqdpercent','gclqdtdf','gclqdfiles','gclqdprogid','gclqdfileUrl')" hidden="hidden"> <input
									type="text" id="gclqdfiles" name="gclqdfiles" hidden="hidden"></td>
								<td colspan="3" id="gclqdtdf">&nbsp;&nbsp; <a onclick="$('#gclqd').click()"
									style="font-weight: bold;  " href="#"> <img
										style="vertical-align:bottom;margin-bottom: 5px;"
										src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"
										onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
								</a>
									<div id="gclqdprogid"
										style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none">
										<div id="gclqdprogressNumber"
											style="background:#3AF960;width:0px;height:10px"></div>
										文件上传中...&nbsp;&nbsp;<font id="gclqdpercent">0%</font>
									</div> <c:forEach items="${attac}" var="att">
									<c:if test="${att.serviceType=='gclqd' }">
										<div  style="margin-top: 5px;">
											<a href='${base}/attachment/download/${att.id}'
												style="color: #666666;font-weight: bold;">${att.originalName}</a>
											&nbsp;&nbsp;&nbsp;&nbsp; <img style="margin-top: 5px;"
												src="${base}/resource-modality/${themenurl}/sccg.png">
											&nbsp;&nbsp;&nbsp;&nbsp; <a id="${att.id}" class="gclqdfileUrl" href="#"
												style="color:red" onclick="deleteAttac(this)">删除</a>
										</div>
									</c:if>
									</c:forEach>
								</td>
							</tr>
						</table>
						</div>				
					</div>
				
				
				
					<!-- 采购清单 -->
					<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					  	<div title="采购清单" data-options="collapsible:false"
						style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px">
					  		<jsp:include page="select_cgconf_plan_mingxi.jsp" />
						</div>
						</div>
					</div> --%>
					<!-- 附件信息 -->
						<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
						<div title="附件信息" data-options="collapsible:false" style="overflow:auto;">		
							<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width: 707px">
								<tr>
									<td class="td1" style="width:60px;">
										附件
										<input type="file" multiple="multiple" id="f" onchange="upladFile(this,'file','cggl02')" hidden="hidden" >
										<input type="text" id="files" name="files" hidden="hidden">
									</td>
									<td colspan="3" id="tdf">
										&nbsp;&nbsp;
										<a onclick="$('#f').click()" style="font-weight: bold;  " href="#">
											<img style="vertical-align:bottom;margin-bottom: 5px;" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
										</a>
										<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
											<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
											 </div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
										</div>
										<c:forEach items="${attac}" var="att">
										<c:if test="${att.serviceType=='file'}">
											<div style="margin-top: 5px;">
											<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<img style="margin-top: 5px;" src="${base}/resource-modality/${themenurl}/sccg.png">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
											</div>
										</c:if>	
										</c:forEach>
									</td>
								</tr>
							</table>
						</div>
						</div> --%>
					</div>
			
			
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveCgsqApply(0)">
					<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveCgsqApply(1)">
					<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<c:if test="${openType == 'edit' }">
					<a href="javascript:void(0)" onclick="showUpdate()">
					<img src="${base}/resource-modality/${themenurl}/button/xgjl1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;
				</c:if>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<div class="window-right-div" id="check_system_div" style="width:254px;height: auto;padding-bottom: 20px;">
			<jsp:include page="../../check_system.jsp" />
		</div>
	</div>
</form>
<form id="form_data_PAB" method="post" enctype="multipart/form-data">
	<input type="hidden" id="data_fpPype" name="fpPype" value="">
	<input type="hidden" id="data_fpId"  name="fpId" value="">
	<input type="hidden" id="data_nCode"  name="nCode" value="">
	
	<input type="hidden" id="data_fDeptName" name="fDeptName" value="">
	<input type="hidden" id="data_fUserName"  name="fUserName" value="">
	<input type="hidden" id="data_fReqTime"  name="fReqTime" value="">
</form>
<script type="text/javascript">
	if($("#fItems").val() == 'B'){
		$("#hideTr").show();
	}
	if('${bean.orgType}' != 'ZXCG' && '${bean.orgType}' != ''){
		$("#org1").show();
		$("#org2").hide();
	}
	function governYes(){
		$("#org1").show();
		$("#org2").hide();
		$("#orgType1").val("");
		$("#orgType2").val("");
	}
	function governNo(){
		$("#org1").hide();
		$("#org2").show();
		$("#orgType1").val("");
		$("#orgType2").val("");
	}
	function impYes(){
		$("#hedeSpan").show();
	}
	function impNo(){
		$("#hedeSpan").hide();
	}
	$("#fItems").change(function(){
		if($(this).find('option:selected').val() == 'B'){
			$("#hideTr").show();
		}else{
			$("#hideTr").hide();
		}
	});


	$(document).ready(function() {
		//批复金额
		var pfAmount = $("#pfAmount").val();
		if(pfAmount !=""){
			$('#p_pfAmount').html(fomatMoney(pfAmount,2)+" [元]");
		}
		//可用金额
		var syAmount = $("#syAmount").val();
		if(syAmount !=""){
			$('#p_syAmount').html(fomatMoney(syAmount,2)+" [元]");
		}
		//批复时间
		var pfDate = $("#pfDate").val();
		if(pfDate !=""){
			$('#p_pfDate').html(getYear(pfDate));
		}
		
		/* var totalFsumMoney=$('#F_fpAmount').val();
		//是否论证字段根据采购金额进行选择，如果采购金额大于1万元，默认是，小于1万元默认为否
		if(totalFsumMoney>=10000){
			$("input[name='fIsInquiry'][value='1']").prop("checked", "checked");
		}else{
			$("input[name='fIsInquiry'][value='0']").prop("checked", "checked");
		}
		isInquiry();
		//采购总金额大于等于10万，要上传三重一大党委会纪要---弹出提示框是否上传三重一大党委会纪要？点是，直接送审，点否，回到页面
		if(totalFsumMoney>=100000){
			$("#scyddwhjy").show();
		}else{
			$("#scyddwhjy").hide();
		}
		//采购类型为货物类，采购单价大于等于10万，-弹出提示框是否上传大型仪器设备前期调研报告？点是，直接送审，点否，回到页面
		var fpPype=$('#F_fpPype').val(); 
		if(totalFsumMoney>=100000 && fpPype=='A10'){
			$("#dxyqdybg").show();
		}else{
			$("#dxyqdybg").hide();
		}
		$("#fItems").combobox(
				{
					onChange : function(n, o) {
						$('#fItemsDetail').textbox('setValue','');
						if((o=="A10"&&(n=="A30"||n=="A20"))||(o=="A30"&&(n=="A10"||n=="A20"))||(o=="A20"&&(n=="A10"||n=="A30"))){
							return;
						}
						var userid = $('#F_fUser').val();
						$("#check_system_div").load("${base}/cgsqsp/refreshProcess?fpPype="+n+'&fUser='+userid);
						if($(this).find('option:selected').val() == 'B'){
							$("#hideTr").show();
						}else{
							$("#hideTr").hide();
						}
					}
				}); */
	});
	
	//根据选择的采购类型刷新审批流
	/* $("#F_fpPype").combobox({
		onChange: function (n,o) {
			if((o=="A10"&&(n=="A30"||n=="A20"))||(o=="A30"&&(n=="A10"||n=="A20"))||(o=="A20"&&(n=="A10"||n=="A30"))){
				return;
			}
			var userid = $('#F_fUser').val();
			$("#check_system_div").load("${base}/cgsqsp/refreshProcess?fpPype="+n+'&fUser='+userid);
			if(n=="A10" || n=="A30"|| n=="A20"){
				var hwfpId=$("#hwfpId").val();
				$("#flowId").val(hwfpId);
			}else{
				var gcfpId=$("#gcfpId").val();
				$("#flowId").val(gcfpId);
			}
			//采购类型为货物类，采购单价大于等于10万，-弹出提示框是否上传大型仪器设备前期调研报告？点是，直接送审，点否，回到页面
			var totalFsumMoney=$('#F_fpAmount').val();
			if(totalFsumMoney>=100000 && n=='A10'){
				$("#dxyqdybg").show();
			}else{
				$("#dxyqdybg").hide();
			}
		}
	}); */
	

	//是否论证	是-显示采购论证结论按钮
/* 	function isInquiry(){
		var isInquiry = $("input[name='fIsInquiry']:checked").val();
		if(isInquiry == "1"){
			$("#cglzjl").show();
		}else {
			$("#cglzjl").hide();
		}
	} */

	//打开选择配置计划页面
	/* function checkConfPlan(){
		var win = creatFirstWin('采购计划选择', 840, 450, 'icon-search', '/cgsqsp/checkedlist');
		win.window('open');
	} */
	//检查上传文件是否为空
	function fileIsNull(){
		var totalFsumMoney=$('#fpAmount').val();
		var fItems=$('#fItems').val();
		var isImp = $('input[name="fIsImp"]:checked').val();
		var isContract = $('input[name="fIsContract"]:checked').val();
		//如果是进口需要上传进口产品专家意见
		if(isImp==1){
			var s3="";
			$(".lzbgfileUrl").each(function(){
				s3=s3+$(this).attr("id")+",";
			});
			if(s3==''){
				$.messager.alert('系统提示', '论证报告', 'info');
				return true;
			}
		}
		if(fItems=='B'){
			var s3="";
			$(".gclqdfileUrl").each(function(){
				s3=s3+$(this).attr("id")+",";
			});
			if(s3==''){
				$.messager.alert('系统提示', '论证报告', 'info');
				return true;
			}
		}
		if(isContract==0&&totalFsumMoney>=10000){
			$.messager.alert('系统提示', '该项目必须订立合同，请修改有关选项', 'info');
			return true;
		}
		var isZc =$('#isZc').val();
		if(isContract==0&&isZc==1){
			$.messager.alert('系统提示', '该项目必须订立合同，请修改有关选项', 'info');
			return true;
		}
		return false;
	}
	//保存
	function saveCgsqApply(fCheckStauts) {
		
		var orgType = $("#orgType").val();
		var orgType1 = $("#orgType1").val();
		var orgType2 = $("#orgType2").val();
		if(orgType1 == '' && orgType2 == ''){
			alert("请选择采购组织形式！");
			return;
		}
		if(orgType1 != null && orgType1 != ''){
			$("#orgType").val(orgType1);
		}
		if(orgType2 != null && orgType2 != ''){
			$("#orgType").val(orgType2);
		}
		/* var rows = $('#plan_dg').datagrid('getRows');
		var mingxi = "";
		var num=0;
		for (var i = 0; i < rows.length; i++) {
			if(rows[i].fIsImp==1){
				num=num+1;
			}
			mingxi = mingxi + JSON.stringify(rows[i]) + ",";
		}
		var isImp = $('input[name="fIsImp"]:checked').val();
		if(isImp==1&&num<1){
			alert("进口商品信息冲突");
			return false;
		}
		$('#mingxiJson').val(mingxi);
		var fpAmount= $('#fpAmount').val();
		if(fCheckStauts==1){
			if(fpAmount==""){
				alert("请添加采购明细！");
				return false;
			}
		
		}
		
		var fplId=$('#F_fplId').val();
		var totalPrice=$('#totalPrice').val();
		if(fplId==""){
			if(totalPrice=="" || totalPrice=="0.00"){
				alert("请配置采购申请清单");
				return false;
			}
		}else{
			if(totalPrice=="0.00"){
				alert("请配置采购申请清单");
				return false;
			}
		}
		
		//附件的路径地址
		var s="";
		$(".fileUrl").each(function(){
			s=s+$(this).attr("id")+",";
		});
		$("#files").val(s);
	 	if(fileIsNull()){
			return false;
		} */
		
		var remark = $("#F_fRemark").val();
		if(remark == '' || remark == null){
			alert("请填写申请理由！");
			return;
		}
		var method = $("#F_fpMethod").val();
		if(method == '' || method == null){
			alert("请填写采购方式！");
			return;
		}
		var items = $("#fItems").val();
		if(items == '' || items == null){
			alert("请填写采购品目目录！");
			return;
		}
		var itemsDetail = $("#fItemsDetail").val();
		if(itemsDetail == '' || itemsDetail == null){
			alert("请填写采购品目明细！");
			return;
		}
		//设置审批状态
		$('#F_fCheckStauts').val(fCheckStauts);
		//设置申请状态
		$('#F_fStauts').val(fCheckStauts);

		//提交
		$('#cgsq_apply_form').form('submit', {
			onSubmit : function() {
				//获得校验结果
				flag = $(this).form('enableValidation').form('validate');
				if (flag) {
					//如果校验通过，则进行下一步
					$.messager.progress();
				}else{
					//校验不通过，就打开第一个校验失败的手风琴
					//openAccordion();
				}
				return flag;
			},
			url : base + '/cgsqsp/save',
			success : function(data) {
				if (flag) {
					$.messager.progress('close');
				}
				data=eval("("+data+")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
				    $("#cg_apply_Tab").datagrid("reload");
				    $("#indexdb").datagrid("reload");
					closeWindow();
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
	
	//打开指标选择页面
	function openIndex() {
		//var win=creatFirstWin('选择指标',860,580,'icon-search','/quota/choiceIndex');
		var win=creatFirstWin('选择指标',1060,580,'icon-search','/apply/choiceIndex?menuType=beforeApply'); 
		win.window('open');
	}
	
	//选择细目
	function chooseItems() {
		var items =$('#fItems').combobox('getValue');
		if(items==''){
			alert('请选择采购品目');
			return false;
		}else{
			var win = creatFirstWin('选择-细目', 640, 580, 'icon-search', '/cgsqsp/chooseItems?item='+items+'');
			win.window('open');
		}

	}
	
	function showUpdate(){
		var win = creatSecondWin('采购计划单修改记录', 1105, 580, 'icon-search',"/cgcheck/UpdateDetail?id=" + '${bean.fpId}');
		win.window('open');
	};
</script>
</body>
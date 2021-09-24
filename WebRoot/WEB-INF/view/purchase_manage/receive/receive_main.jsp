<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<style type="text/css">
.panel-header{
	height: 20px;
}
</style>
<div class="window-div">
<form id="cgsq_receive_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
		<div class="window-left-div" style="width: 765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="tab-wrapper" id="yx-tab">
					<ul class="tab-menu" >
						<li onclick="onclickYS()" class="active">采购验收</li>
						<c:if test="${!empty bidStauts }">
						<li onclick="onclickDJ()">过程登记</li>
						</c:if>
					    <li onclick="onclickCGSQ()">采购申请</li>
					</ul>
					<div class="tab-content">
						<div title="采购验收" id="cgysdiv" data-options="collapsible:false" style="overflow:auto;margin-bottom:35px;">
							<div class="easyui-accordion" data-options="" id="" style="width:707px;margin-left: 20px">
						 		<div title="验收" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;">
							  		<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>&nbsp;验收人</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_facpUser" readonly="readonly"  name="facpUser"required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${receive_people}"/>
											</td>
											<td class="td4">
												<!-- 采购验收状态 --><input type="hidden" name="fIsReceive" id="F_IS_RECEIVE" value="${bean.fIsReceive }">
												<!-- 采购申请Code--><input type="hidden" name="fpCode"  value="${acptbean.fpCode }">
												<!-- 采购申请名称--><input type="hidden" name="facpName"  value="${acptbean.facpName }">
												<!-- 采购申请人 --><input type="hidden" name="cgUserName"  value="${acptbean.cgUserName }">
												<!-- 采购申请人id --><input type="hidden" name="cgUser"  value="${acptbean.cgUser }">
												<!-- 采购申请人部门 --><input type="hidden" name="cgDeptName"  value="${acptbean.cgDeptName }">
												<!-- 采购申请人部门id --><input type="hidden" name="cgDept"  value="${acptbean.cgDept }">
												<!-- 采购申请时间 --><input type="hidden" name="cgTime"  value="${acptbean.cgTime }">
												<!-- 验收的主键id --><input type="hidden" id="F_AcpId" name="facpId" value="${acptbean.facpId}"/>
												<!-- 验收的编码 --><input type="hidden" id="F_AcpCode" name="facpCode" value="${acptbean.facpCode}"/>
												<!-- 验收员id --><input type="hidden" id="F_AcpUserId" name="facpUserId" value="${acptbean.facpUserId}"/>
												<!-- 验收金额 --><input type="hidden" id="F_facpAmount" name="facpAmount" value="${acptbean.facpAmount}"/>
												<!-- 验收员姓名 --><input type="hidden" id="F_AcpUsername" name="facpUsername" value="${acptbean.facpUsername}"/>
												<!-- 验收部门id --><input type="hidden" id="F_DeptId" name="fDepartId" value="${acptbean.fDepartId}"/>
												<!-- 验收部门名称 --><input type="hidden" id="F_DeptName" name="fDepartName" value="${acptbean.fDepartName}"/>
												<!-- 删除状态 --><input type="hidden" id="F_Stauts" name="fStauts" value="${acptbean.fStauts}"/>
												
												<!-- 审批状态 --><input type="hidden" id="F_CheckStauts" name="fCheckStauts" value="${acptbean.fCheckStauts}"/>
												<!-- 下节点审批人id --><input type="hidden"  name="fuserId" value="${acptbean.fuserId}"/>
												<!-- 下节点审批人姓名 --><input type="hidden"  name="userName2" value="${acptbean.userName2}"/>
												<!-- 下节点编码 --><input type="hidden"  name="nCode" value="${acptbean.nCode}"/>
											</td>
											
											<td class="td1"><span class="style1">*</span>&nbsp;验收时间</td>
											<td class="td2">
												<input class="easyui-datebox" class="dfinput" id="F_facpTime"  name="facpTime" required="required" data-options="editable:false,validType:'length[1,20]'" style="width: 200px;" value="${acptbean.facpTime}"/>
											</td>
										</tr>
									<tr class="trbody">
										<td class="td1">验收地点</td>
										<td colspan="4">
											<input class="easyui-textbox" type="text" id="F_facpAddr"  name="facpAddr" data-options="validType:'length[1,20]'" style="width: 555px" value="${acptbean.facpAddr}"/>
										</td>
									</tr>
									
									<tr style="height: 80px;">
										<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>&nbsp;验收意见</p></td>
										<td class="td2" colspan="4">
											<input class="easyui-textbox" type="text" id="F_fmatchRemark" required="required" name="fmatchRemark" data-options="validType:'length[1,50]',multiline:true"   style="width:555px;height:70px;" <c:if test="${!empty acptbean.fmatchRemark}">value="${acptbean.fmatchRemark}"</c:if><c:if test="${empty acptbean.fmatchRemark}">value="验收通过"</c:if>/>
										</td>
									</tr>
										<tr class="trbody">
											<td class="td1" style="width:75px;">
												验收报告及专家意见（如有） <input type="file" multiple="multiple" id="ysbg" accept=".pdf"
												onchange="upladFileMoreParams(this,'ysbg','cggl04','ysbgprogressNumber','ysbgpercent','ysbgtdf','ysbgfiles','ysbgprogid','ysbgfileUrl')" hidden="hidden"> <input
												type="text" id="ysbgfiles" name="ysbgfiles" hidden="hidden"></td>
											<td colspan="3" id="ysbgtdf">&nbsp;&nbsp; <a onclick="$('#ysbg').click()"
												style="font-weight: bold;  " href="#"> <img
													style="vertical-align:bottom;margin-bottom: 5px;"
													src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"
													onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
												</a>
												&nbsp;&nbsp; 
												<div id="ysbgprogid"
													style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none">
													<div id="ysbgprogressNumber"
														style="background:#3AF960;width:0px;height:10px"></div>
													文件上传中...&nbsp;&nbsp;<font id="ysbgpercent">0%</font>
												</div> <c:forEach items="${attac}" var="att">
												<c:if test="${att.serviceType=='ysbg' }">
													<div style="margin-top: 5px;">
														<a href='${base}/attachment/download/${att.id}'
															style="color: #666666;font-weight: bold;">${att.originalName}</a>
														&nbsp;&nbsp;&nbsp;&nbsp; <img style="margin-top: 5px;"
															src="${base}/resource-modality/${themenurl}/sccg.png">
														&nbsp;&nbsp;&nbsp;&nbsp; <a id="${att.id}" class="ysbgfileUrl" href="#"
															style="color:red" onclick="deleteAttac(this)">删除</a>
													</div>
												</c:if>
												</c:forEach>
											</td>
										</tr>
										<tr>
											<td class="td1" style="width:75px;">
												送货清单 <input type="file" multiple="multiple" id="shqd"
												onchange="upladFileMoreParams(this,'shqd','cggl04','shqdprogressNumber','shqdpercent','shqdtdf','shqdfiles','shqdprogid','shqdfileUrl')" hidden="hidden"> <input
												type="text" id="shqdfiles" name="shqdfiles" hidden="hidden"></td>
											<td colspan="3" id="shqdtdf">&nbsp;&nbsp; <a onclick="$('#shqd').click()"
												style="font-weight: bold;  " href="#"> <img
													style="vertical-align:bottom;margin-bottom: 5px;"
													src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"
													onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
												</a>
												&nbsp;&nbsp; 
												<div id="shqdprogid"
													style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none">
													<div id="shqdprogressNumber"
														style="background:#3AF960;width:0px;height:10px"></div>
													文件上传中...&nbsp;&nbsp;<font id="shqdpercent">0%</font>
												</div> <c:forEach items="${attac}" var="att">
												<c:if test="${att.serviceType=='shqd' }">
													<div style="margin-top: 5px;">
														<a href='${base}/attachment/download/${att.id}'
															style="color: #666666;font-weight: bold;">${att.originalName}</a>
														&nbsp;&nbsp;&nbsp;&nbsp; <img style="margin-top: 5px;"
															src="${base}/resource-modality/${themenurl}/sccg.png">
														&nbsp;&nbsp;&nbsp;&nbsp; <a id="${att.id}" class="shqdfileUrl" href="#"
															style="color:red" onclick="deleteAttac(this)">删除</a>
													</div>
												</c:if>
												</c:forEach>
											</td>
										</tr>
									</table>
								</div>
							</div>	
						</div> 
						<c:if test="${!empty bidStauts }">
							<div title="过程登记" style="width:720px;margin-left: 20px" data-options="collapsible:false">
								<div class="easyui-accordion" style="width:720px;margin-right: 20px;">
									<!--第1个div  -->
									<div title="供应商信息" data-options="collapsed:false,collapsible:false" style="width:717px;overflow:auto;">
										<jsp:include page="../process/course_gys_detail.jsp" />
									</div>
								</div>
								<div class="easyui-accordion" style="width:720px;margin-right: 20px;">
									<div title="采购结果" data-options="collapsed:false,collapsible:false" style="width:717px;overflow:auto;">
										<jsp:include page="../process/course_gys_plan_mingxi_detail.jsp" />
									</div>
								</div>
							</div>
						</c:if>
						<div title="采购申请" style="margin-bottom:35px;overflow:auto" data-options="collapsible:false"  style="width:720px;margin-left: 20px">
							<jsp:include page="../purchase/cggl_detail_base.jsp" />	
						</div>
					</div>
				</div>
			</div>
			
			<div class="window-left-bottom-div">
				<c:if test="${!empty fItems }">
				<a href="javascript:void(0)" onclick="saveMyIncome(1)">
					<img src="${base}/resource-modality/${themenurl}/button/ys1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				</c:if>
				<c:if test="${empty fItems }">
				<a href="javascript:void(0)" onclick="saveMyIncome(0)">
					<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveMyIncome(1)">
					<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				</c:if>	
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		<c:if test="${empty fItems}">
		<div class="window-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div>
		</c:if>
</form>
</div>
<script type="text/javascript">
	//加载tab页
	flashtab('yx-tab');
	//防止不停重新加载
	var urlcountYS = 0;
	function onclickYS(){
		if(urlcountYS>=0){
			urlcountYS+=1;
			return false;
		}else {
			urlcountYS+=1;
			$('#plan_receive_dg').datagrid('reload');
			return true;
		}
	}
	var urlcountCGSQ = 0;
	function onclickCGSQ(){
		if(urlcountCGSQ>=1){
			urlcountCGSQ+=1;
			return false;
		}else {
			urlcountCGSQ+=1;
			$('#plan_dg').datagrid('reload');
			$('#check-history-dg-cg').datagrid('reload');
			return true;
		}
	}
	var urlcountDJ = 0;
	function onclickDJ(){
		if(urlcountDJ>=1){
			urlcountDJ+=1;
			return false;
		}else {
			urlcountDJ+=1;
			$('#course_gys_detail_dg').datagrid('reload');
			return true;
		}
	}

	
	
	//提交
	function saveMyIncome(checkStauts) {
		//设置审批状态
		$("#F_CheckStauts").val(checkStauts);
		//设置申请状态
		$("#F_Stauts").val(checkStauts);
		
		//提交
		$('#cgsq_receive_form').form('submit', {
			onSubmit : function() {
				flag = $(this).form('enableValidation').form('validate');
				if (flag) {
					$.messager.progress();
				}else{
					//校验不通过，就打开第一个校验失败的手风琴
					openAccordion();
				}
				return flag;
			},
			url : base + '/cgreceive/receive_submit',
			success : function(data) {
				if (flag) {
					$.messager.progress('close');
				}
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#receive_forAcceptance').datagrid('reload');
					$('#cgsq_yanshou_dg1').datagrid('reload');
					$('#indexdb').datagrid('reload');
					closeWindow();
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
</script>
</body>
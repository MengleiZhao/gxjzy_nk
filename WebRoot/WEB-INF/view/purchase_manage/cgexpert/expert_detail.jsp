<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="expert_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="" style="width:662px;margin-left: 20px">
														<!-- 第一个div -->
					<div title="专家信息" data-options="iconCls:'icon-xxlb'"  style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>专家编码</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fexpertCode"   name="fexpertCode" readonly="readonly"  style="width:200px;" data-options="validType:'length[1,50]'" value="${ebean.fexpertCode}"/>
									<input type="hidden" name="feId" id="F_feId" value="${ebean.feId}"/><!--隐藏域  -->
									<input type="hidden" name="fcheckStauts" id="F_fcheckStauts" value="${ebean.fcheckStauts}"/><!--专家申请的审批状态  -->
									<input type="hidden" name="fisBlack" value="${ebean.fisBlack}" /><!--是否黑名单  -->
									<input type="hidden" name="fstauts" value="${ebean.fstauts}" /><!--数据的删除状态  -->
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>专家名称</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fexpertName"  name="fexpertName" readonly="readonly"  style="width:200px;" data-options="validType:'length[1,50]'" value="${ebean.fexpertName}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>身份证号</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fidNumber"  name="fidNumber"  readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fidNumber}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>专家性别</td>
								<td class="td2">
									<span>
            										<input type="radio"  name="fexpertSex" disabled="disabled" <c:if test="${ebean.fexpertSex=='0'}">checked="checked"</c:if> value="0">男
             									<input type="radio" name="fexpertSex" disabled="disabled" <c:if test="${ebean.fexpertSex=='1'}">checked="checked"</c:if> value="1">女
        										</span>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>出生日期</td>
								<td class="td2">
									<input class="easyui-datebox" type="text" id="F_fbirthday"  name="fbirthday" readonly="readonly"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fbirthday}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>最高学历</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_feducation"  name="feducation"  readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.feducation}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>毕（肄）业时间</td>
								<td class="td2">
									<input class="easyui-datebox"  id="F_fgradTime"  name="fgradTime" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px;" value="${ebean.fgradTime}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>毕（肄）业学校</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fgradSchool"   name="fgradSchool" readonly="readonly"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fgradSchool}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>所学专业</td>
								<td class="td2">
									<input class="easyui-textbox"  id="F_fstudyMajor"  name="fstudyMajor" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px;" value="${ebean.fstudyMajor}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>所获学位</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fdegree"  name="fdegree" readonly="readonly"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fdegree}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>参加工作时间</td>
								<td class="td2">
									<input class="easyui-datebox"  id="F_fstartWorkTime"  name="fstartWorkTime" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px;" value="${ebean.fstartWorkTime}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>工作单位</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fworkUnit"  name="fworkUnit" readonly="readonly"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fworkUnit}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>现从事专业</td>
								<td class="td2">
									<input class="easyui-textbox"  id="F_fnowWork"  name="fnowWork" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px;" value="${ebean.fnowWork}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>现从事专业年限</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fjobTime"  name="fjobTime" readonly="readonly"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fjobTime}"/>
								</td>
							</tr>
							<%-- <tr>
								<td class="td1"><span class="style1">*</span>行政职务</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fadminDut"  name="fadminDut" readonly="readonly"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fadminDut}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>是否高评委建库单位人员</td>
								<td class="td2">
									<span>
            										<input type="radio"  name="fisGpw" disabled="disabled" <c:if test="${ebean.fisGpw=='0'}">checked="checked"</c:if> value="0">否
             									<input type="radio" name="fisGpw" disabled="disabled" <c:if test="${ebean.fisGpw=='1'}">checked="checked"</c:if> value="1">是
        										</span>
								</td>
							</tr> --%>
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>行政职务</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fadminDut"  name="fadminDut"  readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fadminDut}"/>
								</td>
								<td class="td4"></td>
								<td class="td1" colspan="2"><span class="style1">*</span>是否高评委建库单位人员&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<span>
            										<input type="radio"  name="fisGpw" disabled="disabled" <c:if test="${ebean.fisGpw=='0'}">checked="checked"</c:if> value="0">否
             									<input type="radio" name="fisGpw" disabled="disabled" <c:if test="${ebean.fisGpw=='1'}">checked="checked"</c:if> value="1">是
        										</span>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>现有任职资格</td>
								<td class="td2">
									<input class="easyui-textbox"  id="F_fcurrtQualit"  name="fcurrtQualit" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px;" value="${ebean.fcurrtQualit}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>资格级别</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fcurrtQualitLev"  name="fcurrtQualitLev" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fcurrtQualitLev}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>取得时间</td>
								<td class="td2">
									<input class="easyui-datebox"  id="F_fgetTime"  name="fgetTime" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px;" value="${ebean.fgetTime}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>所属系列</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fseries"  name="fseries" readonly="readonly"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fseries}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>聘任情况</td>
								<td class="td2">
									<%-- <input class="easyui-textbox"  id="F_fappoinSituation"  name="fappoinSituation" required="required" data-options="validType:'length[1,20]'" style="width: 200px;" value="${ebean.fappoinSituation}"/> --%>
									<select class="easyui-combobox" id="F_fappoinSituation" name="fappoinSituation" readonly="readonly" required="required"  style="width: 200px;" data-options="editable:false,panelHeight:'auto'">
										<option value="">--请选择--</option>
										<option value="1" <c:if test="${ebean.fappoinSituation=='1'}">selected="selected"</c:if>>在聘</option>
										<option value="2" <c:if test="${ebean.fappoinSituation=='2'}">selected="selected"</c:if>>仅具有资格</option>
										<option value="3" <c:if test="${ebean.fappoinSituation=='3'}">selected="selected"</c:if>>离退休</option>
									</select>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>高评委名称</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fgpwName"  name="fgpwName" readonly="readonly"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fgpwName}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>职务</td>
								<td class="td2">
									<input id="F_fgpwPost" name="fgpwPost.code" readonly="readonly"  class="easyui-combobox" style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=GPW_POST&selected=${ebean.fgpwPost.code}',method:'get',valueField:'code',textField:'text',editable:false"  />
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>任职时间</td>
								<td class="td2">
									<input class="easyui-datebox" type="text" id="F_fgpwPostTime"  name="fgpwPostTime" readonly="readonly"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fgpwPostTime}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>高评委职务</td>
								<td class="td2">
									<input id="F_fgpwPost2" name="fgpwPost2.code" readonly="readonly"  class="easyui-combobox" style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=GPW_POST&selected=${ebean.fgpwPost2.code}',method:'get',valueField:'code',textField:'text',editable:false"  />
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>专业（审议）组</td>
								<td class="td2">
									<%-- <input class="easyui-textbox" type="text" id="F_fgroupName"  name="fgroupName"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fgroupName}"/> --%>
									<select class="easyui-combobox" id="F_fgroupName" name="fgroupName" readonly="readonly" required="required"  style="width: 200px;" data-options="editable:false,panelHeight:'auto'">
										<option value="">--请选择--</option>
										<option value="1" <c:if test="${ebean.fgroupName=='1'}">selected="selected"</c:if>>组长</option>
										<option value="2" <c:if test="${ebean.fgroupName=='2'}">selected="selected"</c:if>>组员</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>业务领域</td>
								<td class="td2">
									<input class="easyui-textbox"  id="F_ffield"  name="ffield" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px;" value="${ebean.ffield}"/>
								</td>
								<td class="td4"></td>
								<td class="td1">邮政编码</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fPost"  name="fPost" readonly="readonly"  data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fPost}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>手机</td>
								<td class="td2">
									<input class="easyui-textbox"  id="F_fmTel"  name="fmTel" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px;" value="${ebean.fmTel}"/>
								</td>
								<td class="td4"></td>
								<td class="td1">办公室电话</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_ftel"  name="ftel" readonly="readonly" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.ftel}"/>
								</td>
							</tr>
							<tr>
								<td class="td1">住宅电话</td>
								<td class="td2">
									<input class="easyui-textbox"  id="F_fhTel"  name="fhTel" readonly="readonly" data-options="validType:'length[1,20]'" style="width: 200px;" value="${ebean.fhTel}"/>
								</td>
								<td class="td4"></td>
								<td class="td1">电子邮箱</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_femail"  name="femail" readonly="readonly"  data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.femail}"/>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1">通讯地址</td>
								<td class="td2" colspan="4">
									<input class="easyui-textbox"  id="F_fhomeAddr"  name="fhomeAddr" readonly="readonly"  data-options="validType:'length[1,20]'" style="width: 555px;" value="${ebean.fhomeAddr}"/>
								</td>
							</tr>
							<c:if test="${ebean.fcheckType=='out'}">	<!-- 出庫 -->
								<tr style="height: 78px;">
									<c:if test="${bean.fflag==1}">
										<td class="td1" valign="top"><span class="style1">*</span>出库原因</td>
									</c:if>
									<c:if test="${bean.fflag==2}">
									<td class="td1" valign="top"><span class="style1">*</span>入库原因</td>
									</c:if>
									<td colspan="4">
										<input class="easyui-textbox" type="text" id="F_foutMsg"  name="foutMsg" readonly="readonly" data-options="validType:'length[1,100]',multiline:true" style="width:555px;height:70px;" value="${ebean.foutMsg}"/>
									</td>
								</tr>
							</c:if>
							<c:if test="${ebean.fcheckType=='black'}">	<!-- 黑名单 -->
								<tr style="height: 78px;">
									<c:if test="${bean.fFlag==1}">
										<td class="td1"valign="top"><span class="style1">*</span>移入黑名单原因</td>
									</c:if>
									<c:if test="${bean.fFlag==2}">
										<td class="td1"valign="top"><span class="style1">*</span>移出黑名单原因</td>
									</c:if>
									<td class="td2" colspan="4">
										<input class="easyui-textbox" type="text" id="F_fblackDesc"  name="fblackDesc" readonly="readonly" data-options="validType:'length[1,100]',multiline:true" style="width:555px;height:70px;" value="${ebean.fblackDesc}"/>
									</td>
								</tr>
							</c:if>
							<c:if test="${ebean.fcheckType=='in'}">
								<c:if test="${ebean.fisBlackStatus==1||ebean.fisBlackStatus==-1}">
									<tr style="height: 78px;">
										<c:if test="${bean.fFlag==1}">
											<td class="td1"valign="top"><span class="style1">*</span>移入黑名单原因</td>
										</c:if>
										<c:if test="${bean.fFlag==2}">
											<td class="td1"valign="top"><span class="style1">*</span>移出黑名单原因</td>
										</c:if>
										<td class="td2" colspan="4">
											<input class="easyui-textbox" type="text" id="F_fblackDesc"  name="fblackDesc" readonly="readonly" data-options="validType:'length[1,100]',multiline:true" style="width:555px;height:70px;" value="${ebean.fblackDesc}"/>
										</td>
									</tr>
								</c:if>
								<c:if test="${ebean.fisOutStatus==1 || ebean.fisOutStatus==9}">
									<tr style="height: 78px;">
										<td class="td1" valign="top"><span class="style1">*</span>入库原因</td>
										<td colspan="4">
											<input class="easyui-textbox" type="text" id="F_foutMsg"  name="foutMsg" readonly="readonly" data-options="validType:'length[1,100]',multiline:true" style="width:555px;height:70px;" value="${ebean.foutMsg}"/>
										</td>
									</tr>
								</c:if>
							</c:if>
							<tr style="height: 80px;">
								<td class="td1" valign="top">备注</td>
								<td colspan="4">
									<input class="easyui-textbox" type="text" id="F_fremark"  name="fremark" readonly="readonly"  data-options="validType:'length[1,50]',multiline:true"   style="width:555px;height:70px;" value="${ebean.fremark}"/>
								</td>
							</tr>
						</table>
					</div>
													<!-- 第2个div -->
					<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../../check_history.jsp" />												
					</div>
					<div title="黑名单记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
					  		<jsp:include page="expert_black_history.jsp" />												
					</div>
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div>
	</div>
</form>
</div>
	<script type="text/javascript">
	
	</script>
</body>
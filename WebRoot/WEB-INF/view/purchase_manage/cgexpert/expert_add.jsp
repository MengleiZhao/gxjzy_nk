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
								<div title="专家信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
									<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>专家编码</td>
											<td class="td2">
												<input class="easyui-textbox" id="F_fexpertCode"  name="fexpertCode" readonly="readonly"  style="width:200px;" data-options="validType:'length[1,50]'" value="${ebean.fexpertCode}"/>
												<input type="hidden" name="feId" id="F_feId" value="${ebean.feId}"/><!--隐藏域  -->
												<input type="hidden" name="fcheckStauts" id="F_fcheckStauts" value="${ebean.fcheckStauts}"/><!--专家申请的审批状态  -->
												<input type="hidden" name="fisBlack" value="${ebean.fisBlack}" /><!--是否黑名单  -->
												<input type="hidden" name="fstauts" value="${ebean.fstauts}" /><!--数据的删除状态  -->
												<input type="hidden" name="faccFreq" value="${ebean.faccFreq}" /><!--拉黑次数 -->
												<input type="hidden" name="fRecUserId" value="${ebean.fRecUserId}" />
												<input type="hidden" name="fcheckType" value="in" />
											</td>
											<td class="td4"></td>
											<td class="td1"><span class="style1">*</span>专家名称</td>
											<td class="td2">
												<input class="easyui-textbox" id="F_fexpertName"  name="fexpertName"  style="width:200px;" data-options="validType:'length[1,25]'" value="${ebean.fexpertName}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>身份证号</td>
											<td class="td2">
												<input class="easyui-textbox" id="F_fidNumber"    name="fidNumber"  required="required" data-options="validType:'idCode',onChange:autoBirthday" style="width: 200px" value="${ebean.fidNumber}"/>
											</td>
											<td class="td4"></td>
											<td class="td1"><span class="style1">*</span>专家性别</td>
											<td class="td2">
												<span>
               										<input type="radio" name="fexpertSex" <c:if test="${ebean.fexpertSex=='0'}">checked="checked"</c:if> value="0">男
                									<input type="radio" name="fexpertSex" <c:if test="${ebean.fexpertSex=='1'}">checked="checked"</c:if> value="1">女
           										</span>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>出生日期</td>
											<td class="td2">
												<%-- <input class="easyui-datebox" type="text" id="F_fbirthday"  name="fbirthday"  required="required" data-options="formatter:myformatter,parser:myparser,validType:'length[1,20]'" style="width: 200px" value="${ebean.fbirthday}"/> --%>
												<input class="easyui-datebox" type="text" id="F_fbirthday"  name="fbirthday"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fbirthday}"/>
											</td>
											<td class="td4"></td>
											<td class="td1"><span class="style1">*</span>最高学历</td>
											<td class="td2">
												<%-- <input class="easyui-textbox" type="text" id="F_feducation"  name="feducation"  required="required" data-options="validType:'length[1,10]'" style="width: 200px" value="${ebean.feducation}"/>
												 --%>
												 <select class="easyui-combobox" id="F_feducation" name="feducation" required="required"  style="width: 200px;" data-options="editable:false,panelHeight:'auto',validType:'selectValid'">
													<option value="--请选择--">--请选择--</option>
													<option value="小学" <c:if test="${ebean.fdegree=='小学'}">selected="selected"</c:if>>小学</option>
													<option value="初中" <c:if test="${ebean.feducation=='初中'}">selected="selected"</c:if>>初中</option>
													<option value="中专" <c:if test="${ebean.feducation=='中专'}">selected="selected"</c:if>>中专</option>
													<option value="高中" <c:if test="${ebean.feducation=='高中'}">selected="selected"</c:if>>高中</option>
													<option value="大专" <c:if test="${ebean.feducation=='大专'}">selected="selected"</c:if>>大专</option>
													<option value="本科" <c:if test="${ebean.feducation=='本科'}">selected="selected"</c:if>>本科</option>
													<option value="硕士" <c:if test="${ebean.feducation=='硕士'}">selected="selected"</c:if>>硕士</option>
													<option value="博士" <c:if test="${ebean.feducation=='博士'}">selected="selected"</c:if>>博士</option>
												 </select>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>毕（肄）业时间</td>
											<td class="td2">
												<input class="easyui-datebox"  id="F_fgradTime"  name="fgradTime" required="required" data-options="validType:'length[1,20]'" style="width: 200px;" value="${ebean.fgradTime}"/>
											</td>
											<td class="td4"></td>
											<td class="td1"><span class="style1">*</span>毕（肄）业学校</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fgradSchool"  name="fgradSchool"  required="required" data-options="validType:'length[1,50]'" style="width: 200px" value="${ebean.fgradSchool}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>所学专业</td>
											<td class="td2">
												<input class="easyui-textbox"  id="F_fstudyMajor"  name="fstudyMajor" required="required" data-options="validType:'length[1,25]'" style="width: 200px;" value="${ebean.fstudyMajor}"/>
											</td>
											<td class="td4"></td>
											<td class="td1"><span class="style1">*</span>所获学位</td>
											<td class="td2">
												<%-- <input class="easyui-textbox" type="text" id="F_fdegree"  name="fdegree"  required="required" data-options="validType:'length[1,10]'" style="width: 200px" value="${ebean.fdegree}"/>
											 --%>
											 <select class="easyui-combobox" id="F_fdegree" name="fdegree"  style="width: 200px;" data-options="editable:false,panelHeight:'auto',validType:'selectValid'">
												<option value="--请选择--">--请选择--</option>
												<option value="学士学位" <c:if test="${ebean.fdegree=='学士学位'}">selected="selected"</c:if>>学士学位</option>
												<option value="硕士学位" <c:if test="${ebean.fdegree=='硕士学位'}">selected="selected"</c:if>>硕士学位</option>
												<option value="博士学位" <c:if test="${ebean.fdegree=='博士学位'}">selected="selected"</c:if>>博士学位</option>
											 </select>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>参加工作时间</td>
											<td class="td2">
												<input class="easyui-datebox"  id="F_fstartWorkTime"  name="fstartWorkTime" required="required" data-options="validType:'length[1,20]'" style="width: 200px;" value="${ebean.fstartWorkTime}"/>
											</td>
											<td class="td4"></td>
											<td class="td1"><span class="style1">*</span>工作单位</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fworkUnit"  name="fworkUnit"  required="required" data-options="validType:'length[1,50]'" style="width: 200px" value="${ebean.fworkUnit}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>现从事专业</td>
											<td class="td2">
												<input class="easyui-textbox"  id="F_fnowWork"  name="fnowWork" required="required" data-options="validType:'length[1,50]'" style="width: 200px;" value="${ebean.fnowWork}"/>
											</td>
											<td class="td4"></td>
											<td class="td1"><span class="style1">*</span>现从事专业年限</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fjobTime"  name="fjobTime"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fjobTime}"/>
											</td>
										</tr>
										<%-- <tr>
											<td class="td1"><span class="style1">*</span>行政职务</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fadminDut"  name="fadminDut"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fadminDut}"/>
											</td>
											<td class="td4"></td>
											<td class="td1"><span class="style1">*</span>是否高评委建库单位人员</td>
											<td class="td2">
												<span>
               										<input type="radio"  name="fisGpw" <c:if test="${ebean.fisGpw=='0'}">checked="checked"</c:if> value="0">否
                									<input type="radio" name="fisGpw" <c:if test="${ebean.fisGpw=='1'}">checked="checked"</c:if> value="1">是
           										</span>
											</td> 
										</tr> --%>
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>行政职务</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fadminDut"  name="fadminDut"  required="required" data-options="validType:'length[1,25]'" style="width: 200px" value="${ebean.fadminDut}"/>
											</td>
											<td class="td4"></td>
											<td class="td1" colspan="2"><span class="style1">*</span>是否高评委建库单位人员&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<span>
               										<input type="radio"  name="fisGpw" <c:if test="${ebean.fisGpw=='0'}">checked="checked"</c:if> value="0">否
                									<input type="radio" name="fisGpw" <c:if test="${ebean.fisGpw=='1'}">checked="checked"</c:if> value="1">是
           										</span>
											</td>
											<%-- <td class="td2" colspan="3">
												<span>
               										<input type="radio"  name="fisGpw" <c:if test="${ebean.fisGpw=='0'}">checked="checked"</c:if> value="0">否
                									<input type="radio" name="fisGpw" <c:if test="${ebean.fisGpw=='1'}">checked="checked"</c:if> value="1">是
           										</span>
											</td> --%>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>现有任职资格</td>
											<td class="td2">
												<input class="easyui-textbox"  id="F_fcurrtQualit"  name="fcurrtQualit" required="required" data-options="validType:'length[1,50]'" style="width: 200px;" value="${ebean.fcurrtQualit}"/>
											</td>
											<td class="td4"></td>
											<td class="td1"><span class="style1">*</span>资格级别</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fcurrtQualitLev"  name="fcurrtQualitLev"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fcurrtQualitLev}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>取得时间</td>
											<td class="td2">
												<input class="easyui-datebox"  id="F_fgetTime"  name="fgetTime" required="required" data-options="validType:'length[1,20]'" style="width: 200px;" value="${ebean.fgetTime}"/>
											</td>
											<td class="td4"></td>
											<td class="td1"><span class="style1">*</span>所属系列</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fseries"  name="fseries"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fseries}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>聘任情况</td>
											<td class="td2">
												<%-- <input class="easyui-textbox"  id="F_fappoinSituation"  name="fappoinSituation" required="required" data-options="validType:'length[1,20]'" style="width: 200px;" value="${ebean.fappoinSituation}"/> --%>
												<select class="easyui-combobox" id="F_fappoinSituation" name="fappoinSituation" required="required"  style="width: 200px;" data-options="editable:false,panelHeight:'auto',validType:'selectValid'">
													<option value="--请选择--">--请选择--</option>
													<option value="1" <c:if test="${ebean.fappoinSituation=='1'}">selected="selected"</c:if>>在聘</option>
													<option value="2" <c:if test="${ebean.fappoinSituation=='2'}">selected="selected"</c:if>>仅具有资格</option>
													<option value="3" <c:if test="${ebean.fappoinSituation=='3'}">selected="selected"</c:if>>离退休</option>
												</select>
											</td>
											<td class="td4"></td>
											<td class="td1"><span class="style1">*</span>高评委名称</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fgpwName"  name="fgpwName"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fgpwName}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>职务</td>
											<td class="td2">
												<c:if test="${empty ebean.feId}">
													<input id="F_fgpwPost" name="fgpwPost.code"  class="easyui-combobox" style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=GPW_POST',method:'get',valueField:'code',textField:'text',editable:false,validType:'selectValid'" />
												</c:if>
												<c:if test="${!empty ebean.feId}">
													<input id="F_fgpwPost" name="fgpwPost.code"  class="easyui-combobox" style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=GPW_POST&selected=${ebean.fgpwPost.code}',method:'get',valueField:'code',textField:'text',editable:false,validType:'selectValid'"  />
												</c:if>											
											</td>
											<td class="td4"></td>
											<td class="td1"><span class="style1">*</span>任职时间</td>
											<td class="td2">
												<input class="easyui-datebox" type="text" id="F_fgpwPostTime"  name="fgpwPostTime"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fgpwPostTime}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>高评委职务</td>
											<td class="td2">
												<c:if test="${empty ebean.feId}">
													<input id="F_fgpwPost2" name="fgpwPost2.code"  class="easyui-combobox" style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=GPW_POST',method:'get',valueField:'code',textField:'text',editable:false,validType:'selectValid'" />
												</c:if>
												<c:if test="${!empty ebean.feId}">
													<input id="F_fgpwPost2" name="fgpwPost2.code"   class="easyui-combobox" style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=GPW_POST&selected=${ebean.fgpwPost2.code}',method:'get',valueField:'code',textField:'text',editable:false,validType:'selectValid'"  />
												</c:if>	
											</td>
											<td class="td4"></td>
											<td class="td1"><span class="style1">*</span>专业（审议）组</td>
											<td class="td2">
												<%-- <input class="easyui-textbox" type="text" id="F_fgroupName"  name="fgroupName"  required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${ebean.fgroupName}"/> --%>
												<select class="easyui-combobox" id="F_fgroupName" name="fgroupName" required="required"  style="width: 200px;" data-options="editable:false,panelHeight:'auto',validType:'selectValid'">
													<option value="--请选择--">--请选择--</option>
													<option value="1" <c:if test="${ebean.fgroupName=='1'}">selected="selected"</c:if>>组长</option>
													<option value="2" <c:if test="${ebean.fgroupName=='2'}">selected="selected"</c:if>>组员</option>
												</select>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>业务领域</td>
											<td class="td2">
												<%-- <input class="easyui-textbox"  id="F_ffield"  name="ffield" required="required" data-options="validType:'length[1,50]'" style="width: 200px;" value="${ebean.ffield}"/> --%>
												<input class="easyui-combobox" id="F_ffield"  name="ffield" required="required" style="width: 200px;"  data-options="url:'${base}/lookup/lookupsJson?parentCode=YWLY&selected=${ebean.ffield }',
													method:'get',valueField:'code',textField:'text',editable:false,validType:'selectValid',multiple:true, panelHeight:'auto'" value="${ebean.ffield}">
											</td>
											<td class="td4"></td>
											<td class="td1">邮政编码</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fPost"  name="fPost"  data-options="validType:'ZIP'" style="width: 200px" value="${ebean.fPost}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>手机</td>
											<td class="td2">
												<input class="easyui-textbox"  id="F_fmTel"  name="fmTel" required="required" data-options="validType:'tel'" style="width: 200px;" value="${ebean.fmTel}"   missingMessage="手机号不能为空" invalidMessage="请输入正确的手机号"/>
											</td>
											<td class="td4"></td>
											<td class="td1">办公室电话</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_ftel"  name="ftel"  data-options="validType:'tel'" style="width: 200px" value="${ebean.ftel}"  />
											</td>
										</tr>
										<tr>
											<td class="td1">住宅电话</td>
											<td class="td2">
												<input class="easyui-textbox"  id="F_fhTel"  name="fhTel"  data-options="validType:'tel'" style="width: 200px;" value="${ebean.fhTel}"   />
											</td>
											<td class="td4"></td>
											<td class="td1">电子邮箱</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_femail"  name="femail"      data-options="validType:'Email'" style="width: 200px" value="${ebean.femail}"/>
											</td>
										</tr>
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>通讯地址</td>
											<td class="td2" colspan="4">
												<input class="easyui-textbox"  id="F_fhomeAddr"  required="required" name="fhomeAddr"  data-options="validType:'length[1,50]'" style="width: 555px;" value="${ebean.fhomeAddr}"/>
											</td>
										</tr>
										<tr style="height: 78px;">
											<td class="td1" valign="top">备注</td>
											<td colspan="4">
												<textarea name="fremark"  id="F_fremark"  class="textbox-text"  oninput="textareaNum(this,'textareaNum1')" autocomplete="off"   style="width:555px;height:70px;resize:none">${ebean.fremark }</textarea> 
								
												<%-- <input class="easyui-textbox" type="text" id="F_fremark"  name="fremark"   style="width:555px;height:70px;" value="${ebean.fremark}"
												data-options="multiline:true,required:false,validType:'length[0,50]'"
												/> --%>
											</td>
										</tr>
										<c:if test="${operType=='add'||operType=='edit' }">
											<tr>
												<td align="right" colspan="6" style="padding-right: 0px;">
												可输入剩余数：<span id="textareaNum1" class="200">
													<c:if test="${empty ebean.fremark}">200</c:if>
													<c:if test="${!empty ebean.fremark}">${200-ebean.fremark.length()}</c:if>
												</span>
												</td>
											</tr>
										</c:if>
									</table>
								</div>
								<c:if test="${ebean.fcheckStauts!=0 && !empty ebean.feId}">
									<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
										<jsp:include page="../../check_history.jsp" />												
									</div>
								</c:if>
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveExpert(0)">
				<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveExpert(1)">
				<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=采购管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
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
	//填写身份证好之后自动填写日期自动填写生日
	function autoBirthday(newValue,oldValue){
		var sex = newValue.substring(17,18);
		var birthday = newValue.substring(6,14);
		var year = birthday.substring(0,4);
		var month = birthday.substring(4,6);
		var date = birthday.substring(6,8);
		//alert('year='+year+',month='+month+',date='+date);
		birthday = year+'-'+month+'-'+date;
		$('#F_fbirthday').datebox('setValue',birthday);
		if(sex%2==0){
			//偶數
			
		}else {
			//奇数
			
		}
	}
	
	
	$('#F_ffield').combobox({
        onClick: function () {
        	$('#F_ffield').combobox('unselect','');
        }
    });
	
	
	//保存
	function saveExpert(fcheckStauts) {
		var data=$('#F_ffield').combobox('getValues');
		//设置审批状态
		$('#F_fcheckStauts').val(fcheckStauts);
		//验证时间格式
		var F_fbirthday=$('#F_fbirthday').val();
		if(F_fbirthday!="" && !isdate(F_fbirthday)){
			alert("出生日期格式不正确");
			return false;
		}
		var F_fgradTime=$('#F_fgradTime').val();
		if(F_fgradTime!="" && !isdate(F_fgradTime)){
			alert("毕（肄）业时间格式不正确");
			return false;
		}
		var F_fstartWorkTime=$('#F_fstartWorkTime').val();
		if(F_fstartWorkTime!="" && !isdate(F_fstartWorkTime)){
			alert("参加工作时间格式不正确");
			return false;
		}
		var F_fgetTime=$('#F_fgetTime').val();
		if(F_fgetTime!="" && !isdate(F_fgetTime)){
			alert("取得时间格式不正确");
			return false;
		}
		var F_fgpwPostTime=$('#F_fgpwPostTime').val();
		if(F_fgpwPostTime!="" && !isdate(F_fgpwPostTime)){
			alert("任职时间格式不正确");
			return false;
		}
		 //提交
		$('#expert_save_form').form('submit', {
			onSubmit : function() {
				flag = $(this).form('enableValidation').form('validate');
				if (flag) {
					$.messager.progress();
				}
				return flag;
			},
			url : base + '/expertgl/save',
			success : function(data) {
				if (flag) {
					$.messager.progress('close');
				}
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					//$("#expert_save_form").form("clear");
					 $("#expert_tab").datagrid("reload");
					 $('#indexdb').datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
					closeWindow();
					$('#expert_save_form').form('clear');
				}
			}
		}); 	
	}
		
	</script>
</body>
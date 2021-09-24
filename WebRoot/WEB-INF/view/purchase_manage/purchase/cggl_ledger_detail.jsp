<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="cgsq_apply_detail_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
		  <div class="win-left-top-div">
			<div class="tab-wrapper" id="yx-tab">
				<ul class="tab-menu" >
						<li class="active">采购信息</li>
					   <c:if test="${!empty bidStauts }">
						<li onclick="onclickDJDetail()">过程登记</li>
						</c:if>
						<li>采购验收</li>
				</ul>
				<div class="tab-content">
								<!-- 第一个div -->
								<div title="采购信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false"
									style="overflow:auto;margin-top: 10px;">
									<table cellpadding="0" cellspacing="0" class="ourtable">
										<!-- 表单样式参考 -->
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>&nbsp;采购批次编号</td>
											<td class="td2">
												<input id="F_fpCode" class="easyui-textbox" type="text" readonly="readonly" required="required" name="fpCode" data-options="validType:'length[1,30]'" style="width: 200px" value="${bean.fpCode}"/>
											</td>
											<td class="td4">
												
												<!-- 隐藏域 --> 
												<input type="hidden" name="fplId" id="F_fplId" value="${bean.fplId}"/><!--配置计划的主键id  -->
												<input type="hidden" name="fpId" id="F_fcId" value="${bean.fpId}"/>
							    				<input type="hidden" name="fCheckStauts" id="F_fCheckStauts" value="${bean.fCheckStauts}"/><!--采购审批状态  -->
							    				<input type="hidden" name="fStauts" id="F_fStauts" value="${bean.fStauts}"/><!--采购数据的删除状态  -->
							    				<input type="hidden" name="fIsReceive" id="F_fIsReceive" value="${bean.fIsReceive}"/><!--验收状态  -->
							    				<input type="hidden" name="fbidStauts" id="F_fbidStauts" value="${bean.fbidStauts}"/><!--中标状态  -->
							    				<input type="hidden" name="fpayStauts" id="F_fpayStauts" value="${bean.fpayStauts}"/><!--付款申请的审批状态  -->
							    				<input type="hidden" name="fevalStauts" id="F_fevalStauts" value="${bean.fevalStauts}"/><!--供应商的评价状态  -->
							    				
							    				<input type="hidden" name="indexId" id="F_fBudgetIndexCode" value="${bean.indexId}"/><!-- 指标ID -->
							    				<input type="hidden" name="indexCode" id="F_indexCode" value="${bean.indexCode}"/><!--采购指标CODE  -->
							    				<input type="hidden" name="indexName" id="F_indexName" value="${bean.indexName}"/><!--采购指标Name  -->
							    				<input type="hidden" name="indexType" id="F_indexType" value="${bean.indexType}"/><!--采购指标type  -->
							    				
												<!-- 项目支出明细ID --><input type="hidden" id="F_proDetailId" name="proDetailId" value="${bean.proDetailId}"/>
												<!-- 可用金额  --><input type="hidden" id="syAmount" value="${bean.syAmount}"/>
												<!-- 批复金额  --><input type="hidden" id="pfAmount" value="${bean.pfAmount}"/>
												<!-- 批复时间  --><input type="hidden" id="pfDate"  value="${bean.pfDate}"/>
											</td>

											<td class="td1"><span class="style1">*</span>&nbsp;申请人</td>
											<td class="td2">
												<input id="F_fUserName" class="easyui-textbox" type="text" readonly="readonly" required="required" name="fUserName" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fUserName}"/>
											</td>
											
										</tr>

										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>&nbsp;申报部门</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fDeptName" readonly="readonly"  name="fDeptName"required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fDeptName}"/>
											</td>
											
											<td style="width: 0px"></td>
										
											<td class="td1"><span class="style1">*</span>&nbsp;申请时间</td>
											<td class="td2">
												<input class="easyui-datebox" class="dfinput" id="F_fReqTime"  name="fReqTime" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px;" value="${bean.fReqTime}"/>
											</td>
										</tr>

										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>&nbsp;采购名称</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fpName" readonly="readonly"  name="fpName" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fpName}"/>
											</td>

											<td style="width: 0px"></td>

											<td class="td1"><span class="style1">*</span>&nbsp;采购金额</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fpAmount"  name="fpAmount" readonly="readonly" required="required" data-options="validType:'length[1,20]',iconWidth: 22,icons: [{iconCls:'icon-yuan',handler: function(e){}}]" style="width: 200px" value="${bean.fpAmount}"/>
											</td>
										</tr>

										<%-- <tr class="trbody">
											<td class="td1"><span class="style1">*</span>&nbsp;组织形式</td>
											<td class="td2">
												<input id="F_fOrgType" name="fOrgType.code" readonly="readonly"   class="easyui-combobox" style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=CGORG_TYPE&selected=${bean.fOrgType.code}',method:'get',valueField:'code',textField:'text',editable:false"  />
											</td>
											
											<td style="width: 0px"></td>
											
											<td class="td1"><span class="style1">*</span>&nbsp;采购方式</td>
											<td class="td2">
												<c:if test="${!empty bean.fOrgType.code && bean.fOrgType.code=='CGORG_TYPE_1'}">
													<input id="F_fpMethod" name="fpMethod.code" readonly="readonly"  class="easyui-combobox" 
													style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=JZCGFS&selected=${bean.fpMethod.code}',
													method:'get',valueField:'code',textField:'text',editable:false"  />
												</c:if>
												<c:if test="${!empty bean.fOrgType.code && bean.fOrgType.code=='CGORG_TYPE_2'}">
													<input id="F_fpMethod" name="fpMethod.code" readonly="readonly"  class="easyui-combobox" 
													style="width: 200px" data-options="url:'${base}/lookup/lookupsJson?parentCode=FSCGFS&selected=${bean.fpMethod.code}',
													method:'get',valueField:'code',textField:'text',editable:false"  />
												</c:if>
											</td>

										</tr> --%>
										
										<tr class="trbody">
											
											<td class="td1"><span class="style1">*</span>&nbsp;采购类型</td>
											<td class="td2">
												<c:if test="${empty bean.fpId}">
													<select class="easyui-combobox" id="F_fpPype"  name="fpPype" required="required" style="width: 200px;" data-options="editable:false,panelHeight:'auto'" validType="selectValueRequired['#test']">
														<!-- <option value="0">--请选择--</option> -->
														<option value="A10" <c:if test="${bean.fpPype=='A10'}">selected="selected"</c:if>>货物</option>
														<option value="A20" <c:if test="${bean.fpPype=='A20'}">selected="selected"</c:if>>工程采购</option>
														<option value="A30" <c:if test="${bean.fpPype=='A30'}">selected="selected"</c:if>>服务</option>
														<option value="A40" <c:if test="${bean.fpPype=='A40'}">selected="selected"</c:if>>办公用品及耗材</option>
													</select>												
												</c:if>
												<c:if test="${!empty bean.fpId}">
													<select class="easyui-combobox" id="F_fpPype"  name="fpPype" readonly="readonly" required="required" style="width: 200px;" data-options="editable:false,panelHeight:'auto'" validType="selectValueRequired['#test']">
														<option value="0">--请选择--</option>
														<option value="A10" <c:if test="${bean.fpPype=='A10'}">selected="selected"</c:if>>货物</option>
														<option value="A20" <c:if test="${bean.fpPype=='A20'}">selected="selected"</c:if>>工程采购</option>
														<option value="A30" <c:if test="${bean.fpPype=='A30'}">selected="selected"</c:if>>服务</option>
														<option value="A40" <c:if test="${bean.fpPype=='A40'}">selected="selected"</c:if>>办公用品及耗材</option>
													</select>	
												</c:if>
											</td>
											<td style="width: 0px"></td>
											<%-- <td class="td1">意向代理机构</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="fAgencyName"  readonly="readonly"  name="fAgencyName"   style="width: 200px" value="${bean.fAgencyName}"/>
											</td> --%>
											
											<td class="td1"><span class="style1">*</span>&nbsp;采购方式</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fpMethod"  name="fpMethod" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fpMethod}"/>
											</td>
										</tr>
									</table>
										
									<table class="window-table-readonly" cellspacing="0" cellpadding="0" style="margin-left: 105px;">
										<tr>
											<td class="window-table-td1"><p>预算批复金额：&nbsp;</p></td>
											<td class="window-table-td2"><p id="p_pfAmount">${bean.pfAmount}万元</p></td>
												
											<td class="window-table-td1"><p>预算批复时间：&nbsp;</p></td>
											<td class="window-table-td2"><p id="p_pfDate">${bean.pfDate}</p></td>
										</tr>
											
										<tr>
											<td class="window-table-td1"><p>使用部门：&nbsp;</p></td>
											<td class="window-table-td2"><p id="p_pfDepartName">${bean.pfDepartName}</p></td>
												
											<td class="window-table-td1"><p>当前可用余额：&nbsp;</p></td>
											<td class="window-table-td2"><p id="p_syAmount">${bean.syAmount}万元</p></td>
										</tr>
									</table>
									
									<table cellpadding="0" cellspacing="0" class="ourtable">
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>&nbsp;进口产品</td>
											<td class="td2">
			         							<input type="radio" name="fIsImp" readonly="readonly" onclick="javascript:return false" <c:if test="${bean.fIsImp=='1'}">checked="checked"</c:if> value="1">是</input>
			         							<input type="radio" name="fIsImp" readonly="readonly" onclick="javascript:return false" <c:if test="${bean.fIsImp!='1'}">checked="checked"</c:if> value="0">否</input>
											</td>
											<td style="width: 0px"></td>
											<td class="td1"><span class="style1">*</span>&nbsp;是否论证</td>
											<td class="td2">
			         							<input type="radio" name="fIsInquiry" readonly="readonly" onclick="javascript:return false" <c:if test="${bean.fIsInquiry=='1'}">checked="checked"</c:if> value="1">是</input>
			         							<input type="radio" name="fIsInquiry" readonly="readonly" onclick="javascript:return false" <c:if test="${bean.fIsInquiry!='1'}">checked="checked"</c:if> value="0">否</input>
											</td>
										</tr>
										<tr>
											<td class="td1" valign="top"><span class="style1">*</span>&nbsp;采购说明</td>
											<td colspan="4">
												<input class="easyui-textbox" type="text" id="F_fRemark"  name="fRemark" readonly="readonly" required="required" data-options="validType:'length[1,50]',multiline:true"   style="width:555px;height:70px;" value="${bean.fRemark}"/>
											</td>
										</tr>
										<tr style="height: 90px;">
											<td class="td1" valign="top"><p style="margin-top: 8px">其他需求</p></td>
											<td colspan="4">
												<input class="easyui-textbox" type="text" id="F_fOtherRemark" readonly="readonly"  name="fOtherRemark" data-options="validType:'length[1,50]',multiline:true"   style="width:555px;height:70px;" value="${bean.fOtherRemark}"/>
											</td>
										</tr>
										<tr class="trbody">
											<td class="td1">&nbsp;&nbsp;项目需求书</td>
											<td colspan="4">
											<c:if test="${!empty attac}">
											<c:forEach items="${attac}" var="att">
												<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a></br>
											</c:forEach>
											</c:if>
											<c:if test="${empty attac}">
												<span style="color:#999999">暂未上传附件</span>
											</c:if>
										</tr>	
									</table>
								</div>

								<%-- 								<!--第二个div  -->
								<div title="采购需求" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
									<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
										<tr style="height: 70px;">
											<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>需求说明</td>
											<td colspan="4">
												<input class="easyui-textbox" type="text" id="F_fOtherRemark" readonly="readonly"  name="fOtherRemark" data-options="validType:'length[1,50]',multiline:true"   style="width:555px;height:70px;" value="${bean.fOtherRemark}"/>
											</td>
										</tr>
									</table>
								</div> --%>
														<!-- 第三个div -->
								<div title="采购清单" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
 							  		<%@ include file="../check/select_cgconf_plan_mingxi.jsp" %>			
								</div>
								<%-- 						<!-- 第四个div -->
								<div title="审批记录" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
									<jsp:include page="../../check_history.jsp" />												
								</div> --%>
								<c:if test="${!empty bidStauts }">
								<div title="过程登记" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
								<div class="easyui-accordion" data-options="" id="" style="width:662px;margin-left: 20px">
								<!--第1个div  -->
								<div title="供应商信息"  id="gysxxdiv"  data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
									<jsp:include page="../process/course_gys.jsp" />
								</div>
								</div>
								</div>
						</c:if>
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
			$('#p_pfDate').html(ChangeDateFormat(pfDate));
		}
	});

	 //寻找相关制度
	function findSystemFile(id) {
		$.ajax({ 
			url: base+"/cheter/systemFind?id="+id, 
			success: function(data){
				data=data.replace('\"','');
				data=data.replace('\"','');
				window.open(data);
	    }});
	} 
	 
	//查看附件
	function findAttacFile(id) {
		$.ajax({ 
			url: base+"/cgsqsp/attacFind?id="+id, 
			success: function(data){
				data=data.replace('\"','');
				data=data.replace('\"','');
				window.open(data);
	    }});
	}
	//未编辑或者已经编辑完毕的行，计算优惠后总价
	function addNum(rows,index){
		var totalPrice=0;
		var fnum=rows[index]['fnum'];
		var funitPrice=rows[index]['funitPrice'];
		if(fnum!="" && fnum!=null && funitPrice!="" && funitPrice!=null){
			totalPrice= parseFloat(fnum)*(parseFloat(funitPrice));
		}
		return totalPrice;
	}
	//计算总额
	function setFsumMoney(newValue,oldValue) {
		var totalFsumMoney = 0;
		var fsumMoney = 0;
		var index=$('#plan_dg').datagrid('getRowIndex',$('#plan_dg').datagrid('getSelected'));
		var rows = $('#plan_dg').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			if(i==index){
				fsumMoney=setEditing(rows,i);
			}else{
				totalFsumMoney+=addNum(rows,i);
			}  
		 
		}
		totalFsumMoney=totalFsumMoney+fsumMoney;
		$('#totalPrice').textbox('setValue',totalFsumMoney.toFixed(2));
		$('#F_fpAmount').textbox('setValue',totalFsumMoney.toFixed(2));
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
		var fpPype=$("#F_fpPype").combobox('getValue'); 
		if(totalFsumMoney>=100000 && fpPype=='A10'){
			$("#dxyqdybg").show();
		}else{
			$("#dxyqdybg").hide();
		}
	}
	 //加载完以后自动计算金额
    $('#plan_dg').datagrid({onLoadSuccess : function(data){
    	setFsumMoney();
    }});
	 
  //加载tab页
	flashtab('yx-tab');
	 
    var urlcountDJ = 0;
	function onclickDJDetail(){
		if(urlcountDJ>=1){
			urlcountDJ+=1;
			return false;
		}else {
			urlcountDJ+=1;
			return true;
		}
	}
</script>
</body>
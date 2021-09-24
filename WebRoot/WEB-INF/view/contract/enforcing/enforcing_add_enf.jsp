<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<form id="enforcing_add_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div">
				<input type="hidden" name="contId" id="dispute_fcId" value="${bean.fcId}"/>
	    		<input type="hidden" name="fFlowStauts" id="dispute_fFlowStauts" value="${bean.fFlowStauts}"/>
	    		<input type="hidden" name="fContStauts" id="dispute_fContStauts" value="${bean.fContStauts}"/>
	    		<input type="hidden" name="fUserName" id="dispute_fUserName" value="${bean.fUserName}"/>
	    		<input type="hidden" name="fUserCode" id="dispute_fUserCode" value="${bean.fUserCode}"/>
	    		<input type="hidden" name="fOperatorId" id="F_fOperatorId" value="${bean.fOperatorId}"/>
	    		<input type="hidden" name="isSame" id="isSame" value="${contBean.isSame}"/>
	    		<input type="hidden"  id="checkName" value="${signInfo.fSignName}"/>
	    		<input type="hidden"  id="checkBank" value="${signInfo.fBankName}"/>
	    		<input type="hidden"  id="checkBankCard" value="${signInfo.fCardNo}"/>
				<input hidden="hidden" id="F_stauts" name ="stauts">
				<input hidden="hidden" id="F_flowStauts" name ="flowStauts">
				<input hidden="hidden" value="${contBean.payId}" name="payId">
				<input type="hidden" name="payCode" id="F_payCodeId" value="${contBean.payCode}"/>
				<!-- 收款人信息id --><input type="hidden" name="pId" value="${payee.pId}" />
				<!-- 付款方式 --><input type="hidden" name="paymentType" value="${payee.paymentType}" id="paymentType"/>
				<input type="hidden" id="hbank" name="bank" value="${payee.bank}"  /><!-- 开户行 -->
				<input type="hidden" id="hbankAccount" name="bankAccount" value="${payee.bankAccount}" /><!-- 银行账户 -->
				<input type="hidden" id="hpayeeName" name="payeeName" value="${payee.payeeName}" /><!-- 收款人 -->
				<input type="hidden" id="json1" name="form1" />
	    		<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="付款信息" data-options=" collapsible:false" style="overflow:auto;">
						<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>&nbsp;付款性质</td>
										<td class="td2">
											<input id="fReceProperty"  class="easyui-combobox" name="fReceProperty" data-options="editable:true,valueField:'text',
												textField:'text',
												validType:'selectValid',
												method:'post',
												url:'${base}/Expiration/lookupsJson?parentCode=FKXZ'" style="width: 200px;height: 30px"
											value="${payBean.fReceProperty}"/>
										</td>
										
										<td class="td1"><span class="style1">*</span>&nbsp;付款条件</td>
										<td class="td2">
											<input id=""  class="easyui-textbox" required="required"  name="fReceCondition" style="width: 200px;height: 30px" value="${payBean.fReceCondition}"/>
										</td>
									</tr>
								
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>&nbsp;计划付款金额</td>
										<td class="td2">
											<input  class="easyui-textbox" required="required" name="fReceAmount" style="width: 200px;height: 30px" value="${payBean.fRecePlanAmount}"/>
										</td>
										<td class="td1"><span class="style1">*</span>&nbsp;计划付款日期</td>
										<td class="td2">
											<input  class="easyui-datebox" required="required" name="fRecePlanTime" style="width: 200px;height: 30px" value="${payBean.fRecePlanTime}"/>
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>&nbsp;申请部门</td>
										<td class="td2">
											<input  class="easyui-textbox" readonly="readonly" required="required" name="" style="width: 200px;height: 30px" value="${bean.fDeptName}"/>
										</td>
										<td class="td1"><span class="style1">*</span>&nbsp;申请人</td>
										<td class="td2">
											<input  class="easyui-textbox" readonly="readonly" required="required"  style="width: 200px;height: 30px" value="${bean.fOperator}"/>
										</td>
									</tr>
									
									<tr style="height: 70px;">
										<td class="td1"><span class="style1">*</span>合同付款依据及情况说明</td>
										<td colspan="4">
											<input class="easyui-textbox" required="required" id="remarks" name="remarks" data-options="multiline:true,validType:'length[0,200]',validType:'invalid'"  style="width:538px;height:70px" value="${contBean.remarks}"/>
										</td>
									</tr>
								</table>
							</div>				
						</div>	
					</form>
					<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					  	<div title="发票信息" data-options="collapsible:false"
						style="overflow:auto;">
							<c:if test="${openType=='add'}">		
							<div style="overflow:hidden;margin-top: 0px">
								<!-- 新增 -->
								<jsp:include page="enforcing_mingxi.jsp" />
							</div>
							</c:if>
							<c:if test="${openType=='edit'}">		
							<div style="overflow:hidden;margin-top: 0px">
								<!--修改 -->
								<jsp:include page="enforcing_mingxi_edit.jsp" />
							</div>
							</c:if>
						</div>
					</div>	
					<!-- 收款人信息 -->
					<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					  	<div title="收款人信息" data-options="collapsible:false"
						style="overflow:auto;">
						<jsp:include page="payee-info.jsp" />
					</div>
					</div>
					<!-- 附件信息 -->
					<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
						<div title="附件信息" data-options="collapsible:false" style="overflow:auto;">		
							<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width: 707px">
								<tr>
									<td class="td1" style="width:60px;">
										附件
										<input type="file" multiple="multiple" id="f" onchange="upladFile(this,'file','cggl02')" hidden="hidden" >
										<input type="text" id="files" name="fhtzxFiles" hidden="hidden">
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
										<c:forEach items="${attaList}" var="att">
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
						</div>
					</div>
					
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveEnforcing('${payBean.fPlanId}',0)">
					<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveEnforcing('${payBean.fPlanId}',1)">
					<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeFirstWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<div class="window-right-div" id="check_system_div" style="width:254px;height: 591px">
			<jsp:include page="../../check_system.jsp" />
		</div>
	</div>

<script type="text/javascript">
	
flashtab('contract-enforcing-add');	
	

	
	//保存申请信息
	function saveEnforcing(fPlanId,stauts){
		var id =${bean.fcId};
		var uptStatus ;
		$.ajax({ 
			type: 'POST', 
			url: '${base}/Enforcing/getUptStatus?id='+id,
			dataType: 'json', 
			async:false, 
			success: function(data){
				uptStatus = data;
			} 
		}); 	
		if(uptStatus=='2'){
			alert('该合同正在发生变更，无法发起付款');
			return false;
		}
		//附件的路径地址
		var s="";
		$(".fileUrl").each(function(){
			s=s+$(this).attr("id")+",";
		});
		$("#files").val(s);
		var jsonStr1 = $("#form1").serializeJson();
		// 在后台反序列话成明细Json的对象集合
		$('#json1').val(jsonStr1);
		$('#F_flowStauts').val(stauts);
		$('#F_stauts').val(stauts);
		flag = $('#payInfo_form').form('enableValidation').form('validate');
		if(flag){
			$('#hpayeeName').val($('#payeeName').textbox('getValue'));
			//$('#paymentType').val($('#paymentTypeShow').combobox('getValue'));
			$('#hbankAccount').val($('#bankAccount').textbox('getValue'));
			$('#hbank').val($('#bankName').textbox('getValue'));
			if(($('#hpayeeName').val())!=($('#checkName').val())){
				$('#isSame').val(0);
			}else if(($('#hbankAccount').val())!=($('#checkBankCard').val())){
				$('#isSame').val(0);
			}else if(($('#hbank').val())!=($('#checkBank').val())){
				$('#isSame').val(0);
			}else {
				$('#isSame').val(1);
			}
		}else{
			return flag;
		}
		var checkSame =$('#isSame').val();
		if(checkSame=='0'){
			if(confirm('收款人信息与合同约定不一致，是否提交？')==false){
				return;
			}
		}
    	$('#enforcing_add_form').form('submit', {
				onSubmit:function(param){ 
	//				param.planJson=plan;
					flag=$(this).form('enableValidation').form('validate');
					if(flag){
						$.messager.progress();
					}
					return flag;
				}, 
				url:'${base}/Enforcing/save?fPlanId='+fPlanId+'&id=${bean.fcId}',
				type:'post',
				async:true,
				success:function(data){
					if(flag){
						$.messager.progress('close');
					}
					data=eval("("+data+")");
					
					if(data.success){
						$.messager.alert('系统提示', data.info, 'info');
						$('#enforcing_plan_dg').datagrid('reload'); 
						$('#enforcing_add_form').form('clear');
						$("#indexdb").datagrid('reload');
						closeFirstWindow();
						closeWindow();
					}else{
						$.messager.alert('系统提示', data.info, 'error');
						$('#enforcing_add_form').form('clear');
						closeFirstWindow();
					}
				} 
			});		
		}
		function fPurchNo_DC(){
			//var node=$('#c_c_dg').datagrid('getSelected');
			var win=creatFirstWin('选择-采购订单号',750,550,'icon-add','/PurchaseApply/PurchNoList');
			win.window('open');
		}
		function quota_DC(){
			//var node=$('#c_c_dg').datagrid('getSelected');
			var win=creatFirstWin('选择-预算指标编号',750,550,'icon-add','/BudgetIndexMgr/contract_list');
			win.window('open');
		}
		var c =0;
		function upt_upFile() {
			/* console.log(document.getElementById("upt_fFileSrc1"));
			var src = getFilePath();
			alert(getFilePath()); */
			c ++;
			var src = $('#upt_fFileSrc1').val();
			/* var srcs =src+','+$('#upt_fi1').val();
			$('#upt_fi1').val(srcs); */
			$('#upt__f1').append("<div id='c"+c+"'><a href='#' class='file_U' style='color: #3f7f7f;font-weight: bold;'>"+src+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a style='color: red;' href='#' onclick='deleteF1(c"+c+")'>删除</a></div>");
		} 
		function deleteF1(val){
			var child=document.getElementById(val.id);
			child.parentNode.removeChild(child);
		}
		//时间格式化
		function ChangeDateFormat(val) {
			//alert(val)
			var t, y, m, d, h, i, s;
			if (val == null) {
				return "";
			}
			t = new Date(val)
			y = t.getFullYear();
			m = t.getMonth() + 1;
			d = t.getDate();
			h = t.getHours();
			i = t.getMinutes();
			s = t.getSeconds();
			// 可根据需要在这里定义时间格式  
			return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
		}
	</script>
</body>
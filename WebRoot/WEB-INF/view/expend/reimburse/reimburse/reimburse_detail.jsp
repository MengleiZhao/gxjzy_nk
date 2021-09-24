<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<form id="reimburse_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:720px;height: 491px">
			<div class="window-left-top-div">
			
				<!-- 隐藏域 --> 
				<!-- 主键ID --><input type="hidden" name="rId" value="${bean.rId}" id="rId"/>
				<!-- 报销单号 --><input type="hidden" name="rCode" value="${bean.rCode}"/>
				<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="reimburseFlowStauts" />
				<!-- 报销状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="reimburseStauts" />
				<%-- <!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
				<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" /> --%>
				<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
				<!-- 报销类型 --><input type="hidden" id="reimburseTypeHi" value="${bean.type}" name="type"/>
				<!-- 报销类型 --><input type="hidden" id="reimburseAmount" name="amount" value="${bean.amount}"/>
				<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id=""/>
				<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="indexType"/>
				<!-- 报销人 --><input type="hidden" name="userName" value="${bean.userName}" id="input_userName"/>
				<!-- 报销部门 --><input type="hidden" name=deptName value="${bean.deptName}" id="input_deptName"/>
				<div id="panelID" class="easyui-panel" data-options="closed:true">
				<!-- 报销时间 --><input class="easyui-datetimebox" name="reimburseReqTime" value="${bean.reimburseReqTime}" id="input_reimburseReqTime" />
				<!-- 项目支出明细ID --><input type="hidden" name="proDetailId" value="${bean.proDetailId}" id="proDetailId"/>
				<!-- 可用金额  --><input type="hidden" id="syAmount" value="${bean.syAmount}"/>
				<!-- 批复金额  --><input type="hidden" id="pfAmount" value="${bean.pfAmount}"/>
				<!-- 批复时间  --><input type="hidden" id="pfDate"  value="${bean.pfDate}"/>
				</div>
			
			
				<!-- 基本信息 -->
				<div id="spbxjbxx" style="overflow:auto; margin-top: -15px;">
				
					<div class="window-title">基本信息</div>
					
					<table class="window-table window-table-readonly" cellspacing="0" cellpadding="0">
						<tr>
							<td class="window-table-td1"><p>报销人:</p></td>
							<td class="window-table-td2"><p>${bean.userName}</p></td>
							
							<td class="window-table-td1"><p>报销部门:</p></td>
							<td class="window-table-td2"><p>${bean.deptName}</p></td>
						</tr>
						
						<tr>
							<td class="window-table-td1"><p>报销时间:</p></td>
							<td colspan="3"><p id="p_reimburseReqTime">${bean.reimburseReqTime}</p></td>
						</tr>
					</table>
					
					<table class="window-table" style="margin-top: 10px" cellspacing="0" cellpadding="0">
					
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 申请单号</td>
							<td colspan="4">
								<input style="width: 590px;height: 30px;" name="gCode" class="easyui-textbox"
								value="${bean.gCode}" data-options="prompt: '事前申请选择' ,icons: [{iconCls:'icon-sousuo'}],required:true" readonly="readonly"/>
							</td>
						</tr>
						
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 报销摘要</td>
							<td colspan="4">
								<input style="width: 590px; height: 30px;" name="gName" class="easyui-textbox"
								value="${bean.gName}" readonly="readonly"/>
							</td>
						</tr>
					
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 支出项目</td>
							<td colspan="3">
								<input class="easyui-textbox" style="width: 590px;height: 30px;"
								name="indexName" value="${bean.indexName}" id="F_fBudgetIndexName"
								data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
							</td>
						</tr>
						
					</table>

					<table class="window-table window-table-readonly" cellspacing="0" cellpadding="0">
						<tr>
							<td class="window-table-td1"><p>批复金额:</p></td>
							<td class="window-table-td2"><p id="p_pfAmount">${bean.pfAmount}</p></td>
							
							<td class="window-table-td1"><p>批复时间:</p></td>
							<td class="window-table-td2"><p id="p_pfDate">${bean.pfDate}</p></td>
						</tr>
						
						<tr>
							<td class="window-table-td1"><p>使用部门:</p></td>
							<td class="window-table-td2"><p id="p_pfDepartName">${bean.pfDepartName}</p></td>
							
							<td class="window-table-td1"><p>可用余额:</p></td>
							<td class="window-table-td2"><p id="p_syAmount">${bean.syAmount}</p></td>
						</tr>
						
					
					</table>

					<table class="window-table" cellspacing="0" cellpadding="0">
						
						
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 冲销借款</td>
							<td class="td2">
								<input id="hotelstd_add_sfwj" name="withLoan" value="1"
									type="radio" readonly="readonly" onclick="selectCxjk(this)" <c:if test="${bean.withLoan==1 }">checked="checked"</c:if>/>是
								<input id="hotelstd_add_sfwj" name="withLoan" value="0"
									type="radio" readonly="readonly" onclick="selectCxjk(this)" <c:if test="${bean.withLoan!=1 }">checked="checked"</c:if>/>否
									 
						</tr>
						
						<tr class="trbody cxjk">
							<td class="td1">借款单号</td>
							<td class="td2">
								<a href="#" onclick="chooseJkd()">
									<input class="easyui-textbox" id="input_jkdbh" style="width: 590px;height: 30px;" data-options="icons: [{iconCls:'icon-sousuo'}]"
									value="${bean.loan.lCode}" readonly="readonly">
									<input id="input_jkdid" type="hidden" name="bean.loan.lId"/>
								</a>
							</td>
						</tr>
	
						<tr class="trbody">
							<td class="td1">
								&nbsp;&nbsp;附件
								<input type="file" multiple="multiple" id="f" onchange="upladFile(this,null,'zcgl03')" hidden="hidden">
								<input type="text" id="files" name="files" hidden="hidden">
							</td>
							
							<td colspan="4" id="tdf">
								<%-- <a onclick="$('#f').click()" style="font-weight: bold;" href="#">
									<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
								</a> --%>
								<c:forEach items="${attaList}" var="att">
									<div style="margin-top: 10px;">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
									&nbsp;&nbsp;&nbsp;&nbsp;
									<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
									</div>
								</c:forEach>
								<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
									<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
								 	</div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
								</div>
							</td>
						</tr>
						
						<tr style="height:5px;"></tr>
						
						<tr class="trbody" style="margin-top: 10px;">
							<td class="td1" valign="top"><p style="margin-top: 8px;"><span class="style1">*</span> 报销事由</p></td>
							<td colspan="4">
								<textarea name="reimburseReason"  id="reimburseReason"  class="textbox-text"  oninput="textareaNum(this,'textareaNum1')" autocomplete="off"   style="width:590px;height:70px;resize:none">${bean.reimburseReason }</textarea> 
     					
								<%-- <input class="easyui-textbox" data-options="multiline:true,required:false,validType:'length[0,250]'" name="reimburseReason" style="width:590px;height:70px;" 
								value="${bean.reimburseReason}"> --%>
							</td>
						</tr>
						<%-- <tr>
							<td align="right" colspan="5">
							可输入剩余数：<span id="textareaNum1" class="250">
							<c:if test="${empty bean.reimburseReason}">250</c:if><c:if test="${!empty bean.reimburseReason}">${250-bean.reimburseReason.length()}</c:if>
							</span>
							</td>
						</tr> --%>
	
					</table>
				</div>
				
	
				<!-- 会议信息 -->
				<div id="spbxhyxx" style="overflow:auto;margin-top: 10px;">
					<div class="window-title">会议信息</div>
					<jsp:include page="../../apply/check/meetingCheck.jsp" />
				</div>
	
				<!-- 培训信息 -->
				<div  id="spbxpxxx"  style="overflow:auto;margin-top: 10px;">
					<div class="window-title">培训信息</div>
					<jsp:include page="../../apply/check/trainingCheck.jsp" />
				</div>
	
				<!-- 差旅信息 -->
				<div id="spbxclxx"  style="overflow:auto;margin-top: 10px;">
					<div class="window-title">差旅信息</div>
					<jsp:include page="../../apply/check/travelCheck.jsp" />
				</div>
	
				<!-- 接待信息 -->
				<div id="spbxjdxx" style="overflow:auto;margin-top: 10px;">
					<div class="window-title">接待信息</div>
					<jsp:include page="../../apply/check/receptionCheck.jsp" />
				</div>
				
				<!-- 接待人员名单 -->
				<div id="spbxjdrymd" style="overflow:auto;margin-top: 10px;">
					<div class="window-title">接待人员名单</div>
					<jsp:include page="../../apply/check/reception_peopleCheck.jsp" />
				</div>
				
				<!-- 公务用车信息 -->
				<div id="spbxgwyc" style="overflow:auto;margin-top: 10px;">
					<div class="window-title">公务用车信息</div>
					<jsp:include page="../../apply/check/officeCarCheck.jsp" />
				</div>
				
				<!-- 公务出国信息 -->
				<div id="spbxgwcg" style="overflow:auto;margin-top: 10px;">
					<div class="window-title">公务出国信息</div>
					<jsp:include page="../../apply/check/abroadCheck.jsp" />
				</div>
	
				<!-- 报销明细 -->
				<div style="overflow:auto;margin-top: 10px;" id="spbxbxmx">
					<div class="window-title">报销明细</div>
					<jsp:include page="reimburse_mingxi.jsp" />
				</div>
				
				<%-- <div title="发票信息" id="spbxfpxx" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
					<jsp:include page="reimburse_invoice.jsp" />
				</div> --%>
				
				<!-- 收款人信息 -->
				<div style="overflow:auto;margin-top: 10px;">
				
					<div class="window-title">收款人信息</div>
				
					<jsp:include page="../../payee-info.jsp" />
					<!-- 收款人主键ID -->
					<input type="hidden" name="pId" value="${payee.pId}"/>
					<input hidden="hidden" id="num2" name="payeeAmount" value="${payee.payeeAmount}" readonly="readonly" precision="2"/>	
				</div>
				
				<!-- 审批记录 -->
				<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
					<div class="window-title">审批记录</div>
					<c:if test="${bean.type!=1 }">
						<jsp:include page="../../../check_history.jsp" />												
					</c:if>
					<c:if test="${bean.type==1 }">
						<jsp:include page="../check/check_history.jsp" />												
					</c:if>
				</div>
				<!-- 下级审批人 -->
				<c:if test="${bean.type==1 }">
					<div id="xjspr" style="overflow:auto;margin-top: 10px;">
						<div class="window-title">下一级审批人</div>
						<jsp:include page="nextrole.jsp" />
					</div>
				</c:if>
				<%-- <!-- 资金信息 -->
				<div id="spbxzjxx" style="overflow:auto;margin-top: 10px;">
					<div class="window-title">资金信息</div>
					<jsp:include page="../../apply/check/fundCheck.jsp" />
				</div> --%>
		
			</div>
			
			<div class="window-left-bottom-div">
			<%-- 	<a href="javascript:void(0)" onclick="saveReimburse(0)">
					<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveReimburse(1)">
					<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp; --%>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=支出管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		<c:if test="${bean.type!=1 }">
			<div class="window-right-div" data-options="region:'east',split:true">
				<jsp:include page="../../../check_system.jsp" />
			</div>
		</c:if>
	</div>
</form>

<script type="text/javascript">
//显示详细信息手风琴页面
$(document).ready(function() {
	//是否显示 冲销借款信息
	selectCxjk();
	//设置时间
	if ($("#rId").val() == "") {
		var date = new Date();
		date=ChangeDateFormat(date);
		$("#input_reimburseReqTime").val(date);
		$("#p_reimburseReqTime").html(date);
	}

	var h = $("#reimburseTypeHi").textbox().textbox('getValue');
	if (h != "") {
		$('#reimburseType').textbox().textbox('setValue', h);
		$('#reimburseType').textbox().attr('readonly', true);
	}
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
	/* //批复时间
	var pfDate = $("#pfDate").val();
	if(pfDate !=""){
		$('#p_pfDate').html(pfDate);
	}
	 
	var applyAmount = $("#applyAmount").val();
	$('#applyAmount_span').html(fomatMoney(applyAmount,2)+" [元]");
	*/
	
	if (h == 1) {
		$('#spbxhyxx').remove();
		$('#spbxpxxx').remove();
		$('#spbxclxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwyc').remove();
		$('#spbxgwcg').remove();
		/* $("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息'); */
	}
	if (h == 2) {//会议
		$('#spbxpxxx').remove();
		$('#spbxclxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwyc').remove();
		$('#spbxgwcg').remove();
	}
	if (h == 3) {//培训
		$('#spbxhyxx').remove();
		$('#spbxclxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwyc').remove();
		$('#spbxgwcg').remove();
	}
	if (h == 4) {//差旅
		$('#spbxhyxx').remove();
		$('#spbxpxxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwyc').remove();
		$('#spbxgwcg').remove();
	}
	if (h == 5) {//接待
		$('#spbxhyxx').remove();
		$('#spbxpxxx').remove();
		$('#spbxclxx').remove();
		$('#spbxgwyc').remove();
		$('#spbxgwcg').remove();
	}
	if (h == 6) {//公务用车
		$('#spbxhyxx').remove();
		$('#spbxpxxx').remove();
		$('#spbxclxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwcg').remove();
	}
	if (h == 7) {//公务出国
		$('#spbxhyxx').remove();
		$('#spbxpxxx').remove();
		$('#spbxclxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwyc').remove();
	}
});

function selectCxjk(){
	var cxjk = $('input[name="withLoan"]:checked').val();
	if(cxjk==1){
		$('tr.cxjk').css('display','');
	} else {
		$('tr.cxjk').css('display','none');
	}
}

//保存
function saveReimburse(flowStauts) {
	var applyAmount1 = $("#applyAmount1").val();
	var nums = $("#nums").val();
	var num3 = $("#num3").val();

	//设置审批状态
	$('#reimburseFlowStauts').val(flowStauts);
	//设置报销状态
	$('#reimburseStauts').val(flowStauts);

	if(nums>num3){
			var win=creatFirstWin(' ',360,280,'icon-search','/reimburse/overfulfil?standard='+num3+"&amount="+nums+"&applyAmount="+applyAmount1.toFixed(2)+"&sts="+flowStauts);
			win.window('open');
		}else{
	// 在后台反序列话成明细Json的对象集合
	accept();
	var rows = $('#rmxdg').datagrid('getRows');
	var mingxi = "";
	for (var i = 0; i < rows.length; i++) {
		mingxi = mingxi + JSON.stringify(rows[i]) + ",";
	}
	$('#rMingxiJson').val(mingxi);
	
	/* // 在后台反序列话成发票Json的对象集合
	accept2();
	var rows2 = $('#drfpdg').datagrid('getRows');
	var fapiao = "";
	for (var i = 0; i < rows2.length; i++) {
		fapiao = fapiao + JSON.stringify(rows2[i]) + ",";
	}
	$('#rfpJson').val(fapiao); */
	
	
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);


	var h = $("#reimburseTypeHi").textbox().textbox('getValue');
	
	//提交
	$('#reimburse_save_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				//如果校验通过，则进行下一步
				$.messager.progress();
			}else{
				//校验不通过，就打开第一个校验失败的手风琴
				openAccordion();
			}
			return flag;
		},
		url : base + '/reimburse/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#reimburse_save_form').form('clear');
				$('#reimburseTab'+h).datagrid('reload');
				$('#indexdb').datagrid('reload');
				closeWindow();
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
		}
}





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

//打开事前申请选择页面
function openApply(applyType) {
	var win = creatFirstWin('申请单选择', 840, 450, 'icon-search', '/reimburse/applyList?applyType='+applyType);
	win.window('open');
}

//打开借款单选择页面
function chooseJkd(){
	var win = creatFirstWin('借款单选择', 840, 450, 'icon-search', '/loan/choose?menuType=fromBxsq');
	win.window('open');
}

//选择申请单
function choiceApply(gId,applyType){
	$.ajax({
	      type:'post',
	      url:base+'/reimburse/findApply?gId='+gId,
	      dataType: 'json',
	      success:function(data){
	    	 	 console.log(data)
	    		$('#reimburse_save_form').form('load', data);
	    	  	$('#rmxdg').datagrid({url:base+'/apply/mingxi'});
	    	  	$('#rmxdg').datagrid('reload',{id:data.gId});
	    	  	//$('#reimburseAmount').textbox('setValue','0');
	    	  	//预算批复金额
	    	  	$('#p_pfAmount').html(data.pfAmount);
	    	  	//预算批复时间
	    	  	$('#p_pfDate').html(data.pfDate);
	    	  	//使用部门
	    	  	$('#p_pfDepartName').html(data.pfDepartName);
	    	  	//可用金额
	    	  	$('#p_syAmount').html(data.syAmount);
	    	  	$('#indexType').val(data.indexType);
	      }
	});
	if(applyType==2||applyType==3){
		$.ajax({
		      type:'post',
		      url:base+'/reimburse/findOther?gId='+gId+'&type='+applyType,
		      dataType: 'json',
		      success:function(data){
		    		$('#reimburse_save_form').form('load', data);
		      }
		});
	}
	if(applyType==4){
		//差旅报销
		$.ajax({
		      type:'post',
		      url:base+'/reimburse/findOther?gId='+gId+'&type='+applyType,
		      dataType: 'json',
		      success:function(data){
		    		$('#reimburse_save_form').form('load', data);
		    		
		    		/* $('#placeStart1').combobox('reload',base+'/area/placeEndJson?code='+data.placeEnd);
		    		$('#placeStart2').combobox('reload',base+'/area/placeEndJson?sonCode='+data.placeEnd); */
		    		$('#travel_add_placeEnd').textbox('setValue',data.travelArea.area);
		    		$('#placeEnd1').combobox('reload',base+'/area/placeEndJson?code='+data.placeStart);
		    		$('#placeEnd2').combobox('reload',base+'/area/placeEndJson?sonCode='+data.placeStart);
		    		$('#vehicle1').combobox('reload',base+'/vehicle/comboboxJson?selected='+data.vehicleLevel+'&parentCode='+data.vehicle);
		    		$('#vehicle2').combobox('reload',base+'/vehicle/comboboxJson?selected='+data.vehicle);
		      }
		});
	}
	if(applyType==5){
		$.ajax({
		      type:'post',
		      url:base+'/reimburse/findOther?gId='+gId+'&type='+applyType,
		      dataType: 'json',
		      success:function(data){
		    		$('#reimburse_save_form').form('load', data);
		    		$('#rpt').datagrid({url:base+'/apply/recep'});
		    		$('#rpt').datagrid('reload',{id:data.jId});
		      }
		});
	}
	if(applyType==6){
		$.ajax({
		      type:'post',
		      url:base+'/reimburse/findOther?gId='+gId+'&type='+applyType,
		      dataType: 'json',
		      success:function(data){
		    		$('#reimburse_save_form').form('load', data);
		      }
		});
	}
	if(applyType==7){
		$.ajax({
		      type:'post',
		      url:base+'/reimburse/findOther?gId='+gId+'&type='+applyType,
		      dataType: 'json',
		      success:function(data){
		    		$('#reimburse_save_form').form('load', data);
		      }
		});
	}
	closeFirstWindow();
}
//打开指标选择页面
function openIndex() {
	//var win=creatFirstWin('选择指标',860,580,'icon-search','/quota/choiceIndex');
	var win=creatFirstWin('选择指标',1060,580,'icon-search','/apply/choiceIndex?menuType=beforeApply'); 
	win.window('open');
}		
		
</script>

</body>


<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<form id="apply_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div">
				<!-- 隐藏域 --> 
				<!-- 主键ID --><input type="hidden" name="gId" value="${bean.gId}" />
				<!-- 申请单流水号 --><input type="hidden" name="gCode" value="${bean.gCode}" />
				<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="applyflowStauts" />
				<!-- 申请状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="applyStauts" />
				<%-- <!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
				<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" /> --%>
				<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
				<!-- 申请类型 --><input type="hidden" id="applyTypeHi" value="${bean.type}" />
				<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id="F_fBudgetIndexCode"/>
				<!-- 项目支出明细ID --><input type="hidden" name="proDetailId" value="${bean.proDetailId}" id="F_proDetailId"/>
				<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="F_indexType"/>
				<!-- 申请时间  --><input type="hidden" id="applyReqTime" name="reqTime" value="${bean.reqTime}"/>
				<!-- 申请事项  --><input type="hidden" id="applyType" name="type" value="${bean.type}"/>
				<!-- 申请总额  --><%-- <input type="hidden" id="applyAmount" name="amount" value="${bean.amount}"/> --%>
				<!-- 可用金额  --><input type="hidden" id="syAmount" value="${bean.syAmount}"/>
				<!-- 批复金额  --><input type="hidden" id="pfAmount" value="${bean.pfAmount}"/>
				<!-- 批复时间  --><input type="hidden" id="pfDate"  value="${bean.pfDate}"/>
				<!-- 流程id  --><input type="hidden" id="flowId"  value="${fpId}"/>
				<!--历史审批节点  --><input type="hidden" id="historyNodes"  value="${historyNodes}"/>
				<!-- 下一级审批节点  --><input type="hidden" id="nextKey"  value="${bean.nCode}"/>
				<!-- 隐藏域主键 -->
			<input type="hidden" name="jId" value="${receptionBean.jId}" />
			<input type="hidden" id="diningPlaceHi" value="${receptionBean.diningPlace}" />
			<input type="hidden" id="receptionLevelHi" value="${receptionBean.receptionLevel}" />
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
								
								<td class="window-table-td1"><p>预算年度：</p></td>
								<td class="window-table-td2"><p id="p_pfDate">${bean.pfDate}</p></td>
								<td class="window-table-td1"><p></p></td>
								<td class="window-table-td2"><p></p></td>
							</tr>
							
							<tr hidden="hidden">
								<td class="window-table-td1"><p>批复金额：</p></td>
								<td class="window-table-td2"><p id="p_pfAmount">${bean.pfAmount}元</p></td>
								<td class="window-table-td1"><p>可用额度：</p></td>
								<td class="window-table-td2"><p id="p_syAmount">${bean.indexAmount}元</p></td>
							</tr>
					</table>				
				</div>
				</div>
				<!-- 基本信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
				<div title="基本信息" data-options=" collapsible:false" style="overflow:auto;">
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
						<tr class="trbody">
							<td class="td1" ><span class="style1">*</span> 事项摘要</td>
							<td colspan="3">
								<c:if test="${operation=='add' }">
									<input class="easyui-textbox" style="width: 606px;height: 30px; " value="${draftAdd}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
								</c:if>
								<c:if test="${operation!='add' }">
									<input class="easyui-textbox" style="width: 606px;height: 30px; " value="${bean.gName}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
								</c:if>
							</td>
						</tr>
							<jsp:include page="reception.jsp" />
					</table>
				</div>				
				</div>
				
				<!-- 会议日程 -->
				<%-- <div class="easyui-accordion" style="">
				<div title="会议日程" data-options="iconCls:'icon-xxlb',collapsible:false"
					style="overflow:auto;">
					<div style="overflow:auto;margin-top: 0px">
						<jsp:include page="meeting_plan.jsp" />
					</div>
				</div>
				</div> --%>
				<!-- 参考观察者安排 -->
				<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="参考观察安排" data-options="collapsible:false"
						style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px">
						<jsp:include page="observe_plan.jsp" />
						</div>
					</div>
				</div> --%>
				<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="其他安排" data-options="collapsible:false"
						style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px">
						<tr style="height: 70px;">
							<td colspan="3">
								<textarea name="otherContet"  id="otherContet" class="textbox-text"   autocomplete="off" 
								  style="width:700px;height:80px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:5px; margin-bottom:0px;">${receptionBean.otherContet}</textarea>
							</td>
						</tr>
						</div>
					</div>
				</div> --%>
				<%-- <!-- 费用明细 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="费用明细" data-options="collapsible:false"
						style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px">
							<!--  公务接待申请  明细 -->
							<jsp:include page="mingxi_reception.jsp" />
							<div style="overflow:auto;margin-top: 10px;">
								<span style="float: left;">
									<span style="color: red;"  >申请金额总计： </span>
									<span style="float: right;"  id="applyAmount_span" ><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span>
								</span>
							</div>
							<div class="window-table" style="margin-bottom:10px;">
								<div style="">
									<span>被接待人员自行缴纳伙食费和交通费情况</span>
								</div>
								<div style="width:700px;margin-top:10px;display:flex">
									<div style="flex:1;">
									<label>缴费人数&nbsp;</label> 
									<input type="text" name="paymentNum" class="easyui-numberbox" style="width:150px;" value="${receptionBean.paymentNum}" />
									</div>
									<div style="flex:1;">
									<label>缴费标准&nbsp; </label> 
									<input type="text" name="paymentStd" class="easyui-textbox" style="width:150px;"value="${receptionBean.paymentStd}" />
									</div>
									<div style="flex:1;">
									<label>缴费总金额&nbsp;</label> 
									<input type="text" name="paymentAmount" class="easyui-numberbox" style="width:150px;" value="${receptionBean.paymentAmount}" data-options="icons: [{iconCls:'icon-yuan'}],precision:2"/>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div> --%>
				
				<!-- 附件信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="附件信息" data-options="collapsible:false" style="overflow:auto;">		
						<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width: 707px">
							<tr>
								<td class="td1" style="width:60px;">
									附件
									<input type="file" multiple="multiple" id="f" onchange="upladFile(this,'file','zcgl01')" hidden="hidden">
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
			
			<div class="window-left-bottom-div" style="margin-top: 55px;">
				<a href="javascript:void(0)" onclick="saveApply(0)">
				<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveApply(1)">
				<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				&nbsp;&nbsp;
				 <a href="${base }/systemcentergl/list?typeStr=支出管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a> 
				&nbsp;&nbsp;
				<%-- <a href="javascript:void(0)" onclick="showFlowDesinger()">
				<img src="${base}/resource-modality/${themenurl}/button/CCLCT1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>  --%>
			</div>
			
		</div>
		<c:if test="${type!=1 }">
			<div class="window-right-div" id="check_system_div" style="width:254px;height: auto;padding-bottom: 20px;">
				<jsp:include page="../../../check_system.jsp" />
			</div>
		</c:if>
	</div>
</form>
<script type="text/javascript">


function ChangeDateFormat1(val) {
	var t, y, m, d, h, i, s;
    if(val==null){
  	  return "";
    }
    t = new Date(val);
    y = t.getFullYear();
    m = t.getMonth() + 1;
    d = t.getDate();
    h = t.getHours();
    i = t.getMinutes();
    s = t.getSeconds();
    // 可根据需要在这里定义时间格式  
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
}



//保存
function saveApply(flowStauts) {
	if($('#receptionContent').val()==''){
		alert('请注意填写接待事由！');
		return ;
	}
	if($('#applyAmount_span').html()=='&nbsp;'||parseInt($('#applyAmount_span').html())<=0){
		alert('请注意填写费用明细金额！');
		return ;
	}
	
	/* if($('#box1').is(':checked')){
		var unitFeteNum =isNaN(parseInt($('#unitFeteNum').numberbox('getValue')))?0:parseInt($('#unitFeteNum').numberbox('getValue'));//宴请人数
		var personNum =isNaN(parseInt($('#rePeopNum').numberbox('getValue')))?0:parseInt($('#rePeopNum').numberbox('getValue'));//接待人数
		if(personNum<unitFeteNum){
			alert('接待对象人数不能小于宴请人数！');
			return false;
		}
	} */
	
	// 在后台反序列化成明细Json的对象集合
	var h = $("#applyTypeHi").val();
/* 	var plan1 = $("#diningPlacePlan1").val();
	var plan2 = $("#diningPlacePlan2").val();
	if(plan1=='1'){
		var yanqing = requiredValidatebox();
		if(yanqing==false){
			alert('宴请信息不完整,请填写完整！');
			return false;
		}
	}
	if(plan2=='1'){
		var diningPlace = $("#diningPlace").textbox('getValue');
		if(diningPlace==''){
			alert('工作餐就餐地点未填写,请填写完整！');
			return false;
		}
	} */
	
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	var s1="";
	$(".jdghfileUrl").each(function(){
		s1=s1+$(this).attr("id")+",";
	});
	/* if(s1==''){
		alert('请上传接待公函及其他附件');
		return
	} */
	if(flowStauts!='0'){
	 if(s==''){
		alert('请上传附件');
		return
	} 
	}
	//在后台反序列化成会议日程Json的对象集合
	//meetPlanJson
	/* acceptP();
	var rows = $('#dg_reception_people').datagrid('getRows');
	var recePeopJson = "";
	for (var i = 0; i < rows.length; i++) {
		recePeopJson = recePeopJson + JSON.stringify(rows[i]) + ",";
	}
	$('#recePeopJson').val(recePeopJson);
	acceptR();
	var rows1 = $('#rec-hotel-dg').datagrid('getRows');
	var hotelJson = "";
	for (var i = 0; i < rows1.length; i++) {
		hotelJson = hotelJson + JSON.stringify(rows1[i]) + ",";
	}
	$('#hotelJson').val(hotelJson);
 */
	//acceptO();
	//var rows1 = $('#dg_observe_plan').datagrid('getRows');
	var observePlan = "";
	/* for (var i = 0; i < rows1.length; i++) {
		
		observePlan = observePlan + JSON.stringify(rows1[i]) + ",";
	} */
	
	$('#observePlan').val(observePlan);
	//accept1();
	var num =0;
	//var rows2 = $('#rec-food-dg').datagrid('getRows');
	var foodJson = "";
	//var isForeign = $('input[name="isForeign"]:checked').val();	
	/* for (var i = 0; i < rows2.length; i++) {
		foodJson = foodJson + JSON.stringify(rows2[i]) + ",";
		if(isForeign==0){
			if(rows2[i].time==''){
				alert("请将餐费里的时间填写完整");
				return false;
			}
			
			if(rows2[i].fFoodType=="宴请"){
				num=num+1;
			}
		}else{
			if(rows2[i].date==''){
				alert("请将餐费里的日期填写完整");
				return false;
			}
			if(rows2[i].fFoodType!="日常伙食"){
				num=num+1;
			}
		}
		if(rows2[i].place==''){
			alert("请将餐费里的地点填写完整");
			return false;
		}
		if(rows2[i].fFoodType==''){
			alert("请将餐费里的标准填写完整");
			return false;
		}
		if(rows2[i].fPersonNum==''){
			alert("请将餐费里的用餐总人数填写完整");
			return false;
		}
	} */
	$('#foodJson').val(foodJson);
	/* if(isForeign==0){
		if(num>1){
			alert("宴请次数已超过上限！");
			return;
		}
	}else{
		if(num>2){
			alert("宴请次数已超过上限！");
			return;
		}
	} */
	//accept2();
	//var rows3 = $('#rec-other-dg').datagrid('getRows');
	var otherJson = "";
	/* for (var i = 0; i < rows3.length; i++) {
		otherJson = otherJson + JSON.stringify(rows3[i]) + ",";
	} */
	$('#otherJson').val(otherJson);
	//设置审批状态
	$('#applyflowStauts').val(flowStauts);
	//设置申请状态
	$('#applyStauts').val(flowStauts);

	/* if($('#applyAmount').val()==""||$('#applyAmount').val()=="0.00") {
		alert('请填写费用明细申请金额');
		return;
	} */
	
	//校验
	//预算指标
	var budgetIndexName = $('#F_fBudgetIndexName').val();
	if(flowStauts!='0'){
	if(budgetIndexName == ''){
		alert('请选择支出项目！');
		return;
	}
	}
	//申请金额
	var applyAmount = isNaN(parseFloat($('#amount').numberbox('getValue')))?0:$('#amount').numberbox('getValue');
	/* if(applyAmount == '' || applyAmount == '0.00') {
		alert('请填写费用明细申请金额！');
		return;
	} */
	var syAmount = $('#syAmount').val();
	if(parseFloat(syAmount)<parseFloat(applyAmount)){
		alert('预算可用金额不足,请重新选择支出项目！');
		return;
	}
	var flag = true;
	//提交
	$('#apply_save_form').form('submit', {
		onSubmit : function() {
			if(flowStauts!='0'){
			flag = $(this).form('enableValidation').form('validate');
			 if (flag) {
				//如果校验通过，则进行下一步
				$.messager.progress();
			}else{
				//校验不通过，就打开第一个校验失败的手风琴
				openAccordion();
			}
			return flag;
			}
		},
		url : base + '/apply/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			} 
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#applyTab'+h).datagrid('reload');
				$('#indexdb').datagrid('reload');
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

function standardFlag() {
	var row = $('#appli-detail-dg').datagrid('getRows');
	for(var i=0;i<row.length;i++) {
		if(row[i].standard!="据实列支") {//当开支标准不等于据实列支是，判断
			if(parseFloat(row[i].applySum)>parseFloat(row[i].standard)){
				alert('申请金额不能大于开支标准，请核对！');
				return false;
			}
		}
	}
	return true;
}

//计算申请总额
function addNum(newValue,oldValue) {
	var type = '${type}';
	
	if (type!='1' && type!='6') {
		//bakup 2019-05-08 差旅明细使用固定配置
		
		//2-计算当前编辑行
		var row = $('#appli-detail-dg-travel').datagrid('getSelected');//获得选择行
		var index=$('#appli-detail-dg-travel').datagrid('getRowIndex',$('#appli-detail-dg-travel').datagrid('getSelected'));//获得选中行的行号
		var tr = $('#appli-detail-dg-travel').datagrid('getEditors', index);
		var standar = row.standard;
		var price = parseFloat(newValue);
		var priceOld = parseFloat(row.applySum);//判断之前是否有数据
		//计算总额：1-计算非编辑行
		var rows = $('#appli-detail-dg-travel').datagrid('getRows');
		var totalPrice = 0;
		var pri = 0;
		for(var i=0; i<rows.length; i++){
			
			if(i==index){
				pri =parseFloat(newValue);
			}else{
				totalPrice+=addNums(rows,i);
			} 
		}
		//3-两类数值相加得到总额
		if(!isNaN(price)){
			if(parseFloat(newValue) > standar){
				alert('申请金额不能大于开支标准，请核对！');
				tr[0].target.numberbox('setValue','0');
				newValue=0;
			} else {
				//原先有数据且未改动的，不能进入总额合计
				if(!isNaN(priceOld) && isNaN(parseFloat(oldValue))){
					return;
				} else {
					totalPrice = totalPrice + price;
				}
			}
		}
		//给两个总额框赋值
		$('#applyAmount').val(totalPrice.toFixed(2));//
		$('#applyAmount_span').html(fomatMoney(totalPrice,2)+" [元]");
		$('#num1').numberbox('setValue',totalPrice.toFixed(2));
		return;
	} else {
		var row = $('#appli-detail-dg').datagrid('getSelected');//获得选择行
		var index=$('#appli-detail-dg').datagrid('getRowIndex',row);//获得选中行的行号
		var tr = $('#appli-detail-dg').datagrid('getEditors', index);
		var standar= tr[1].target.textbox('getValue');//获得选中行的开支标准
		
		if(parseFloat(newValue)>parseFloat(standar)){
			
			alert('申请金额不能大于开支标准，请核对！');
			tr[2].target.textbox('setValue','0');
			newValue=0;
		}
		
		var num = 0;
		var rows = $('#appli-detail-dg').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			if(i!=index){
				if(rows[i].applySum!=""&&rows[i].applySum!=null){
					num += parseFloat(rows[i].applySum);
				}
			}
		}
		if(newValue!=""&&newValue!=null) {
			num += parseFloat(newValue);
		}
		$('#num1').textbox('setValue',num.toFixed(2));
		$('#applyAmount').val(num.toFixed(2));
		$('#applyAmount_span').html(fomatMoney(num,2)+" [元]");
	}
}
//未编辑或者已经编辑完毕的行
function addNums(rows,index){
	
	var amount=rows[index]['applySum'];
	if(amount==null){
		amount=0;
		return parseFloat(amount);
	}
	return parseFloat(amount); 
}
//明细表格添加删除，保存方法
var editIndex = undefined;
function endEditing() {
	if (editIndex == undefined) {
		return true
	}
	if ($('#appli-detail-dg').datagrid('validateRow', editIndex)) {
		var ed = $('#appli-detail-dg').datagrid('getEditor', {
			index : editIndex,
			field : 'costDetail'
		});
		$('#appli-detail-dg').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow(index) {
	if (editIndex != index) {
		if (endEditing()) {
			$('#appli-detail-dg').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndex = index;
		} else {
			$('#appli-detail-dg').datagrid('selectRow', editIndex);
		}
	}
}
function append() {
	if (endEditing()) {
		$('#appli-detail-dg').datagrid('appendRow', {});
		editIndex = $('#appli-detail-dg').datagrid('getRows').length - 1;
		$('#appli-detail-dg').datagrid('selectRow', editIndex).datagrid('beginEdit',
				editIndex);
	}

	//页面随滚动条置底
	var div = document.getElementById('easyAcc');
	div.scrollTop = div.scrollHeight;
}
function removeit() {
	if (editIndex == undefined) {
		return
	}
	$('#appli-detail-dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
			editIndex);
	editIndex = undefined;
	
	//修改申请总额
	var num = 0;
	var rows = $('#appli-detail-dg').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		if(rows[i].applySum!=""&&rows[i].applySum!=null){
			num += parseFloat(rows[i].applySum);
		}
	}
	$('#num1').textbox('setValue',num.toFixed(2));
	$('#applyAmount').val(num.toFixed(2));
	$('#applyAmount_span').html(fomatMoney(num,2)+" [元]");
}
function accept() {
	if (endEditing()) {
		$('#dg_meet_plan').datagrid('acceptChanges');
	}
}

//明细只加载一遍(在改变表格内容时如果有url他会优先加载url而不会加载手写的内容，所以只加载一遍会使表格不去请求url中的内容)
var mingxinum=1;
$("#appli-detail-dg").datagrid({
	onBeforeLoad: function () {
		if(mingxinum != 1) {
			return false;
		} else {
			mingxinum = mingxinum + 1;
			return true;
		}
	}
});

//重新计算开支标准的方法（重新计算开支标准，清空申请金额）
function calculateStandard(newValue, oldValue) {
	accept();//先保存明细
	var rows = $('#appli-detail-dg').datagrid('getRows');
	var mingxi = "";
	
	for (var i = 0; i < rows.length; i++) {
		if(i==0) {
			rows[i].applySum=0;//清空申请金额
			rows[i].standard=parseFloat((rows[i].standard/oldValue)*newValue);//重新计算开支标准
			mingxi = mingxi + "["+JSON.stringify(rows[i]);
		} else {
			rows[i].applySum=0;//清空申请金额
			rows[i].standard=parseFloat((rows[i].standard/oldValue)*newValue);//重新计算开支标准
			mingxi = mingxi + "," + JSON.stringify(rows[i]);
		}
	}
	mingxi = mingxi + "]";
	var data = $.parseJSON(mingxi); 
	$('#appli-detail-dg').datagrid('loadData', data);
	$('#num1').textbox('setValue',0);
	$('#applyAmount').val(0);
	$('#applyAmount_span').html(fomatMoney(0,2)+" [元]");
}
setTimeout('hideColumn()',1000);
function hideColumn(){
	var isForeign = $('input[name="isForeign"]:checked').val();	
	if(isForeign=='1'){
		$('#rec-food-dg').datagrid('hideColumn', 'time');
		$('#rec-food-dg').datagrid('showColumn', 'date');
	}else{
		$('#rec-food-dg').datagrid('showColumn', 'time');
		$('#rec-food-dg').datagrid('hideColumn', 'date');
	}
}
//显示详细信息手风琴页面
$(document).ready(function() {
	
	//设置时间
	if($("#applyReqTime").val()==""||$("#applyReqTime").val()==null){
		var date = new Date();
		date=ChangeDateFormat1(date);
		$("#req_time").html(date);
		$("#applyReqTime").val(date);
	} else {
		var date = $("#applyReqTime").val();
		date=ChangeDateFormat1(date);
		$("#req_time").html(date);
	}
	
	//设置支出申请扩展信息
	var h = $("#applyTypeHi").val();
	if (h != "") {
		$('#applyType').val(h);
	}
	//批复金额
	var pfAmount = $("#pfAmount").val();
	if(pfAmount !=""){
		$('#p_pfAmount').html(fomatMoney(pfAmount,2)+" [元]");
	}
	/* //可用金额
	var syAmount = $("#syAmount").val();
	if(syAmount !=""){
		$('#p_syAmount').html(fomatMoney(syAmount,2)+" [元]");
	} */
	var applyAmount = $("#applyAmount").val();
	if(applyAmount !=""){
		$('#applyAmount_span').html(fomatMoney(applyAmount,2)+" [元]");
	}
	
	var costFood = $("#costFood").val();
	if(costFood !=""){
		$('#costFood_span').html(fomatMoney(costFood,2)+" [元]");
	}
	var costHotel = $("#costHotel").val();
	if(costHotel !=""){
		$('#costHotel_span').html(fomatMoney(costHotel,2)+" [元]");
	}
	var costOther = $("#costOther").val();
	if(costOther !=""){
		$('#costOther_span').html(fomatMoney(costOther,2)+" [元]");
	}
	var plan1 = $("#diningPlacePlan1").val();
	var plan2 = $("#diningPlacePlan2").val();
	if(plan1=='1'){
		
    	$('#tr1').show();
	}else{
		$('#tr1').hide();
	}
	if(plan2=='1'){
    	$('#tr0').show();
	}else{
		$('#tr0').hide();
	}
	
	
});

</script>
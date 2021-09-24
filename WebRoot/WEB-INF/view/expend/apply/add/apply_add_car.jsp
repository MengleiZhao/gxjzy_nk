<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>


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

//显示详细信息手风琴页面
$(document).ready(function() {
	/* //设值时间
	if ($("#applyReqTime").textbox().textbox('getValue') == "") {
		$("#applyReqTime").textbox().textbox('setValue', 'date');
	} */
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
	var h = $("#applyTypeHi").textbox().textbox('getValue');
	if (h != "") {
		$('#applyType').val(h);
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
	//批复时间
	var applyAmount = $("#applyAmount").val();
	if(applyAmount !=""){
		$('#applyAmount_span').html(fomatMoney(applyAmount,2)+" [元]");
	}
	
	
});


//保存
function saveApply(flowStauts) {
	if($('#applyAmount_span').html()=='&nbsp;'||parseInt($('#applyAmount_span').html())<=0){
		alert('请注意填写费用明细金额！');
		return ;
	}
	// 在后台反序列化成明细Json的对象集合
	var type = '${type}';
	var rows;
	
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);
	//在后台反序列话成被接待人员Json的对象集合
	var h = $("#applyTypeHi").textbox().textbox('getValue');
		acceptR();
		var rows2 = $('#cart').datagrid('getRows');
		var officeCar = "";
		for (var i = 0; i < rows2.length; i++) {
			officeCar = officeCar + JSON.stringify(rows2[i]) + ",";
		}
		officeCar = '[' + officeCar.substring(0, officeCar.length - 1) + ']';
		$('#officeCarJson').val(officeCar);

	//设置审批状态
	$('#applyflowStauts').val(flowStauts);
	//设置申请状态
	$('#applyStauts').val(flowStauts);

	if($('#applyAmount').val()==""||$('#applyAmount').val()=="0.00") {
		alert('请填写费用明细申请金额');
		return;
	}
	
	//校验
	//预算指标
	var budgetIndexName = $('#F_fBudgetIndexName').val();
	if(budgetIndexName == ''){
		alert('请选择支出项目！');
		
		return;
	}
	//申请金额
	var applyAmount = $('#applyAmount').val();
	if(applyAmount == '' || applyAmount == '0.00') {
		alert('请填写费用明细申请金额！');
		return;
	}
	var syAmount = $('#syAmount').val();
	if(parseFloat(syAmount)<parseFloat(applyAmount)){
		alert('预算可用金额不足,请重新选择支出项目！');
		return;
	}
	//提交
	$('#apply_save_form').form('submit', {
		onSubmit : function(param) {
			param.officeCar=officeCar;	
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
		url : base + '/apply/saveOfficeCar',
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
function openIndex1() {
	//var win=creatFirstWin('选择指标',860,580,'icon-search','/quota/choiceIndex');
	var win=creatFirstWin('选择指标',1060,580,'icon-search','/apply/choiceIndex?menuType=beforeApply'); 
	win.window('open');
}





function chooseArea(){
	var win = creatFirstWin('选择-出差地区', 640, 580, 'icon-search', '/hotelStandard/choose');
	win.window('open');
}


//自动获得费用明细
function calcTravelCost(){
	var configId = $('#travel_add_placeEnd_id').textbox('getValue');
	var travelDays = $('#travelTotalDays').val();
	var hotelDays = $('#hotelTotalDays').val();
	if(configId=='' || travelDays=='' ||isNaN(travelDays)|| hotelDays==''||isNaN(hotelDays)){
		return;
	}
		$.ajax({
			url :base+'/hotelStandard/calcCost?outType=travel',
			data : {
				configId: configId,
				travelDays: travelDays,
				hotelDays: hotelDays
			},
			type : 'post',
			dataType : 'json',
			success : function(data){
				  for (var i=0;i<data.length;i++){
                  var name = data[i].costDetail;
                  if(name=="住宿费"){
                	  $('#p_hotelStd').html(data[i].standard+"元");
                	  $('#hotelAmount').val(data[i].standard);
                  }
                  if(name=="伙食补助费"){
                	  $('#p_foodStd').html(data[i].standard+"元");
                	  $('#foodAmount').val(data[i].standard);
                  }
				  }
					var hotelAmount=parseFloat($('#hotelAmount').val());
					var foodAmount=parseFloat($('#foodAmount').val());
					var loongTavelAmount = parseFloat($('#loongTavelAmount').numberbox('getValue'));
					var cityTavelAmount =parseFloat($('#cityTavelAmount').numberbox('getValue'));
					var otherAmount =parseFloat($('#otherAmount').numberbox('getValue'));
					var totalPrice=parseFloat(hotelAmount+foodAmount);
					if(!isNaN(loongTavelAmount)){
						totalPrice=totalPrice+loongTavelAmount;
					}
					if(!isNaN(cityTavelAmount)){
						totalPrice=totalPrice+cityTavelAmount;
					}
					if(!isNaN(otherAmount)){
						totalPrice=totalPrice+otherAmount;
					}
					//给两个总额框赋值
					$('#applyAmount').val(totalPrice.toFixed(2));
					$('#applyAmount_span').html(fomatMoney(totalPrice,2)+" [元]");
				}
			});
		
}

function changeHotel(n,o){
	if(n==undefined || o==undefined){
		return false;
	}
	var days1 = 0;
	var days2 = 0;
	var days3 = parseInt(n);
	var index=$('#rpt').datagrid('getRowIndex',$('#rpt').datagrid('getSelected'));
	var rows = $('#rpt').datagrid('getRows');
	var row = $('#rpt').datagrid('getSelected');//获得选择行
	var tr = $('#rpt').datagrid('getEditors', index);
	var daysOld = parseInt(row.hotelDays);//判断之前是否有数据
	var traveldays = tr[8].target.numberbox('getValue');;
	for(var i=0;i<rows.length;i++){
		if(i==index){
			days1=parseInt(n);
		}else{
			days2+=addDays(rows,i);
		}
	}
		//3-两类数值相加得到总额
		if(!isNaN(days3)){	
			if(parseInt(n) > traveldays){
			alert('住宿天数不能大于出差天数，请核对！');
			tr[9].target.numberbox('setValue','0');
			n=0;
		} else{
				//原先有数据且未改动的，不能进入总额合计
				if(!isNaN(daysOld) && isNaN(parseInt(o))){
					return;
				} else {
						days2 = days2 + days3;
					}
			}
		}
		$('#hotelTotalDays').val(days2);
		calcTravelCost();
		return;
}

//未编辑或者已经编辑完毕的行
function addDays(rows,index){
	var hoteldays=rows[index]['hotelDays'];
	if(hoteldays==null){
		hoteldays=0;
		return parseInt(hoteldays);
	}
	return parseInt(hoteldays); 
}

function changeTravel(n,o){
	if(n==undefined || o==undefined){
		return false;
	}
	var days4 = 0;
	var days5 = 0;
	var days6 = parseInt(n);
	var index=$('#rpt').datagrid('getRowIndex',$('#rpt').datagrid('getSelected'));
	var rows = $('#rpt').datagrid('getRows');
	var row = $('#rpt').datagrid('getSelected');//获得选择行
	var daysOld = parseInt(row.travelDays);//判断之前是否有数据
	for(var i=0;i<rows.length;i++){
		if(i==index){
			days4=parseInt(n);
		}else{
			days5+=addDays1(rows,i);
		}
	}
		//3-两类数值相加得到总额
				//原先有数据且未改动的，不能进入总额合计
				if(!isNaN(daysOld) && isNaN(parseInt(o))){
					return;
				} else {
						days5 = days5 + days6;
					}
		$('#travelTotalDays').val(days5);
		calcTravelCost();
		return;
}

//未编辑或者已经编辑完毕的行
function addDays1(rows,index){
	var traveldays=rows[index]['travelDays'];
	if(traveldays==null){
		traveldays=0;
		return parseInt(traveldays);
	}
	return parseInt(traveldays); 
}

//计算总金额
function addAmount(newValue,oldValue){
	if(newValue==undefined || oldValue==undefined){
		return false;
	}
	// var rows = $('#prolist_add_table').datagrid('getRows');
	var rows = $('#cart').datagrid('getRows');
     var num1 = 0;
     for (var i = 0; i < rows.length; i++) {
    	 if (!isNaN(parseFloat(rows[i]['fUseAmount']))) {
	    	 num1 += parseFloat(rows[i]['fUseAmount']);
    	 }
	}
     //
     var num = parseFloat(newValue);
     var row = $('#cart').datagrid('getSelected');
     var numOld = parseFloat(row.fUseAmount);
     if(!isNaN(num)){
    	 if(!isNaN(numOld) && isNaN(parseFloat(oldValue))){
				return;
		} else {
			if (!isNaN(numOld)) {
				num1 = num1 + num - numOld;
			}else{
				num1 = num1 + num;
			}
		 }
	 } 
     /* if(num1==num2&&controlAmount>0){
    	$('#songshen').show();
     }else{
    	 $('#songshen').hide(); 
     } */
	/* if(num1>num2){
		alert('拨款金额不能大于预算金额，请核对！');
	} */
   //给两个总额框赋值
		$('#applyAmount').val(num1.toFixed(2));
		$('#applyAmount_span').html(fomatMoney(num1,2)+" [元]");
}

</script>

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
				<!-- 申请总额  --><input type="hidden" id="applyAmount" name="amount" value="${bean.amount}"/>
				<!-- 可用金额  --><input type="hidden" id="syAmount" value="${bean.syAmount}"/>
				<!-- 批复金额  --><input type="hidden" id="pfAmount" value="${bean.pfAmount}"/>
				<!-- 批复时间  --><input type="hidden" id="pfDate"  value="${bean.pfDate}"/>
				<!-- 流程id  --><input type="hidden" id="flowId"  value="${fpId}"/>
				<!--历史审批节点  --><input type="hidden" id="historyNodes"  value="${historyNodes}"/>
				<!-- 下一级审批节点  --><input type="hidden" id="nextKey"  value="${bean.nCode}"/>
				<!-- 基本信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="基本信息" data-options="collapsible:false" style="overflow:auto; ">
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 摘要</td>
							<td colspan="3">
								<c:if test="${operation=='add' }">
									<input class="easyui-textbox" style="width: 639px;height: 30px;margin-left: 10px " value="${draftAdd}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
								</c:if>
								<c:if test="${operation!='add' }">
									<input class="easyui-textbox" style="width: 639px;height: 30px;margin-left: 10px " value="${bean.gName}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
								</c:if>
							</td>
						</tr>
						<tr class="trbody" style="line-height: 0px;">
							<td class="td1" style="width: 70px;"><span class="style1">*</span>申请事由</td>
							<td colspan="3">
								<textarea name="reason" id="reason" class="textbox-text"
										oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
										style=" width:635px;height:60px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:2px; margin-bottom:0px;">${bean.reason }</textarea>
							</td>
						</tr>
						<tr class="trbody"  style="line-height: 35px;">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 经办人</td>
							<td class="td2" >
							<input class="easyui-textbox" id="userNames" name="userNames" readonly="readonly" value="${bean.userNames}" style="width: 265px;height: 30px;margin-left: 10px; margin-top:10px; " >
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 部门名称</td>
							<td class="td2" >
							<input class="easyui-textbox" id="deptName" name="deptName" readonly="readonly" value="${bean.deptName}" style="width: 267px;height: 30px;margin-left: 10px; margin-top:10px; " >
							</td>
						</tr>
					</table>
				</div>				
				</div>
				
				<!-- 费用明细 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
					<div title="费用明细" data-options="collapsed:false,collapsible:false" style="overflow:auto; ">
						<div style="overflow:auto;margin-top: 0px;">
							<jsp:include page="mingxi_car.jsp" />
							<div style="overflow:auto;margin-top: 0px;margin-right: 52px;">
								<span style="float: right;"> <span style="color: red;">申请总额：
								</span> <span style="float: right;" id="applyAmount_span">&nbsp;</span>
								</span>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 预算信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 50px">
				<div title="预算信息" data-options="collapsible:false" style="overflow:auto;margin-left: 0px;">				
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:707px;">
						<tr class="trbody">
							<td style="width: 60px;"><span style="text-align: left;color: red">*</span> 支出项目:</td>
							<td colspan="3" style="float: right;">
								<a onclick="openIndex1()" href="#">
								<input class="easyui-textbox" style="width: 642px;height: 30px;"
								name="indexName" value="${bean.indexName}" id="F_fBudgetIndexName"
								data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
								</a>
							</td>
						</tr>
					</table>	
					<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="margin-left: 0px;width:707px;height: 50px;">
							<tr>
								<td class="window-table-td1"><p>批复金额：</p></td>
								<td class="window-table-td2"><p id="p_pfAmount">${bean.pfAmount}万元</p></td>
								
								<td class="window-table-td1"><p>预算年度：</p></td>
								<td class="window-table-td2"><p id="p_pfDate">${bean.pfDate}</p></td>
							</tr>
							
							<tr>
								<td class="window-table-td1"><p>可用额度：</p></td>
								<td class="window-table-td2"><p id="p_syAmount">${bean.syAmount}</p></td>
								
								<%-- <td class="window-table-td1"><p>累计支出:</p></td>
								<td class="window-table-td2"><p id="p_syAmount">${bean.syAmount}万元</p></td> --%>
							</tr>
					</table>				
				</div>
				</div>
				
				<!-- 附件信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="附件信息" data-options="collapsible:false" style="overflow:auto;">		
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
						<tr>
							<td class="td1" style="width:75px;text-align: left"><span class="style1">*</span>
								附件
								<input type="file" multiple="multiple" id="f" onchange="upladFile(this,null,'zcgl01')" hidden="hidden">
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
									<div style="margin-top: 5px;">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<img style="margin-top: 5px;" src="${base}/resource-modality/${themenurl}/sccg.png">
									&nbsp;&nbsp;&nbsp;&nbsp;
									<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
									</div>
								</c:forEach>
							</td>
						</tr>
						
						
					</table>
					
				</div>
				</div>
			</div>
			
			<div class="window-left-bottom-div" style="margin-top: 35px;">
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
				<a href="javascript:void(0)" onclick="showFlowDesinger()">
				<img src="${base}/resource-modality/${themenurl}/button/CCLCT1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
			
		</div>
		<c:if test="${type!=1 }">
			<div class="window-right-div" style="width:254px;height: auto;padding-bottom: 20px;">
				<jsp:include page="../../../check_system.jsp" />
			</div>
		</c:if>
	</div>
</form>

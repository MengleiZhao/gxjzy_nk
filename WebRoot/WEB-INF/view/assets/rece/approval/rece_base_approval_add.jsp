<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="ReceLowAddEditForm" action="" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="fId_R" id="R_fId_R" value="${bean.fId_R}"/>
				<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
			    <input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
			    <!-- 审批附件 --><input type="hidden" name="spjlFile" id="spjlFile" value=""/>	
					<div class="easyui-accordion" style="width:662px;margin-left: 20px;">
							<div title="领用单详情" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
								<table class="ourtable" cellpadding="0" cellspacing="0">
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>资产领用单号</td>
										<td  colspan="4">
											<input id="F_fAssReceCode" class="easyui-textbox" type="text" readonly="readonly" name="fAssReceCode" data-options="prompt:'系统自动生成',validType:'length[1,20]'" value="${bean.fAssReceCode}" style="width: 555px;color: #f7f7f7;"/> 
										</td>								
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>领用人部门</td>
										<td class="td2">
											<input id="R_fReceDept"  class="easyui-textbox" readonly="readonly"  name="fReceDept" data-options="prompt:' ',validType:'length[1,20]'" style="width: 200px" value="${bean.fReceDept}"/>					
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1">&nbsp;&nbsp;领用人</td>
										<td class="td2">
											<input id="R_fReceUser"  class="easyui-textbox"  name="fReceUser" readonly="readonly" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fReceUser}"/>
										</td>
										
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>申请时间</td>
										<td class="td2">
											<input class="easyui-datebox" class="dfinput"  id="R_fReqTime" readonly="readonly" name="fReqTime"  data-options="" style="width: 200px" value="${bean.fReqTime}"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>总金额(元)</td>
										<td class="td2">
											<input class="easyui-numberbox" class="dfinput"  id="R_fSumAmount" readonly="readonly" name="fSumAmount"  data-options="icons: [{iconCls:'icon-yuan'}],validType:'length[1,20]',precision:2" style="width: 200px" value="${bean.fSumAmount}"/>
										</td>
										
									</tr>
									<tr style="height: 70px;">
										<td class="td1" valign="top"><p style="margin-top: 8px">&nbsp;&nbsp;领用原因</p></td>
										<td  colspan="4">
											<input class="easyui-textbox" data-options="multiline:true,validType:'length[0,200]'" id="R_fReceRemark" readonly="readonly" name="fReceRemark" style="width: 555px;height:70px" value="${bean.fReceRemark}">  
											<!-- <input type="text" id="S_fFlowStauts" name="fFlowStauts" hidden="hidden" value="0"/> -->
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1">
											&nbsp;&nbsp;附件
											<input type="file" multiple="multiple" id="fly" onchange="upladFile(this,'lyflies','zcagl01')" hidden="hidden">
											<input type="text" id="files" name="receFlies" hidden="hidden">
										</td>
										<td colspan="4" id="tdf">
											<c:if test="${openType=='add'||openType=='edit'}">
											<a onclick="$('#fly').click()" style="font-weight: bold;" href="#">
												<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
											</a>
											</c:if>
											<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
												<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
										 		</div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
											 </div>
											<c:forEach items="${ReceFilesList}" var="att">
												<c:if test="${att.serviceType=='lyflies' }">
													<div style="margin-top: 10px;">
													<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
													&nbsp;&nbsp;&nbsp;&nbsp;
													<c:if test="${openType=='add'||openType=='edit'}">
													<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
													&nbsp;&nbsp;&nbsp;&nbsp;
														<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
													</c:if>
													</div>
												</c:if>
											</c:forEach>
										</td>
									</tr>
								</table>	
							</div>
							<div title="领用资产清单" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
					        	<%@ include file="rece_base_approval_plan.jsp" %>
							</div>
							<c:if test="${checkinfo==1}">
							<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
								<jsp:include page="../../../check_history.jsp" />												
							</div>
							</c:if>
						</div>			
			</div>
			
			<div class="win-left-bottom-div">
				<c:if test="${openType=='add'||openType=='edit'||openType=='app'}">
					<a href="javascript:void(0)" onclick="openCheckWin('审批意见','1')">
						<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="openCheckWin('审批意见','0')">
						<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
				</c:if>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=资产管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<div class="win-right-div" data-options="region:'east',split:true">
			 <jsp:include page="../../../check_system.jsp" /> 
		</div>
	</div>
</form>
</div>
<script type="text/javascript">
//时间格式化
function ChangeDateFormat2(val) {
	//alert(val)
    var t, y, m, d, h, i, s;
    if(val==null){
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
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) + ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i);
}

function check(stauts){
	var fid=$('#R_fId_R').val;
	$('#ReceLowAddEditForm').form('submit', {
			onSubmit: function(){ 
				flag=$(this).form('enableValidation').form('validate');
				if(flag){
					$.messager.progress();
				}
				return flag;
			}, 
			url:'${base}/Rece/approvel/'+stauts,
			data:{'fFlowStauts_R':stauts,'fId_R':fid},
			success:function(data){
				if(flag){
					$.messager.progress('close');
				}
				data=eval("("+data+")");
				if(data.success){
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					$('#ReceLowAddEditForm').form('clear');
					$("#rece_base_approval_dg").datagrid('reload'); 
					$("#indexdb").datagrid('reload'); 
				}else{
					$.messager.alert('系统提示', data.info, 'error');
				}
			} 
		});	
}
   $('#F_fcType').combobox({  
       onChange:function(newValue,oldValue){  
   	var sel2=$('#F_fcType').combobox('getValue');
   	if(sel2!="1"){
   		$('#cg1').hide();
   		//$('#cg2').hide();
   		//$('#F_fPurchNo').next(".textbox").show();
	}else{
   		$('#cg1').show();
   		//$('#cg2').show();
   		//$('#F_fPurchNo').next(".textbox").hide();
	} 
       }
   }); 
	function fReceCode(){
		var win=creatFirstWin('原配置单号',970,580,'icon-search','/Rece/receCodeList');
		win.window('open');
	}
	function fProCode_DC(){
		var win=creatFirstWin(' ',970,580,'icon-search','/Formulation/fProCode');
		win.window('open');
	}
	function quota_DC(){
		//var node=$('#rece_low_dg').datagrid('getSelected');
		var win=creatFirstWin('选择-预算指标编号',970,580,'icon-add','/BudgetIndexMgr/contract_list');
		win.window('open');
	}
	var names = new Array();
	function streetChange(streetCode){
		$('#userStreetJwh').combobox('reload',"${base}/street/jwh?streetCode="+streetCode);
	}
	function departSelect(selectType){
		var win=creatSearchDataWin('选择-部门',590,400,'icon-add',"/depart/refUserDepart/"+selectType);
	    win.window('open');
	} 
	function deleteCF(){
		var row = $('#CS_dg').datagrid('getSelected');
		var selections = $('#rece_low_dg').datagrid('getSelections');
			if(confirm("确认删除吗？")){
				$.ajax({ 
					type: 'POST', 
					url: '${base}/Formulation/delete/'+row.fcId,
					dataType: 'json',  
					success: function(data){ 
						if(data.success){
							$.messager.alert('系统提示',data.info,'info');
							$("#rece_low_dg").datagrid('reload');
						}else{
							$.messager.alert('系统提示',data.info,'error');
						}
					} 
				}); 
			}
	}
</script>
</body>
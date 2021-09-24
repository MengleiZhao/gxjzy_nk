<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="maintainAddEditForm" action="${base}/Maintain/save" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="fID" id="m_fID" value="${bean.fID}"/>
		    	<input type="hidden" name="fFlowStauts" id="m_fFlowStauts" value="${bean.fFlowStauts}"/>
		    	<input type="hidden" name="fMainStauts" id="m_fMainStauts" value="${bean.fMainStauts}"/>
	    		<input type="hidden"  name="bId" id="F_fBudgetIndexCode" value="${bean.bId}"/>
		    	<input type="hidden"  class="easyui-datebox" name="fMainTime" id="m_fMainTime" value="${bean.fMainTime}"/>
		    	<input type="hidden" name="fMainUserID" id="m_fMainUserID" value="${bean.fMainUserID}"/>
		    	<input type="hidden" name="fMainDeptID" id="m_fMainDeptID" value="${bean.fMainDeptID}"/>
		    	<input type="hidden" name="fBIndexCode" id="m_fBIndexCode" value="${bean.fBIndexCode}"/>
		    	<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
			    <input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
			  	<!-- 审批附件 --><input type="hidden" name="spjlFile" id="spjlFile" value=""/>
	    		<c:if test="${bean.fID !=null}">
			    	<input type="hidden" name="fNextUserName" id="A_fNextUserName" value="${bean.fNextUserName}"/>
			    	<input type="hidden" name="fNextUserCode" id="A_fNextUserCode" value="${bean.fNextUserCode}"/>
			    	<input type="hidden" name="fNextCode" id="A_fNextCode" value="${bean.fNextCode}"/>
	    		</c:if>
					<div class="easyui-accordion" style="width:662px;margin-left: 15px;">
							<div title="维修单详情" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
								<table class="ourtable" cellpadding="0" cellspacing="0">
								<tr class="trbody">
										<td class="td1"><span class="style1">*</span>维修调拨单号</td>
										<td  colspan="4">
											<input id="m_tAssetMainCode"  class="easyui-textbox" type="text" readonly="readonly" name="tAssetMainCode" data-options="prompt:'系统自动生成',validType:'length[1,20]'" value="${bean.tAssetMainCode}" style="width: 555px;color: #f7f7f7;"/> 
										</td>								
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>资产名称</td>
										<td class="td2">
											<input class="easyui-textbox" readonly="readonly" class="dfinput" id="m_fAssName" name="fAssName"  data-options="prompt:'请选择需要调拨的资产',validType:'length[1,20]'" style="width: 200px" value="${bean.fAssName }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>资产编号</td>
										<td class="td2">
											<input class="easyui-textbox" readonly="readonly" class="dfinput"  id="m_fAssCode" name="fAssCode"  data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fAssCode}"/>
										</td>
									</tr> 
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>规格型号</td>
										<td class="td2">
											<input class="easyui-textbox" readonly="readonly" class="dfinput" id="m_fAssModel" name="fAssModel"  data-options="prompt:'',validType:'length[1,20]'" style="width: 200px" value="${bean.fAssModel }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>购置日期</td>
										<td class="td2">
											<input class="easyui-datebox" readonly="readonly" class="dfinput" id="m_fAcquisitionDate" name="fAcquisitionDate"  data-options="prompt:'',validType:'length[1,20]'" style="width: 200px" value="${bean.fAcquisitionDate }"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>是否产生费用</td>
										<td class="td2">
											<input class="easyui-combobox" readonly="readonly" class="dfinput" id="m_fMainWhether" name="mainWhether"  data-options="editable:false,panelHeight:'auto',url:'${base}/Maintain/lookupsJson?parentCode=sfcswxfy&selected=${bean.fMainWhether.code}',method:'POST',valueField:'code',textField:'text',editable:false,validType:'selectValid'" value="${bean.fMainWhether.code}" style="width: 200px"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>报修时间</td>
										<td class="td2">
											<input class="easyui-datebox" readonly="readonly" class="dfinput" id="m_fRepairTime" name="fRepairTime"  data-options="prompt:'',validType:'length[1,20]'" style="width: 200px" value="${bean.fRepairTime }"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>申请部门</td>
										<td class="td2">
											<input class="easyui-textbox" readonly="readonly" class="dfinput" readonly="readonly" id="m_fMainDept" name="fMainDept"  data-options="prompt:'',validType:'length[1,25]'" style="width: 200px" value="${bean.fMainDept }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>申请人</td>
										<td class="td2">
											<input class="easyui-textbox" class="dfinput" readonly="readonly" id="m_fMainUser" name="fMainUser"  data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fMainUser}"/>
										</td>
									</tr>
									<c:if test="${bean.fMainWhether.code=='sfcswxfy-01'}"><tr class="trbody" id="choose1"></c:if> 
									<c:if test="${bean.fMainWhether.code!='sfcswxfy-01'}"><tr class="trbody"hidden="hidden"id="choose1"></c:if>
										<td class="td1"><span class="style1">*</span>维修费用</td>
										<td class="td2">
											<input class="easyui-numberbox"  class="dfinput" readonly="readonly" id="m_fMainAmountr" name="fMainAmount"  data-options="validType:'length[1,20]',precision:2" style="width: 200px" value="${bean.fMainAmount}"/>
										</td>
										<td class="td4">&nbsp;</td>
										<%-- <td class="td1"><span class="style1">*</span>预算指标名称</td>
										<td class="td2">
											<input class="easyui-textbox"  class="dfinput"  id="F_fBudgetIndexName" name="fBIndexName"  data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fBIndexName}"/>
										</td> --%>
									</tr>
									<tr style="height: 70px;">
										<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>故障情况</p></td>
										<td  colspan="4">
											<input class="easyui-textbox" readonly="readonly" data-options="validType:'length[1,200]',multiline:true" id="m_fFaultRemark" name="fFaultRemark" style="width: 555px;height:70px" value="${bean.fFaultRemark}">  
										</td>
									</tr>	
									<tr class="trbody">
										<td class="td1">
											&nbsp;&nbsp;附件
											<input type="file" multiple="multiple" id="fmaintaindj" onchange="upladFile(this,'maintaindj','gdzcwx')" hidden="hidden">
											<input type="text" id="files" name="maintainFiles" hidden="hidden">
										</td>
										<td colspan="4" id="tdf">
											<c:if test="${openType=='add'||openType=='edit'}">
											<a onclick="$('#fmaintaindj').click()" style="font-weight: bold;" href="#">
												<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
											</a>
											</c:if>
											<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
												<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
										 		</div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
											 </div>
											<c:forEach items="${maintianAttaList}" var="att">
												<c:if test="${att.serviceType=='maintaindj' }">
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
							<c:if test="${checkinfo==1}">
								<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
									<jsp:include page="../../../check_history.jsp" />												
								</div>
							</c:if>
						</div>			
			
		
			</div>
			
			<div class="win-left-bottom-div">
				<c:if test="${openType=='add'||openType=='app'}">
					<a href="javascript:void(0)" onclick="openCheckWin('审批意见','1')">
						<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="openCheckWin('审批意见','0')">
						<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
				</c:if>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
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
	function fresult(val, row) {
		if (val == 1) {
			return '<span style="color:green;">' + " 通过" + '</span>';
		} else if (val == 0) {
			return '<span style="color:red;">' + " 未通过" + '</span>';
		}
	}
    $('#m_fMainWhether').combobox({  
        onChange:function(newValue,oldValue){  
	    	var sel2=$('#m_fMainWhether').combobox('getValue');
	    	if(sel2!="sfcswxfy-01"){
	    		$('#choose1').hide();
	    		$('#m_fMainAmountr').numberbox('setValue',0);
	    		$('#F_fBudgetIndexName').attr("required",false);
			}else{
	    		$('#F_fBudgetIndexName').attr("required",true);
	    		$('#choose1').show();
			} 
       }
    }); 
    var c=0;
	function check(stauts){
		/* if(stauts==1){
			stauts='tg';
		}else if(stauts==0){
			stauts='btg';
		} */
		var id=$('#m_fID').val();
		var r=$('#R_fRemark').val();
		$('#maintainAddEditForm').form('submit', {
				onSubmit: function(){ 
					flag=$(this).form('enableValidation').form('validate');
					if(flag){
						$.messager.progress();
					}
					return flag;
				}, 
				url:'${base}/Maintain/approve/'+stauts+'?id='+id,
				success:function(data){
					if(flag){
						$.messager.progress('close');
					}
					data=eval("("+data+")");
					if(data.success){
						$.messager.alert('系统提示', data.info, 'info');
						closeWindow();
						$('#maintainAddEditForm').form('clear');
						$("#miantain_fixed_approval_dg").datagrid('reload'); 
						$("#indexdb").datagrid('reload'); 
					}else{
						$.messager.alert('系统提示', data.info, 'error');
					}
				} 
			});	
	}
		
		function chooseFBIndex(){
			var win=creatFirstWin('原配置单号',860,580,'icon-search','/Maintain/BudgetIndexCode');
			win.window('open');
		}
		function BudgetIndexCode(){
			var win=creatFirstWin(' ',860,580,'icon-search','/Formulation/BudgetIndexCode');
			win.window('open');
		}
		var c1 =0;
		function deleteCF(){
			var row = $('#CS_dg').datagrid('getSelected');
			var selections = $('#miantain_fixed_dg').datagrid('getSelections');
				if(confirm("确认删除吗？")){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/Formulation/delete/'+row.fcId,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#miantain_fixed_dg").datagrid('reload');
							}else{
								$.messager.alert('系统提示',data.info,'error');
							}
						} 
					}); 
				}
		}
	</script>
</body>
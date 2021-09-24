<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<div class="win-div">
<form id="registrationAddForm" action="${base}/Maintain/saveRegistration" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="mainID" id="reg_mainID" value="${bean.maintain.fID}"/>
				<input type="hidden" name="fRegID" id="reg_fRegID" value="${bean.fRegID}"/>
				<div class="easyui-accordion" style="width:662px;margin-left: 15px;">
					<div title="维修登记单" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
						<table class="ourtable" cellpadding="0" cellspacing="0">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>维修登记单号</td>
								<td  colspan="4">
									<input id="reg_tMianRegCode" required="required" class="easyui-textbox" type="text" readonly="readonly" name="tMianRegCode" data-options="prompt:'系统自动生成',validType:'length[1,30]'" value="${bean.tMianRegCode}" style="width: 555px;color: #f7f7f7;"/> 
								</td>								
							</tr>
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>维修单</td>
								<td colspan="4">
									<c:if test="${openType=='add'||openType=='edit'}"><a onclick="chooseMain()"></c:if><input class="easyui-textbox" required="required" class="dfinput" id="reg_mainCode" name="tAssetMainCode"  data-options="prompt:'单击选择维修单',validType:'length[1,30]'" style="width: 555px" value="${bean.maintain.tAssetMainCode }"/><c:if test="${openType=='add'||openType=='edit'}"></a></c:if>
								</td>
							</tr> 
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>是否产生费用</td>
								<td class="td2">
									<input class="easyui-combobox" required="required" class="dfinput" id="reg_fMainWhether" name="mainWhether"  data-options="editable:false,panelHeight:'auto',url:'${base}/Maintain/lookupsJson?parentCode=sfcswxfy&selected=${bean.fMainWhether.code}',method:'POST',valueField:'code',textField:'text',editable:false,validType:'selectValid'" value="${bean.fMainWhether.code}" style="width: 200px"/>
								</td>
								<td class="td4">&nbsp;</td>
								<td class="td1" id="reg1" hidden="hidden"><span class="style1">*</span>维修费用</td>
								<td class="td2" id="reg2" hidden="hidden">
									<input class="easyui-numberbox" required="required" class="dfinput" id="reg_fRegAmount" name="fRegAmount"  data-options="icons: [{iconCls:'icon-yuan'}],prompt:'',validType:'length[1,20]',precision:2" style="width: 200px" value="${bean.fRegAmount }"/>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>操作人</td>
								<td class="td2">
									<input class="easyui-textbox" readonly="readonly" class="dfinput" id="reg_fMainRegUser" name="fMainRegUser"  data-options="prompt:'',validType:'length[1,20]'" style="width: 200px" value="${bean.fMainRegUser }"/>
								</td>
								<td class="td4">&nbsp;</td>
								<td class="td1"><span class="style1">*</span>操作部门</td>
								<td class="td2">
									<input class="easyui-textbox" readonly="readonly" class="dfinput"  id="reg_fMainRegDept" name="fMainRegDept"  data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fMainRegDept}"/>
								</td>
							</tr> 
							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>故障情况</p></td>
								<td  colspan="4">
									<%-- <input class="easyui-textbox" data-options="validType:'length[1,200]',multiline:true" id="reg_fMainResult"
									 name="fMainResult" style="width: 555px;height:70px" value="${bean.fMainResult}"> --%>  
									
									
									<textarea name="fMainResult"  id="reg_fMainResult"  class="textbox-text" oninput="textareaNum(this,'textareaNum1')"
											autocomplete="off"  style="width: 555px;height:70px;resize:none">${bean.fMainResult }</textarea>
								</td>
							</tr>	
							<c:if test="${openType=='add'||openType=='edit'}">
								<tr>
									<td align="right" colspan="5" style="padding-right: 0px;">
									可输入剩余数：<span id="textareaNum1" class="200">
										<c:if test="${empty bean.fMainResult}">200</c:if>
										<c:if test="${!empty bean.fMainResult}">${200-bean.fMainResult.length()}</c:if>
									</span>
									</td>
								</tr>
							</c:if>	
						</table>
					</div>
				</div>			
			</div>
			
			<div class="win-left-bottom-div">
				<c:if test="${openType=='add'||openType=='edit'}">
					<a href="javascript:void(0)" onclick="registrationAddForm();">
						<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
				</c:if>
				<c:if test="${detailType=='detail'}">
					<a href="javascript:void(0)" onclick="closeWindow()">
						<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</c:if>
				<c:if test="${detailType=='ledger'}">
					<a href="javascript:void(0)" onclick="closeFirstWindow()">
						<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</c:if>
				&nbsp;&nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=资产管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<%-- <div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../../check_system.jsp" />
		</div> --%>
	</div>
</form>
</div>
	<script type="text/javascript">
	 $('#reg_fMainWhether').combobox({  
	        onChange:function(newValue,oldValue){  
	    	var sel2=$('#reg_fMainWhether').combobox('getValue');
	    	if(sel2=="sfcswxfy-01"){
	    		$('#reg1').show();
	    		$('#reg2').show();
			}else{
	    		$('#reg1').hide();
	    		$('#reg2').hide();
			} 
	        }
	    }); 
    var c=0;
		function registrationAddForm(){
			$('#registrationAddForm').form('submit', {
				onSubmit: function(){ 
   					flag=$(this).form('enableValidation').form('validate');
   					if(flag){
   						$.messager.progress();
   					}
   					return flag;
   				}, 
   				success:function(data){
   					if(flag){
   						$.messager.progress('close');
   					}
   					data=eval('('+data+')');
   					if(data.success){
   						$.messager.alert('系统提示', data.info, 'info');
   						closeWindow();
   						$('#registrationAddForm').form('clear');
   						$('#miantain_fixed_reg_dg').datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   					}
   				} 
   			});		
		}
		
		function chooseMain(){
			var win=creatFirstWin('选择维修单',860,590,'icon-search','/Maintain/chooseMain');
			win.window('open');
		}
		var c1 =0;
	</script>
</body>
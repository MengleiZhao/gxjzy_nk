<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="AllocaAddEditForm" action="${base}/Alloca/save" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="fId_A" id="A_fId_A" value="${bean.fId_A}"/>
		    	<input type="hidden" name="fFlowStauts" id="A_fFlowStauts" value="${bean.fFlowStauts}"/>
		    	<input type="hidden" name="fAllocaStauts" id="A_fAllocaStauts" value="${bean.fAllocaStauts}"/>
		    	<input type="hidden" name="fReqTime" id="A_fReqTime" value="${bean.fReqTime}"/>
		    	<input type="hidden" name="fRecDeptId" id="A_fRecDeptId" value="${bean.fRecDeptId}"/>
		    	<input type="hidden" name="fRecUserId" id="A_fRecUserId" value="${bean.fRecUserId}"/>
		    	<input type="hidden" name="fOutDeptId" id="A_fOutDeptId" value="${bean.fOutDeptId}"/>
		    	<input type="hidden" name="fOutUserID" id="A_fOutUserID" value="${bean.fOutUserID}"/>
		    	<input type="hidden" name="fInUserID" id="A_fInUserID" value="${bean.fInUserID}"/>
		    	<input type="hidden" name="fInDeptID" id="A_fInDeptID" value="${bean.fInDeptID}"/>
		    	<input type="hidden" name="fNextUserName" id="A_fNextUserName" value="${bean.fNextUserName}"/>
		    	<input type="hidden" name="fNextUserCode" id="A_fNextUserCode" value="${bean.fNextUserCode}"/>
		    	<input type="hidden" name="fNextCode" id="A_fNextCode" value="${bean.fNextCode}"/>
		    	<input type="hidden" name="fRecDept" id="A_fRecDept" value="${bean.fRecDept}"/>
		    	<input type="hidden" name="fRecUser" id="A_fRecUser" value="${bean.fRecUser}"/>
					<div class="easyui-accordion" style="width:662px;margin-left: 15px;">
							<div title="调拨单详情" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
								<table class="ourtable" cellpadding="0" cellspacing="0">
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>&nbsp;资产调拨单号</td>
										<td  colspan="4">
											<input id="A_fAssAllcoaCode" class="easyui-textbox" readonly="readonly" required="required" name="fAssAllcoaCode" data-options="prompt:'系统自动生成',validType:'length[1,20]'" value="${bean.fAssAllcoaCode}" style="width: 555px;color: #f7f7f7;"/> 
										</td>								
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>&nbsp;调入部门</td>
										<td class="td2">
											<input class="easyui-textbox" readonly="readonly" required="required" class="dfinput"  id="A_fInDept" name="fInDept"  data-options="prompt:'点击选择',validType:'length[1,25]'" style="width: 200px" 
											value="${bean.fInDept }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>&nbsp;调出部门</td>
										<td class="td2">
											<input class="easyui-textbox" class="dfinput"  readonly="readonly" required="required"  id="A_fOutDept" name="fOutDept"  data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fOutDept}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>&nbsp;调入日期</td>
										<td class="td2">
											<input class="easyui-datebox" class="dfinput" readonly="readonly" required="required" id="A_fInTime" name="fInTime" editable="false" data-options="prompt:'',validType:'length[1,25]'" style="width: 200px" 
											value="${bean.fInTime }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>&nbsp;调出日期</td>
										<td class="td2">
											<input class="easyui-datebox" class="dfinput" readonly="readonly" required="required" id="A_fOutTime" name="fOutTime" editable="false" data-options="validType:'length[1,20]'" style="width: 200px" 
											value="${bean.fOutTime}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>&nbsp;调入经办人</td>
										<td class="td2">
											<input class="easyui-textbox" class="dfinput" readonly="readonly" required="required" id="A_fInUser" name="fInUser"  data-options="prompt:'',validType:'length[1,25]'" style="width: 200px" 
											value="${bean.fInUser }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>&nbsp;调出经办人</td>
										<td class="td2">
											<input class="easyui-textbox" class="dfinput" readonly="readonly" required="required" id="A_fOutUser" name="fOutUser"  data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fOutUser}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>&nbsp;合计数量</td>
										<td class="td2">
											<input class="easyui-numberbox" class="dfinput" readonly="readonly" required="required" id="A_fSumNumber" name="fSumNumber"  data-options="prompt:'',validType:'length[1,25]',precision:0" style="width: 200px" 
											value="${bean.fSumNumber }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>&nbsp;合计总值</td>
										<td class="td2">
											<input class="easyui-numberbox" class="dfinput" readonly="readonly" required="required" id="A_fSumAmount" name="fSumAmount" data-options="icons: [{iconCls:'icon-yuan'}],validType:'length[1,20]',precision:2" style="width: 200px" 
											value="${bean.fSumAmount}"/>
										</td>
									</tr>
									<%-- <tr class="trbody">
										<td class="td1">&nbsp;&nbsp;申请部门</td>
										<td class="td2">
											<input class="easyui-textbox" required="required" class="dfinput" readonly="readonly" id="A_fRecDept" name="fRecDept"  data-options="prompt:'',validType:'length[1,25]'" style="width: 200px" value="${bean.fRecDept }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1">&nbsp;&nbsp;申请人</td>
										<td class="td2">
											<input class="easyui-textbox" required="required" class="dfinput" readonly="readonly" id="A_fRecUser" name="fRecUser"  data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fRecUser}"/>
										</td>
									</tr> --%>
									
									<tr style="height: 70px;">
										<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span> 资产内部转移原因</p></td>
										<td  colspan="4">
											<input class="easyui-textbox" data-options="validType:'length[1,200]',multiline:true" readonly="readonly" required="required" id="A_fAllocaRemark" name="fAllocaRemark" style="width: 555px;height:70px" value="${bean.fAllocaRemark}">  
										</td>
									</tr>
										
									<tr class="trbody">
										<td class="td1">
											&nbsp;&nbsp;附件
											<input type="file" multiple="multiple" id="fzcdb" onchange="upladFile(this,'allocaFlies','zcagl01')" hidden="hidden">
											<input type="text" id="files" name="allocaFlies" hidden="hidden">
										</td>
										<td colspan="4" id="tdf">
											<%-- <c:if test="${openType=='add'||openType=='edit'}">
											<a onclick="$('#fzcdb').click()" style="font-weight: bold;" href="#">
												<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
											</a>
											</c:if>
											<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
												<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
										 		</div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
											 </div> --%>
											<c:forEach items="${allocaListFiles}" var="att">
												<c:if test="${att.serviceType=='allocaFlies' }">
													<div style="margin-top: 10px;">
													<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
													&nbsp;&nbsp;&nbsp;&nbsp;
													<%-- <c:if test="${openType=='add'||openType=='edit'}">
													<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
													&nbsp;&nbsp;&nbsp;&nbsp;
														<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
													</c:if> --%>
													</div>
												</c:if>
											</c:forEach>
										</td>
									</tr>
								</table>	
							</div>
							<div title="调拨清单" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
								<jsp:include page="alloca_base_add_plan.jsp" />												
							</div>
							<c:if test="${checkinfo==1}">
							<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
								<jsp:include page="../../check_history.jsp" />												
							</div>
							</c:if>
						</div>			
			
		
			</div>
			
			<div class="win-left-bottom-div">
				<%-- <c:if test="${openType=='add'||openType=='edit'}">
					<a href="javascript:void(0)" onclick="AllocaAddEditForm();">
						<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="AllocsFormSS()">
						<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
				</c:if> --%>
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
	
		<div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
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
		function AllocaAddEditForm(){
			$("#A_fFlowStauts").val("0"); 
			$('#AllocaAddEditForm').form('submit', {
				onSubmit: function(param){ 
					param.planJson=getPlan();
   					flag=$(this).form('enableValidation').form('validate');
   					if(flag){
   						$.messager.progress();
   					}
   					return flag;
   				}, 
   				/* url:base+'/demo/save',  */
   				success:function(data){
   					if(flag){
   						$.messager.progress('close');
   					}
   					data=eval("("+data+")");
   					if(data.success){
   						$.messager.alert('系统提示', data.info, 'info');
   						closeWindow();
   						$('#AllocaAddEditForm').form('clear');
   						$("#allcoa_dg").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   					}
   				} 
   			});		
		}
		function AllocsFormSS(){
			$("#A_fFlowStauts").val("1");
			$('#AllocaAddEditForm').form('submit', {
								
   				onSubmit: function(param){ 
   					param.planJson=getPlan();
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
   					data=eval("("+data+")");
   					if(data.success){
   						$.messager.alert('系统提示', data.info, 'info');
   						closeWindow();
   						$('#AllocaAddEditForm').form('clear');
   						$("#allcoa_dg").datagrid('reload'); 
   						$('#indexdb').datagrid('reload');
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   					}
   				} 
   			});		
		}
		
		function fReceCode(){
			var win=creatFirstWin('原配置单号',840,450,'icon-search','/Alloca/receCodeList');
			win.window('open');
		}
		//弹出选择资产的页面
		function chooseAss(){
			var win=creatFirstWin('选择调拨资产',970,560,'icon-search','/Alloca/choose');
			win.window('open');
		}
		function fTransUser(){
			var win=creatFirstWin('姓名部门',840,450,'icon-search','/Alloca/nameAndDept');
			win.window('open');
		}
		function quota_DC(){
			//var node=$('#allcoa_dg').datagrid('getSelected');
			var win=creatFirstWin('选择-预算指标编号',750,550,'icon-add','/BudgetIndexMgr/contract_list');
			win.window('open');
		}
	var c1 =0;
	function upFile1() {
		c1 ++;
		var src = $('#a_fFileSrc1').val();
		$('#fi1').val(src);
		$('#S_a_f1').append("<div id='c1"+c1+"'><a href='#' style='color: #3f7f7f;font-weight: bold;'>"+src+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a style='color: red;' href='#' onclick='deleteF1(c1"+c1+")'>删除</a></div>");
	} 
	function deleteF1(val){
		var child=document.getElementById(val.id);
		child.parentNode.removeChild(child);
	}
		var names = new Array();
		function streetChange(streetCode){
			$('#userStreetJwh').combobox('reload',"${base}/street/jwh?streetCode="+streetCode);
		}
		function departSelect(selectType){
			var win=creatSearchDataWin('选择-部门',590,400,'icon-add',"/depart/refUserDepart/"+selectType);
		    win.window('open');
		} 
		function departReturnSelect(ret){
			if (ret == "clear") {
		       $("#user_depart").html("");
			}

		    if (ret!="&&&&" && ret != undefined && ret != null && ret.indexOf("&&") != -1 && ret != "cancel") {
		    	var retArray = ret.split("&&");
		        var str= new Array(); 
		       	str=retArray[2].split(","); 
		       	for(var i=0;i<str.length-1 ;i++){
		       		if(null!=str[i]){
		       			var str1= new Array();
		       			str1=str[i].split(":");
		       			var div1 = $("#user_depart");
		       			if(!isUserTreeExist(str1[0]) && !isUserTreeExist(str1[1])){
							names.push(str1[0]);	
							div1.html("<div  style='float:left;margin-left:8px;margin-top:8px;' > "+
										"<input type='hidden' name='depart.id' id='departIds' value='"+str1[0]+"'/>"+
										"<span title='"+str1[1]+"'>"+((str1[1].length>8)?str1[1].substring(0,8)+"...":str1[1])+"</span>"+
										"<img src='${base}/resource/images/cancelDepart.jpg' style='cursor:pointer;margin-left:5px;height:15px;width:15px;' onclick = 'cancelUserDepart(this)' title='删除' id='"+str1[0]+"'/>"+
										"</div>");
						}
		       		}
		       	}
		    }
		}
		function isUserTreeExist(name){
			for(var i=0; i<names.length; i++){
				if(names[i] == name){
					return true;
				}
			}
			return false;
		}
		function deleteCF(){
			var row = $('#CS_dg').datagrid('getSelected');
			var selections = $('#allcoa_dg').datagrid('getSelections');
				if(confirm("确认删除吗？")){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/Formulation/delete/'+row.fcId,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#allcoa_dg").datagrid('reload');
							}else{
								$.messager.alert('系统提示',data.info,'error');
							}
						} 
					}); 
				}
		}
		function cancelUserDepart(obj){
			var id=obj.id;
			if(names.length>0)
			{
				for(i=0; i<names.length; i++){
					if(names[i] == id){
						names.splice(i,1);
					}
				}
			}
			$(obj).parent().remove();
		}
		function checkMobileNo(){
			var mobile=$("#user_edit_mobileNo").textbox("getValue");
			var id=$("#user_edit_id").val();
			var tag="0";
			if(mobile!=''){
				 $.ajax({
		  			   type : "post",
		  			   url : "${base}/user/mobileCheck",
		  			   data:{"mobileNo":mobile,"id":id},
		  			   dataType: 'json',  
					   async: false,
		  			   success : function(data){
		  				   if(data.success){ 	
		  			   	     $.messager.alert('系统提示', "手机号在系统中已存在，请更换手机号！", 'info');
		  			   	     tag="1";
		  			   	   }else{
		  			   		 tag="0"; 
		  			   	   }  
		  			   }
		  		   })
			}
			 if(tag=="0"){
		    	return true; 
		     }else if(tag=="1"){
		    	return false; 
		     }
		}
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
		    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) + ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i) + ':' + (s < 10 ? '0' + s : s);
		}
		
		
		
		//调入部门
		function inDepart(){
			var win = creatFirstWin('调入部门', 840, 450, 'icon-search', '/Alloca/departCodeList');
			win.window('open');
		}
	</script>
</body>
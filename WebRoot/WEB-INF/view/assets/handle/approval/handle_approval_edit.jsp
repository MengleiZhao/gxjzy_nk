<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="HandleApprovalAddEditForm" action="${base}/Handle/applicationSave" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="fId" id="H_fId" value="${bean.fId}"/>
		    	<input type="hidden" name="fFlowStauts" id="H_fFlowStauts" value="${bean.fFlowStauts}"/>
		    	<input type="hidden" name="fHandleStauts" id="H_fHandleStauts" value="${bean.fHandleStauts}"/>
		    	<input hidden="hidden" type="text" id="remakeValue" name="fRemark" />
		    	<!-- 审批附件 --><input type="hidden" name="spjlFile" id="spjlFile" value=""/>
	    		<c:if test="${bean.fId !=null}">
			    	<input type="hidden" name="fReqTime" id="H_fReqTime" value="${bean.fReqTime}"/>
			    	<input type="hidden" name="fNextUserName" id="H_fNextUserName" value="${bean.fNextUserName}"/>
			    	<input type="hidden" name="fNextUserCode" id="H_fNextUserCode" value="${bean.fNextUserCode}"/>
			    	<input type="hidden" name="fNextCode" id="H_fNextCode" value="${bean.fNextCode}"/>
			    	<input type="hidden" name="fReqUser" id="H_fReqUser" value="${bean.fReqUser}"/>
			    	<input type="hidden" name="fRecDept" id="H_fRecDept" value="${bean.fRecDept}"/>
			    	<input type="hidden" name="fReqUserid" id="H_fReqUserid" value="${bean.fReqUserid}"/>
			    	<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
			    	<input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
	    		</c:if>
					<div class="easyui-accordion" style="width:662px;margin-left: 15px;">
							<div title="处置单详情" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
								<table class="ourtable" cellpadding="0" cellspacing="0">
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>资产处置单号</td>
										<td  colspan="4">
											<input id="H_fAssHandleCode" class="easyui-textbox" type="text" readonly="readonly" name="fAssHandleCode" data-options="prompt:'系统自动生成',validType:'length[1,20]'" value="${bean.fAssHandleCode}" style="width: 555px;color: #f7f7f7;"/> 
										</td>								
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>处置资产编号</td>
										<td colspan="4">
											<input id="H_fAssCode" class="easyui-textbox" type="text" readonly="readonly"  name="fAssCode" data-options="prompt:'单击选择原配置单号',validType:'length[1,20]'" value="${bean.fAssCode}" style="width: 555px;color: #f7f7f7;"/>
										</td>								
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>处置资产名称</td>
										<td class="td2">
											<input class="easyui-textbox" class="dfinput" id="H_fAssName" readonly="readonly"  name="fAssName"  data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fAssName }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>处理资产类型</td>
										<td class="td2">
											<input  id="H_fAssType" name="fAssType"  value="${bean.fAssType}" readonly="readonly"  data-options="url:'${base}/Handle/lookupsJson?parentCode=ZCLX&selected=${bean.fAssType}',method:'POST',valueField:'code',textField:'text',editable:false" class="easyui-combobox" style="width: 200px"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>计量单位</td>
										<td class="td2">
											<input class="easyui-textbox" class="dfinput" id="H_fMeasUnit" readonly="readonly"  name="fMeasUnit" data-options="validType:'length[0,11]'" style="width: 200px" value="${bean.fMeasUnit }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>处置数量</td>
										<td class="td2">
											<input class="easyui-textbox" class="dfinput"  id="H_fHandleNum" readonly="readonly"  name="fHandleNum"  data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fHandleNum}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>处置方式</td>
										<td class="td2">
											<input  id="H_fHandleKind" name="fHandleKind" readonly="readonly"  data-options="url:'${base}/Handle/lookupsJson?parentCode=CZFS&selected=${bean.fHandleKind }',method:'POST',valueField:'code',textField:'text',editable:false" class="easyui-combobox" style="width: 200px" value="${bean.fHandleKind }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>处置日期</td>
										<td class="td2">
											<input class="easyui-datebox" class="dfinput"  id="H_fHandleTime" readonly="readonly"  name="fHandleTime"  data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fHandleTime}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>处置人</td>
										<td class="td2">
											<input class="easyui-textbox" class="dfinput" id="H_fHandleUser" readonly="readonly"  name="fHandleUser" data-options="prompt:'单击选择',validType:'length[0,20]'" style="width: 200px" value="${bean.fHandleUser }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>处置人部门</td>
										<td class="td2">
											<input class="easyui-textbox" class="dfinput"  id="H_fHandleDept" readonly="readonly"  name="fHandleDept"  data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fHandleDept}"/>
										</td>
									</tr>
																		<tr class="trbody">
										<td class="td1"><span class="style1">*</span>资产净值(元)</td>
										<td class="td2">
											<input class="easyui-numberbox" class="dfinput" id="H_fNetValue" readonly="readonly"  name="fNetValue" data-options="validType:'length[0,11]'" style="width: 200px" value="${bean.fNetValue }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>原使用部门</td>
										<td class="td2">
											<input class="easyui-textbox" class="dfinput" id="H_fOldDept" readonly="readonly"  name="fOldDept" data-options="validType:'length[0,20]'" style="width: 200px" value="${bean.fOldDept }"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>已提折旧(元)</td>
										<td class="td2">
											<input class="easyui-numberbox" class="dfinput" id="H_fDeprecationValue" readonly="readonly"  name="fDeprecationValue" data-options="validType:'length[0,11]'" style="width: 200px" value="${bean.fDeprecationValue }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>资产残值(元)</td>
										<td class="td2">
											<input class="easyui-numberbox" class="dfinput" id="H_fResidualValue" readonly="readonly"  name="fResidualValue" data-options="validType:'length[0,20]'" style="width: 200px" value="${bean.fResidualValue }"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>购买日期</td>
										<td class="td2">
											<input class="easyui-datebox" class="dfinput" id="H_fBuyTime" readonly="readonly"  name="fBuyTime" data-options="validType:'length[0,11]'" style="width: 200px" value="${bean.fBuyTime }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>规定使用年限(年)</td>
										<td class="td2">
											<input class="easyui-numberbox" class="dfinput" id="H_fWxTime" readonly="readonly"  name="fWxTime" data-options="validType:'length[0,20]'" style="width: 200px" value="${bean.fWxTime }"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>已使用年限(年)</td>
										<td class="td2">
											<input class="easyui-numberbox" class="dfinput" id="H_fUsedTime" readonly="readonly"  name="fUsedTime" data-options="validType:'length[0,11]'" style="width: 200px" value="${bean.fUsedTime }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>尚未使用年限(年)</td>
										<td class="td2">
											<input class="easyui-numberbox" class="dfinput" id="H_fUnusedTime" readonly="readonly"  name="fUnusedTime" data-options="validType:'length[0,20]'" style="width: 200px" value="${bean.fUnusedTime }"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>资产原值</td>
										<td class="td2">
											<input class="easyui-numberbox" class="dfinput" id="H_fOldAmount" readonly="readonly"  name="fOldAmount" data-options="validType:'length[0,11]'" style="width: 200px" value="${bean.fOldAmount }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td colspan="2"><span id="H_fOldAmount_span" > </span></td>
									</tr>
									<tr class="trbody">
									<td class="td1"><span class="style1">*</span>是否上报</td>
										<td class="td2">
											<input type="radio" name="fIsReport" value="1" checked="checked" <c:if test="${bean.fIsReport=='1'}">checked="checked"</c:if> />是
											<input type="radio" name="fIsReport" value="0" <c:if test="${bean.fIsReport=='0'}">checked="checked"</c:if> />否
											<%-- <select class="easyui-combobox" id="F_fIsAuthor" name="fIsAuthor" value="${bean.fIsAuthor}"style="width: 200px" data-options="editable:false,panelHeight:'auto'">
												<option value="${bean.fIsAuthor}"></option>
												<option value="0">否</option>
												<option value="1">是</option>
											</select> --%>
										</td>
									</tr>
									<tr style="height: 70px;">
										<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>处置原因</p></td>
										<td  colspan="4">
											<input class="easyui-textbox" data-options="multiline:true" readonly="readonly"  id="H_fHandleRemark" name="fHandleRemark" style="width: 555px;height:70px" value="${bean.fHandleRemark}">  
											<!-- <input type="text" id="S_fFlowStauts" name="fFlowStauts" hidden="hidden" value="0"/> -->
										</td>
									</tr>	
								</table>	
							</div>
							<c:if test="${checkinfo==1}">
								<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
									<jsp:include page="../../../check_history.jsp" />												
								</div>
							</c:if>
							<%-- <div title="审批意见" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
								<table class="ourtable" cellpadding="0" cellspacing="0">
									<tr style="height: 70px;">
										<td class="td1" valign="top"><p style="margin-top: 8px">&nbsp;&nbsp;审批意见</p></td>
										<td  colspan="4">
											<input class="easyui-textbox" data-options="multiline:true" id="H_fRemark" name="fRemark" style="width: 505px;height:70px" value="${check.fRemark}">  
											<!-- <input type="text" id="S_fFlowStauts" name="fFlowStauts" hidden="hidden" value="0"/> -->
										</td>
									</tr>	
								</table>	
							</div> --%>
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
    var c=0;
	//附件上传
	function upFile() {
		var url = $("#f").val();
		var urlli = url.split(',');
		var fAssType= "ZCLX-01";
		for(var i=0; i< urlli.length; i++){
			var fileurl=urlli[i];
			var filename = fileurl.split('\\');
			$('#tdf').append(
				"<div style='margin-top: 10px;'>"+
					"<a href='#' style='color: #666666;font-weight: bold;'>"+filename[filename.length-1]+"</a>"+
					"&nbsp;&nbsp;&nbsp;&nbsp;"+
					"<img id='imgt"+c+"' style='display:none' src='"+base+"/resource-modality/${themenurl}/sccg.png'>"+
					"<img id='imgf"+c+"' style='display:none' src='"+base+"/resource-modality/${themenurl}/scsb.png'>"+
					"&nbsp;&nbsp;&nbsp;&nbsp;<a id='"+fileurl+"' class='fileUrl' href='#' style='color:red' onclick='deleteAttac(this)'>删除</a><div>"
			);
			c++;
			fileurl = encodeURI(encodeURI(fileurl));
			$.ajax({
				async:false,
				type:"POST",
		        url:base+"/Storage/storageFile?fileurl="+fileurl,
		        data:{"fAssType":fAssType},
		        success:function(data){
			    	if($.trim(data)=="true"){
						$('#imgt'+i).css('display','');
			    	} else {
						$('#imgf'+i).css('display','');
			    	}
		        }
		    });
		}	
	} 
		function HandleApprovalAddEditForm(){
			/* //附件的路径地址
			var s="";
			$(".fileUrl").each(function(){
				s=s+$(this).attr("id")+",";
			});
			$("#files").val(s); */
			$("#H_fFlowStauts").val("0"); 
			$('#HandleApprovalAddEditForm').form('submit', {
				onSubmit: function(){ 
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
   						$('#HandleApprovalAddEditForm').form('clear');
   						$("#handle_application_dg").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   					}
   				} 
   			});		
		}
		function AllocsFormSS(){
			$("#H_fFlowStauts").val("1");
			$('#HandleApprovalAddEditForm').form('submit', {
								
   				onSubmit: function(){ 
   					
   					flag=$(this).form('enableValidation').form('validate');
   					if(flag){
   						$.messager.progress();
   					}
   					return flag;
   				}, 
   				
   				//url:base+'/demo/save',
   				success:function(data){
   					if(flag){
   						$.messager.progress('close');
   					}
   					data=eval("("+data+")");
   					if(data.success){
   						$.messager.alert('系统提示', data.info, 'info');
   						closeWindow();
   						$('#HandleApprovalAddEditForm').form('clear');
   						$("#handle_application_dg").datagrid('reload'); 
   						$("#indexdb").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   					}
   				} 
   			});		
		}
		
		function fAssCode(){
			var win=creatFirstWin('处置资产编号',840,450,'icon-search','/Handle/AssCodeList');
			win.window('open');
		}
		function UserAndDept(){
			var win=creatFirstWin('姓名部门',840,450,'icon-search','/Handle/nameAndDept');
			win.window('open');
		}
		function quota_DC(){
			//var node=$('#handle_application_dg').datagrid('getSelected');
			var win=creatFirstWin('选择-预算指标编号',750,550,'icon-add','/BudgetIndexMgr/contract_list');
			win.window('open');
		}
		
	function check(stauts){
		if(stauts==1){
			stauts='tg';
		}else if(stauts==0){
			stauts='btg';
		}
		var r=$('#H_fRemark').val();
		$('#HandleApprovalAddEditForm').form('submit', {
				onSubmit: function(){ 
					flag=$(this).form('enableValidation').form('validate');
					if(flag){
						$.messager.progress();
					}
					return flag;
				}, 
				url:'${base}/Handle/approval/'+stauts,
				success:function(data){
					if(flag){
						$.messager.progress('close');
					}
					data=eval("("+data+")");
					if(data.success){
						$.messager.alert('系统提示', data.info, 'info');
						closeWindow();
						$('#HandleApprovalAddEditForm').form('clear');
						$('#handle_approval_dg').datagrid('reload'); 
					}else{
						$.messager.alert('系统提示', data.info, 'error');
					}
				} 
			});	
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
			var selections = $('#handle_application_dg').datagrid('getSelections');
				if(confirm("确认删除吗？")){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/Formulation/delete/'+row.fcId,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#handle_application_dg").datagrid('reload');
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
	</script>
</body>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="HandleApplicationAddEditForm" action="${base}/Handle/applicationSave" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="fAssType.code" id="H_fAssType" value="${bean.fAssType.code}"/>
				<input type="hidden" name="fId" id="H_fId" value="${bean.fId}"/>
		    	<input type="hidden" name="fFlowStauts" id="H_fFlowStauts" value="${bean.fFlowStauts}"/>
		    	<input type="hidden" name="fHandleStauts" id="H_fHandleStauts" value="${bean.fHandleStauts}"/>
	    		<c:if test="${bean.fId !=null}">
			    	<input type="hidden" name="fReqTime" id="H_fReqTime" value="${bean.fReqTime}"/>
			    	<input type="hidden" name="fNextUserName" id="H_fNextUserName" value="${bean.fNextUserName}"/>
			    	<input type="hidden" name="fNextUserCode" id="H_fNextUserCode" value="${bean.fNextUserCode}"/>
			    	<input type="hidden" name="fNextCode" id="H_fNextCode" value="${bean.fNextCode}"/>
			    	<input type="hidden" name="fReqUser" id="H_fReqUser" value="${bean.fReqUser}"/>
			    	<input type="hidden" name="fRecDept" id="H_fRecDept" value="${bean.fRecDept}"/>
			    	<input type="hidden" name="fRecDeptID" id="H_fRecDeptID" value="${bean.fRecDeptID}"/>
			    	<input type="hidden" name="fReqUserid" id="H_fReqUserid" value="${bean.fReqUserid}"/>
	    		</c:if>
	    		
				<div class="easyui-accordion" style="width:662px;margin-left: 20px;">
					<div title="处置单详情" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
						<table class="ourtable" cellpadding="0" cellspacing="0">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;资产处置单号</td>
								<td  colspan="4">
									<input id="H_fAssHandleCode" class="easyui-textbox" readonly="readonly" required="required" name="fAssHandleCode" data-options="prompt:'系统自动生成',validType:'length[1,20]'" value="${bean.fAssHandleCode}" style="width: 555px;color: #f7f7f7;"/> 
								</td>								
							</tr>
							
							<c:if test="${bean.fAssType.code=='ZCLX-01'}">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;合计金额</td>
								<td class="td2">
									<input class="easyui-numberbox" class="dfinput" readonly="readonly" required="required" id="H_fSumAmount" name="fSumAmount"  data-options="icons: [{iconCls:'icon-yuan'}],validType:'length[1,20]',precision:2" style="width: 200px" value="${bean.fSumAmount}"/>
								</td>
								<td class="td4">&nbsp;</td>
							</tr>
							</c:if>
									
							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>&nbsp;处置说明</p></td>
									<td  colspan="4">
										<%-- <input class="easyui-textbox" data-options="multiline:true" required="required" id="H_fHandleRemark"
										 name="fHandleRemark" style="width: 555px;height:60px" value="${bean.fHandleRemark}">  --%> 
										<!-- <input type="text" id="S_fFlowStauts" name="fFlowStauts" hidden="hidden" value="0"/> -->
										
										
										<textarea name="fHandleRemark"  id="H_fHandleRemark"  class="textbox-text" oninput="textareaNum(this,'textareaNum1')"
											autocomplete="off"  style="width: 555px;height:70px;resize:none">${bean.fHandleRemark }</textarea>
									</td>
								</tr>
								<tr>
									<td align="right" colspan="5" style="padding-right: 0px;">
										可输入剩余数：<span id="textareaNum1" class="200">
										<c:if test="${empty bean.fHandleRemark}">200</c:if>
										<c:if test="${!empty bean.fHandleRemark}">${200-bean.fHandleRemark.length()}</c:if>
										</span>
									</td>
								</tr>
										
							<tr class="trbody">
								<td class="td1">
									&nbsp;&nbsp;附件
									<input type="file" multiple="multiple" id="fzccz" onchange="upladFile(this,'handleflies','zcagl01')" hidden="hidden">
									<input type="text" id="files" name="LowHandleFlies" hidden="hidden">
								</td>
								<td colspan="4" id="tdf">
									<a onclick="$('#fzccz').click()" style="font-weight: bold;" href="#">
										<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
									</a>
									<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
										<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
								 		</div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
									 </div>
									<c:forEach items="${handleList}" var="att">
										<c:if test="${att.serviceType=='handleflies' }">
											<div style="margin-top: 10px;">
												<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
												&nbsp;&nbsp;&nbsp;&nbsp;
												<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
												&nbsp;&nbsp;&nbsp;&nbsp;
												<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
											</div>
										</c:if>
									</c:forEach>
								</td>
							</tr>	
						</table>	
					</div>
						
					<c:if test="${bean.fAssType.code=='ZCLX-01'}">
						<div title="处置清单表" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
							<%@ include file="handle_low_add_plan.jsp" %>
						</div>
					</c:if>
					<c:if test="${bean.fAssType.code=='ZCLX-02'}">
						<div title="处置清单表" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
							<%@ include file="handle_fixed_add_plan.jsp" %>
						</div>
					</c:if>
					<c:if test="${checkinfo==1}">
						<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow-x:hidden;margin-top: 10px;">
							<jsp:include page="../../check_history.jsp" />												
						</div>
					</c:if>
				</div>			
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="HandleApplicationAddEditForm();">
					<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="HandleApplicationFormSS()">
					<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<%-- <c:if test="${detailType=='detail'}">
					<a href="javascript:void(0)" onclick="closeWindow()">
						<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</c:if>
				<c:if test="${detailType=='ledger'}">
					<a href="javascript:void(0)" onclick="closeFirstWindow()">
						<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</c:if>
				&nbsp;&nbsp;&nbsp; --%>
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
	$('#H_fWxTime').numberbox({
        onChange:function(newValue,oldValue){  
        	var H_fUsedTime=$('#H_fUsedTime').numberbox('getValue');
    		if(newValue<H_fUsedTime){
    			alert("'规定使用年限'不得小于'已使用年限'，请重新填写！");
        		$('#H_fUsedTime').numberbox('setValue',0);
	        	$('#H_fWxTime').numberbox('setValue',oldValue);
    		}else {
	    		$('#H_fUnusedTime').numberbox('setValue',newValue-H_fUsedTime);
    		}
        	
        }
	});
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
    $('#H_fOldAmount').numberbox({
    	 onChange:function(newValue,oldValue){  
    		 if(newValue<200000){
    			 $('#H_fOldAmount_span').html("您处置的资产原值低于20万元，请报国管局备案");
    		 }else if(newValue>=200000){
    			 $('#H_fOldAmount_span').html("您处置的资产原值超过20万元，请报国管局审批");
    		 }
    	 }
    });
    $('#H_fUsedTime').numberbox({
    	onChange:function(newValue,oldValue){  
    		var fWxTime=$('#H_fWxTime').textbox('getValue');
    		if(newValue>fWxTime){
    			alert("'已使用年限'不得大于'规定使用年限',请重新填写！");
    			$('#H_fUsedTime').numberbox('setValue',0);
    		}else{
	    		$('#H_fUnusedTime').textbox('setValue',fWxTime-newValue);
    		}
    	}
    });
		function HandleApplicationAddEditForm(){
			/* //附件的路径地址
			var s="";
			$(".fileUrl").each(function(){
				s=s+$(this).attr("id")+",";
			});
			$("#files").val(s); */
			$("#H_fFlowStauts").val("0"); 
			$('#HandleApplicationAddEditForm').form('submit', {
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
   						$('#HandleApplicationAddEditForm').form('clear');
   						$("#handle_low_dg").datagrid('reload'); 
   						$("#handle_fixed_dg").datagrid('reload');
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   					}
   				} 
   			});		
		}
		function HandleApplicationFormSS(){
			$("#H_fFlowStauts").val("1");
			$('#HandleApplicationAddEditForm').form('submit', {
								
   				onSubmit: function(param){ 
   					param.planJson=getPlan();
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
   						$('#HandleApplicationAddEditForm').form('clear');
   						$("#handle_low_dg").datagrid('reload'); 
   						$("#handle_fixed_dg").datagrid('reload'); 
   						$('#indexdb').datagrid('reload');
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   					}
   				} 
   			});		
		}
		
		function fAssCode(){
			var type=$('#H_Type').val();
			var win=creatFirstWin('处置资产编号',970,560,'icon-search','/Handle/AssCodeList?Type='+type);
			win.window('open');
		}
		function UserAndDept(){
			var win=creatFirstWin('姓名部门',970,560,'icon-search','/Handle/nameAndDept');
			win.window('open');
		}
		function quota_DC(){
			//var node=$('#handle_application_dg').datagrid('getSelected');
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
			var selections = $('#handle_application_dg').datagrid('getSelections');
				if(confirm("确认删除吗？")){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/Formulation/delete/'+row.fcId,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#handle_application_low_dg").datagrid('reload');
								$("#handle_application_fixed_dg").datagrid('reload');
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
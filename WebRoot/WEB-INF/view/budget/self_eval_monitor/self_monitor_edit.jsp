<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="selfmonitorEdit" action="${base}/pfmmonitor/save" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="pid" id="R_pid" value="${bean.pid}"/>
					<div class="easyui-accordion" style="width:662px;margin-left: 20px;">
							<div title="绩效目标监控" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
								<table class="ourtable" cellpadding="0" cellspacing="0">
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;项目名称</td>
										<td  colspan="4">
											<input id="F_FProName" class="easyui-textbox" type="text" readonly="readonly" name="project.FProName"  value="${bean.project.FProName}" style="width: 505px;color: #f7f7f7;"/> 
										</td>								
									</tr>
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;承办部门</td>
										<td class="td2">
											<input id="R_FProAppliDepart"  class="easyui-textbox" readonly="readonly" type="text" name="project.FProAppliDepart"  style="width: 150px" value="${bean.project.FProAppliDepart}"/>			
										</td>
										
										<td class="td4">&nbsp;</td>
										
										<td class="td1">&nbsp;&nbsp;项目负责人</td>
										<td class="td2">
											<input class="easyui-textbox" id="R_FProHead" readonly="readonly" name="project.FProHead"  style="width: 150px" value="${bean.project.FProHead}"/>
										</td>
									</tr>
									<tr style="height: 70px;">
										<td class="td1" valign="top"><p style="margin-top: 8px">&nbsp;&nbsp;项目目标</p></td>
										<td  colspan="4">
											<%-- <input class="easyui-textbox" readonly="readonly" data-options="multiline:true,validType:'length[0,200]'" id="R_longGoal" name="longGoal" style="width: 505px;height:70px" value="${bean.longGoal}"> --%>  
											<textarea name="longGoal"  id="R_longGoal"  class="textbox-text" oninput="textareaNum(this,'textareaNum1')" autocomplete="off"  style="width:555px;height:70px">${bean.longGoal }</textarea>
										</td>
									</tr>	
									<c:if test="${openType=='edit' }">
										<tr>
											<td align="right" colspan="5" style="padding-right: 50px;">
											可输入剩余数：<span id="textareaNum1" class="200">
												<c:if test="${empty bean.longGoal}">200</c:if>
												<c:if test="${!empty bean.longGoal}">${200-bean.longGoal.length()}</c:if>
											</span>
											</td>
										</tr>
									</c:if>
									<tr>
										<td colspan="5">
											<h1 style="text-align: left ">项目资金-年初预算数(万元)</h1>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;资金总额</td>
										<td class="td2">
											<input id="R_longTotal" readonly="readonly" class="easyui-numberbox" type="text" name="longTotal" data-options="validType:'length[1,20]'" style="width: 150px" value="${bean.longTotal}"/>					
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1">&nbsp;&nbsp;拨款金额</td>
										<td class="td2">
											<input class="easyui-numberbox" class="dfinput" readonly="readonly" id="R_longAmount1" name="longAmount1"  data-options="validType:'length[1,20]'" style="width: 150px" value="${bean.longAmount1}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;其他资金</td>
										<td class="td2">
											<input id="R_longAmount2"  class="easyui-numberbox" readonly="readonly" type="text" name="longAmount2" data-options="validType:'length[1,20]'" style="width: 150px" value="${bean.longAmount2}"/>					
										</td>
										<td class="td4">&nbsp;</td>
									</tr>
									<tr>
										<td colspan="5">
											<h1 style="text-align: left">项目资金-当前执行数(万元)</h1>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;资金总额</td>
										<td class="td2">
											<input class="easyui-numberbox" class="dfinput" readonly="readonly" id="R_fCurrentAmount" name="fCurrentAmount"  data-options="validType:'length[1,20]'" style="width: 150px" value="${bean.fCurrentAmount}"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1">&nbsp;&nbsp;预算拨款额</td>
										<td class="td2">
											<input id="R_fCurrentApproAmount" readonly="readonly" class="easyui-numberbox" type="text" name="fCurrentApproAmount" data-options="validType:'length[1,20]'" style="width: 150px" value="${bean.fCurrentApproAmount}"/>					
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;其他资金</td>
										<td class="td2">
											<input class="easyui-numberbox" class="dfinput" readonly="readonly" id="R_fCurrentOtherAmount" name="fCurrentOtherAmount"  data-options="validType:'length[1,20]'" style="width: 150px" value="${bean.fCurrentOtherAmount}"/>
										</td>
									</tr>
									<tr>
										<td colspan="5">
											<h1 style="text-align: left">项目资金-全年预计执行数(万元)</h1>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>资金总额</td>
										<td class="td2">
											<input id="R_fYearAmount"  class="easyui-numberbox"  name="fYearAmount" data-options="validType:'length[1,20]',precision:2" style="width: 150px" value="${bean.fYearAmount}"/>					
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>预算拨款额</td>
										<td class="td2">
											<input class="easyui-numberbox" class="dfinput"  id="R_fYearApproAmount" name="fYearApproAmount"  data-options="validType:'length[1,20]',precision:2" style="width: 150px" value="${bean.fYearApproAmount}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>其他资金</td>
										<td class="td2">
											<input id="R_fYearOtherAmount"  class="easyui-numberbox"  name="fYearOtherAmount" data-options="validType:'length[1,20]',precision:2" style="width: 150px" value="${bean.fYearOtherAmount}"/>					
										</td>
										<td class="td4">&nbsp;</td>
									</tr>
								</table>	
							</div>
							<div title="明细表" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
					        		<%@ include file="self_monitor_edit_goaldetail.jsp" %>
							</div> 
						</div>			
			
		
			</div>
			
			<div class="win-left-bottom-div">
				<c:if test="${openType=='add'||openType=='edit'}">
					<a href="javascript:void(0)" onclick="selfmonitorEdit();">
						<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
				</c:if>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<%-- <div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div> --%>
	</div>
</form>
</div>
	<script type="text/javascript">
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
	
	
	//附件删除AJAX
	function deleteAttac(a){
		var filename = a.id;
		var fAssType= $("#S_fAssType").val();
		filename = encodeURI(encodeURI(filename));  
		$.ajax({
			type:"POST",
	        url:base+"/Storage/storageFileDelete?filename="+filename,
	        data:{"fAssType":fAssType},
	        success:function(data){
	        	if($.trim(data)=="true"){
					//删除div
		        	$(a).parent().remove();
	        		alert("附件删除成功！");
	        	} else {
	        		alert("附件删除失败！");
	        	}
	        }
	    });
	}
		function selfmonitorEdit(){
			var plan = getPlan();
			$('#R_fFlowStauts_R').val("0");
			$('#selfmonitorEdit').form('submit', {
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
   						$('#selfmonitorEdit').form('clear');
   						$("#rece_low_dg").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   					}
   				} 
   			});		
		}
		function ReceLowFormSS(){
			$("#R_fFlowStauts_R").val('1');
			$('#selfmonitorEdit').form('submit', {
								
   				onSubmit: function(param){ 
   					param.planJson=getPlan();
   					flag=$(this).form('enableValidation').form('validate');
   					if(flag){
   						$.messager.progress();
   					}
   					return flag;
   				}, 
   				
   				//url:base+'/demo/save',
   				data:{'fFlowStauts_R':'1'},
   				success:function(data){
   					if(flag){
   						$.messager.progress('close');
   					}
   					data=eval("("+data+")");
   					if(data.success){
   						$.messager.alert('系统提示', data.info, 'info');
   						closeWindow();
   						$('#selfmonitorEdit').form('clear');
   						$("#rece_low_dg").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   						$('#selfmonitorEdit').form('clear');
   					}
   				} 
   			});		
		}
		
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
	</script>
</body>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="ReceFixedAddEditForm" action="${base}/Rece/save?fAssType=ZCLX-02" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="fId_R" id="R_fId_R" value="${bean.fId_R}"/>
		    	<input type="hidden" name="fFlowStauts_R" id="R_fFlowStauts_R" value="${bean.fFlowStauts_R}"/>
		    	<input type="hidden" name="fAssStauts" id="R_fAssStauts" value="${bean.fAssStauts}"/>
	    		<c:if test="${bean.fId_R !=null}">
			    	<input type="hidden" name="fOperator" id="R_fOperator" value="${bean.fOperator}"/>
			    	<input type="hidden" name="fOperatorDept" id="R_fOperatorDept" value="${bean.fOperatorDept}"/>
			    	<input type="hidden" name="fOperatorTime" id="R_fOperatorTime" value="${bean.fOperatorTime}"/>
			    	<input type="hidden" name="fNextUserName" id="R_fNextUserName" value="${bean.fNextUserName}"/>
			    	<input type="hidden" name="fNextUserCode" id="R_fNextUserCode" value="${bean.fNextUserCode}"/>
			    	<input type="hidden" name="fNextCode" id="R_fNextCode" value="${bean.fNextCode}"/>
			    	<input type="hidden" name="fReceUserId" id="R_fReceUserId" value="${bean.fReceUserId}"/>
	    		</c:if>
						<div class="easyui-accordion" style="width:662px;margin-left: 15px;">
							<div title="领用单详情" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
								<table class="ourtable" cellpadding="0" cellspacing="0">
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>资产领用单号</td>
										<td  colspan="4">
											<input id="R_fAssReceCode" class="easyui-textbox" type="text" readonly="readonly" name="fAssReceCode" data-options="prompt:'系统自动生成',validType:'length[1,20]'" value="${bean.fAssReceCode}" style="width: 555px;color: #f7f7f7;"/> 
										</td>								
									</tr>
									<%-- <tr class="trbody">
										<td class="td1"><span class="style1">*</span>领用资产名称</td>
										<td class="td2">
											<input class="easyui-combobox" id="R_fAssName" name="fAssName" style="width: 200px" value="${bean.fAssName}" data-options="editable:false,panelHeight:'auto',url:'${base}/Rece/lookupsJsonAssName',method:'POST',valueField:'fAssName',textField:'fAssName',editable:false,onSelect:function(item){
												$('#R_fMeasUnit').textbox('setValue', item.fMeasUnit);
												$('#R_fAssCode_R').textbox('setValue', item.fAssCode);
											}">
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>资产编号</td>
										<td class="td2">
											<input class="easyui-textbox" class="dfinput" readonly="readonly" id="R_fAssCode_R" name="fAssCode_R"  data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fAssCode_R}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>领用数量</td>
										<td class="td2">
											<input class="easyui-textbox" class="dfinput" readonly="readonly" id="R_fReceNum" name="fReceNum"  data-options="validType:'length[1,20]'" style="width: 200px" value="1"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>计量单位</td>
										<td class="td2">
											<input class="easyui-textbox" class="dfinput"  id="R_fMeasUnit" name="fMeasUnit"  data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fMeasUnit}"/>
										</td>
									</tr> --%>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>领用部门</td>
										<td class="td2">
											<%-- <c:if test="${openType=='add'||openType=='edit'}"><a onclick="fReceCode()"></c:if> --%><input id="R_fReceDept" readonly="readonly" class="easyui-textbox" type="text" name="fReceDept" data-options="prompt:'点击选择',validType:'length[1,20]'" style="width: 200px" value="${bean.fReceDept}"/></a>					
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1">&nbsp;&nbsp;领用人</td>
										<td class="td2">
											<input id="R_fReceUser" readonly="readonly" class="easyui-textbox" type="text" name="fReceUser" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fReceUser}"/>
																
										</td>
									</tr>
									<%-- <tr class="trbody">
										<td class="td1"><span class="style1">*</span>领用人电话</td>
										<td class="td2">
											<input class="easyui-numberbox" class="dfinput"  id="R_fReceTel" name="fReceTel"  data-options="validType:'length[1,11]'" style="width: 200px" value="${bean.fReceTel}"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>领用日期</td>
										<td class="td2">
											<input class="easyui-datebox" class="dfinput"  id="R_fReceTime" name="fReceTime"  data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fReceTime}"/>
										</td>
									</tr> --%>
									<%-- <tr style="height: 70px;">
										<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>领用用途</p></td>
										<td  colspan="4">
											<input class="easyui-textbox" data-options="multiline:true" id="R_fReceRemark" name="fReceRemark" style="width: 505px;height:70px" value="${bean.fReceRemark}">  
											<!-- <input type="text" id="S_fFlowStauts" name="fFlowStauts" hidden="hidden" value="0"/> -->
										</td>
									</tr> --%>	
									<tr style="height: 70px;">
										<td class="td1" valign="top"><p style="margin-top: 8px">&nbsp;&nbsp;备注</p></td>
										<td  colspan="4">
											<%-- <input class="easyui-textbox" data-options="validType:'length[0,200]',multiline:true" id="R_fOtherRemark"
											 name="fOtherRemark" style="width: 555px;height:70px" value="${bean.fOtherRemark}"> --%>  
											<!-- <input type="text" id="S_fFlowStauts" name="fFlowStauts" hidden="hidden" value="0"/> -->
											<textarea name="fOtherRemark"  id="R_fOtherRemark"  class="textbox-text" oninput="textareaNum(this,'textareaNum1')"
											autocomplete="off"  style="width: 555px;height:70px;resize:none">${bean.fOtherRemark }</textarea>
										</td>
									</tr>
									<c:if test="${openType=='add'||openType=='edit'}">
										<tr>
											<td align="right" colspan="5" style="padding-right: 0px;">
											可输入剩余数：<span id="textareaNum1" class="200">
												<c:if test="${empty bean.fOtherRemark}">200</c:if>
												<c:if test="${!empty bean.fOtherRemark}">${200-bean.fOtherRemark.length()}</c:if>
											</span>
											</td>
										</tr>
									</c:if>	
								</table>	
							</div>
							<div title="领用资产清单" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
					        		<%@ include file="rece_base_add_plan.jsp" %>
							</div>
							<c:if test="${checkinfo==1}">
								<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
									<jsp:include page="../../check_history.jsp" />												
								</div>
							</c:if>
						</div>			
			</div>
			<div class="win-left-bottom-div">
				<%-- <c:if test="${openType=='add'}">
				<a href="javascript:void(0)" onclick="ReceFixedAddEditForm();">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				</c:if> --%>
				<c:if test="${openType=='add'||openType=='edit'}">
					<a href="javascript:void(0)" onclick="ReceFixedAddEditForm();">
						<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="RecefixedFormSS()">
						<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
				</c:if>
				<c:if test="${detailType=='ledger'}">
					<a href="javascript:void(0)" onclick="closeFirstWindow()">
						<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</c:if>
				<c:if test="${detailType=='detail'}">
					<a href="javascript:void(0)" onclick="closeWindow()">
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
		function ReceFixedAddEditForm(){
			/* //附件的路径地址
			var s="";
			$(".fileUrl").each(function(){
				s=s+$(this).attr("id")+",";
			});
			$("#files").val(s); */
			$('#R_fFlowStauts_R').val("0");
			$("#R_fAssStauts").val("1"); 
			$('#ReceFixedAddEditForm').form('submit', {
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
   						$('#ReceFixedAddEditForm').form('clear');
   						$("#rece_fixed_dg").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   					}
   				} 
   			});		
		}
		function RecefixedFormSS(){
			$("#R_fFlowStauts_R").val('1');
			$('#ReceFixedAddEditForm').form('submit', {
								
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
   						$('#ReceFixedAddEditForm').form('clear');
   						$("#rece_fixed_dg").datagrid('reload'); 
   						$('#indexdb').datagrid('reload');
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
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
			//var node=$('#rece_fixed_dg').datagrid('getSelected');
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
			var selections = $('#rece_fixed_dg').datagrid('getSelections');
				if(confirm("确认删除吗？")){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/Formulation/delete/'+row.fcId,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#rece_fixed_dg").datagrid('reload');
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
		    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) + ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i);
		}
	</script>
</body>
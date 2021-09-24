<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="StroageIntangibleAddEditForm" action="${base}/Storage/save" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="fId_S" id="S_fId_S" value="${bean.fId_S}"/>
		    	<input type="hidden" name="fAssStorageCode" id="S_fAssStorageCode" value="${bean.fAssStorageCode}"/>
		    	<input type="hidden" name="fPurchaseDate" id="S_fPurchaseDate" value="${bean.fPurchaseDate}"/>
		    	<input type="hidden" name="fOperator" id="S_fOperator" value="${bean.fOperator}"/>
		    	<input type="hidden" name="fAssStauts" id="S_fAssStauts" value="${bean.fAssStauts}"/>
					<div class="easyui-accordion" style="width:662px;margin-left: 15px;">
							<div title="无形资产登记表" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
								<table class="ourtable" border="0" cellpadding="0" cellspacing="0">
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>资产编号</td>
										<td  colspan="4">
											<input id="S_fAssCode" required="required" class="easyui-textbox"  name="fAssCode" data-options="prompt:'',validType:'length[1,20]'" value="${bean.fAssCode}" style="width: 555px"/> 
										</td>								
									</tr>
									
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>资产名称</td>
										<td  colspan="4">
											<input class="easyui-textbox"  id="S_fStorageName" name="fStorageName" required="required" data-options="validType:'length[1,50]'" value="${bean.fStorageName}" style="width: 555px"/>
										</td>
									</tr> 
									
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;资产类型</td>
										<td class="td2">
											<input id="S_fAssType" hidden="hidden" type="text"  name="fAssType" data-options="validType:'length[1,20]',prompt:'无形资产'"  value="ZCLX-03" style="width: 200px"/>
											<select class="easyui-combobox" id="S_fcType" readonly="readonly" name="fcType" value="ZCLX-03" style="width: 200px" data-options="editable:false,panelHeight:'auto'">
												<option value="ZCLX-03"<c:if test="${bean.fAssType=='ZCLX-03' }" >selected="selected"</c:if>>无形资产</option>
												<option value="ZCLX-02"<c:if test="${bean.fAssType=='ZCLX-02' }" >selected="selected"</c:if>>固定资产</option>
												<option value="ZCLX-01"<c:if test="${bean.fAssType=='ZCLX-01' }" >selected="selected"</c:if>>低值易耗品</option>
											</select>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>规格型号</td>
										<td class="td2">
											<input id="S_fSpecificationModel" required="required" class="easyui-textbox"  required="true" name="fSpecificationModel" data-options="validType:'length[1,50]'"  value="${bean.fSpecificationModel}" style="width: 200px"/>
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;单位</td>
										<td class="td2">
											<input class="easyui-textbox" id="S_fStorageUnit" name="fStorageUnit" data-options="validType:'length[1,10]',prompt:''" value="${bean.fStorageUnit}" style="width: 200px"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1">&nbsp;&nbsp;价值</td>
										<td class="td2">
											<input class="easyui-numberbox" class="dfinput" id="S_fStoragePrice" name="fStoragePrice"  data-options="icons: [{iconCls:'icon-yuan'}],validType:'length[1,20]',precision:2" style="width: 200px" value="${bean.fStoragePrice}"/>
										</td>
									</tr>
									
									
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;数量</td>
										<td class="td2">
											<input id="S_fStorageNum" class="easyui-numberbox"  readonly="readonly" name="fStorageNum" data-options="validType:'length[1,20]',precision:0" style="width: 200px" value="1"/>					
										</td>
										
										<td class="td4">&nbsp;</td>
										
										<td class="td1">&nbsp;&nbsp;资产原值</td>
										<td class="td2">
											<input class="easyui-numberbox"  id="S_fStorageValue" name="fStorageValue"   data-options="icons: [{iconCls:'icon-yuan'}]" style="width: 200px" value="${bean.fStorageValue}"/>
										</td>
									</tr>
									<tr  class="trbody">
										<td class="td1">&nbsp;&nbsp;发票号</td>
										<td  colspan="4">
											<input id="S_fStorageInvoice" class="easyui-textbox" name="fStorageInvoice" data-options="prompt:'发票号',validType:'length[1,20]'" value="${bean.fStorageInvoice}" style="width: 555px"/>
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1">
											&nbsp;&nbsp;附件
											<input type="file" multiple="multiple" id="fwxzcdj" onchange="upladFile(this,'intangibledj','zcagl01')" hidden="hidden">
											<input type="text" id="files" name="storageFiles" hidden="hidden">
										</td>
										<td colspan="4" id="tdf">
											<c:if test="${openType=='add'||openType=='edit'}">
											<a onclick="$('#fwxzcdj').click()" style="font-weight: bold;" href="#">
												<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
											</a>
											</c:if>
											<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
												<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
											 	</div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
											</div>
											<c:forEach items="${StorageAttaList}" var="att">
												<c:if test="${att.serviceType=='intangibledj' }">
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
									
									<tr style="height: 70px;">
										<td class="td1" valign="top">&nbsp;&nbsp;备注</td>
										<td  colspan="4">
											<%-- <input class="easyui-textbox" data-options="validType:'length[1,100]',multiline:true" id="S_fRemark_S" name="fRemark_S" style="width: 555px;height:70px" value="${bean.fRemark_S}"> --%>  
											<!-- <input type="text" id="S_fFlowStauts" name="fFlowStauts" hidden="hidden" value="0"/> -->
											<textarea name="fRemark_S"  id="S_fRemark_S"  class="textbox-text" oninput="textareaNum(this,'textareaNum1')"
											autocomplete="off"  style="width: 555px;height:70px;resize:none">${bean.fRemark_S }</textarea>
										</td>
									</tr>
									<c:if test="${openType=='add'||openType=='edit'}">
										<tr>
											<td align="right" colspan="5" style="padding-right: 0px;">
											可输入剩余数：<span id="textareaNum1" class="200">
												<c:if test="${empty bean.fRemark_S}">200</c:if>
												<c:if test="${!empty bean.fRemark_S}">${200-bean.fRemark_S.length()}</c:if>
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
				<a href="javascript:void(0)" onclick="StroageIntangibleAddEditForm();">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				</c:if>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				&nbsp;&nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=资产管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
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
//上传附件
function storagefixed_upFile(obj){
	//创建上传表单
	var files = obj.files;
	var formData = new FormData();
    for(var i=0; i< files.length; i++){
  	  formData.append("attFiles",files[i]);   
  	} 
    //ajax上传
	$.ajax({  
    	url: base + '/Storage/uploadAtt?serviceType=intangibledj',  
        type: 'post',  
        data: formData,  
        cache: false,
        processData: false,
        contentType: false,
        async: false,
        dataType:'json',
	    success:function(data){
	    	 if(data.success==true){
			        var datainfo = data.info;
	    		 	var infoArray = datainfo.split(',');	
	    		 	for(var i=0; i< infoArray.length; i++){
	    		 		var info = infoArray[i];
	    		 		var inf = info.split('@');
	    		 		var id = inf[0];//附件id
	    		 		var name = inf[1];//附件名称
				        $('#tdfwxzcdj').append(
			    			"<div style='margin-top: 10px;'>"+
			    				"<a href='"+base+"/attachment/download/"+id+"' style='color: #666666;font-weight: bold;'>"+name+"</a>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;"+
			    				"<img style='vertical-align:middle' src='"+base+"/resource-modality/${themenurl}/sccg.png'>"+
			    				"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/${themenurl}/scsb.png'>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;<a id='"+id+"' class='fileUrl' href='#' style='color:red' onclick='deleteAttac(this)'>删除</a><div>"
			    		);
	    		 		
	    		 	}
	    		 	//放入附件id
	    			var s="";
	    			$(".fileUrl").each(function(){
	    				s=s+$(this).attr("id")+",";
	    			});
	    			$("#storageFiles").val(s);
		       	 	
	    	} else {
	    		alert(data.info);
	    		$('#tdfwxzcdj').append(
    				"<div style='margin-top: 10px;'>"+
    					"<a href='#' style='color: #666666;font-weight: bold;'>"+filename[filename.length-1]+"</a>"+
    					"&nbsp;&nbsp;&nbsp;&nbsp;"+
    					"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/${themenurl}/sccg.png'>"+
    					"<img style='vertical-align:middle' src='"+base+"/resource-modality/${themenurl}/scsb.png'>"+
    					"&nbsp;&nbsp;&nbsp;&nbsp;<a id='fail' class='fileUrl' href='#' style='color:red' onclick='deleteAttac(this)'>删除</a><div>"
    			);
	    	}
	     },
	     error:function(){
	    	 alert('上传失败！');
	     }
    });
}
function StroageIntangibleAddEditForm(){
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);
		$('#StroageIntangibleAddEditForm').form('submit', {
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
						$('#StroageIntangibleAddEditForm').form('clear');
						$("#storage_intangible_dg").datagrid('reload'); 
					}else{
						$.messager.alert('系统提示', data.info, 'error');
					}
				} 
			});		
	}
	function CFFormSS(){
		$("#CF_fFlowStauts").val('1');
		$('#StroageIntangibleAddEditForm').form('submit', {
							
				onSubmit: function(){ 
					flag=$(this).form('enableValidation').form('validate');
					if(flag){
						$.messager.progress();
					}
					return flag;
				}, 
				
				//url:base+'/demo/save',
				data:{'fFlowStauts':'1'},
				success:function(data){
					if(flag){
						$.messager.progress('close');
					}
					data=eval("("+data+")");
					if(data.success){
						$.messager.alert('系统提示', data.info, 'info');
						closeWindow();
						$('#StroageIntangibleAddEditForm').form('clear');
						$("#storage_intangible_dg").datagrid('reload'); 
					}else{
						$.messager.alert('系统提示', data.info, 'error');
						closeWindow();
						$('#StroageIntangibleAddEditForm').form('clear');
					}
				} 
			});		
	}
	
	function fPurchNo_DC(){
		var win=creatFirstWin(' ',800,550,'icon-search','/PurchaseApply/PurchNoList');
		win.window('open');
	}
	function fProCode_DC(){
		var win=creatFirstWin(' ',800,550,'icon-search','/Formulation/fProCode');
		win.window('open');
	}
	function quota_DC(){
		//var node=$('#storage_intangible_dg').datagrid('getSelected');
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
			var selections = $('#storage_intangible_dg').datagrid('getSelections');
				if(confirm("确认删除吗？")){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/Formulation/delete/'+row.fcId,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#storage_intangible_dg").datagrid('reload');
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
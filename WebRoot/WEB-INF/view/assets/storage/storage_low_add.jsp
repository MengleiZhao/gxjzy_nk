<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="StroageLowAddEditForm" action="${base}/Storage/save?fAssType=ZCLX-01" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="fId_S" id="S_fId_S" value="${bean.fId_S}"/>
	    		<c:if test="${bean.fId_S !=null}">
		    		<input type="hidden" name="fAssStorageCode" id="S_fAssStorageCode" value="${bean.fAssStorageCode}"/>
		    		<%-- <input type="hidden" name="fPurchaseDate" id="S_fPurchaseDate" value="${bean.fPurchaseDate}"/>
		    		<input type="hidden" name="fOperator" id="S_fOperator" value="${bean.fOperator}"/> --%>
		    		<input type="hidden" name="fAssStauts" id="S_fAssStauts" value="${bean.fAssStauts}"/>
	    		</c:if>
					<div class="easyui-accordion" style="width:662px;margin-left: 20px;">
							<div title="登记单详情" id="djdxqDiv" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
								<table class="ourtable">
									
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>取得方式</td>
										<td class="td2">
											<input class="easyui-combobox" type="text" id="S_fAcquisitionType" required="required" name="fAcquisitionType" data-options="editable:false,panelHeight:'auto',url:'${base}/Storage/lookupsJson?parentCode=QDFS&selected=${bean.fAcquisitionType}',method:'POST',valueField:'code',textField:'text',editable:false,validType:'selectValid'"  value="${bean.fAcquisitionType}" style="width: 200px"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>取得日期</td>
										<td class="td2">
											<input class="easyui-datebox" class="dfinput" id="S_fAcquisitionDate" required="required" name="fAcquisitionDate"  data-options="validType:'length[1,20]',precision:2" style="width: 200px" value="${bean.fAcquisitionDate}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>资产类型</td>
										<td class="td2">
											<input class="easyui-combobox" readonly="readonly" required="required" class="dfinput" id="S_fAssType" name="fAssType"  data-options="editable:false,panelHeight:'auto',url:'${base}/Storage/lookupsJson?parentCode=ZCLX&selected=${bean.fAssType}',method:'POST',valueField:'code',textField:'text',editable:false,validType:'selectValid'" style="width: 200px" value="${bean.fAssType}"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>采购方式</td>
										<td class="td2">
											<input class="easyui-combobox" type="text" id="S_fBuyType" required="required" name="fBuyType.code"  data-options="editable:false,panelHeight:'auto',url:'${base}/Storage/lookupsJson?parentCode=PURCHASE_METHOD&selected=${bean.fBuyType.code}',method:'POST',valueField:'code',textField:'text',editable:false,validType:'selectValid'" style="width: 200px" value="${bean.fBuyType.code}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>登记人</td>
										<td class="td2">
											<input class="easyui-textbox" type="text" id="S_fOperator" required="required" readonly="readonly" name="fOperator" data-options="validType:'length[1,20]',prompt:''" value="${bean.fOperator}" style="width: 200px"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>登记日期</td>
										<td class="td2">
											<input id="S_fPurchaseDate" class="easyui-datebox" required="required"  value="${bean.fPurchaseDate}" readonly="readonly" name="fPurchaseDate" data-options="validType:'length[1,20]'" style="width: 200px" />					
										</td>
									</tr>
									<tr style="height: 70px;">
										<td class="td1" valign="top">&nbsp;&nbsp;说明</td>
										<td  colspan="4">
											<%-- <input class="easyui-textbox" data-options="validType:'length[1,200]',multiline:true" id="S_fRemark_S" name="fRemark_S" style="width: 568px;height:70px" value="${bean.fRemark_S}">  --%> 
											<!-- <input type="text" id="S_fFlowStauts" name="fFlowStauts" hidden="hidden" value="0"/> -->
											<textarea name="fRemark_S"  id="S_fRemark_S"  class="textbox-text" oninput="textareaNum(this,'textareaNum1')"
											autocomplete="off"  style="width: 568px;height:70px;resize:none">${bean.fRemark_S }</textarea>
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
									<tr class="trbody">
										<td class="td1">
											&nbsp;&nbsp;附件
											<input type="file" multiple="multiple" id="fdzyhpdj" onchange="upladFile(this,'lowdj','zcagl01')" hidden="hidden">
											<input type="text" id="files" name="storageFiles" hidden="hidden">
										</td>
										<td colspan="4" id="tdf">
											<c:if test="${openType=='add'||openType=='edit'}">
											<a onclick="$('#fdzyhpdj').click()" style="font-weight: bold;" href="#">
												<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
											</a>
											</c:if>
											<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
												<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
										 		</div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
											 </div>
											<c:forEach items="${StorageAttaList}" var="att">
												<c:if test="${att.serviceType=='lowdj' }">
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
							<div title="登记资产清单" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
					        		<%@ include file="storage_low_add_plan.jsp" %>
							</div>
						</div>			
			
		
			</div>
			
			<div class="win-left-bottom-div">
				<c:if test="${openType=='add'||openType=='edit'}">
				<a href="javascript:void(0)" onclick="StroageLowAddEditForm();">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
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
    //如果选择‘采购’主管方法会弹出页面，让你选择采购计划
    $('#S_fAcquisitionType').combobox({
    	onChange:function(newValue,oldValue){
    		if(newValue=='QDFS-02'){
    			var win = creatSearchDataWin('采购计划', 970, 590, 'icon-search','/Storage/cgd?type=ZCLX-01&fAcquisitionType='+newValue);
    			win.window('open');
    			//如果不是采购的方式不需要挂接采购单，这由操作人自己添加物品
    			$("#S_fAcquisitionType").combobox('setValue','QDFS-02');
	    		$('#addLowButton').hide();
    		}else {
	    		$('#addLowButton').show();
    		}
    	}
    });
    
	//上传附件
	function storageLow_upFile(obj){
		//创建上传表单
		var files = obj.files;
		var formData = new FormData();
	    for(var i=0; i< files.length; i++){
	  	  formData.append("attFiles",files[i]);   
	  	} 
	    //ajax上传
		$.ajax({  
	    	url: base + '/Storage/uploadAtt?serviceType=lowdj',  
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
					        $('#tdfdzyhpdj').append(
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
		    		$('#tdfdzyhpdj').append(
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
		function StroageLowAddEditForm(){
			//附件的路径地址
			var s="";
			$(".fileUrl").each(function(){
				s=s+$(this).attr("id")+",";
			});
			$("#files").val(s);
			$('#StroageLowAddEditForm').form('submit', {
				onSubmit: function(param){ 
					param.planJson=getPlan();
   					flag=$(this).form('enableValidation').form('validate');
   					if(flag){
   						$.messager.progress();
   					}else {
   						openAccordion();
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
   						$('#StroageLowAddEditForm').form('clear');
   						$("#storage_low_dg").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   					}
   				} 
   			});		
		}
		function CFFormSS(){
			$("#CF_fFlowStauts").val('1');
			$('#StroageLowAddEditForm').form('submit', {
								
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
   						$('#StroageLowAddEditForm').form('clear');
   						$("#storage_low_dg").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   						closeWindow();
   						$('#StroageLowAddEditForm').form('clear');
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
			//var node=$('#storage_low_dg').datagrid('getSelected');
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
				var selections = $('#storage_low_dg').datagrid('getSelections');
					if(confirm("确认删除吗？")){
						$.ajax({ 
							type: 'POST', 
							url: '${base}/Formulation/delete/'+row.fcId,
							dataType: 'json',  
							success: function(data){ 
								if(data.success){
									$.messager.alert('系统提示',data.info,'info');
									$("#storage_low_dg").datagrid('reload');
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
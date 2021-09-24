<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="BAAddForm" action="${base}/AssetBasicInfo/save" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="fAssId" id="ledger_fcId" value="${bean.fAssId}"/>
					<div class="easyui-accordion" style="width:662px;margin-left: 20px;">
							<div title="资产品目" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
								<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>资产编号</td>
										<td  colspan="4">
											<input id="ledger_fAsledger_ode" class="easyui-textbox" type="text" name="fAssCode" data-options="prompt:'',validType:'length[1,20]'" value="${bean.fAssCode}" style="width: 505px;color: #f7f7f7;"/> 
										</td>								
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>资产名称</td>
										<td  colspan="4">
											<input class="easyui-textbox" type="text" id="ledger_fAssName" name="fAssName" required="required" data-options="validType:'length[1,50]'" value="${bean.fAssName}" style="width: 505px"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>资产类型</td>
										<td class="td2">
											<input class="easyui-combobox" id="ledger_fAssType" name="fAssType" style="width: 150px"data-options="editable:false,panelHeight:'auto',url:'${base}/Storage/lookupsJson?parentCode=ZCLX&selected=${bean.fAssType}',method:'POST',valueField:'code',textField:'text',editable:false">
											 <!-- <input name="fAssType" id="ledger_fAssType_H" hidden="hidden">  -->
												<%-- <option value="2" <c:if test="${bean.fcCode=='2' }" >selected="selected"</c:if>>收入合同</option>
												<option value="1" <c:if test="${bean.fcCode=='1' }" >selected="selected"</c:if>>支出合同</option>
												<option value="3"<c:if test="${bean.fcCode=='3' }" >selected="selected"</c:if>>非经济合同</option>
											</select> --%>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>规格型号</td>
										<td class="td2">
											<input id="ledger_fSPModel" class="easyui-textbox" type="text" required="true" name="fSPModel" data-options="validType:'length[1,20]'"  value="${bean.fSPModel}" style="width: 150px"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>计量单位</td>
										<td class="td2">
											<input class="easyui-textbox" type="text" id="ledger_fMeasUnit" name="fMeasUnit" data-options="validType:'length[1,20]'" value="${bean.fMeasUnit}" style="width: 150px"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>库存数量</td>
										<td class="td2">
											<input class="easyui-textbox" type="text" id="ledger_stockNum" name="stockNum" data-options="validType:'length[1,20]'" value="${bean.stockNum}" style="width: 150px"/>
										</td>
									</tr>
									<tr style="height: 70px;">
										<td class="td1" valign="top"><p style="margin-top: 8px">&nbsp;&nbsp;说明</p></td>
										<td  colspan="4">
											<input class="easyui-textbox" data-options="multiline:true" id="CF_fRemark_ABI" name="fRemark_ABI" style="width:505px;height:70px" value="${bean.fRemark_ABI}">  
										</td>
									</tr>
								</table>
							</div>
						</div>			
			
		
			</div>
			
			<div class="win-left-bottom-div">
				<c:if test="${openType=='add'}">
					<a href="javascript:void(0)" onclick="BAAddForm();">
						<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</c:if>
				&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
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
    $('#ledger_fcType').combobox({  
        onChange:function(newValue,oldValue){  
    	var sel2=$('#ledger_fcType').combobox('getValue');
    	if(sel2!="HTFL-01"){
    		$('#cg1').hide();
    		$('#cg2').hide();
    		//$('#cg2').hide();
    		//$('#F_fPurchNo').next(".textbox").show();
		}else{
    		$('#cg1').show();
    		$('#cg2').show();
    		//$('#cg2').show();
    		//$('#F_fPurchNo').next(".textbox").hide();
		} 
        }
    }); 
   /*  function getFilePath(){  
        var input = document.getElementById("CF_file");
    	if(input){//input是<input type="file">Dom对象  
            if(window.navigator.userAgent.indexOf("MSIE")>=1){  //如果是IE    
                input.select();      
              return document.selection.createRange().text;      
            }      
            else if(window.navigator.userAgent.indexOf("Firefox")>=1){  //如果是火狐  {      
                if(input.files){      
                    return input.files.item(0).getAsDataURL();      
                }      
                return input.value;      
            }      
            return input.value;   
        }  
    }   */
		//baocun
		function BAAddForm(){
			/* var fcType=$("#ledger_fAssType").val();
			console.log(fcType)
			if(fcType=="ZCLX-01"){
				$("#ledger_fAssType_H").val("1");
			}else if(fcType=="ZCLX-02"){
				$("#ledger_fAssType_H").val("2");
			}else if(fcType=="ZCLX-03"){
				$("#ledger_fAssType_H").val("3");
			} */
	    	/* //附件的路径地址
			var s="";
			$(".fileUrl").each(function(){
				s=s+$(this).attr("id")+",";
			});
			$("#files").val(s); */
    		$('#BAAddForm').form('submit', {
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
   						closeFirstWindow();
   						$('#BAAddForm').form('clear');
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   					}
   				} 
   			});		
		}
		function CFFormSS(){
			$("#CF_fFlowStauts").val('1');
			var s="";
			$(".fileUrl").each(function(){
				s=s+$(this).attr("id")+",";
			});
			$("#files").val(s);  
			$('#BAAddForm').form('submit', {
								
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
   						closeFirstWindow();
   						$('#BAAddForm').form('clear');
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   						closeFirstWindow();
   						$('#BAAddForm').form('clear');
   					}
   				} 
   			});		
		}
		
		function fPurchNo_DC(){
			var win=creatFirstWin(' ',840,450,'icon-search','/PurchaseApply/PurchNoList');
			win.window('open');
		}
		function fProCode_DC(){
			var win=creatFirstWin(' ',800,550,'icon-search','/Formulation/fProCode');
			win.window('open');
		}
		function quota_DC(){
			//var node=$('#CF_dg').datagrid('getSelected');
			var win=creatFirstWin('选择-预算指标编号',750,550,'icon-add','/BudgetIndexMgr/contract_list');
			win.window('open');
		}
	var c=0;
	//附件上传
	function upFile() {
		var url = $("#f").val();
		var urlli = url.split(',');
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
		        url:base+"/Formulation/formulationFile?fileurl="+fileurl,
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
		filename = encodeURI(encodeURI(filename));  
		$.ajax({
			type:"POST",
	        url:base+"/Formulation/formulationFileDelete?filename="+filename,
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
	
	var c1 =0;
	function upFile1() {
		c1 ++;
		var src = $('#a_fFileSrc1').val();
		$('#fi1').val(src);
		$('#f_a_f1').append("<div id='c1"+c1+"'><a href='#' style='color: #3f7f7f;font-weight: bold;'>"+src+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a style='color: red;' href='#' onclick='deleteF1(c1"+c1+")'>删除</a></div>");
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
			var row = $('#CF_dg').datagrid('getSelected');
			var selections = $('#CF_dg').datagrid('getSelections');
				if(confirm("确认删除吗？")){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/Formulation/delete/'+row.fcId,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#CF_dg").datagrid('reload');
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
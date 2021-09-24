<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
<style type="text/css">
.textbox-text:read-only{background-color: #f6f6f6;color: #999999} 
.textbox-readonly{background-color: #f6f6f6;color: #999999}
.textbox-text{color:#666666;height: 25px; line-height: 25px}
.style1{color: red;height: 40px;}
.numberbox .textbox-text {text-align: left;}
.tabDiv{padding:10px;}
.ourtable{font-size: 12px;width: 550px;color: #666666;font-family: "微软雅黑"}
.ourtable2{font-size: 12px;color: #666666;font-family: "微软雅黑"}
.td1{width: 100px;}
.td2{height: 30px;width: 150px;}
.trtop{height: 10px;}
.trbody{height: 30px;}

</style>  
	<script type="text/javascript">
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
		function YBAddEditForm(){
			/* //附件的路径地址
			var s="";
			$(".fileUrl").each(function(){
				s=s+$(this).attr("id")+",";
			});
			$("#files").val(s); */
			$('#YBAddEditForm').form('submit', {
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
   						$('#YBAddEditForm').form('clear');
   						$("#yb_dg").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   					}
   				} 
   			});		
		}
		function copyForm(){
			var yearId=$('#YB_fbId').val()
			console.log(yearId)
			$('#YBAddEditForm').form('submit', {
				onSubmit: function(){ 
   					flag=$(this).form('enableValidation').form('validate');
   					if(flag){
   						$.messager.progress();
   					}
   					return flag;
   				}, 
   				url:base+'/accoYear/copyYears/'+yearId, 
   				success:function(data){
   					if(flag){
   						$.messager.progress('close');
   					}
   					data=eval("("+data+")");
   					if(data.success){
   						$.messager.alert('系统提示', data.info, 'info');
   						closeWindow();
   						$('#YBAddEditForm').form('clear');
   						$("#yb_dg").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   					}
   				} 
   			});		
		}
		function AllocsFormSS(){
			$("#A_fFlowStauts").val("1");
			$('#YBAddEditForm').form('submit', {
								
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
   						$('#YBAddEditForm').form('clear');
   						$("#yb_dg").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   						$('#YBAddEditForm').form('clear');
   					}
   				} 
   			});		
		}
		
		function fReceCode(){
			var win=creatFirstWin('原配置单号',840,450,'icon-search','/Alloca/receCodeList');
			win.window('open');
		}
		function fTransUser(){
			var win=creatFirstWin('姓名部门',840,450,'icon-search','/Alloca/nameAndDept');
			win.window('open');
		}
		function quota_DC(){
			//var node=$('#yb_dg').datagrid('getSelected');
			var win=creatFirstWin('选择-预算指标编号',750,550,'icon-add','/BudgetIndexMgr/contract_list');
			win.window('open');
		}
		
		
	</script>
    <div class="easyui-layout" fit="true" style="color: #333333">
   		<div data-options="region:'west',split:true"style="width:600px;border-color: dce5e9" id="westDiv">
	    	<form id="YBAddEditForm" action="${base}/accoYear/save" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	    		<input type="hidden" name="fbId" id="YB_fbId" value="${bean.fbId}"/>
				<table >
				<tr>
					<td >
						<div class="easyui-accordion" style="width:555px;margin-left: 20px;">
								<table class="ourtable" cellpadding="0" cellspacing="0">
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>模板名称(年份)</td>
										<td class="td2">
											<input class="easyui-textbox" id="YB_ftName" name="ftName"  data-options="validType:'length[1,20]'" style="width: 150px;height:25px" value="${bean.ftName }"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>期次维度</td>
										<td class="td2">
											<input class="easyui-numberbox"  id="YB_fPeriod" name="fPeriod"  data-options="validType:'length[1,20]'" style="width: 150px;height:25px" value="${bean.fPeriod}"/>
										</td>
									</tr>
									<tr  style="height: 70px;">
										<td class="td1" valign="top"><p style="margin-top: 8px">&nbsp;&nbsp;备注</p></td>
										<td  colspan="4">
											<textarea name="fRemark"  id="YB_fRemark"  class="textbox-text"  oninput="textareaNum(this,'textareaNum1')" autocomplete="off"   style="width:450px;height:70px;resize:none">${bean.fRemark }</textarea> 
											<%-- <input class="easyui-textbox" data-options="multiline:true" id="YB_fRemark" data-options="validType:'length[0,200]'"  name="fRemark" style="width: 450px;height:70px" value="${bean.fRemark}">  
										 --%>
										</td>
									</tr>
									<tr>
										<td align="right" colspan="5" style="padding-right: 0px;">
										可输入剩余数：<span id="textareaNum1" class="200">
											<c:if test="${empty bean.fRemark}">200</c:if>
											<c:if test="${!empty bean.fRemark}">${200-bean.fRemark.length()}</c:if>
										</span>
										</td>
									</tr>	
								</table>	
						</div>
					</td>
				</tr>
				</table>
				</div>
			<div data-options="region:'south'" style="height: 51px;width: 100%; border: 0px;">
					<div style="text-align: center;">
						<c:if test="${openType=='add'}">
							<a href="javascript:void(0)" onclick="YBAddEditForm()">
								<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>&nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${openType=='edit'}">
							<a href="javascript:void(0)" onclick="YBAddEditForm()">
								<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>&nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${openType=='copymodel'}">
							<a href="javascript:void(0)" onclick="copyForm()">
								<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>&nbsp;&nbsp;&nbsp;
						</c:if>
						<a href="javascript:void(0)" onclick="closeWindow()">
							<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</div>
			</div>
			</form>
	</div>
	<script type="text/javascript">
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
			var selections = $('#yb_dg').datagrid('getSelections');
				if(confirm("确认删除吗？")){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/Formulation/delete/'+row.fcId,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#yb_dg").datagrid('reload');
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
</html>


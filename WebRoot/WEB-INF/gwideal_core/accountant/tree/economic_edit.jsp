<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="economicAddEditForm" action="${base}/accoTree/update" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 309px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div" style="height: 200px">
				<div class="easyui-accordion" style="width:662px;margin-left: 20px;">
					<div title="经济科目" id="djdxqDiv" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
						<table class="ourtable">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>科目编号</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" onchange="EL()" id="economic_code" required="required"  name="code" data-options="validType:'length[1,20]'"style="width: 200px" value="${bean.code}"/>
								</td>
								<td class="td4">
									<input type="hidden" class="easyui-textbox" name="fid" id="economic_id" value="${bean.fid}"/>
			    					<input type="hidden" class="easyui-textbox" name="fYBId" id="economic_fYBId" value="${bean.fYBId}"/>
								</td>
								<td class="td1"><span class="style1">*</span>科目名称</td>
								<td class="td2">
									<input id="economic_name" class="easyui-textbox" required="required" name="name" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.name}"/>					
								</td>
							</tr>			
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>科目级别</td>
								<td class="td2">
									<input id="economic_leve" <c:if test="${openType=='edit'}">readonly="readonly"</c:if> name="leve" style="width: 200px;" value="${bean.leve}" data-options="url:'${base}/accoTree/lookupsJson?parentCode=KMJB&selected=${bean.leve}',method:'POST',valueField:'code',textField:'text',editable:false,validType:'selectValid'" class="easyui-combobox">
								</td>
								<td class="td4">&nbsp;</td>
								<td class="td1"><span class="style1">*</span>上级科目编号</td>
								<td class="td2">
									<input class="easyui-textbox" style="width: 200px" type="text" id="economic_id" name="pid" <c:if test="${openType=='edit'}">readonly="readonly"</c:if> required="required" data-options="validType:'length[1,50]'"value="${bean.pid}"/>
								</td>
							</tr>			
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>科目类型</td>
								<td class="td2">
									<input class="easyui-combobox" id="economic_type" <c:if test="${openType=='edit'}">readonly="readonly"</c:if> name="type" value="${bean.type}" style="width: 200px;" data-options="url:'${base}/accoTree/lookupsJson?parentCode=KMLX&selected=${bean.type}',method:'POST',valueField:'code',textField:'text',editable:false,validType:'selectValid'" class="easyui-combobox">
								</td>
								<td class="td4">&nbsp;</td>
								<td class="td1"><span class="style1">*</span>是否启用</td>
								<td class="td2">
									<select class="easyui-combobox" id="economic_on" <c:if test="${openType=='edit'}">readonly="readonly"</c:if> name="on" value="${bean.on}" style="width: 200px;" data-options="editable:false,panelHeight:'auto'">
										<option value="1">启用</option>
										<option value="2">停用</option>
									</select>
								</td>
							</tr>			
				
						</table>
					</div>
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="economicAddEditForm()">
				<img src="${base}/resource-modality/img/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/img/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
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
	
		function economicAddEditForm(){
			if('#')
			$('#economicAddEditForm').form('submit', {
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
   					data=eval("("+data+")");
   					if(data.success){
   						$.messager.alert('系统提示', data.info, 'info');
   						closeWindow();
   						$('#economicAddEditForm').form('clear');
   						$("#Economic_dg").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   						closeWindow();
   						$('#economicAddEditForm').form('clear');
   					}
   				} 
   			});		
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
											"</div>")
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
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
	<script type="text/javascript">
		function userAddEditForm(){
			var flag=false;
			if(!checkMobileNo()){
				return;
			}
			//校验部门
			var departId = $('#departId').val();
			if(departId == '' || departId == undefined){
				alert('请选择部门！');
				return;
			}
			$('#userAddEditForm').form('submit', {
				onSubmit: function(){ 
					flag=$(this).form('enableValidation').form('validate');
					if(flag){
						$.messager.progress();
					}
					return flag;
				}, 
				dataType:'json',
				success:function(data){
					if(flag){
						$.messager.progress('close');
					}
					var data = eval('(' + data + ')');
					if(data.success){
						$.messager.alert('系统提示',data.info,'info');
						closeWindow();
						$('#userAddEditForm').form('clear');
						$("#user_dg").datagrid('reload');
					}else{
						$.messager.alert('系统提示',data.info,'error');
						closeWindow();
						$('#userAddEditForm').form('clear');
					}
				} 
			});
		}
	</script>
    <div class="easyui-layout" fit="true">
    	<div region="center" border="false" style="margin-top: 5px;">
	    	<form id="userAddEditForm" action="${base}/user/save" method="post" data-options="novalidate:true" class="easyui-form">
	    		<input type="hidden" name="id" id="user_edit_id" value="${bean.id}"/>
	    		<c:if test="${fn:length(bean.id)>0}">
	    			<input type="hidden" name="islocked" value="${bean.islocked}"/>
	    			<%-- <input type="hidden" name="status" value="${bean.status}"/> --%>
	    		</c:if>
				<table border="0" cellpadding="0" cellspacing="0" class="main_table">
					<c:if test="${fn:length(bean.id)>0}">
						<tr>
							<th class="td1"><span style="color: red;">*</span>&nbsp;帐号</th>
							<td class="td2">
								<input class="easyui-textbox" type="text" name="accountNo" data-options="required:true,validType:'length[1,20]'" style="width: 200px" value="${bean.accountNo}"/>
								<input type="hidden" name="password" value="${bean.password}"/>
							</td>
							<td class="td3-ys"></td>
							<th class="td1"><span style="color: red;">*</span>&nbsp;修改密码</th>
							<td class="td2">
								<span>见重置按钮</span>
							</td>
						</tr>
						<tr style="height: 5px;"></tr>
					</c:if>
					<c:if test="${fn:length(bean.id)==0}">
						<tr>
							<th class="td1"><span style="color: red;">*</span>&nbsp;账号</th>
							<td class="td2">
								<input class="easyui-textbox" type="text" name="accountNo" data-options="required:true,validType:'length[1,20]'" style="width: 200px" value="${bean.accountNo}"/>
							</td>
							<td class="td3-ys"></td>
							<th class="td1"><span style="color: red;">*</span>&nbsp;初始密码</th>
							<td class="td2">
								<input class="easyui-textbox" type="text" readonly="readonly" name="password" data-options="required:true,validType:'length[1,20]'" style="width: 200px" value="123456"/>
							</td>
						</tr>
						<tr style="height: 5px;"></tr>
					</c:if>
					<tr>
						<th class="td1"><span style="color: red;">*</span>&nbsp;姓名</th>
						<td class="td2">
							<input class="easyui-textbox" type="text" name="name" data-options="required:true,validType:'length[1,50]'" style="width: 200px" value="${bean.name}"/>
						</td>
						<%-- <th class="td1">&nbsp;&nbsp;是否为责任人</th>
						<td class="td2">
							<select class="easyui-combobox" name="isPersonLiable" style="width: 200px;" data-options="editable:false,panelHeight:'auto'">
								<option value="0" <c:if test="${bean.isPersonLiable=='0'}">selected="selected"</c:if>>否</option>
								<option value="1" <c:if test="${bean.isPersonLiable=='1'}">selected="selected"</c:if>>是</option>
							</select>
						</td> --%>
						<td class="td3-ys"></td>
						<th class="td1"><span style="color: red;">*</span>&nbsp;部门</th>
						<td class="td2">
						  	<c:if test="${fn:length(bean.id)==0}">
						  	<div style="width:243px; height:32px;">
                          	<div id="user_depart" style="float: left; width:198px; height:30px; overflow-x:hidden; border: 1px solid #D4D4D4;margin-left: 0px;" ></div>
          			        <input type="button" value="选" class="button_blue" style="float:right; width:32px;height:32px;margin-left: 5px" onclick="departSelect('yhbm')"/>
          			        </div>
						  	</c:if>
						  
						 	<c:if test="${fn:length(bean.id)>0}">
						   	<div id="user_depart" style="float: left; width:198px; height:30px; overflow-x:hidden; border: 1px solid #D4D4D4;margin-left: 0px;" >
                                       
		          				<div style='float:left;margin-left:8px;margin-top:8px;' >
		          					<input type='hidden' name='depart.id' id='departId' value='${bean.depart.id}'/>
		          					<c:if test="${fn:length(bean.depart.name)>8}">
		          					<span title="${bean.depart.name}">${fn:substring(bean.depart.name,0,8)}...</span>
		          					</c:if>
		          					<c:if test="${fn:length(bean.depart.name)<=8}">
		          					<span title="${bean.depart.name}">${bean.depart.name}</span>
		          					</c:if>
		          					<c:if test="${bean.depart.name!=null}">
		          					<img src='${base}/resource/images/cancelDepart.jpg' style='cursor:pointer;margin-left:5px;height:15px;width:15px;' onclick = 'cancelUserDepart(this)' title='删除' id='${bean.depart.id}'/>
		          				    </c:if>
		          				</div>
	         			    </div>
						    <input type="button" value="选" class="button_blue" style="width:32px;height:32px;position: absolute;margin-left: 5px" onclick="departSelect('yhbm')"/>
							</c:if>
						</td>
					</tr>
					<tr style="height: 5px;"></tr>
					<tr>
						<th class="td1"><span style="color: red;">*</span>&nbsp;在岗状态</th>
						<td class="td2">
							<select class="easyui-combobox" name="status" style="width: 200px;" data-options="required:true,editable:false,panelHeight:'auto'">
								<option value="1" <c:if test="${bean.status=='1'}">selected="selected"</c:if>>在岗</option>
								<option value="0" <c:if test="${bean.status=='0'}">selected="selected"</c:if>>离岗</option>
							</select>
						</td>
						<td class="td3-ys">
							<input type="hidden" id="roleslevel" name="roleslevel" value="${bean.roleslevel}" />
						</td>
						<th class="td1">&nbsp;&nbsp;职务</th>
						<td class="td2">
							<select class="easyui-combobox" name="post" style="width: 200px;" data-options="required:true,editable:false,panelHeight:'auto',onSelect:onSelectPost">
								<option value="厅级人员" <c:if test="${bean.post=='厅级人员'}">selected="selected"</c:if>>厅级人员</option>
								<option value="其他人员" <c:if test="${bean.post=='其他人员'}">selected="selected"</c:if>>其他人员</option>
							</select>
						</td>
					</tr>
					<tr style="height: 5px;"></tr>
					<tr>
						<th class="td1">&nbsp;&nbsp;手机号码</th>
						<td class="td2">
							<input id="user_edit_mobileNo" class="easyui-textbox" type="text" name="mobileNo" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.mobileNo}"/>
						</td>
						<td class="td3-ys"></td>
						<th class="td1">&nbsp;&nbsp;电话号码</th>
						<td class="td2">
							<input class="easyui-textbox" type="text" name="telNo" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.telNo}"/>
						</td>
					</tr>
					<tr style="height: 5px;"></tr>
					<tr>
						<th class="td1">&nbsp;&nbsp;传真号码</th>
						<td class="td2">
							<input class="easyui-textbox" type="text" name="faxNo" data-options="validType:'length[1,50]'" style="width: 200px" value="${bean.faxNo}"/>
						</td>
						<td class="td3-ys"></td>
						<th class="td1">&nbsp;&nbsp;邮箱</th>
						<td class="td2">
							<input class="easyui-textbox" type="text" name="email" data-options="validType:'length[1,50]'" style="width: 200px" value="${bean.email}"/>
						</td>
					</tr>
					<tr style="height: 5px;"></tr>
					<tr>
						<th class="td1">&nbsp;&nbsp;邮编</th>
						<td class="td2">
							<input class="easyui-textbox" type="text" name="postalCode" data-options="validType:'length[1,50]'" style="width: 200px" value="${bean.postalCode}"/>
						</td>
						<td class="td3-ys"></td>
						<td class="td3-ys"></td>
					</tr>
					<tr style="height: 5px;"></tr>
					<tr>
						<th class="td1">&nbsp;&nbsp;地址</th>
						<td class="td2" colspan="4">
							<input class="easyui-textbox" type="text" name="address" data-options="validType:'length[1,50]'" style="width: 513px" value="${bean.address}"/>
						</td>
					</tr>
					<tr style="height: 5px;"></tr>
					<tr>
						<th class="td1">公用角色</th>
						<td class="td2" colspan="4">
							<table  style="border: 1px solid #D9E3E7;border-radius: 4px;">
								<tr>
								<c:forEach items="${listRole}" var="role" varStatus="s">
									<td>
										<c:set var="checked" value="false"/>
										<c:forEach items="${bean.roles}" var="r">
											<c:if test="${r.id==role.id}">
												<c:set var="checked" value="true"/>		
											</c:if>
										</c:forEach>
										<input type="checkbox" name="roleIds" value="${role.id}" <c:if test="${checked=='true'}">checked="checked"</c:if>/>&nbsp;${role.name}&nbsp;
									</td>
									<c:if test="${ s.count%5==0 && s.count!=0 }">      
							        <tr></tr>
							    	</c:if>
								</c:forEach>
								<tr>
							</table>
						</td>
					</tr>
					<tr style="height: 5px;"></tr>
					<tr>
						<th class="td1">部门角色</th>
						<td class="td2" colspan="4">
							<table id="departmentRoleId"  style="border: 1px solid #D9E3E7;border-radius: 4px;width: 513px;height: 20px">
							</table>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div region="south" border="false" class="south" top="385px;" align="center">
			<a href="javascript:void(0)" onclick="userAddEditForm();">
				<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
			<a href="javascript:void(0)" onclick="closeWindow();">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
		</div>
	</div>
	<script type="text/javascript">
	
	
		 var as ='${bean.depart.id}';
		 var type = '${type}';
		 if(type=="edit"){
		 departmentRole(as);
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
										"<input type='hidden' name='depart.id' id='departId' value='"+str1[0]+"'/>"+
										"<span title='"+str1[1]+"'>"+((str1[1].length>8)?str1[1].substring(0,8)+"...":str1[1])+"</span>"+
										"<img src='${base}/resource/images/cancelDepart.jpg' style='cursor:pointer;margin-left:5px;height:15px;width:15px;' onclick = 'cancelUserDepart(this)' title='删除' id='"+str1[0]+"'/>"+
										"</div>")
							$("#departmentRoleId").empty();
		       				departmentRole(str1[0]);
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
		
		
		function departmentRole(departId){
			$.ajax({
				url: base+ "/user/getDepartmentRole?departId="+departId+"",
				type : 'post',
				async : true,
				dataType:'json',
			    contentType:'application/json;charset=UTF-8',
				success : function(json) {
					var s = '${beans}';
					 var str= new Array(); 
			       	str=s.split(",");
					var html = "";
					html +="<tr>";
					html +="<td>";
					for(var i=0;i<json.length;i++){
						var checked = "";	
						for(var j=0;j<str.length;j++){
							if(str[j]==json[i].id){
								 checked = "true";
								 break;
							}
						}
					if(checked == "true"){
						html +="<input type=\"checkbox\" name=\"roleIds\" value=\""+json[i].id+"\" checked=\"checked\"/>&nbsp;"+json[i].name+"&nbsp;";
					}else{
						html +="<input type=\"checkbox\" name=\"roleIds\" value=\""+json[i].id+"\"/>&nbsp;"+json[i].name+"&nbsp;";
					}
				}
						html +="<td>";
						html +="<tr>";
					$("#departmentRoleId").append(html);
			}
			    });
		}
		
		function onSelectPost(rec){
			if(rec.text=="其他人员"){
				$("#roleslevel").val(3);
			}
			if(rec.text=="厅级人员"){
				$("#roleslevel").val(2);
			}
		}
	</script>
</body>
</html>


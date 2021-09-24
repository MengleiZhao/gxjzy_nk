<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="economicAddEditForm" action="${base}/yearsUnionBasic/ecBasicOrDepartSave" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
		<input type="hidden" id="funcIds" name="funcIds" value=""/>
		<input type="hidden" id="pId" name="pId" value="${departId }"/>
	<div class="easyui-layout" style="height: 500px;">
		<div class="win-left-div" data-options="region:'west',split:true" style="overflow: hidden;">
			<div class="win-left-top-div" style="height: 460px;overflow-x: hidden;overflow-y: auto;">
				<div class="easyui-accordion" style="width:662px;margin-left: 20px;">
					<div title="经济科目" id="djdxqDiv" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow: hidden;margin-top:10px;">
						<div>二级分类</div>
						<table style="width:662px;height: 400px">
						<tr >
							<c:forEach items="${proMgrLevel2}" var="pro" varStatus="s">
								<td style="height: 10px">
									<c:set var="checked" value="false"/>
									<c:forEach items="${departEconomicList}" var="de">
										<c:if test="${de.fEjProCode==pro.fLevCode2}">
											<c:set var="checked" value="true"/>		
										</c:if>
									</c:forEach>
									<input type="checkbox" name="fEjProCode" value="${pro.fLevCode2}" <c:if test="${checked=='true'}">checked="checked"</c:if>/>&nbsp;${pro.fLevName2}&nbsp;
									<input type="hidden" name="fEjProName" value="${pro.fLevName2}" <c:if test="${checked=='true'}">checked="checked"</c:if>/>
									<input type="hidden" name="funcIds" value="${pro.fLvId2}" <c:if test="${checked=='true'}">checked="checked"</c:if>/>
								</td>
								<c:if test="${ s.count%6==0 && s.count!=0 }">      
							        <tr style="height: 10px"></tr>
							    	</c:if>
							</c:forEach>
						<tr>
						</table>
						<%-- <div data-options="region:'west',split:false"  style="width:200px;" >
							<ul id="EconomicTrees" class="easyui-tree" data-options="url:'${base}/yearsUnionBasic/economicAddDepartTree?departId=${departId }',checkbox:true,animate:true,lines:true,onCheck:checkTreeMethods,cascadeCheck:false" ></ul>
						</div> --%>
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
			
			//将功能树选中的值设置到隐藏文本上
			/* var nodes = $('#EconomicTrees').tree('getChecked');
			var fIds = '';
			for(var i=0; i<nodes.length;i++){
				if(nodes[i].code!=null){
					nodes[i].remove;
				}else{
				if (fIds!='') fIds+=',';
				fIds+= nodes[i].id;
				}
			}
			$('#funcIds').val(fIds); */
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
			
			//获取父节点
			function getParentNode(parentNode,isFlag){
				if(isFlag){
					//设置节点属性为选中
					parentNode.checkState= "checked";
					parentNode.checked= true;
					//设置勾选样式
					$('#'+parentNode.domId+'').find(".tree-checkbox").removeClass("tree-checkbox0").addClass("tree-checkbox1");
				}else{
					//循环父节点下是否有子节点选中
					forParentCheckMethod(parentNode,isFlag);
				}
				parentNode = $('#EconomicTrees').tree('getParent',parentNode.target);
				if(parentNode!=null){
					getParentNode(parentNode,isFlag);
				}
			}
			//循环父节点下是否有子节点选中
			function forParentCheckMethod(parentNode,isFlag){
				//获取子节点
				var childRows = $('#EconomicTrees').tree('getChildren',parentNode.target);
				var state=null;
				var type=null;
				var num=0;	//节点选中的数量
				if(!isFlag){
					if(childRows!=undefined && childRows.length>0){
						for(var i=0;i<childRows.length;i++){
							state=childRows[i].checkState;
							type=childRows[i].checked;
							if(state=='checked' && type==true){
								num++;
								if(num>1){	//有多个节点选中
									break;
								}
							}
						}
						if(num==0){	//没有其它节点选中 ，清除选中样式
							parentNode.checkState= "unchecked";
							parentNode.checked= false;
							$('#'+parentNode.domId+'').find(".tree-checkbox").removeClass("tree-checkbox1").addClass("tree-checkbox0");
						}
					}else{
						$('#'+parentNode.domId+'').find(".tree-checkbox").removeClass("tree-checkbox1").addClass("tree-checkbox0");
					}
				}
			}
			//循环子节点
			function forChildrenMethod(isFlag,childRows){
				if(childRows!=undefined && childRows.length>0){
					for(var i=0;i<childRows.length;i++){
						$('#EconomicTrees').tree(isFlag, childRows[i].target);
					}
				}
			}
			//复选框选中事件
			function checkTreeMethods(node,checked){
					//获取父节点
					var parentNode = $('#EconomicTrees').tree('getParent',node.target);
					//获取子节点
					var childRows = $('#EconomicTrees').tree('getChildren',node.target);
					if(parentNode!=null){
						if(checked){
							//选中
							forChildrenMethod('check',childRows);
						}else{
							forChildrenMethod('uncheck',childRows);
						}
						//父节点处理
						getParentNode(parentNode,checked);
					}else{
						if(checked){
							//选中
							forChildrenMethod('check',childRows);
						}else{
							forChildrenMethod('uncheck',childRows);
						}
					}
			}
	</script>
</body>
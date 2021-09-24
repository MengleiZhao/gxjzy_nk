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
	var names = new Array();
		function departEditForm(){
			//校验
			if ($('#depart_edit_type').combobox('getValue')=='') {
				alert('请选择类型！');
				return;
			}
			//form 提交
			var flag=false;
			$('#departEditForm').form('submit', {
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
						$('#departEditForm').form('clear');
						$("#depart_dg").datagrid('reload');
					}else{
						$.messager.alert('系统提示',data.info,'error');
						closeWindow();
						$('#departEditForm').form('clear');
					}
				} 
			});
		}
		
		function departOneselfSelect(selectType){
			var win=creatSearchDataWin('新增-部门',600,300,'icon-add',"/depart/refOneselfDepart/"+selectType);
		    win.window('open');
		}
		
		function departOneselfReturnSelect(ret){
			if (ret == "clear") {
		       $("#div_depart_oneself").html("");
			}

		    if (ret!="&&&&" && ret != undefined && ret != null && ret.indexOf("&&") != -1 && ret != "cancel") {
		    	var retArray = ret.split("&&");
		        var str= new Array(); 
		       	str=retArray[2].split(","); 
		       	for(var i=0;i<str.length-1 ;i++){
		       		if(null!=str[i]){
		       			var str1= new Array();
		       			str1=str[i].split(":");
		       			var div1 = $("#div_depart_oneself");
		       			if(!isDepartOneselfTreeExist(str1[0]) && !isDepartOneselfTreeExist(str1[1])){
							names.push(str1[0]);	
							div1.html("<div  style='float:left;margin-left:8px;margin-top:8px;' > "+
										"<input type='hidden' name='parent.id' value='"+str1[0]+"'/>"+
										""+str1[1]+""+
										"<img src='${base}/resource/images/cancelDepart.jpg' style='cursor:pointer;margin-left:5px;height:15px;width:15px;' onclick = 'cancelDepartOneself(this)' title='删除' id='"+str1[0]+"'/>"+
										"</div>")
						}
		       		}
		       	}
		    }
		}
		function isDepartOneselfTreeExist(name){
			for(var i=0; i<names.length; i++){
				if(names[i] == name){
					return true;
				}
			}
			return false;
		}
		
		function cancelDepartOneself(obj){
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
		
		//选择主管领导
		function chooseMgr(){
			var win = creatFirstWin('选择-主管领导', 840, 580, 'icon-search', '/depart/chooseUser');
			win.window('open');
		}
	</script>
    <div class="easyui-layout" fit="true">
    	<div region="center" border="false" style="margin-top: 5px;">
	    	<form id="departEditForm" action="${base}/depart/save" method="post" data-options="novalidate:true" class="easyui-form">
	    		<input type="hidden" name="id" value="${bean.id}"/>
				<table border="0" cellpadding="0" cellspacing="0" class="main_table">
					<tr>
						<th class="td1"><span style="color: red;">*</span>&nbsp;部门代码</th>
						<td class="td2">
							<input class="easyui-textbox" type="text" name="code" data-options="required:true,validType:'length[1,50]'" style="width: 200px" value="${bean.code}"/>
						</td>
						<th class="td1"><span style="color: red;">*</span>&nbsp;类型</th>
						<td class="td2">
							<select id="depart_edit_type" class="easyui-combobox" style="width: 200px" name="type" 
								data-options="required:true,editable:false">
								<option value="">-请选择-</option>
								<option value="COMPANY" <c:if test="${bean.type=='COMPANY' }">selected="selected"</c:if> >单位</option>
								<option value="DEPART" <c:if test="${bean.type=='DEPART' }">selected="selected"</c:if> >部门</option>
							</select>
						</td>
					</tr>
					<tr style="height: 5px;"></tr>
					<tr>
						<th class="td1"><span style="color: red;">*</span>&nbsp;部门名称</th>
						<td class="td2">
							<input class="easyui-textbox" type="text" name="name" data-options="required:true,validType:'length[1,50]'" style="width: 200px" value="${bean.name}"/>
						</td>
						<th class="td1">&nbsp;&nbsp;上级部门名称</th>
						<td class="td2">
	                      <c:if test="${fn:length(bean.id)==0}">
	                        
	                        <c:if test="${depart.id==null}">
                          		<div id="div_depart_oneself" style="float: left; width:198px; height:30px; overflow-x:hidden; border: 1px solid #D4D4D4;margin-left: 0px;" ></div>
          			        	<input type="button" value="选" class="button_blue" style="width:32px;height:32px;position: absolute;margin-left: 5px" onclick="departOneselfSelect('bmlxbm')"/>
						    </c:if>
						    <c:if test="${depart.id!=null}">
                          		<div id="div_depart_oneself" style="float: left; width:198px; height:30px; overflow-x:hidden; border: 1px solid #D4D4D4;margin-left: 0px;" >           
		          				<div style='float:left;margin-left:8px;margin-top:8px;' >
		          				    <input type='hidden' name='parent.id'  value='${depart.id}'/>
		          				    ${depart.name}
		          					<img src='${base}/resource/images/cancelDepart.jpg' style='cursor:pointer;margin-left:5px;height:15px;width:15px;' onclick = 'cancelDepartOneself(this)' title='删除' id='${depart.id}'/>
		          				</div>
	         			        </div>
						      <input type="button" value="选" class="button_blue" style="width:32px;height:32px;position: absolute;margin-left: 5px" onclick="departOneselfSelect('bmlxbm')"/>
						    </c:if>
						  </c:if>
						  
						  <c:if test="${fn:length(bean.id)>0}">
						        <div id="div_depart_oneself" style="float: left; width:198px; height:30px; overflow-x:hidden; border: 1px solid #D4D4D4;margin-left: 0px;" >           
		          				<div style='float:left;margin-left:8px;margin-top:8px;' >
		          				    <input type='hidden' name='parent.id'  value='${bean.parent.id}'/>
		          				    ${bean.parent.name}
		          				    <c:if test="${bean.parent.id!=null}">
		          					<img src='${base}/resource/images/cancelDepart.jpg' style='cursor:pointer;margin-left:5px;height:15px;width:15px;' onclick = 'cancelDepartOneself(this)' title='删除' id='${bean.parent.id}'/>
		          				    </c:if>
		          				</div>
	         			        </div>
						      <input type="button" value="选" class="button_blue" style="width:32px;height:32px;position: absolute;margin-left: 5px" onclick="departOneselfSelect('bmlxbm')"/>
						  </c:if>
						</td>
					</tr>
					<tr style="height: 5px;"></tr>
					<tr>
						<th class="td1">&nbsp;&nbsp;主管领导</th>
						<td class="td2" onclick="chooseMgr()">
							<input id="depart_add_mgrName" class="easyui-textbox" data-options="" style="width: 200px" value="${bean.manager.name}"/>
							<input id="depart_add_mgrId" name="manager.id" type="hidden" value="${bean.manager.name}"/>
						</td>
						<th class="td1"><span style="color: red;">*</span>&nbsp;排列顺序</th>
						<td class="td2">
							<input class="easyui-textbox" type="text" name="orderNo" data-options="required:true,validType:'length[1,10]'" style="width: 200px" value="${bean.orderNo}"/>
						</td>
					</tr>
					<tr style="height: 5px;"></tr>
					<tr>
						<th class="td1">&nbsp;&nbsp;说明</th>
						<td class="td2" colspan="4">
							<input class="easyui-textbox" type="text" name="description" data-options="multiline:true,validType:'length[1,200]'" style="width: 513px;height:100px" value="${bean.description}"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div region="south" border="false" class="south" align="center">
			<a href="javascript:void(0)" onclick="departEditForm();">
				<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
			<a href="javascript:void(0)" onclick="closeWindow();">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
		</div>
	</div>
</body>
</html>


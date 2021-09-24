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
		function categoryEditForm(){
			var flag=false;
			$('#categoryEditForm').form('submit', {
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
						$('#categoryEditForm').form('clear');
						$("#category_dg").datagrid('reload');
					}else{
						$.messager.alert('系统提示',data.info,'error');
						$('#categoryEditForm').form('clear');
					}
				} 
			});
		}
		function categorySelect(selectType){
			var win=creatSearchDataWin('新增-字典类型',490,300,'icon-add',"/category/refCategoryGrid/"+selectType);
		    win.window('open');
		}
		function categoryReturnSelect(ret){
			if (ret == "clear") {
		       $("#div_category").html("");
			}

		    if (ret!="&&&&" && ret != undefined && ret != null && ret.indexOf("&&") != -1 && ret != "cancel") {
		    	var retArray = ret.split("&&");
		        var str= new Array(); 
		       	str=retArray[2].split(","); 
		       	for(var i=0;i<str.length-1 ;i++){
		       		if(null!=str[i]){
		       			var str1= new Array();
		       			str1=str[i].split(":");
		       			var div1 = $("#div_category");
		       			if(!isCategoryTreeExist(str1[0]) && !isCategoryTreeExist(str1[1])){
							names.push(str1[0]);	
							div1.html("<div  style='float:left;margin-left:8px;margin-top:8px;' > "+
										"<input type='hidden' name='parent.id' id='departIds' value='"+str1[0]+"'/>"+
										""+str1[1]+""+
										"<img src='${base}/resource/images/cancelDepart.jpg' style='cursor:pointer;margin-left:5px;height:15px;width:15px;' onclick = 'cancelCategory(this)' title='删除' id='"+str1[0]+"'/>"+
										"</div>")
						}
		       		}
		       	}
		    }
		}
		function isCategoryTreeExist(name){
			for(var i=0; i<names.length; i++){
				if(names[i] == name){
					return true;
				}
			}
			return false;
		}
		
		function cancelCategory(obj){
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
	</script>
    <div class="easyui-layout" fit="true">
    	<div region="center" border="false">
	    	<form id="categoryEditForm" action="${base}/category/save" method="post" data-options="novalidate:true" class="easyui-form">
	    		<input type="hidden" name="id" value="${bean.id}"/>
				<table border="0" cellpadding="0" cellspacing="0" class="main_table">
					<tr>
						<th width="20%"><span style="color: red;">*</span>字典类型代码：</th>
						<td width="80%" colspan="3">
							<input class="easyui-textbox" type="text" name="code" data-options="required:true,validType:'length[1,50]'" size="50" value="${bean.code}"/>
						</td>
					</tr>
					<tr>
						<th><span style="color: red;">*</span>字典类型名称：</th>
						<td colspan="3">
							<input class="easyui-textbox" type="text" name="name" data-options="required:true,validType:'length[1,50]'" size="50" value="${bean.name}"/>
						</td>
					</tr>
					<tr>
						<th>父字典类型：</th>
						<td colspan="3">
	                      <c:if test="${fn:length(bean.id)==0}">
	                        
	                        <c:if test="${category.code==null}">
                          	<div id="div_category" style="float: left; width:300px; height:25px; overflow-x:hidden; border: 1px solid #D4D4D4; margin: 5px" ></div>
          			        <input type="button" value="选" class="button_blue" style="margin-top: 5px" onclick="categorySelect('zdlxbm')"/>
						    </c:if>
						    <c:if test="${category.code!=null}">
                          		<div id="div_category" style="float: left; width:300px; height:25px; overflow-x:hidden; border: 1px solid #D4D4D4; margin: 5px" >           
		          				<div style='float:left;margin-left:8px;margin-top:8px;' >
		          				    <input type='hidden' name='parent.id'  value='${category.id}'/>
		          				    ${category.name}
		          					<img src='${base}/resource/images/cancelDepart.jpg' style='cursor:pointer;margin-left:5px;height:15px;width:15px;' onclick = 'cancelCategory(this)' title='删除' id='${category.id}'/>
		          				</div>
	         			        </div>
						      <input type="button" value="选" class="button_blue" style="margin-top: 5px" onclick="categorySelect('zdlxbm')"/>
						    </c:if>
						    
						  </c:if>
						  
						  <c:if test="${fn:length(bean.id)>0}">
						        <div id="div_category" style="float: left; width:300px; height:25px; overflow-x:hidden; border: 1px solid #D4D4D4; margin: 5px" >           
		          				<div style='float:left;margin-left:8px;margin-top:8px;' >
		          				    <input type='hidden' name='parent.id'  value='${bean.parent.id}'/>
		          				    ${bean.parent.name}
		          				    <c:if test="${bean.parent.id!=null}">
		          					<img src='${base}/resource/images/cancelDepart.jpg' style='cursor:pointer;margin-left:5px;height:15px;width:15px;' onclick = 'cancelCategory(this)' title='删除' id='${bean.parent.id}'/>
		          				    </c:if>
		          				</div>
	         			        </div>
						      <input type="button" value="选" class="button_blue" style="margin-top: 5px" onclick="categorySelect('${bean.id}')"/>
						  </c:if>
						  
						</td>
					</tr>
					<tr>
						<th><span style="color: red;">*</span>排列顺序：</th>
						<td colspan="3">
							<input class="easyui-textbox" type="text" name="orderNo" data-options="required:true,validType:'length[1,10]'" size="50" value="${bean.orderNo}"/>
						</td>
					</tr>
					<tr>
						<th>说明：</th>
						<td colspan="3">
							<input class="easyui-textbox" type="text" name="description" data-options="multiline:true,validType:'length[1,200]'" size="70" style="height:100px" value="${bean.description}"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div region="south" border="false" class="south">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-ok" onclick="categoryEditForm();">保存</a> 
			<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" onclick="closeWindow();">关闭</a>
		</div>
	</div>
</body>
</html>


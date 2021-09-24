<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
<%-- <jsp:include page="/commons/top.jsp"></jsp:include>	 --%>
<!--main start-->
<%-- 	<jsp:include page="/commons/left.jsp"></jsp:include>    --%>
     <!--right start-->
   
	<div class="easyui-layout" fit="true">
	<%-- <div data-options="region:'west',split:false"  style="width:200px;">
		<ul id="userDepartTree" class="easyui-tree" data-options="url:'${base}/depart/tree',animate:true,lines:true"></ul>
	</div> --%>
	<div data-options="region:'center'">
		<div id="user_tb" style="padding:2px 5px;">
			<form action="" id="query_user_form" class="easyui-form" style="margin-bottom: 0px;" onkeydown="if(event.keyCode==13){queryUser();return false; }">
			    <p style="padding-bottom:5px;">
					科目编号: <input type="text" size="15" class="easyui-textbox" maxlength="10" id="economic_code"/>&nbsp;
					科目名称: <input type="text" size="15" class="easyui-textbox" maxlength="10" id="economic_name"/>&nbsp;
					<%-- 上级科目编号: <select name="street.streetCode" id="jdCode" onchange="streetChange(this.value);">
	          				<option value="">--请选择--</option>
	          				<c:forEach items="${listStreet}" var="street">
	          					<option value="${street.streetCode}" <c:if test="${street.streetCode==bean.street.streetCode}">selected="selected"</c:if>>${street.name}</option>
	          				</c:forEach>
	          		     </select> --%>
					科目类型: <input id="economic_type" style="width: 100px;" class="easyui-textbox" />
				</p>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search32',size:'large',iconAlign:'left'" onclick="queryUser();">查询</a>&nbsp;
				<%-- <gwideal:perm url="/user/add"> --%>
				    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add32',size:'large',iconAlign:'left'" onclick="addEconomic();">新增</a>&nbsp;
				<%-- </gwideal:perm>
				<gwideal:perm url="/user/edit/{id}"> --%>
				 	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit32',size:'large',iconAlign:'left'" onclick="editUser();">修改</a>&nbsp;
				<%-- </gwideal:perm>
				<gwideal:perm url="/user/delete/{id}"> --%>
				    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut32',size:'large',iconAlign:'left'" onclick="deleteEconomic();">删除</a>&nbsp;
				<%-- </gwideal:perm> --%>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-view32',size:'large',iconAlign:'left'" onclick="view();">详情</a>&nbsp;
			</form>

		</div>
		
		<table id="economic_dg" border="0" class="easyui-datagrid"
				data-options="singleSelect:true,collapsible:true,url:'${base}/economic/JsonPagination',
				method:'post',fit:true,pagination:true,toolbar:'#user_tb',singleSelect: true,
				selectOnCheck: true,checkOnSelect: true,remoteSort:true,pageSize:50,pageList:[50,100,150],rownumbers:true">
			<thead>
				<tr>
					<!-- <th data-options="field:'ck',checkbox:true"></th> -->
					<th data-options="field:'fid',hidden:true"></th>
					<th data-options="field:'code',align:'left',resizable:false,sortable:true" width="15%">科目编号</th>
					<th data-options="field:'name',align:'center',resizable:false,sortable:true" width="25%">科目名称</th>
					<th data-options="field:'leve',align:'center',resizable:false,sortable:true" width="15%">科目级别</th>
					<th data-options="field:'pid',align:'center',resizable:false" width="15%">上级科目编号</th>
					<th data-options="field:'on',align:'center',resizable:false" width="10%">是否启用</th>
					<th data-options="field:'type',align:'center',resizable:false" width="20%">科目类型</th>
					<!-- <th data-options="field:'cuser',align:'center',resizable:false" width="8%">创建人</th>
					<th data-options="field:'ctime',align:'center',resizable:false" width="10%">创建时间</th> -->
					<!-- <th data-options="field:'locked',align:'center',resizable:false" width="10%">是否锁定</th> -->
				</tr>
			</thead>
		</table>
    </div>
</div>
<script type="text/javascript">

	
	function view(){
		var row = $('#economic_dg').datagrid('getSelected');
		var selections = $('#economic_dg').datagrid('getSelections');
		if(null!=row && selections.length==1){
		    var win=creatWin('查看-经济分类科目',850,200,'icon-edit','/economic/view/'+row.fid);
		    win.window('open');
		}else{
			 $.messager.alert('系统提示','请选择一条要查看的数据！','info');
		}
	}
	function reSetPassword(){
		var row = $('#economic_dg').datagrid('getSelected');
		var selections = $('#economic_dg').datagrid('getSelections');
		if(null!=row && selections.length==1){
			$.messager.confirm('系统提示','确认重置密码吗?',function(r){
				if(r){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/user/reSetPwd/'+row.id,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
							}else{
								$.messager.alert('系统提示',data.info,'error');
							}
						} 
					});
				}
			});
		}else{
			 $.messager.alert('系统提示','请选择一条数据！','info');
		}
	}
	function changeStatus(){
		var info;
		var row = $('#economic_dg').datagrid('getSelected');
		var selections = $('#economic_dg').datagrid('getSelections');
		if(null!=row && selections.length==1){
			if(row.status=='10'){
				info="确认设置为离岗吗?";
			}else if(row.status=='20'){
				info="确认设置为在岗吗?";
			}else{
				$.messager.alert('系统提示',"非责任人，无法操作！",'error');
				return;
			}
			$.messager.confirm('系统提示',info,function(r){
				if(r){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/user/changeStatus/'+row.id,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#economic_dg").datagrid('reload');
							}else{
								$.messager.alert('系统提示',data.info,'error');
							}
						} 
					});
				}
			});
			
		}else{
			 $.messager.alert('系统提示','请选择一条数据！','info');
		}
	}
	function lock(){
		var row = $('#economic_dg').datagrid('getSelected');
		var selections = $('#economic_dg').datagrid('getSelections');
		if(null!=row && selections.length==1){
			$.messager.confirm('系统提示','确认锁定/解锁用户吗?',function(r){
				if(r){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/user/lock/'+row.id,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#economic_dg").datagrid('reload');
							}else{
								$.messager.alert('系统提示',data.info,'error');
							}
						} 
					});
				}
			});
		}else{
			 $.messager.alert('系统提示','请选择一条数据！','info');
		}
	}
	function deleteEconomic(){
		var row = $('#economic_dg').datagrid('getSelected');
		var selections = $('#economic_dg').datagrid('getSelections');
		if(null!=row && selections.length==1){
			if(row.status=='10'){
				$.messager.alert('系统提示','离岗后才能删除!','info');
				return;
			}
			$.messager.confirm('系统提示','确认删除用户吗?',function(r){
				if(r){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/economic/delete/'+row.fid,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#economic_dg").datagrid('reload');
							}else{
								$.messager.alert('系统提示',data.info,'error');
							}
						} 
					});
				}
			});
		}else{
			 $.messager.alert('系统提示','请选择一条数据！','info');
		}
	}
	function smsSetUp(){
		var mainFrame=parent.parent.parent.document.getElementById("mainFrame").contentWindow;
        if(null==mainFrame.Ext.getCmp('smsSetUpTab')){ 
        	var tabs=mainFrame.Ext.getCmp('tabPanel');
			tabs.add({
				  id:'smsSetUpTab',
		          title: '短信设置',
		          iconCls: 'tabs',
		          html: "<iframe id='smsSetUpIframe' src='${base}/project/toSmsSetUpParam.action' width='100%' height='100%' frameborder='0'></iframe>",
		          closable: true
		      }).show();
        }else{
        	mainFrame.Ext.getCmp('smsSetUpTab').show();
        	parent.document.getElementById('smsSetUpIframe').src="${base}/project/toSmsSetUpParam.action";
        }
	}
	function queryUser(){
		$('#economic_dg').datagrid('load',{ 
			code:$('#economic_code').val(),
			name:$('#economic_name').val(),
			type:$('#economic_type').val()
		}); 
	}
	function addEconomic(){
		var node=$('#userDepartTree').tree('getSelected');
		var win=creatWin('新增-经济分类科目',750,250,'icon-add','/economic/add');
		if(null!=node){
			win=creatWin('新增-经济分类科目',750,450,'icon-add','/economic/add?departId='+node.id);
		}
		win.window('open');
	}
	function editUser(){
		var row = $('#economic_dg').datagrid('getSelected');
		var selections = $('#economic_dg').datagrid('getSelections');
		if(null!=row && selections.length==1){
		    var win=creatWin('修改-经济分类科目',750,250,'icon-edit','/economic/edit/'+row.fid);
		    win.window('open');
		}else{
			 $.messager.alert('系统提示','请选择一条数据！','info');  
		}
	}
	$('#userDepartTree').tree({
		onClick: function(node){
			$('#economic_dg').datagrid('load',{ 
				departId:node.id
			}); 
		}
	});
	function streetChange(streetCode){
		$('#streetJwh').combobox('reload',"${base}/street/jwh?streetCode="+streetCode);
	}
</script>
</body>
</html>


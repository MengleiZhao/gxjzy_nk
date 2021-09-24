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
		<div data-options="region:'west',split:false"  style="width:200px;">
			<ul id="userDepartTree" class="easyui-tree" data-options="url:'${base}/depart/tree',animate:true,lines:true"></ul>
		</div>
	<div data-options="region:'center'" style="background-color: #f0f5f7">
	
		<div style="height: 10px;background-color:#f0f5f7 "></div>
		
			<form action="" id="query_user_form" class="easyui-form" style="margin-bottom: 0px;" onkeydown="if(event.keyCode==13){queryUser();return false; }">
			    <div class="list-top">
					<table   class="top-table" cellpadding="0" cellspacing="0">
						<tr>
							<td class="top-table-search" style="width:70%;">姓名&nbsp;
								<input type="text" size="15" class="easyui-textbox" maxlength="10" id="userName" style="width: 150px;height:25px;"/>
								<!-- &nbsp;&nbsp;帐号&nbsp;
								<input type="text" size="15" class="easyui-textbox" maxlength="10" id="userAccountNo" style="width: 150px;height:25px;"/> -->
								&nbsp;&nbsp;角色名称&nbsp;
								<input type="text" size="15" class="easyui-textbox" maxlength="10" id="userRoleName" style="width: 150px;height:25px;"/>
								&nbsp;&nbsp;
								<a href="#" onclick="queryUser();">
									<img style="vertical-align:bottom"  src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
								</a>
								<a href="#" onclick="clearUser();">
									<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
								</a>
							</td>
							<td align="right" style="padding-right: 10px">
								<a href="#" onclick="AKeyToReplace()">
									<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/thlc1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
								</a>
								<a href="#" onclick="reSetPassword()">
									<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/czmm1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
								</a>
								<a href="#" onclick="addUser()">
									<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
								</a>
								<a href="#" onclick="editUser()">
									<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
								</a>
								<a href="#" onclick="deleteUser()">
									<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shanchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
								</a>
							</td>
						</tr>
					</table>
				</div>
			    
			    
			<%--     
			    <p style="padding-bottom:5px;">
					姓名: <input type="text" size="15" class="easyui-textbox" maxlength="10" id="userName"/>&nbsp;
					帐号: <input type="text" size="15" class="easyui-textbox" maxlength="10" id="userAccountNo"/>&nbsp;
					角色名称: <input type="text" size="15" class="easyui-textbox" maxlength="10" id="userRoleName"/>&nbsp;
				</p>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search32',size:'large',iconAlign:'left'" onclick="queryUser();">查询</a>&nbsp;
				<gwideal:perm url="/user/add">
				    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add32',size:'large',iconAlign:'left'" onclick="addUser();">新增</a>&nbsp;
				</gwideal:perm>
				<gwideal:perm url="/user/edit/{id}">
				 	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit32',size:'large',iconAlign:'left'" onclick="editUser();">修改</a>&nbsp;
				</gwideal:perm>
				<gwideal:perm url="/user/delete/{id}">
				    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut32',size:'large',iconAlign:'left'" onclick="deleteUser();">删除</a>&nbsp;
				</gwideal:perm>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-view32',size:'large',iconAlign:'left'" onclick="view();">详情</a>&nbsp;
				<gwideal:perm url="/user/reSetPwd/{userId}">
				    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit32',size:'large',iconAlign:'left'" onclick="reSetPassword();">重置密码</a>&nbsp;
				</gwideal:perm>
				<gwideal:perm url="/user/lock/{userId}">
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add32',size:'large',iconAlign:'left'" onclick="lock();">锁定/解锁用户</a>&nbsp;
				</gwideal:perm>
				<gwideal:perm url="/user/changeStatus/{userId}">
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit32',size:'large',iconAlign:'left'" onclick="changeStatus();">在岗/离岗</a>&nbsp;
				</gwideal:perm> --%>
			</form>
		
		<div class="list-table" style="height: 90%">
			<table id="user_dg" border="0" class="easyui-datagrid"
					data-options="singleSelect:true,collapsible:true,url:'${base}/user/jsonPagination',
					method:'post',fit:true,pagination:true,toolbar:'#user_tb',singleSelect: true,
					selectOnCheck: true,checkOnSelect: true,remoteSort:true,pageSize:50,pageList:[50,100,150],rownumbers:true">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'accountNo',align:'center',resizable:false,sortable:true" width="25%">帐号</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true" width="25%">姓名</th>
						<th data-options="field:'departName',align:'center',resizable:false" width="25%">部门名称</th>
						<th data-options="field:'userRoleName',align:'center',resizable:false" width="25%">角色名称</th>
					</tr>
				</thead>
			</table>
		</div>
    </div>
</div>
<script type="text/javascript">
	function view(){
		var row = $('#user_dg').datagrid('getSelected');
		var selections = $('#user_dg').datagrid('getSelections');
		if(null!=row && selections.length==1){
		    var win=creatWin('查看-用户信息',850,300,'icon-search','/user/view/'+row.id);
		    win.window('open');
		}else{
			 $.messager.alert('系统提示','请选择一条要查看的数据！','info');
		}
	}
	function reSetPassword(){
		var row = $('#user_dg').datagrid('getSelected');
		var selections = $('#user_dg').datagrid('getSelections');
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
	/* function changeStatus(){
		var info;
		var row = $('#user_dg').datagrid('getSelected');
		var selections = $('#user_dg').datagrid('getSelections');
		if(null!=row && selections.length==1){
			if(row.status=='1'){
				info="确认设置为离岗吗?";
			}else if(row.status=='0'){
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
								$("#user_dg").datagrid('reload');
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
	} */
	function lock(){
		var row = $('#user_dg').datagrid('getSelected');
		var selections = $('#user_dg').datagrid('getSelections');
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
								$("#user_dg").datagrid('reload');
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
	function deleteUser(){
		var row = $('#user_dg').datagrid('getSelected');
		var selections = $('#user_dg').datagrid('getSelections');
		if(null!=row && selections.length==1){
			if(row.status=='1'){
				$.messager.alert('系统提示','离岗后才能删除!','info');
				return;
			}
			$.messager.confirm('系统提示','确认删除用户吗?',function(r){
				if(r){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/user/delete/'+row.id,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#user_dg").datagrid('reload');
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
		$('#user_dg').datagrid('load',{ 
			name:$('#userName').val(),
			accountNo:$('#userAccountNo').val(),
			userRoleName:$('#userRoleName').val()
		}); 
	}
	//清除查询条件
	function clearUser() {
		$("#userName").textbox('setValue','');
		$("#userAccountNo").textbox('setValue','');
		$("#userRoleName").combobox('setValue','');
		$('#user_dg').datagrid('load',{//清空以后，重新查一次
		});
	}
	function addUser(){
		var node=$('#userDepartTree').tree('getSelected');
		var win=creatWin('新增-用户信息',750,525,'icon-add','/user/add');
		if(null!=node){
			win=creatWin('新增-用户信息',750,525,'icon-add','/user/add?departId='+node.id);
		}
		win.window('open');
	}
	function AKeyToReplace(){
		var row = $('#user_dg').datagrid('getSelected');
		var selections = $('#user_dg').datagrid('getSelections');
		if(null!=row && selections.length==1){
		    var win=creatWin('新增-用户信息',450,225,'icon-search','/user/aKeyToReplace/'+row.id);
			win.window('open');
		}else{
			 $.messager.alert('系统提示','请选择一条要替换的数据！','info');
			 return false;
		}
	}
	function editUser(){
		var row = $('#user_dg').datagrid('getSelected');
		var selections = $('#user_dg').datagrid('getSelections');
		if(null!=row && selections.length==1){
		    var win=creatWin('修改-用户信息',750,525,'icon-edit','/user/edit/'+row.id);
		    win.window('open');
		}else{
			 $.messager.alert('系统提示','请选择一条数据！','info');  
		}
	}
	$('#userDepartTree').tree({
		onClick: function(node){
			$('#user_dg').datagrid('load',{ 
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


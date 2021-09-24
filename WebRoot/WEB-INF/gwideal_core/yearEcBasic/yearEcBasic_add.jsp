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
	  
	<div data-options="region:'north'" >
		<input id="sdf" hidden="hidden" value="${departId }"/>
		 	<table>
				<td>
					<form action="" id="query_user_form" class="easyui-form" style="margin-bottom: 0px;" onkeydown="if(event.keyCode==13){queryUser();return false; }">
			    <p style="padding-bottom:5px;">
					科目名称: <input type="text"  size="15" class="easyui-textbox" maxlength="10" id="ye_Name_add"/>&nbsp;
					科目编号: <input type="text"  size="15" class="easyui-textbox" maxlength="10" id="ye_Period_add"/>&nbsp;
					科目类型: <input id="ye_type" style="width: 100px;" class="easyui-textbox" />
				</p>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search32',size:'large',iconAlign:'left'" onclick="queryYe();">查询</a>&nbsp;
				<%-- <gwideal:perm url="/user/add"> --%>
				    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add32',size:'large',iconAlign:'left'" onclick="addYs()();">保存</a>&nbsp;
				<%-- </gwideal:perm> --%>
				<%-- <gwideal:perm url="/user/edit/{id}">
				 	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit32',size:'large',iconAlign:'left'" onclick="editUser();">修改</a>&nbsp;
				</gwideal:perm> --%>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut32',size:'large',iconAlign:'left'" onclick="closeWindow();">关闭</a>&nbsp;
			</form>
			</table>
	  	</div>
	  	
	  <div data-options="region:'center'" >
		<table id="ye_dg_add" border="0" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/yearsUnionBasic/JsonPaginationadd?departId=${departId}',
				method:'post',fit:true,pagination:true,singleSelect: true,
				selectOnCheck: true,checkOnSelect: true,remoteSort:true,pageSize:50,pageList:[50,100,150],rownumbers:true">
			<thead>
				<tr>
					<!-- <th data-options="field:'ck',checkbox:true"></th> -->
					<th data-options="field:'fbId', checkbox:true" width="5%"></th>
					<th data-options="field:'code',align:'left',resizable:false,sortable:true" width="10%" >科目编号</th>
					<th data-options="field:'name',align:'center',resizable:false,sortable:true" width="30%" >科目名称</th>
					<th data-options="field:'leve',align:'center',resizable:false,sortable:true" width="20%" >科目级别</th>
					<th data-options="field:'pid',align:'center',resizable:false" width="10%" >上级科目编号</th>
					<th data-options="field:'on',align:'center',resizable:false" width="10%">是否启用</th>
					<th data-options="field:'type',align:'center',resizable:false" width="15%" >科目类型</th>
				</tr>
			</thead>
		</table>
		
		</div>
		
    </div>
    
	 
</div>
<script type="text/javascript">
	function view(){
		var row = $('#ye_dg_add').datagrid('getSelected');
		var selections = $('#ye_dg_add').datagrid('getSelections');
		if(null!=row && selections.length==1){
		    var win=creatWin('查看-经济分类科目',850,250,'icon-edit','/economic/view/'+row.fid);
		    win.window('open');
		}else{
			 $.messager.alert('系统提示','请选择一条要查看的数据！','info');
		}
	}
	function reSetPassword(){
		var row = $('#ye_dg_add').datagrid('getSelected');
		var selections = $('#ye_dg_add').datagrid('getSelections');
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
		var row = $('#ye_dg_add').datagrid('getSelected');
		var selections = $('#ye_dg_add').datagrid('getSelections');
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
								$("#ye_dg_add").datagrid('reload');
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
		var row = $('#ye_dg_add').datagrid('getSelected');
		var selections = $('#ye_dg_add').datagrid('getSelections');
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
								$("#ye_dg_add").datagrid('reload');
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
		var row = $('#ye_dg_add').datagrid('getSelected');
		var selections = $('#ye_dg_add').datagrid('getSelections');
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
								$("#ye_dg_add").datagrid('reload');
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
	function queryYe(){
		var node=$('#userDepartTree').tree('getSelected');
		$('#ye_dg_add').datagrid('load',{ 
			name:$('#ye_Name_add').val(),
			code:$('#ye_Period_add').val(),
			fPeriod:node.text,
			fbId:node.id
		}); 
	}
	 function addYs(){
		var node=$('#ye_dg_add').tree('getSelected');
		var da=$('#ye_dg_add').datagrid('getChecked');
		var row = $('#ye_dg_add').datagrid('getSelected');
		var fids=[15];
		var str;
		var departId = $('#sdf').val();
		for(var i=0;i<da.length;i++){
			fids[i]=(da[i].fid);
			str=str+','+da[i].fid;
		}
		if(null==node){
			$.ajax({ 
				type: 'POST', 
				url: '${base}/yearsUnionBasic/yeubadd',
				dataType: 'json', 
				data:{'daw':str,'departId':departId}, 
				success: function(data){ 
					if(data.success){
						$.messager.alert('系统提示',data.info,'info');
						closeWindow();
						$('#query_user_form').datagrid('clear');
						$('#query_user_form').datagrid('reload');
					}else{
						$.messager.alert('系统提示',data.info,'error');
					}
				} 
			});;
		}
		win.window('open');
	} 
	function editUser(){
		var row = $('#ye_dg_add').datagrid('getSelected');
		var selections = $('#ye_dg_add').datagrid('getSelections');
		if(null!=row && selections.length==1){
		    var win=creatWin('修改-经济分类科目',750,250,'icon-edit','/economic/edit/'+row.fid);
		    win.window('open');
		}else{
			 $.messager.alert('系统提示','请选择一条数据！','info');  
		}
	}
	$('#ye_dg_add').datagrid({singleSelect:(this.value==1)})
	
</script>
</body>
</html>


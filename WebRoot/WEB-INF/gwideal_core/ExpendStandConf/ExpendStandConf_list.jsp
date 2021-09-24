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
		<div id="ESC_tb" style="padding:2px 5px;">
			<form action="" id="ESC_form" class="easyui-form" style="margin-bottom: 0px;" onkeydown="if(event.keyCode==13){queryESC();return false; }">
			    <p style="padding-bottom:5px;">
					岗位级别: <input type="text" size="15" class="easyui-textbox" maxlength="10" id="ESC_fpLevel"/>&nbsp;
					岗位名称: <input type="text" size="15" class="easyui-textbox" maxlength="10" id="ESC_fpName"/>&nbsp;
					开支标准（下限）: <input id="ESC_fStandAmountD" style="width: 100px;" class="easyui-textbox" />
					开支标准（上限）: <input id="ESC_fStandAmountU" style="width: 100px;" class="easyui-textbox" />
				</p>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search32',size:'large',iconAlign:'left'" onclick="queryESC();">查询</a>&nbsp;
				<gwideal:perm url="/user/add">
				    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add32',size:'large',iconAlign:'left'" onclick="addESC();">新增</a>&nbsp;
				</gwideal:perm>
				<gwideal:perm url="/user/edit/{id}">
				 	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit32',size:'large',iconAlign:'left'" onclick="editESC();">修改</a>&nbsp;
				</gwideal:perm>
				<gwideal:perm url="/user/delete/{id}">
				    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut32',size:'large',iconAlign:'left'" onclick="deleteESC();">删除</a>&nbsp;
				</gwideal:perm>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-view32',size:'large',iconAlign:'left'" onclick="view();">详情</a>&nbsp;
			</form>

		</div>
		
		<table id="ESC_dg" border="0" class="easyui-datagrid"
				data-options="singleSelect:true,collapsible:true,url:'${base}/ExpendStandConf/JsonPagination',
				method:'post',fit:true,pagination:true,toolbar:'#ESC_tb',singleSelect: true,
				selectOnCheck: true,checkOnSelect: true,remoteSort:true,pageSize:50,pageList:[50,100,150],rownumbers:true">
			<thead>
				<tr>
					<!--  <th data-options="field:'ck',checkbox:true"></th>  -->
					<th data-options="field:'feId',hidden:true"></th>
					<th data-options="field:'fpName',align:'center',resizable:false,sortable:true" width="20%">岗位名称</th>
					<th data-options="field:'fpLevel',align:'center',resizable:false,sortable:true" width="20%">岗位级别</th>
					<th data-options="field:'fStandAmountD',align:'center',resizable:false,sortable:true" width="20%">开支标准 下限</th>
					<th data-options="field:'fStandAmountU',align:'center',resizable:false" width="20%">开支标准 上限</th>
					<th data-options="field:'fRemark',align:'center',resizable:false" width="20%">备注</th>
				</tr>
			</thead>
		</table>
    </div>
</div>
<script type="text/javascript">
	function view(){
		var row = $('#ESC_dg').datagrid('getSelected');
		var selections = $('#ESC_dg').datagrid('getSelections');
		if(null!=row && selections.length==1){
		    var win=creatWin('查看-开支标准配置',850,200,'icon-edit','/ExpendStandConf/view/'+row.fid);
		    win.window('open');
		}else{
			 $.messager.alert('系统提示','请选择一条要查看的数据！','info');
		}
	}
	function reSetPassword(){
		var row = $('#ESC_dg').datagrid('getSelected');
		var selections = $('#ESC_dg').datagrid('getSelections');
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
		var row = $('#ESC_dg').datagrid('getSelected');
		var selections = $('#ESC_dg').datagrid('getSelections');
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
								$("#ESC_dg").datagrid('reload');
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
		var row = $('#ESC_dg').datagrid('getSelected');
		var selections = $('#ESC_dg').datagrid('getSelections');
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
								$("#ESC_dg").datagrid('reload');
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
	function deleteESC(){
		var row = $('#ESC_dg').datagrid('getSelected');
		var selections = $('#ESC_dg').datagrid('getSelections');
		console.log(row);
		if(null!=row && selections.length==1){
			if(row.status=='10'){
				$.messager.alert('系统提示','离岗后才能删除!','info');
				return;
			}
			$.messager.confirm('系统提示','确认删除用户吗?',function(r){
				if(r){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/ExpendStandConf/delete/'+row.feId	,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#ESC_dg").datagrid('reload');
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
	function queryESC(){
		$('#ESC_dg').datagrid('load',{ 
			fpName:$('#ESC_fpName').val(),
			fpLevel:$('#ESC_fpLevel').val(),
			fStandAmountD:$('#ESC_fStandAmountD').val(),
			fStandAmountU:$('#ESC_fStandAmountU').val()
		}); 
	}
	function addESC(){
		var node=$('#userDepartTree').tree('getSelected');
		var win=creatWin('新增-开支标准配置',750,280,'icon-add','/ExpendStandConf/add');
		 if(null!=node){
			win=creatWin('新增-开支标准配置',750,280,'icon-add','/ExpendStandConf/add?departId='+node.id);
		} 
		win.window('open');
	}
	function editESC(){
		var row = $('#ESC_dg').datagrid('getSelected');
		console.log(row.feId);
		var selections = $('#ESC_dg').datagrid('getSelections');
		if(null!=row && selections.length==1){
		    var win=creatWin('修改-开支标准配置',750,280,'icon-edit','/ExpendStandConf/edit/'+row.feId);
		    win.window('open');
		}else{
			 $.messager.alert('系统提示','请选择一条数据！','info');  
		}
	}
	$('#userDepartTree').tree({
		onClick: function(node){
			$('#ESC_dg').datagrid('load',{ 
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


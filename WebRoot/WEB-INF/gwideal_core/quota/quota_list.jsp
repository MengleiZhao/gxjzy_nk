<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
<style type="text/css">
.tabletop{margin: 0 10px 10px 10px;background-color: #fff;font-family: "微软雅黑"}
.queryth{text-align: right;}
</style>
</head>
<body style="background-color: #f0f5f7;text-align: center;">
   
	<div class="easyui-layout" fit="true">
	<div data-options="region:'west',split:false"  style="width:200px;background-color: #f0f5f7" >
		<ul id="quitaTree" class="easyui-tree" data-options="url:'${base}/quotaConfig/tree',animate:true,lines:true" ></ul>
	</div>
	
	  <div data-options="region:'center'" >
	  
		<div id="ye_tb" style="padding:2px 5px;">
			<form action="" id="query_user_form" class="easyui-form" style="margin-bottom: 0px;" onkeydown="if(event.keyCode==13){queryUser();return false; }">
			    <p style="padding-bottom:5px;">
					科目名称: <input type="text"  size="12" class="easyui-textbox" maxlength="10" id="ye_Name"/>&nbsp;
					科目编号: <input type="text"  size="12" class="easyui-textbox" maxlength="10" id="ye_Period"/>&nbsp;
					科目类型: <input id="ye_type" style="width: 100px;" class="easyui-textbox" />
				</p>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search32',size:'large',iconAlign:'left'" onclick="queryUser();">查询</a>&nbsp;
				<%-- <gwideal:perm url="/user/add"> --%>
				    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add32',size:'large',iconAlign:'left'" onclick="addEconomic();">新增</a>&nbsp;
				<%-- </gwideal:perm> --%>
				<%-- <gwideal:perm url="/user/edit/{id}"> --%>
				 	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit32',size:'large',iconAlign:'left'" onclick="editUser();">修改</a>&nbsp;
				<%-- </gwideal:perm>  --%>
				<%-- <gwideal:perm url="/user/delete/{id}"> --%>
				    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut32',size:'large',iconAlign:'left'" onclick="deleteEconomic();">删除</a>&nbsp;
				<%-- </gwideal:perm> --%>
			</form>

		</div>
		 <div style="margin: 0 10px 0 10px;height: 420px;" >
		<table id="quitaConfig_dg" border="0" class="easyui-datagrid"
				data-options="singleSelect:true,collapsible:true,url:'${base}/quotaConfig/JsonPagination',
				method:'post',fit:true,pagination:true,singleSelect: true,
				selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<!-- <th data-options="field:'ck',checkbox:true"></th> 
					<th data-options="field:'fbId',checkbox:true"></th>-->
					<th data-options="field:'code',align:'left',resizable:false,sortable:true" width="15%">科目编号</th>
					<th data-options="field:'name',align:'center',resizable:false,sortable:true" width="30%">科目名称</th>
					<th data-options="field:'leve',align:'center',resizable:false,sortable:true,formatter:kmjb " width="20%">科目级别</th>
					<th data-options="field:'pid',align:'center',resizable:false" width="10%">上级科目编号</th>
					<th data-options="field:'on',align:'center',resizable:false,formatter:qiyong" width="10%">是否启用</th>
					<th data-options="field:'type',align:'center',resizable:false,formatter:kmlx" width="15%">科目类型</th>
				</tr>
			</thead>
		</table>
		</div>
	  
		
    </div>
	 
	
	
	
		
    
   
</div>
<script type="text/javascript">
//分页样式调整
$(function(){
	var pager = $('#quitaConfig_dg').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});			
});
//清除查询条件
function clearTable() {
	$('#YB_ftName').textbox('setValue',null);
	$('#YB_fPeriod').textbox('setValue',null);
}
//鼠标移入图片替换
function mouseOver(img){
	var src = $(img).attr("src");
	src = src.replace(/1/, "2");
	$(img).attr("src",src);
}
	
function mouseOut(img) {
	var src = $(img).attr("src");
	src = src.replace(/2/, "1");
	$(img).attr("src",src);
}
//科目级别
function kmjb(val, row){
	if(row.leve=='KMJB-01'){
		return '一级科目';
	}else if(row.leve=='KMJB-02'){
		return '二级科目';
	}
}
//是否启用
function qiyong(val, row){
	if(row.on=='1'){
		return '启用';
	}else if(row.on=='2'){
		return '停用';
	}
}
//科目类型
function kmlx(val, row){
	if(row.type=='KMLX-01'){
		return '支出科目';
	}else if(row.type=='KMLX-09'){
		return '收入科目';
	}
}
	function view(){
		var row = $('#quitaConfig_dg').datagrid('getSelected');
		var selections = $('#quitaConfig_dg').datagrid('getSelections');
		if(null!=row && selections.length==1){
		    var win=creatWin('查看-经济分类科目',850,250,'icon-edit','/economic/view/'+row.fid);
		    win.window('open');
		}else{
			 $.messager.alert('系统提示','请选择一条要查看的数据！','info');
		}
	}
	function reSetPassword(){
		var row = $('#quitaConfig_dg').datagrid('getSelected');
		var selections = $('#quitaConfig_dg').datagrid('getSelections');
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
		var row = $('#quitaConfig_dg').datagrid('getSelected');
		var selections = $('#quitaConfig_dg').datagrid('getSelections');
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
								$("#quitaConfig_dg").datagrid('reload');
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
		var row = $('#quitaConfig_dg').datagrid('getSelected');
		var selections = $('#quitaConfig_dg').datagrid('getSelections');
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
								$("#quitaConfig_dg").datagrid('reload');
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
		var node=$('#quitaTree').tree('getSelected');
		var row =$('#quitaConfig_dg').datagrid('getChecked');
		var selections = $('#quitaConfig_dg').datagrid('getSelections');
		var da=$('#quitaConfig_dg').datagrid('getChecked');
		var fids=[15];
		var str;
		for(var i=0;i<da.length;i++){
			fids[i]=(da[i].fid);
			str=str+','+da[i].fid;
		}
		if(null!=row){
			$.messager.confirm('系统提示','确认删除吗?',function(r){
				if(r){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/economic/delete/'+row[0].fid,
						dataType: 'json',  
						data:{'fid':row[0].fid},
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#quitaConfig_dg").datagrid('reload');
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
		var node=$('#quitaTree').tree('getSelected');
		$('#quitaConfig_dg').datagrid('load',{ 
			name:$('#ye_Name').val(),
			code:$('#ye_Period').val(),
			fPeriod:node.text,
			fbId:node.id,
			type:$('#ye_type').val()
		}); 
	}
	function addEconomic(){
		var node=$('#quitaTree').tree('getSelected');
		//var win=creatWin('新增-经济分类科目',750,250,'icon-add','/yearsUnionBasic/add');
		if(null!=node){
			win=creatWin('新增-经济分类科目',700,300,'icon-search','/economic/add?departId='+node.id);
		}
		win.window('open');
	}
	function editUser(){
		var row = $('#quitaConfig_dg').datagrid('getSelected');
		var selections = $('#quitaConfig_dg').datagrid('getSelections');
		if(null!=row && selections.length==1){
		    var win=creatWin('修改-经济分类科目',750,250,'icon-search','/economic/edit/'+row.fid);
		    win.window('open');
		}else{
			 $.messager.alert('系统提示','请选择一条数据！','info');  
		}
	}
   $('#quitaTree').tree({
    	onClick: function(node){
			$('#quitaConfig_dg').datagrid('load',{ 
				fPeriod:node.text,
				fbId:node.id
				
			}); 
    	}
    }); 
   /*  function da(){
    	var node=$('#quitaTree').tree('getSelected');
    	console.log(node)
    } */
	/* $('#quitaTree').tree({
		onClick: function(node){
			console.log(node)
			$('#quitaConfig_dg').datagrid('load',{ 
				fPeriod:node.text,
				fbId:node.id
				
			}); 
		}
	}); */
	function streetChange(streetCode){
		$('#streetJwh').combobox('reload',"${base}/street/jwh?streetCode="+streetCode);
	}
</script>
</body>
</html>


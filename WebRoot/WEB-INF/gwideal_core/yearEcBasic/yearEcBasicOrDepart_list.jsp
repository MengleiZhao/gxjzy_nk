<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
<div class="easyui-layout" fit="true">
	<div data-options="region:'west',split:false"  style="width:200px;" >
		<ul id="EconomicTree" class="easyui-tree" data-options="url:'${base}/depart/tree',animate:true,lines:true" ></ul>
	</div>
	<div data-options="region:'center'" style="background-color: #f0f5f7">
	  <div style="height: 10px;background-color:#f0f5f7 "></div>
	  
		<div class="list-top">
			<form action="" id="query_user_form" class="easyui-form" style="margin-bottom: 0px;" onkeydown="if(event.keyCode==13){queryUser();return false; }">
			  <table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-td1">科目名称:</td> 
					<td class="top-table-td2">
						<input id="ye_Name" class="easyui-textbox" size="15"  maxlength="10" style="width: 150px;height:25px;"/>
					</td>
					
					<td style="width: 8px;"></td>
					<td class="top-table-td1">科目编号:</td> 
					<td class="top-table-td2">
						<input id="ye_Period" class="easyui-textbox" size="15"  maxlength="10" style="width: 150px;height:25px;"/>
					</td>
					
					<td style="width: 8px;"></td>
					<td class="top-table-td1">科目类型:</td> 
					<td class="top-table-td2">
						<input id="ye_type" class="easyui-textbox" size="15"  maxlength="10" style="width: 150px;height:25px;"/>
					</td>
					
					<td style="width: 8px;"></td>
					
					<td style="width: 26px;">
						<a href="#" onclick="queryUser();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					
					<%-- <gwideal:perm url="/lookup/add"> --%>
					<td style="width: 8px;"></td>
					
					<td style="width: 26px;">
						<a href="#" onclick="addEconomic();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<%-- </gwideal:perm> --%>
					
					<%-- <gwideal:perm url="/lookup/edit/{id}"> --%>
					<td style="width: 8px;"></td>
					
					<td style="width: 26px;">
						<a href="#" onclick="editUser();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<%-- </gwideal:perm> --%>
					
					<%-- <gwideal:perm url="/lookup/delete/{id}"> --%>
					<td style="width: 8px;"></td>
					
					<%-- <td style="width: 26px;">
						<a href="#" onclick="deleteEconomic();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td> --%>
					<%-- </gwideal:perm> --%>
					<td align="right" style="padding-right: 10px"></td>
				</tr>
			</table>
			</form>

		</div>
		<div class="list-table" style="height: 90%">
		<table id="Economic_dg" border="0" class="easyui-datagrid"
				data-options="singleSelect:true,collapsible:true,url:'${base}/yearsUnionBasic/JsonPaginations',
				method:'post',fit:true,pagination:true,singleSelect: true,pageSize:50,
				selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<!-- <th data-options="field:'ck',checkbox:true"></th> 
					<th data-options="field:'fbId',checkbox:true"></th>-->
					<th data-options="field:'deId',hidden:true"></th>
					<th data-options="field:'fEjProCode',align:'center',resizable:false,sortable:true" width="40%">科目编号</th>
					<th data-options="field:'fEjProName',align:'center',resizable:false,sortable:true" width="41%">科目名称</th>
					<!-- <th data-options="field:'fEcLeve',align:'center',resizable:false,sortable:true,formatter:kmjb " width="20%">科目级别</th> -->
					<th data-options="field:'id',align:'center',resizable:false,formatter:CZS" style="width: 20%">操作</th>
				</tr>
			</thead>
		</table>
		</div>
    </div>
</div>
<script type="text/javascript">

//操作栏创建
function CZS(val, row) {
	
	if(val != -1){
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="subjectEdit('+row.deId+','+row.fEjProCode+')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
			   '</a></td><td style="width: 25px">'+
				'<a href="#" onclick="deleteEconomic('+row.deId+','+row.fEjProCode+')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
				'</a></td></tr></table>';
	}
}

function subjectEdit(deId,fEjProCode){
	var node=$('#EconomicTree').tree('getSelected');
	//var win=creatWin('新增-经济分类科目',750,250,'icon-add','/yearsUnionBasic/add');
	if(null!=node){
		win=creatWin('修改-经济分类科目',710,580,'icon-search','/yearsUnionBasic/subjectEdit?departId='+node.id+'&deId='+deId+'&fEjProCode='+fEjProCode);
	}
	win.window('open');
}
//分页样式调整
$(function(){
	 var addr_tree = $("#EconomicTree").tree({  
	        url:'${base}/depart/tree',  
	        method:"post",  
	        onSelect:function(node){},
	        onLoadSuccess:function(node,data){  
	        	//找到第一条数据
	        	var n = $('#EconomicTree').tree('find', data[0].id);
		        //调用选中事件
		        $('#EconomicTree').tree('select', n.target);
	        	var node=$('#EconomicTree').tree('getSelected');
				$('#Economic_dg').datagrid('load',{ 
					name:$('#ye_Name').val(),
					code:$('#ye_Period').val(),
					fPeriod:node.text,
					departId:node.id,
					type:$('#ye_type').val()
				}); 
	         }  
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
	if(val=='KMJB-01'){
		return '一级科目';
	}else if(val=='KMJB-02'){
		return '二级科目';
	}else if(val=='KMJB-03'){
		return '三级科目';
	}else if(val=='KMJB-04'){
		return '四级科目';
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
		var row = $('#Economic_dg').datagrid('getSelected');
		var selections = $('#Economic_dg').datagrid('getSelections');
		if(null!=row && selections.length==1){
		    var win=creatWin('查看-经济分类科目',850,250,'icon-edit','/economic/view/'+row.fid);
		    win.window('open');
		}else{
			 $.messager.alert('系统提示','请选择一条要查看的数据！','info');
		}
	}
	function reSetPassword(){
		var row = $('#Economic_dg').datagrid('getSelected');
		var selections = $('#Economic_dg').datagrid('getSelections');
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
		var row = $('#Economic_dg').datagrid('getSelected');
		var selections = $('#Economic_dg').datagrid('getSelections');
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
								$("#Economic_dg").datagrid('reload');
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
		var row = $('#Economic_dg').datagrid('getSelected');
		var selections = $('#Economic_dg').datagrid('getSelections');
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
								$("#Economic_dg").datagrid('reload');
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
	function deleteEconomic(deId,fEjProCode){
		var row=$('#EconomicTree').tree('getSelected');
		if(confirm("确定删除吗？")){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/yearsUnionBasic/subjectDelete?departId='+row.id+'&deId='+deId+'&fEjProCode='+fEjProCode,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#Economic_dg").datagrid('reload');
							}else{
								$.messager.alert('系统提示',data.info,'error');
							}
						} 
					});
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
		var node=$('#EconomicTree').tree('getSelected');
		$('#Economic_dg').datagrid('load',{ 
			name:$('#ye_Name').val(),
			code:$('#ye_Period').val(),
			fPeriod:node.text,
			fbId:node.id,
			type:$('#ye_type').val()
		}); 
	}
	function addEconomic(){
		var node=$('#EconomicTree').tree('getSelected');
		//var win=creatWin('新增-经济分类科目',750,250,'icon-add','/yearsUnionBasic/add');
		if(null!=node){
			win=creatWin('新增-二级分类',710,580,'icon-search','/yearsUnionBasic/ecBasicOrDepartAdd?departId='+node.id);
		}
		win.window('open');
	}
	function editUser(){
		var row=$('#EconomicTree').tree('getSelected');
		//var selections = $('#EconomicTree').tree('getSelections');
		if(null!=row ){
		    var win=creatWin('修改-二级分类',710,580,'icon-search','/yearsUnionBasic/ecBasicOrDepartAdd?departId='+row.id);
		    win.window('open');
		}else{
			 $.messager.alert('系统提示','请选择一条数据！','info');  
		}
	}
   $('#EconomicTree').tree({
    	onClick: function(node){
			$('#Economic_dg').datagrid('load',{ 
				fPeriod:node.text,
				departId:node.id,
				
			}); 
    	}
    }); 
   /*  function da(){
    	var node=$('#EconomicTree').tree('getSelected');
    	console.log(node)
    } */
	/* $('#EconomicTree').tree({
		onClick: function(node){
			console.log(node)
			$('#Economic_dg').datagrid('load',{ 
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


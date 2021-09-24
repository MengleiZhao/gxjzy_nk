<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
			   <tr>
						<td class="top-table-td1">模板名称：</td> 
						<td class="top-table-td2">
							<input id="yb_ftName" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						</td>
						<td class="top-table-td1">应用年份：</td> 
						<td class="top-table-td2">
							<input id="yb_fPeriod" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
						</td>
						<td style="width: 12px">
						</td>
						<td style="width: 24px;">
							<a href="javascript:void(0)"  onclick="queryYb();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
									onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
						</td>
						<td style="width: 12px">
						</td>
						<td style="width: 24px;">
							<a href="javascript:void(0)"  onclick="clearTable();"><img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"
									onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"></a>
						</td>
						<td style="width: 12px">
						</td>
						<td align="right">
							<a href="#"   onclick="addYb()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/xz2.png')"
									onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/xz1.png')"></a>
						</td>
						<td style="width: 14px">
						</td>
					</tr>
					<tr id="helpTr" style="display: none;">
					</tr>
				</table>

		</div>
		
		<div class="list-table">
		<table id="yb_dg" border="0" class="easyui-datagrid"
				data-options="singleSelect:true,collapsible:true,url:'${base}/accoYear/JsonPagination',
				method:'post',fit:true,pagination:true,singleSelect: true,
				selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<th data-options="field:'fbId',hidden:true"></th>
					<th data-options="field:'number',align:'center'" width="5%">序号</th>
					<th data-options="field:'fPeriod',align:'left',resizable:false,sortable:true" width="20%">应用年份</th>
					<th data-options="field:'ftName',align:'left',resizable:false,sortable:true" width="20%">模板名称</th>
					<th data-options="field:'fRemark',align:'left',resizable:false,sortable:true" width="15%">启用状态</th>
					<th data-options="field:'creator',align:'left',resizable:false,sortable:true" width="15%">创建人</th>
					<th data-options="field:'createTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" width="15%">创建时间</th>
					<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ" width="10%">操作</th>
					<!--<th data-options="field:'pid',align:'center',resizable:false" width="10%">上级科目编号</th>
					<th data-options="field:'on',align:'center',resizable:false" width="10%">是否启用</th>
					<th data-options="field:'type',align:'center',resizable:false" width="10%">科目类型</th>
					 <th data-options="field:'cuser',align:'center',resizable:false" width="8%">创建人</th>
					<th data-options="field:'ctime',align:'center',resizable:false" width="10%">创建时间</th> -->
					<!-- <th data-options="field:'locked',align:'center',resizable:false" width="10%">是否锁定</th> -->
				</tr>
			</thead>
		</table>
    </div>
</div>
<script type="text/javascript">
//分页样式调整
$(function(){
	var pager = $('#yb_dg').datagrid().datagrid('getPager');	// get the pager of datagrid
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

function CZ(val, row) {
	return  '<table><tr style="width: 105px;height:20px"><td style="width: 25px">'
			+'<a href="#" onclick="detail(' + row.fbId
			+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png"></a>'
			+ '</td><td style="width: 25px">'
			+'<a href="#" onclick="editYb(' + row.fbId
			+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png"></a>'
			+ '</td><td style="width: 25px">'
			+'<a href="#" onclick="deleteYb(' + row.fbId
			+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png"></a>'
			+ '</td><td style="width: 25px">'
			+'<a href="#" onclick="copymodel(' + row.fbId
			+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/othersave1.png"></a>'
			+ '</td></tr></table>';
}
function showB(obj){
	obj.src=base+'/resource-modality/${themenurl}/select2.png';
}
function showA(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
}
function showC(obj){
	obj.src=base+'/resource-modality/${themenurl}/update2.png';
}
function showD(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/update1.png';
}
function showE(obj){
	obj.src=base+'/resource-modality/${themenurl}/delete2.png';
}
function showF(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/delete1.png';
}
function showG(obj){
	obj.src=base+'/resource-modality/${themenurl}/othersave2.png';
}
function showH(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/othersave1.png';
}
	function view(){
		var row = $('#yb_dg').datagrid('getSelected');
		var selections = $('#yb_dg').datagrid('getSelections');
		if(null!=row && selections.length==1){
		    var win=creatWin('查看-经济分类科目',850,250,'icon-edit','/accoYear/view/'+row.fid);
		    win.window('open');
		}else{
			 $.messager.alert('系统提示','请选择一条要查看的数据！','info');
		}
	}
	function reSetPassword(){
		var row = $('#yb_dg').datagrid('getSelected');
		var selections = $('#yb_dg').datagrid('getSelections');
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
		var row = $('#yb_dg').datagrid('getSelected');
		var selections = $('#yb_dg').datagrid('getSelections');
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
								$("#yb_dg").datagrid('reload');
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
		var row = $('#yb_dg').datagrid('getSelected');
		var selections = $('#yb_dg').datagrid('getSelections');
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
								$("#yb_dg").datagrid('reload');
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
	function deleteYearsBsaic(){
		var row = $('#yb_dg').datagrid('getSelected');
		var selections = $('#yb_dg').datagrid('getSelections');
		console.log(row.fbId);
		if(null!=row && selections.length==1){
			if(row.status=='10'){
				$.messager.alert('系统提示','离岗后才能删除!','info');
				return;
			}
			$.messager.confirm('系统提示','确认删除用户吗?',function(r){
				if(r){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/accoYear/delete/'+row.fbId,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#yb_dg").datagrid('reload');
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
	function queryYb(){
		$('#yb_dg').datagrid('load',{ 
			ftName:$('#yb_ftName').val(),
			fPeriod:$('#yb_fPeriod').val(),
		}); 
	}
	function detail(id) {
		var win = creatWin('查看', 650, 300, 'icon-search','/accoYear/detail/' + id);
		win.window('open');
	}	
	function deleteYb(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/accoYear/delete/' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#yb_dg').form('clear');
						$("#yb_dg").datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	}	
	function addYb(){
		var win=creatWin('新增-年度模板管理',650,300,'icon-search','/accoYear/add');
		win.window('open');
	}
	function editYb(id){
		var win=creatWin('修改-年度模板管理',650,300,'icon-search','/accoYear/edit/'+id);
		win.window('open');
	}
	function copymodel(id){
		var win=creatWin('另存-年度模板管理',650,300,'icon-search','/accoYear/copymodel/'+id);
		win.window('open');
	}
	$('#userDepartTree').tree({
		onClick: function(node){
			$('#yb_dg').datagrid('load',{ 
				departId:node.id
			}); 
		}
	});
	function streetChange(streetCode){
		$('#streetJwh').combobox('reload',"${base}/street/jwh?streetCode="+streetCode);
	}
	
	//时间格式化
	function ChangeDateFormat(val) {
		//alert(val)
		var t, y, m, d, h, i, s;
		if (val == null) {
			return "";
		}
		t = new Date(val)
		y = t.getFullYear();
		m = t.getMonth() + 1;
		d = t.getDate();
		h = t.getHours();
		i = t.getMinutes();
		s = t.getSeconds();
		// 可根据需要在这里定义时间格式  
		return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
	}
</script>
</body>
</html>


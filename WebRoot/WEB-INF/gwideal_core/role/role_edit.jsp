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
	$('#edit_departid').combobox({
	    onChange:function(newValue,oldValue){
	    	//设置部门名称
	    	$('#edit_departname').val($('#edit_departid').combobox('getText'));
	    }
	});
	function roleEditForm(){
		//将功能树选中的值设置到隐藏文本上
		var nodes = $('#functionRoleTree').tree('getChecked');
		var fIds = '';
		for(var i=0; i<nodes.length;i++){
			if (fIds!='') fIds+=',';
			fIds+= nodes[i].id;
		}
		$('#funcIds').val(fIds);
		//form 提交
		var flag=false;
		$('#roleEditForm').form('submit', {
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
					$('#roleEditForm').form('clear');
					$("#role_dg").datagrid('reload');
				}else{
					$.messager.alert('系统提示',data.info,'error');
					closeWindow();
					$('#roleEditForm').form('clear');
				}
			} 
		});
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
		parentNode = $('#functionRoleTree').tree('getParent',parentNode.target);
		if(parentNode!=null){
			getParentNode(parentNode,isFlag);
		}
	}
	//循环父节点下是否有子节点选中
	function forParentCheckMethod(parentNode,isFlag){
		//获取子节点
		var childRows = $('#functionRoleTree').tree('getChildren',parentNode.target);
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
				$('#functionRoleTree').tree(isFlag, childRows[i].target);
			}
		}
	}
	//复选框选中事件
	function checkTreeMethod (node,checked){
			//获取父节点
			var parentNode = $('#functionRoleTree').tree('getParent',node.target);
			//获取子节点
			var childRows = $('#functionRoleTree').tree('getChildren',node.target);
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
	
	//打开指标选择页面
	function openDepart(selectType) {
		//var win=creatFirstWin('选择指标',860,580,'icon-search','/quota/choiceIndex');
		var win=creatSearchDataWin('选择指标',560,480,'icon-search',"/depart/refUserDepart/"+selectType); 
		win.window('open');
	}
	function isUserTreeExist(name){
		for(var i=0; i<names.length; i++){
			if(names[i] == name){
				return true;
			}
		}
		return false;
	}
</script>
    <div class="easyui-layout" fit="true">
    	<div style="height:430px;overflow:auto">
	    	<form id="roleEditForm" action="${base}/role/save" method="post" data-options="novalidate:true" class="easyui-form">
	    		<input type="hidden" name="id" value="${bean.id}"/>
	    		<input type="hidden" name="funcIds" id="funcIds"/>
				<table border="0" cellpadding="0" cellspacing="0" class="main_table">
					<%-- <tr style="height: 5px;"></tr>
					<%-- <tr>
						<th width="20%" style="text-align: right;"><span style="color: red;">*</span>&nbsp;角色代码</th>
						<td width="80%" colspan="4">
							<input class="easyui-textbox" type="text" name="code" data-options="required:true,validType:'length[1,50]'" size="50" value="${bean.code}"/>
						</td>
					<td class="td3-ys"></td>
					</tr> --%>
					<tr style="height: 5px;"></tr>
					
					<tr>
						<th style="text-align: right;"><span style="color: red;">*</span>&nbsp;角色名称&nbsp;</th>
						<td colspan="4">
							<input class="easyui-textbox" type="text" name="name" data-options="required:true,validType:'length[1,50]'" size="50" value="${bean.name}"/>
						</td>
						<td class="td3-ys"></td>
					</tr>
					<tr style="height: 5px;"></tr>
					<tr>
						<th style="text-align: right;"><span style="color: red;">*</span>归属部门：</th>
						<td colspan="4">
							<input type="hidden" id="edit_departname" name="departname" value="${bean.departname }">
							<input class="easyui-combobox" style="width: 100%;height: 30px; " value="${bean.departid}" id="edit_departid" name="departid" required="required"  data-options="editable:false,panelHeight:'auto',url:'${base}/apply/chooseDepart?selected=${bean.departid}',method:'POST',valueField:'code',textField:'text',editable:false,validType:'selectValid'"/>
							</td>
					<td class="td3-ys"></td>
					</tr>
					<tr style="height: 5px;"></tr>
					<tr>
						<th style="text-align: right;"><span style="color: red;">*</span>&nbsp;排列顺序&nbsp;</th>
						<td colspan="4">
							<input class="easyui-textbox" type="text" name="orderNo" data-options="required:true,validType:'length[1,10]'" size="50" value="${bean.orderNo}"/>
						</td>
					<td class="td3-ys"></td>
					</tr>
					<tr style="height: 5px;"></tr>
					<tr>
						<th style="text-align: right;">&nbsp;&nbsp;描述&nbsp;</th>
						<td colspan="4">
							<input class="easyui-textbox" type="text" name="description" data-options="multiline:true,validType:'length[1,200]'" size="50" style="height:100px" value="${bean.description}"/>
						</td>
					<td class="td3-ys"></td>
					</tr>
					<tr style="height: 5px;"></tr>
					<tr>
						<th style="text-align: right;">&nbsp;&nbsp;拥有的功能&nbsp;</th>
						<td colspan="4">
							<ul id="functionRoleTree" class="easyui-tree" data-options="url:'${base}/role/functionTree?roleId=${bean.id}',animate:true,lines:true,checkbox:true,cascadeCheck:false,onCheck:checkTreeMethod,"></ul>
						</td>
					<td class="td3-ys"></td>
					</tr>
				</table>
			</form>
		</div>
		<div class="south" style="text-align: center;">
			<a href="javascript:void(0)" onclick="roleEditForm();">
				<img src="${base}/resource-modality/img/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a> 
			<a href="javascript:void(0)" onclick="closeWindow();">
				<img src="${base}/resource-modality/img/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
		</div>
	</div>
</body>
</html>


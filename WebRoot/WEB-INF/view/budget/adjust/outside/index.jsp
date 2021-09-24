<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="win-div">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true" style="width: 600px">
			<div class="tab-wrapper" id="choice" style="height: 440px">
				<ul class="tab-menu">
					<li class="active" onclick="$('#basic-choose-tree').datagrid('reload'),tablist=1">基本支出指标</li>
					<li onclick="$('#pro-choose-tree').treegrid('reload'),tablist=2">项目支出指标</li> 
				</ul>
				
				<div class="tab-content">
					<div style="height: 400px">
						<table id="basic-choose-tree"  class="easyui-datagrid" style="width:100%;"
				            data-options="
				                url: '${base}/quota/insideOrProject?indexType=0',onClickRow:clickIndex,checkbox: true,
				            	collapsible:true,method:'post',fit:true,pagination:true,singleSelect: false,rownumbers:true,
								selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true,
				            ">
				        	<thead>
				            	<tr>
				                <th data-options="field:'bId',hidden:true"></th>
				                <th data-options="field:'ck',checkbox:'true',name:'test' "></th>
				                <th data-options="field:'indexName'" width="25%">预算指标名称</th>
				                <th data-options="field:'pfAmount',formatter:pfcolor" width="25%" >指标批复金额[万元]</th>
				                <th data-options="field:'syAmount',formatter:sycolor" width="25%" >指标剩余金额[万元]</th>
				                <th data-options="field:'djAmount',formatter:djcolor" width="25%" >指标冻结金额[万元]</th>
				            	</tr>
				        	</thead>
				    	</table> 
					</div>
					
					<div style="height: 400px">
						<table id="pro-choose-tree"  class="easyui-treegrid" style="width:100%;"
				            data-options="
				                url: '${base}/quota/treeIndex',
				                method: 'get',
				                idField: 'id',
				                treeField: 'text',
				                checkbox: true,
				                singleSelect: false,
				               onClickRow:clickIndex
				            ">
					        <thead>
					            <tr>
					                <th data-options="field:'text'" width="30%" > 预算指标名称</th>
					                <th data-options="field:'col1',formatter:pfcolor" width="23%">批复金额[万元]</th>
					                <th data-options="field:'col2',formatter:sycolor" width="23%">可用金额[万元]</th>
					                <th data-options="field:'col3',formatter:djcolor" width="24%">冻结金额[万元]</th>
					            </tr>
					        </thead>
					    </table> 
					</div>
					
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="confirmKm(${drdc})">
				<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeFirstWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
			
		</div>
	</div>
</div>
	
<script type="text/javascript">
var tablist=1;
//初始化
$(function(){
	//tab
	flashtab('choice');
});

function confirmKm(){
	var bids = '';
	var pids='';
	if(tablist==1){
		row = $('#basic-choose-tree').datagrid('getSelected');
		var basicnodes = $('#basic-choose-tree').datagrid('getSelections');
		for(var i=0; i<basicnodes.length; i++){
			if(bids==''){
				bids=basicnodes[i].bId;
			}else{
				bids=bids+","+basicnodes[i].bId;
			}
		}
	}else if(tablist==2){
		//var pronodes = $("#pro-choose-tree").treegrid("getCheckedNodes");
		//var pronodes = $('#pro-choose-tree').treegrid('getAllChecked', true);
		var pronodes = $('#pro-choose-tree').datagrid('getSelections');
		for(var i=0; i<pronodes.length; i++){
			if(pids==''){
				pids=pronodes[i].col4;
			}else{
				pids=pids+","+pronodes[i].col4;
			}
			
		}
		//如果只勾选父节点，会出现取不到子节点的问题
		pids=getDate(pids);
		if(pids==""){
			 //提示信息
		     $.messager.alert('系统提示',"请勾选被调整的指标！",'info');
		      return false;
		}
	}
	
	$('#zbtz').datagrid('reload',{
		bids:bids,
		pids:pids
	});
	
	//将指标调整表格的焦点清除
	editIndex_outcome = undefined;
	closeFirstWindow();
}
function getDate(pids){
	var rows = $("#pro-choose-tree").treegrid("getData");
   	for(var i=0; i<rows.length; i++){
   		var checkState=rows[i].checkState;
   		if(checkState=="checked"){
   			var children=$('#pro-choose-tree').treegrid("getChildren",rows[i].id);
   			for(var c=0;c<children.length;c++){
   				if(pids==''){
					pids=children[c].col4;
				}else{
					pids=pids+","+children[c].col4;
				}
   			}
   			
   		}
   	}
   	return pids;
}








function clickIndex(node, checked) {
	if(tablist==2){ //项目指标
		if (node.leaf==false) {//如果是父节点，就展开子节点，并且取消改行被选中状态
			$(this).treegrid("toggle", node.id);//就展开子节点
			//$("#pro-choose-tree").datagrid("unselectRow", node.id);//取消改行被选中状态
	       // return false; 
	    }else{
	    	if(node.checkState=="checked"){
	    		$("#pro-choose-tree").treegrid("uncheckNode",node.id);  //根据ID取消勾选节点	 
	    	}else{
	    		$("#pro-choose-tree").treegrid("checkNode",node.id);  //根据ID勾选节点
	    	}
		}
		/*  var childNode =$(this).treegrid('getChildren', node.id);
		 if(childNode.length > 0) {
	        for (var i = 0; i < childNode.length; i++) {
	        	$(this).treegrid('check', childNode[i].id);//子节点勾选
	        }
	    } */
	}
	
}
function childrenCheck(node, checked){
	 var childNode =$(this).treegrid('getChildren', node.target);
	 if(childNode.length > 0) {
        for (var i = 0; i < childNode.length; i++) {
        	$(this).treegrid('check', childNode[i].target);//子节点勾选
        }
    }
}


//批复金额颜色
function pfcolor(val, row) {
	val = listToFixed(val, row);
	return '<span style="color:#5196d4">'+val+'</span>';
}

//剩余金额颜色
function sycolor(val, row) {
	val = listToFixed(val, row);
	return '<span style="color:#97cd5c">'+val+'</span>';
}

//冻结金额颜色
function djcolor(val, row) {
	val = listToFixed(val, row);
	return '<span style="color:#999999">'+val+'</span>';
} 
</script>
</body>

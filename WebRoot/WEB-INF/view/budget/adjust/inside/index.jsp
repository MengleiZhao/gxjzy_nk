<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="win-div">
	<div class="easyui-layout" style="height: 535px;">
		<div class="win-left-div" data-options="region:'west',split:true" style="width: 720px">
			<div class="list-top">
				<table class="top-table" cellpadding="0" cellspacing="0">
					<tr>
						<td class="top-table-search-pro" class="queryth">
							预算指标名称&nbsp;
							<input id="inside_indexNameOut" name="" style="width: 100px; height:25px;" class="easyui-textbox"></input>
							&nbsp;&nbsp;
							指标部门&nbsp;
							<input id="inside_deptName" name="" style="width: 100px; height:25px;" class="easyui-textbox"></input>
							&nbsp;&nbsp;
							<a href="#" onclick="query();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>
							<a href="#" onclick="clearTable();">
								<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>
						</td>
						<c:if test="${drdc == '1'}">
							<td align="right" style="padding-right: 10px">
								<a href="#" onclick="add()">
									<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
								</a>
							</td>
						</c:if>
					</tr>
				</table>
			</div>
			
			<div class="list-table">
				<div class="tab-wrapper" id="choice" style="height: 440px">
					<ul class="tab-menu">
						<c:if test="${indexType=='0'}">
						<li class="active" onclick="$('#basic-choose-tree').datagrid('reload')">基本支出指标</li>
						</c:if>
						<c:if test="${indexType=='1'}">
						<li onclick="$('#pro-choose-tree').treegrid('reload')">项目支出指标</li> 
						</c:if>
					</ul>
					
					<div class="tab-content">
						<c:if test="${indexType=='0'}">
						<div style="height: 400px">
							<table id="basic-choose-tree"  class="easyui-treegrid" style="width:98%;height: 400px"
					            data-options="
					                url: '${base}/quota/treeIndex?indexType=0&changeType=${ changeType}&isAcrossDept=${isAcrossDept }&drdc=${drdc }',
				               		method: 'get',
					                idField: 'id',
					                treeField: 'text',
					                checkbox: true,
					                singleSelect: false,
					                onClickRow:clickIndex
					            ">
					        	<thead>
					            	<tr>
						               <!--  <th data-options="field:'bId',hidden:true"></th>
						                <th data-options="field:'ck',checkbox:'true',name:'test' "></th>
						                <th data-options="field:'indexName'" width="25%">预算指标名称</th>
						                <th data-options="field:'pfAmount',formatter:pfcolor" width="25%" >指标批复金额[万元]</th>
						                <th data-options="field:'syAmount',formatter:sycolor" width="25%" >指标剩余金额[万元]</th>
						                <th data-options="field:'djAmount',formatter:djcolor" width="24%" >指标冻结金额[万元]</th> -->
						                <th data-options="field:'text',align:'left',formatter:formatCellTooltip" width="42%" >预算指标名称</th>
						                <th data-options="field:'col1',align:'left',formatter:pfcolor" width="20%">批复金额</th>
						                <th data-options="field:'col2',align:'left',formatter:sycolor" width="20%">可用金额</th>
						                <th data-options="field:'col3',align:'left',formatter:djcolor" width="20%">冻结金额</th>
					            	</tr>
					        	</thead>
					    	</table> 
						</div>
						</c:if>
						
						<c:if test="${indexType=='1'}">
						<div style="height: 400px">
							<table id="pro-choose-tree"  class="easyui-treegrid" style="width:98%;height: 400px"
				 				 data-options="
					                url: '${base}/quota/treeIndex?indexType=1&changeType=${ changeType}&isAcrossDept=${isAcrossDept }&drdc=${drdc }',
					                method: 'get',
					                idField: 'id',
					                treeField: 'text',
					                checkbox: true,
					                singleSelect: false,
					               onClickRow:clickIndex
					            ">
						        <thead>
						            <tr>
						                <th data-options="field:'text',align:'left',formatter:formatCellTooltip" width="42%" >预算指标名称</th>
						                <th data-options="field:'col1',align:'left',formatter:pfcolor" width="20%">批复金额</th>
						                <th data-options="field:'col2',align:'left',formatter:sycolor" width="20%">可用金额</th>
						                <th data-options="field:'col3',align:'left',formatter:djcolor" width="20%">冻结金额</th>
						            </tr>
						        </thead>
						    </table> 
						</div>
						</c:if>
					</div>
				</div>
			</div>	
			
			<div class="win-left-bottom-div" style="height: 40px;">
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
var tablist='${indexType}';
//初始化
$(function(){
	//tab
	flashtab('choice');
	
});

function confirmKm(drdc){
	var bids = '';
	var pids='';
	//
	if(tablist==0){
		var basicnodes = $('#basic-choose-tree').datagrid('getSelections');
		for(var i=0; i<basicnodes.length; i++){
			if(bids==''){
				bids=basicnodes[i].col4;
			}else{
				bids=bids+","+basicnodes[i].col4;
			}
		}
	}else if(tablist==1){
		var pronodes = $('#pro-choose-tree').datagrid('getSelections');
		for(var i=0; i<pronodes.length; i++){
			if(pids==''){
				pids=pronodes[i].col4;
			}else{
				pids=pids+","+pronodes[i].col4;
			}
		} 
	}
	//如果只勾选父节点，会出现取不到子节点的问题
	pids=getDate(pids);
	if(pids==""){
		 //提示信息
	     $.messager.alert('系统提示',"请勾选被调整的指标！",'info');
	      return false;
	}
	//重新加载表格内容
	if(drdc == 0) {
		$('#zbdc').datagrid('reload',{bids:bids,pids:pids});
		//调出金额清空
		$('#snum1').textbox('setValue',0);
		$('#snum2').textbox('setValue',0);
	} else if(drdc == 1) {
		$('#zbdr').datagrid('reload',{bids:bids,pids:pids});
		$('#snum3').textbox('setValue',0);
		//调入指标清空
	}
	//将调入调出表格的焦点清除
	editIndex_outcome = undefined;
	editIndex_outcome2 = undefined;
	//关闭指标选择页面
	closeFirstWindow();
}
function getDate(pids){
	var rows = null;
	if(tablist==0){
		rows = $("#basic-choose-tree").treegrid("getData");
	}else if(tablist==1){
		rows = $("#pro-choose-tree").treegrid("getData");
	}
   	for(var i=0; i<rows.length; i++){
   		var checkState=rows[i].checkState;
   		if(checkState=="checked"||checkState=="indeterminate"){
   			var children = null;
   			if(tablist==0){
	   			children=$('#basic-choose-tree').treegrid("getChildren",rows[i].id);
   			}else if(tablist==1){
	   			children=$('#pro-choose-tree').treegrid("getChildren",rows[i].id);
   			}
   			for(var c=0;c<children.length;c++){
   				if(children[c].checkState=="checked"){
	   				if(pids==''){
						pids=children[c].col4;
					}else{
						pids=pids+","+children[c].col4;
					}
   				}
   			}
   			
   		}
   	}
   	return pids;
}
function clickIndex(node, checked) {
	/* if(tablist==2){ //项目指标 */
		if (node.leaf==false) {//如果是父节点，就展开子节点，并且取消改行被选中状态
			$(this).treegrid("toggle", node.id);//就展开子节点
			//$("#pro-choose-tree").datagrid("unselectRow", node.id);//取消改行被选中状态
	       // return false; 
	   /*  }else{
	    	if(node.checkState=="checked"){
	    		$("#pro-choose-tree").treegrid("uncheckNode",node.id);  //根据ID取消勾选节点	 
	    	}else{
	    		$("#pro-choose-tree").treegrid("checkNode",node.id);  //根据ID勾选节点
	    	}
		} */
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
	val = listToFixed(val);
	return '<span style="color:#5196d4">'+val+'</span>';
}

//剩余金额颜色
function sycolor(val, row) {
	val = listToFixed(val);
	return '<span style="color:#97cd5c">'+val+'</span>';
}

//冻结金额颜色
function djcolor(val, row) {
	val = listToFixed(val);
	return '<span style="color:#999999">'+val+'</span>';
}


//点击查询
function query() {
	
	var id = "";
	if(tablist==1){
		id = "pro-choose-tree";
	}else if(tablist==0){
		id = "basic-choose-tree";
	}
	$('#'+id).treegrid('load', {
		indexNameOut:$('#inside_indexNameOut').textbox('getValue'),
		deptName:$('#inside_deptName').textbox('getValue'),
	});
}
//清除查询条件
function clearTable() {
	
	var id = "";
	if(tablist==1){
		id = "pro-choose-tree";
	}else if(tablist==0){
		id = "basic-choose-tree";
	}
	$("#inside_indexNameOut").textbox('setValue','');
	$("#inside_deptName").textbox('setValue','');
	$('#'+id).treegrid('load',{
		
	});	//清空以后，重新查一次
}
function add(){
	
	var rows = null;
	if(tablist==1){
		rows = $("#pro-choose-tree").treegrid("getData");
	}else if(tablist==0){
		rows = $("#basic-choose-tree").treegrid("getData");
	}
   	var h = 0;
   	var id = '';
   	for(var i=0; i<rows.length; i++){
   		var checkState=rows[i].checkState;
   		if(checkState=="checked"){
   			h++;
   			id = rows[i].id;
   		}
   	}
   	if(h != 1){
   		alert("请选择一条且只能选择一条指标！");
   		return
   	}
   	closeFirstWindow();
   	if(tablist==0){
   		var win = creatFirstWin('基本支出明细', 920,580, 'icon-search', '/insideAdjust/detailIndex?id='+id+'&tablist='+tablist);
   	}else if(tablist==1){
   		var win = creatFirstWin('项目支出明细', 920,580, 'icon-search', '/insideAdjust/detailIndex?id='+id+'&tablist='+tablist);
   	}
   	
	win.window('open');
}
</script>
</body>

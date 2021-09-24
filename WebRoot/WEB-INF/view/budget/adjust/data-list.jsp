<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<style type="text/css">
 .datagrid-cell {
     text-overflow: ellipsis;
 }
 /* 边框样式 */
.datagrid-body td{
  border-bottom: 1px dashed #ccc;
  border-right: 1px dashed #ccc;
}
.datagrid-htable tr td{
	border-right: 1px solid #fff;
	border-bottom: 1px solid #fff;
}
.progressbar-value,
.progressbar-value .progressbar-text {
  color: #000000;		
}	
</style>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
			
			<div class="list-table" style="height:520px">
				<table id="data_analysis" class="easyui-datagrid" 
		data-options="collapsible:true,url:'${base}/insideAdjust/listData',
			method:'post',fit:true,pagination:false,singleSelect: true,rowStyler:function(index,row){  if (row[0]=='合计'){ return 'background-color:#EFEFEF;color:black;font-weight:bold;'; } if (row[${size*3+4}]=='depart'){ return 'background-color:#EFEFEF;color:black;font-weight:bold;'; }},
			nowrap:true,striped: true,fitColumns: true" >
					            <thead >
					        	<tr>
					        		<th data-options="rowspan:2,field:'0',align:'center',halign: 'center',resizable:true" style="width: 15%"></th>
									<c:forEach items="${adjustEconomicList}"  var="list">
										<th colspan="3" data-options="align:'center'">${list[2]}</th>
									</c:forEach>
									<th data-options="rowspan:2,field:'${size*3+1}',align:'center',halign: 'center',resizable:true,formatter:listToFixed1" style="width: 12%">年初预算数汇总</th>
									<th data-options="rowspan:2,field:'${size*3+2}',align:'center',halign: 'center',resizable:true,formatter:listToFixed1" style="width: 12%">累计调整数汇总</th>
									<th data-options="rowspan:2,field:'${size*3+3}',align:'center',halign: 'center',resizable:true,formatter:listToFixed1" style="width: 12%">最新预算数汇总</th>
								</tr>
								<tr>
									<c:forEach	var="i" items="${adjustEconomicList}" varStatus="val">
									<th data-options="field:'${val.index*3+1}',align:'center',halign: 'center',resizable:true,formatter:listToFixed1" style="width: 12%">年初预算数</th>
									<th data-options="field:'${val.index*3+2}',align:'center',halign: 'center',resizable:true,formatter:listToFixed1" style="width: 12%">累计调整数</th>
									<th data-options="field:'${val.index*3+3}',align:'center',halign: 'center',resizable:true,formatter:listToFixed1" style="width: 12%">最新预算数</th>
									</c:forEach>
								</tr>
								</thead>
					    	</table> 
						</div>
						
			</div>	
			
	
<script type="text/javascript">
var tablist=1;
//初始化
$(function(){
	//tab
	flashtab('choice');
	
});
//金额数据保留两位
function listToFixed1(val) {
	if(val != null && val != ""){
		var	num = (parseFloat(val)*10000).toFixed(2);
	    return num.toString().replace(/\d+/, function (n) { // 先提取整数部分
	        return n.replace(/(\d)(?=(\d{3})+$)/g, function ($1) { // 对整数部分添加分隔符
	            return $1 + ",";
	        });
	    });
	} else {
		val=0;
		return val.toFixed(2);
	}
}
function confirmKm(drdc){
	var bids = '';
	var pids='';
	//
	/* if(tablist==1){
		var basicnodes = $('#basic-choose-tree').datagrid('getSelections');
		for(var i=0; i<basicnodes.length; i++){
			if(bids==''){
				bids=basicnodes[i].col4;
			}else{
				bids=bids+","+basicnodes[i].col4;
			}
		}
	}else if(tablist==2){
		var pronodes = $('#pro-choose-tree').datagrid('getSelections');
		for(var i=0; i<pronodes.length; i++){
			if(pids==''){
				pids=pronodes[i].col4;
			}else{
				pids=pids+","+pronodes[i].col4;
			}
		} 
	} */
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
	if(tablist==1){
		rows = $("#basic-choose-tree").treegrid("getData");
	}else if(tablist==2){
		rows = $("#pro-choose-tree").treegrid("getData");
	}
   	for(var i=0; i<rows.length; i++){
   		var checkState=rows[i].checkState;
   		if(checkState=="checked"||checkState=="indeterminate"){
   			var children = null;
   			if(tablist==1){
	   			children=$('#basic-choose-tree').treegrid("getChildren",rows[i].id);
   			}else if(tablist==2){
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
	val = listToFixed1(val);
	return '<span style="color:#5196d4">'+val+'</span>';
}

//剩余金额颜色
function sycolor(val, row) {
	val = listToFixed1(val);
	return '<span style="color:#97cd5c">'+val+'</span>';
}

//冻结金额颜色
function djcolor(val, row) {
	val = listToFixed1(val);
	return '<span style="color:#999999">'+val+'</span>';
}


//点击查询
function query() {
	$('#choice').datagrid('load', {
		indexNameOut:$('#inside_indexNameOut').val(),
	});
}
//清除查询条件
function clearTable() {
	$("#inside_indexNameOut").textbox('setValue','');
	$('#choice').datagrid('load',{});	//清空以后，重新查一次
}
</script>
</body>

<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>

<body>
<div class="win-div">
		<div style="height: 400px">
			<table id="expend-detail-table"  class="easyui-datagrid" style="width:100%;"
	            data-options="
	                url: '${base}/quota/getExpDetailList?fproid=${fproid }',checkbox: true,
	              	collapsible:true,method:'post',fit:true,pagination:false,singleSelect: false,
					selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true,
	            ">
	        	<thead>
	            	<tr>
	                <th data-options="field:'pid',hidden:true"></th>
	                <th data-options="field:'num'" width="5%">序号</th>
	                 <th data-options="field:'ck',checkbox:'true',name:'test' "></th>
	                 <th data-options="field:'expCode'" width="25%">指标编码</th>
	                <th data-options="field:'activity'" width="25%">指标名称</th>
	                <th data-options="field:'syAmount'" width="22%" >可用金额[元]</th>
	            	</tr>
	        	</thead>
	    	</table> 
		</div>
</div>
	<div class="win-left-bottom-div">
		<a href="javascript:void(0)" onclick="confirmIndex()">
		<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>&nbsp;&nbsp;
		<a href="javascript:void(0)" onclick="closeSecondWindow()">
		<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
	</div>

<script type="text/javascript">

var tablist=0;

function confirmIndex(){
	var activitys = '';
	var pids = '';
	var nodes = $('#expend-detail-table').datagrid('getSelections');
	for(var i=0; i<nodes.length; i++){
		if(pids==''){
			pids=nodes[i].pid;
			activitys=nodes[i].activity;
		}else{
			pids=pids+","+nodes[i].pid;
			activitys=activitys+"|"+nodes[i].activity;
		}
	}
	/* //把值设置进单元格里
     var row  = $('#pro-choose-tree').datagrid('getRows', ${index});  
     var view = $('.datagrid-view');
     for (var i = 0; i < view.length; i++) {
         if ($(view[i]).children($('#pro-choose-tree').selector).length  > 0) {
             var view = $(view[i]).children('.datagrid-view2');
             var td = $(view).find('.datagrid-body td[field="activitys"]')[${index}];
             var div = $(td).find('div')[0];
             $(div).text(activitys);
         }
     }
     row["activitys"] = activitys;
     row["pids"] = pids;
     $('#pro-choose-tree').datagrid('clearSelections'); */
     
     
  // 得到columns对象
     var columns = $('#pro-choose-tree').datagrid("options").columns;
     // 得到rows对象
     var rows = $('#pro-choose-tree').datagrid("getRows"); // 这段代码是// 对某个单元格赋值
     rows[${index}][columns[0][8].field]=activitys;
     rows[${index}][columns[0][0].field]=pids;
     // 刷新该行, 只有刷新了才有效果
     $('#pro-choose-tree').datagrid('refreshRow', ${index});
	//关闭指标选择页面
	closeSecondWindow();
}

//查询
function queryIndex() {
	var tab = $('#tree').tabs('getSelected');
	var index = $('#tree').tabs('getTabIndex',tab);
	if(index == 0) {
		$('#expend-detail-table').treegrid('load',{ 
			depart:$('#indexDepartName').textbox('getValue'),
		}); 
	} else if (index == 1) {
		$('#expend-detail-table').treegrid('load',{ 
			depart:$('#indexDepartName').textbox('getValue'),
		});
	}
}

</script>
</body>

	
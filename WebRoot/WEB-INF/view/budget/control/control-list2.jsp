<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>

<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-td1">预算年份：</td>
				<td class="top-table-td2">
					<input id="" style="width: 150px;height:25px;" class="easyui-numberbox"/>
				</td>
				
				<td style="width: 30px;"></td>
				
				<td style="width: 26px;">
					<a href="#" onclick="queryControl();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td style="width: 8px;"></td>
				
				<td style="width: 26px;">
					<a href="#" onclick="clearConQuery();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="yxbc()">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="list-table">
			<table id="yx_control_dg" class="easyui-datagrid" 
				data-options="collapsible:true,url:'${base}/project/yxprojectPage',
				onClickRow: onClickRow,scrollbarSize:0,method:'post',fit:true,singleSelect: true,striped: true">
					<thead>
						<tr>
							<th data-options="field:'fproId',hidden:true"></th>
							<th data-options="align:'center',field:'pageOrder'" style="width: 5%">序号</th>
							<th data-options="align:'left',field:'fproCode'" style="width: 10%">项目编号</th>
							<th data-options="align:'left',field:'fproName'" style="width: 10%">项目名称</th>
							<th data-options="align:'left',field:'planStartYear',formatter: dateformat_year" style="width: 10%">预算年度</th>
							<th data-options="align:'left',field:'firstLevelName'" style="width: 10%">一级分类名称</th>
							<th data-options="align:'left',field:'fproBudgetAmount'" style="width: 10%">项目预算金额[万元]</th>
							<th data-options="align:'left',field:'commitAmount1',required:'required',editor:{type:'numberbox',options:{precision:2}}" style="width: 10%">项目控制数[万元]</th>
							<th data-options="align:'left',field:'fext12',editor:{type:'textbox'}" style="width: 25%">备注(50字以内)</th>
							<th data-options="align:'left',field:'ysCZ'" style="width: 10%">操作</th>
							
						</tr>
					</thead>
			</table>
		
		
	</div>

</div>
		
		
		
		


<script type="text/javascript">
//时间格式化
function dateformat_year(val){
    var t, y, m, d, h, i, s;
    if(val==null){
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
    return y ;
}

function operformat_controllist(value, row, index){
	var btn1 = "<a href='javascript:void(0)' style='color:blue' onclick='detailControl("+row.fCId+")'>"
				+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/select1.png'>"
				+ "</a>";
	var btn2 = "<a href='javascript:void(0)' style='color:blue' onclick='deleteControl("+row.fCId+")'>"
				/* + "<img onmouseover='picVerdictOut(this)' onmouseout='picVerdictOver(this)' src='"+base+"/resource-modality/${themenurl}/verdict2.png'>" */
				+ "</a>";
	var btn3 = "";
	btn3 = "<a href='javascript:void(0)' style='color:blue' onclick='editControl("+row.fCId+")'>"
			+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/update1.png'>"
			+"</a>";
	return btn1 ;
}
function showA(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
}
function showB(obj){
	obj.src=base+'/resource-modality/${themenurl}/select2.png';
}
function showC(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/update1.png';
}
function showD(obj){
	obj.src=base+'/resource-modality/${themenurl}/update2.png';
}



var editIndex = undefined;
function endEditing() {
	if (editIndex == undefined) {
		return true
	}
	if ($('#yx_control_dg').datagrid('validateRow', editIndex)) {
		var ed = $('#yx_control_dg').datagrid('getEditor', {
			index : editIndex,
			field : 'costDetail'
		});
		$('#yx_control_dg').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow(index) {
	if (editIndex != index) {
		if (endEditing()) {
			$('#yx_control_dg').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndex = index;
		} else {
			$('#yx_control_dg').datagrid('selectRow', editIndex);
		}
	}
}


//一下保存
function yxbc() {
	$('#yx_control_dg').datagrid('acceptChanges');
	
	var data="";
	var data2="";
	var data3="";
	var checkedItems = $('#yx_control_dg').datagrid('getRows');
	$.each(checkedItems, function(index, item){
    	data +=item.fproId + ',';
    	data2 += item.commitAmount1 + ',';
    	data3 += item.fext12 +',';
    });


	$.ajax({ 
		type: 'POST', 
		url: base+'/project/yx?fproIdLi='+data+'&commitAmountLi='+data2+'&fext12Li='+data3,
		dataType: 'json',  
		success: function(data){ 
			if(data.success){
				$.messager.alert('系统提示',data.info,'info');
				$("#yx_control_dg").datagrid('reload');
			}else{
				$.messager.alert('系统提示',data.info,'error');
			}
		} 
	});
	
}
</script>
</body>


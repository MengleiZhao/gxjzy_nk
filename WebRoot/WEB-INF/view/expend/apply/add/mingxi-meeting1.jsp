<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<c:if test="${type!=1}">
<!-- <div class="window-title">费用明细</div> -->
</c:if>


<div class="window-tab" style="margin-left: 0px;padding-top: 10px">


	<table id="appli-detail-dg1" class="easyui-datagrid" style="width:707px;height:auto;"
	data-options="
	toolbar: '#appli-detail-tb',
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/mingxi?id=${bean.gId}',
	</c:if>
	<c:if test="${empty bean.gId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRow,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:false,
	scrollbarSize:0,
	singleSelect: true,
	">
	<thead>
		<tr>
			<th data-options="field:'cId',hidden:true"></th>
			
			
			
				<th data-options="field:'costDetail',required:'required',align:'center',width:170">费用名称</th>
				<th data-options="field:'standard',required:'required',align:'center',width:180">费用标准（元/人天）</th>
				<th data-options="field:'totalStandard',required:'required',align:'center',width:180">总额标准[元]</th>
				<c:if test="${empty detail}">
				<th data-options="field:'applySum',required:'required',align:'center',width:180,editor:{type:'numberbox',options:{onChange:addNum1,precision:2,groupSeparator:','}}">申请金额[元]</th>
				</c:if>
				<c:if test="${!empty detail}">
				<th data-options="field:'applySum',required:'required',align:'center',width:150,editor:{type:'numberbox',options:{precision:2,groupSeparator:','}}">申请金额[元]</th>
				</c:if>
								
								
			
			
		</tr>
	</thead>
	</table>
</div>
<%-- <c:if test="${empty detail}">
<div id="appli-detail-tb" style="height:30px">
	<a style="color: red;">申请总额：</a><input style="width: 100px;" id="num1" class="easyui-numberbox" value="${bean.amount}" readonly="readonly" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]"/>
	
	<!-- <a href="#" onclick="openbz()" style="color: blue">查看标准</a> -->
	<a href="javascript:void(0)" onclick="removeit()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="javascript:void(0)" onclick="append()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
</div>
</c:if>
<c:if test="${!empty detail}">
<div id="appli-detail-tb" style="height:30px">
	<a style="color: red;">申请总额：</a><input style="width: 100px;" class="easyui-numberbox" value="${bean.amount}" readonly="readonly"/>
</div>
</c:if> --%>
<input type="hidden" id="mingxiJson" name="mingxi"/>
<script type="text/javascript">
$(document).ready(function() {
	if (endEditing()){
    	$('#appli-detail-dg1').datagrid('insertRow', {
    		index: 0,
    		row:{
    		costDetail: '住宿费',
    		standard:'',
    		}
    	});
    	$('#appli-detail-dg1').datagrid('insertRow', {
    		index: 1,
    		row:{
    		costDetail: '伙食费',
    		standard:'',
    		}
    	});
    	$('#appli-detail-dg1').datagrid('insertRow', {
    		index: 2,
    		row:{
    		costDetail: '其他费用',
    		standard:'',
    		}
    	});
		}
	editIndex = undefined;
});


//未编辑或者已经编辑完毕的行
function addNums(rows,index){
	
	var amount=rows[index]['applySum'];
	if(amount==null){
		amount=0;
		return parseFloat(amount);
	}
	return parseFloat(amount); 
}
</script>

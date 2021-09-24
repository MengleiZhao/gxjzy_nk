<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="refund_detail_mingxi_dg" class="easyui-datagrid" style="margin-top: 10px;margin-left: 0px;"
data-options="
singleSelect: true,
rownumbers : true,
striped:true,
url: '${base}/refund/mingxi?id=${bean.fRID }',
method: 'post',
">
	<thead>
		<tr>
			<%-- 2021.01.11应要求不显示
			<c:if test="${bean.flowStauts==9 }">
				<th data-options="field:'name',align:'center',formatter:portCZ" style="width: 10%">操作</th>
			</c:if>	 --%>		
			<c:if test="${bean.fNewOrOld==1 }">
				<th data-options="field:'fId',hidden:true"></th>
				<th data-options="field:'studentName',align:'center'" style="width: 15%">学生姓名</th>
				<th data-options="field:'studentCollege',align:'center'" style="width: 20%">所属学院</th>
				<th data-options="field:'studentClass',align:'center'" style="width: 20%">专业班级</th>
				<th data-options="field:'idNumber',align:'center'" style="width: 25%">学号</th>
				<th data-options="field:'moneyCode',align:'center'" style="width: 20%">收费单号</th>
				<th data-options="field:'refundReason',align:'center'" style="width: 20%">退费原因</th>
				<th data-options="field:'payedTuition',align:'center',editor:{type:'numberbox',options:{precision:2,readonly:true}}" style="width: 15%">已交学费[元]</th>
				<th data-options="field:'payedRoom',align:'center',editor:{type:'numberbox',options:{precision:2,readonly:true}}" style="width: 15%">已交住宿费[元]</th>
				<th data-options="field:'refundTuition',align:'center',editor:{type:'numberbox',options:{precision:2,readonly:true}}" style="width: 15%">应退学费[元]</th>
				<th data-options="field:'refundRoom',align:'center',editor:{type:'numberbox',options:{precision:2,readonly:true}}" style="width: 15%">应退住宿费[元]</th>
				<th data-options="field:'tel',align:'center'" style="width: 20%">联系电话</th>
				<th data-options="field:'classTeacher',align:'center'" style="width: 15%">班主任</th>
				<th data-options="field:'sumMoney',hidden:true,align:'center',editor:{type:'numberbox',options:{precision:2}}" style="width: 20%">合计金额</th>
				<th data-options="field:'filess',align:'center',formatter:lookFilesDetail" style="width:8%">附件</th>
				<th data-options="field:'fileFid',align:'center',hidden:true" style="width:8%">附件ID</th>
			</c:if>
			
			<c:if test="${bean.fNewOrOld==0 }">
				<th data-options="field:'fId',hidden:true"></th>
				<th data-options="field:'studentName',align:'center'" style="width: 15%">学生姓名</th>
				<th data-options="field:'studentCollege',align:'center'" style="width: 20%">所属学院</th>
				<th data-options="field:'studentClass',align:'center'" style="width: 20%">专业班级</th>
				<th data-options="field:'identityId',align:'center'" style="width: 25%">身份证号</th>
				<th data-options="field:'moneyCode',align:'center'" style="width: 20%">收费单号</th>
				<th data-options="field:'refundReason',align:'center'" style="width: 20%">退费原因</th>
				<th data-options="field:'payedTuition',align:'center',editor:{type:'numberbox',options:{precision:2,readonly:true}}" style="width: 15%">已交学费[元]</th>
				<th data-options="field:'payedRoom',align:'center',editor:{type:'numberbox',options:{precision:2,readonly:true}}" style="width: 15%">已交住宿费[元]</th>
				<th data-options="field:'refundTuition',align:'center',editor:{type:'numberbox',options:{precision:2,readonly:true}}" style="width: 15%">应退学费[元]</th>
				<th data-options="field:'refundRoom',align:'center',editor:{type:'numberbox',options:{precision:2,readonly:true}}" style="width: 15%">应退住宿费[元]</th>
				<th data-options="field:'tel',align:'center'" style="width: 20%">联系电话</th>
				<th data-options="field:'sumMoney',hidden:true,align:'center',editor:{type:'numberbox',options:{precision:2}}" style="width: 20%">合计金额</th>
				<th data-options="field:'filess',align:'center',formatter:lookFilesDetail" style="width:8%">附件</th>
				<th data-options="field:'fileFid',align:'center',hidden:true" style="width:8%">附件ID</th>
			</c:if>
		</tr>
	</thead>
</table>
<script type="text/javascript">


function portCZ(val,row){
	return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		'<a href="#" onclick="studentExport(' + row.fId + ')" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/dy1.png">'+
		'</a></td></tr></table>';
}
function studentExport(id){
	window.open(base+'/refund/studentExport?id='+ id);
}


//点击查看附件
function lookFilesDetail(val, row, index) {
	return '<a href="#" onclick="clickLookFilesDetail(\'' + row.fId + '\',\'' + index + '\',\'' + row.fileFid + '\')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/fj1.png">' + 
	'</a>';
}
//查看附件
function clickLookFilesDetail(id,index,fileFid){
	var win = creatFirstWin('附件上传', 600, 300, 'icon-search','/refund/filesjsp/' + id+'?type=0&index=' + index + '&val='+fileFid+'&fliesType=refund_detail_mingxi_dg');
	win.window('open');
}
</script>
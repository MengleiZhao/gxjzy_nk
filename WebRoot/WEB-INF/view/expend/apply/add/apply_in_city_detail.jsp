<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">

	<table id="in_city_tab_id_detail" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#in_city_id_detail',
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/applyInCityPage?gId=${bean.gId}',
	</c:if>
	<c:if test="${empty bean.gId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRowInCity,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'ftId',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'fPerson',width:220,align:'center',editor:{type:'textbox',options:{editable:true}}">姓名</th>
				<th data-options="field:'fSubsidyDay',width:220,align:'center',editor:{type:'textbox',options:{editable:true}}">补贴天数</th>
				<th data-options="field:'fApplyAmount',width:240,align:'center',editor:{type:'numberbox',options:{editable:true,precision:2}}">补贴费用</th>
			</tr>
		</thead>
	</table>
	<div id="in_city_id_detail" style="height:30px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">市内交通费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">申请费用：<span id=""><fmt:formatNumber groupingUsed="true" value="${bean.cityAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<%-- <a href="javascript:void(0)" onclick="removeitInCity()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendInCity()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a> --%>
	</div>
	<input type="hidden" id="hotelTotalDays"  />
	<input type="hidden" id="travelTotalDays"  />
	<input type="hidden" id="hotelTotalDays"  />
	<input type="hidden" id="inCityJson" name="inCity" />
</div>
<script type="text/javascript">

//接待人员表格添加删除，保存方法
var editIndexInCity = undefined;
function endEditingInCity() {
	if (editIndexInCity == undefined) {
		return true
	}
	if ($('#in_city_tab_id_detail').datagrid('validateRow', editIndexInCity)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#in_city_tab_id_detail').datagrid('getEditors', editIndexInCity);
		var text=tr[1].target.combotree('getText');
		if(text!='--请选择--'){
			tr[1].target.textbox('setValue',text);
		}
		var text1=tr[2].target.textbox('getText');
		if(text1!='--请选择--'){
			tr[2].target.textbox('setValue',text1);
		}
		$('#in_city_tab_id_detail').datagrid('endEdit', editIndexInCity);
		editIndexInCity = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowInCity(index) {
	if (editIndexInCity != index) {
		if (endEditingInCity()) {
			$('#in_city_tab_id_detail').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndexInCity = index;
		} else {
			$('#in_city_tab_id_detail').datagrid('selectRow', editIndexInCity);
		}
	}
}
function appendInCity() {
	if (endEditingInCity()) {
		$('#in_city_tab_id_detail').datagrid('appendRow', {
			
			
			
			
		});
		editIndexInCity = $('#in_city_tab_id_detail').datagrid('getRows').length - 1;
		$('#in_city_tab_id_detail').datagrid('selectRow', editIndexInCity).datagrid('beginEdit',editIndexInCity);
	}
}
function removeitInCity() {
	if (editIndexInCity == undefined) {
		return
	}
	$('#in_city_tab_id_detail').datagrid('cancelEdit', editIndexInCity).datagrid('deleteRow',
			editIndexInCity);
	editIndexInCity = undefined;
	var rows = $('#in_city_tab_id_detail').datagrid('getRows');
	var travelDays=0;
	var hotelDays=0;
	for(var i=0;i<rows.length;i++){
		if(rows[i].travelDays!=""&&rows[i].travelDays!=null){
			travelDays += parseInt(rows[i].travelDays);
		}
		if(rows[i].hotelDays!=""&&rows[i].hotelDays!=null){
			hotelDays += parseInt(rows[i].hotelDays);
		}
	}
	$('#travelTotalDays').val(travelDays);
	$('#hotelTotalDays').val(hotelDays);
}
function acceptInCity() {
	if (endEditingInCity()) {
		$('#in_city_tab_id_detail').datagrid('acceptChanges');
	}
}
	
	
//计算天数
function setDays5(newValue,oldValue) {
	var totalDays = 0;
	var fsumDays = 0;
	var index=$('#in_city_tab_id_detail').datagrid('getRowIndex',$('#in_city_tab_id_detail').datagrid('getSelected'));
	var rows = $('#in_city_tab_id_detail').datagrid('getRows');
    var editors = $('#in_city_tab_id_detail').datagrid('getEditors', index);  
    var day1 = editors[0]; 
    var day2 = editors[1]; 
    startday = new Date(day1.target.val());
    endday = new Date(day2.target.val());
    if(day1!=''&&day2!=''){
    	if(endday<startday){
    		alert("结束日期不能小于开始日期！");
    		editors[0].target.datebox('setValue', '');
    	}
    }
	/* for(var i=0;i<rows.length;i++){
		if(i==index){
			fsumDays=setEditing(rows,i);
		}else{
			totalDays+=addNum(rows,i);
		}
		totalDays =fsumDays+totalDays;
		//$('#travelTotalDays').val(totalDays);
		//$('#hotelTotalDays').val(totalDays);
	} */
	
}

function setDays6(newValue,oldValue) {
	var totalDays = 0;
	var fsumDays = 0;
	var index=$('#in_city_tab_id_detail').datagrid('getRowIndex',$('#in_city_tab_id_detail').datagrid('getSelected'));
	var rows = $('#in_city_tab_id_detail').datagrid('getRows');
    var editors = $('#in_city_tab_id_detail').datagrid('getEditors', index);  
    var day1 = editors[0]; 
    var day2 = editors[1]; 
    startday = new Date(day1.target.val());
    endday = new Date(day2.target.val());
    if(day1!=''&&day2!=''){
    	if(endday<startday){
    		alert("结束日期不能小于开始日期！");
    		editors[1].target.datebox('setValue', '');
    	}
    }
	/* for(var i=0;i<rows.length;i++){
		if(i==index){
			fsumDays=setEditing(rows,i);
		}else{
			totalDays+=addNum(rows,i);
		}
		totalDays =fsumDays+totalDays;
		//$('#travelTotalDays').val(totalDays);
		//$('#hotelTotalDays').val(totalDays);
	} */
	
}
//未编辑或者已经编辑完毕的行，计算天数
function addNum(rows,index){
	var totalDays=0;
	var startday=new Date(rows[index]['startTime']);
	var endday=new Date (rows[index]['endTime']);
	if(startday!="" && startday!=null && endday!="" && endday!=null){
		totalDays = (endday - startday) / 86400000 + 1;
	}
	return totalDays;
}
//对于正在编辑的行，计算天数
/* function setEditing(rows,index){
    var editors = $('#in_city_tab_id_detail').datagrid('getEditors', index);  
    var day1 = editors[0]; 
    var day2 = editors[1]; 
    var travelDays =editors[8];
    var hotelDays =editors[9];
	startday = new Date(day1.target.val());
    endday = new Date(day2.target.val());
    var totalDays = (endday - startday) / 86400000 + 1;
    travelDays.target.numberbox('setValue', totalDays);
    hotelDays.target.numberbox('setValue', totalDays-1);
    return totalDays;
} */


function inCityJson(){
	acceptInCity();
	var rows2 = $('#in_city_tab_id_detail').datagrid('getRows');
	var inCity = "";
	if(rows2==''){
	}else{
		for (var i = 0; i < rows2.length; i++) {
			inCity = inCity + JSON.stringify(rows2[i]) + ",";
			}
		$('#inCityJson').val(inCity);
	}
}
</script>
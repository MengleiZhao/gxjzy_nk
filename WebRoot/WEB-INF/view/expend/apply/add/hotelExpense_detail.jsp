<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">

	<table id="hoteltab_detail" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#hoteltool',
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/hotelJson?gId=${bean.gId}',
	</c:if>
	<c:if test="${empty bean.gId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRowhotel,
	</c:if>
	striped : true,
	nowrap : true,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'ffId',hidden:true"></th>
				<th data-options="field:'checkInTime',align:'center',editor:{type:'datebox', options:{editable:false}}"width="18%">入住时间</th>
				<th data-options="field:'checkOUTTime',align:'center',editor:{type:'datebox',options:{editable:false}}"width="18%">退房时间</th>
				<th data-options="field:'CityId',align:'center',editor:'textbox',hidden:true">城市id</th>
				<th data-options="field:'travelPersonnelId',align:'center',editor:'textbox',hidden:true">住宿人员id</th>
				<th data-options="field:'locationCity',align:'center',editor:{type:'textbox',options:{icons:[{iconCls:'icon-add',handler: function(e){
					var row = $('#hoteltab_detail').datagrid('getSelected');
					var index = $('#hoteltab_detail').datagrid('getRowIndex',row);
					chooseArea(index,4)
					<!-- $(e.data.target).textbox('setValue', 'Something added'); -->
				}}]}}" width="20%">所在城市</th>
				<th data-options="field:'travelPersonnel',align:'center',editor:{type:'textbox',options:{icons:[{iconCls:'icon-add',handler: function(e){
					var row = $('#hoteltab_detail').datagrid('getSelected');
					var index = $('#hoteltab_detail').datagrid('getRowIndex',row);
					chooseUser(index,4)
					}}]}}" width="33%">住宿人员</th>
				<th data-options="field:'travelChummage',width:150,
                        editor:{
                            type:'combobox',
                            options:{
                                valueField:'id',
                                textField:'text',
                                multiple: false,
                                onHidePanel:travelChummageId,
                                onShowPanel:onClickCellChummagetab
                            }}">合住人员</th>
				<th data-options="field:'travelChummageId',hidden:true,editor:{type:'textbox',options:{editable:false}}">合住人员id</th>
				<th data-options="field:'applyAmount',align:'center',editor:{type:'numberbox',precision:2}" width="12%">申请费用</th>
			</tr>
		</thead>
	</table>
	<div id="hoteltool" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">住宿费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span id="hotelAmount"><fmt:formatNumber groupingUsed="true" value="${bean.hotelAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<%-- <a href="javascript:void(0)" onclick="removehotel()" id="hotelRemoveId" hidden="hidden" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendhotel()" id="hotelAppendId" hidden="hidden" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a> --%>
	</div>
	<input type="hidden" id="hotelJson" name="hotelJson" />
</div>
<script type="text/javascript">
/* 
<!-- multiple:true,
valueField: 'value',
textField: 'label',
onShowPanel:function onShowPanel(){
		endEditingItinerary();
		userdata();
		userdatajson = eval('('+userdatajson+')');
		$(this).combotree('loadData',userdatajson);
},
onHidePanel:function onSelect(){
	var row = $('#hoteltab_detail').datagrid('getSelected');
	var index = $('#hoteltab_detail').datagrid('getRowIndex',row);
	var e = $('#hoteltab_detail').datagrid('getEditor',{index:index,field:'travelPersonnelId'});
	$(e.target).textbox('setValue', row.value);
}, --> */


//伙食表格添加删除
var editIndex = undefined;
function endEditinghotel() {
	if (editIndex == undefined) {
		return true;
	}
	if ($('#hoteltab_detail').datagrid('validateRow', editIndex)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#hoteltab_detail').datagrid('getEditors', editIndex);
		/* var text=tr[5].target.combotree('getText');
		if(text!='--请选择--'){
			tr[5].target.combotree('setValue',text);
		}
		var text1=tr[4].target.combotree('getText');
		if(text1!='--请选择--'){
			tr[4].target.combotree('setValue',text1);
		} */
		$('#hoteltab_detail').datagrid('endEdit', editIndex);
		calcHotelCost();
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowhotel(index) {
	if(sign==1){
	if (editIndex != index) {
		if (endEditinghotel()) {
			$('#hoteltab_detail').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndex = index;
		} else {
			$('#hoteltab_detail').datagrid('selectRow', editIndex);
		}
	}
	}else{
		alert("不能编辑！");
		return false;
	}
}
function appendhotel() {
	if (endEditinghotel()) {
		$('#hoteltab_detail').datagrid('appendRow', {});
		editIndex = $('#hoteltab_detail').datagrid('getRows').length - 1;
		$('#hoteltab_detail').datagrid('selectRow', editIndex).datagrid('beginEdit',editIndex);
	}
}
function removehotel() {
	if (editIndex == undefined) {
		return
	}
	$('#hoteltab_detail').datagrid('cancelEdit', editIndex).datagrid('deleteRow',editIndex);
	editIndex = undefined;
	calcHotelCost();
}
function accepthotel() {
	if (endEditinghotel()) {
		$('#hoteltab_detail').datagrid('acceptChanges');
		calcHotelCost();
	}
}
//获得json数据
function getHotelJson(){
	accepthotel();
	$('#hoteltab_detail').datagrid('acceptChanges');
	var rows = $('#hoteltab_detail').datagrid('getRows');
	var entities= '';
	for(var i = 0 ;i < rows.length;i++){
	 entities = entities  + JSON.stringify(rows[i]) + ',';  
	}
	$("#hotelJson").val(entities);
}	
function calcHotelCost(){
	//计算总额
	var rows = $('#hoteltab_detail').datagrid('getRows');
	var HotelAmount=parseFloat(0.00);
	for(var i=0;i<rows.length;i++){
		var money = isNaN(parseFloat(rows[i].applyAmount))?0.00:parseFloat(rows[i].applyAmount);
		HotelAmount=HotelAmount+money;
	}
	$('#hotelAmount').html(HotelAmount.toFixed(2)+'[元]');
}	
/* 	//重新计算开支标准
	function countkzbz() {
		accept();
		//获得接待人数（有几行就是接待多少人）
		var rownum = $('#hoteltab_detail').datagrid('getRows').length;
		//修改明细表中的开支标准
		var rows = $('#appli-detail-dg').datagrid('getRows');
		for(var i=0;i<rows.length;i++) {
			var tr = $('#appli-detail-dg').datagrid('getEditors', i);
			//获得每一行的开支标准
			var kzbz=rows[i].standard;
			//设置开支标准
			onClickRow(i);
			tr[1].target.textbox('setValue', parseFloat(kzbz*rownum));
			accept();
		}
	} */
	
/* //计算天数
function setDays1(newValue,oldValue) {
	var totalDays = 0;
	var fsumDays = 0;
	var index=$('#hoteltab_detail').datagrid('getRowIndex',$('#hoteltab_detail').datagrid('getSelected'));
	var rows = $('#hoteltab_detail').datagrid('getRows');
    var editors = $('#hoteltab_detail').datagrid('getEditors', index);  
    var day1 = editors[6]; 
    var day2 = editors[7]; 
    startday = new Date(day1.target.val());
    endday = new Date(day2.target.val());
    if(day1!=''&&day2!=''){
    	if(endday<startday){
    		alert("结束日期不能小于开始日期！");
    		editors[6].target.datebox('setValue', '');
    	}
    }
	for(var i=0;i<rows.length;i++){
		if(i==index){
			fsumDays=setEditing(rows,i);
		}else{
			totalDays+=addNum(rows,i);
		}
		totalDays =fsumDays+totalDays;
		//$('#travelTotalDays').val(totalDays);
		//$('#hotelTotalDays').val(totalDays);
		calcHotelCost();
	}
	
}

function setDays2(newValue,oldValue) {
	var totalDays = 0;
	var fsumDays = 0;
	var index=$('#hoteltab_detail').datagrid('getRowIndex',$('#hoteltab_detail').datagrid('getSelected'));
	var rows = $('#hoteltab_detail').datagrid('getRows');
    var editors = $('#hoteltab_detail').datagrid('getEditors', index);  
    var day1 = editors[6]; 
    var day2 = editors[7]; 
    startday = new Date(day1.target.val());
    endday = new Date(day2.target.val());
    if(day1!=''&&day2!=''){
    	if(endday<startday){
    		alert("结束日期不能小于开始日期！");
    		editors[7].target.datebox('setValue', '');
    	}
    }
	for(var i=0;i<rows.length;i++){
		if(i==index){
			fsumDays=setEditing(rows,i);
		}else{
			totalDays+=addNum(rows,i);
		}
		totalDays =fsumDays+totalDays;
		//$('#travelTotalDays').val(totalDays);
		//$('#hotelTotalDays').val(totalDays);
		calcHotelCost();
	}
	
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
function setEditing(rows,index){
    var editors = $('#hoteltab_detail').datagrid('getEditors', index);  
    var day1 = editors[6]; 
    var day2 = editors[7]; 
    var travelDays =editors[8];
    var hotelDays =editors[9];
	startday = new Date(day1.target.val());
    endday = new Date(day2.target.val());
    var totalDays = (endday - startday) / 86400000 + 1;
    travelDays.target.numberbox('setValue', totalDays);
    hotelDays.target.numberbox('setValue', totalDays-1);
    return totalDays;
}
 */
function reload(rec){
	var row = $('#hoteltab_detail').datagrid('getSelected');
	var rindex = $('#hoteltab_detail').datagrid('getRowIndex', row); 
	var ed = $('#hoteltab_detail').datagrid('getEditor',{
		index:rindex,
		field : 'vehicleLevel'  
	});
	if(rec.code !='JTGJ06'){
		var url = base+'/vehicle/comboboxJson?selected=${travelBean.vehicle}&parentCode='+rec.code;
    	$(ed.target).combotree('reload', url);
	}/* else{
		$('#vehicleOther1').css('display','');
		$('#vehicleOther2').css('display','');
		$('#vehicleLevel1').css('display','none');
		$('#vehicleLevel2').css('display','none');
	}
	 $(ed.target).combobox('setValue', '2016');  */
}

//选择出差地区
function chooseArea(index,editType){
	var win = creatFirstWin('选择-出差地区', 640, 580, 'icon-search', '/hotelStandard/choose?index='+index+'&editType=4');
	win.window('open');
}
//选择人员
function chooseUser(index,editType){
	var win = creatFirstWin('选择-出差人员', 640, 580, 'icon-search', '/hotelStandard/chooseUser?index='+index+'&editType=4');
	win.window('open');
}
</script>
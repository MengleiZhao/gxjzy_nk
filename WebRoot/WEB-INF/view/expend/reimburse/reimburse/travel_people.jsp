<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab">

	<table id="rpt" class="easyui-datagrid" style="width:660px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#rph',
	<c:if test="${!empty travelBean.trId}">
	url: '${base}/apply/travelp?id=${travelBean.trId}',
	</c:if>
	<c:if test="${empty travelBean.trId}">
	url: '',
	</c:if>
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'travelRId',hidden:true"></th>
				<th data-options="field:'travelPeopName',width:150,align:'center',editor:'textbox'">姓名</th>
				<th data-options="field:'idCard',width:200,align:'center',editor:'numberbox'">身份证号</th>
				<th data-options="field:'position',width:200,align:'center',editor:'textbox'">行政级别</th>
				<th data-options="field:'phoneNum',width:200,align:'center',editor:'textbox'">联系方式</th>
				<th data-options="field:'vehicle',width:200,align:'center',editor:{
							editable:true,
							type:'combotree',
							options:{
								required:true,
								valueField:'code',
								textField:'text',
								method:'post',
								url:base+'/vehicle/comboboxJson?selected=${travelBean.vehicle}',
								onSelect:reload  
							}}">交通工具</th>
				<th data-options="field:'vehicleLevel',width:200,align:'center',editor:{
							editable:true,
							type:'combotree',
							options:{
								required:true,
								valueField:'code',
								textField:'text',
								method:'post',
								url:base+'/vehicle/comboboxJson?selected=${travelBean.vehicleLevel}&parentCode=${travelBean.vehicle}',
							}}">交通工具级别</th>
				<th data-options="field:'startTime',width:200,align:'center',editor:{type:'datebox', options:{onChange:setDays1,editable:false}},formatter:ChangeDateFormat">开始时间</th>
				<th data-options="field:'endTime',width:200,align:'center',editor:{type:'datebox',options:{onChange:setDays2,editable:false}},formatter:ChangeDateFormat">结束时间</th>
				<th data-options="field:'travelDays',width:200,align:'center',editor:{type:'numberbox',options:{editable:false}}">出差天数</th>
				<th data-options="field:'hotelDays',width:200,align:'center',editor:{type:'numberbox'}">住宿天数</th>
			</tr>
		</thead>
	</table>
	<input type="hidden" id="hotelTotalDays"  />
	<input type="hidden" id="travelTotalDays"  />
	<input type="hidden" id="hotelTotalDays"  />
</div>
<script type="text/javascript">

//接待人员表格添加删除，保存方法
	var editIndex = undefined;
	function endEditingR() {
		if (editIndex == undefined) {
			return true
		}
		if ($('#rpt').datagrid('validateRow', editIndex)) {
			//下面三行，是在增加一行的时候，防止原来的一行的值变成code
			var tr = $('#rpt').datagrid('getEditors', editIndex);
			var text=tr[5].target.combotree('getText');
			if(text!='--请选择--'){
				tr[5].target.combotree('setValue',text);
			}
			var text1=tr[4].target.combotree('getText');
			if(text1!='--请选择--'){
				tr[4].target.combotree('setValue',text1);
			}
			$('#rpt').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRowR(index) {
		if (editIndex != index) {
			if (endEditingR()) {
				$('#rpt').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex = index;
			} else {
				$('#rpt').datagrid('selectRow', editIndex);
			}
		}
	}
	function appendR() {
		if (endEditingR()) {
			$('#rpt').datagrid('appendRow', {});
			editIndex = $('#rpt').datagrid('getRows').length - 1;
			$('#rpt').datagrid('selectRow', editIndex).datagrid('beginEdit',editIndex);
		}
	}
	function removeitR() {
		if (editIndex == undefined) {
			return
		}
		$('#rpt').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
				editIndex);
		editIndex = undefined;
		var rows = $('#rpt').datagrid('getRows');
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
		calcTravelCost();
	}
	function acceptR() {
		if (endEditingR()) {
			$('#rpt').datagrid('acceptChanges');
		}
	}
	
	
/* 	//重新计算开支标准
	function countkzbz() {
		accept();
		//获得接待人数（有几行就是接待多少人）
		var rownum = $('#rpt').datagrid('getRows').length;
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
	
	//计算天数
	function setDays1(newValue,oldValue) {
		var totalDays = 0;
		var fsumDays = 0;
		var index=$('#rpt').datagrid('getRowIndex',$('#rpt').datagrid('getSelected'));
		var rows = $('#rpt').datagrid('getRows');
	    var editors = $('#rpt').datagrid('getEditors', index);  
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
			calcTravelCost();
		}
		
	}
	
	function setDays2(newValue,oldValue) {
		var totalDays = 0;
		var fsumDays = 0;
		var index=$('#rpt').datagrid('getRowIndex',$('#rpt').datagrid('getSelected'));
		var rows = $('#rpt').datagrid('getRows');
	    var editors = $('#rpt').datagrid('getEditors', index);  
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
			calcTravelCost();
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
	    var editors = $('#rpt').datagrid('getEditors', index);  
	    var day1 = editors[6]; 
	    var day2 = editors[7]; 
	    var travelDays =editors[8];
	    var hotelDays =editors[9];
		startday = new Date(day1.target.val());
	    endday = new Date(day2.target.val());
	    var totalDays = (endday - startday) / 86400000 + 1;
	    travelDays.target.numberbox('setValue', totalDays);
	    hotelDays.target.numberbox('setValue', totalDays);
	    return totalDays;
	}
	
	function reload(rec){
		var row = $('#rpt').datagrid('getSelected');
		var rindex = $('#rpt').datagrid('getRowIndex', row); 
		var ed = $('#rpt').datagrid('getEditor',{
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
	

</script>
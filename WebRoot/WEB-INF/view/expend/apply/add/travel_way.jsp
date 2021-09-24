<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-top:10px;padding-top: 0px;margin-left: 0px;">
	<!-- <div style="margin-right:40px;float:left">
		<span class="style1"></span>
	</div> -->
	<c:if test="${empty detail}">
		<div style="margin-right:0px;float:right">
			<a href="javascript:void(0)" onclick="removeitWay()" id="removeWayId" hidden="hidden" style="float: right;margin-right: 22px;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
			<a style="float: right;">&nbsp;&nbsp;</a>
			<a href="javascript:void(0)" onclick="appendWay()" id="appendWayId" hidden="hidden" style="float: right; "><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		</div>
	</c:if>
	<table id="travel-way-dg" class="easyui-datagrid" style="width:707px;height:auto;"
	data-options="
	toolbar: '#dmp',
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/getTravelWay?gId=${bean.gId}&travelType=GWCG',
	</c:if>
	<c:if test="${empty bean.gId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRowWay,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	singleSelect: true,
	">
	<thead>
		<tr>
			<th data-options="field:'fOId',hidden:true"></th>			
			<th data-options="field:'gId',hidden:true"></th>			
			<th data-options="field:'fStartDate',required:'required',align:'center',width:140,editor:{type:'datebox',options:{onChange:setDaysPlanWay1,onHidePanel:selectTimeWay}},formatter:ChangeDateFormat">出发日期</th>
			<th data-options="field:'fEndDate',required:'required',align:'center',width:140,editor:{type:'datebox',options:{onChange:setDaysPlanWay2,onHidePanel:selectTimeWay}},formatter:ChangeDateFormat">到达日期</th>
			<th data-options="field:'departurePlace',required:'required',align:'center',width:138,editor:'textbox'">出发地</th>
			<th data-options="field:'destination',required:'required',align:'center',width:138,editor:'textbox'">目的地</th>
			<th data-options="field:'travelPersonnel',width:142,align:'center',editor:{type:'combobox',options:{
                             valueField:'id',
                             textField:'text',
                             multiple: false,
                             onShowPanel:choosePeople,
                             onSelect:setPeopleId,
                             onHidePanel:personnerIdA,
                             editable:false
                         }}">出行人员</th>
			<th data-options="field:'vehicle',width:160,align:'center',editor:{
							editable:true,
							type:'combotree',
							filter: function(q, row){
									var opts = $(this).combotree('options');
									return row[opts.textField].indexOf(q) == 0;
								},
							options:{
								required:true,
								valueField:'code',
								textField:'text',
								method:'post',
								url:base+'/vehicle/comboboxJson?selected=JTGJ06',
								onSelect:reload
							}}">交通工具</th>
			<th data-options="field:'vehicleLevel',width:160,align:'center',editor:{
							editable:true,
							type:'combotree',
							options:{
								required:true,
								valueField:'code',	
								textField:'text',
								method:'post',
								onShowPanel:reloadLevel,
								url:base+'/vehicle/comboboxJson?selected=JTGJ06&parentCode=JTGJ0602'
							}}">交通工具级别</th>

             <th data-options="field:'travelPersonnelId',required:'required',hidden:true,editor:{type:'textbox',options:{editable: true}}"></th>  
             <th data-options="field:'vehicleId',required:'required',hidden:true,editor:{type:'textbox',options:{editable: true}}"></th>                         
             <th data-options="field:'travelPersonnelLevel',required:'required',hidden:true,editor:{type:'textbox',options:{editable: true}}"></th>                         
		</tr>
	</thead>
</table>
</div>
<script type="text/javascript">
var gId = '${bean.gId}';

//接待人员表格添加删除，保存方法
	var editIndexWay = undefined;
	function endEditingWay() {
		if (editIndexWay == undefined) {
			return true
		}
		if ($('#travel-way-dg').datagrid('validateRow', editIndexWay)) {
			//下面三行，是在增加一行的时候，防止原来的一行的值变成code
			 var tr = $('#travel-way-dg').datagrid('getEditors', editIndexWay);
			var text=tr[4].target.combobox('getText');
			if(text!='--请选择--'){
				tr[4].target.combobox('setValue',text);
			} 

			var text1=tr[5].target.combotree('getText');
			if(text1!='--请选择--'){
				tr[5].target.combotree('setValue',text1);
			} 
			var text=tr[6].target.combotree('getText');
			if(text!='--请选择--'){
				tr[6].target.combotree('setValue',text);
			} 
			$('#travel-way-dg').datagrid('endEdit', editIndexWay);
			editIndexWay = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRowWay(index) {
		if (editIndexWay != index) {
			if (endEditingWay()) {
				$('#travel-way-dg').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndexWay = index;
			} else {
				$('#travel-way-dg').datagrid('selectRow', editIndexWay);
			}
		}
	}
	function appendWay() {
		if (endEditingWay()) {
			$('#travel-way-dg').datagrid('appendRow', {});
			editIndexWay = $('#travel-way-dg').datagrid('getRows').length - 1;
			$('#travel-way-dg').datagrid('selectRow', editIndexWay).datagrid('beginEdit',editIndexWay);
		}
	}
	function removeitWay() {
		if (editIndexWay == undefined) {
			return
		}
		$('#travel-way-dg').datagrid('cancelEdit', editIndexWay).datagrid('deleteRow',
				editIndexWay);
		editIndexWay = undefined;
	}
	function travelWayAccept() {
		if (endEditingWay()) {
			$('#travel-way-dg').datagrid('acceptChanges');
		}
	}
	
	function reload(rec){
	    	var row = $('#travel-way-dg').datagrid('getSelected');
	    	var rindex = $('#travel-way-dg').datagrid('getRowIndex', row); 
	    	var ed = $('#travel-way-dg').datagrid('getEditor',{
	    		index:rindex,
	    		field : 'vehicleLevel'  
	    	});
	    	var level = $('#travel-way-dg').datagrid('getEditor',{
	    		index:rindex,
	    		field : 'travelPersonnelLevel'  
	    	});
	    	var vehicleId = $('#travel-way-dg').datagrid('getEditor',{
	    		index:rindex,
	    		field : 'vehicleId'  
	    	});
	    	$(ed.target).combotree('setValue', '');
	    	$(vehicleId.target).textbox('setValue', rec.code);
	    	var url = base+'/vehicle/comboboxJsons?selected=${travelBean.vehicle}&parentCode='+rec.code+'&level='+$(level.target).textbox('getValue');
	       	$(ed.target).combotree('reload', url);
	}
	function reloadLevel(){
		var row = $('#travel-way-dg').datagrid('getSelected');
		var rindex = $('#travel-way-dg').datagrid('getRowIndex', row); 
		var ed = $('#travel-way-dg').datagrid('getEditor',{
			index:rindex,
			field : 'vehicleLevel'  
		});
		var level = $('#travel-way-dg').datagrid('getEditor',{
			index:rindex,
			field : 'travelPersonnelLevel'  
		});
		var vehicleId = $('#travel-way-dg').datagrid('getEditor',{
			index:rindex,
			field : 'vehicleId'  
		});
		$(ed.target).combotree('setValue', '');
		var url = base+'/vehicle/comboboxJsons?parentCode='+$(vehicleId.target).textbox('getValue')+'&level='+$(level.target).textbox('getValue');
	   	$(ed.target).combotree('reload', url);
	}
	
	function travelWayJson(){
		travelWayAccept();
		var rows1 = $('#travel-way-dg').datagrid('getRows');
		var travelWay = "";
		for (var i = 0; i < rows1.length; i++) {
			travelWay = travelWay + JSON.stringify(rows1[i]) + ",";
		}
		$('#travelWayJson').val(travelWay);
	}
	
	function travelWayDateFormat(val) {
		var t, y, m, d, h, i, s;
	    if(val==null || val==''){
	  	  return "";
	    }
	    t = new Date(val);
	    y = t.getFullYear();
	    m = t.getMonth() + 1;
	    d = t.getDate();
	    // 可根据需要在这里定义时间格式  
	    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
	}
	
	var peopleArr =new Array();
	/* function choosePeople(){
		$('#travel-way-dg').datagrid('selectRow', editIndexWay).datagrid('beginEdit',
				editIndexWay);
		var index=$('#travel-way-dg').datagrid('getRowIndex',$('#travel-way-dg').datagrid('getSelected'));
		var ed = $('#travel-way-dg').datagrid('getEditor',{
				index:index,
				field:'travelPersonnel'
			});
		$(ed.target).combobox({
            data: peopleArr,
            valueField: 'id',
            multiple: true,
            textField: 'text',
		});
	} */
	function setPeopleId(rec){
		var row = $('#travel-way-dg').datagrid('getSelected');
		var rindex = $('#travel-way-dg').datagrid('getRowIndex', row); 
		var ed = $('#travel-way-dg').datagrid('getEditor',{
			index:rindex,
			field : 'travelPersonnelLevel'  
		});
		$(ed.target).textbox('setValue', rec.level);
	}
	
	function selectTimeWay(){
		var index=$('#travel-way-dg').datagrid('getRowIndex',$('#travel-way-dg').datagrid('getSelected'));
	    var editors = $('#travel-way-dg').datagrid('getEditors', index);  
	    var maxTime =  Date.parse($("#abroadDateEnd").val())+86400000;
	    var minTime =  Date.parse($("#abroadDateStart").val())-28800000;
		 if(isNaN(maxTime)||isNaN(minTime)){
		    	alert("请填写基本信息里的开始时间和结束时间！");
		    	editors[0].target.datebox('setValue', '');
		    	editors[1].target.datebox('setValue', '');
		    	return
		   }
	}
	
	function setDaysPlanWay1(newValue,oldValue) {
		var index=$('#travel-way-dg').datagrid('getRowIndex',$('#travel-way-dg').datagrid('getSelected'));
	    var editors = $('#travel-way-dg').datagrid('getEditors', index);  
	    var day2 = editors[1]; 
	    var startday = Date.parse(new Date(newValue));
	    var endday = Date.parse(new Date(day2.target.val()));
	   
	    var maxTime =  Date.parse($("#abroadDateEnd").val())+86400000;
	    var minTime =  Date.parse($("#abroadDateStart").val())-28800000;
	    if(!isNaN(startday)&&!isNaN(endday)){
	    	if((startday>=minTime &&startday<=maxTime) && endday<=maxTime){
	    		if(endday<startday){
	        		alert("结束日期不能小于开始日期！");
	        		editors[0].target.datebox('setValue', '');
	        	}
	    	}else{
	    		alert("所选时间不在行程范围内请重新选择！");
	    		editors[0].target.datebox('setValue', '');
	    	}
	    	
	    }else{
	    	if(startday>maxTime || startday<minTime){
	    		alert("所选时间不在行程范围内请重新选择！");
	    		editors[0].target.datebox('setValue', '');
	    	}
	    }
		
	}
	
	//计算天数
	function setDaysPlanWay2(newValue,oldValue) {
		var index=$('#travel-way-dg').datagrid('getRowIndex',$('#travel-way-dg').datagrid('getSelected'));
	    var editors = $('#travel-way-dg').datagrid('getEditors', index);  
	    var day1 = editors[0]; 
	    var startday = Date.parse(new Date(day1.target.val()));
	    var endday = Date.parse(new Date(newValue));
	    
	    var maxTime = Date.parse(new Date($("#abroadDateEnd").datebox('getValue')));
	    var minTime = Date.parse(new Date($("#abroadDateStart").datebox('getValue')));
	    if(!isNaN(startday)&&!isNaN(endday)){
	    	if((startday>=minTime &&startday<=maxTime) && endday<=maxTime){
	    		if(endday<startday){
	        		alert("结束日期不能小于开始日期！");
	        		editors[1].target.datebox('setValue', '');
	        	}
	    	}else{
	    		alert("所选时间不在行程范围内请重新选择！");
	    		editors[1].target.datebox('setValue', '');
	    	}
	    	
	    }else{
	    	if(endday>maxTime || endday<minTime){
	    		alert("所选时间不在行程范围内请重新选择！");
	    		editors[1].target.datebox('setValue', '');
	    	}
	    }
	}
	
	function choosePeople(){
		$('#travel-way-dg').datagrid('selectRow', editIndexWay).datagrid('beginEdit',
				editIndexWay);
		var index=$('#travel-way-dg').datagrid('getRowIndex',$('#travel-way-dg').datagrid('getSelected'));
			var new_arrsAbroad= new_arrAbroad();
			var travelPersonnel = $('#travel-way-dg').datagrid('getEditor',{
				index:index,
				field:'travelPersonnel'
			});
			$(travelPersonnel.target).combobox({
	            data: new_arrsAbroad,
	            valueField: 'id',
	            multiple: false,
	            textField: 'text',
			});
	}
	
	function new_arrAbroad(){
		var rows = $('#abroad-person-dg').datagrid('getRows');
		var arr = new Array();
		for (var i = 0; i < rows.length; i++) {
			var PeopId = rows[i].travelPeopId.split(',');
			var PeopName = rows[i].travelPeopName.split(',');
			var level = rows[i].travelPersonnelLevel.split(',');
			if(PeopId.length>1){
				for (var j = 0; j < PeopId.length; j++) {
					var idAndName = {};
					idAndName.id = PeopId[j];
					idAndName.text = PeopName[j];
					idAndName.level = level[j];
					arr.push(idAndName);
				}
			}else{
				var idAndName = {};
				idAndName.id = rows[i].travelPeopId;
				idAndName.text = rows[i].travelPeopName;
				idAndName.level = rows[i].travelPersonnelLevel;
				arr.push(idAndName);
			}
		}
		for (var h = 0; h < arr.length; h++) {
			for (var c =h+1; c <arr.length; ) {
			    if (arr[h].id == arr[c].id ) {//通过id属性进行匹配；
			    	arr.splice(c, 1);//去除重复的对象；
				}else {
				c++;
				}
			}
			}
		return arr;
	}
	//选中时给出行人员设置id
	function personnerIdA(){
		var index=$('#travel-way-dg').datagrid('getRowIndex',$('#travel-way-dg').datagrid('getSelected'));
		var travelPersonnelId = $('#travel-way-dg').datagrid('getEditor',{
			index:index,
			field:'travelPersonnelId'
		});
		var travelPersonnel = $('#travel-way-dg').datagrid('getEditor',{
			index:index,
			field:'travelPersonnel'
		});
		$(travelPersonnelId.target).textbox('setValue', $(travelPersonnel.target).combobox('getValues'));
	}
</script>
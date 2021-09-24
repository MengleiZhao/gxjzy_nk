<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<style type="text/css">
</style>

<!-- 隐藏域主键 -->
<input type="hidden" name="mId" value="${meetingBean.mId}" />

<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 0px;">
	<tr class="trbody">
		<td class="td1" ><span class="style1">*</span> 会议名称</td>
		<td class="td2" colspan="3" >
			<input class="easyui-textbox" style="width: 590px; height: 30px;" name="meetingName" 
			value="${meetingBean.meetingName}" required="required" data-options="validType:'length[1,50]'"/>
		</td>
	</tr>
	<%-- <tr class="trbody">
		<td class="td1" ><span class="style1">*</span> 会议类型</td>
		<td class="td2" style="width: 281px;">
			<input id="meetingType" class="easyui-combobox" style="width: 200px; height: 30px;" name="meetingType" value="${meetingBean.meetingType}"
				data-options="valueField: 'meetingType',textField: 'value',editable: false,
				data: [{meetingType: '1',value: '一类会议'},{meetingType: '2',value: '二类会议'},{meetingType: '3',value: '三类会议'},{meetingType: '4',value: '四类会议'}]"/>
		</td>

		<td class="td1"><span class="style1">*</span> 会议方式</td>
		<td class="td2">
			<select id="meetingMethod" class="easyui-combobox"
				name="meetingMethod" style="width: 200px; height: 30px;" required="required" editable="false">
					<option value="1">电话</option>
					<option value="2">网络视频会议</option>
					<option value="3">单位内部会议室</option>
					<option value="4">外部定点会议室</option>
			</select>
		</td>
			
			
		</td>
	</tr> --%>
	<tr class="trbody">
		<td class="td1" ><span class="style1">*</span> 会议类型</td>
		<td class="td2">
			<input id="meetingType" class="easyui-combobox" style="width: 200px; height: 30px;" name="meetingType" value="${meetingBean.meetingType}" required="required"
				data-options="prompt: '-请选择-' ,valueField: 'meetingType',textField: 'value',editable: false,
				data: [{meetingType: '4',value: '四类会议',selected:true}]"/>
				<!-- {meetingType: '1',value: '一类会议'},{meetingType: '2',value: '二类会议'}, {meetingType: '3',value: '三类会议'},-->
		</td>
		<td class="td1"><span class="style1">*</span> 会议方式</td>
		<td class="td2" style="width: 200px;">
			<input id="meetingMethod" class="easyui-combobox" style="width: 130px; height: 30px;" name="meetingMethod" value="${meetingBean.meetingMethod}" required="required"
				data-options="prompt: '-请选择-' ,valueField: 'meetingMethod',textField: 'value',editable: false,
				data: [{meetingMethod: '1',value: '电视电话'},{meetingMethod: '2',value: '网络视频'},{meetingMethod: '3',value: '单位内部会议室'},{meetingMethod: '4',value: '外部定点会议室'}],onChange:onchangedaochu"/>
				<a id="daochu" href="javascript:void(0)" onclick="downloadwj()">
					<img style="vertical-align:bottom;margin-bottom: 5px;" src="${base}/resource-modality/${themenurl}/button/daochu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
				</a>
		</td>
	</tr>

	 <tr class="trbody">
		<td class="td1"><span class="style1">*</span> 省</td>
		<td class="td2" style="width: 180px;">
			<input class="easyui-combobox" id="fsheng" name="fsheng" style="width: 200px;height: 30px;margin-left: 10px " value="${meetingBean.fsheng}" required="required" data-options="editable:false,
				url:'${base}/apply/getRegion?id=0&selected=${meetingBean.fsheng}',
				method:'POST',
				valueField:'id',
				textField:'text'">
		</td>

		<td class="td1" ><span class="style1">*</span>市</td>
		<td class="td2" >
			<input class="easyui-combobox" id="fshi" name="fshi" style="width: 200px;height: 30px;margin-left: 10px " value="${meetingBean.fshi}" required="required" editable="false" data-options="editable:false,
				method:'POST',
				url:'${base}/apply/getRegion?selected=${meetingBean.fshi}',
				valueField:'id',
				textField:'text',
				onShowPanel:onShowPanelSHIAttend">
		</td>
	</tr> 
	
	 <tr class="trbody">
		 <td class="td1"><span class="style1">*</span>区</td>
		<td class="td2">
		<input class="easyui-combobox" id="fqu" name="fqu" style="width: 200px;height: 30px;margin-left: 10px " value="${meetingBean.fqu}" required="required" editable="false" data-options="editable:false,
									url:'${base}/apply/getRegion?selected=${meetingBean.fqu}',method:'POST',valueField:'id',textField:'text',
									onShowPanel:onShowPanelQUAttend">
		</td> 
		<td class="td1"><span class="style1">*</span> 详细地址</td>
		<td colspan="3">
			<input class="easyui-textbox" style="width: 200px; height: 30px;" name="meetingPlace" 
			value="${meetingBean.meetingPlace}" required="required" data-options="prompt: '请填写详细地址' ,validType:'length[1,50]'"/>
		</td>
	</tr> 

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 参会人数</td>
		<td class="td2"><input class="easyui-numberbox" style="width: 200px; height: 30px;" id="attendNum" name="attendNum" 
			value="${meetingBean.attendNum}" required="required" data-options="validType:'length[1,3]'"/>
		</td>

		<td class="td1" style="width:102px"><span class="style1">*</span>其中工作人员人数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 200px; height: 30px;" 
			id="staffNum" name="staffNum"
			value="${meetingBean.staffNum}" required="required" data-options="validType:'length[1,3]'"/> 
		</td>
	</tr>

		<tbody id="bz" >
			<tr class="trbody">
				<td class="td1"><span class="style1">*</span> 备注</td>
				<td colspan="3">
					<input class="easyui-textbox" style="width: 590px; height: 30px;" name="attendPeople"
					value="${meetingBean.attendPeople}" data-options="validType:'length[1,100]'"/>
				</td>
			</tr>
		</tbody>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 报到时间</td>
		<td class="td2" style="width: 281px;">
			<input class="easyui-datebox" style="width: 200px; height: 30px;" id="meetingDateStart" name="dateStart"
			data-options="" value="${meetingBean.dateStart}" required="required" editable="false"/>
		</td>

		<td class="td1"><span class="style1">*</span> 离开时间</td>
		<td class="td2">
			<input class="easyui-datebox" style="width: 200px; height: 30px;" id="meetingDateEnd" name="dateEnd"
			data-options="onSelect:onSelect2,onChange:onchange,onHidePanel:onHidepanel,showSeconds:true" value="${meetingBean.dateEnd}" required="required" editable="false"/>
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 会议天数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 200px; height: 30px;" id="duration" name="duration" 
			value="${meetingBean.duration}"  required="required" data-options="iconCls:'icon-tian',validType:'length[1,2]'"/>
		</td>
	</tr>
	
	<%-- <tr class="trbody">
		<td class="td1"><span class="style1">*</span> 会议地点</td>
		<td colspan="3">
			<input class="easyui-textbox" style="width: 590px; height: 30px;" name="meetingPlace" 
			value="${meetingBean.meetingPlace}" required="required" data-options="prompt: '请填写详细地址' ,validType:'length[1,50]'"/>
		</td>
	</tr> --%>

	<tr style="height:5px;"></tr>

	<%-- <tr class="trbody">
		<td class="td1" valign="top"><p style="margin-top: 8px">会议内容</p></td>
		<td colspan="3">
			 <input class="easyui-textbox"data-options="multiline:true,required:false,validType:'length[0,250]'" name="content" style="width:590px;height:70px;" 
			value="${meetingBean.content}"> 
		</td>
	</tr> --%>
	
	<tr class="trbody">
		<td class="td1" ><span class="style1">*</span>
			经办人</td>
		<td class="td2"><input class="easyui-textbox" id="userNames"
			name="userNames" readonly="readonly" value="${bean.userNames}"
			style="width: 200px;height: 30px;margin-left: 10px "></td>
		<td class="td1" ><span class="style1">*</span>
			部门名称</td>
		<td class="td2"><input class="easyui-textbox" id="deptName"
			name="deptName" readonly="readonly" value="${bean.deptName}"
			style="width: 200px;height: 30px;margin-left: 10px "></td>
	</tr>
</table>
<input type="hidden" id="hotelStd" />
<input type="hidden" id="foodStd" />
<input type="hidden" id="otherStd" />
<script type="text/javascript">
var startday2='${meetingBean.dateStart}';
var endday2='${meetingBean.dateEnd}';
$("#meetingDateStart").datebox({
    onSelect : function(beginDate){
    	startday2 = beginDate;
    	/* endday2 = new Date(endday2);
    	var d = (endday2 - startday2) / 86400000 + 1;
    	if (d > 0) {
    		$('#duration').numberbox("setValue", d);
    	} else {
    		$('#duration').numberbox("setValue", 0);
    	} */
        $('#meetingDateEnd').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
       // autoCalStdMoney();
    },
   /*  onChange : function() {
		loadMeetStd();
    } */
});
/* $("#meetingDateEnd").datebox({
	onChange : function() {
		loadMeetStd();
    },
}); */
function onSelect2(date) {
	endday2 = date;
	startday2 = new Date(startday2);
	/* var d = (endday2 - startday2) / 86400000 + 1;
	if (d > 0) {
		$('#duration').numberbox("setValue", d);
	} else {
		$('#duration').numberbox("setValue", 0);
	} */
}

function onchange(){
	loadMeetStd();
}

function onHidepanel(){
	var duration = $('#duration').numberbox("getValue");
	endday =  $('#meetingDateEnd').datebox('getValue');
	startday = $('#meetingDateStart').datebox('getValue');
	endday2 = new Date(endday);
	startday2 = new Date(startday);
	var d = (endday2 - startday2) / 86400000;
	if(d == 0){
		$('#duration').numberbox("setValue", 1);
		duration = 1;
	}else if (d > 0) {
		$('#duration').numberbox("setValue", d+1);
		duration = d+1;
	}else if (d < 0) {
		$('#meetingDateEnd').datebox().datebox('calendar');
		alert("离开时间不得早于报道时间，请重新选择");
	}else {
		$('#duration').numberbox("setValue", 0);
		duration = 0;
	}
	
	var attendNum = $('#attendNum').numberbox("getValue");
	if (duration != '' && attendNum != '') {
		//定额标准
		var p_otherStd = $('#p_otherStd').val();
		var p_otherAllMoney = $('#p_otherAllMoney').html();
		/* if(p_otherAllMoney != '' && p_otherAllMoney != '0.00元'){
			$('#otherStdUpdate').val(p_otherStd * duration * attendNum);
		}else{
			$('#otherStdUpdate').val(0.00);
		} */
	}
	getStdAmount();
}

$(document).ready(function() {
	var meetingMethod = $('#meetingMethod').val();
	if(meetingMethod == '4'){
		$('#daochu').show();
	}else{
		$('#daochu').hide();
	}
	loadMeetStd1();
//设置会议天数和参会人员的变更方法
$("#attendNum").numberbox({
	onChange: function(newValue, oldValue) {
		//其他费用定额标准
		var p_otherStd = $('#p_otherStd').val();
		var duration = $('#duration').numberbox("getValue");
		var p_otherAllMoney = $('#p_otherAllMoney').html();
		/* if (duration != '' && p_otherAllMoney != '' && p_otherAllMoney != '0.00元') {
			$('#otherStdUpdate').val(p_otherStd * newValue * duration);
		}else{
			$('#otherStdUpdate').val(0.00);
		} */
		selectbz(newValue);
		getStdAmount();
		validateMeetStd();
		countStd();
	}
});

$("#staffNum").numberbox({
	onChange: function(newValue, oldValue) {
		validateMeetStd();
		countStd();
	}
});


/*  $("#meetingType").combobox({
	onChange: function(newValue, oldValue) {
		var Daynum =parseInt($('#duration').numberbox('getValue'));
		if(!isNaN(Daynum)){
			if(newValue=='2'|newValue=='3'){
				if(Daynum>5){
					alert('二、三类会议天数超过不能超过5天，请重新填写');
					$("#meetingType").combobox('setValue','');
				}
			}else if(newValue=='4'){
				if(Daynum>4){
					alert('四类会议天数超过不能超过4天，请重新填写');
					$("#meetingType").combobox('setValue','');
				}
			}
		}
		
		validateMeetStd();
		loadMeetStd();
		countStd();
	}
});  */
 $('#duration').numberbox({
	 onChange: function(newValue, oldValue) {
		 var meetType = $('#meetingType').combobox('getValue');
		 if(meetType=='3'||meetType=='4'){
			 if(newValue>2){
				 alert('会议天数超过不能超过2天，请重新填写');
				 $('#meetingDateEnd').datebox('setValue','');
				 //$('#meetingDateStart').datebox('setValue','');
				 $('#duration').numberbox('setValue','');
			 }
		 }/* else if(meetType=='4'){
				if(newValue>4){
					alert('四类会议天数超过不能超过4天，请重新填写');
					$("#meetingType").combobox('setValue','');
				}
			} */

		 countStd();
	 }
 })	;
});


//加载费用标准
function loadMeetStd(){
	
	//var trainingType = parseInt($('#trainingType').combobox('getValue'));//参会人数
	
	var meetType = $('#meetingType').combobox('getValue');
	$.ajax({
		url : base + '/hotelStandard/getStd?applyType=meet&meetType='+meetType,
		type : 'get',
		async:false,
		dataType : 'json',
		success : function(map){
			for (var key in map) {
			// 	alert(map['hotel'])
			//	alert(map['food'])
			//	alert(map['other'])
				 
				if(key=='other'){
					$('#otherStd').val(map['other']);
					$('#p_otherStd').val(map['other']);
					var duration = $('#duration').numberbox("getValue");
					var attendNum = $('#attendNum').numberbox("getValue");
					if (duration != '' && attendNum != '') {
						//定额标准
						var p_otherStd = $('#p_otherStd').val();
						var p_otherAllMoney = $('#p_otherAllMoney').html();
						/* if(p_otherAllMoney != '' && p_otherAllMoney != '0.00元'){
							$('#otherStdUpdate').val(p_otherStd * duration * attendNum);
						}else{
							$('#otherStdUpdate').val(0.00);
						} */
					}
					getStdAmount();
				}if(key=='food'){
					$('#foodStd').val(map['food']);
					$('#p_foodStd').val(map['food']);
					var foodPersonNum = Number($('#foodPersonNum').val());
					if (foodPersonNum != '') {
						//定额标准
						var p_foodStd = $('#p_foodStd').val();
						$('#foodStdUpdate').val(p_foodStd * foodPersonNum);
					}
				}if(key=='hotel'){
					$('#hotelStd').val(map['hotel']);
					$('#p_hotelStd').val(map['hotel']);
					var hotelPersonNum = Number($('#hotelPersonNum').val());
					if (hotelPersonNum != '') {
						//定额标准
						var p_hotelStd = $('#p_hotelStd').val();
						$('#hotelStdUpdate').val(p_hotelStd * hotelPersonNum);
					}
				}
			}
			
		}
	});
}

//修改时初始加载费用标准
function loadMeetStd1(){
	var meetType = '${meetingBean.meetingType}';
	$.ajax({
		url : base + '/hotelStandard/getStd?applyType=meet&meetType='+meetType,
		type : 'get',
		async:false,
		dataType : 'json',
		success : function(map){
			for (var key in map) {
			/* 	alert(map['hotel'])
				alert(map['food'])
				alert(map['other'])
				 */
				 
				if(key=='other'){
					$('#otherStd').val(map['other']);
					$('#p_otherStd').val(map['other']);
					/* var duration = $('#duration').numberbox("getValue");
					var attendNum = $('#attendNum').numberbox("getValue");
					if (duration != '' && attendNum != '') {
						//定额标准
						var p_otherStd = $('#p_otherStd').val();
						var p_otherAllMoney = $('#p_otherAllMoney').html();
						if(p_otherAllMoney != '' && p_otherAllMoney != '0.00元' && p_otherAllMoney != '元'){
							$('#otherStdUpdate').val(p_otherStd * duration * attendNum);
						}else{
							$('#otherStdUpdate').val(0.00);
						}
					}
					getStdAmount(); */
				}if(key=='food'){
					$('#foodStd').val(map['food']);
					$('#p_foodStd').val(map['food']);
					/* var foodPersonNum = Number($('#foodPersonNum').val());
					if (foodPersonNum != '') {
						//定额标准
						var p_foodStd = $('#p_foodStd').val();
						$('#foodStdUpdate').val(p_foodStd * foodPersonNum);
					} */
				}if(key=='hotel'){
					$('#hotelStd').val(map['hotel']);
					$('#p_hotelStd').val(map['hotel']);
					/* var hotelPersonNum = Number($('#hotelPersonNum').val());
					if (hotelPersonNum != '') {
						//定额标准
						var p_hotelStd = $('#p_hotelStd').val();
						$('#hotelStdUpdate').val(p_hotelStd * hotelPersonNum);
					} */
				}
			}
			
		}
	});
}
//校验 会议人数标准
function validateMeetStd(){
	//会议类型
	var meetType = parseInt($('#meetingType').combobox('getValue'));
	//参会人数
	var meetPerson = parseInt($('#attendNum').numberbox('getValue'));
	if(!isNaN(meetPerson)&&!isNaN(meetType)){
		if (meetType==2) {
			//二类会议参会人数不能超过200人，工作人员数不超过15%;
			if (meetPerson > 200) {
				alert("二类会议参会人数，不能超过200人!");
				$('#attendNum').numberbox('setValue','');
				return false;
			} 
		} else if (meetType==3) {
			//三类会议参会人数不能超过150人，工作人员不超过10%
			if (meetPerson > 150) {
				alert("三类会议参会人数，不能超过150人!");
				$('#attendNum').numberbox('setValue','');
				return false;
			} 
		} /* else if (meetType==4) {
			//四类会议参会人数不能超过50人，工作人员不超过10%；
			if (meetPerson > 50) {
				var attendPeople = $("input[name='attendPeople']")[0].defaultValue;
				if(attendPeople == "" ){
				alert("四类会议参会人数，不能超过50人,如超过50人请填写备注!");
				$('#attendNum').numberbox('setValue','');
				}
				return false;
			} 
		} */
	}
	//工作人员数量
	var meetWorker = parseInt($('#staffNum').numberbox('getValue'));
	if (!isNaN(meetType) && !isNaN(meetPerson) && !isNaN(meetWorker)) {
		if (meetType==2) {
			//二类会议参会人数不能超过200人，工作人员数不超过15%;
			if (meetPerson > 200) {
				alert("二类会议参会人数，不能超过200人!");
				$('#attendNum').numberbox('setValue','');
				return false;
			} else if (meetWorker > meetPerson * 0.15 ) {
				alert("二类会议工作人员人数，不能超过参会人员的15%");
				$('#staffNum').numberbox('setValue','');
				return false;
			}
		} else if (meetType==3) {
			//三类会议参会人数不能超过150人，工作人员不超过10%
			if (meetPerson > 150) {
				alert("三类会议参会人数，不能超过150人!");
				$('#attendNum').numberbox('setValue','');
				return false;
			}
			if(meetPerson <10){
				if (meetWorker > 1 ) {
				alert("三类会议工作人员人数，不能超过参会人员的10%");
				$('#staffNum').numberbox('setValue','');
				return false;
				}
			}else if(meetWorker > (meetPerson-meetWorker) * 0.1){
				alert("三类会议工作人员人数，不能超过参会人员的10%");
				$('#staffNum').numberbox('setValue','');
				return false;
			}
		} else if (meetType==4) {
			//四类会议参会人数不能超过50人，工作人员不超过10%；
			/* if (meetPerson > 50) {
				alert("四类会议参会人数，不能超过50人!");
				$('#attendNums').numberbox('setValue','');
				return false;
			} */
			debugger
			if(meetPerson <=10){
				if(meetWorker > 1){
					alert("四类会议工作人员人数，不能超过参会人员的10%");
					$('#staffNum').numberbox('setValue','');
					return false;
				}
			}else if (meetWorker > (meetPerson-meetWorker) * 0.1 ) {
				alert("四类会议工作人员人数，不能超过参会人员的10%");
				$('#staffNum').numberbox('setValue','');
				return false;
			}
		}
	}
	return true;
}
//校验 总金额 true代表通过
function validateTotalMoney(){
	var duration = $('#duration').numberbox('getValue');//天数
	var personNum = 0;//总人数
	var std1 = parseInt($('#p_hotelStd').html());
	var std2 = parseInt($('#p_foodStd').html());
	var std3 = parseInt($('#p_otherStd').html());
	var meetPerson = parseInt($('#attendNum').numberbox('getValue'));
	var meetWorker = parseInt($('#staffNum').numberbox('getValue'));
	if (!isNaN(meetPerson)) {
		personNum = personNum + meetPerson;
	}
	if (!isNaN(meetWorker)) {
		personNum = personNum + meetWorker;
	}
	var applyMoney = parseInt($('#applyAmount_span').html());
	if (!isNaN(applyMoney)) {
		if (!isNaN(std1) && !isNaN(std2) 
				&& !isNaN(personNum) 
				&& !isNaN(duration)) {
			var stdMoney = duration * personNum * (std1 + std2 + std3);
			if (applyMoney > stdMoney) {
				alert("申请总额大于支出标准，请重新核对！");
				return false;
			}
		}
	}
	return true;
}
//更新支出标准
function countStd(){
	var meet_num = parseInt($('#duration').numberbox('getValue'));//会议天数
	var meet_personNum = parseInt($('#attendNum').numberbox('getValue'));//参会人数
	var num=0;
	if(isNaN(meet_num)){
		meet_num=parseInt(0);
	}
	if(isNaN(meet_personNum)){
		meet_personNum=parseInt(0);
	}
	if(!isNaN(meet_personNum)){
		num=num+meet_personNum;
	}
	var otherStd =parseFloat($('#otherStd').val());
	var totalStandard1= otherStd*num*meet_num;
	$('#appli-detail-dg1').datagrid('updateRow',{
			index: 2,
			row: {
				costDetail: '其他费用',
				standard: otherStd,
				totalStandard: totalStandard1
			}
	});
	var foodStd =parseFloat($('#foodStd').val());
	var totalStandard2= foodStd*num*meet_num;
	$('#appli-detail-dg1').datagrid('updateRow',{
				index: 1,
				row: {
					costDetail: '伙食费',
					standard: foodStd,
					totalStandard: totalStandard2
				}
	});
	var hotelStd =parseFloat($('#hotelStd').val());
	var totalStandard3= hotelStd*num*(meet_num-1);
	$('#appli-detail-dg1').datagrid('updateRow',{
				index: 0,
				row: {
					costDetail: '住宿费',
					standard: hotelStd,
					totalStandard: totalStandard3
				}
	});
	editIndex = undefined;
}

function getStdAmount(){
	var stdAmount = Number($('#hotelStdUpdate').val()) + Number($('#foodStdUpdate').val())
		+ Number($('#otherStdUpdate').val());
	$('#stdAmount_span').html(stdAmount.toFixed(2) + "[元]");
}


function reloadProcess() {
	var indexId = $('#F_fBudgetIndexCode').val();
	if (indexId != '' || indexId != null) {
		$('#check_system_div').load('${base}/apply/refreshApplyProcess?indexId='+indexId+'&applyType=2');
	}
}
$('#F_fBudgetIndexName').textbox({
	 onChange: function(newValue, oldValue) {
		 reloadProcess();
	 }
});

function downloadwj(){
	var url=base+"/apply/downloadwjgx";
	window.location.href=url; 
}
function selectbz(newvalue){
	 var meetType = $('#meetingType').combobox('getValue');
	//var cxjk = $('input[name="attendPeople"]:checked').val();
	if(meetType == '4'){
		if(newvalue>50){
			$('#bz').show();
		} else {
			$('#bz').hide();
		}
	}else {
		$('#bz').hide();
	}
}
function onShowPanelSHIAttend(){
	var fsheng =  $("#fsheng").combobox('getValue');
	if(fsheng==""){
		alert('请先选择省级地区！');
		return false;
	}
	var url = base+'/apply/getRegion?id='+fsheng;
    $('#fshi').combobox('reload', url);
}
function onShowPanelQUAttend(){
	var fshi =  $("#fshi").combobox('getValue');
	if(fshi==""){
		alert('请先选择市级地区！');
		return false;
	}
	var url = base+'/apply/getRegion?id='+fshi;
    $('#fqu').combobox('reload', url);
}
function onchangedaochu(newValue){
	if(newValue == '4'){
		$('#daochu').show();
	}else{
		$('#daochu').hide();
	}
}
</script>
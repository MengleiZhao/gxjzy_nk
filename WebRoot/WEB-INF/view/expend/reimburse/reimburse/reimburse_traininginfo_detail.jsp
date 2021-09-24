<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!-- 隐藏域主键 -->
<input type="hidden" id="hotelStd"/>
<input type="hidden" id="foodStd"/>
<input type="hidden" id="zongheStd"/>
<input type="hidden" id="otherStd"/>
<input type="hidden" id="lesson1Std"  />
<input type="hidden" id="lesson2Std"  />
<input type="hidden" id="lesson3Std"  />
<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 0px;">

	<tr class="trbody">
		<td class="td1" style=""><span class="style1">*</span> 培训名称</td>
		<td colspan="4">
			<input class="easyui-textbox" style="width: 580px; height: 30px;" name="trainingName" readonly="readonly"
			value="${reimbTrainingBean.trainingName}" required="required" data-options="validType:'length[1,50]'"/>
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1" style="width: 70px;"><span class="style1">*</span> 省</td>
		<td class="td2">
			<input  class="easyui-combobox" style="width: 200px; height: 30px;" id="fProvinceId" name="fProvinceId" readonly="readonly"
			value="${reimbTrainingBean.fProvinceId}" required="required" editable="false" data-options="editable:false,
				url:'${base}/apply/getRegion?id=0&selected=${reimbTrainingBean.fProvinceId}',
				method:'POST',
				valueField:'id',
				textField:'text'"/>
		</td>
		<td class="td4" style="width: 67px;"></td>
		<td class="td1" style="width: 70px;"><span class="style1">*</span> 市</td>
		<td class="td2">
			<input class="easyui-combobox" style="width: 200px;; height: 30px;" id="fCityId" name="fCityId" readonly="readonly"
			value="${reimbTrainingBean.fCityId}" required="required" editable="false" data-options="editable:false,
				method:'POST',
				url:'${base}/apply/getRegion?selected=${reimbTrainingBean.fCityId}',
				valueField:'id',
				textField:'text',
				onShowPanel:onShowPanelSHIAttendReim"/>
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1" style="width: 70px;"><span class="style1">*</span> 区</td>
		<td class="td2">
			<input  class="easyui-combobox" style="width: 200px;; height: 30px;" id="fDistrictId" name="fDistrictId" readonly="readonly"
			value="${reimbTrainingBean.fDistrictId}" required="required" editable="false" data-options="editable:false,
				url:'${base}/apply/getRegion?selected=${reimbTrainingBean.fDistrictId}',method:'POST',valueField:'id',textField:'text',
				onShowPanel:onShowPanelQUAttendReim"/>
		</td>
		<td class="td4" style="width: 67px;"></td>
		<td class="td1" style="width: 70px;"><span class="style1">*</span> 详细地址</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 200px;; height: 30px;" id="trPlace" name="trPlace" readonly="readonly"
			value="${reimbTrainingBean.trPlace}" required="required" />
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 参训人数</td>
		<td class="td2">
			<input  class="easyui-numberbox" style="width: 200px; height: 30px;" name="trAttendNum" id="trAttendNum" readonly="readonly"
			value="${reimbTrainingBean.trAttendNum}" required="required" data-options="validType:'length[1,3]'"/>
		</td>
		<td class="td4" style="width: 67px;"></td>
		<td class="td1">工作人员人数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 206px; height: 30px;" id="trStaffNum" name="trStaffNum" readonly="readonly"
			value="${reimbTrainingBean.trStaffNum}" data-options="validType:'length[1,3]'" />
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 报到日期</td>
		<td class="td2">
			<input  class="easyui-datebox" style="width: 200px;; height: 30px;" id="trDateStart" name="trDateStart" readonly="readonly"
			data-options="" value="${reimbTrainingBean.trDateStart}" required="required" editable="false"/>
		</td>

		<td class="td4" style="width: 67px;"></td>

		<td class="td1"><span class="style1">*</span> 撤离日期</td>
		<td class="td2">
			<input class="easyui-datebox" style="width: 206px;; height: 30px;" id="trDateEnd" name="trDateEnd" readonly="readonly"
			data-options="onChange:onSelect4" value="${reimbTrainingBean.trDateEnd}" required="required" editable="false"/>
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span>培训天数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 200px;; height: 30px;" id="trDayNum" name="trDayNum" 
			value="${reimbTrainingBean.trDayNum}" readonly="readonly" required="required" 
			data-options="validType:'length[1,2]',icons: [{iconCls:'icon-tian'}]"/>
		</td>
		<td class="td4" style="width: 67px;"></td>
		<td class="td1"></td>
		<td class="td2">
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span>
			经办人</td>
		<td class="td2"><input class="easyui-textbox" id="userNames"
			name="userNames" readonly="readonly" value="${applyBean.userNames}"
			style="width: 200px;height: 30px; "></td>
		<td class="td4" style="width: 67px;"></td>
		<td class="td1"><span class="style1">*</span>
			经办部门</td>
		<td class="td2"><input class="easyui-textbox" id="deptName"
			name="deptName" readonly="readonly" value="${applyBean.deptName}"
			style="width: 206px;height: 30px; "></td>
	</tr>
</table>


<script type="text/javascript">

//计算总人数
function addPersonNum(){
	var totalNum =0;
	var num1 =parseInt($("#trAttendNum").numberbox('getValue'));
	var num2 =parseInt($("#trStaffNum").numberbox('getValue'));
	if(!isNaN(num1)){
		totalNum =totalNum+num1;
	}
	if(!isNaN(num2)){
		totalNum =totalNum+num2;
	}
	$('#personNum1').val(totalNum);
	$('#personNum2').val(totalNum);
}

var startday3='${reimbTrainingBean.trDateStart}';
var endday3='${reimbTrainingBean.trDateEnd}';
$("#trDateStart").datebox({
    onSelect : function(beginDate){
    	startday3 = beginDate;
    	endday3 =new Date(endday3);
    	var d = (endday3-startday3)/86400000+1;
    	
    	if(d>0){
    		$('#trDayNum').numberbox("setValue",d);
    		$('#personDay2').val(d);
    		$('#personDay2').val(d);
    	} else {
    		$('#trDayNum').numberbox("setValue", "");
    		$('#personDay2').val("");
    		$('#personDay2').val("");
    	}
        $('#trDateEnd').datebox().datebox('calendar').calendar({
            validator: function(date){
	                return beginDate <= date;
            }
        });
    }
}); 


function onSelect4(){
	endday3 = new Date($("#trDateEnd").datebox('getValue'));
	startday3 =new Date(startday3);
	var d = (endday3-startday3)/86400000+1;
	if(d<=92&&d>0){
		$('#trDayNum').numberbox("setValue",d);
		$('#personDay1').val(d);
		$('#personDay2').val(d);
	}else if(d>92){
		alert('培训天数不能超过92天');
		$("#trDateStart").datebox('setValue','')
		$("#trDateEnd").datebox('setValue','')
		$("#trDayNum").numberbox('setValue','');
	} else {
		$('#trDayNum').numberbox("setValue", "");
		$('#personDay1').val("");
		$('#personDay2').val("");
	}
}

function loadTrainStd(){
	var trainType = $('#trainingType').combobox('getValue');
	$.ajax({
		url : base + '/hotelStandard/getStd?applyType=train&meetType='+trainType,
		type : 'post',
		dataType : 'json',
		success : function(map){
			for (var key in map) {
				if(key=='food'){
				$('#foodStd').val(map['food']);
				$('#foodStds').val(map['food']);
				}if(key=='hotel'){
				$('#hotelStd').val(map['hotel']);
				$('#hotelStds').val(map['hotel']);
				}if(key=='zonghe'){
				$('#zongheStd').val(map['zonghe']);
				$('#zongheStds').val(map['zonghe']);
				}if(key=='other'){
				$('#otherStd').val(map['other']);
				$('#otherStds').val(map['other']);
				}if(key=='lesson1'){
				$('#lesson1Std').val(map['lesson1']);
				$('#lesson1Stds').val(map['lesson1']);
				}if(key=='lesson2'){
				$('#lesson2Std').val(map['lesson2']);
				$('#lesson2Stds').val(map['lesson2']);
				}if(key=='lesson3'){
				$('#lesson3Std').val(map['lesson3']);
				$('#lesson3Stds').val(map['lesson3']);
				}
			}
			countStd()
		}
	});
}
//修改时进页面加载标准
function loadTrainStd1(){
	
	var trainType = '${reimbTrainingBean.trainingType}';
	$.ajax({
		url : base + '/hotelStandard/getStd?applyType=train&meetType='+trainType,
		type : 'post',
		dataType : 'json',
		success : function(map){
			for (var key in map) {
				if(key=='food'){
				$('#foodStd').val(map['food']);
				}if(key=='hotel'){
				$('#hotelStd').val(map['hotel']);
				}if(key=='zonghe'){
				$('#zongheStd').val(map['zonghe']);
				}if(key=='other'){
				$('#otherStd').val(map['other']);
				}if(key=='lesson1'){
				$('#lesson1Std').val(map['lesson1']);
				}if(key=='lesson2'){
				$('#lesson2Std').val(map['lesson2']);
				}if(key=='lesson3'){
				$('#lesson3Std').val(map['lesson3']);
				}
			}
		}
	});
}
//更新支出标准
function countStd(){
	var train_num = parseInt($('#trDayNum').numberbox('getValue'));//培训天数
	var train_personNum = parseInt($('#trAttendNum').numberbox('getValue'));//参会人数
	var train_workNum = parseInt($('#trStaffNum').numberbox('getValue'));//工作人数
	var num=0;
	if(isNaN(train_workNum)){
		train_workNum=parseInt(0);
	}
	if(isNaN(train_num)){
		train_num=parseInt(0);
	}
	if(isNaN(train_personNum)){
		train_personNum=parseInt(0);
	}
	if(!isNaN(train_personNum)){
		num=num+train_personNum;
	}
	if(!isNaN(train_workNum)){
		num=num+train_workNum;
	}
	if(train_personNum>10){
		if(train_workNum>train_personNum*0.1||train_workNum>10){
			$('#trStaffNum').numberbox('setValue',0);
			alert('工作人员数量不得超过参训人数的10%，最多不超过10人！');
			return false;
		}
	}
	if(train_personNum<=10){
		if(train_workNum>1){
			alert('10人以下的培训参训人数，不能大于1人');
			$('#trStaffNum').numberbox('setValue',0);
			return false;
		}
	}
}

$(document).ready(function() {
	loadTrainStd1()
});



//选择培训类型后，触发事件
function initComboTrainingType(){
	//trainingType
	$('#trainingType').combobox({
		onSelect : function(rec) {
			var trainingType = rec.trainingType;
			if (trainingType==1) {
				alert("系统提示：一类会议是指参训人员主要为市级干部及响应人员的培训项目");
			} else if (trainingType==2) {
				alert("系统提示：二类会议是指参训人员主要为局级干部的培训项目");
			} else if (trainingType==3) {
				alert("系统提示：三类会议是指参训人员主要为处级以下干部的培训项目");
			}
		}
	});
}
//trDateStart trDateEnd
function initComboboxDateStart(){
	$("#trDateStart").datetimebox({
		onSelect : function(value) {
			var dates = new Date(value);
			var datee = new Date($('#trDateEnd').datetimebox('getValue'));
		}
	});
}
function initComboboxDateEnd(){
	$("#trDateEnd").datetimebox({
		onSelect : function(value) {
			var dates = new Date($('#trDateStart').datetimebox('getValue'));
			var datee = new Date(value);
			//alert(dates)
			//alert(datee)
			var d = (datee-dates)/86400000+1;
			$('#dayLong').numberbox('setValue',d);
		}
	});
}
$("#trainingType").combobox({
	onChange : function(newValue, oldValue) {
		loadTrainStd();
	}
});


$("#trAttendNum").numberbox({
	onChange: function(newValue, oldValue) {
		countStd();
	}
});

$("#trStaffNum").numberbox({
	onChange: function(newValue, oldValue) {
		countStd();
	}
});

$("#trDayNum").numberbox({
	onChange: function(newValue, oldValue) {
		countStd();
		var data = new Array();
		$('#dg_train_plan').datagrid('loadData',data);
	}
});
function onShowPanelSHIAttendReim(){
	var fProvinceId =  $("#fProvinceId").combobox('getValue');
	if(fProvinceId==""){
		alert('请先选择省级地区！');
		return false;
	}
	var url = base+'/apply/getRegion?id='+fProvinceId;
    $('#fCityId').combobox('reload', url);
}
function onShowPanelQUAttendReim(){
	var fCityId =  $("#fCityId").combobox('getValue');
	if(fCityId==""){
		alert('请先选择市级地区！');
		return false;
	}
	var url = base+'/apply/getRegion?id='+fCityId;
    $('#fDistrictId').combobox('reload', url);
}
</script>

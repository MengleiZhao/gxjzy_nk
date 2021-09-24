<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!-- 隐藏域主键 -->
<input type="hidden" name="tId" value="${trainingBean.tId}" />
<input type="hidden" id="hotelStd"/>
<input type="hidden" id="foodStd"/>
<input type="hidden" id="zongheStd"/>
<input type="hidden" id="otherStd"/>
<input type="hidden" id="costExternalHotel"/>
<input type="hidden" id="costExternalFood"/>
<input type="hidden" id="costExternalBook"/>
<input type="hidden" id="costExternalOther"/>
<input type="hidden" id="lesson1Std"/>
<input type="hidden" id="lesson2Std"/>
<input type="hidden" id="lesson3Std"/>
<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 0px;margin-left: 3px;">
	<tr class="trbody">
		<td class="td1" style=""><span class="style1">*</span> 培训名称</td>
		<td colspan="4">
			<input class="easyui-textbox" style="width: 580px; height: 30px;" name="trainingName"
			value="${trainingBean.trainingName}" required="required" data-options="validType:'length[1,50]'"/>
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1" style="width: 70px;"><span class="style1">*</span> 省</td>
		<td class="td2">
			<input  class="easyui-combobox" style="width: 200px;; height: 30px;" id="fProvinceId" name="fProvinceId" <c:if test="${operation=='edit'}"> readonly="readonly"</c:if>
			value="${travelBean.fProvinceId}" required="required" editable="false" data-options="editable:false,
				url:'${base}/apply/getRegion?id=0&selected=${trainingBean.fProvinceId}',
				method:'POST',
				valueField:'id',
				textField:'text',
				onSelect: function(rec){
					$('#fCityId').combobox('setValue', '');
				    var url = '${base}/apply/getRegion?id='+rec.id+'&selected=${trainingBean.fCityId}';
				    $('#fCityId').combobox('reload', url);
				    }"/>
		</td>
		<td class="td4" style="width: 67px;"></td>
		<td class="td1" style="width: 70px;"><span class="style1">*</span> 市</td>
		<td class="td2">
			<input class="easyui-combobox" style="width: 200px;; height: 30px;" id="fCityId" name="fCityId" <c:if test="${operation=='edit'}"> readonly="readonly"</c:if>
			value="${travelBean.fCityId}" required="required" editable="false" data-options="editable:false,
				method:'POST',
				valueField:'id',
				textField:'text',
				onSelect: function(rec){
				    var url = '${base}/apply/getRegion?id='+rec.id+'&selected=${trainingBean.fDistrictId}';
				    $('#fDistrictId').combobox('reload', url);
					$('#fDistrictId').combobox('setValue', '');
				    }"/>
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1" style="width: 70px;"><span class="style1">*</span> 区</td>
		<td class="td2">
			<input  class="easyui-combobox" style="width: 200px;; height: 30px;" id="fDistrictId" name="fDistrictId" <c:if test="${operation=='edit'}"> readonly="readonly"</c:if>
			value="${travelBean.fDistrictId}" required="required" editable="false" data-options="
			editable:false,
			method:'POST',
			valueField:'id',
			textField:'text'"/>
		</td>
		<td class="td4" style="width: 67px;"></td>
		<td class="td1" style="width: 70px;"><span class="style1">*</span> 详细地址</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 200px;; height: 30px;" id="trPlace" name="trPlace" <c:if test="${operation=='edit'}"> readonly="readonly"</c:if>
			value="${trainingBean.trPlace}" required="required" />
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 参训人数</td>
		<td class="td2">
			<input  class="easyui-numberbox" style="width: 200px; height: 30px;" name="trAttendNum" id="trAttendNum" <c:if test="${operation=='edit'}"> readonly="readonly"</c:if>
			value="${trainingBean.trAttendNum}" required="required" data-options="validType:'length[1,3]'"/>
		</td>

		<td class="td4" style="width: 67px;"></td>

		<td class="td1"><span class="style1">*</span>工作人员人数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 200px; height: 30px;" id="trStaffNum" name="trStaffNum" <c:if test="${operation=='edit'}"> readonly="readonly"</c:if>
			value="${trainingBean.trStaffNum}" required="required" data-options="validType:'length[1,3]'"/>
		</td>
	</tr>
	
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 报到时间</td>
		<td class="td2">
			<input  class="easyui-datebox" style="width: 200px;; height: 30px;" id="trDateStart" name="trDateStart" <c:if test="${operation=='edit'}"> readonly="readonly"</c:if>
			data-options="" value="${trainingBean.trDateStart}" required="required" editable="false"/>
		</td>

		<td class="td4" style="width: 67px;"></td>

		<td class="td1"><span class="style1">*</span> 撤离时间</td>
		<td class="td2">
			<input class="easyui-datebox" style="width: 200px;; height: 30px;" id="trDateEnd" name="trDateEnd" <c:if test="${operation=='edit'}"> readonly="readonly"</c:if>
			data-options="onChange:onSelect4" value="${trainingBean.trDateEnd}" required="required" editable="false"/>
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span>培训天数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 200px;; height: 30px;" id="trDayNum" name="trDayNum" 
			value="${trainingBean.trDayNum}" readonly="readonly" required="required" 
			data-options="validType:'length[1,2]',icons: [{iconCls:'icon-tian'}]"/>
		</td>
		<td class="td4" style="width: 67px;"></td>
		<td class="td1"></td>
		<td class="td2">
		</td>
		
		<%-- <td class="td4" style="width: 67px;"></td>
		<td class="td1"><span class="style1">*</span> 培训类别</td>
		<td class="td2">
			<input id="trainingType" class="easyui-combobox" required="required" style="width: 200px; height: 30px;" value="${trainingBean.trainingType}" name="trainingType"
			data-options="valueField: 'trainingType',textField: 'value',editable: false,
				data: [{trainingType: '1',value: '一类培训'},{trainingType: '2',value: '二类培训'},{trainingType: '3',value: '三类培训'}]"/> 
		</td> --%>
	</tr>

	<%-- <tr class="trbody">
		<td class="td1"><span class="style1">*</span> 培训地点</td>
		<td colspan="4">
			<input class="easyui-textbox" style="width: 580px; height: 30px;" name="trPlace"
			value="${trainingBean.trPlace}" required="required" data-options="prompt: '填写时地点精确到会议室房间号' ,validType:'length[1,50]'"/>
		</td>
	</tr>


	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 参训人员说明</td>
		<td colspan="4">
			<input class="easyui-textbox" style="width: 580px; height: 30px;" name="trAttendPeop"
			value="${trainingBean.trAttendPeop}" required="required" data-options="validType:'length[1,100]'"/>
		</td>
	</tr> --%>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span>
			经办人</td>
		<td class="td2"><input class="easyui-textbox" id="userNames"
			name="userNames" readonly="readonly" value="${bean.userNames}"
			style="width: 200px;height: 30px; "></td>
		<td class="td4" style="width: 67px;"></td>
		<td class="td1"><span class="style1">*</span>
			经办部门</td>
		<td class="td2"><input class="easyui-textbox" id="deptName"
			name="deptName" readonly="readonly" value="${bean.deptName}"
			style="width: 200px;height: 30px; "></td>
	</tr>
</table>


<script type="text/javascript">
var startday3='${trainingBean.trDateStart}';
var endday3='${trainingBean.trDateEnd}';
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
		$("#trDayNum").numberbox('setValue','')
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
				}
				if(key=='hotel'){
					$('#hotelStd').val(map['hotel']);
				}
				if(key=='zonghe'){
					$('#zongheStd').val(map['zonghe']);
				}
				if(key=='other'){
					$('#otherStd').val(map['other']);
				}
				if(key=='externalFood'){
					$('#costExternalFood').val(map['externalFood']);
				}
				if(key=='externalHotel'){
					$('#costExternalHotel').val(map['externalHotel']);
				}
				if(key=='externalZonghe'){
					$('#costExternalBook').val(map['externalZonghe']);
				}
				if(key=='externalOther'){
					$('#costExternalOther').val(map['externalOther']);
				}
				if(key=='lesson1'){
					$('#lesson1Std').val(map['lesson1']);
				}
				if(key=='lesson2'){
					$('#lesson2Std').val(map['lesson2']);
				}
				if(key=='lesson3'){
					$('#lesson3Std').val(map['lesson3']);
				}
			}
			countStd();
		}
	});
}
//修改时进页面加载标准
function loadTrainStd1(){
	var trainType = '${trainingBean.trainingType}';
	$.ajax({
		url : base + '/hotelStandard/getStd?applyType=train&meetType='+trainType,
		type : 'post',
		dataType : 'json',
		success : function(map){
			for (var key in map) {
				if(key=='food'){
					$('#foodStd').val(map['food']);
				}
				if(key=='hotel'){
					$('#hotelStd').val(map['hotel']);
				}
				if(key=='zonghe'){
					$('#zongheStd').val(map['zonghe']);
				}
				if(key=='other'){
					$('#otherStd').val(map['other']);
				}
				if(key=='externalFood'){
					$('#costExternalFood').val(map['externalFood']);
				}
				if(key=='externalHotel'){
					$('#costExternalHotel').val(map['externalHotel']);
				}
				if(key=='externalZonghe'){
					$('#costExternalBook').val(map['externalZonghe']);
				}
				if(key=='externalOther'){
					$('#costExternalOther').val(map['externalOther']);
				}
				if(key=='lesson1'){
					$('#lesson1Std').val(map['lesson1']);
				}
				if(key=='lesson2'){
					$('#lesson2Std').val(map['lesson2']);
				}
				if(key=='lesson3'){
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
				alert("系统提示：一类培训是指参训人员主要为市级干部及响应人员的培训项目");
			} else if (trainingType==2) {
				alert("系统提示：二类培训是指参训人员主要为局级干部的培训项目");
			} else if (trainingType==3) {
				alert("系统提示：三类培训是指参训人员主要为处级以下干部的培训项目");
			}
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
function onShowPanelSHIAttend(){
	var fProvinceId =  $("#fProvinceId").combobox('getValue');
	if(fProvinceId==""){
		alert('请先选择省级地区！');
		return false;
	}
	var url = base+'/apply/getRegion?id='+fProvinceId;
    $('#fCityId').combobox('reload', url);
}
function onShowPanelQUAttend(){
	var fCityId =  $("#fCityId").combobox('getValue');
	if(fCityId==""){
		alert('请先选择市级地区！');
		return false;
	}
	var url = base+'/apply/getRegion?id='+fCityId;
    $('#fDistrictId').combobox('reload', url);
}
</script>

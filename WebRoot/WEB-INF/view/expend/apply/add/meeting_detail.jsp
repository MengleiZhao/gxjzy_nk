<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/includes/taglibs.jsp"%>

<style type="text/css">
</style>

<!-- 隐藏域主键 -->
<input type="hidden" name="mId" value="${meetingBean.mId}" />

<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: -12px;">
	<tr class="trbody">
		<td class="td1" ><span class="style1">*</span> 会议名称</td>
		<td class="td2" colspan="3" >
			<input class="easyui-textbox" style="width: 590px; height: 30px;" name="meetingName" 
			value="${meetingBean.meetingName}" readonly="readonly" required="required" data-options="validType:'length[1,50]'"/>
		</td>
	</tr>
	<%-- <tr class="trbody">
		<td class="td1" ><span class="style1">*</span> 会议类型</td>
		<td class="td2" style="width: 281px;">
			<input id="meetingType" class="easyui-combobox" readonly="readonly" style="width: 200px; height: 30px;" name="meetingType" value="${meetingBean.meetingType}"
				data-options="valueField: 'meetingType',textField: 'value',editable: false,
				data: [{meetingType: '1',value: '一类会议'},{meetingType: '2',value: '二类会议'},{meetingType: '3',value: '三类会议'},{meetingType: '4',value: '四类会议'}]"/>
		</td>

		<td class="td1"><span class="style1">*</span> 会议方式</td>
		<td class="td2">
		</td>
			
			
		</td>
	</tr> --%>

	<tr class="trbody">
		<td class="td1" ><span class="style1">*</span> 会议类型</td>
		<td class="td2">
			<input id="meetingType" class="easyui-combobox" readonly="readonly" style="width: 200px; height: 30px;" name="meetingType" value="${meetingBean.meetingType}"
				data-options="prompt: '-请选择-' ,valueField: 'meetingType',textField: 'value',editable: false,
				data: [{meetingType: '1',value: '一类会议'},{meetingType: '2',value: '二类会议'},{meetingType: '3',value: '三类会议'},{meetingType: '4',value: '四类会议'}]"/>
		</td>
		<td class="td1"><span class="style1">*</span> 会议方式</td>
		<td class="td2" style="width: 200px;">
			<input id="meetingMethod" class="easyui-combobox" readonly="readonly" style="width: 130px; height: 30px;" name="meetingMethod" value="${meetingBean.meetingMethod}"
				data-options="prompt: '-请选择-' ,valueField: 'meetingMethod',textField: 'value',editable: false,
				data: [{meetingMethod: '1',value: '电视电话'},{meetingMethod: '2',value: '网络视频会议'},{meetingMethod: '3',value: '单位内部会议室'},{meetingMethod: '4',value: '外部定点会议室'}]"/>
				<a id="daochu" href="javascript:void(0)" onclick="downloadwj()">
					<img style="vertical-align:bottom;margin-bottom: 5px;" src="${base}/resource-modality/${themenurl}/button/daochu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
				</a>
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 省</td>
		<td class="td2" style="width: 180px;">
			<input class="easyui-combobox" id="fsheng" name="fsheng" style="width: 200px;height: 30px;margin-left: 10px " value="${meetingBean.fsheng}" readonly="readonly" required="required" editable="false"data-options="editable:false,
				url:'${base}/apply/getRegion?id=0&selected=${meetingBean.fsheng}',
				method:'POST',
				valueField:'id',
				textField:'text'"/>
		</td>

		<td class="td1" ><span class="style1">*</span>市</td>
		<td class="td2" >
			<input class="easyui-combobox" id="fshi" name="fshi" style="width: 200px;height: 30px;margin-left: 10px " value="${meetingBean.fshi}" readonly="readonly" required="required" editable="false" data-options="editable:false,
				method:'POST',
				url:'${base}/apply/getRegion?selected=${meetingBean.fshi}',
				valueField:'id',
				textField:'text'"/>
		</td>
	</tr> 
	
	 <tr class="trbody">
		 <td class="td1"><span class="style1">*</span>区</td>
		<td class="td2">
		<input class="easyui-combobox" id="fqu" name="fqu" style="width: 200px;height: 30px;margin-left: 10px " value="${meetingBean.fqu}" readonly="readonly" required="required" editable="false" data-options="editable:false,
			url:'${base}/apply/getRegion?selected=${meetingBean.fqu}',method:'POST',valueField:'id',textField:'text',
			"/>
		</td> 
		<td class="td1"><span class="style1">*</span> 详细地址</td>
		<td colspan="3">
			<input class="easyui-textbox" style="width: 200px; height: 30px;" name="meetingPlace" 
			value="${meetingBean.meetingPlace}" readonly="readonly" required="required" data-options="prompt: '请填写详细地址' ,validType:'length[1,50]'"/>
		</td>
	</tr> 

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 参会人数</td>
		<td class="td2"><input class="easyui-numberbox" style="width: 200px; height: 30px;" name="attendNum" id="attendNum" readonly="readonly"
			value="${meetingBean.attendNum}" required="required" data-options="validType:'length[1,3]'"/>
		</td>

		<td class="td1">其中工作人员人数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 200px; height: 30px;" readonly="readonly"
			id="staffNum" name="staffNum"
			value="${meetingBean.staffNum}" data-options="validType:'length[1,3]'"/>
		</td>
	</tr>

	<tbody id="bz" >
			<tr class="trbody">
				<td class="td1"><span class="style1"></span> 备注</td>
				<td colspan="3">
					<input class="easyui-textbox" style="width: 590px; height: 30px;" name="attendPeople"
					value="${meetingBean.attendPeople}" required="required" data-options="validType:'length[1,100]'"/>
				</td>
			</tr>
		</tbody>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 报到时间</td>
		<td class="td2" style="width: 281px;">
			<input class="easyui-datebox" readonly="readonly" style="width: 200px; height: 30px;" id="meetingDateStart" name="dateStart"
			data-options="" value="${meetingBean.dateStart}" required="required" editable="false"/>
		</td>

		<td class="td1"><span class="style1">*</span> 离开时间</td>
		<td class="td2">
			<input class="easyui-datebox" readonly="readonly" style="width: 200px; height: 30px;" id="meetingDateEnd" name="dateEnd"
			data-options="onSelect:onSelect2" value="${meetingBean.dateEnd}" required="required" editable="false"/>
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 会议天数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 200px; height: 30px;" id="duration" name="duration" 
			value="${meetingBean.duration}" readonly="readonly" required="required" data-options="iconCls:'icon-tian',validType:'length[1,2]'"/>
		</td>
		<td class="td1" ></td>
		<td class="td2" style="width: 200px;">
		</td>
	</tr>
	
	<%-- <tr class="trbody">
		<td class="td1"><span class="style1">*</span> 参会人员说明</td>
		<td colspan="3">
			<input class="easyui-textbox" style="width: 590px; height: 30px;" name="attendPeople" readonly="readonly"
			value="${meetingBean.attendPeople}" required="required" data-options="validType:'length[1,100]'"/>
		</td>
	</tr> --%>

	<tr style="height:5px;"></tr>

	<%-- <tr class="trbody">
		<td class="td1" valign="top"><p style="margin-top: 8px">会议内容</p></td>
		<td colspan="3">
			 <input class="easyui-textbox"data-options="multiline:true,required:false,validType:'length[0,250]'" readonly="readonly" name="content" style="width:590px;height:70px;" 
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

<script type="text/javascript">
var startday2='${meetingBean.dateStart}';
var endday2='${meetingBean.dateEnd}';



$(document).ready(function() {
	var meetingMethod = $('#meetingMethod').val();
	if(meetingMethod == '4'){
		$('#daochu').show();
	}else{
		$('#daochu').hide();
	}
var meetType = $("#meetingType")[0].value;
var newvalue = $("#attendNum")[0].value;//参会人数
if(meetType == '4'){
	if(newvalue>50){
		$('#bz').show();
	}else {
		$('#bz').hide();
	}
}else {
	$('#bz').hide();
}
//设置会议天数和参会人员的变更方法
$("#attendNum").numberbox({
	onChange: function(newValue, oldValue) {
		autoCalStdMoney();
	}
});

$("#staffNum").numberbox({
	onChange: function(newValue, oldValue) {
		autoCalStdMoney();
	}
});

$("#otherMoney").numberbox({
	onChange: function(newValue, oldValue) {
		autoCalStdMoney();
	}
});
/* $("#meetingType").combobox({
	onChange: function(newValue, oldValue) {
		autoCalStdMoney();//会议类型，重新计算开支标准
	}
}); */
	
//设值复选框的值
});

/* $("#meetingType").combobox({
	onUnselect : function(rec) {
		alert(1)
		$('#appli-detail-dg').datagrid('loadData',[]);
		$('#num1').textbox('setValue',0);
		$('#applyAmount').textbox('setValue',0);
	}
}); */

$("#meetingType").combobox({
	onChange : function() {
		loadMeetStd();
		/* alert(2)
		$("#appli-detail-dg").datagrid({
		columns: [[{ field: 'cId', hidden:true},
			{field: 'costDetail', title: '支出明细', width: 150, align: 'center', 
					editor: { type: 'combobox', 
						options: { url:base+'/ExpenditureMatter/lookupsJsonAll?type=2&meetingType='+rec.meetingType, valueField: "feName", textField: "feName",
					    	onSelect:function(item){
								var index=$("#appli-detail-dg").datagrid('getRowIndex',$('#appli-detail-dg').datagrid('getSelected'));
								var tr = $("#appli-detail-dg").datagrid('getEditors', index);
								
								var dayNum = $("#meetingDay").textbox('getValue');//会议天数
								var attendNum = $("#attendNum").textbox('getValue');//参会人数
								
								tr[1].target.textbox('setValue', parseFloat(item.feStandard*dayNum*attendNum));//运算规则（开支标准*会议天数*参会人数）
								tr[1].target.textbox('textbox').attr('readonly',true);
							}
						 }
					}
			},
	        { field: 'standard', title: '支出标准', width: 150, editor: { type: 'textbox'} },
	        { field: 'applySum', title: '申请金额[元]', width: 150, align: 'center', editor: { type: 'numberbox', options: { onChange:addNum,precision:2 } },formatter:function(value,row,index){return fomatMoney(value,2);} },
	        { field: 'remark', title: '描述', width: 185, align: 'center', editor: { type: 'textbox' } }]]
		}); */
	}
});
function loadMeetStd(){
	var meetType = $('#meetingType').combobox('getValue');
	$.ajax({
		url : base + '/hotelStandard/getStd?applyType=meet&meetType='+meetType,
		type : 'post',
		dataType : 'json',
		success : function(map){
			for (var key in map) {
			/* 	alert(map['hotel'])
				alert(map['food'])
				alert(map['other'])
				 */
				/* if(key=='other'){
				$('#p_otherStd').html(map['other']);
				} */if(key=='food'){
				$('#p_foodStd').html(map['food']);
				$('#foodStd').val(map['food']);
				}if(key=='hotel'){
				$('#p_hotelStd').html(map['hotel']);
				$('#hotelStd').val(map['hotel']);
				}
			}
			autoCalStdMoney();
		}
	});
}


function onSelect2(date) {
	endday2 = date;
	startday2 = new Date(startday2);
	var d = (endday2 - startday2) / 86400000 + 1;
	if (d > 0) {
		$('#duration').numberbox("setValue", d);
	} else {
		$('#duration').numberbox("setValue", "");
	}
}

//自动获得费用明细
function calcTravelCost(){
	
	var meet_num = $("#meetingDay").textbox('getValue');//会议天数
	var meet_personNum = $("#attendNum").textbox('getValue');//参会人数
	if(meet_personNum=='' || meet_num==''){
		return;
	}
	
	$('#appli-detail-dg-travel').datagrid({
		url: base+'/hotelStandard/calcCost?outType=meet',
		queryParams:{
			meet_personNum: meet_personNum,
			meet_num: meet_num
		}
	});
}

//校验 会议人数标准
function validateMeetStd(){
	//会议类型
	var meetType = parseInt($('#meetingType').combobox('getValue'));
	//参会人数
	var meetPerson = parseInt($('#attendNum').numberbox('getValue'));
	//工作人员数量
	var meetWorker = parseInt($('#staffNum').numberbox('getValue'));
	if (!isNaN(meetType) && !isNaN(meetPerson) && !isNaN(meetWorker)) {
		if (meetType==2) {
			//二类会议参会人数不能超过200人，工作人员数不超过15%;
			if (meetPerson > 200) {
				alert("二类会议参会人数，不能超过200人!");
				return false;
			} else if (meetWorker > meetPerson * 0.15 ) {
				alert("二类会议工作人员人数，不能超过15%");
				return false;
			}
		} else if (meetType==3) {
			//三类会议参会人数不能超过150人，工作人员不超过10%
			if (meetPerson > 150) {
				alert("三类会议参会人数，不能超过150人!");
				return false;
			} else if (meetWorker > meetPerson * 0.1 ) {
				alert("三类会议工作人员人数，不能超过10%");
				return false;
			}
		} else if (meetType==4) {
			//四类会议参会人数不能超过50人，工作人员不超过10%；
			if (meetPerson > 50) {
				alert("四类会议参会人数，不能超过50人!");
				return false;
			} else if (meetWorker > meetPerson * 0.1 ) {
				alert("四类会议工作人员人数，不能超过10%");
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
	//var std3 = parseInt($('#p_otherStd').html());
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
			var stdMoney = duration * personNum * (std1 + std2 + 110);
			if (applyMoney > stdMoney) {
				alert("申请总额大于支出标准，请重新核对！");
				return false;
			}
		}
	}
	return true;
}
//自动计算 支出标准总额 （待完成）
function autoCalStdMoney(){
	var duration =$('#duration').numberbox('getValue');
	var personNum = 0;
	var std1 = parseInt($('#p_hotelStd').html());
	var std2 = parseInt($('#p_foodStd').html());
	//var std3 = parseInt($('#p_otherStd').html());
	//住宿费总额
	var hotelMoney = 0;
	//伙食费
	var foodMoney = 0;
	//其他费用
	var otherMoney = parseFloat($('#otherMoney').numberbox('getValue'));
	var meetPerson = parseInt($('#attendNum').numberbox('getValue'));
	var meetWorker = parseInt($('#staffNum').numberbox('getValue'));
	if (!isNaN(meetPerson)) {
		personNum = personNum + meetPerson;
	}
	if (!isNaN(meetWorker)) {
		personNum = personNum + meetWorker;
	}
	if (!isNaN(std1) && !isNaN(std2) 
			&& !isNaN(personNum) 
			&& !isNaN(duration)) {
		hotelMoney =duration * personNum *std1;
		var stdMoney = duration * personNum * (std1 + std2 );
		if(!isNaN(otherMoney)){
			stdMoney = stdMoney +otherMoney;
		}
		$('#p_hotelMoney').html(hotelMoney.toFixed(2)+"元");
		$('#hotelMoney').val(hotelMoney.toFixed(2));
		foodMoney =duration * personNum *std2;
		$('#p_foodMoney').html(foodMoney.toFixed(2)+"元");
		$('#foodMoney').val(foodMoney.toFixed(2));
		//otherMoney =duration * personNum *std3;
	/* 	$('#otherMoney').numberbox('setValue',otherMoney); */
		//$('#stdAmount_span').html(stdMoney);
		$('#applyAmount').val(stdMoney.toFixed(2));//
		$('#applyAmount_span').html(fomatMoney(stdMoney,2)+" [元]");
	}
}

function downloadwj(){
	var url=base+"/apply/downloadwjgx";
	window.location.href=url; 
}

	
</script>

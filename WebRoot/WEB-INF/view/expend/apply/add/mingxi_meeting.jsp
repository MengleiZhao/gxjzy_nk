<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<table class="window-table-readonly" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1"><p>费用名称：</p></td>
			<td class="window-table-td2">
				<p style=" color:#0000CD;">住宿费</p>
			</td>
			<td class="window-table-td1"><p>费用标准：</p></td>
			<td class="window-table-td2">
				<font id="p_hotelStd"></font>元/人天
				<input type="hidden"
					id="hotelStd" name="hotelStd" value="${meetingBean.hotelStd }"/>
			</td>
		</tr>
	<%-- 	<tr>
			<td class="window-table-td1"><p>住宿人数：</p></td>
			<td class="window-table-td2">
				<input id="nb_hotelPerson" name="hotelPersonNum" value="${meetingBean.hotelPersonNum}"
				class="easyui-numberbox"
				style="height:25px;"/>
			</td>
			
			<td class="window-table-td1"><p>住宿天数：</p></td>
			<td class="window-table-td2">
				<input id="nb_hotelDays" name="hotelDayNum" value="${meetingBean.hotelDayNum }"
				class="easyui-numberbox"
				style="height:25px;"/>
			</td>
		</tr> --%>
		<tr>
			<td class="window-table-td1"><p>申请金额：</p></td>
			<td class="window-table-td2">
				<c:if test="${operation!='add'&& operation!='edit'}">
					<p id="p_hotelMoney">${meetingBean.hotelMoney}元</p>
				</c:if>
				<c:if test="${operation=='add'|| operation=='edit'}">
					<input id="hotelMoney" class="easyui-numberbox" style="height:25px;width:110px" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" name="hotelMoney" value="${meetingBean.hotelMoney }"/>
				</c:if>
			</td>
			<td class="window-table-td1" ><p style="">总额限制：</p> </td>
			<td class="window-table-td2" style="margin-right:8px">
				<font id="p_allhotelMoney"></font>元
			</td>
		</tr>
</table>		
<div style="height:10px;"></div>
<table class="window-table-readonly" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1"><p>费用名称：</p></td>
			<td class="window-table-td2">
				<p style=" color:#0000CD;">伙食费</p>
			</td>
			
			<td class="window-table-td1"><p>费用标准：</p></td>
			<td class="window-table-td2">
				<font id="p_foodStd"></font>元/人天
				<input type="hidden"
				id="foodStd" name="foodStd" value="${meetingBean.foodStd }"/>
			</td> 
		</tr>
	<%-- 	<tr>
			<td class="window-table-td1"><p>申请人数：</p></td>
			<td class="window-table-td2">
				<input id="nb_foodPerson"
				name="foodPersonNum" value="${meetingBean.foodPersonNum }"
				class="easyui-numberbox"
				style="height:25px;"/>
			</td>
			
			<td class="window-table-td1"><p>申请天数：</p></td>
			<td class="window-table-td2">
				<input id="nb_foodDays" 
				name="foodDayNum" value="${meetingBean.foodDayNum }"
				class="easyui-numberbox"
				style="height:25px;"/>
			</td>
		</tr> --%>
		<tr>
			<td class="window-table-td1"><p>申请金额：</p></td>
			<td class="window-table-td2">
				<c:if test="${operation!='add'&& operation!='edit'}">
				<p id="p_foodMoney">${meetingBean.foodMoney}元</p>
				</c:if>
				<c:if test="${operation=='add'|| operation=='edit'}">
				<%-- <p id="p_foodMoney">${meetingBean.foodMoney }元</p> --%>
				<input class="easyui-numberbox" style="height:25px;width:110px" data-options="icons: [{iconCls:'icon-yuan'}],precision:2"
				id="foodMoney" name="foodMoney" value="${meetingBean.foodMoney }"/>
				</c:if>
			</td>
			<td class="window-table-td1" ><p style="">总额限制：</p> </td>
			<td class="window-table-td2" style="margin-right:8px">
				<font id="p_allfoodMoney"></font>元
			</td>
		</tr>
</table>		
<div style="height:10px;"></div>
<table class="window-table-readonly" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1"><p >费用名称：</p></td>
			<td class="window-table-td2">
				<p style=" color:#0000CD;">其他费用</p>
			</td>
			
			<td class="window-table-td1" ><p style="">费用标准：</p> </td>
			<td class="window-table-td2" style="margin-right:8px">
				<font id="p_otherStd"></font>元/人天
				<input type="hidden" 
				id="otherStd" name="otherStd" value="${meetingBean.otherStd }"/>
			</td>
		</tr>
	<%-- 	<tr>
			<td class="window-table-td1"><p>申请人数：</p></td>
			<td class="window-table-td2">
				<input id="nb_otherPerson" class="easyui-numberbox"
				name="otherPersonNum" value="${meetingBean.otherPersonNum }"
				style="height:25px;"/>
			</td>
			
			<td class="window-table-td1"><p>申请天数：</p></td>
			<td class="window-table-td2">
				<input id="nb_otherDays" 
				name="otherDayNum" value="${meetingBean.otherDayNum }
				class="easyui-numberbox"
				style="height:25px;"/>
			</td>
		</tr> --%>
		<tr>
			<td class="window-table-td1"><p>申请金额：</p></td>
			<td class="window-table-td2">
				<!-- <p id="p_otherMoney"></p> -->
				<c:if test="${operation!='add'&& operation!='edit'}">
				<p id="p_otherMoney">${meetingBean.otherMoney}元</p>
				</c:if>
				<c:if test="${operation=='add'|| operation=='edit'}">
				<input class="easyui-numberbox" style="height:25px;width:110px" data-options="icons: [{iconCls:'icon-yuan'}],precision:2"
				id="otherMoney" name="otherMoney" value="${meetingBean.otherMoney }" />
				</c:if>
			</td>
			<td class="window-table-td1" ><p style="">总额限制：</p> </td>
			<td class="window-table-td2" style="margin-right:8px">
				<font id="p_allotherMoney"></font>元
			</td>
		</tr>
</table>	

<script type="text/javascript">
$(function(){
	initMeetInput();
});

//计算各项申请金额和总额
function calTotalMoney(){
	//住宿费总额
	var hotelMoney = parseInt($('#hotelMoney').numberbox('getValue'));
	var std1 = parseInt($('#p_hotelStd').html());
	var personNum1 = parseInt($('#nb_hotelPerson').numberbox('getValue'));
	var dayNum1 = parseInt($('#nb_hotelDays').numberbox('getValue'));
	if(!isNaN(std1) && !isNaN(personNum1) && !isNaN(dayNum1)){
		hotelMoney = std1 * personNum1 * dayNum1;
	}
	$('#p_hotelMoney').html(hotelMoney.toFixed(2));
	//伙食费
	var foodMoney = parseInt($('#foodMoney').numberbox('getValue'));
	var std2 = parseInt($('#p_foodStd').html());
	var personNum2 = parseInt($('#nb_foodPerson').numberbox('getValue'));
	var dayNum2 = parseInt($('#nb_foodDays').numberbox('getValue'));
	if(!isNaN(std2) && !isNaN(personNum2) && !isNaN(dayNum2)){
		foodMoney = std2 * personNum2 * dayNum2;
	}
	$('#p_foodMoney').html(foodMoney.toFixed(2));
	//其他费用
	var otherMoney = parseInt($('#otherMoney').numberbox('getValue'));
	var std3 = parseInt($('#p_otherStd').html());
	var dayNum3 = parseInt($('#nb_otherDays').numberbox('getValue'));
	var personNum3 = parseInt($('#nb_otherPerson').numberbox('getValue'));
	if(!isNaN(std3) && !isNaN(personNum3) && !isNaN(dayNum3)){
		otherMoney = std3 * personNum3 * dayNum3;
	}
	$('#p_otherMoney').html(otherMoney.toFixed(2));
	//所有费用合计
	$('#applyAmount').val((hotelMoney + foodMoney + otherMoney).toFixed(2));
	$('#applyAmount_span').html((hotelMoney + foodMoney + otherMoney).toFixed(2) + "[元]");
}
//初始化费用明细的输入框
function initMeetInput(){
	$("#nb_hotelPerson").numberbox({
		onChange: function(newValue, oldValue) {
			calTotalMoney();
		}
	});
	$("#nb_hotelDays").numberbox({
		onChange: function(newValue, oldValue) {
			calTotalMoney();
		}
	});
	$("#nb_foodPerson").numberbox({
		onChange: function(newValue, oldValue) {
			calTotalMoney();
		}
	});
	$("#nb_foodDays").numberbox({
		onChange: function(newValue, oldValue) {
			calTotalMoney();
		}
	});
	$("#nb_otherPerson").numberbox({
		onChange: function(newValue, oldValue) {
			calTotalMoney();
		}
	});
	$("#nb_otherDays").numberbox({
		onChange: function(newValue, oldValue) {
			calTotalMoney();
		}
	});
}
</script>

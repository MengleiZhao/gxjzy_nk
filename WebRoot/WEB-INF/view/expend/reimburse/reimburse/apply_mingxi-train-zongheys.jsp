<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<style>
.under{
	outline: none;
	width:75px;
    border-bottom: 1px solid #000;
    border-top: 0px;
    border-left: 0px;
    border-right: 0px;
    background-color: #F0F5F7;
    text-align:center;
    color:#0000CD;
}
</style>
	<div id="lessons_Id" style="height:30px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">综合预算</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
	</div>

<table class="window-table-readonly-zc-pxAndHy" cellspacing="0" cellpadding="0">
	<tr>
		<td class="window-table-td1" style="width:20%"><span style="color: red"></span>住宿费</td>
		<td class="window-table-td2" style="width:27%">
			<p style=" color:#0000CD;"></p>
		</td>
		<td class="window-table-td1"></td>
		<td class="td2">
		</td>
	</tr>
	<tr>
		<td class="window-table-td1" colspan="2">
			<p>
				<input class="under" readonly="readonly" value="${trainingBean.hotelPersonNum}" type="text">人·天
				<input class="under" readonly="readonly" value="${trainingBean.realityHotelMoney}" type="text">元/人·天
			</p>
		</td>
		<td class="window-table-td1"><p>申请金额：</p></td>
		<td class="td2">
			<input value="${trainingBean.hotelMoney}" class="easyui-numberbox"
		 style="height:25px;width: 205px" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" readonly="readonly">
		</td>
	</tr>
	<tr>
		<td class="window-table-td1" style="width:15%"></td>
		<td class="window-table-td2" style="width:27%">
		</td>
		<td class="window-table-td1"><p>定额标准：</p></td>
		<td class="td2">
			<input class="under" value="${trainingBean.hotelStd}" readonly="readonly" type="text">元
		</td>
	</tr>
</table>		
<div style="height:10px;"></div>
<table class="window-table-readonly-zc-pxAndHy" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1" style="width:20%"><span style="color: red"></span>伙食费</td>
			<td class="window-table-td2" style="width:27%">
				<p style=" color:#0000CD;"></p>
			</td>
			<td class="window-table-td1"></td>
			<td class="td2">
			</td>
		</tr>
		<tr>
			<td class="window-table-td1" colspan="2">
				<p>
					<input class="under" readonly="readonly" value="${trainingBean.foodPersonNum}" type="text">人·天
					<input class="under" readonly="readonly" value="${trainingBean.realityFoodMoney}" type="text">元/人·天
				</p>
			</td>
			
			<td class="window-table-td1"><p>申请金额：</p></td>
			<td class="td2">
				<input class="easyui-numberbox" style="height:25px;width: 205px" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" 
				 value="${trainingBean.foodMoney}" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td class="window-table-td1" style="width:15%"></td>
			<td class="window-table-td2" style="width:27%">
			</td>
			<td class="window-table-td1"><p>定额标准：</p></td>
			<td class="td2">
				<input class="under" value="${trainingBean.foodStd}" readonly="readonly" type="text">元
			</td>
		</tr>
</table>		
<div style="height:10px;"></div>
<table class="window-table-readonly-zc-pxAndHy" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1" style="width:20%"><span style="color: red"></span>资料、场地、交通费</td>
			<td class="window-table-td2" style="width:27%">
				<p style=" color:#0000CD;"></p>
			</td>
			<td class="window-table-td1"></td>
			<td class="td2" hidden="hidden">
				<input class="easyui-numberbox" value="${trainingBean.dataMoney}" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" readonly="readonly" style="height:25px;width: 205px"/>
			</td>
		</tr>
		<tr>
			<td class="window-table-td1" style="padding-left: 30px;" colspan="2"><span style="color: red;"></span>培训资料费</td>
			<td class="window-table-td1"></td>
			<td class="td2"></td>
		</tr>
		<tr>
			<td class="window-table-td1" colspan="2" style="padding-left: 50px;">
				<p>
					<input class="under" readonly="readonly" value="${trainingBean.dataPersonNum}" type="text">人*
					<input class="under" readonly="readonly" value="${trainingBean.realityDataMoney}" type="text">元/人
				</p>
			</td>
		</tr>
		<tr hidden="hidden">
			<td class="window-table-td1" style="padding-left: 30px;" colspan="2"><span style="color: red;"></span>培训场地费</td>
			<td class="window-table-td1"><p>金额：</p></td>
			<td class="td2">
				<input class="easyui-numberbox" value="${trainingBean.spaceMoney}" data-options="icons: [{iconCls:'icon-yuan'}],precision:2"
				readonly="readonly"
				style="height:25px;width: 205px"/>
			</td>
			<td class="window-table-td1"><p>申请金额：</p></td>
			<td class="td2">
				<input class="easyui-numberbox" value="${trainingBean.costThreeTermsMoney}" readonly="readonly" data-options="icons: [{iconCls:'icon-yuan'}],precision:2"
				style="height:25px;width: 205px"/>
			</td>
		</tr>
		<tr hidden="hidden">
			<td class="window-table-td1" style="padding-left: 30px;" colspan="2"><span style="color: red;"></span>交通费</td>
			
			<td class="window-table-td1"><p>金额：</p></td>
			<td class="td2">
				<input class="easyui-numberbox" value="${trainingBean.transportMoney}" data-options="icons: [{iconCls:'icon-yuan'}],precision:2"
				readonly="readonly"
				style="height:25px;width: 205px"/>
			</td>
		</tr>
		<tr>
			<td class="window-table-td1" style="width:15%"></td>
			<td class="window-table-td2" style="width:27%">
			</td>
			<td class="window-table-td1"><p>定额标准：</p></td>
			<td class="td2">
				<input class="under" value="${trainingBean.costThreeTermsStd}" readonly="readonly" type="text">元
			</td>
		</tr>
</table>	
<div style="height:10px;"></div>
<table class="window-table-readonly-zc-pxAndHy" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1" style="width:20%"><span style="color: red;text-align: right;"></span>其他费用</td>
			<td class="window-table-td2" style="width:27%">
				<p style=" color:#0000CD;"></p>
			</td>
			<td class="window-table-td1"><p>申请金额：</p></td>
			<td class="td2">
				<input class="easyui-numberbox" value="${trainingBean.otherMoney}" data-options="icons: [{iconCls:'icon-yuan'}],precision:2"
				readonly="readonly"
				style="height:25px;width: 205px"/>
			</td>
		</tr>
		<tr>
			<td class="window-table-td1" style="width:15%"></td>
			<td class="window-table-td2" style="width:27%">
			</td>
			<td class="window-table-td1"><p>定额标准：</p></td>
			<td class="td2">
				<input class="under" value="${trainingBean.otherStd}" readonly="readonly" type="text">元
			</td>
		</tr>
</table>
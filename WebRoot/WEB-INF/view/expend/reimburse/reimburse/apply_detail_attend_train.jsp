<%@ page language="java" pageEncoding="UTF-8"%>
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
		<!-- 预算信息 -->
		<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 0px;width: 717px">
		<div title="预算信息" data-options="collapsible:false" style="overflow:auto;margin-left: 0px;height: auto">				
			<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:707px;">
				<tr class="trbody">
					<td style="width: 100px;float: left;"><span style="text-align: left;color: red">*</span>支出项目-培训费</td>
					<td colspan="3"  style="padding-right: 5px;">
						<a href="#">
						<input class="easyui-textbox" style="width: 602px;height: 30px;"
						name="indexName" value="${applyBean.indexName}" id="F_fBudgetIndexName"
						data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
						</a>
					</td>
				</tr>
			</table>	
			<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="margin-left: 0px;width:707px;height: 50px;">
					<tr>
						<td class="window-table-td1" style="width: 128px"><p>批复金额：</p></td>
						<td class="window-table-td2"><p id="p_pfAmount">${bean.pfAmount}元</p></td>
						
						<td class="window-table-td1"><p>预算年度：</p></td>
						<td class="window-table-td2"><p id="p_pfDate">${bean.pfDate}</p></td>
					</tr>
					<tr>
						<td class="window-table-td1"><p>可用额度：</p></td>
						<td class="window-table-td2"><p id="p_syAmount">${applyBean.indexAmount}</p></td>
					</tr>
			</table>				
		</div>
		</div>
		
		<!-- 基本信息 -->
		<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 717px">
		<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
			<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
				<tr class="trbody">
					<td class="td1" style="width: 70px;"><span class="style1">*</span> 事项摘要</td>
					<td colspan="3">
							<input class="easyui-textbox" style="width: 635px;height: 30px;margin-left: 10px  " readonly="readonly" value="${applyBean.gName}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
					</td>
				</tr>
				<tr class="trbody" style="line-height: 65px;">
					<td class="td1" style="width: 70px;"><span class="style1">*</span>培训名称</td>
					<td colspan="3">
						<input class="easyui-textbox" style="width: 635px;height: 30px;margin-left: 10px  " readonly="readonly" value="${applyBean.applyName}" name="applyName" required="required" data-options="validType:'length[1,100]'"/>
					</td>
				</tr>
				<tr class="trbody" style="line-height: 65px;">
					<td class="td1" style="width: 70px;"><span class="style1">*</span>培训事由</td>
					<td colspan="3">
						<textarea name="reason" id="reason" class="easyui-textbox" data-options="multiline:true" readonly="readonly"
							oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
							style="margin-left: 10px ;width:635px;height:60px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:15px; margin-bottom:0px;">${applyBean.reason }</textarea>
					</td>
				</tr>
				<tr class="trbody">
					<td class="td1" style="width: 70px;"><span class="style1">*</span> 经办人</td>
					<td class="td2" >
					<input class="easyui-textbox" id="userNames" name="userNames" readonly="readonly" value="${applyBean.userNames}" style="width: 265px;height: 30px;margin-left: 10px " >
					</td>
					<td class="td1" style="width: 70px;"><span class="style1">*</span> 经办部门</td>
					<td class="td2" >
					<input class="easyui-textbox" id="deptName" name="deptName" readonly="readonly" value="${applyBean.deptName}" style="width: 267px;height: 30px;margin-left: 10px " >
					</td>
				</tr>
				<tr class="trbody">
					<td class="td1" style="width: 70px;"><span class="style1">*</span> 出发日期</td>
					<td class="td2">
						<input  class="easyui-datebox" style="width: 265px;; height: 30px;" readonly="readonly" id="travelDateStart" name="travelDateStart"
						data-options="" value="${travelBean.travelDateStart}" required="required" editable="false"/>
					</td>
					<td class="td1" style="width: 70px;"><span class="style1">*</span> 结束日期</td>
					<td class="td2">
						<input class="easyui-datebox" style="width: 267px;; height: 30px;" readonly="readonly" id="travelDateEnd" name="travelDateEnd"
						data-options="" value="${travelBean.travelDateEnd}" required="required" editable="false"/>
					</td>
				</tr>
				<tr class="trbody">
					<td class="td1" style="width: 70px;"><span class="style1">*</span> 省</td>
					<td class="td2">
						<input  class="easyui-combobox" style="width: 265px; height: 30px;" readonly="readonly" id="fProvinceId" name="fProvinceId"
						value="${travelBean.fProvinceId}" required="required" editable="false"data-options="editable:false,
							url:'${base}/apply/getRegion?id=0&selected=${travelBean.fProvinceId}',
							method:'POST',
							valueField:'id',
							textField:'text'"/>
					</td>
					<td class="td1" style="width: 70px;"><span class="style1">*</span> 市</td>
					<td class="td2">
						<input class="easyui-combobox" style="width: 265px; height: 30px;" readonly="readonly" id="fCityId" name="fCityId"
						value="${travelBean.fCityId}" required="required" editable="false" data-options="editable:false,
							method:'POST',
							url:'${base}/apply/getRegion?selected=${travelBean.fCityId}',
							valueField:'id',
							textField:'text',
							"/>
					</td>
				</tr>
				<tr class="trbody">
					<td class="td1" style="width: 70px;"><span class="style1">*</span> 区</td>
					<td class="td2">
						<input  class="easyui-combobox" style="width: 265px; height: 30px;" readonly="readonly" id="fDistrictId" name="fDistrictId"
						value="${travelBean.fDistrictId}" required="required" editable="false" data-options="editable:false,
							url:'${base}/apply/getRegion?selected=${travelBean.fDistrictId}',method:'POST',valueField:'id',textField:'text',
							"/>
					</td>
					<td class="td1" style="width: 70px;"><span class="style1">*</span> 详细地址</td>
					<td class="td2">
						<input class="easyui-textbox" style="width: 267px;; height: 30px;" readonly="readonly" id="travelAreaName" name="travelAreaName"
						value="${travelBean.travelAreaName}" required="required" />
					</td>
				</tr>
				<tr class="trbody">
					<td class="td1" style="width: 70px;"><span class="style1">*</span> 同行人</td>
					<td colspan="3">
						<input class="easyui-textbox" style="width: 635px;height: 30px;margin-left: 10px" id="travelAttendPeop" readonly="readonly" value="${travelBean.travelAttendPeop}" name="travelAttendPeop" required="required"/>
					</td>
				</tr>
				<tr class="trbody">
					<td class="td1" style="width: 70px;"><span class="style1">*</span> 交通工具</td>
					<td colspan="3">
						<input  class="easyui-combobox" style="width: 265px;; height: 30px;" id="vehicle" readonly="readonly" name="vehicle"
						value="${travelBean.vehicle}" required="required" editable="false" />
					</td>
				</tr>
			</table>
		</div>				
		</div>
		<!-- 出差人员名单 -->
		<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px; width: 717px">
			<div title="培训费明细" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
			<div style="overflow:auto;margin-top: 0px;">
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
								<input class="under" autocomplete="off" id="hotelPersonNum" readonly="readonly" name="hotelPersonNum" value="${travelBean.hotelPersonNum}" onkeyup="value=this.value.replace(/\D+/g,'')" type="text">人·天
								<input class="under" autocomplete="off" id="realityHotelMoney" readonly="readonly" name="realityHotelMoney" value="${travelBean.realityHotelMoney}" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"  type="text">元/人·天
							</p>
						</td>
						<td class="window-table-td1"><p>申请金额：</p></td>
						<td class="td2">
							<input id="hotelMoney" name="hotelMoney" value="${travelBean.hotelMoney}" readonly="readonly" class="easyui-numberbox"
						 style="width: 200px;height:25px;" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" <c:if test="${operation!='add'&& operation!='edit'}">readonly="readonly"</c:if>>
						</td>
					</tr>
					<tr>
						<td class="window-table-td1" style="width:15%"></td>
						<td class="window-table-td2" style="width:27%">
						</td>
						<td class="window-table-td1"><p>定额标准：</p></td>
						<td class="td2">
							<input class="under" id="hotelStds" name="hotelStd" value="${travelBean.hotelStd}" readonly="readonly" type="text">元
						</td>
					</tr>
				</table>
			<div style="height:10px;"></div>
				<table class="window-table-readonly-zc-pxAndHy" cellspacing="0" cellpadding="0">
					<tr>
						<td class="window-table-td1" style="width:20%"><span style="color: red"></span>培训学费</td>
						<td class="window-table-td2" style="width:27%">
							<p style=" color:#0000CD;"></p>
						</td>
						<td class="window-table-td1"><p>申请金额：</p></td>
						<td class="td2">
							<input id="trainMoney" name="trainMoney" readonly="readonly" value="${travelBean.trainMoney}" class="easyui-numberbox"
						 style="width: 200px;height:25px;" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" <c:if test="${operation!='add'&& operation!='edit'}">readonly="readonly"</c:if>>
						</td>
					</tr>
				</table>
			<div style="margin-top: 15px;float: right;">合计金额：<span id="hejiAmount">${applyBean.amount}</span>元</div>
			<div style="height:10px;"></div>
			
			</div>
			<div style="margin-top: 20px">
				<div id="applyHotelHintId" style="color: red;">${applyBean.fHotelHint}</div>
				<div id="applyTrafficHintId" style="color: red;">${applyBean.fTrafficHint}</div>
			</div>
			</div>
		</div>
		<!-- 附件信息 -->
		<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 717px">
		<div title="附件信息" data-options="collapsible:false"
			style="overflow:auto;">		
			<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
				<tr>
					<td class="td1" style="width:55px;text-align: left">
						附件:
					</td>
					<td colspan="3" id="tdf">
						<c:forEach items="${attaList}" var="att">
							<div style="margin-top: 5px;">
							<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
							
							</div>
						</c:forEach>
					</td>
				</tr>
			</table>
		</div>
		</div>
						<!-- 审批记录 -->
		<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 717px">
			<div title="审批记录" data-options=" collapsible:false" style="overflow:auto;">
				<!-- <div class="window-title"> 审批记录</div> -->
					<jsp:include page="../../../check_history_reim_apply.jsp" />
			</div>
		</div>	

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<style>
	.input_amonut{
		width: 110px;
		height: 20px;
		border-radius: 4px;
		border: 1px solid #F0F5F7;
	}
	.fp_span{
		width:60px;
		margin-bottom:5px;
		display: inline-block;
	}
	.fp_span1{
		width:60px;
		margin-bottom:5px;
		margin-left:40px;
		display: inline-block;
	}
</style>
<div id="dlgdiv" class="easyui-dialog"
     style="width: 650px; height: 550px; padding: 10px 20px" closed="true"
     buttons="#dlgdiv-buttons">
        <div id="divlarge"></div>
</div>
<form id="form1">
	<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:12.6%">
					<p style=" color:#0000CD;">住宿费</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p id="p_hotelMoney">${travelBean.hotelAmount}元</p>
				</td>
				<td>
				</td>
			</tr>
			<!-- <tr>
				<td class="window-table-td1"><p>备注：</p></td>
				<td class="window-table-td2">
					<p style=" color:#0000CD;"></p>
				</td>
			</tr> -->
			<c:forEach items="${fp1}" var="fp1" varStatus="st1">		
			<tbody id="hotel_${st1.index}" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;发票${st1.index+1}
					<input type="text" id="fp_${st1.index}" name="fileId" hidden="hidden">
					<input type="file" id="image_${st1.index }" onchange="upImageFile(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st1.index}">
					<c:if test="${fp1.fileId!=null&&!empty fp1.fileId}">
					<img style="vertical-align:bottom;width: 200px; height: 153px;" src="${base}/attachment/download/${fp1.fileId}" onclick="yl(this.src)"/>
					</c:if>		
			</tr>
			<tr>
				<td class="td2" colspan="5" id="">
					<div style="width: auto; height:auto;margin-top:5px;margin-left:49px;">
						<p style="margin-bottom:10px;">
							<span class="fp_span">票面金额：</span>
							<input  class="easyui-numberbox" style="width:110px;height:25px" name="amount" id="amount_${st1.index}" value="${fp1.amount}"  onchange="addAmonut(this)" readonly="readonly" data-options="precision:2,icons: [{iconCls:'icon-yuan'}],groupSeparator:','"
							/>
							<span class="fp_span1">专项税额：</span>
							<input  name="tax" id="tax_${st1.index}" class="easyui-numberbox" style="width:110px;height:25px" value="${fp1.tax}" readonly="readonly" data-options="precision:2,icons: [{iconCls:'icon-yuan'}],groupSeparator:','"
							 />
						</p>
						<p style="margin-bottom:10px;">
							<span class="fp_span">开票时间：</span>
							<input  name="time" id="time_${st1.index}" class="easyui-datebox" style="width:110px;height:25px" readonly="readonly"
							value="${fp1.time}" />
						</p>
						<p style="margin-bottom:10px;">
							<span class="fp_span">住宿地点：</span>
							<input name="unit"  id="unit_${st1.index}" class="easyui-textbox" style="width:110px;height:25px" readonly="readonly"
							value="${fp1.unit}" />
						</p>
						<p style="margin-bottom:10px;">
							<span class="fp_span">入住日期：</span>
							<input   name="startTime"  id="startTime_${st1.index}" class="easyui-datebox" style="width:110px;height:25px" onchange="countDays(this)" readonly="readonly"
							value="${fp1.startTime}" />
							<span class="fp_span1">退房日期：</span>
							<input  class="easyui-datebox" style="width:110px;height:25px" name="endTime"  id="endTime_${st1.index}"  onchange="countDays(this)" readonly="readonly"
							value="${fp1.endTime}" />
						</p>
						<p style="margin-bottom:10px;">
							<span class="fp_span">天数：</span>
							<input  class="easyui-textbox" style="width:110px;height:25px" name="days" id="days_${st1.index}"  readonly="readonly"
							value="${fp1.days}" />
							<span class="fp_span1">日均价：</span>
							<input class="easyui-numberbox" style="width:110px;height:25px" name="average" id="average_${st1.index}" readonly="readonly" data-options="precision:2,icons: [{iconCls:'icon-yuan'}],groupSeparator:','"
							value="${fp1.average}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">住宿人员：</span>
							<input  class="easyui-textbox" style="width:328px;height:25px" name="people" id="people_${st1.index}" readonly="readonly"
							value="${fp1.people}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">备注：</span>
							<input  class="easyui-textbox" style="width:328px;height:25px" name="remark" id="remark_${st1.index}" readonly="readonly"
							value="${fp1.remark}" />
						</p>
					<p style="margin-bottom:5px;">
							<span style="width: 85px;display: inline-block;">核验结果：</span>
							<span style="width: 80px;display: inline-block;" id="checkTrue_${st1.index}">
								<c:if test="${fp1.fileId!=null&&!empty fp1.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">
								</c:if>
								<c:if test="${fp1.fileId==null||empty fp1.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">
								</c:if>
							</span>
							<span style="width: 45px;display: inline-block;" id="checkRepet_${st1.index}">
								<c:if test="${fp1.fileId!=null&&!empty fp1.fileId}">
				        			<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/wcf.png">
								</c:if>
							</span>
						</p>
					</div>
				</td>	
			</tr>
			</tbody>
		</c:forEach>	
	</table>
</form>	
	<div style="height:10px"></div>
<form id="form2">		
	<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:12.6%;">
					<p style=" color:#0000CD;">伙食补助费</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p id="p_foodMoney">${travelBean.foodAmount}元</p>
				</td>
				<td>
				</td>
			</tr>
		<c:forEach items="${fp2}" var="fp2" varStatus="st2">
			<tbody id="food_${st2.index}" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;发票${st2.index+1}
					<input type="text" id="fp_${st2.index+a}" name="fileId" hidden="hidden">
					<input type="file" id="image_${st2.index+a}" onchange="upImageFile(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st2.index+a}">
					<c:if test="${fp2.fileId!=null&&!empty fp2.fileId}">
					<img style="vertical-align:bottom;width: 200px; height: 153px;" src="${base}/attachment/download/${fp2.fileId}" onclick="yl(this.src)"/>
					</c:if>		
				</td>	
			</tr>

			<tr>
				<td class="td2" colspan="5" >
					<div style="width: auto; height:auto;margin-top:5px;margin-left:49px;">
						<p style="margin-bottom:5px;">
							<span class="fp_span">票面金额：</span>
							<input  class="easyui-numberbox" style="width:110px;height:25px" name="amount"  id="amount_${st2.index+a}"  onchange="addAmonut(this)" readonly="readonly"
							value="${fp2.amount}" data-options="precision:2,icons: [{iconCls:'icon-yuan'}],groupSeparator:','"/>
							<span class="fp_span1">专项税额：</span>
							<input  class="easyui-numberbox" style="width:110px;height:25px" name="tax" id="tax_${st2.index+a}" readonly="readonly"
							value="${fp2.tax}" data-options="precision:2,icons: [{iconCls:'icon-yuan'}],groupSeparator:','"/>
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">开票时间：</span>
							<input  class="easyui-datebox" style="width:110px;height:25px" name="time" id="time_${st2.index+a}"  readonly="readonly"
							value="${fp2.time}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">备注：</span>
							<input class="easyui-textbox" style="width:328px;height:25px" name="remark" id="remark_${st2.index+a}" readonly="readonly"
							value="${fp2.remark}" />
						</p>
					<p style="margin-bottom:5px;">
							<span style="width: 85px;display: inline-block;">核验结果：</span>
							<span style="width: 80px;display: inline-block;" id="checkTrue_${st2.index}">
								<c:if test="${fp2.fileId!=null&&!empty fp2.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">
								</c:if>
								<c:if test="${fp2.fileId==null||empty fp2.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">
								</c:if>
							</span>
							<span style="width: 45px;display: inline-block;" id="checkRepet_${st2.index}">
								<c:if test="${fp2.fileId!=null&&!empty fp2.fileId}">
				        			<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/wcf.png">
								</c:if>
							</span>
						</p>
					</div>
				</td>	
			</tr>
			</tbody>
		</c:forEach>	
	</table>
</form>	
<div style="height:10px"></div>
<form id="form3">		
	<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:12.6%">
					<p style=" color:#0000CD;" >长途交通费</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p >${travelBean.loongTavelAmount}元</p>
				</td>
				<td>
				</td>
			</tr>
		<c:forEach items="${fp3}" var="fp3" varStatus="st3">
			<tbody id="long_${st3.index}" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;<span id="longFp_${st3.index}">发票${st3.index+1}</span>
					<input type="text" id="fp_${st3.index+a+b}" name="fileId" hidden="hidden"  >
					<input type="file" id="image_${st3.index+a+b}" onchange="upImageFile3(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st3.index+a+b}">
					<c:if test="${fp3.fileId!=null&&!empty fp3.fileId}">
					<img style="vertical-align:bottom;width: 200px; height: 153px;" src="${base}/attachment/download/${fp3.fileId}" onclick="yl(this.src)"/>
					</c:if>		
				</td>	
			</tr>
			<tr>
				<td class="td2" colspan="5" >
					<div style="width: auto; height:auto;margin-top:5px;margin-left:49px;">
						<p style="margin-bottom:5px;">
							<span class="fp_span">票面金额：</span>
							<input class="easyui-numberbox" style="width:110px;height:25px" name="amount"  id="amount_${st3.index+a+b}" onchange="countTravel(this)" readonly="readonly"
							value="${fp3.amount}" data-options="precision:2,icons: [{iconCls:'icon-yuan'}],groupSeparator:','"/>
							<span class="fp_span1">退改等附加金额：</span>
							<input class="easyui-numberbox" style="width:110px;height:25px" name="amount1" id="amount1_${st3.index+a+b}" onchange="countTravel(this)" readonly="readonly"
							value="${fp3.amount1}" data-options="precision:2,icons: [{iconCls:'icon-yuan'}],groupSeparator:','"/>
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">金额小计：</span>
							<input  class="easyui-numberbox" style="width:110px;height:25px" name="amount2"  id="amount2_${st3.index+a+b}" readonly="readonly"
							value="${fp3.amount2}" data-options="precision:2,icons: [{iconCls:'icon-yuan'}],groupSeparator:','"/> 
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">乘坐日期：</span>
							<input  class="easyui-datebox" style="width:110px;height:25px" name="rideTime" id="rideTime_${st3.index+a+b}" readonly="readonly"
							value="${fp3.rideTime}" />
							<span class="fp_span1">交通工具：</span>
							<input  class="easyui-textbox" style="width:110px;height:25px" name="vehicle" id="vehicle_${st3.index+a+b}" readonly="readonly"
							value="${fp3.vehicle}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">坐席类别：</span>
							<input  class="easyui-textbox" style="width:110px;height:25px" name="vehicleLevel"  id="vehicleLevel_${st3.index+a+b}" readonly="readonly"
							value="${fp3.vehicleLevel}" />
							<span class="fp_span1">出发地：</span>
							<input  class="easyui-textbox" style="width:110px;height:25px" name="placeStart" id="placeStart_${st3.index+a+b}"  readonly="readonly"
							value="${fp3.placeStart}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">到达地：</span>
							<input  class="easyui-textbox" style="width:110px;height:25px" name="placeEnd" id="placeEnd_${st3.index+a+b}" readonly="readonly"
							value="${fp3.placeEnd}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">备注：</span>
							<input class="easyui-textbox" style="width:328px;height:25px" name="remark" id="remark_${st3.index+a+b}" readonly="readonly"
							value="${fp3.remark}" />
						</p>
						<p style="margin-bottom:5px;">
							<span style="width: 85px;display: inline-block;">核验结果：</span>
							<span style="width: 80px;display: inline-block;" id="checkTrue_${st3.index}">
								<c:if test="${fp3.fileId!=null&&!empty fp3.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">
								</c:if>
								<c:if test="${fp3.fileId==null||empty fp3.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">
								</c:if>
							</span>
							<span style="width: 45px;display: inline-block;" id="checkRepet_${st3.index}">
								<c:if test="${fp3.fileId!=null&&!empty fp3.fileId}">
				        			<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/wcf.png">
								</c:if>
							</span>
						</p>
					</div>
				</td>	
			</tr>
			</tbody>
		</c:forEach>	
	</table>
</form>	
<div style="height:10px"></div>
<form id="form4">		
	<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:12.6%">
					<p style=" color:#0000CD;">市内交通费</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p>${travelBean.cityTavelAmount}元</p>
				</td>
				<td >
				</td>
			</tr>
			<c:forEach items="${fp4}" var="fp4" varStatus="st4">		
			<tbody id="short_${st4.index}" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;<span id="shortFp_${st4.index}">发票${st4.index+1}</span>
					<input type="text" id="fp_${st4.index+a+b+c}" name="fileId" hidden="hidden" >
					<input type="file" id="image_${st4.index+a+b+c}" onchange="upImageFile4(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st4.index+a+b+c}">
					<c:if test="${fp4.fileId!=null&&!empty fp4.fileId}">
					<img style="vertical-align:bottom;width: 200px; height: 153px;" src="${base}/attachment/download/${fp4.fileId}" onclick="yl(this.src)"/>
					</c:if>		
				</td>	
			</tr>

			<tr>
				<td class="td2" colspan="5" >
					<div style="width: auto; height:auto;margin-top:5px;margin-left:49px;">
						<p style="margin-bottom:5px;">
							<span class="fp_span">票面金额：</span>
							<input  class="easyui-numberbox" style="width:110px;height:25px" name="amount"  id="amount_${st4.index+a+b+c}" onchange="addAmonut(this)" readonly="readonly"
							value="${fp4.amount}" data-options="precision:2,icons: [{iconCls:'icon-yuan'}],groupSeparator:','"/>
							<span class="fp_span1">城市名称：</span>
							<input  class="easyui-textbox" style="width:110px;height:25px" name="unit" id="unit_${st4.index+a+b+c}" readonly="readonly"
							value="${fp4.unit}" />
						</p>
						<p style="margin-bottom:5px;">
						<span class="fp_span">交通工具：</span>
							<input class="easyui-textbox" style="width:110px;height:25px" name="vehicle" id="vehicle_${st4.index+a+b+c}" readonly="readonly"
							value="${fp4.vehicle}" />
							<span class="fp_span1">出行日期：</span>
							<input class="easyui-datebox" style="width:110px;height:25px" name="rideTime" id="rideTime_${st4.index+a+b+c}" readonly="readonly"
							value="${fp4.rideTime}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">出发地：</span>
							<input  class="easyui-textbox" style="width:110px;height:25px" name="placeStart" id="placeStart_${st4.index+a+b+c}" readonly="readonly"
							value="${fp4.placeStart}" />
							<span class="fp_span1">到达地：</span>
							<input  class="easyui-textbox" style="width:110px;height:25px" name="placeEnd" id="placeEnd_${st4.index+a+b+c}" readonly="readonly"
							value="${fp4.placeEnd}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">出行人员：</span>
							<input  class="easyui-textbox" style="width:110px;height:25px" name="people" id="people_${st4.index+a+b+c}" readonly="readonly"
							value="${fp4.people}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">备注：</span>
							<input  class="easyui-textbox" style="width:328px;height:25px" name="remark" id="remark_${st4.index+a+b+c}" readonly="readonly"
							value="${fp4.remark}" />
						</p>
						<p style="margin-bottom:5px;">
							<span style="width: 85px;display: inline-block;">核验结果：</span>
							<span style="width: 80px;display: inline-block;" id="checkTrue_${st4.index}">
								<c:if test="${fp4.fileId!=null&&!empty fp4.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">
								</c:if>
								<c:if test="${fp4.fileId==null||empty fp4.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">
								</c:if>
							</span>
							<span style="width: 45px;display: inline-block;" id="checkRepet_${st4.index}">
								<c:if test="${fp4.fileId!=null&&!empty fp4.fileId}">
				        			<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/wcf.png">
								</c:if>
							</span>
						</p>
					</div>
				</td>	
			</tr>
			</tbody>
		</c:forEach>		
	</table>
</form>	
<div style="height:10px"></div>
<form id="form5">
	<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="margin-bottom:0px;">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:12.6%;">
					<p style=" color:#0000CD;">其他费用</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p id="p_otherMoney">${travelBean.otherAmount}元</p>
				</td>
				<td class="">
				</td>
			</tr>
		<c:forEach items="${fp5}" var="fp5" varStatus="st5">		
			<tbody id="other_${st5.index}" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;发票${st5.index+1}
					<input type="text" id="fp_${st5.index+a+b+c+d}" name="fileId" hidden="hidden">
					<input type="file" id="image_${st5.index+a+b+c+d}" onchange="upImageFile(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st5.index+a+b+c+d}">
					<c:if test="${fp5.fileId!=null&&!empty fp5.fileId}">
					<img style="vertical-align:bottom;width: 200px; height: 153px;" src="${base}/attachment/download/${fp5.fileId}" onclick="yl(this.src)"/>
					</c:if>		
				</td>	
			</tr>

			<tr>
				<td class="td2" colspan="5" >
					<div style="width: auto; height:auto;margin-top:5px;margin-left:49px;">
						<p style="margin-bottom:5px;">
							<span class="fp_span">票面金额：</span>
							<input  class="easyui-numberbox" style="width:110px;height:25px" name="amount" id="amount_${st5.index+a+b+c+d}"  class="a" onchange="addAmonut(this)" readonly="readonly"
							value="${fp5.amount}" data-options="precision:2,icons: [{iconCls:'icon-yuan'}],groupSeparator:','"/>
							<span class="fp_span1">专项税额：</span>
							<input  class="easyui-numberbox" style="width:110px;height:25px" name="tax" id="tax_${st5.index+a+b+c+d}" readonly="readonly"
							value="${fp5.tax}" data-options="precision:2,icons: [{iconCls:'icon-yuan'}],groupSeparator:','"/>
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">开票时间：</span>
							<input  class="easyui-datebox" style="width:110px;height:25px" name="time" id="time_${st5.index+a+b+c+d}"  readonly="readonly"
							value="${fp5.time}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">备注：</span>
							<input  class="easyui-textbox" style="width:328px;height:25px" name="remark" id="remark_${st5.index+a+b+c+d}"  readonly="readonly"
							value="${fp5.remark}" />
						</p>
						<p style="margin-bottom:5px;">
							<span style="width: 85px;display: inline-block;">核验结果：</span>
							<span style="width: 80px;display: inline-block;" id="checkTrue_${st5.index}">
								<c:if test="${fp5.fileId!=null&&!empty fp5.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">
								</c:if>
								<c:if test="${fp5.fileId==null||empty fp5.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">
								</c:if>
							</span>
							<span style="width: 45px;display: inline-block;" id="checkRepet_${st5.index}">
								<c:if test="${fp5.fileId!=null&&!empty fp5.fileId}">
				        			<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/wcf.png">
								</c:if>
							</span>
						</p>
					</div>
				</td>	
			</tr>
		</c:forEach>		
	</table>
</form>	
<script type="text/javascript">
var index =${a+b+c-1};
var a =${a-1};
var b =${b-1};
var c =${c-1};
$(function(){
/* 	for(var i=0; i<=index; i++){
		
	$('#startTime' + i).change(function(){
		countDays(i);
		});
	$('#endTime' + i).change(function(){
		countDays(i);
		});
	} */
});
//计算报销金额
function addAmonut(obj){
	var totalAmount=0;
    var tags = [];
    $(".a").each(function(i,e){
        tags[i]= e.value;
        var num =parseFloat(tags[i]);
        if(!isNaN(num)){
        	totalAmount+=num;
        }
      });
    $('#p_amount').html(fomatMoney(totalAmount,2)+" [元]");
    $('#reimburseAmount').val(totalAmount.toFixed(2));
      countDays(obj);
      cx();
}

function countDays(obj){
	var id=obj.id;
	var j=id.lastIndexOf("\_");
	var i=id.substring(j+1,id.length);
	var time1 =new Date($('#startTime_' + i).val());
	var time2 =new Date($('#endTime_' + i).val());
	var d = (time2 - time1) / 86400000 + 1;
	if (d > 0) {
		var amount =parseFloat($('#amount_' + i).val());
		if(!isNaN(amount)){
			var average =(amount/d).toFixed(2);
			$('#average_' + i).val(average);
		}
	$('#days_' + i).val(d);
	}else{
	$('#days_' + i).val("");
	}
}



function append(){
		index=index+1;
		var addItem = $('#hotel_0').clone(true);
		addItem.attr('id', "hotel_" + (a+1));
		var amount = addItem.find('#amount_'+a ); //根据id查找子元素
		var tax = addItem.find('#tax_'+a );
		var time = addItem.find('#time_'+a );
		var unit = addItem.find('#unit_'+a );
		var startTime = addItem.find('#startTime_'+a );
		var endTime = addItem.find('#endTime_'+a );
		var days = addItem.find('#days_'+a );
		var average = addItem.find('#average_'+a );
		var people = addItem.find('#people_'+a );
		var remark = addItem.find('#remark_'+a );
		var fp = addItem.find('#fp_'+a );
		var image = addItem.find('#image_'+a );
		var zfbimagetd = addItem.find('#zfbimagetd_'+a );
		var click = addItem.find('#click_'+a );
		var sc = addItem.find('#sc_' );
		amount.attr("id", "amount_" + index); //改变克隆子元素节点
		tax.attr("id", "tax_" + index); //改变克隆元素子节点
		time.attr("id", "time_" + index); //改变克隆子元素节点
		unit.attr("id", "unit_" + index); //改变克隆子元素节点
		startTime.attr("id", "startTime_" + index); //改变克隆子元素节点
		endTime.attr("id", "endTime_" + index); //改变克隆子元素节点
		days.attr("id", "days_" + index); //改变克隆子元素节点
		average.attr("id", "average_" + index); //改变克隆子元素节点
		people.attr("id", "people_" + index); //改变克隆子元素节点
		remark.attr("id", "remark_" + index); //改变克隆子元素节点
		fp.attr("id", "fp_" + index); //改变克隆子元素节点
		image.attr("id", "image_" + index); //改变克隆子元素节点
		zfbimagetd.attr("id", "zfbimagetd_" + index); //改变克隆子元素节点
		click.attr("id", "click_" + index); //改变克隆子元素节点
		sc.attr("id", "sc_" + index); //改变克隆子元素节点
		$('#hotel_' + a).after(addItem);
		$('#zfbimagetd_'+index).empty();
		$('#zfbimagetd_'+index).append('<a onclick="clickUpFile(this)" id="click_'+index+'" style="font-weight: bold;" href="#">'+
			'<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#amount_' + index).val("");
		$('#tax_' + index).val("");
		$('#time_' + index).val("");
		$('#unit_' +index).val("");
		$('#startTime_' + index).val("");
		$('#endTime_' + index).val("");
		$('#days_' + index).val("");
		$('#average_' + index).val("");
		$('#people_' + index).val("");
		$('#remark_' + index).val("");
		$('#fp_' + index).val(null);
		a =a+1;
	}
function append1(){
	index=index+1;
	var addItem = $('#food_'+b).clone(true);
	addItem.attr('id', "food_" + (b+1));
	var amount = addItem.find('#amount_'+ (a+b) ); //根据id查找子元素
	var tax = addItem.find('#tax_'+ (a+b) );
	var time = addItem.find('#time_'+ (a+b) );
	var remark = addItem.find('#remark_'+ (a+b) );
	var fp = addItem.find('#fp_'+ (a+b) );
	var image = addItem.find('#image_'+ (a+b) );
	var zfbimagetd = addItem.find('#zfbimagetd_'+ (a+b) );
	var click = addItem.find('#click_'+ (a+b) );
	var sc = addItem.find('#sc_'+ (a+b) );
	amount.attr("id", "amount_" + index); //改变克隆子元素节点
	tax.attr("id", "tax_" + index); //改变克隆元素子节点
	time.attr("id", "time_" + index); //改变克隆子元素节点
	remark.attr("id", "remark_" + index); //改变克隆子元素节点
	fp.attr("id", "fp_" + index); //改变克隆子元素节点
	image.attr("id", "image_" + index); //改变克隆子元素节点
	zfbimagetd.attr("id", "zfbimagetd_" + index); //改变克隆子元素节点
	click.attr("id", "click_" + index); //改变克隆子元素节点
	sc.attr("id", "sc_" + index); //改变克隆子元素节点
	$('#food_' + b).after(addItem);
	$('#zfbimagetd_'+index).empty();
	$('#zfbimagetd_'+index).append('<a onclick="clickUpFile(this)" id="click_'+index+'" style="font-weight: bold;" href="#">'+
		'<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
	$('#amount_' + index).val("");
	$('#tax_' + index).val("");
	$('#time_' + index).val("");
	$('#remark_' + index).val("");
	$('#fp_' + index).val(null);
	b =b+1;
}
function append2(){
	index=index+1;
	var addItem = $('#other_'+c).clone(true);
	addItem.attr('id', "other_" + (c+1));
	var amount = addItem.find('#amount_' + (a+b+c)); //根据id查找子元素
	var tax = addItem.find('#tax_'+ (a+b+c) );
	var time = addItem.find('#time_'+ (a+b+c) );
	var remark = addItem.find('#remark_'+ (a+b+c) );
	var fp = addItem.find('#fp_'+ (a+b+c) );
	var image = addItem.find('#image_' + (a+b+c));
	var zfbimagetd = addItem.find('#zfbimagetd_'+ (a+b+c) );
	var click = addItem.find('#click_'+ (a+b+c) );
	var sc = addItem.find('#sc_'+ (a+b+c) );
	amount.attr("id", "amount_" + index); //改变克隆子元素节点
	tax.attr("id", "tax_" + index); //改变克隆元素子节点
	time.attr("id", "time_" + index); //改变克隆子元素节点
	remark.attr("id", "remark_" + index); //改变克隆子元素节点
	fp.attr("id", "fp_" + index); //改变克隆子元素节点
	image.attr("id", "image_" + index); //改变克隆子元素节点
	zfbimagetd.attr("id", "zfbimagetd_" + index); //改变克隆子元素节点
	click.attr("id", "click_" + index); //改变克隆子元素节点
	sc.attr("id", "sc_" + index); //改变克隆子元素节点
	$('#other_' + c).after(addItem);
	$('#zfbimagetd_'+index).empty();
	$('#zfbimagetd_'+index).append('<a onclick="clickUpFile(this)" id="click_'+index+'" style="font-weight: bold;" href="#">'+
		'<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
	$('#amount_' + index).val("");
	$('#tax_' + index).val("");
	$('#time_' + index).val("");
	$('#remark_' + index).val("");
	$('#fp_' + index).val(null);
	c=c+1;
}
	//将表单序列化成json格式的数据(但不适用于含有控件的表单，例如复选框、多选的select)
	(function($) {
		$.fn.serializeJson = function() {
			var jsonData1 = {};
			var serializeArray = this.serializeArray();
			// 先转换成{"id": ["12","14"], "name": ["aaa","bbb"], "pwd":["pwd1","pwd2"]}这种形式
			$(serializeArray).each(
					function() {
						if (jsonData1[this.name]) {
							if ($.isArray(jsonData1[this.name])) {
								jsonData1[this.name].push(this.value);
							} else {
								jsonData1[this.name] = [ jsonData1[this.name],
										this.value ];
							}
						} else {
							jsonData1[this.name] = this.value;
						}
					});
			// 再转成[{"id": "12", "name": "aaa", "pwd":"pwd1"},{"id": "14", "name": "bb", "pwd":"pwd2"}]的形式
			var vCount = 0;
			// 计算json内部的数组最大长度
			for ( var item in jsonData1) {
				var tmp = $.isArray(jsonData1[item]) ? jsonData1[item].length
						: 1;
				vCount = (tmp > vCount) ? tmp : vCount;
			}

			if (vCount > 1) {
				var jsonData2 = new Array();
				for (var i = 0; i < vCount; i++) {
					var jsonObj = {};
					for ( var item in jsonData1) {
						jsonObj[item] = jsonData1[item][i];
					}
					jsonData2.push(jsonObj);
				}
				return JSON.stringify(jsonData2);
			} else {
				return "[" + JSON.stringify(jsonData1) + "]";
			}
		};
	})(jQuery);
	
	
	function clickUpFile(obj) {
		var id =obj.id;
		 var i=id.lastIndexOf("\_");
	     var j=id.substring(i+1,id.length);
			$('#image_'+ j).click();
	}

	//上传图片文件转化为base64在页面显示
	function upImageFile(obj) {
		var id =obj.id;
		 var i=id.lastIndexOf("\_");
	     var j=id.substring(i+1,id.length);
		if(obj==null||obj=="") {
			return;
		}
		var files = obj.files;
		var formData = new FormData();
		for(var i=0; i< files.length; i++){
			formData.append("imageFile",files[i]);//图片文件
			/* formData.append("imageType",type); //类型1支付宝、2微信 */
			$.ajax({ 
				url: base + '/base64/uploadImage' ,
				type: 'post',  
		        data: formData,
		        cache: false,
		        processData: false,
		        contentType: false,
		        async: false,
		        dataType:'json',
		        success:function(data){
		        	console.log(obj);
			        	upladFp(obj,"hotel","fp02");
			        	$('#zfbimagetd_'+j).empty();
			        	$('#image_'+j).val("");
			        	$('#zfbimagetd_'+j).append('<img style="vertical-align:bottom; width: 100px;height: 73px" src="'+data+'"/><a style="color:red" href="#" id="sc_'+j+'" onclick="deleteImage(this)">    删除</a>');
		        }
			});
		} 
	}

	//删除上传的图片
	function deleteImage(obj) {
		var id =obj.id;
		 var i=id.lastIndexOf("\_");
	     var j=id.substring(i+1,id.length);
			$('#zfbimagetd_'+j).empty();
			$('#zfbimagetd_'+j).append('<a onclick="clickUpFile(this)" id="click_'+j+'" style="font-weight: bold;" href="#">'+
				'<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
			$('#fp_'+j).val(null);
	}
</script>

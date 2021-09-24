<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<style>
		.input_amonut{
		width: 150px;
		height: 20px;
		border-radius: 4px;
		border: 1px solid #F0F5F7;
	}
	.input_amonut1{
		width: 410px;
		height: 20px;
		border-radius: 4px;
		border: 1px solid #F0F5F7;
	}
	.fp_span{
		width:85px;
		margin-bottom:5px;
		display: inline-block;
	}
	.fp_span1{
		width:85px;
		margin-bottom:5px;
		margin-left:15px;
		display: inline-block;
	}
</style>
<div id="dlgdiv" class="easyui-dialog"
     style="width: 800px; height: 550px; padding: 10px 10px" closed="true"
     buttons="#dlgdiv-buttons">
        <div id="divlarge"></div>
</div>
<table>
	<tr>
		<td>1-以下为综合预算</td>
	</tr>
</table>
<form id="form1">
	<table id="tableHotel" class="window-table-readonly" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:26%">
					<p style="color:#0000CD;" >住宿费</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p id="p_hotelStd" >${extraBean.hotelMoney}元</p>
				</td>
				<td>
					<a onclick="append(this)" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/tjfp1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
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
					&nbsp;&nbsp;<span id="hotelFp_${st1.index}">发票${st1.index+1}</span>
					<input type="text" id="fp_${st1.index}" name="fileId" hidden="hidden" value="${fp1.fileId}">
					<input type="file" id="image_${st1.index }" onchange="upImageFile(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st1.index}">
					<c:if test="${fp1.fileId==null||empty fp1.fileId}">
					<a onclick="clickUpFile(this)" id="click_${st1.index}" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>
					<c:if test="${fp1.fileId!=null&&!empty fp1.fileId}">
					<img style="vertical-align:bottom;width: 100px; height: 73px;margin-left:30px" src="${fp1.fileId}" src="${base}/attachment/download/${fp1.fileId}" onclick="yl(this.src)"/><a style="color:red" href="#" onclick="deleteImage(this)" id="sc_${st1.index}">    删除</a>
					</c:if>	
					<c:if test="${st1.index !=0}">
					<a onclick="deleteTrains(this)" style="float: right;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>	
			</tr>
			<tr>
				<td class="td2" colspan="5" id="">
					<div style="width: auto; height:auto;margin-top:5px;margin-left:49px;">
						<p style="margin-bottom:10px;">
							<span class="fp_span">票面金额(元)：</span>
							<input  class="input_amonut a" name="amount" id="amount_${st1.index}" value="${fp1.amount}" 
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" onchange="addAmonut(this)"/>
							<span class="fp_span1">专项税额(元)：</span>
							<input  name="tax" id="tax_${st1.index}" class="input_amonut" value="${fp1.tax}"
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')"/>
						</p>
						<p style="margin-bottom:10px;">
							<span class="fp_span">开票时间：</span>
							<input  name="time" id="time_${st1.index}" type="date" class="input_amonut"
							value="${fn:substring(fp1.time, 0, 10)}" />
						</p>
						<p style="margin-bottom:10px;">
							<span class="fp_span">住宿地点：</span>
							<input name="unit"  id="unit_${st1.index}" class="input_amonut"
							value="${fp1.unit}" />
						</p>
						<p style="margin-bottom:10px;">
							<span class="fp_span">入住日期：</span>
							<input  class="input_amonut" name="startTime"  id="startTime_${st1.index}" type="date" onchange="countDays(this)"
							value="${fp1.startTime}" />
							<span class="fp_span1">退房日期：</span>
							<input  class="input_amonut" name="endTime"  id="endTime_${st1.index}" type="date" onchange="countDays(this)"
							value="${fp1.endTime}" />
						</p>
						<p style="margin-bottom:10px;">
							<span class="fp_span">天数：</span>
							<input  class="input_amonut" name="days" id="days_${st1.index}"  readonly="readonly"
							value="${fp1.days}" />
							<span class="fp_span1">日均价(元)：</span>
							<input  class="input_amonut" name="average" id="average_${st1.index}" readonly="readonly"
							value="${fp1.average}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">住宿人员：</span>
							<a href="#" id="choose_${st1.index}" onclick="chooseUser(this)">
							<input  class="input_amonut1" name="people" id="people_${st1.index}" readonly="readonly" placeholder=" 请选择"
							value="${fp1.people}" />
							</a>
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">备注：</span>
							<input  class="input_amonut1" name="remark" id="remark_${st1.index}" 
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
	<table id="tableFood" class="window-table-readonly" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:26%">
					<p style=" color:#0000CD;">伙食费</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p id="p_foodStd" >${extraBean.foodMoney}元</p>
				</td>
				<td>
					<a onclick="append1(this)" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/tjfp1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>
			</tr>
			
			<c:forEach items="${fp2}" var="fp2" varStatus="st2">
			<tbody id="food_${st2.index}" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;<span id="foodFp_${st2.index}">发票${st2.index+1}</span>
					<input type="text" id="fp_${st2.index+a}" name="fileId" hidden="hidden"  value="${fp2.fileId}">
					<input type="file" id="image_${st2.index+a}" onchange="upImageFile(this)" hidden="hidden" >
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st2.index+a}">
					<c:if test="${fp2.fileId==null||empty fp2.fileId}">
					<a onclick="clickUpFile(this)" id="click_${st2.index+a}" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>
					<c:if test="${fp2.fileId!=null&&!empty fp2.fileId}">
					<img style="vertical-align:bottom;margin-left:30px;width: 100px; height: 73px;" src="${base}/attachment/download/${fp2.fileId}" onclick="yl(this.src)"/><a style="color:red" href="#" onclick="deleteImage(this)" id="sc_${st2.index+a}">    删除</a>
					</c:if>
					<c:if test="${st2.index !=0}">
					<a onclick="deleteTrains(this)" style="float: right;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>		
				</td>	
			</tr>

			<tr>
				<td class="td2" colspan="5" >
					<div style="width: auto; height:auto;margin-top:5px;margin-left:49px;">
						<p style="margin-bottom:5px;">
							<span class="fp_span">票面金额(元)：</span>
							<input  class="input_amonut a" name="amount"  id="amount_${st2.index+a}"  onchange="addAmonut(this)"
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp2.amount}" />
							<span class="fp_span1">专项税额(元)：</span>
							<input  class="input_amonut" name="tax" id="tax_${st2.index+a}" 
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp2.tax}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">开票时间：</span>
							<input  class="input_amonut" name="time" id="time_${st2.index+a}" type="date"
							value="${fn:substring(fp2.time, 0, 10)}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">备注：</span>
							<input class="input_amonut1" name="remark" id="remark_${st2.index+a}" 
							value="${fp2.remark}" />
						</p>
						<p style="margin-bottom:5px;">
							<span style="width: 85px;display: inline-block;">核验结果：</span>
							<span style="width: 80px;display: inline-block;" id="checkTrue_${st2.index+a}">
								<c:if test="${fp2.fileId!=null&&!empty fp2.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">
								</c:if>
								<c:if test="${fp2.fileId==null||empty fp2.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">
								</c:if>
							</span>
							<span style="width: 45px;display: inline-block;" id="checkRepet_${st2.index+a}">
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
	<table id="tableCost1" class="window-table-readonly" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:26%">
					<p style=" color:#0000CD;" >培训资料费</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p >${extraBean.dataMoney}元</p>
				</td>
				<td>
					<a onclick="append2(this)" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/tjfp1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>

			</tr>
		<c:forEach items="${fp3}" var="fp3" varStatus="st3">
			<tbody id="cost1_${st3.index}" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;<span id="cost1Fp_${st3.index}">发票${st3.index+1}</span>
					<input type="text" id="fp_${st3.index+a+b}" name="fileId" hidden="hidden"  value="${fp3.fileId}">
					<input type="file" id="image_${st3.index+a+b}" onchange="upImageFile(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st3.index+a+b}">
					<c:if test="${fp3.fileId==null||empty fp3.fileId}">
					<a onclick="clickUpFile(this)" id="click_${st3.index+a+b}" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>
					<c:if test="${fp3.fileId!=null&&!empty fp3.fileId}">
					<img style="vertical-align:bottom;margin-left:30px;width: 100px; height: 73px;" src="${base}/attachment/download/${fp3.fileId}" onclick="yl(this.src)"/><a style="color:red" href="#" onclick="deleteImage(this)" id="sc_${st3.index+a+b}">    删除</a>
					</c:if>	
					<c:if test="${st3.index !=0}">
					<a onclick="deleteTrains(this)" style="float: right;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>	
				</td>	
			</tr>
			<tr>
				<td class="td2" colspan="5" >
					<div style="width: auto; height:auto;margin-top:5px;margin-left:49px;"">
						<p style="margin-bottom:5px;">
							<span class="fp_span">票面金额(元)：</span>
							<input  class="input_amonut a" name="amount"  id="amount_${st3.index+a+b}" onchange="addAmonut(this)"
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp3.amount}" />
							<span class="fp_span1">专项税额(元)：</span>
							<input  class="input_amonut " name="tax" id="tax_${st3.index+a+b}" 
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp3.tax}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">开票时间：</span>
							<input  class="input_amonut" name="time" id="time_${st3.index+a+b}" type="date"
							value="${fn:substring(fp3.time, 0, 10)}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">备注：</span>
							<input  class="input_amonut1" name="remark" id="remark_${st3.index+a+b}" 
							value="${fp3.remark}" />
						</p>
						<p style="margin-bottom:5px;">
							<span style="width: 85px;display: inline-block;">核验结果：</span>
							<span style="width: 80px;display: inline-block;" id="checkTrue_${st3.index+a+b}">
								<c:if test="${fp3.fileId!=null&&!empty fp3.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">
								</c:if>
								<c:if test="${fp3.fileId==null||empty fp3.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">
								</c:if>
							</span>
							<span style="width: 45px;display: inline-block;" id="checkRepet_${st3.index+a+b}">
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
	<table id="tableCost2" class="window-table-readonly" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:26%">
					<p style=" color:#0000CD;">培训场地费</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p>${extraBean.spaceMoney}元</p>
				</td>
				<td >
					<a onclick="append3(this)" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/tjfp1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>
			</tr>
			<c:forEach items="${fp4}" var="fp4" varStatus="st4">		
			<tbody id="cost2_${st4.index}" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;<span id="cost2Fp_${st4.index}">发票${st4.index+1}</span>
					<input type="text" id="fp_${st4.index+a+b+c}" name="fileId" hidden="hidden" value="${fp4.fileId}">
					<input type="file" id="image_${st4.index+a+b+c}" onchange="upImageFile(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st4.index+a+b+c}">
					<c:if test="${fp4.fileId==null||empty fp4.fileId}">
					<a onclick="clickUpFile(this)" id="click_${st4.index+a+b+c}" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>
					<c:if test="${fp4.fileId!=null&&!empty fp4.fileId}">
					<img style="vertical-align:bottom;margin-left:30px;width: 100px; height: 73px;" src="${base}/attachment/download/${fp4.fileId}" onclick="yl(this.src)"/><a style="color:red" href="#" onclick="deleteImage(this)" id="sc_${st4.index+a+b+c}">    删除</a>
					</c:if>	
					<c:if test="${st4.index !=0}">
					<a onclick="deleteTrains(this)" style="float: right;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>	
				</td>	
			</tr>

			<tr>
				<td class="td2" colspan="5" >
					<div style="width: auto; height:auto;margin-top:5px;margin-left:49px;">
						<p style="margin-bottom:5px;">
							<span class="fp_span">票面金额(元)：</span>
							<input  class="input_amonut a" name="amount"  id="amount_${st4.index+a+b+c}" onchange="addAmonut(this)"
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp4.amount}" />
							<span class="fp_span1">专项税额(元)</span>
							<input  class="input_amonut" name="tax" id="tax_${st4.index+a+b+c}" 
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp4.tax}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">开票时间：</span>
							<input  class="input_amonut" name="time" id="time_${st4.index+a+b+c}" type="date"
							value="${fn:substring(fp4.time, 0, 10)}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">备注：</span>
							<input  class="input_amonut1" name="remark" id="remark_${st4.index+a+b+c}" 
							value="${fp4.remark}" />
						</p>
						<p style="margin-bottom:5px;">
							<span style="width: 85px;display: inline-block;">核验结果：</span>
							<span style="width: 80px;display: inline-block;" id="checkTrue_${st4.index+a+b+c}">
								<c:if test="${fp4.fileId!=null&&!empty fp4.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">
								</c:if>
								<c:if test="${fp4.fileId==null||empty fp4.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">
								</c:if>
							</span>
							<span style="width: 45px;display: inline-block;" id="checkRepet_${st4.index+a+b+c}">
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
	<table id="tableCost3" class="window-table-readonly" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:26%">
					<p style=" color:#0000CD;">交通费</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p>${extraBean.transportMoney}元</p>
				</td>
				<td>
					<a onclick="append4(this)" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/tjfp1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>
			</tr>
		<c:forEach items="${fp5}" var="fp5" varStatus="st5">		
			<tbody id="cost3_${st5.index}" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;<span id="cost3Fp_${st5.index}">发票${st5.index+1}</span>
					<input type="text" id="fp_${st5.index+a+b+c+d}" name="fileId" hidden="hidden"  value="${fp5.fileId}">
					<input type="file" id="image_${st5.index+a+b+c+d}" onchange="upImageFile(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st5.index+a+b+c+d}">
					<c:if test="${fp5.fileId==null||empty fp5.fileId}">
					<a onclick="clickUpFile(this)" id="click_${st5.index+a+b+c+d}" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>
					<c:if test="${fp5.fileId!=null&&!empty fp5.fileId}">
					<img style="vertical-align:bottom;margin-left:30px;width: 100px; height: 73px;" src="${base}/attachment/download/${fp5.fileId}" onclick="yl(this.src)"/><a style="color:red" href="#" onclick="deleteImage(this)"  id="sc_${st5.index+a+b+c+d}">    删除</a>
					</c:if>	
					<c:if test="${st5.index !=0}">
					<a onclick="deleteTrains(this)" style="float: right;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>	
				</td>	
			</tr>

			<tr>
				<td class="td2" colspan="5" >
					<div style="width: auto; height:auto;margin-top:5px;margin-left:49px;">
						<p style="margin-bottom:5px;">
							<span class="fp_span">票面金额(元)：</span>
							<input  class="input_amonut a" name="amount" id="amount_${st5.index+a+b+c+d}" onchange="addAmonut(this)"
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp5.amount}" />
							<span class="fp_span1">专项税额(元)：</span>
							<input  class="input_amonut" name="tax" id="tax_${st5.index+a+b+c+d}" 
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp5.tax}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">开票时间：</span>
							<input  class="input_amonut" name="time" id="time_${st5.index+a+b+c+d}" type="date"
							value="${fn:substring(fp5.time, 0, 10)}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">备注：</span>
							<input  class="input_amonut1" name="remark" id="remark_${st5.index+a+b+c+d}" 
							value="${fp5.remark}" />
						</p>
						<p style="margin-bottom:5px;">
							<span style="width: 85px;display: inline-block;">核验结果：</span>
							<span style="width: 80px;display: inline-block;" id="checkTrue_${st5.index+a+b+c+d}">
								<c:if test="${fp5.fileId!=null&&!empty fp5.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">
								</c:if>
								<c:if test="${fp5.fileId==null||empty fp5.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">
								</c:if>
							</span>
							<span style="width: 45px;display: inline-block;" id="checkRepet_${st5.index+a+b+c+d}">
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
	<div style="height:10px"></div>
<form id="form6">
	<table id="tableCost4" class="window-table-readonly" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:26%">
					<p style=" color:#0000CD;">其他费用</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p>${extraBean.otherMoney}元</p>
				</td>
				<td>
					<a onclick="append5(this)" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/tjfp1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>
			</tr>
		<c:forEach items="${fp6}" var="fp6" varStatus="st6">		
			<tbody id="cost4_${st6.index}" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;<span id="cost4Fp_${st6.index}">发票${st6.index+1}</span>
					<input type="text" id="fp_${st6.index+a+b+c+d+e}" name="fileId" hidden="hidden"  value="${fp6.fileId}">
					<input type="file" id="image_${st6.index+a+b+c+d+e}" onchange="upImageFile(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st6.index+a+b+c+d+e}">
					<c:if test="${fp6.fileId==null||empty fp6.fileId}">
					<a onclick="clickUpFile(this)" id="click_${st6.index+a+b+c+d+e}" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>
					<c:if test="${fp6.fileId!=null&&!empty fp6.fileId}">
					<img style="vertical-align:bottom;margin-left:30px;width: 100px; height: 73px;" src="${base}/attachment/download/${fp6.fileId}" onclick="yl(this.src)"/><a style="color:red" href="#" onclick="deleteImage(this)"  id="sc_${st6.index+a+b+c+d+e}">    删除</a>
					</c:if>
					<c:if test="${st6.index !=0}">
					<a onclick="deleteTrains(this)" style="float: right;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>		
				</td>	
			</tr>

			<tr>
				<td class="td2" colspan="5" >
					<div style="width: auto; height:auto;margin-top:5px;margin-left:49px;">
						<p style="margin-bottom:5px;">
							<span class="fp_span">票面金额(元)：</span>
							<input  class="input_amonut a" name="amount" id="amount_${st6.index+a+b+c+d+e}" onchange="addAmonut(this)"
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp6.amount}" />
							<span class="fp_span1">专项税额(元)：</span>
							<input  class="input_amonut" name="tax" id="tax_${st6.index+a+b+c+d+e}" 
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp6.tax}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">开票时间：</span>
							<input  class="input_amonut" name="time" id="time_${st6.index+a+b+c+d+e}" type="date"
							value="${fn:substring(fp6.time, 0, 10)}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">备注：</span>
							<input  class="input_amonut1" name="remark" id="remark_${st6.index+a+b+c+d+e}" 
							value="${fp6.remark}" />
						</p>
						<p style="margin-bottom:5px;">
							<span style="width: 85px;display: inline-block;">核验结果：</span>
							<span style="width: 80px;display: inline-block;" id="checkTrue_${st6.index+a+b+c+d+e}">
								<c:if test="${fp6.fileId!=null&&!empty fp6.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">
								</c:if>
								<c:if test="${fp6.fileId==null||empty fp6.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">
								</c:if>
							</span>
							<span style="width: 45px;display: inline-block;" id="checkRepet_${st6.index+a+b+c+d+e}">
								<c:if test="${fp6.fileId!=null&&!empty fp6.fileId}">
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
<div style="height:10px"></div>
<table>
	<tr>
		<td>2-以下为师资费预算</td>
	</tr>
</table>
<form id="form7">
	<table id="tableCost5" class="window-table-readonly" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:26%">
					<p style=" color:#0000CD;">讲课费（院士、全国知名专家讲师 ）</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p>${extraBean.lessonMoney1}元</p>
				</td>
				<td>
					<a onclick="append6(this)" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/tjfp1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>
			</tr>
		<c:forEach items="${fp7}" var="fp7" varStatus="st7">		
			<tbody id="cost5_${st7.index}" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;<span id="cost5Fp_${st7.index}">发票${st7.index+1}</span>
					<input type="text" id="fp_${st7.index+a+b+c+d+e+f}" name="fileId" hidden="hidden"  value="${fp7.fileId}">
					<input type="file" id="image_${st7.index+a+b+c+d+e+f}" onchange="upImageFile(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st7.index+a+b+c+d+e+f}">
					<c:if test="${fp7.fileId==null||empty fp7.fileId}">
					<a onclick="clickUpFile(this)" id="click_${st7.index+a+b+c+d+e+f}" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>
					<c:if test="${fp7.fileId!=null&&!empty fp7.fileId}">
					<img style="vertical-align:bottom;margin-left:30px;width: 100px; height: 73px;" src="${base}/attachment/download/${fp7.fileId}" onclick="yl(this.src)"/><a style="color:red" href="#" onclick="deleteImage(this)"  id="sc_${st7.index+a+b+c+d+e+f}">    删除</a>
					</c:if>
					<c:if test="${st7.index !=0}">
					<a onclick="deleteTrains(this)" style="float: right;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>		
				</td>	
			</tr>

			<tr>
				<td class="td2" colspan="5" >
					<div style="width: auto; height:auto;margin-top:5px;margin-left:49px;">
						<p style="margin-bottom:5px;">
							<span class="fp_span">票面金额(元)：</span>
							<input  class="input_amonut a" name="amount" id="amount_${st7.index+a+b+c+d+e+f}" onchange="addAmonut(this)"
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp7.amount}" />
							<span class="fp_span1">专项税额(元)：</span>
							<input  class="input_amonut" name="tax" id="tax_${st7.index+a+b+c+d+e+f}" 
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp7.tax}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">开票时间：</span>
							<input  class="input_amonut" name="time" id="time_${st7.index+a+b+c+d+e+f}" type="date"
							value="${fn:substring(fp7.time, 0, 10)}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">备注：</span>
							<input  class="input_amonut1" name="remark" id="remark_${st7.index+a+b+c+d+e+f}" 
							value="${fp7.remark}" />
						</p>
						<p style="margin-bottom:5px;">
							<span style="width: 85px;display: inline-block;">核验结果：</span>
							<span style="width: 80px;display: inline-block;" id="checkTrue_${st7.index+a+b+c+d+e+f}">
								<c:if test="${fp7.fileId!=null&&!empty fp7.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">
								</c:if>
								<c:if test="${fp7.fileId==null||empty fp7.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">
								</c:if>
							</span>
							<span style="width: 45px;display: inline-block;" id="checkRepet_${st7.index+a+b+c+d+e+f}">
								<c:if test="${fp7.fileId!=null&&!empty fp7.fileId}">
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
<div style="height:10px"></div>
<form id="form8">
	<table id="tableCost6" class="window-table-readonly" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:26%">
					<p style=" color:#0000CD;">讲课费（正高级技术职称讲师）</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p>${extraBean.lessonMoney2}元</p>
				</td>
				<td>
					<a onclick="append7(this)" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/tjfp1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>
			</tr>
		<c:forEach items="${fp8}" var="fp8" varStatus="st8">		
			<tbody id="cost6_${st8.index}" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;<span id="cost6Fp_${st8.index}">发票${st8.index+1}</span>
					<input type="text" id="fp_${st8.index+a+b+c+d+e+f+g}" name="fileId" hidden="hidden"  value="${fp8.fileId}">
					<input type="file" id="image_${st8.index+a+b+c+d+e+f+g}" onchange="upImageFile(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st8.index+a+b+c+d+e+f+g}">
					<c:if test="${fp8.fileId==null||empty fp8.fileId}">
					<a onclick="clickUpFile(this)" id="click_${st8.index+a+b+c+d+e+f+g}" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>
					<c:if test="${fp8.fileId!=null&&!empty fp8.fileId}">
					<img style="vertical-align:bottom;margin-left:30px;width: 100px; height: 73px;" src="${base}/attachment/download/${fp8.fileId}" onclick="yl(this.src)"/><a style="color:red" href="#" onclick="deleteImage(this)"  id="sc_${st8.index+a+b+c+d+e+f+g}">    删除</a>
					</c:if>
					<c:if test="${st8.index !=0}">
					<a onclick="deleteTrains(this)" style="float: right;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>		
				</td>	
			</tr>

			<tr>
				<td class="td2" colspan="5" >
					<div style="width: auto; height:auto;margin-top:5px;margin-left:49px;">
						<p style="margin-bottom:5px;">
							<span class="fp_span">票面金额(元)：</span>
							<input  class="input_amonut a" name="amount" id="amount_${st8.index+a+b+c+d+e+f+g}" onchange="addAmonut(this)"
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp8.amount}" />
							<span class="fp_span1">专项税额(元)：</span>
							<input  class="input_amonut" name="tax" id="tax_${st8.index+a+b+c+d+e+f+g}" 
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp8.tax}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">开票时间：</span>
							<input  class="input_amonut" name="time" id="time_${st8.index+a+b+c+d+e+f+g}" type="date"
							value="${fn:substring(fp8.time, 0, 10)}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">备注：</span>
							<input  class="input_amonut1" name="remark" id="remark_${st8.index+a+b+c+d+e+f+g}" 
							value="${fp8.remark}" />
						</p>
						<p style="margin-bottom:5px;">
							<span style="width: 85px;display: inline-block;">核验结果：</span>
							<span style="width: 80px;display: inline-block;" id="checkTrue_${st8.index+a+b+c+d+e+f+g}">
								<c:if test="${fp10.fileId!=null&&!empty fp10.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">
								</c:if>
								<c:if test="${fp10.fileId==null||empty fp10.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">
								</c:if>
							</span>
							<span style="width: 45px;display: inline-block;" id="checkRepet_${st8.index+a+b+c+d+e+f+g}">
								<c:if test="${fp10.fileId!=null&&!empty fp10.fileId}">
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
<div style="height:10px"></div>
<form id="form9">
	<table id="tableCost7" class="window-table-readonly" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:26%">
					<p style=" color:#0000CD;">讲课费（副高级技术职称讲师）</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p>${extraBean.lessonMoney3}元</p>
				</td>
				<td>
					<a onclick="append8(this)" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/tjfp1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>
			</tr>
		<c:forEach items="${fp9}" var="fp9" varStatus="st9">		
			<tbody id="cost7_${st9.index}" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;<span id="cost7Fp_${st9.index}">发票${st9.index+1}</span>
					<input type="text" id="fp_${st9.index+a+b+c+d+e+f+g+x}" name="fileId" hidden="hidden"  value="${fp9.fileId}">
					<input type="file" id="image_${st9.index+a+b+c+d+e+f+g+x}" onchange="upImageFile(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st9.index+a+b+c+d+e+f+g+x}">
					<c:if test="${fp9.fileId==null||empty fp9.fileId}">
					<a onclick="clickUpFile(this)" id="click_${st9.index+a+b+c+d+e+f+g+x}" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>
					<c:if test="${fp9.fileId!=null&&!empty fp9.fileId}">
					<img style="vertical-align:bottom;margin-left:30px;width: 100px; height: 73px;" src="${base}/attachment/download/${fp9.fileId}" onclick="yl(this.src)"/><a style="color:red" href="#" onclick="deleteImage(this)"  id="sc_${st9.index+a+b+c+d+e+f+g+x}">    删除</a>
					</c:if>	
					<c:if test="${st9.index !=0}">
					<a onclick="deleteTrains(this)" style="float: right;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>	
				</td>	
			</tr>

			<tr>
				<td class="td2" colspan="5" >
					<div style="width: auto; height:auto;margin-top:5px;margin-left:49px;">
						<p style="margin-bottom:5px;">
							<span class="fp_span">票面金额(元)：</span>
							<input  class="input_amonut a" name="amount" id="amount_${st9.index+a+b+c+d+e+f+g+x}" onchange="addAmonut(this)"
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp9.amount}" />
							<span class="fp_span1">专项税额(元)：</span>
							<input  class="input_amonut" name="tax" id="tax_${st9.index+a+b+c+d+e+f+g+x}" 
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp9.tax}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">开票时间：</span>
							<input  class="input_amonut" name="time" id="time_${st9.index+a+b+c+d+e+f+g+x}" type="date"
							value="${fn:substring(fp9.time, 0, 10)}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">备注：</span>
							<input  class="input_amonut1" name="remark" id="remark_${st9.index+a+b+c+d+e+f+g+x}" 
							value="${fp9.remark}" />
						</p>
						<p style="margin-bottom:5px;">
							<span style="width: 85px;display: inline-block;">核验结果：</span>
							<span style="width: 80px;display: inline-block;" id="checkTrue_${st9.index+a+b+c+d+e+f+g+x+y}">
								<c:if test="${fp9.fileId!=null&&!empty fp9.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">
								</c:if>
								<c:if test="${fp9.fileId==null||empty fp9.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">
								</c:if>
							</span>
							<span style="width: 45px;display: inline-block;" id="checkRepet_${st9.index+a+b+c+d+e+f+g+x+y}">
								<c:if test="${fp9.fileId!=null&&!empty fp9.fileId}">
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
<div style="height:10px"></div>
<form id="form9">
	<table id="tableCost8" class="window-table-readonly" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:26%">
					<p style=" color:#0000CD;">长途交通费</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p>${extraBean.longTrafficMoney}元</p>
				</td>
				<td>
					<a onclick="append9(this)" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/tjfp1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>
			</tr>
		<c:forEach items="${fp10}" var="fp10" varStatus="st10">		
			<tbody id="cost8_${st10.index}" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;<span id="cost8Fp_${st10.index}">发票${st9.index+1}</span>
					<input type="text" id="fp_${st10.index+a+b+c+d+e+f+g+x+y}" name="fileId" hidden="hidden"  value="${fp10.fileId}">
					<input type="file" id="image_${st10.index+a+b+c+d+e+f+g+x+y}" onchange="upImageFile(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st10.index+a+b+c+d+e+f+g+x+y}">
					<c:if test="${fp10.fileId==null||empty fp10.fileId}">
					<a onclick="clickUpFile(this)" id="click_${st10.index+a+b+c+d+e+f+g+x+y}" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>
					<c:if test="${fp10.fileId!=null&&!empty fp10.fileId}">
					<img style="vertical-align:bottom;margin-left:30px;width: 100px; height: 73px;" src="${base}/attachment/download/${fp10.fileId}" onclick="yl(this.src)"/><a style="color:red" href="#" onclick="deleteImage(this)"  id="sc_${st10.index+a+b+c+d+e+f+g+x+y}">    删除</a>
					</c:if>	
					<c:if test="${st10.index !=0}">
					<a onclick="deleteTrains(this)" style="float: right;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>	
				</td>	
			</tr>

			<tr>
				<td class="td2" colspan="5" >
					<div style="width: auto; height:auto;margin-top:5px;margin-left:49px;">
						<p style="margin-bottom:5px;">
							<span class="fp_span">票面金额(元)：</span>
							<input  class="input_amonut a" name="amount" id="amount_${st10.index+a+b+c+d+e+f+g+x+y}" onchange="addAmonut(this)"
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp10.amount}" />
							<span class="fp_span1">专项税额(元)：</span>
							<input  class="input_amonut" name="tax" id="tax_${st10.index+a+b+c+d+e+f+g+x+y}" 
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp10.tax}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">开票时间：</span>
							<input  class="input_amonut" name="time" id="time_${st10.index+a+b+c+d+e+f+g+x+y}" type="date"
							value="${fn:substring(fp10.time, 0, 10)}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">备注：</span>
							<input  class="input_amonut1" name="remark" id="remark_${st10.index+a+b+c+d+e+f+g+x+y}" 
							value="${fp10.remark}" />
						</p>
						<p style="margin-bottom:5px;">
							<span style="width: 85px;display: inline-block;">核验结果：</span>
							<span style="width: 80px;display: inline-block;" id="checkTrue_${st10.index+a+b+c+d+e+f+g+x+y}">
								<c:if test="${fp10.fileId!=null&&!empty fp10.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">
								</c:if>
								<c:if test="${fp10.fileId==null||empty fp10.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">
								</c:if>
							</span>
							<span style="width: 45px;display: inline-block;" id="checkRepet_${st10.index+a+b+c+d+e+f+g+x+y}">
								<c:if test="${fp10.fileId!=null&&!empty fp10.fileId}">
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

var index =${a+b+c+d+e+f+g+x+y+z-1};
var a =${a-1};
var b =${b-1};
var c =${c-1};
var d =${d-1};
var e =${e-1};
var f =${f-1};
var g =${g-1};
var x =${x-1};
var y =${y-1};
var z =${z-1};
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

function countTravel(obj){
	var id=obj.id;
	var j=id.lastIndexOf("\_");
	var i=id.substring(j+1,id.length);
	var num =0;
	var num1 =parseFloat($('#amount_' + i).val());
	var num2 =parseFloat($('#amount1_' + i).val());
	if (!isNaN(num1)) {
		num=num+num1;
		}
	if (!isNaN(num2)) {
		num=num+num2;
		}
	$('#amount2_' + i).val(num);
	addAmonut(obj);
	}

	function append(obj) {
		index = index + 1;
		var addItem = $('#hotel_0').clone(true);
		addItem.attr('id', "hotel_" + (a + 1));
		var amount = addItem.find('#amount_0'); //根据id查找子元素
		var tax = addItem.find('#tax_0');
		var time = addItem.find('#time_0');
		var unit = addItem.find('#unit_0');
		var startTime = addItem.find('#startTime_0');
		var endTime = addItem.find('#endTime_0');
		var days = addItem.find('#days_0');
		var average = addItem.find('#average_0');
		var people = addItem.find('#people_0');
		var remark = addItem.find('#remark_0');
		var fp = addItem.find('#fp_0');
		var image = addItem.find('#image_0');
		var zfbimagetd = addItem.find('#zfbimagetd_0');
		var click = addItem.find('#click_0');
		var sc = addItem.find('#sc_0');
		var checkTrue = addItem.find('#checkTrue_0' );
		var checkRepet = addItem.find('#checkRepet_0' );
		var hotelFp = addItem.find('#hotelFp_0' );
		var choose = addItem.find('#choose_0' );
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
		checkTrue.attr("id", "checkTrue_" + index); //改变克隆子元素节点
		checkRepet.attr("id", "checkRepet_" + index); //改变克隆子元素节点
		hotelFp.attr("id", "hotelFp_" + (a+1)); //改变克隆子元素节点
		choose.attr("id", "choose_" + index); //改变克隆子元素节点
		$('#hotel_0').after(addItem);
		$('#zfbimagetd_' + index).empty();
		$('#zfbimagetd_' + index)
				.append(
						'<a onclick="clickUpFile(this)" id="click_'
								+ index
								+ '" style="font-weight: bold;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
								+'<a onclick="deleteTrains(this)" style="float: right;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#amount_' + index).val("");
		$('#tax_' + index).val("");
		$('#time_' + index).val("");
		$('#unit_' + index).val("");
		$('#startTime_' + index).val("");
		$('#endTime_' + index).val("");
		$('#days_' + index).val("");
		$('#average_' + index).val("");
		$('#people_' + index).val("");
		$('#remark_' + index).val("");
		$('#fp_' + index).val(null);
		$('#checkTrue_' + index).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">');
		$('#checkRepet_' + index).html("");
		
		var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
		for (var i = 1; i < fromNum.length; i++) {
			var s = fromNum[i].children[0].children[0].children[0].id;
			$('#' + s).html("发票"+i);
			}
		a = a + 1;
	}
	function append1(obj) {
		var k=${a};
		index = index + 1;
		var addItem = $('#food_0').clone(true);
		addItem.attr('id', "food_" + (b + 1));
		var amount = addItem.find('#amount_'+k); //根据id查找子元素
		var tax = addItem.find('#tax_'+k);
		var time = addItem.find('#time_'+k);
		var remark = addItem.find('#remark_'+k);
		var fp = addItem.find('#fp_'+x);
		var image = addItem.find('#image_'+k);
		var zfbimagetd = addItem.find('#zfbimagetd_'+k);
		var click = addItem.find('#click_'+k);
		var sc = addItem.find('#sc_'+k);
		var checkTrue = addItem.find('#checkTrue_'+k);
		var checkRepet = addItem.find('#checkRepet_'+k );
		var foodFp = addItem.find('#foodFp_0' );
		amount.attr("id", "amount_" + index); //改变克隆子元素节点
		tax.attr("id", "tax_" + index); //改变克隆元素子节点
		time.attr("id", "time_" + index); //改变克隆子元素节点
		remark.attr("id", "remark_" + index); //改变克隆子元素节点
		fp.attr("id", "fp_" + index); //改变克隆子元素节点
		image.attr("id", "image_" + index); //改变克隆子元素节点
		zfbimagetd.attr("id", "zfbimagetd_" + index); //改变克隆子元素节点
		click.attr("id", "click_" + index); //改变克隆子元素节点
		sc.attr("id", "sc_" + index); //改变克隆子元素节点
		foodFp.attr("id", "foodFp_" + (b+1)); //改变克隆子元素节点
		checkTrue.attr("id", "checkTrue_" + index); //改变克隆子元素节点
		checkRepet.attr("id", "checkRepet_" + index); //改变克隆子元素节点
		$('#food_0').after(addItem);
		$('#zfbimagetd_' + index).empty();
		$('#zfbimagetd_' + index)
				.append(
						'<a onclick="clickUpFile(this)" id="click_'
								+ index
								+ '" style="font-weight: bold;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
								+'<a onclick="deleteTrains(this)" style="float: right;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#amount_' + index).val("");
		$('#tax_' + index).val("");
		$('#time_' + index).val("");
		$('#remark_' + index).val("");
		$('#fp_' + index).val(null);
		$('#checkTrue_' + index).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">');
		$('#checkRepet_' + index).html("");
		
		var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
		for (var i = 1; i < fromNum.length; i++) {
			var s = fromNum[i].children[0].children[0].children[0].id;
			$('#' + s).html("发票"+i);
			}
		b = b + 1;
	}
	function append2(obj) {
		var l=${a+b};
		index = index + 1;
		var addItem = $('#cost1_0').clone(true);
		addItem.attr('id', "cost1_" + (c + 1));
		var amount = addItem.find('#amount_'+l); //根据id查找子元素
		var tax = addItem.find('#tax_'+l);
		var time = addItem.find('#time_'+l);
		var remark = addItem.find('#remark_'+l);
		var fp = addItem.find('#fp_'+l);
		var image = addItem.find('#image_'+l);
		var zfbimagetd = addItem.find('#zfbimagetd_'+l);
		var click = addItem.find('#click_'+l);
		var sc = addItem.find('#sc_'+l);
		var checkTrue = addItem.find('#checkTrue_'+l );
		var checkRepet = addItem.find('#checkRepet_'+l );
		var otherFp = addItem.find('#cost1Fp_0' );
		amount.attr("id", "amount_" + index); //改变克隆子元素节点
		tax.attr("id", "tax_" + index); //改变克隆元素子节点
		time.attr("id", "time_" + index); //改变克隆子元素节点
		remark.attr("id", "remark_" + index); //改变克隆子元素节点
		fp.attr("id", "fp_" + index); //改变克隆子元素节点
		image.attr("id", "image_" + index); //改变克隆子元素节点
		zfbimagetd.attr("id", "zfbimagetd_" + index); //改变克隆子元素节点
		click.attr("id", "click_" + index); //改变克隆子元素节点
		sc.attr("id", "sc_" + index); //改变克隆子元素节点
		checkTrue.attr("id", "checkTrue_" + index); //改变克隆子元素节点
		checkRepet.attr("id", "checkRepet_" + index); //改变克隆子元素节点
		otherFp.attr("id", "cost1Fp_" + (c+1)); //改变克隆子元素节点
		$('#cost1_0').after(addItem);
		$('#zfbimagetd_' + index).empty();
		$('#zfbimagetd_' + index)
				.append(
						'<a onclick="clickUpFile(this)" id="click_'
								+ index
								+ '" style="font-weight: bold;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#amount_' + index).val("");
		$('#tax_' + index).val("");
		$('#time_' + index).val("");
		$('#remark_' + index).val("");
		$('#fp_' + index).val(null);
		$('#checkTrue_' + index).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">');
		$('#checkRepet_' + index).html("");
		
		var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
		for (var i = 1; i < fromNum.length; i++) {
			var s = fromNum[i].children[0].children[0].children[0].id;
			$('#' + s).html("发票"+i);
			}
		c = c + 1;
	}
	function append3(obj) {
		var m=${a+b+c};
		index = index + 1;
		var addItem = $('#cost2_0').clone(true);
		addItem.attr('id', "cost2_" + (d + 1));
		var amount = addItem.find('#amount_'+m); //根据id查找子元素
		var tax = addItem.find('#tax_'+m);
		var time = addItem.find('#time_'+m);
		var remark = addItem.find('#remark_'+m);
		var fp = addItem.find('#fp_'+m);
		var image = addItem.find('#image_'+m);
		var zfbimagetd = addItem.find('#zfbimagetd_'+m);
		var click = addItem.find('#click_'+m);
		var sc = addItem.find('#sc_'+m);
		var checkTrue = addItem.find('#checkTrue_'+m );
		var checkRepet = addItem.find('#checkRepet_'+m );
		var otherFp = addItem.find('#cost2Fp_0' );
		amount.attr("id", "amount_" + index); //改变克隆子元素节点
		tax.attr("id", "tax_" + index); //改变克隆元素子节点
		time.attr("id", "time_" + index); //改变克隆子元素节点
		remark.attr("id", "remark_" + index); //改变克隆子元素节点
		fp.attr("id", "fp_" + index); //改变克隆子元素节点
		image.attr("id", "image_" + index); //改变克隆子元素节点
		zfbimagetd.attr("id", "zfbimagetd_" + index); //改变克隆子元素节点
		click.attr("id", "click_" + index); //改变克隆子元素节点
		sc.attr("id", "sc_" + index); //改变克隆子元素节点
		checkTrue.attr("id", "checkTrue_" + index); //改变克隆子元素节点
		checkRepet.attr("id", "checkRepet_" + index); //改变克隆子元素节点
		otherFp.attr("id", "cost2Fp_" + (d+1)); //改变克隆子元素节点
		$('#cost2_0').after(addItem);
		$('#zfbimagetd_' + index).empty();
		$('#zfbimagetd_' + index)
				.append(
						'<a onclick="clickUpFile(this)" id="click_'
								+ index
								+ '" style="font-weight: bold;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
								+'<a onclick="deleteTrains(this)" style="float: right;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#amount_' + index).val("");
		$('#tax_' + index).val("");
		$('#time_' + index).val("");
		$('#remark_' + index).val("");
		$('#fp_' + index).val(null);
		$('#checkTrue_' + index).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">');
		$('#checkRepet_' + index).html("");
		
		var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
		for (var i = 1; i < fromNum.length; i++) {
			var s = fromNum[i].children[0].children[0].children[0].id;
			$('#' + s).html("发票"+i);
			}
		d = d + 1;
	}
	function append4(obj) {
		var n=${a+b+c+d};
		index = index + 1;
		var addItem = $('#cost3_0').clone(true);
		addItem.attr('id', "cost3_" + (e + 1));
		var amount = addItem.find('#amount_'+n); //根据id查找子元素
		var tax = addItem.find('#tax_'+n);
		var time = addItem.find('#time_'+n);
		var remark = addItem.find('#remark_'+n);
		var fp = addItem.find('#fp_'+n);
		var image = addItem.find('#image_'+n);
		var zfbimagetd = addItem.find('#zfbimagetd_'+n);
		var click = addItem.find('#click_'+n);
		var sc = addItem.find('#sc_'+n);
		var checkTrue = addItem.find('#checkTrue_'+n );
		var checkRepet = addItem.find('#checkRepet_'+n );
		var otherFp = addItem.find('#cost3Fp_0' );
		amount.attr("id", "amount_" + index); //改变克隆子元素节点
		tax.attr("id", "tax_" + index); //改变克隆元素子节点
		time.attr("id", "time_" + index); //改变克隆子元素节点
		remark.attr("id", "remark_" + index); //改变克隆子元素节点
		fp.attr("id", "fp_" + index); //改变克隆子元素节点
		image.attr("id", "image_" + index); //改变克隆子元素节点
		zfbimagetd.attr("id", "zfbimagetd_" + index); //改变克隆子元素节点
		click.attr("id", "click_" + index); //改变克隆子元素节点
		sc.attr("id", "sc_" + index); //改变克隆子元素节点
		checkTrue.attr("id", "checkTrue_" + index); //改变克隆子元素节点
		checkRepet.attr("id", "checkRepet_" + index); //改变克隆子元素节点
		otherFp.attr("id", "cost3Fp_" + (e+1)); //改变克隆子元素节点
		$('#cost3_0').after(addItem);
		$('#zfbimagetd_' + index).empty();
		$('#zfbimagetd_' + index)
				.append(
						'<a onclick="clickUpFile(this)" id="click_'
								+ index
								+ '" style="font-weight: bold;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
								+'<a onclick="deleteTrains(this)" style="float: right;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#amount_' + index).val("");
		$('#tax_' + index).val("");
		$('#time_' + index).val("");
		$('#remark_' + index).val("");
		$('#fp_' + index).val(null);
		$('#checkTrue_' + index).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">');
		$('#checkRepet_' + index).html("");
		
		var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
		for (var i = 1; i < fromNum.length; i++) {
			var s = fromNum[i].children[0].children[0].children[0].id;
			$('#' + s).html("发票"+i);
			}
		e = e + 1;
	}
	
	function append5(obj) {
		var o=${a+b+c+d+e};
		index = index + 1;
		var addItem = $('#cost4_0').clone(true);
		addItem.attr('id', "cost4_" + (f + 1));
		var amount = addItem.find('#amount_'+o); //根据id查找子元素
		var tax = addItem.find('#tax_'+o);
		var time = addItem.find('#time_'+o);
		var remark = addItem.find('#remark_'+o);
		var fp = addItem.find('#fp_'+o);
		var image = addItem.find('#image_'+o);
		var zfbimagetd = addItem.find('#zfbimagetd_'+o);
		var click = addItem.find('#click_'+o);
		var sc = addItem.find('#sc_'+o);
		var checkTrue = addItem.find('#checkTrue_'+o );
		var checkRepet = addItem.find('#checkRepet_'+o );
		var otherFp = addItem.find('#cost4Fp_0' );
		amount.attr("id", "amount_" + index); //改变克隆子元素节点
		tax.attr("id", "tax_" + index); //改变克隆元素子节点
		time.attr("id", "time_" + index); //改变克隆子元素节点
		remark.attr("id", "remark_" + index); //改变克隆子元素节点
		fp.attr("id", "fp_" + index); //改变克隆子元素节点
		image.attr("id", "image_" + index); //改变克隆子元素节点
		zfbimagetd.attr("id", "zfbimagetd_" + index); //改变克隆子元素节点
		click.attr("id", "click_" + index); //改变克隆子元素节点
		sc.attr("id", "sc_" + index); //改变克隆子元素节点
		checkTrue.attr("id", "checkTrue_" + index); //改变克隆子元素节点
		checkRepet.attr("id", "checkRepet_" + index); //改变克隆子元素节点
		otherFp.attr("id", "cost4Fp_" + (f+1)); //改变克隆子元素节点
		$('#cost4_0').after(addItem);
		$('#zfbimagetd_' + index).empty();
		$('#zfbimagetd_' + index)
				.append(
						'<a onclick="clickUpFile(this)" id="click_'
								+ index
								+ '" style="font-weight: bold;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
								+'<a onclick="deleteTrains(this)" style="float: right;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#amount_' + index).val("");
		$('#tax_' + index).val("");
		$('#time_' + index).val("");
		$('#remark_' + index).val("");
		$('#fp_' + index).val(null);
		$('#checkTrue_' + index).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">');
		$('#checkRepet_' + index).html("");
		
		var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
		for (var i = 1; i < fromNum.length; i++) {
			var s = fromNum[i].children[0].children[0].children[0].id;
			$('#' + s).html("发票"+i);
			}
		f = f + 1;
	}
	
	function append6(obj) {
		var p=${a+b+c+d+e+f};
		index = index + 1;
		var addItem = $('#cost5_0').clone(true);
		addItem.attr('id', "cost5_" + (g + 1));
		var amount = addItem.find('#amount_'+p); //根据id查找子元素
		var tax = addItem.find('#tax_'+p);
		var time = addItem.find('#time_'+p);
		var remark = addItem.find('#remark_'+p);
		var fp = addItem.find('#fp_'+p);
		var image = addItem.find('#image_'+p);
		var zfbimagetd = addItem.find('#zfbimagetd_'+p);
		var click = addItem.find('#click_'+p);
		var sc = addItem.find('#sc_'+p);
		var checkTrue = addItem.find('#checkTrue_'+p );
		var checkRepet = addItem.find('#checkRepet_'+p );
		var otherFp = addItem.find('#cost5Fp_0' );
		amount.attr("id", "amount_" + index); //改变克隆子元素节点
		tax.attr("id", "tax_" + index); //改变克隆元素子节点
		time.attr("id", "time_" + index); //改变克隆子元素节点
		remark.attr("id", "remark_" + index); //改变克隆子元素节点
		fp.attr("id", "fp_" + index); //改变克隆子元素节点
		image.attr("id", "image_" + index); //改变克隆子元素节点
		zfbimagetd.attr("id", "zfbimagetd_" + index); //改变克隆子元素节点
		click.attr("id", "click_" + index); //改变克隆子元素节点
		sc.attr("id", "sc_" + index); //改变克隆子元素节点
		checkTrue.attr("id", "checkTrue_" + index); //改变克隆子元素节点
		checkRepet.attr("id", "checkRepet_" + index); //改变克隆子元素节点
		otherFp.attr("id", "cost5Fp_" + (g+1)); //改变克隆子元素节点
		$('#cost5_0').after(addItem);
		$('#zfbimagetd_' + index).empty();
		$('#zfbimagetd_' + index)
				.append(
						'<a onclick="clickUpFile(this)" id="click_'
								+ index
								+ '" style="font-weight: bold;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
								+'<a onclick="deleteTrains(this)" style="float: right;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#amount_' + index).val("");
		$('#tax_' + index).val("");
		$('#time_' + index).val("");
		$('#remark_' + index).val("");
		$('#fp_' + index).val(null);
		$('#checkTrue_' + index).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">');
		$('#checkRepet_' + index).html("");
		
		var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
		for (var i = 1; i < fromNum.length; i++) {
			var s = fromNum[i].children[0].children[0].children[0].id;
			$('#' + s).html("发票"+i);
			}
		g = g + 1;
	}
	
	function append7(obj) {
		var q=${a+b+c+d+e+f+g};
		index = index + 1;
		var addItem = $('#cost6_0').clone(true);
		addItem.attr('id', "cost6_" + (x + 1));
		var amount = addItem.find('#amount_'+q); //根据id查找子元素
		var tax = addItem.find('#tax_'+q);
		var time = addItem.find('#time_'+q);
		var remark = addItem.find('#remark_'+q);
		var fp = addItem.find('#fp_'+q);
		var image = addItem.find('#image_'+q);
		var zfbimagetd = addItem.find('#zfbimagetd_'+q);
		var click = addItem.find('#click_'+q);
		var sc = addItem.find('#sc_'+q);
		var checkTrue = addItem.find('#checkTrue_'+q );
		var checkRepet = addItem.find('#checkRepet_'+q );
		var otherFp = addItem.find('#cost6Fp_0' );
		amount.attr("id", "amount_" + index); //改变克隆子元素节点
		tax.attr("id", "tax_" + index); //改变克隆元素子节点
		time.attr("id", "time_" + index); //改变克隆子元素节点
		remark.attr("id", "remark_" + index); //改变克隆子元素节点
		fp.attr("id", "fp_" + index); //改变克隆子元素节点
		image.attr("id", "image_" + index); //改变克隆子元素节点
		zfbimagetd.attr("id", "zfbimagetd_" + index); //改变克隆子元素节点
		click.attr("id", "click_" + index); //改变克隆子元素节点
		sc.attr("id", "sc_" + index); //改变克隆子元素节点
		checkTrue.attr("id", "checkTrue_" + index); //改变克隆子元素节点
		checkRepet.attr("id", "checkRepet_" + index); //改变克隆子元素节点
		otherFp.attr("id", "cost6Fp_" + (x+1)); //改变克隆子元素节点
		$('#cost6_0').after(addItem);
		$('#zfbimagetd_' + index).empty();
		$('#zfbimagetd_' + index)
				.append(
						'<a onclick="clickUpFile(this)" id="click_'
								+ index
								+ '" style="font-weight: bold;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
								+'<a onclick="deleteTrains(this)" style="float: right;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#amount_' + index).val("");
		$('#tax_' + index).val("");
		$('#time_' + index).val("");
		$('#remark_' + index).val("");
		$('#fp_' + index).val(null);
		$('#checkTrue_' + index).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">');
		$('#checkRepet_' + index).html("");
		
		var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
		for (var i = 1; i < fromNum.length; i++) {
			var s = fromNum[i].children[0].children[0].children[0].id;
			$('#' + s).html("发票"+i);
			}
		x = x + 1;
	}
	
	function append8(obj) {
		var r=${a+b+c+d+e+f+g+x};
		index = index + 1;
		var addItem = $('#cost7_0').clone(true);
		addItem.attr('id', "cost7_" + (y + 1));
		var amount = addItem.find('#amount_'+r); //根据id查找子元素
		var tax = addItem.find('#tax_'+r);
		var time = addItem.find('#time_'+r);
		var remark = addItem.find('#remark_'+r);
		var fp = addItem.find('#fp_'+r);
		var image = addItem.find('#image_'+r);
		var zfbimagetd = addItem.find('#zfbimagetd_'+r);
		var click = addItem.find('#click_'+r);
		var sc = addItem.find('#sc_'+r);
		var checkTrue = addItem.find('#checkTrue_'+r );
		var checkRepet = addItem.find('#checkRepet_'+r );
		var otherFp = addItem.find('#cost7Fp_0' );
		amount.attr("id", "amount_" + index); //改变克隆子元素节点
		tax.attr("id", "tax_" + index); //改变克隆元素子节点
		time.attr("id", "time_" + index); //改变克隆子元素节点
		remark.attr("id", "remark_" + index); //改变克隆子元素节点
		fp.attr("id", "fp_" + index); //改变克隆子元素节点
		image.attr("id", "image_" + index); //改变克隆子元素节点
		zfbimagetd.attr("id", "zfbimagetd_" + index); //改变克隆子元素节点
		click.attr("id", "click_" + index); //改变克隆子元素节点
		sc.attr("id", "sc_" + index); //改变克隆子元素节点
		checkTrue.attr("id", "checkTrue_" + index); //改变克隆子元素节点
		checkRepet.attr("id", "checkRepet_" + index); //改变克隆子元素节点
		otherFp.attr("id", "cost7Fp_" + (y+1)); //改变克隆子元素节点
		$('#cost7_0').after(addItem);
		$('#zfbimagetd_' + index).empty();
		$('#zfbimagetd_' + index)
				.append(
						'<a onclick="clickUpFile(this)" id="click_'
								+ index
								+ '" style="font-weight: bold;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
								+'<a onclick="deleteTrains(this)" style="float: right;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#amount_' + index).val("");
		$('#tax_' + index).val("");
		$('#time_' + index).val("");
		$('#remark_' + index).val("");
		$('#fp_' + index).val(null);
		$('#checkTrue_' + index).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">');
		$('#checkRepet_' + index).html("");
		
		var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
		for (var i = 1; i < fromNum.length; i++) {
			var s = fromNum[i].children[0].children[0].children[0].id;
			$('#' + s).html("发票"+i);
			}
		y = y + 1;
	}
	function append9(obj) {
		var t=${a+b+c+d+e+f+g+x+y};
		index = index + 1;
		var addItem = $('#cost8_0').clone(true);
		addItem.attr('id', "cost8_" + (z + 1));
		var amount = addItem.find('#amount_'+t); //根据id查找子元素
		var tax = addItem.find('#tax_'+t);
		var time = addItem.find('#time_'+t);
		var remark = addItem.find('#remark_'+t);
		var fp = addItem.find('#fp_'+t);
		var image = addItem.find('#image_'+t);
		var zfbimagetd = addItem.find('#zfbimagetd_'+t);
		var click = addItem.find('#click_'+t);
		var sc = addItem.find('#sc_'+t);
		var checkTrue = addItem.find('#checkTrue_'+t );
		var checkRepet = addItem.find('#checkRepet_'+t );
		var otherFp = addItem.find('#cost8Fp_0' );
		amount.attr("id", "amount_" + index); //改变克隆子元素节点
		tax.attr("id", "tax_" + index); //改变克隆元素子节点
		time.attr("id", "time_" + index); //改变克隆子元素节点
		remark.attr("id", "remark_" + index); //改变克隆子元素节点
		fp.attr("id", "fp_" + index); //改变克隆子元素节点
		image.attr("id", "image_" + index); //改变克隆子元素节点
		zfbimagetd.attr("id", "zfbimagetd_" + index); //改变克隆子元素节点
		click.attr("id", "click_" + index); //改变克隆子元素节点
		sc.attr("id", "sc_" + index); //改变克隆子元素节点
		checkTrue.attr("id", "checkTrue_" + index); //改变克隆子元素节点
		checkRepet.attr("id", "checkRepet_" + index); //改变克隆子元素节点
		otherFp.attr("id", "cost8Fp_" + (z+1)); //改变克隆子元素节点
		$('#cost8_0').after(addItem);
		$('#zfbimagetd_' + index).empty();
		$('#zfbimagetd_' + index)
				.append(
						'<a onclick="clickUpFile(this)" id="click_'
								+ index
								+ '" style="font-weight: bold;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
								+'<a onclick="deleteTrains(this)" style="float: right;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#amount_' + index).val("");
		$('#tax_' + index).val("");
		$('#time_' + index).val("");
		$('#remark_' + index).val("");
		$('#fp_' + index).val(null);
		$('#checkTrue_' + index).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">');
		$('#checkRepet_' + index).html("");
		
		var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
		for (var i = 1; i < fromNum.length; i++) {
			var s = fromNum[i].children[0].children[0].children[0].id;
			$('#' + s).html("发票"+i);
			}
		z = z + 1;
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
		var id = obj.id;
		var i = id.lastIndexOf("\_");
		var j = id.substring(i + 1, id.length);
		$('#image_' + j).click();
	}

	
	function upImageFile(obj) {
		var id = obj.id;
		var i = id.lastIndexOf("\_");
		var j = id.substring(i + 1, id.length);
		if (obj == null || obj == "") {
			return;
		}
		var files = obj.files;
		var formData = new FormData();
		for (var i = 0; i < files.length; i++) {
			formData.append("imageFile", files[i]);//图片文件
			$
					.ajax({
						url : base + '/base64/uploadImage',
						type : 'post',
						data : formData,
						cache : false,
						processData : false,
						contentType : false,
						async : false,
						dataType : 'json',
						success : function(data) {
							upladFp(obj, "hotel", "fp03",j);
							
				        	var num = obj.parentNode.parentNode.parentNode.id;
				        	$('#zfbimagetd_'+j).empty();
				        	$('#image_'+j).val("");
				        	var x=num.lastIndexOf("\_");
				   	     var y=num.substring(x+1,num.length);
				        	if(y!=0){
				        		$('#zfbimagetd_' + j)
								.append(
										'<img style="vertical-align:bottom;margin-left:30px; width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)"/><a style="color:red" href="#" id="sc_'
												+ j
												+ '" onclick="deleteImage(this)">    删除</a>'
												+'<a onclick="deleteTrains(this)" style="float: right;" href="#">'
												+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
												+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
					        	}else{
					        		$('#zfbimagetd_'+j).append('<img style="vertical-align:bottom;margin-left:30px; width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)"/><a style="color:red" href="#" id="sc_'+j+'" onclick="deleteImage(this)">    删除</a>');
					        	}
							$('#checkTrue_'+j).html('<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/left/zp.png">');
				        	$('#checkRepet_'+j).html('<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/left/wcf.png">');
						}
					});
		}
	}
	//删除上传的图片
	function deleteImage(obj) {
		var id =obj.id;
		
		 var i=id.lastIndexOf("\_");
	     var j=id.substring(i+1,id.length);
	     var num = obj.parentNode.parentNode.parentNode.id;
     	$('#zfbimagetd_'+j).empty();
     	$('#image_'+j).val("");
     	var x=num.lastIndexOf("\_");
	     var y=num.substring(x+1,num.length);
	   	  if(y!=0){
	   		$('#zfbimagetd_' + j)
			.append(
					'<a onclick="clickUpFile(this)" id="click_'
							+ j
							+ '" style="font-weight: bold;" href="#">'
							+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
							+'<a onclick="deleteTrains(this)" style="float: right;" href="#">'
							+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
							+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
      	}else{
      		$('#zfbimagetd_'+j).append('<a onclick="clickUpFile(this)" id="click_'+j+'" style="font-weight: bold;" href="#">'+
					'<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)"'
					+' onMouseOut="mouseOut(this)"></a>');
      	}
		$('#fp_' + j).val(null);
		$('#checkTrue_'+j).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">');
		$('#checkRepet_'+j).html("");
	}
	//选择人员
	function chooseUser(obj){
		var id =obj.id;
		var i=id.lastIndexOf("\_");
	    var j=id.substring(i+1,id.length);
		var win=creatSecondWin('选择住宿人员',860,580,'icon-search','/user/chooseUser?index='+j+''); 
		win.window('open');
	}
	

	function  deleteTrains(item){
		var fromNum = item.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children.length;
		var id = item.parentNode.parentNode.parentNode.id;
		$("#"+id).remove();
		var arr=id.split("_");
		for(var i=1;i<fromNum-1;i++){
			if('hotel'==arr[0]){
				var tableId = $('#tableHotel').find('tbody');
				var fapiao = tableId[i].children[0].children[0].children[0].id;
				$("#"+fapiao).html("发票"+i);
				a=i-1;
			}
			if('food'==arr[0]){
				var tableId = $('#tableFood').find('tbody');
				var fapiao = tableId[i].children[0].children[0].children[0].id;
				$("#"+fapiao).html("发票"+i);
				b=i-1;
			}
			if('data'==arr[0]){
				var tableId = $('#tableCost1').find('tbody');
				var fapiao = tableId[i].children[0].children[0].children[0].id;
				$("#"+fapiao).html("发票"+i);
				c=i-1;
			}
			if('place'==arr[0]){
				var tableId = $('#tableCost2').find('tbody');
				var fapiao = tableId[i].children[0].children[0].children[0].id;
				$("#"+fapiao).html("发票"+i);
				d=i-1;
			}
			if('traffic'==arr[0]){
				var tableId = $('#tableCost3').find('tbody');
				var fapiao = tableId[i].children[0].children[0].children[0].id;
				$("#"+fapiao).html("发票"+i);
				e=i-1;
			}
			if('other'==arr[0]){
				var tableId = $('#tableCost4').find('tbody');
				var fapiao = tableId[i].children[0].children[0].children[0].id;
				$("#"+fapiao).html("发票"+i);
				f=i-1;
			}
			if('sz1'==arr[0]){
				var tableId = $('#tableCost5').find('tbody');
				var fapiao = tableId[i].children[0].children[0].children[0].id;
				$("#"+fapiao).html("发票"+i);
				g=i-1;
			}
			if('sz2'==arr[0]){
				var tableId = $('#tableCost6').find('tbody');
				var fapiao = tableId[i].children[0].children[0].children[0].id;
				$("#"+fapiao).html("发票"+i);
				x=i-1;
			}
			if('sz3'==arr[0]){
				var tableId = $('#tableCost7').find('tbody');
				var fapiao = tableId[i].children[0].children[0].children[0].id;
				$("#"+fapiao).html("发票"+i);
				y=i-1;
			}
			if('sz4'==arr[0]){
				var tableId = $('#tableCost8').find('tbody');
				var fapiao = tableId[i].children[0].children[0].children[0].id;
				$("#"+fapiao).html("发票"+i);
				z=i-1;
			}
		}
		addAmonut(item);
		return ;
	}
</script>

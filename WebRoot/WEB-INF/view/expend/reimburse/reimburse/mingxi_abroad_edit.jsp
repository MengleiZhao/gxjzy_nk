<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<style>
		.input_amonut{
		width: 140px;
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
<form id="form6">
	<table id="tableHotel" class="window-table-readonly" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:26%">
					<p style="color:#0000CD;" >国际旅费</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p id="p_hotelStd" >${abroad.travelMoney}}元</p>
				</td>
				<td>
					<a onclick="append(this)" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/tjfp1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>
			</tr>
			<c:forEach items="${fp1}" var="fp1" varStatus="st1">		
			<tbody id="hotel_${st1.index}" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;<span id="hotelFp_${st1.index}">发票${st1.index+1}</span>
					<input type="text" id="fp_${st1.index}" name="fileId" hidden="hidden" value="${fp1.fileId}">
					<input type="file" id="image_${st1.index }" onchange="upImageFile1(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st1.index}">
					<c:if test="${fp1.fileId==null||empty fp1.fileId}">
					<a onclick="clickUpFile(this)" id="click_${st1.index}" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>
					<c:if test="${fp1.fileId!=null&&!empty fp1.fileId}">
					<img style="vertical-align:bottom;width: 100px; height: 73px;margin-left:30px" onclick="yl(this.src)" src="${base}/attachment/download/${fp1.fileId}"/><a style="color:red" href="#" onclick="deleteImage(this)" id="sc_${st1.index}">    删除</a>
					</c:if>	
					<c:if test="${st1.index !=0}">
					<a onclick="deleteAbroads(this)" style="float: right;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>		
			</tr>
			<tr>
				<td class="td2" colspan="5" id="">
					<div style="width: auto; height:auto;margin-top:5px;margin-left:49px;">
						<p style="margin-bottom:10px;">
							<span class="fp_span">票面金额(元)：</span>
							<input  class="input_amonut a" name="amount" id="amount_${st1.index}" value="${fp1.amount}"  onchange="addAmonut(this)"
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" />
							<span class="fp_span1">专项税额(元)：</span>
							<input  name="tax" id="tax_${st1.index}" class="input_amonut" value="${fp1.tax}"
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')"  />
						</p>
						<p style="margin-bottom:10px;">
							<span class="fp_span">开票时间：</span>
							<input  name="time" id="time_${st1.index}" type="date" class="input_amonut"
							value="${fn:substring(fp1.time, 0, 10)}" />
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
<form id="form1">		
	<table id="tableFood" class="window-table-readonly" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:26%">
					<p style=" color:#0000CD;">住宿费</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p id="p_foodStd" >${abroad.hotelMoney}元</p>
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
					<input type="file" id="image_${st2.index+a}" onchange="upImageFile2(this)" hidden="hidden" >
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st2.index+a}">
					<c:if test="${fp2.fileId==null||empty fp2.fileId}">
					<a onclick="clickUpFile(this)" id="click_${st2.index+a}" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>
					<c:if test="${fp2.fileId!=null&&!empty fp2.fileId}">
					<img style="vertical-align:bottom;margin-left:30px;width: 100px; height: 73px;" onclick="yl(this.src)" src="${base}/attachment/download/${fp2.fileId}"/><a style="color:red" href="#" onclick="deleteImage(this)" id="sc_${st2.index+a}">    删除</a>
					</c:if>	
					<c:if test="${st2.index !=0}">
					<a onclick="deleteAbroads(this)" style="float: right;" href="#">
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
<form id="form2">		
	<table id="tableLong" class="window-table-readonly" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:26%">
					<p style=" color:#0000CD;" >伙食、公杂费</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p >${abroad.foodMoney}元</p>
				</td>
				<td>
					<a onclick="append3(this)" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/tjfp1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>

			</tr>
		<c:forEach items="${fp3}" var="fp3" varStatus="st3">
			<tbody id="long_${st3.index}" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;<span id="longFp_${st3.index}">发票${st3.index+1}</span>
					<input type="text" id="fp_${st3.index+a+b}" name="fileId" hidden="hidden"  value="${fp3.fileId}">
					<input type="file" id="image_${st3.index+a+b}" onchange="upImageFile3(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st3.index+a+b}">
					<c:if test="${fp3.fileId==null||empty fp3.fileId}">
					<a onclick="clickUpFile(this)" id="click_${st3.index+a+b}" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>
					<c:if test="${fp3.fileId!=null&&!empty fp3.fileId}">
					<img style="vertical-align:bottom;margin-left:30px;width: 100px; height: 73px;" onclick="yl(this.src)" src="${base}/attachment/download/${fp3.fileId}"/><a style="color:red" href="#" onclick="deleteImage(this)" id="sc_${st3.index+a+b}">    删除</a>
					</c:if>	
					<c:if test="${st3.index !=0}">
					<a onclick="deleteAbroads(this)" style="float: right;" href="#">
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
<form id="form3">		
	<table id="tableShort" class="window-table-readonly" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:26%">
					<p style=" color:#0000CD;">零用费</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p>${abroad.pocketMoney}元</p>
				</td>
				<td >
					<a onclick="append4(this)" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/tjfp1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>
			</tr>
			<c:forEach items="${fp4}" var="fp4" varStatus="st4">		
			<tbody id="short_${st4.index}" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;<span id="shortFp_${st4.index}">发票${st4.index+1}</span>
					<input type="text" id="fp_${st4.index+a+b+c}" name="fileId" hidden="hidden" value="${fp4.fileId}">
					<input type="file" id="image_${st4.index+a+b+c}" onchange="upImageFile4(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st4.index+a+b+c}">
					<c:if test="${fp4.fileId==null||empty fp4.fileId}">
					<a onclick="clickUpFile(this)" id="click_${st4.index+a+b+c}" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>
					<c:if test="${fp4.fileId!=null&&!empty fp4.fileId}">
					<img style="vertical-align:bottom;margin-left:30px;width: 100px; height: 73px;" onclick="yl(this.src)" src="${base}/attachment/download/${fp4.fileId}"/><a style="color:red" href="#" onclick="deleteImage(this)" id="sc_${st4.index+a+b+c}">    删除</a>
					</c:if>	
					<c:if test="${st4.index !=0}">
					<a onclick="deleteAbroads(this)" style="float: right;" href="#">
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
<form id="form4">
	<table id="tableOther" class="window-table-readonly" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:26%">
					<p style=" color:#0000CD;">交通费</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p>${abroad.trafficMoney}元</p>
				</td>
				<td>
					<a onclick="append2(this)" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/tjfp1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>
			</tr>
		<c:forEach items="${fp5}" var="fp5" varStatus="st5">		
			<tbody id="other_${st5.index}" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;<span id="otherFp_${st5.index}">发票${st5.index+1}</span>
					<input type="text" id="fp_${st5.index+a+b+c+d}" name="fileId" hidden="hidden"  value="${fp5.fileId}">
					<input type="file" id="image_${st5.index+a+b+c+d}" onchange="upImageFile5(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st5.index+a+b+c+d}">
					<c:if test="${fp5.fileId==null||empty fp5.fileId}">
					<a onclick="clickUpFile(this)" id="click_${st5.index+a+b+c+d}" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>
					<c:if test="${fp5.fileId!=null&&!empty fp5.fileId}">
					<img style="vertical-align:bottom;margin-left:30px;width: 100px; height: 73px;" onclick="yl(this.src)" src="${base}/attachment/download/${fp5.fileId}"/><a style="color:red" href="#" onclick="deleteImage(this)"  id="sc_${st5.index+a+b+c+d}">    删除</a>
					</c:if>
					<c:if test="${st5.index !=0}">
					<a onclick="deleteAbroads(this)" style="float: right;" href="#">
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
<form id="form5">
	<table id="tableOther1" class="window-table-readonly" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:26%">
					<p style=" color:#0000CD;">其他费用</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p>${abroad.totalOtherMoney}元</p>
				</td>
				<td>
					<a onclick="append5(this)" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/tjfp1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>
			</tr>
		<c:forEach items="${fp6}" var="fp6" varStatus="st6">		
			<tbody id="other1_${st6.index}" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;<span id="otherFp1_${st6.index}">发票${st6.index+1}</span>
					<input type="text" id="fp_${st6.index+a+b+c+d+f}" name="fileId" hidden="hidden"  value="${fp6.fileId}">
					<input type="file" id="image_${st6.index+a+b+c+d+f}" onchange="upImageFile5(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${st6.index+a+b+c+d+f}">
					<c:if test="${fp6.fileId==null||empty fp6.fileId}">
					<a onclick="clickUpFile(this)" id="click_${st6.index+a+b+c+d+f}" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>
					<c:if test="${fp6.fileId!=null&&!empty fp6.fileId}">
					<img style="vertical-align:bottom;margin-left:30px;width: 100px; height: 73px;" onclick="yl(this.src)" src="${base}/attachment/download/${fp6.fileId}"/><a style="color:red" href="#" onclick="deleteImage(this)"  id="sc_${st6.index+a+b+c+d+f}">    删除</a>
					</c:if>	
					<c:if test="${st6.index !=0}">
					<a onclick="deleteAbroads(this)" style="float: right;" href="#">
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
							<input  class="input_amonut a" name="amount" id="amount_${st6.index+a+b+c+d+f}" onchange="addAmonut(this)"
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp6.amount}" />
							<span class="fp_span1">专项税额(元)：</span>
							<input  class="input_amonut" name="tax" id="tax_${st6.index+a+b+c+d+f}" 
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp6.tax}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">开票时间：</span>
							<input  class="input_amonut" name="time" id="time_${st6.index+a+b+c+d+f}" type="date"
							value="${fn:substring(fp6.time, 0, 10)}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">备注：</span>
							<input  class="input_amonut1" name="remark" id="remark_${st6.index+a+b+c+d+f}" 
							value="${fp6.remark}" />
						</p>
						<p style="margin-bottom:5px;">
							<span style="width: 85px;display: inline-block;">核验结果：</span>
							<span style="width: 80px;display: inline-block;" id="checkTrue_${st6.index+a+b+c+d+f}">
								<c:if test="${fp6.fileId!=null&&!empty fp6.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">
								</c:if>
								<c:if test="${fp6.fileId==null||empty fp6.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">
								</c:if>
							</span>
							<span style="width: 45px;display: inline-block;" id="checkRepet_${st6.index+a+b+c+d+f}">
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
<script type="text/javascript">

var index =${a+b+c+d+f+e-1};
var a =${a-1};
var b =${b-1};
var c =${c-1};
var d =${d-1};
var f =${f-1};
var e =${e-1};
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
		var remark = addItem.find('#remark_0');
		var fp = addItem.find('#fp_0');
		var image = addItem.find('#image_0');
		var zfbimagetd = addItem.find('#zfbimagetd_0');
		var click = addItem.find('#click_0');
		var sc = addItem.find('#sc_0');
		var checkTrue = addItem.find('#checkTrue_0' );
		var checkRepet = addItem.find('#checkRepet_0' );
		var hotelFp = addItem.find('#hotelFp_0' );
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
		hotelFp.attr("id", "hotelFp_" + (a+1)); //改变克隆子元素节点
		
		var lastTbody = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].lastElementChild.id;
		$('#' + lastTbody).after(addItem);
		$('#zfbimagetd_' + index).empty();
		$('#zfbimagetd_' + index).append('<a onclick="clickUpFile(this)" id="click_'
								+ index
								+ '" style="font-weight: bold;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
								+'<a onclick="deleteAbroads(this)" style="float: right;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#amount_' + index).val("");
		$('#tax_' + index).val("");
		$('#time_' + index).val("");
		$('#remark_' + index).val("");
		$('#fp_' + index).val(null);
		$('#checkTrue_' + index).html('<a style="width: 80px;">请上传发票</a>');
		$('#checkRepet_' + index).html("");
		
		var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
		for (var i = 1; i < fromNum.length; i++) {
			var s = fromNum[i].children[0].children[0].children[0].id;
			$('#' + s).html("发票"+i);
			}
		a = a + 1;
	}
	function append1(obj) {
		var x=${a};
		index = index + 1;
		var addItem = $('#food_0').clone(true);
		addItem.attr('id', "food_" + (b + 1));
		var amount = addItem.find('#amount_'+x); //根据id查找子元素
		var tax = addItem.find('#tax_'+x);
		var time = addItem.find('#time_'+x);
		var remark = addItem.find('#remark_'+x);
		var fp = addItem.find('#fp_'+x);
		var image = addItem.find('#image_'+x);
		var zfbimagetd = addItem.find('#zfbimagetd_'+x);
		var click = addItem.find('#click_'+x);
		var sc = addItem.find('#sc_'+x);
		var checkTrue = addItem.find('#checkTrue_'+x);
		var checkRepet = addItem.find('#checkRepet_'+x );
		var foodFp = addItem.find('#foodFp_0');
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
		
		var lastTbody = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].lastElementChild.id;
		$('#' + lastTbody).after(addItem);
		$('#zfbimagetd_' + index).empty();
		$('#zfbimagetd_' + index)
				.append(
						'<a onclick="clickUpFile(this)" id="click_'
								+ index
								+ '" style="font-weight: bold;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
								+'<a onclick="deleteAbroads(this)" style="float: right;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#amount_' + index).val("");
		$('#tax_' + index).val("");
		$('#time_' + index).val("");
		$('#remark_' + index).val("");
		$('#fp_' + index).val(null);
		$('#checkTrue_' + index).html('<a style="width: 80px;">请上传发票</a>');
		$('#checkRepet_' + index).html("");
		
		var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
		for (var i = 1; i < fromNum.length; i++) {
			var s = fromNum[i].children[0].children[0].children[0].id;
			$('#' + s).html("发票"+i);
			}
		b = b + 1;
	}
	function append2(obj) {
		var y=${a+b+c+d};
		index = index + 1;
		var addItem = $('#other_0').clone(true);
		addItem.attr('id', "other_" + (f + 1));
		var amount = addItem.find('#amount_'+y); //根据id查找子元素
		var tax = addItem.find('#tax_'+y);
		var time = addItem.find('#time_'+y);
		var remark = addItem.find('#remark_'+y);
		var fp = addItem.find('#fp_'+y);
		var image = addItem.find('#image_'+y);
		var zfbimagetd = addItem.find('#zfbimagetd_'+y);
		var click = addItem.find('#click_'+y);
		var sc = addItem.find('#sc_'+y);
		var checkTrue = addItem.find('#checkTrue_'+y );
		var checkRepet = addItem.find('#checkRepet_'+y );
		var otherFp = addItem.find('#otherFp_0');
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
		otherFp.attr("id", "otherFp_" + (f+1)); //改变克隆子元素节点
		
		var lastTbody = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].lastElementChild.id;
		$('#' + lastTbody).after(addItem);
		$('#zfbimagetd_' + index).empty();
		$('#zfbimagetd_' + index)
				.append(
						'<a onclick="clickUpFile(this)" id="click_'
								+ index
								+ '" style="font-weight: bold;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
								+'<a onclick="deleteAbroads(this)" style="float: right;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#amount_' + index).val("");
		$('#tax_' + index).val("");
		$('#time_' + index).val("");
		$('#remark_' + index).val("");
		$('#fp_' + index).val(null);
		$('#checkTrue_' + index).html('<a style="width: 80px;">请上传发票</a>');
		$('#checkRepet_' + index).html("");
		
		var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
		for (var i = 1; i < fromNum.length; i++) {
			var s = fromNum[i].children[0].children[0].children[0].id;
			$('#' + s).html("发票"+i);
			}
		f = f + 1;
	}
	function append3(obj) {
		index = index + 1;
		var z=${a+b};
		var addItem = $('#long_0').clone(true);
		addItem.attr('id', "long_" + (c + 1));
		var amount = addItem.find('#amount_'+z); //根据id查找子元素
		var tax = addItem.find('#tax_'+z);
		var time = addItem.find('#time_'+z);
		var remark = addItem.find('#remark_'+z);
		var fp = addItem.find('#fp_'+z);
		var image = addItem.find('#image_'+z);
		var zfbimagetd = addItem.find('#zfbimagetd_'+z);
		var click = addItem.find('#click_'+z);
		var sc = addItem.find('#sc_'+z);
		var checkTrue = addItem.find('#checkTrue_'+z );
		var checkRepet = addItem.find('#checkRepet_'+z );
		var longFp = addItem.find('#longFp_0');
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
		longFp.attr("id", "longFp_" + (c+1)); //改变克隆子元素节点
		
		var lastTbody = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].lastElementChild.id;
		$('#' + lastTbody).after(addItem);
		$('#zfbimagetd_' + index).empty();
		$('#zfbimagetd_' + index)
				.append(
						'<a onclick="clickUpFile(this)" id="click_'
								+ index
								+ '" style="font-weight: bold;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
								+'<a onclick="deleteAbroads(this)" style="float: right;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#amount_' + index).val("");
		$('#tax_' + index).val("");
		$('#time_' + index).val("");
		$('#remark_' + index).val("");
		$('#fp_' + index).val(null);
		$('#checkTrue_' + index).html('<a style="width: 80px;">请上传发票</a>');
		$('#checkRepet_' + index).html("");
		
		var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
		for (var i = 1; i < fromNum.length; i++) {
			var s = fromNum[i].children[0].children[0].children[0].id;
			$('#' + s).html("发票"+i);
			}
		c = c + 1;
	}
	function append4(obj) {
		index = index + 1;
		var m=${a+b+c};
		var addItem = $('#short_0').clone(true);
		addItem.attr('id', "short_" + (d + 1));
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
		var shortFp = addItem.find('#shortFp_0');
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
		shortFp.attr("id", "shortFp_" + (d+1)); //改变克隆子元素节点
		
		var lastTbody = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].lastElementChild.id;
		$('#' + lastTbody).after(addItem);
		$('#zfbimagetd_' + index).empty();
		$('#zfbimagetd_' + index)
				.append(
						'<a onclick="clickUpFile(this)" id="click_'
								+ index
								+ '" style="font-weight: bold;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
								+'<a onclick="deleteAbroads(this)" style="float: right;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#amount_' + index).val("");
		$('#tax_' + index).val("");
		$('#time_' + index).val("");
		$('#remark_' + index).val("");
		$('#fp_' + index).val(null);
		$('#checkTrue_' + index).html('<a style="width: 80px;">请上传发票</a>');
		$('#checkRepet_' + index).html("");
		
		var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
		for (var i = 1; i < fromNum.length; i++) {
			var s = fromNum[i].children[0].children[0].children[0].id;
			$('#' + s).html("发票"+i);
			}
		d = d + 1;
	}
	function append5(obj) {
		var n=${a+b+c+d+f};
		index = index + 1;
		var addItem = $('#other1_0').clone(true);
		addItem.attr('id', "other1_" + (e + 1));
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
		var otherFp = addItem.find('#otherFp1_0' );
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
		otherFp.attr("id", "otherFp1_" + (e+1)); //改变克隆子元素节点
		
		var lastTbody = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].lastElementChild.id;
		$('#' + lastTbody).after(addItem);
		$('#zfbimagetd_' + index).empty();
		$('#zfbimagetd_' + index)
				.append(
						'<a onclick="clickUpFile(this)" id="click_'
								+ index
								+ '" style="font-weight: bold;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
								+'<a onclick="deleteAbroads(this)" style="float: right;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#amount_' + index).val("");
		$('#tax_' + index).val("");
		$('#time_' + index).val("");
		$('#remark_' + index).val("");
		$('#fp_' + index).val(null);
		$('#checkTrue_' + index).html('<a style="width: 80px;">请上传发票</a>');
		$('#checkRepet_' + index).html("");
		
		var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
		for (var i = 1; i < fromNum.length; i++) {
			var s = fromNum[i].children[0].children[0].children[0].id;
			$('#' + s).html("发票"+i);
			}
		e = e + 1;
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

	//上传图片文件转化为base64在页面显示
	function upImageFile1(obj) {
		 ;
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
			$.ajax({
						url : base + '/base64/uploadImage',
						type : 'post',
						data : formData,
						cache : false,
						processData : false,
						contentType : false,
						async : false,
						dataType : 'json',
						success : function(data) {
							upladFp(obj, "hotel", "fp07",j);
							
				        	var num = obj.parentNode.parentNode.parentNode.id;
				        	$('#zfbimagetd_'+j).empty();
				        	$('#image_'+j).val("");
				        	var x=num.lastIndexOf("\_");
				   	     	var y=num.substring(x+1,num.length);
				        	if(y!=0){
				        		$('#zfbimagetd_' + j).append(
										'<img style="vertical-align:bottom;margin-left:30px; width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)"/><a style="color:red" href="#" id="sc_'
												+ j
												+ '" onclick="deleteImage(this)">    删除</a>'
												+'<a onclick="deleteAbroads(this)" style="float: right;" href="#">'
												+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
												+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
					        	}else{
					        		$('#zfbimagetd_'+j).append('<img style="vertical-align:bottom;margin-left:30px; width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)"/><a style="color:red" href="#" id="sc_'+j+'" onclick="deleteImage(this)">    删除</a>');
					        	}
							$('#checkTrue_'+j).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">');
				        	$('#checkRepet_'+j).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/wcf.png">');
						}
					});
		}
	}

	function upImageFile2(obj) {
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
							upladFp(obj, "food", "fp07",j);
							
				        	var num = obj.parentNode.parentNode.parentNode.id;
				        	$('#zfbimagetd_'+j).empty();
				        	$('#image_'+j).val("");
				        	var x=num.lastIndexOf("\_");
				   	     	var y=num.substring(x+1,num.length);
				        	if(y!=0){
				        		$('#zfbimagetd_' + j).append(
										'<img style="vertical-align:bottom;margin-left:30px; width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)"/><a style="color:red" href="#" id="sc_'
												+ j
												+ '" onclick="deleteImage(this)">    删除</a>'
												+'<a onclick="deleteAbroads(this)" style="float: right;" href="#">'
												+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
												+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
					        	}else{
					        		$('#zfbimagetd_'+j).append('<img style="vertical-align:bottom;margin-left:30px; width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)"/><a style="color:red" href="#" id="sc_'+j+'" onclick="deleteImage(this)">    删除</a>');
					        	}
							$('#checkTrue_'+j).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">');
				        	$('#checkRepet_'+j).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/wcf.png">');
						}
					});
		}
	}
	function upImageFile3(obj) {
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
							upladFp(obj, "long", "fp07",j);
							
				        	var num = obj.parentNode.parentNode.parentNode.id;
				        	$('#zfbimagetd_'+j).empty();
				        	$('#image_'+j).val("");
				        	var x=num.lastIndexOf("\_");
				   	     	var y=num.substring(x+1,num.length);
				        	if(y!=0){
				        		$('#zfbimagetd_' + j).append(
										'<img style="vertical-align:bottom;margin-left:30px; width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)"/><a style="color:red" href="#" id="sc_'
												+ j
												+ '" onclick="deleteImage(this)">    删除</a>'
												+'<a onclick="deleteAbroads(this)" style="float: right;" href="#">'
												+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
												+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
					        	}else{
					        		$('#zfbimagetd_'+j).append('<img style="vertical-align:bottom;margin-left:30px; width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)"/><a style="color:red" href="#" id="sc_'+j+'" onclick="deleteImage(this)">    删除</a>');
					        	}
							$('#checkTrue_'+j).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">');
				        	$('#checkRepet_'+j).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/wcf.png">');
						}
					});
		}
	}
	function upImageFile4(obj) {
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
							upladFp(obj, "short", "fp07",j);
							
				        	var num = obj.parentNode.parentNode.parentNode.id;
				        	$('#zfbimagetd_'+j).empty();
				        	$('#image_'+j).val("");
				        	var x=num.lastIndexOf("\_");
				   	     	var y=num.substring(x+1,num.length);
				        	if(y!=0){
				        		$('#zfbimagetd_' + j).append(
										'<img style="vertical-align:bottom;margin-left:30px; width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)"/><a style="color:red" href="#" id="sc_'
												+ j
												+ '" onclick="deleteImage(this)">    删除</a>'
												+'<a onclick="deleteAbroads(this)" style="float: right;" href="#">'
												+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
												+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
					        	}else{
					        		$('#zfbimagetd_'+j).append('<img style="vertical-align:bottom;margin-left:30px; width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)"/><a style="color:red" href="#" id="sc_'+j+'" onclick="deleteImage(this)">    删除</a>');
					        	}
							$('#checkTrue_'+j).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">');
				        	$('#checkRepet_'+j).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/wcf.png">');
						}
					});
		}
	}
	function upImageFile5(obj) {
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
							upladFp(obj, "other", "fp07",j);
							
				        	var num = obj.parentNode.parentNode.parentNode.id;
				        	$('#zfbimagetd_'+j).empty();
				        	$('#image_'+j).val("");
				        	var x=num.lastIndexOf("\_");
				   	     	var y=num.substring(x+1,num.length);
				        	if(y!=0){
				        		$('#zfbimagetd_' + j).append(
										'<img style="vertical-align:bottom;margin-left:30px; width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)"/><a style="color:red" href="#" id="sc_'
												+ j
												+ '" onclick="deleteImage(this)">    删除</a>'
												+'<a onclick="deleteAbroads(this)" style="float: right;" href="#">'
												+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
												+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
					        	}else{
					        		$('#zfbimagetd_'+j).append('<img style="vertical-align:bottom;margin-left:30px; width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)"/><a style="color:red" href="#" id="sc_'+j+'" onclick="deleteImage(this)">    删除</a>');
					        	}
							$('#checkTrue_'+j).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">');
				        	$('#checkRepet_'+j).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/wcf.png">');
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
	   		$('#zfbimagetd_' + j).append('<a onclick="clickUpFile(this)" id="click_'
				+ j
				+ '" style="font-weight: bold;" href="#">'
				+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"'
				+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
				+'<a onclick="deleteAbroads(this)" style="float: right;" href="#">'
				+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
				+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
      	}else{
      		$('#zfbimagetd_'+j).append('<a onclick="clickUpFile(this)" id="click_'+j+'" style="font-weight: bold;" href="#">'+
					'<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)"'
					+' onMouseOut="mouseOut(this)"></a>');
      	}
		$('#fp_' + j).val(null);
		$('#checkTrue_'+j).html('<a style="width: 80px;">请上传发票</a>');
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
	
	
	function  deleteAbroads(item){
		
		var fromNum = item.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children.length;
		var id = item.parentNode.parentNode.parentNode.id;
		$("#"+id).remove();
		var arr=id.split("_");
		for(var i=1;i<fromNum-1;i++){
			if('other1'==arr[0]){
				var tableId = $('#tableOther1').find('tbody');
				var fapiao = tableId[i].children[0].children[0].children[0].id;
				$("#"+fapiao).html("发票"+i);
				e = e - 1;
				if(e==-1){
					e=0;
				}
				
			}
			if('food'==arr[0]){
				var tableId = $('#tableFood').find('tbody');
				var fapiao = tableId[i].children[0].children[0].children[0].id;
				$("#"+fapiao).html("发票"+i);
				b = b - 1;
				if(b==-1){
					b=0;
				}
			}
			if('hotel'==arr[0]){
				var tableId = $('#tableHotel').find('tbody');
				var fapiao = tableId[i].children[0].children[0].children[0].id;
				$("#"+fapiao).html("发票"+i);
				a = a - 1;
				if(a==-1){
					a=0;
				}
			}
			if('short'==arr[0]){
				var tableId = $('#tableShort').find('tbody');
				var fapiao = tableId[i].children[0].children[0].children[0].id;
				$("#"+fapiao).html("发票"+i);
				d = d - 1;
				if(d==-1){
					d=0;
				}
			}
			if('long'==arr[0]){
				var tableId = $('#tableLong').find('tbody');
				var fapiao = tableId[i].children[0].children[0].children[0].id;
				$("#"+fapiao).html("发票"+i);
				c = c - 1;
				if(c==-1){
					c=0;
				}
			}
			if('other'==arr[0]){
				var tableId = $('#tableOther').find('tbody');
				var fapiao = tableId[i].children[0].children[0].children[0].id;
				$("#"+fapiao).html("发票"+i);
				f=f-1;
				if(f==-1){
					f=0;
				}
			}
		}
		addAmonut(item);
		return ;
	}
</script>

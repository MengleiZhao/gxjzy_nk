<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="/includes/taglibs.jsp"%>

<style type="text/css">
.pro_plan_th {background: #c1e3f2;font-weight: bold;color: #333333;}
.pro_plan_table td {border-left:1px solid black;border-bottom:1px solid black;margin: 0;padding: 0}
.pro_plan_input{border: 1px solid #fff;background-color: #f0f5f7;vertical-align: middle;width: 80px;}
.pro_plan_input:read-only{ background-color: #f6f6f6;} 

</style>


	<table style="width:100%" class="a_table">
		<tr style="height: 15px"><td>单位：元</td></tr>
			<!-- <td style=" text-align: left;">
			支出计划总额度:<input class="easyui-numberbox" style="width: 100px;height: 20px"/>
			</td> -->
	</table>
	
	<table id="pro_plan_table" class="ystable">
		<tr style="text-align: center;">
			<th class="pro_plan_th" rowspan="2" style="width: 30px;">序号</th>
			<th class="pro_plan_th" rowspan="2">预算年度</th>
			<th class="pro_plan_th" rowspan="2">支出计划额度</th>
			<th class="pro_plan_th" colspan="3">年初预算</th>
			<th class="pro_plan_th" colspan="3">执行调整</th>
			<th class="pro_plan_th" colspan="3">全年预算</th>
			<th class="pro_plan_th" colspan="3">支出</th>
			<th class="pro_plan_th" colspan="3">年度剩余</th>
			<th class="pro_plan_th" colspan="3">实际年度剩余</th>
			<th class="" style="width:50px"></th>
		</tr>
		
		<tr style="text-align: center;">
			<th class="pro_plan_th" name="">财政拨款</th>
			<th class="pro_plan_th" name="">结转资金</th>
			<th class="pro_plan_th" name="">小计</th>
			<th class="pro_plan_th" name="">财政拨款</th>
			<th class="pro_plan_th" name="">结转资金</th>
			<th class="pro_plan_th" name="">小计</th>
			<th class="pro_plan_th" name="">财政拨款</th>
			<th class="pro_plan_th" name="">结转资金</th>
			<th class="pro_plan_th" name="">小计</th>
			<th class="pro_plan_th" name="">财政拨款</th>
			<th class="pro_plan_th" name="">结转资金</th>
			<th class="pro_plan_th" name="">小计</th>
			<th class="pro_plan_th" name="">财政拨款</th>
			<th class="pro_plan_th" name="">结转资金</th>
			<th class="pro_plan_th" name="">小计</th>
			<th class="pro_plan_th" name="">财政拨款</th>
			<th class="pro_plan_th" name="">结转资金</th>
			<th class="pro_plan_th" name="">小计</th>
		</tr>
		
		<c:if test="${!empty planList}">
		<c:forEach var="p" items="${planList}" varStatus="status">
		<tr class="gdzqTr">
			<td><span style="width: 30px;display: block;text-align: center;">${status.index+1}</span></td>
			<td><input class="pro_plan_input" id="plan2_${status.index}" name="planList[${status.index}].year" value="${p.year}" oninput="autoPlanYear(this)"/></td>
			<td><input class="pro_plan_input" id="plan3_${status.index}" name="planList[${status.index}].totalPlan" value="${p.totalPlan}" oninput="autoTotalPlan(this)"/></td>
			<td><input class="pro_plan_input" id="plan5_${status.index}" name="planList[${status.index}].earlyAmount1" value="${p.earlyAmount1}" oninput="autoCaculate(this)"/></td>
			<td><input class="pro_plan_input" id="plan6_${status.index}" name="planList[${status.index}].earlyAmount2" value="${p.earlyAmount2}" oninput="autoCaculate(this)"/></td>
			<td><input class="pro_plan_input" id="plan4_${status.index}" name="planList[${status.index}].earlyTotal" value="${p.earlyTotal}" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>
			<td><input class="pro_plan_input" id="plan8_${status.index}" name="planList[${status.index}].adjustAmount1" value="${p.adjustAmount1}" oninput="autoCaculate(this)"/></td>
			<td><input class="pro_plan_input" id="plan9_${status.index}" name="planList[${status.index}].adjustAmount2" value="${p.adjustAmount2}" oninput="autoCaculate(this)"/></td>
			<td><input class="pro_plan_input" id="plan7_${status.index}" name="planList[${status.index}].adjustTotal" value="${p.adjustTotal}" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>
			<td><input class="pro_plan_input" id="plan11_${status.index}" name="planList[${status.index}].yearAmount1" value="${p.yearAmount1}" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>
			<td><input class="pro_plan_input" id="plan12_${status.index}" name="planList[${status.index}].yearAmount2" value="${p.yearAmount2}" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>
			<td><input class="pro_plan_input" id="plan10_${status.index}" name="planList[${status.index}].yearTotal" value="${p.yearTotal}" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>
			<td><input class="pro_plan_input" id="plan14_${status.index}" name="planList[${status.index}].outAmount1" value="${p.outAmount1}" oninput="autoCaculate(this)"/></td>
			<td><input class="pro_plan_input" id="plan15_${status.index}" name="planList[${status.index}].outAmount2" value="${p.outAmount2}" oninput="autoCaculate(this)"/></td>
			<td><input class="pro_plan_input" id="plan13_${status.index}" name="planList[${status.index}].outTotal" value="${p.outTotal}" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>
			<td><input class="pro_plan_input" id="plan17_${status.index}" name="planList[${status.index}].leastAmount1" value="${p.leastAmount1}" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>
			<td><input class="pro_plan_input" id="plan18_${status.index}" name="planList[${status.index}].leastAmount2" value="${p.leastAmount2}" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>
			<td><input class="pro_plan_input" id="plan16_${status.index}" name="planList[${status.index}].leastTotal" value="${p.leastTotal}" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>
			<td><input class="pro_plan_input" id="plan20_${status.index}" name="planList[${status.index}].actualAmount1" value="${p.actualAmount1}"/></td>
			<td><input class="pro_plan_input" id="plan21_${status.index}" name="planList[${status.index}].actualAmount2" value="${p.actualAmount2}"/></td>
			<td><input class="pro_plan_input" id="plan19_${status.index}" name="planList[${status.index}].actualTotal" value="${p.actualTotal}" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>
		</tr>
		</c:forEach>
		</c:if>
		<c:if test="${empty planList}">
		<tr class="gdzqTr">
			<td><span style="width: 30px;display: block;text-align: center;">1</span></td>
			<td><input class="pro_plan_input" id="plan2_0" name="planList[0].year" value="${bean.planStartYear}" oninput="autoPlanYear(this)"/></td>
			<td><input class="pro_plan_input" id="plan3_0" name="planList[0].totalPlan" oninput="autoTotalPlan(this)"/></td>
			<td><input class="pro_plan_input" id="plan5_0" name="planList[0].earlyAmount1" oninput="autoCaculate(this)"/></td>
			<td><input class="pro_plan_input" id="plan6_0" name="planList[0].earlyAmount2" oninput="autoCaculate(this)" value="0.00"/></td>
			<td><input class="pro_plan_input" id="plan4_0" name="planList[0].earlyTotal" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>
			<td><input class="pro_plan_input" id="plan8_0" name="planList[0].adjustAmount1" oninput="autoCaculate(this)" value="0.00"/></td>
			<td><input class="pro_plan_input" id="plan9_0" name="planList[0].adjustAmount2" oninput="autoCaculate(this)" value="0.00"/></td>
			<td><input class="pro_plan_input" id="plan7_0" name="planList[0].adjustTotal" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>
			<td><input class="pro_plan_input" id="plan11_0" name="planList[0].yearAmount1" readonly="readonly" oninput="autoCaculate(this)"  placeholder="&lt;自动计算 &gt;"/></td>
			<td><input class="pro_plan_input" id="plan12_0" name="planList[0].yearAmount2" readonly="readonly" oninput="autoCaculate(this)"  placeholder="&lt;自动计算 &gt;"/></td>
			<td><input class="pro_plan_input" id="plan10_0" name="planList[0].yearTotal" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>
			<td><input class="pro_plan_input" id="plan14_0" name="planList[0].outAmount1" oninput="autoCaculate(this)"/></td>
			<td><input class="pro_plan_input" id="plan15_0" name="planList[0].outAmount2" oninput="autoCaculate(this)"  value="0.00"/></td>
			<td><input class="pro_plan_input" id="plan13_0" name="planList[0].outTotal" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>
			<td><input class="pro_plan_input" id="plan17_0" name="planList[0].leastAmount1" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>
			<td><input class="pro_plan_input" id="plan18_0" name="planList[0].leastAmount2" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>
			<td><input class="pro_plan_input" id="plan16_0" name="planList[0].leastTotal" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>
			<td><input class="pro_plan_input" id="plan20_0" name="planList[0].actualAmount1" oninput="autoCaculate(this)"/></td>
			<td><input class="pro_plan_input" id="plan21_0" name="planList[0].actualAmount2" oninput="autoCaculate(this)" value="0.00"/></td>
			<td><input class="pro_plan_input" id="plan19_0" name="planList[0].actualTotal" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>
			<!-- <td><a href="javascript:void(0)" onclick="deletePlanRow(this)"><span class="pro_add_deleter">删除</span></a></td> -->
		</tr> 
		</c:if>
	</table>
	
	<script type="text/javascript">
	var rIndex=0;
	function appendPlanCome(){
		rIndex++;
		var table = $('#pro_plan_table');
		table.append("<tr class='gdzqTr'>"
				+"<td>"+(rIndex+1)+"</td>"
				+"<td><input class='pro_plan_input' id='plan2_"+rIndex+"' name='planList["+rIndex+"].year' oninput='autoPlanYear(this)'/></td>"
				+"<td><input class='pro_plan_input' id='plan3_"+rIndex+"' name='planList["+rIndex+"].totalPlan' oninput='autoTotalPlan(this)'/></td>"
				+"<td><input class='pro_plan_input' id='plan5_"+rIndex+"' name='planList["+rIndex+"].earlyAmount1' oninput='autoCaculate(this)'/></td>"
				+"<td><input class='pro_plan_input' id='plan6_"+rIndex+"' name='planList["+rIndex+"].earlyAmount2' oninput='autoCaculate(this)'/></td>"
				+"<td><input class='pro_plan_input' id='plan4_"+rIndex+"' name='planList["+rIndex+"].earlyTotal' readonly='readonly' oninput='autoCaculate(this)' placeholder='&lt;自动计算 &gt;'/></td>"
				+"<td><input class='pro_plan_input' id='plan8_"+rIndex+"' name='planList["+rIndex+"].adjustAmount1' oninput='autoCaculate(this)'/></td>"
				+"<td><input class='pro_plan_input' id='plan9_"+rIndex+"' name='planList["+rIndex+"].adjustAmount2' oninput='autoCaculate(this)'/></td>"
				+"<td><input class='pro_plan_input' id='plan7_"+rIndex+"' name='planList["+rIndex+"].adjustTotal' readonly='readonly' oninput='autoCaculate(this)' placeholder='&lt;自动计算 &gt;'/></td>"
				+"<td><input class='pro_plan_input' id='plan11_"+rIndex+"' name='planList["+rIndex+"].yearAmount1' readonly='readonly' oninput='autoCaculate(this)' placeholder='&lt;自动计算 &gt;'/></td>"
				+"<td><input class='pro_plan_input' id='plan12_"+rIndex+"' name='planList["+rIndex+"].yearAmount2' readonly='readonly' oninput='autoCaculate(this)' placeholder='&lt;自动计算 &gt;'/></td>"
				+"<td><input class='pro_plan_input' id='plan10_"+rIndex+"' name='planList["+rIndex+"].yearTotal' readonly='readonly' oninput='autoCaculate(this)' placeholder='&lt;自动计算 &gt;'/></td>"
				+"<td><input class='pro_plan_input' id='plan14_"+rIndex+"' name='planList["+rIndex+"].outAmount1' oninput='autoCaculate(this)'/></td>"
				+"<td><input class='pro_plan_input' id='plan15_"+rIndex+"' name='planList["+rIndex+"].outAmount2' oninput='autoCaculate(this)'/></td>"
				+"<td><input class='pro_plan_input' id='plan13_"+rIndex+"' name='planList["+rIndex+"].outTotal' readonly='readonly' oninput='autoCaculate(this)' placeholder='&lt;自动计算 &gt;'/></td>"
				+"<td><input class='pro_plan_input' id='plan17_"+rIndex+"' name='planList["+rIndex+"].leastAmount1' readonly='readonly' oninput='autoCaculate(this)' placeholder='&lt;自动计算 &gt;'/></td>"
				+"<td><input class='pro_plan_input' id='plan18_"+rIndex+"' name='planList["+rIndex+"].leastAmount2' readonly='readonly' oninput='autoCaculate(this)' placeholder='&lt;自动计算 &gt;'/></td>"
				+"<td><input class='pro_plan_input' id='plan16_"+rIndex+"' name='planList["+rIndex+"].leastTotal' readonly='readonly' oninput='autoCaculate(this)' placeholder='&lt;自动计算 &gt;'/></td>"
				+"<td><input class='pro_plan_input' id='plan20_"+rIndex+"' name='planList["+rIndex+"].actualAmount1' oninput='autoCaculate(this)'/></td>"
				+"<td><input class='pro_plan_input' id='plan21_"+rIndex+"' name='planList["+rIndex+"].actualAmount2' oninput='autoCaculate(this)'/></td>"
				+"<td><input class='pro_plan_input' id='plan19_"+rIndex+"' name='planList["+rIndex+"].actualTotal' readonly='readonly' oninput='autoCaculate(this)' placeholder='&lt;自动计算 &gt;'/></td>"
				+"</tr>");
		/* +"<td><a href='javascript:void(0)' onclick='deletePlanRow(this)'><span class='pro_add_deleter'>删除</span></a></td>" */
	}
	
	function deletePlanRow(obj){
		var td=obj.parentNode;
		var row=td.parentNode;
		row.parentNode.removeChild(row);
	}
	
	var autoCaculateOld="";
	function autoCaculate(obj){
		var patt = /^[0-9]*(\.){0,1}[0-9]{0,2}$/;//判断小数的正则表达式
		//字符校验
		if(patt.test(obj.value)){
			autoCaculateOld = obj.value;
		} else {
			obj.value = autoCaculateOld;
		}
		
		var nkzjzeNum=0;//年度资金总额
		var czbkNum=0;//财政拨款
		var qtzjNum=0;//其他资金
		
		
		$('#pro_plan_table tr').each(function(i){     // 遍历 tr
			var ary = [];
			$(this).children('td').each(function(j){  // 遍历 tr 的各个 td
				$(this).children('input').each(function(k){
					ary.push($(this).attr('id'));
				});
	      	});
			//年初预算
			var total4 = parseFloat($('#'+ary[2]).val())+parseFloat($('#'+ary[3]).val());
			//执行调整
			var total7 = parseFloat($('#'+ary[5]).val())+parseFloat($('#'+ary[6]).val());
			//全年预算
			var total10;
			total10 = total4 + total7; 
			if (isNaN(total7)) {
				total10 = total4;
			}
			var total8 = parseFloat($('#'+ary[2]).val())+parseFloat($('#'+ary[5]).val());
			var total9 = parseFloat($('#'+ary[3]).val())+parseFloat($('#'+ary[6]).val());
			//支出
			var total13 = parseFloat($('#'+ary[11]).val())+parseFloat($('#'+ary[12]).val());
			//年度剩余
			var total16 = total10 - total13;
			var total14 = parseFloat($('#'+ary[2]).val())+parseFloat($('#'+ary[5]).val())-parseFloat($('#'+ary[11]).val());
			var total15 = parseFloat($('#'+ary[3]).val())+parseFloat($('#'+ary[6]).val())-parseFloat($('#'+ary[12]).val());;
			//实际年度剩余
			var total19 = parseFloat($('#'+ary[17]).val())+parseFloat($('#'+ary[18]).val());
			//放入数据
			$('#'+ary[4]).val(isNaN(total4)?'':total4.toFixed(2));
			$('#'+ary[7]).val(isNaN(total7)?'':total7.toFixed(2));
			$('#'+ary[8]).val(isNaN(total8)?'':total8.toFixed(2));
			$('#'+ary[9]).val(isNaN(total9)?'':total9.toFixed(2));
			$('#'+ary[10]).val(isNaN(total10)?'':total10.toFixed(2));
			$('#'+ary[13]).val(isNaN(total13)?'':total13.toFixed(2));
			$('#'+ary[14]).val(isNaN(total14)?'':total14.toFixed(2));
			$('#'+ary[15]).val(isNaN(total15)?'':total15.toFixed(2));
			$('#'+ary[16]).val(isNaN(total16)?'':total16.toFixed(2));
			$('#'+ary[19]).val(isNaN(total19)?'':total19.toFixed(2));
			
			
			var total11 = parseFloat($('#'+ary[11]).val());		
			var total12 = parseFloat($('#'+ary[12]).val());
			czbkNum += parseFloat(isNaN(total11)?0.0:total11);//财政拨款
			qtzjNum += parseFloat(isNaN(total12)?0.0:total12);//其他资金
			nkzjzeNum += (czbkNum+qtzjNum);//年度资金总额
			
	   });
		
		//修改绩效目标数据
		$('#pro_goal_nkzjze').textbox('setValue',nkzjzeNum.toFixed(2));
		$('#pro_goal_czbk').textbox('setValue',czbkNum.toFixed(2));
		$('#pro_goal_qtzj').textbox('setValue',qtzjNum.toFixed(2));
	}
	
	var autoTotalPlanOld="";
	function autoTotalPlan(obj) {
		var patt = /^[0-9]*(\.){0,1}[0-9]{0,2}$/;//判断小数的正则表达式
		//字符校验
		if(patt.test(obj.value)){
			autoTotalPlanOld = obj.value;
		} else {
			obj.value = autoTotalPlanOld;
		}
/* 		var ary = [];
		$(this).children('td').each(function(j){  // 遍历 tr 的各个 td
			$(this).children('input').each(function(k){
				ary.push($(this).attr('id'));
			});
      	}); */
	}
	
	var autoPlanYearOld="";
	function autoPlanYear(obj){
		//var patt1 = /^\d{4}$/;//判断4位正整数
		var patt = /^[0-9]*$/;//判断数字
		//字符校验
		if(patt.test(obj.value) && obj.value.length<5){
			autoPlanYearOld = obj.value;
		} else {
			obj.value = autoPlanYearOld;
		}
	}
	</script>
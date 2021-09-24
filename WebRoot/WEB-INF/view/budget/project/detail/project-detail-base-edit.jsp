<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="easyui-accordion" data-options="" style="width:922px;margin-left: 20px">
	<div title="项目基本信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
		<table cellpadding="0" cellspacing="0">
			<tr class="trbody">
		   		<td class="td1-ys"><span class="style_must">*</span>&nbsp;项目编号</td>
		     	<td colspan="4">
		     		<input id="project_add_FProCode" class="easyui-textbox" data-options="required:false" readonly="readonly" 
		     		style="height:30px;width:450px" name="FProCode" value="${bean.FProCode}"/>
		     		<!-- 项目id -->
					<input type="hidden" id="F_fProId" name="FProId" value="${bean.FProId }"/>
					<!-- 预算支出类型 -->
					<input type="hidden" id="project_add_FProOrBasic" onchange="FProOrBasicChange(${bean.FProOrBasic})" name="FProOrBasic" value="${bean.FProOrBasic}"/>
		     	</td>
		   	</tr>
		   	
			<tr class="trbody">
		   		<td class="td1-ys"><span class="style_must">*</span>&nbsp;项目名称</td>
		     	<td colspan="4">
		     		<input id="project_add_FProName" name="FProName" class="easyui-textbox" style="width:450px"
		     		<c:if test="${operation !='review'}">
			     		readonly="readonly"
			     	</c:if>  value="<c:out value="${bean.FProName}"></c:out>" >
		     	</td>
		   	</tr>
		   	
		   	 <tr id="radiofupdate" class="trbody">
				<td class="td1" style="width: 80px;"><span class="style1">*</span>结转理由</td>
				<td colspan="3" class="td2" >
					<textarea name="reason"  id="reason" class="textbox-text"
							oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
							style="width:445px;height:70px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:8px; margin-bottom:0px;">${bean.reason }</textarea>
				</td>
			</tr> 
		</table>
	</div>
</div>
<script type="text/javascript">
function onChangeCgjeInput(){
	var sfcg = 	$('input:radio[name="FProcurementYn"]:checked').val();
	/* if(sfcg==0){
		$('#th_cgje').hide();
		$('#td_cgje').hide();
	}else if(sfcg==1){
		$('#th_cgje').show();
		$('#td_cgje').show();
	} */
}
/* function onChangeSfcxxxm(){
	var sfcx = $('input:radio[name="FContinuousYn"]:checked').val();
	if(sfcx==0){
		$('#pro_add_FProRollingCycle').numberbox('setValue','1');
	}else if(sfcx==1){
		$('#pro_add_FProRollingCycle').numberbox('setValue','');
	}
} */


//设置附件信息
function setAccoFile(){
	var s="";
	$(".fileUrl1").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files1").val(s);
}
function setPlanFile(){
	var s="";
	$(".fileUrl2").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files2").val(s);
}
function FProOrBasicChange(newValue,oldValue){
	//隐藏立项依据和项目实施方案
	if(newValue==1){
	//项目支出
		$('.FProAccording').show();
		$('.FExplain').show();
		$('#project_firstLevel').show();
		$('#project_secondLevel').show();
	}
	//重新请求工作流数据
	$("#check_system_div").load("${base}/project/refreshProcess?proOrBasic="+newValue);
}

/* //滚动周期变化
function gdzq(newValue, oldValue) {
	if(newValue>99){
		return;
	}
	$('.gdzqTr').each(function(i){
		if(newValue>=1){
			$(this).remove();
		}
	});
	
	var y = $('#pro_add_planStartYear').textbox('getValue');//开始执行年份
	
	for(var i=0;i<newValue;i++) {
		var n=i+1;
		var year = parseInt(y)+i;
		
		$('#pro_plan_table').append('<tr class="gdzqTr">'+
		'<td><span style="width: 30px;display: block;text-align: center;">'+n+'</span></td>'+
		'<td><input class="pro_plan_input" id="plan2_'+i+'" name="planList['+i+'].year" value="'+year+'"/></td>'+
		'<td><input class="pro_plan_input" id="plan3_'+i+'" name="planList['+i+'].totalPlan"/></td>'+
		'<td><input class="pro_plan_input" id="plan5_'+i+'" name="planList['+i+'].earlyAmount1" oninput="autoCaculate(this)"/></td>'+
		'<td><input class="pro_plan_input" id="plan6_'+i+'" name="planList['+i+'].earlyAmount2" oninput="autoCaculate(this)"/></td>'+
		'<td><input class="pro_plan_input" id="plan4_'+i+'" name="planList['+i+'].earlyTotal" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>'+
		'<td><input class="pro_plan_input" id="plan8_'+i+'" name="planList['+i+'].adjustAmount1" oninput="autoCaculate(this)"/></td>'+
		'<td><input class="pro_plan_input" id="plan9_'+i+'" name="planList['+i+'].adjustAmount2" oninput="autoCaculate(this)"/></td>'+
		'<td><input class="pro_plan_input" id="plan7_'+i+'" name="planList['+i+'].adjustTotal" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>'+
		'<td><input class="pro_plan_input" id="plan11_'+i+'" name="planList['+i+'].yearAmount1" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>'+
		'<td><input class="pro_plan_input" id="plan12_'+i+'" name="planList['+i+'].yearAmount2" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>'+
		'<td><input class="pro_plan_input" id="plan10_'+i+'" name="planList['+i+'].yearTotal" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>'+
		'<td><input class="pro_plan_input" id="plan14_'+i+'" name="planList['+i+'].outAmount1" oninput="autoCaculate(this)"/></td>'+
		'<td><input class="pro_plan_input" id="plan15_'+i+'" name="planList['+i+'].outAmount2" oninput="autoCaculate(this)"/></td>'+
		'<td><input class="pro_plan_input" id="plan13_'+i+'" name="planList['+i+'].outTotal" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>'+
		'<td><input class="pro_plan_input" id="plan17_'+i+'" name="planList['+i+'].leastAmount1" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>'+
		'<td><input class="pro_plan_input" id="plan18_'+i+'" name="planList['+i+'].leastAmount2" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>'+
		'<td><input class="pro_plan_input" id="plan16_'+i+'" name="planList['+i+'].leastTotal" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td>'+
		'<td><input class="pro_plan_input" id="plan20_'+i+'" name="planList['+i+'].actualAmount1" oninput="autoCaculate(this)"/></td>'+
		'<td><input class="pro_plan_input" id="plan21_'+i+'" name="planList['+i+'].actualAmount2" oninput="autoCaculate(this)"/></td>'+
		'<td><input class="pro_plan_input" id="plan19_'+i+'" name="planList['+i+'].actualTotal" readonly="readonly" oninput="autoCaculate(this)" placeholder="&lt;自动计算 &gt;"/></td></tr>'
		);
	}
	
} */

//项目预算金额
$('#pro_add_FProBudgetAmount').numberbox({
	onChange:function(newValue,oldValue){
		$('#pro_add_UP_FProBudgetAmount').html(convertCurrency(newValue));
	}
});
$(function(){ 
	$("#pro_add_FProBudgetAmount").textbox('setValue',${bean.FProBudgetAmount});
	$('#pro_add_UP_FProBudgetAmount').html(convertCurrency(${bean.FProBudgetAmount}));
			var proOrBasic = '${bean.FProOrBasic}';
		   	if(proOrBasic==0){
		   	//基本支出
		   		$('.FProAccording').hide();
		   		$('.FExplain').hide();
		   		//$('#fProAccordingId').removeAttr('required');
		   		$('#project_add_FProOrBasic_show').val('基本支出');
		   	}else if(proOrBasic==1){
		   	//项目支出
		   		$('.FProAccording').show();
		   		$('.FExplain').show();
		   		$('#project_add_FProOrBasic_show').val('项目支出');
		   	}
});

//存入json
function getPerformanceJson(){
}
</script>
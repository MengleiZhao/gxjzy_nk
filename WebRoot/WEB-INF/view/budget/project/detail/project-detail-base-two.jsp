<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="easyui-accordion" data-options="" style="width:922px;margin-left: 20px">
	<div title="基本支出信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
		<table cellpadding="0" cellspacing="0">
			<tr class="trbody">
		   		<td class="td1-ys"><span class="style_must">*</span>&nbsp;基本支出编号</td>
		     	<td class="td2"  colspan="5">
		     		<input class="easyui-textbox" data-options="required:false" readonly="readonly" style="height:30px;width:750px" value="${bean.FProCode}" />
		     	</td>
		   	</tr>
   			<tr class="trbody">
				<td class="td1-ys"><span class="style_must">*</span>&nbsp;申报部门</td>
     			<td class="td2">
     				<input class="easyui-textbox" data-options="required:false" style="height:30px; width: 300px" readonly="readonly" value="${sbbm}" />
     			</td>
     			<td class="td3-ys" style="width: 35px;"></td>
				<td class="td1-ys"><span class="style_must">*</span>&nbsp;申报人</td>
   				<td class="td2">
   					<input class="easyui-textbox" data-options="required:false" style="height:30px; width: 300px" readonly="readonly" value="${sbr}" />
   				</td>
			</tr>
			
   			<tr class="trbody">
   				<td class="td1-ys"><span class="style_must">*</span>&nbsp;负责人</td>
   				<td class="td2">
   					<input class="easyui-textbox" data-options="required:true" style="height:30px; width: 300px" value="${bean.FProHead}" />
   				</td>
   				<td class="td3-ys"></td>
   				<td class="td1-ys"><span class="style_must">*</span>&nbsp;项目类别名称</td>
   				<td class="td2">
		     		<input class="easyui-combobox" style="height:30px; width: 300px" required="true" readonly="readonly" data-options="editable:false,url:'${base}/Formulation/lookupsJson?parentCode=PRO-TYPE&selected=${bean.FProClass}',method:'POST',valueField:'code',textField:'text'"/>
   				</td>
   			</tr>
			<tr class="trbody">
		   		<td class="td1-ys">&nbsp;项目名称</td>
		     	<td class="td2" colspan="5">
		     		<input class="easyui-textbox" data-options="required:true" style="height:30px; width:750px" value="${bean.FProName}" >
		     	</td>
		   	</tr>
		   	
		    <tr class="trbody">
		    	<td class="td1-ys"><span class="style_must">*</span>&nbsp;预算支出类型</td>
		     	<td class="td2">
		     		<input class="easyui-textbox" readonly="readonly" value="基本支出" style="height:30px; width: 300px" >
		     	</td>
		     	<td class="td3-ys"></td>
		    	<td class="td1-ys"><span class="style_must">*</span>&nbsp;计划开始执行年份</td>
		     	<td class="td2">
		     		<input class="easyui-numberbox" style="height:30px;width: 300px" data-options="validType:'length[4,4]'" readonly="readonly" value="${bean.planStartYear}"/>
		     	</td>
		    </tr>
			
			<!-- 基本支出 -->
			<tr class="trbody" id="base_secondLevel" >
				<td class="td1-ys">&nbsp;是否政府采购</td>
				<td class="td2">
		     		<input type="radio" value="1" disabled="disabled" name="fprocurementStatus" <c:if test="${bean.fprocurementStatus=='1'}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;是
					&nbsp;&nbsp;
					<input type="radio" value="0" disabled="disabled" name="fprocurementStatus" <c:if test="${bean.fprocurementStatus=='0'||bean.fprocurementStatus==''}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;否
				</td> 
		     	<td class="td3-ys"></td>
				<td class="td1-ys"></td>
		     	<td class="td2" hidden="hidden">     			 	
		     		<!-- 项目预算金额 -->
		     		<input class="easyui-numberbox" style="height:30px;width: 300px" data-options="" readonly="readonly" value="${bean.FProBudgetAmount}"/>
		     	</td>
			</tr>
		</table>
	</div>
	
	<div id="zijinlaiyuan" title="资金来源" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
		<table cellpadding="0" cellspacing="0" >
			<tr class="trbody">
		    	<td class="td1-ys" style="padding-top: 0px" colspan="6">
		    		<%@ include file="project-detail-fundssource.jsp" %>
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
	if(newValue==0){
	//基本支出
		$('#base_firstLevel').show();
		$('#base_secondLevel').show();
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
</script>
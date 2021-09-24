<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="easyui-accordion" data-options="" style="width:990px;margin-left: 20px">
	<div title="项目基本信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
		<table cellpadding="0" cellspacing="0">
		    <c:if test="${operation!='add'}">
				<tr class="trbody">
			   		<td class="td1-ys"><span class="style_must">*</span>&nbsp;项目编号</td>
			     	<td class="td2"  colspan="4">
			     		<input id="project_add_FProCode" class="easyui-textbox" readonly="readonly" 
			     		style="height:30px;width:750px" name="FProCode" value="${bean.FProCode}" />
			     	</td>
			   	</tr>
		   	</c:if>
 			<tr class="trbody">
				<td class="td1-ys"><span class="style_must">*</span>&nbsp;申报部门</td>
     			<td class="td2">
     				<input class="easyui-textbox" data-options="required:false" style="height:30px; width: 300px" readonly="readonly" 
     				id="project-add-FProAppliDepart" name="FProAppliDepart" value="${sbbm}" />
     			</td>
     			<td class="td3-ys" style="width: 35px;"></td>
				<td class="td1-ys"><span class="style_must">*</span>&nbsp;申报人</td>
   				<td class="td2">
   					<input class="easyui-textbox" data-options="required:false" style="height:30px; width: 300px" readonly="readonly"
     				id="project-add-FProAppliPeople" name="FProAppliPeople" value="${sbr}" />
   				</td>
			</tr>
			
   			<tr class="trbody">
   				<td class="td1-ys"><span class="style_must">*</span>&nbsp;负责人</td>
   				<td class="td2">
	   				<a onclick="chooseFProHead()">
	   					<input class="easyui-textbox" data-options="prompt:'单击选择负责人',required:true" style="height:30px; width: 300px" 
	     				id="project-add-FProHead" name="FProHead" value="${bean.FProHead}" />
	   				</a>
   				</td>
   				<td class="td3-ys"></td>
   				<td class="td1-ys">&nbsp;&nbsp;负责人电话</td>
   				<td class="td2">
   					<input class="easyui-textbox" data-options="required:false" style="height:30px; width: 300px"
   					id="pro_add_headerPhone" name="headerPhone" value="${bean.headerPhone}"/>
   				</td>
   			</tr>
			<tr class="trbody">
		   		<td class="td1-ys"><span class="style_must">*</span>&nbsp;项目名称</td>
		     	<td class="td2" colspan="4">
		     		<input id="project_add_FProName" name="FProName" class="easyui-textbox" style="height:30px; width:750px" 
		     		data-options="validType:'length[1,50]'" prompt="请输入项目名称"  value="<c:out value="${bean.FProName}"></c:out>" >
		     		<!-- 一级分类名 -->
		     		<input type="hidden" id="add_FirstLevelName" name="firstLevelName" <c:if test="${bean.FProOrBasic==0}"> value="经常性支出项目" </c:if>/>
		     		<!-- 二级分类名 -->
		     		<input type="hidden" id="add_secondLevelName" name="secondLevelName" value="${bean.secondLevelName}"/>
					<!-- 项目id -->
					<input type="hidden" id="F_fProId" name="FProId" value="${bean.FProId}"/>
					<!-- 数据状态 -->
					<input type="hidden" id="F_Stauts" name="FStauts" value="${bean.FStauts}"/>
					<!-- 审批状态 -->
					<input type="hidden" id="F_FFlowStauts" name="FFlowStauts" value="${bean.FFlowStauts}"/>
					<!-- 项目预算周期 -->
					<input type="hidden"  name="FProBudgetCycle" value="1"/>
					<!-- 预算支出类型 -->
					<input type="hidden" id="project_add_FProOrBasic" onchange="FProOrBasicChange(${bean.FProOrBasic})" name="FProOrBasic" value="${bean.FProOrBasic}"/>
		     		<!-- 项目预算金额 -->
		     		<input type="hidden" id="pro_add_FProBudgetAmount" name="FProBudgetAmount" value="${bean.FProBudgetAmount}"/>
		     		<!-- 政府采购金额 -->
		     		<input type="hidden" id="pro_add_governmentPurAmount"  name="governmentPurAmount" value="${bean.governmentPurAmount}"/>
		     		<!-- 政府软件采购金额 -->
		     		<input type="hidden" id="pro_add_governmentSEPurAmount"  name="governmentSEPurAmount" value="${bean.governmentSEPurAmount}"/>
		     		<!-- 项目负责人id -->
		     		<input hidden="hidden" id="pro_add_FProHeadId"  name="FProHeadId" value="${bean.FProHeadId}"/>
		     	</td>
		   	</tr>
		   	
		    <tr class="trbody">
		    	<td class="td1-ys"><span class="style_must">*</span>&nbsp;预算支出类型</td>
		     	<td class="td2">
		     		<input class="easyui-textbox" id="project_add_FProOrBasic_show" readonly="readonly"  style="height:30px; width: 300px" >
		     	</td>
				<td class="td3-ys bigPro"></td>
     			<td class="td1-ys bigPro"><span class="style_must">*</span>所属大项目名称</td>
     			<td class="td2 bigPro">
     				<input class="easyui-textbox" style="height:30px; width: 300px" id="bigProName" name="bigProName" value="${bean.bigProName}" readonly="readonly"/>
     			</td>
		    </tr>
		    
		    <!-- 项目支出 -->
			<tr class="trbody" id="project_firstLevel" hidden="hidden">
				<td class="td1-ys"><span class="style_must">*</span>&nbsp;一类名称</td>
		     	<td class="td2">
		     		<input id="project_add_firstLevel"  class="easyui-combobox" style="height:30px;width: 300px" required="true"
		     		data-options="url:'${base}/project/getSubject1?selected=${bean.firstLevelCode}',method:'get',valueField:'code',textField:'text',editable:false,validType:'selectValid',
					    onSelect: function(rec){
				        	//设置名称值
					    	$('#add_FirstLevelName').val(rec.text);
					    	//设置显示值
					    	$('#project_yjxmdm').textbox('setValue',rec.code);
						    var url = '${base}/project/getSubject2?selected=${bean.secondLevelCode}&parentCode='+rec.code;
						    $('#project_add_secondLevel').combobox('reload', url);
					    }"/>
		     	</td>
				<td class="td3-ys"></td>
				<td class="td1-ys"><span class="style_must">*</span>&nbsp;一类代码</td>
				<td class="td2">
		     		<input class="easyui-textbox" id="project_yjxmdm" name="firstLevelCode" readonly="readonly" style="height:30px; width: 300px" value="${bean.firstLevelCode}"/>
		     	</td>
			</tr>
			
			<!-- 项目支出 -->
			<tr class="trbody" id="project_secondLevel" hidden="hidden">
				<td class="td1-ys"><span class="style_must">*</span>&nbsp;二类名称</td>
		     	<td class="td2">
		     		<input id="project_add_secondLevel" 
		     		class="easyui-combobox" style="height:30px; width: 300px" required="true"
		     		data-options="url:'${base}/project/getSubject2?selected=${bean.secondLevelCode}&parentCode=${bean.firstLevelCode}',method:'get',valueField:'code',textField:'text',editable:false,validType:'selectValid', 
		     		onSelect:function(item){
		     			// 注意：在修改该处地方时，如要增加二级分类，必须注意一二级项目分类，字典表中项目类型和资金来源字段的关系，不然容易出现问题。资金来源的请求方法和二级
		     			// 分类的请求方法不一致，但是显示的名称却相同，需要注意值同步,有可能需要两边字段同时添加 
			     		var tabdata = $('#fundssource').datagrid('getData');
			     		var Rows = $('#fundssource').datagrid('getRows');
			     		selectCode = item.code;
			     		selectVal = item.text;
			     		if(4001 == selectCode){
			     			selectCode = 0;
			     			selectVal = '财政拨款收入';
			     		}else if(4002 == selectCode){
			     			selectCode = 4;
			     			selectVal = '其它收入';
			     		}else if(4003 == selectCode){
			     			selectCode = 1;
			     			selectVal = '教育事业收入';
			     		}
			     		for (var i = 0; i < Rows.length; i++) {
				     		$('#fundssource').datagrid('updateRow',{
					     		index:i,
					     		row: {fundsSource:selectCode,fundsSourceText:selectVal}
				     		});
						}
		     		},
		     	"/>
		     	</td>
		     	<td class="td3-ys"></td>
				<td class="td1-ys"><span class="style_must">*</span>&nbsp;二类代码</td>
				<td class="td2">
		     		<input class="easyui-textbox" style="height:30px; width: 300px" data-options="validType:'length[1,50]'"
		   			id="project_ejxmdm" name="secondLevelCode" readonly="readonly"  value="${bean.secondLevelCode}"/>
		     	</td> 
			</tr>
			
		    <tr class="trbody">
		    	<td class="td1-ys"><span class="style_must">*</span>&nbsp;计划开始执行年份</td>
		     	<td class="td2">
		     		<input class="easyui-numberbox" style="height:30px;width: 300px" data-options="validType:'length[4,4]'" 
     				id="pro_add_planStartYear" required="required" name="planStartYear" value="${bean.planStartYear}"/>
		     	</td>
		     	<td class="td3-ys"></td>
		     	<td class="td1-ys">&nbsp;&nbsp;项目使用类型</td>
     			<td class="td2">
					<input class="easyui-combobox" id="proUseType" name="proUseType" style="width: 300px;height: 30px;" data-options="editable:false,url:'${base}/Formulation/lookupsJson?parentCode=YSSYLX&selected=${bean.proUseType}',method:'POST',valueField:'code',textField:'text'">
     			</td>
		    </tr>
			<tr class="trbody" >
				<td class="td1-ys">是否为科研项目</td>
				<td class="td2">
		     		<input type="radio" value="1" name="ifScientificPro" onclick="onclickIfScientificPro1()" id="ifScientificProBox1" <c:if test="${bean.ifScientificPro=='1'}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;是
					&nbsp;&nbsp;
					<input type="radio" value="0" name="ifScientificPro" onclick="onclickIfScientificPro2()" id="ifScientificProBox2" <c:if test="${bean.ifScientificPro=='0'||bean.ifScientificPro==''||empty bean.ifScientificPro}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;否
				</td> 
		     	<td class="td3-ys"></td>
				<td class="td1-ys"></td>
		     	<td class="td2" ></td>
			</tr>
			<tr class="trbody" id="ifScientificProId" hidden="hidden">
				<td class="td1-ys">科研项目信息</td>
				<td class="td2" colspan="4">
		     		<input class="easyui-textbox" style="height:30px;width:750px" data-options="validType:'length[1,200]',editable:false,icons:[{iconCls:'icon-add',handler: function(e){
					     selectScientificProName();
					     }}]" id="scientificProName" name="scientificProName" value="${bean.scientificProName}"/>
     				
					<input type="hidden" id="scientificProId" name="scientificProId" value="${bean.scientificProId}"/>
				</td> 
			</tr>
			<tr class="trbody" >
				<td class="td1-ys">&nbsp;是否政府采购</td>
				<td class="td2">
		     		<input type="radio" value="1" name="fprocurementStatus" onclick="$('#zhengfuProId').css('display','');$('#fprocurementStatusShowOrHideId').show();" id="box1" <c:if test="${bean.fprocurementStatus=='1'}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;是
					&nbsp;&nbsp;
					<input type="radio" value="0" name="fprocurementStatus" onclick="$('#zhengfuProId').css('display','none');$('#zhengfuProSEId').css('display','none');$('#fprocurementStatusShowOrHideId').hide();$('#fprocurementStatusId1').val('');" id="box2" <c:if test="${bean.fprocurementStatus=='0'||bean.fprocurementStatus==''||empty bean.fprocurementStatus}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;否
				</td> 
		     	<td class="td3-ys"></td>
				<td class="td1-ys"></td>
		     	<td class="td2" hidden="hidden">     			 	
		     		<!-- 项目预算金额 -->
		     		<input class="easyui-numberbox" style="height:30px;width: 300px" data-options="" readonly="readonly"
     				id="pro_add_FProBudgetAmount" required="required"  value="${bean.FProBudgetAmount}"/>
		     	
		     	</td>
			</tr>
			<tr class="trbody" id="fprocurementStatusShowOrHideId" hidden="hidden" >
				<td style="width: 100px; text-align: left; padding-right: 8px;" colspan="5">政府采购是否涉及信息网络及软件购置更新&nbsp;&nbsp;
		     		<input type="radio" value="1" name="ifInvolveNetworkSoftware" onclick="$('#zhengfuProSEId').css('display','');" id="ifInvolveNetworkSoftwareId1" <c:if test="${bean.ifInvolveNetworkSoftware=='1'}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;是
					&nbsp;&nbsp;
					<input type="radio" value="0" name="ifInvolveNetworkSoftware" onclick="$('#zhengfuProSEId').css('display','none');" id="ifInvolveNetworkSoftware2" <c:if test="${bean.ifInvolveNetworkSoftware=='0'||bean.ifInvolveNetworkSoftware==''||empty bean.ifInvolveNetworkSoftware}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;否
				</td>
			</tr>
		</table>
	</div>
	
	<div title="资金来源" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
		<table cellpadding="0" cellspacing="0" >
			<tr class="trbody">
		    	<td class="td1-ys" style="padding-top: 0px" colspan="6">
		    		<%@ include file="project-add-fundssource.jsp" %>
				</td>
		    </tr>
		</table>
	</div>

</div>
<script type="text/javascript">
var n =0;
var loadcount =0;
/* $('#project_add_firstLevel').combobox({
    onChange:function(newValue,oldValue){
    	if(newValue!=null||newValue!=''){
    		$("#project_add_secondLevel").combobox({disabled:false});
		}
    	if(newValue==null||newValue==''){
    		$("#project_add_secondLevel").combobox({disabled:true});
		}
    	//设置名称值
    	$('#add_FirstLevelName').val($('#project_add_firstLevel').combobox('getText'));
    	//设置显示值
    	$('#project_yjxmdm').textbox('setValue',$('#project_add_firstLevel').combobox('getValue'));
       //重置二级分类选择
       $('#project_add_secondLevel').combobox('reload','${base}/project/getSubject2?parentCode='+newValue);
        
    }
}); */
function FProOrBasicChange(newValue,oldValue){
	if(newValue==1){
	//项目支出
		$('.FProAccording').show();
		$('.FExplain').show();
		$('#base_firstLevel').hide();
		$('#project_firstLevel').show();
		$('#base_secondLevel').hide();
		$('#project_secondLevel').show();
	}
	//重新请求工作流数据
	$("#check_system_div").load("${base}/project/refreshProcess?proOrBasic="+newValue);
}

$('#pro_add_departid').combobox({
    onChange:function(newValue,oldValue){
    	var FProOrBasic = $('#project_add_FProOrBasic').val();
		//重新请求工作流数据
	//	$("#check_system_div").load("${base}/project/refreshProcess?proOrBasic="+FProOrBasic+'&FProAppliDepartId='+newValue);
        
    }
});

$('#project_add_secondLevel').combobox({
    onChange:function(newValue,oldValue){
    	//设置二级分类名称
    	$('#add_secondLevelName').val($('#project_add_secondLevel').combobox('getText'));
    	//设置显示值
    	$('#project_ejxmdm').textbox('setValue',$('#project_add_secondLevel').combobox('getValue'));
    }
});

//基本支出的二级分类选择
$('#project_add_base_secondLevel').combobox({
    onChange:function(newValue,oldValue){
    	//设置二级分类名称
    	$('#add_secondLevelName').val($('#project_add_base_secondLevel').combobox('getText'));
    	//设置显示值
    	$('#project_base_ejxmdm').textbox('setValue',$('#project_add_base_secondLevel').combobox('getValue'));
    }
});


//项目预算金额
$('#pro_add_FProBudgetAmount').numberbox({
	onChange:function(newValue,oldValue){
		$('#pro_add_UP_FProBudgetAmount').html(convertCurrency(newValue));
	}
});
		
$(function(){ 
	$("#pro_add_FProBudgetAmount").textbox('setValue',${bean.FProBudgetAmount});
	var value=$("#pro_add_FProBudgetAmount").val();
	$('#pro_add_UP_FProBudgetAmount').html(convertCurrency(value));
			var proOrBasic = '${bean.FProOrBasic}';
		   	if(proOrBasic==1){
		   	//项目支出
		   		$('.FProAccording').show();
		   		$('.FExplain').show();
	    		$('#project_firstLevel').show();
	    		$('#project_secondLevel').show();
	    		$('#project-add-performance').show();
	    		$('#project_add_FProOrBasic_show').val('项目支出');
		   	}
		   	
	var operation = '${operation}';
	if(operation!='add'){
		var fprocurementStatus = '${bean.fprocurementStatus}';
		if(fprocurementStatus=='1'){
			$('#zhengfuProId').css('display','');
			$('#fprocurementStatusShowOrHideId').show();
		}else{
			$('#zhengfuProId').css('display','none');
			$('#zhengfuProSEId').css('display','none');
			$('#fprocurementStatusId1').val('');
			$('#fprocurementStatusShowOrHideId').hide();
		}
		var ifInvolveNetworkSoftware = '${bean.ifInvolveNetworkSoftware}';
		if(ifInvolveNetworkSoftware=='1'){
			$('#zhengfuProSEId').css('display','');
		}else{
			$('#zhengfuProSEId').css('display','none');
		}
		//科研项目显示1为是科研项目其他的都不显示
		var ifScientificPro = '${bean.ifScientificPro}';
		if(ifScientificPro=='1'){
			$('#ifScientificProId').show();
			$('.bigPro').show();
		}else{
			$('#ifScientificProId').hide();
			$('.bigPro').hide();
		}
	}else{
		//科研项目显示1为是科研项目其他的都不显示
		var ifScientificPro = '${bean.ifScientificPro}';
		if(ifScientificPro=='1'){
			$('#ifScientificProId').show();
			$('.bigPro').show();
		}else{
			$('#ifScientificProId').hide();
			$('.bigPro').hide();
		}
	}
});
		
//开始执行年份
$("#pro_add_planStartYear").numberbox({
	onChange:function(){
		var planStartYear = $("#pro_add_planStartYear").val();
		if(planStartYear==''){
			return false;
		}
		//下一年度
		var nextYear = new Date().getFullYear()+1;
		if(planStartYear < nextYear-1){
			alert("开始执行年份不得小于当前年度, 请重新输入！");
			$("#pro_add_planStartYear").numberbox('setValue', nextYear);
		}
	}
});

//选择项目负责人
function chooseFProHead(){
	var win=creatSecondWin('选择负责人', 500,550, 'icon-search', '/project/chooseFProHead');
	win.window('open');
}

function selectScientificProName(){
	var proAppliPeople = $("#project-add-FProAppliPeople").textbox('getValue');
	var win = creatFirstWin('选择-科研项目', 1140, 580, 'icon-search', '/researchProjects/skipScientificPro?userName='+proAppliPeople);
	win.window('open');

}

function onclickIfScientificPro1(){
	$('#ifScientificProId').show();
	$('#bigProName').textbox('setValue','科研经费');
		$('.bigPro').show();
}
function onclickIfScientificPro2(){
	$('#ifScientificProId').hide();
		$('.bigPro').hide();
	$('#scientificProId').val('');
	$('#scientificProName').textbox('setValue','')
	$('#bigProName').textbox('setValue','');
}
</script>
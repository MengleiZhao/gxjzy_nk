<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="easyui-accordion" data-options="" style="width:922px;margin-left: 20px">
	<div title="基本支出信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
		<table cellpadding="0" cellspacing="0">
		    <c:if test="${operation!='add'}">
			<tr class="trbody">
		   		<td class="td1-ys"><span class="style_must">*</span>&nbsp;基本支出编号</td>
		     	<td class="td2"  colspan="5">
		     		<input id="project_add_FProCode" class="easyui-textbox" data-options="required:false" readonly="readonly" 
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
   					<input class="easyui-textbox" data-options="required:true" style="height:30px; width: 300px" 
     				id="project-add-FProHead" name="FProHead" value="${bean.FProHead}" />
   				</td>
   				<td class="td3-ys"></td>
   				<td class="td1-ys"><span class="style_must">*</span>&nbsp;项目类别名称</td>
   				<td class="td2">
		     		<input class="easyui-combobox" style="height:30px; width: 300px" required="true" name="FProClass" <c:if test="${bean.FProAppliDepartId!='13'}"> readonly="readonly"</c:if> data-options="editable:false,url:'${base}/Formulation/lookupsJson?parentCode=PRO-TYPE<c:if test="${bean.FProAppliDepartId=='13'}">&selected=${bean.FProClass}</c:if><c:if test="${bean.FProAppliDepartId!='13'}">&selected=PRO-TYPE-01</c:if>',method:'POST',valueField:'code',textField:'text'"/>
   				</td>
   			</tr>
			<tr class="trbody">
		   		<td class="td1-ys">&nbsp;项目名称</td>
		     	<td class="td2" colspan="5">
		     		<input id="project_add_FProName" name="FProName" class="easyui-textbox" data-options="required:true" style="height:30px; width:750px" value="${bean.FProName}" >
		     	</td>
		   	</tr>
		   	
		    <tr class="trbody">
		    	<td class="td1-ys"><span class="style_must">*</span>&nbsp;预算支出类型</td>
		     	<td class="td2">
		     		<input class="easyui-textbox" id="project_add_FProOrBasic_show" readonly="readonly" value="基本支出" style="height:30px; width: 300px" >
		     	</td>
		     	<td class="td3-ys"></td>
		    	<td class="td1-ys"><span class="style_must">*</span>&nbsp;计划开始执行年份</td>
		     	<td class="td2">
		     		<input class="easyui-numberbox" style="height:30px;width: 300px" data-options="validType:'length[4,4]'" 
     				id="pro_add_planStartYear" required="required" name="planStartYear" value="${bean.planStartYear}"/>
		     	</td>
		    </tr>
			
			<!-- 基本支出 -->
			<tr class="trbody" id="base_secondLevel" >
				<td class="td1-ys">&nbsp;是否政府采购</td>
				<td class="td2">
		     		<input type="radio" value="1" name="fprocurementStatus" onclick="$('#zhengfuId').css('display','');$.parser.parse('#mingxiId');$('#pro_purchase_tab_id').datagrid('reload');" id="box1" <c:if test="${bean.fprocurementStatus=='1'}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;是
					&nbsp;&nbsp;
					<input type="radio" value="0" name="fprocurementStatus" onclick="$('#zhengfuId').css('display','none');" id="box2" <c:if test="${bean.fprocurementStatus=='0'||bean.fprocurementStatus==''||empty bean.fprocurementStatus}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;否
				</td> 
		     	<td class="td3-ys"></td>
				<td class="td1-ys"></td>
		     	<td class="td2" hidden="hidden">     			 	
		     		<!-- 项目预算金额 -->
		     		<input class="easyui-numberbox" style="height:30px;width: 300px" data-options="" readonly="readonly"
     				id="pro_add_FProBudgetAmount" required="required" name="FProBudgetAmount" value="${bean.FProBudgetAmount}"/>
		     	
		     	</td>
			</tr>
		</table>
	</div>
	
	<div id="zijinlaiyuan" title="资金来源" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
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
var w =0;
$('#project_add_firstLevel').combobox({
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
});

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

$('#pro_add_departid').combobox({
    onChange:function(newValue,oldValue){
    	var FProOrBasic = $('#project_add_FProOrBasic').val();
		//重新请求工作流数据
		//$("#check_system_div").load("${base}/project/refreshProcess?proOrBasic="+FProOrBasic+'&FProAppliDepartId='+newValue);
	    $('#project_add_base_secondLevel').combobox('reload', '${base}/project/getJbzcSubject2?selected=${bean.secondLevelCode}&departId='+newValue);
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
    	var text=$('#project_add_base_secondLevel').combobox('getText');
    	if( text =='--请选择--'){
    		text='';
 		}
    	$('#project_add_FProName').textbox('setValue',text);
    }
});


//项目预算金额
$('#pro_add_FProBudgetAmount').numberbox({
	onChange:function(newValue,oldValue){
		$('#pro_add_FProBudgetAmount_show').html(newValue);
		$('#pro_add_UP_FProBudgetAmount').html(convertCurrency(newValue));
	}
});

//显示详细信息手风琴页面
$(document).ready(function(){
	$("#pro_add_FProBudgetAmount").textbox('setValue',${bean.FProBudgetAmount});
	var value=$("#pro_add_FProBudgetAmount").val();
	$('#pro_add_UP_FProBudgetAmount').html(convertCurrency(value));
			var proOrBasic = '${bean.FProOrBasic}';
		   	if(proOrBasic==0){
		   	//基本支出
	    		$('#base_firstLevel').show();
	    		$('#base_secondLevel').show();
		   	}
});
		
//开始执行年份
$("#pro_add_planStartYear").numberbox({
	onChange:function(newVal,oldVal){
		if(newVal==undefined||oldVal==undefined){
			return false;
		}
		//下一年度
		var nextYear = new Date().getFullYear();
		
		if(newVal < nextYear){
			alert("开始执行年份不得小于当前年度, 请重新输入！");
			$("#pro_add_planStartYear").numberbox('setValue', nextYear+1);
		}
	}
});
//选择项目负责人
function chooseFProHead(){
	var win=creatSecondWin('选择负责人', 500,550, 'icon-search', '/project/chooseFProHead');
	win.window('open');
}
</script>
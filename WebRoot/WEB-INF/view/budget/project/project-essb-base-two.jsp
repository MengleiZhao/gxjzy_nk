<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="easyui-accordion" data-options="" style="width:922px;margin-left: 20px">
	<div title="基本支出信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
		<table cellpadding="0" cellspacing="0">
		    <c:if test="${operation!='add'}">
			<tr class="trbody">
		   		<td class="td1-ys"><span class="style_must">*</span>&nbsp;基本支出编号</td>
		     	<td class="td2"  colspan="4">
		     		<input id="project_add_FProCode" class="easyui-textbox" data-options="required:false" readonly="readonly" 
		     		style="height:30px;width:750px" name="FProCode" value="${bean.FProCode}" />
		     	</td>
		   	</tr>
		   	</c:if>
		   	
			<tr class="trbody">
		   		<td class="td1-ys">&nbsp;基本支出名称</td>
		     	<td class="td2" colspan="4">
		     		<input id="project_add_FProName" name="FProName" class="easyui-textbox" style="height:30px; width:750px"
		     		readonly="readonly"   value="${bean.FProName}" >
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
		     		<input type="hidden" id="pro_add_FProBudgetAmount"  name="FProBudgetAmount" value="${bean.FProBudgetAmount}"/>
		     		<!-- 一下控制数 -->
		     		<input type="hidden" id="pro_add_provideAmount1"  name="provideAmount1" value="${bean.provideAmount1}"/>		     		
		     		<!-- 项目负责人id -->
		     		<input type="hidden" id="pro_add_FProHeadId"  name="FProHeadId" value="${bean.FProHeadId}"/>
		      	</td>
		   	</tr>
		   	
		    <tr class="trbody">
		    	<td class="td1-ys"><span class="style_must">*</span>&nbsp;预算支出类型</td>
		     	<td class="td2">
		     		<input class="easyui-textbox" id="project_add_FProOrBasic_show" readonly="readonly"  style="height:30px; width: 300px" >
		     	</td>
		     	<td class="td3-ys"></td>
		     	<td class="td1-ys"><span class="style_must">*</span>&nbsp;部门</td>
		     	<td class="td2" colspan="2">
		     		<input class="easyui-combobox" style="width: 300px;height: 30px; " readonly="readonly" id="pro_add_departid" name="FProAppliDepartId"   data-options="editable:false,hasDownArrow:false,panelHeight:'auto',url:'${base}/depart/chooseDepart?selected=${bean.FProAppliDepartId}',method:'POST',valueField:'code',textField:'text',editable:false"/>
		     	</td>
		    </tr>
		    
			<!-- 基本支出 -->
			<tr class="trbody" id="base_firstLevel" >
				<td class="td1-ys"><span class="style_must">*</span>&nbsp;所属一级名称</td>
		     	<td class="td2">
		     		<input class="easyui-textbox" id="project_add_twe_firstLevelCode" style="height:30px;width: 300px" readonly="readonly" value="经常性支出项目"/>
		     	</td>
				<td class="td3-ys"></td>
				<td class="td1-ys">&nbsp;所属一级代码</td>
				<td class="td2">
		     		<input class="easyui-textbox" name="firstLevelCode"  readonly="readonly"  style="height:30px; width: 300px" value="XD-01"/>
		     	</td>
			</tr>
			
			<!-- 基本支出 -->
			<tr class="trbody" id="base_secondLevel" >
				<td class="td1-ys"><span class="style_must">*</span>&nbsp;二级名称</td>
		     	<td class="td2">
		     		<input id="project_add_base_secondLevel" 
		     		class="easyui-combobox" style="height:30px; width: 300px" required="true"
		     		data-options="url:'${base}/project/getJbzcSubject2?selected=${bean.secondLevelCode}',method:'get',valueField:'code',textField:'text',editable:false,validType:'selectValid',
		     			onSelect: function(rec){
						    var url = '${base}/project/getSubject2?selected=${bean.secondLevelCode}&blank=XD-01&parentCode='+rec.code;
						    $('#project_add_secondLevel').combobox('reload', url);
	   			     		var tabdata = $('#fundssource').datagrid('getData');
				     		var Rows = $('#fundssource').datagrid('getRows');
				     		var proOrBasic = $('#project_add_FProOrBasic').val();
			     			
				     		selectCode = rec.code;
				     		fEcCode = rec.code;
				     		selectVal = rec.text;
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
							var outTable = document.getElementById('pro_outcome_table'); 
							var trnum = outTable.childNodes[1].children.length;
							w+=1
							if(w>3){
							<!-- 避免修改时前面加载一级指标时就修改后面的数据 ，修改时打开初始一共加载6次-->
								for (var i = 1; i < trnum; i++) {
									outTable.childNodes[1].children[i].children[2].children[2].innerHTML='点击选择经济分类科目';
									outTable.childNodes[1].children[i].children[2].children[1].value='';
									outTable.childNodes[1].children[i].children[2].children[0].value='';
									<!-- outTable.childNodes[1].children[i].children[1].children[0].value=''; -->
								}
								<c:if test="${operation=='add'||operation=='edit'||operation=='verdict'}">
									$('#fundssource').datagrid('cancelEdit', fundsEditIndex).datagrid('deleteRow',0);
									fundsEditIndex = undefined;
									setFsumMoney(0,0);
									fundsappend()
								</c:if>
							}
						}
					"/>
		     	</td>
		     	<td class="td3-ys"></td>
				<td class="td1-ys">&nbsp;二级代码</td>
				<td class="td2">
		     		<input class="easyui-textbox" style="height:30px; width: 300px" data-options="validType:'length[1,50]'"
		   			id="project_base_ejxmdm" name="secondLevelCode" readonly="readonly"  value="${bean.secondLevelCode}"/>
		     	</td> 
			</tr>
			
		    <tr class="trbody">
		    	<td class="td1-ys"><span class="style_must">*</span>&nbsp;计划开始执行年份</td>
		     	<td class="td2">
		     		<input class="easyui-numberbox" style="height:30px;width: 300px" data-options="validType:'length[4,4]'" 
     				id="pro_add_planStartYear" name="planStartYear" value="${bean.planStartYear}"/>
		     	</td>
		     	<td class="td3-ys"></td>
		     	<td class="td1-ys"></td>
     			<td class="td2">
     				
     			</td> 
		    </tr>
		   <%--  <tr class="trbody">
		    	<td class="td1-ys">大写金额</td>
		     	<td class="td2" >
		     		<span style="color: red"  id="pro_add_UP_FProBudgetAmount"></span>
		     		<input type="hidden" id="pro_add_provideAmount1"  name="provideAmount1" value="${bean.provideAmount1}"/>
		     	</td>
		     	<td class="td3-ys"></td>
		    </tr> --%>
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
	
	<div title="基本支出管理信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
		<table cellpadding="0" cellspacing="0" >
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
		$('#pro_add_UP_FProBudgetAmount').html(convertCurrency(newValue));
	}
});

$(function(){
	$("#pro_add_FProBudgetAmount").textbox('setValue',${bean.FProBudgetAmount});
	var value=$("#pro_add_FProBudgetAmount").val();
	$('#pro_add_UP_FProBudgetAmount').html(convertCurrency(value));
			var proOrBasic = '${bean.FProOrBasic}';
		   	if(proOrBasic==0){
		   	//基本支出
	    		$('#base_firstLevel').show();
	    		$('#base_secondLevel').show();
	    		$('#project_add_FProOrBasic_show').val('基本支出');
		   	}
});
		
//开始执行年份
$("#pro_add_planStartYear").numberbox({
	onChange:function(){
		var planStartYear = $("#pro_add_planStartYear").val();
		//下一年度
		var nextYear = new Date().getFullYear()+1;
		if(planStartYear > nextYear){
			alert("开始执行年份不得大于下一年度, 请重新输入！");
			$("#pro_add_planStartYear").numberbox('setValue', nextYear);
		}
	}
});
//选择项目负责人
function chooseFProHead(){
	var win=creatSecondWin('选择负责人', 500,550, 'icon-search', '/project/chooseFProHead');
	win.window('open');
}
</script>
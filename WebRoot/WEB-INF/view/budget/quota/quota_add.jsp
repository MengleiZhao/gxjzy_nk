<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="quota_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" style="width:662px;margin-left: 20px">
					<div title="基本指标" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>归属部门</td>

								<td class="td2">
									<!-- 隐藏域 --> 
									<!-- 主键ID --><input type="hidden" name="bId" value="${bean.bId}" />
									<!-- 指标类型 --><input type="hidden" name="indexType" value="0"/>
									<input type="hidden" id="quota_add_deptName" name="deptName" value="${bean.deptName}"/>
									<input id="project_add_departCombobox"   name="deptCode"
						     		class="easyui-combobox" style="height:30px;width: 200px"
						     		data-options="url:'${base}/depart/getDepartCombobox?selected=${bean.deptCode}',method:'get',valueField:'code',textField:'text',editable:false,validType:'selectValid'"  />
								</td>	
								
								<td class="td3"></td>

								<td class="td1"><span class="style1">*</span>部门编码</td>
								<td class="td2">
									<input style="width: 200px;" id="quota_add_deptCode"  class="easyui-textbox"
									value="${bean.deptCode}" readonly="readonly"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>二级名称</td>

								<td class="td2">
									<input type="hidden" id="project_add_expItemName" name="expItemName" value="${bean.expItemName}"/>
									<input id="project_add_subject2Combobox" name="expItemCode"
						     		class="easyui-combobox" style="height:30px;width: 200px"
						     		data-options="url:'${base}/project/getSubject2ByPm1?selected=${bean.expItemCode}&pml=1',method:'get',valueField:'code',textField:'text',editable:false,validType:'selectValid'"  />
								</td>	
								<td class="td3"></td>
								<td class="td1"><span class="style1">*</span>二级代码</td>
								<td class="td2">
									<input  id="project_add_expItemCode" style="width: 200px;"  class="easyui-textbox"
									value="${bean.expItemCode}" readonly="readonly"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>指标名称</td>
								<td class="td2">
									<input type="hidden" id="project_add_indexName" name="indexName" value="${bean.indexName}"/>
									<input id="project_add_economicLeve2Combobox" name="expItemCode2"
						     		class="easyui-combobox" style="height:30px;width: 200px"
						     		data-options="url:'${base}/economic/findEconomicLeve2?selected=${bean.expItemCode2}',method:'get',valueField:'code',textField:'text',editable:false,validType:'selectValid'"  />
								</td>	
								<td class="td3"></td>
								<td class="td1"><span class="style1">*</span>指标编码</td>
								<td class="td2">
									<input type="hidden" id="project_add_expItemCode2"  value="${bean.expItemCode2}"/>
									<input id="project_add_indexCode"  style="width: 200px;"  class="easyui-textbox" name="indexCode"
									value="${bean.indexCode}" readonly="readonly"/>
								</td>
							</tr>
						
							<tr class="trbody">
									
								
								

								<td class="td1"><span class="style1">*</span>资金性质</td>
								<td class="td2">
									<select id="quota_add_property" class="easyui-combobox" data-options="required:false,editable:false" name="property" style="height:30px;width: 200px;">
				     					<option value="">-请选择-</option>
				     					<option value="1" <c:if test="${bean.property==1 }"> selected="selected"</c:if>>财政性资金</option>
				     					<option value="2" <c:if test="${bean.property==2 }"> selected="selected"</c:if>>非财政性资金</option>
				     				</select>
								</td>
								<td class="td3"></td>
								<td class="td1"><span class="style1">*</span>预算年度</td>
								<td class="td2">
									<input style="width: 200px;" name="years" class="easyui-numberbox"
									value="${bean.years}"/>
								</td>
							</tr>
						
							<tr class="trbody">
							
							<td class="td1"><span class="style1">*</span>指标金额</td>

								<td class="td2">
									<input style="width: 200px;" id="pfzAmount" name="pfzAmount"  required="required"  class="easyui-numberbox"
									data-options="precision:2,iconWidth: 30,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]" 
									value="${bean.pfzAmount}"/>
								</td>
								
								<td class="td3"></td>
								<td class="td1"><span class="style1">*</span>指标类型</td>
								<td class="td2">
									<input style="width: 200px;"  class="easyui-textbox"
									value="基本指标" readonly="readonly"/>
								</td>	
								
							</tr>
						</table>
					</div>
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="save()">
				<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=预算管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<%-- <div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div> --%>
	</div>
</form>
</div>

<script type="text/javascript">
init();
function init(){
	var controlType=$("#controlType").val();
	if(controlType =='2'){
		$("#excessRangetd1").show();
		$("#excessRangetd2").show();
	}
	
}

//部门下拉框事件
$('#project_add_departCombobox').combobox({
    onChange:function(newValue,oldValue){
    	//设置隐藏值
        $('#quota_add_deptName').val($('#project_add_departCombobox').combobox('getText'));
    	//设置显示值
    	$('#quota_add_deptCode').textbox('setValue',$('#project_add_departCombobox').combobox('getValue'));
    	setIndexCode();
    }
});

//二级分类名称下拉框事件
$('#project_add_subject2Combobox').combobox({
    onChange:function(newValue,oldValue){
    	//设置隐藏值
        $('#project_add_expItemName').val($('#project_add_subject2Combobox').combobox('getText'));
    	//设置显示值
    	$('#project_add_expItemCode').textbox('setValue',$('#project_add_subject2Combobox').combobox('getValue'));
    	setIndexCode();
    }
});

//指标名称下拉框事件
$('#project_add_economicLeve2Combobox').combobox({
  onChange:function(newValue,oldValue){
  	//设置隐藏值
      $('#project_add_indexName').val($('#project_add_economicLeve2Combobox').combobox('getText'));
  	//设置显示值
  	$('#project_add_expItemCode2').val($('#project_add_economicLeve2Combobox').combobox('getValue'));
  	setIndexCode();
  }
});

function setIndexCode(){
	var deptCode = $('#quota_add_deptCode').textbox('getValue');
	var expItemCode = $('#project_add_expItemCode').textbox('getValue');
	var expItemCode2 = $('#project_add_expItemCode2').val();
	if(deptCode !="" &&expItemCode2 !="" &&expItemCode !="" ){
		$('#project_add_indexCode').textbox('setValue',expItemCode+"-"+deptCode+"-"+expItemCode2);
	}
	
	
}
//保存
function save() {
	var pfzAmount=$("#pfzAmount").val();//指标金额
	if(pfzAmount==""){
		alert("请填写指标金额");
		return false;
	}
	//提交
	$('#quota_save_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}
			return flag;
		},
		url : base + '/quota/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$('#quota_save_form').form('clear');
				$('#basicIndex').datagrid('reload');
			} else {
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#quota_save_form').form('clear');
			}
		}
	});
}
</script>

</body>
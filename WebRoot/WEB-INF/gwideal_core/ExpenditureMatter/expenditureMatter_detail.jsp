<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="EMAddEditForm" action="${base}/ExpenditureMatter/save" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="feId" id="S_fId_S" value="${bean.feId}"/>
					<div class="easyui-accordion" style="width:662px;margin-left: 20px;">
							<div title="支出事项详情" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
								<table class="ourtable" cellpadding="0" cellspacing="0">
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;支出事项编码</td>
										<td class="td2">
											<input class="easyui-textbox" type="text" id="EM_feCode" readonly="readonly" name="feCode" data-options="validType:'length[1,20]',prompt:''" value="${bean.feCode}" style="width: 200px"/>
										</td>
										<td class="td4">
										
										<input hidden="hidden" value="${bean.fext1}" name="fext1" id="expenditure-fext1"/>
										<input hidden="hidden" value="${bean.fext2}" name="fext2" id="expenditure-fext2"/>
										
										</td>
										<td class="td1">&nbsp;&nbsp;支出事项名称</td>
										<td class="td2">
											<input id="EM_feName" class="easyui-textbox" value="${bean.feName}" name="feName" data-options="validType:'length[1,20]',readonly:true" style="width: 200px" />					
										</td>
									</tr>
									 
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;适用范围</td>
										<td class="td2">
											<input class="easyui-combobox" id="exp_add_type1" name="feType" editable="false"
												style="width: 200px"  value="${bean.feType}" data-options="valueField: 'feType',textField: 'value',readonly:true,
												data: [{feType: '1',value: '通用事项'},{feType: '2',value: '会议'},{feType: '3',value: '培训'},
													   {feType: '5',value: '因公接待'},{feType: '6',value: '公务用车'},{feType: '7',value: '因公出国'},{feType: '8',value: '直接报销'}]" 
											/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1">&nbsp;&nbsp;支出事项标准</td>
										<td class="td2">
											<input class="easyui-textbox" id="EM_feStandard" name="feStandard" data-options="validType:'length[1,20]',readonly:true" value="${bean.feStandard}" style="width: 200px"/>
											<!-- &nbsp;&nbsp;&nbsp;据实列支<input type="checkbox" onclick="jslz(this)" style="margin-top: 3px;vertical-align: middle;"> -->
										</td>
									</tr>
									<!-- 正餐费用 、早餐费用、宴请费用 -->
									<%-- <tr class="trbody" id="tr_px1" style="display: none;">
										<td class="td1">&nbsp;&nbsp;正餐费用</td>
										<td class="td2">
											<input id="EM_feName" class="easyui-textbox" value="${bean.feName}" name="feName" data-options="validType:'length[1,20]'" style="width: 200px" />					
										</td>
										<td class="td4"></td>
										<td class="td1">&nbsp;&nbsp;正餐费用</td>
										<td class="td2">
											<input id="EM_feName" class="easyui-textbox" value="${bean.feName}" name="feName" data-options="validType:'length[1,20]'" style="width: 200px" />					
										</td>
									</tr>
									<tr class="trbody" id="tr_px2" style="display: none;">
										<td class="td1">&nbsp;&nbsp;宴请费用</td>
										<td class="td2">
											<input id="EM_feName" class="easyui-textbox" value="${bean.feName}" name="feName" data-options="validType:'length[1,20]'" style="width: 200px" />					
										</td>
									</tr> --%>
									
									<%-- <tr class="trbody" id="expenditure-travel" style="display: none;">
										<td class="td1">&nbsp;&nbsp;费用类型</td>
										<td class="td2">
											<input class="easyui-combobox" id="exp_add_type2" style="width: 200px" value="${bean.fext1}" data-options="valueField: 'fext1',textField: 'value',
											data: [{fext1: '1',value: '差旅费'},{fext1: '3',value: '伙食费'},{fext1: '4',value: '其他'}]" 
											/>
										</td>
										<td class="td4"></td>
										<td class="td1" style="display: none;" id="expenditure-travel-level1">&nbsp;&nbsp;城市等级</td>
										<td class="td2" style="display: none;" id="expenditure-travel-level2">
											<input class="easyui-combobox" style="width: 200px" value="${bean.fext2}" 
												data-options="url:base+'/lookup/lookupsJson?parentCode=CSDJ&selected=${bean.fext2}',
															method:'get',valueField:'code',textField:'text',editable:false,
															onSelect: function(rec){
																$('#expenditure-fext2').val(rec.code);
															}"/>
										</td>
									</tr> --%>
									
									<tr  class="trbody" id="expenditure-meeting" style="display: none;">
										<td class="td1">&nbsp;&nbsp;会议类型</td>
										<td class="td2">
											<input class="easyui-combobox" style="width: 200px" value="${bean.fext2}" data-options="valueField: 'fext2',textField: 'value',readonly:true,
											data: [{fext2: '1',value: '一类会议'},{fext2: '2',value: '二类会议'},{fext2: '3',value: '三、四类会议'}],
											onSelect: function(rec){
												$('#expenditure-fext2').val(rec.fext2);
											}"/>
										</td>
										
										<td class="td4"></td>
										
										<td class="td1">&nbsp;&nbsp;费用类型</td>
										<td class="td2">
											<input class="easyui-combobox" style="width: 200px" value="${bean.fext1}" data-options="valueField: 'fext1',textField: 'value',readonly:true,
											data: [{fext1: '2',value: '住宿费'},{fext1: '3',value: '伙食费'},{fext1: '4',value: '其他'}],
											onSelect: function(rec){
												$('#expenditure-fext1').val(rec.fext1);
											}"/>
										</td>
									</tr>
									
									<tr  class="trbody" id="expenditure-training" style="display: none;">
										<td class="td1">&nbsp;&nbsp;培训类型</td>
										<td class="td2">
											<input class="easyui-combobox" style="width: 200px" value="${bean.fext2}" data-options="valueField: 'fext2',textField: 'value',readonly:true,
											data: [{fext2: '1',value: '一类培训'},{fext2: '2',value: '二类培训'},{fext2: '3',value: '三类培训'}],
											onSelect: function(rec){
												$('#expenditure-fext2').val(rec.fext2);
											}"/>
										</td>
										
										<td class="td4">&nbsp;</td>
										
										<td class="td1">&nbsp;&nbsp;费用类型</td>
										<td class="td2">
											<input class="easyui-combobox" style="width: 200px" value="${bean.fext1}" data-options="valueField: 'fext1',textField: 'value',readonly:true,
											data: [{fext1: '2',value: '住宿费'},{fext1: '3',value: '伙食费'},{fext1: '4',value: '其他'},{fext1: '5',value: '场地、资料、交通费'},{fext1: '5',value: '师资费'}],
											onSelect: function(rec){
												$('#expenditure-fext1').val(rec.fext1);
											}"/>
										</td>
									</tr>
									<tr style="height: 5px;">&nbsp;</tr>
									<tr style="height: 70px;" id="expenditure-role">
										<td class="td1" valign="top">
										&nbsp;&nbsp;适用角色<br/>
										</td>
										<td colspan="4">
										<input class="easyui-textbox" data-options="multiline:true" id="roleName" name="roleName" style="width: 555px;height:70px" value="${bean.roleName}" readonly="readonly"> 
										<input class="easyui-textbox" id="roleIds" name="roleIds" value="${bean.roleIds}" type="hidden">
										</td>
									</tr>
									
									<tr style="height: 70px;">
										<td class="td1" valign="top">&nbsp;&nbsp;支出事项说明</td>
										<td colspan="4">
											<input class="easyui-textbox" data-options="multiline:true,readonly:true" id="EM_feRemark" name="feRemark" style="width: 555px;height:70px;" value="${bean.feRemark}">  
											<!-- <input type="text" id="S_fFlowStauts" name="fFlowStauts" hidden="hidden" value="0"/> -->
										</td>
										
									</tr>
									
								</table>	
							</div>
						</div>			
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	</div>
</form>
</div>
<script type="text/javascript">
function EMAddEditForm(){
$('#EMAddEditForm').form('submit', {
	onSubmit: function(){ 
		flag=$(this).form('enableValidation').form('validate');
		if(flag){
			$.messager.progress();
		}
		return flag;
	}, 
	success:function(data){
		if(flag){
			$.messager.progress('close');
		}
		data=eval("("+data+")");
		if(data.success){
			$.messager.alert('系统提示', data.info, 'info');
			closeWindow();
			$('#EMAddEditForm').form('clear');
			$('#EM_dg').datagrid('reload'); 
		}else{
			$.messager.alert('系统提示', data.info, 'error');
		}
		} 
	});		
}
		
//选择适用角色
function choiceRoles() {
	var win = creatFirstWin('适用角色选择', 970, 580, 'icon-search', '/ExpenditureMatter/choiceRoles');
	win.window('open');
}


function jslz(obj){
	if($(obj).prop('checked')){
		$('#EM_feStandard').textbox('setValue','据实列支');
	}else{
		$('#EM_feStandard').textbox('setValue','');
	}
}

//选择 费用类型 触发方法
function fylxOnchange(){
	var syfw = $('#exp_add_type1').combobox('getValue');//适用范围
	var fylx = $('#exp_add_type2').combobox('getValue');//费用类型
	if(syfw=='4' && fylx=='2'){
		//差旅费中的住宿费，显示淡旺季配置选项
		$('#tr_zcsxgl_add_dwj').show();
	}else{
		$('#tr_zcsxgl_add_dwj').hide();
		$('#zjsx_add_fext3').datebox('setValue','');
		$('#zjsx_add_fext4').datebox('setValue','');
		$('#zjsx_add_fext5').numberbox('setValue','');
	}
}

$(function(){
	//初始化 支出事项类型选择
	$('#exp_add_type1').combobox({
		onSelect: function(rec){
			var feType = rec.feType;
			if(feType==2) {//会议
				$('#expenditure-meeting').css('display','');
				
				$('#expenditure-travel').css('display','none');
				$('#expenditure-role').css('display','none');
				$('#expenditure-training').css('display','none');
				$('#tr_zcsxgl_add_dwj').css('display','none');
			} else if(feType==3) {//培训
				$('#expenditure-training').css('display','');
				
				$('#expenditure-role').css('display','none');
				$('#expenditure-meeting').css('display','none');
				$('#expenditure-travel').css('display','none');
				$('#tr_zcsxgl_add_dwj').css('display','none');
			} else if(feType==4){//差旅
				$('#expenditure-travel').css('display','');
				$('#expenditure-role').css('display','');
				
				$('#expenditure-meeting').css('display','none');
				$('#expenditure-training').css('display','none');
			} else {
				$('#expenditure-role').css('display','');
				
				$('#expenditure-meeting').css('display','none');
				$('#expenditure-travel').css('display','none');
				$('#expenditure-training').css('display','none');
				
				$('#tr_zcsxgl_add_dwj').css('display','none');
				
			}
		}
	});

	//初始化
	$('#exp_add_type2').combobox({
		onChange:fylxOnchange
	});

	
	
	
});

</script>
</body>
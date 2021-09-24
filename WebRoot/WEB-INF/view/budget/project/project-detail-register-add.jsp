<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<script type="text/javascript">
//保存
function saveApply(flowStauts) {
	
	var proActivity = $("#proDetailId").val();
	if(proActivity==""){
		alert('请选择具体业务！');
		return false;
	}
	
	var amount = isNaN(parseFloat($("#amount").numberbox('getValue')));
	if(amount){
		alert('请填写支出金额！');
		return false;
	}
	//提交
	$('#apply_save_form').form('submit', {
		onSubmit : function() {
			//如果校验通过，则进行下一步
			$.messager.progress();
		},
		url : base + '/indexDetailRegister/save',
		success : function(data) {
			$.messager.progress('close');
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#index-xdmx').datagrid('reload');
				closeFirstWindow();
				
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
}


	/* $(document).ready(function() {
		
	}); */
	

function onSelectproActivity(record){
		$("#proDetailId").val(record.id);
	}
</script>

<form id="apply_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 391px;border: 1px solid #D9E3E7;margin-top: 20px;"">
			<div class="win-left-top-div">
				<!-- 基本信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="基本信息" data-options="collapsed:false,collapsible:false"style="overflow:auto;">
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 具体业务</td>
							<td colspan="4">
								<input class="easyui-combobox" style="width: 617px;height: 30px;" value="${bean.proActivity}" id="proActivity" name="proActivity" required="required" data-options="
								url:'${base}/indexDetailRegister/findByfProIdGetDetail?id=${proId}',
								method:'get',
								valueField:'text',
								textField:'text',
								editable:false,
								validType:'length[1,100]',
								onSelect:onSelectproActivity"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span>&nbsp;登记时间</td>
							<td class="td2">
								<input class="easyui-datebox" id="time" name="time" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 245px;height: 30px" value="${bean.time}"/>
							</td>	
							<td class="td3" ></td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 支出金额</td>
							<td class="td2" >
								<input class="easyui-numberbox" id="amount" required="required" name="amount" value="${bean.amount}" style="width: 245px;height: 30px;margin-left: 10px " data-options="precision:2" >
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 登记人</td>
							<td class="td2" >
								<input class="easyui-textbox" id="userName" name="userName" readonly="readonly" value="${bean.userName}" style="width: 245px;height: 30px;margin-left: 10px " >
							</td>
							<td class="td3" >
							<!-- 隐藏域 --> 
							<!-- 主键ID --><input type="hidden" name="proId" value="${proId}" />
							<!-- 项目支出明细ID --><input type="hidden" id="proDetailId" name="proDetailId" value="${bean.proDetailId}"/>
							<!-- 登记人ID --><input type="hidden" name="userId" value="${bean.userId}"/>
							<!-- 登记人部门ID --><input type="hidden" name="departmentId" value="${bean.departmentId}"/>
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 登记部门</td>
							<td class="td2" >
								<input class="easyui-textbox" id="department" name="department" readonly="readonly" value="${bean.department}" style="width: 245px;height: 30px;margin-left: 10px " >
							</td>
						</tr>
					</table>
				</div>				
				</div>
			</div>
			
			<div class="window-left-bottom-div" style="">
				<a href="javascript:void(0)" onclick="saveApply()">
				<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeFirstWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				&nbsp;&nbsp;
			</div>
			
		</div>
	</div>
</form>

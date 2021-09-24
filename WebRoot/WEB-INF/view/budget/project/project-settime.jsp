<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<script type="text/javascript">
//保存
function saveApply() {
	//提交
	$('#settime_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				//如果校验通过，则进行下一步
				$.messager.progress();
			}else{
				//校验不通过，就打开第一个校验失败的手风琴
				openAccordion();
			}
			return flag;
		},
		url : base + '/project/saveAddAndCheckTime',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
}


</script>

<form id="settime_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:450px;height: 330px;margin-bottom: 0px;">
			<div class="win-left-top-div" style="width: 420px;height: 310px;">
				<!-- 隐藏域 --> 
				<!-- 主键ID --><input type="hidden" name="fid" value="${bean.fid}" />
				<!-- 数据阶段1-一上,2-二上 --><input type="hidden" name="fDataType" value="${bean.fDataType}" />
				<!-- 基本信息 -->
				<div class="easyui-accordion" style="width: 420px;">
					<div title="配置时间" data-options="collapsible:false" style="overflow:auto;padding:10px; ">
						<table class="window-table" style="width: 400px;" cellspacing="0" cellpadding="0">
							<tr class="trbody">
								<td class="td1" style="width:75px;"><span class="style1">*</span>&nbsp;申报开始时间</td>
								<td class="td2">
									<input class="easyui-datetimebox" style="width: 200px; height: 30px;" id="addStartTime" name="addStartTime"
									data-options="" value="${bean.addStartTime}" required="required"/>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1" style="width:75px;"><span class="style1">*</span>&nbsp;申报结束时间</td>
								<td class="td2">
									<input class="easyui-datetimebox" style="width: 200px; height: 30px;" id="addEndTime" name="addEndTime"
									data-options="" value="${bean.addEndTime}" required="required"/>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1" style="width:75px;"><span class="style1">*</span>&nbsp;审批开始时间</td>
								<td class="td2">
									<input class="easyui-datetimebox" style="width: 200px; height: 30px;" id="checkStartTime" name="checkStartTime"
									data-options="" value="${bean.checkStartTime}" required="required"/>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1" style="width:75px;"><span class="style1">*</span>&nbsp;审批结束时间</td>
								<td class="td2">
									<input class="easyui-datetimebox" style="width: 200px; height: 30px;" id="checkEndTime" name="checkEndTime"
									data-options="" value="${bean.checkEndTime}" required="required"/>
								</td>
							</tr>
							<%-- <tr class="trbody">
								<td class="td1" style="width:75px;"><span class="style1">*</span>&nbsp;修改开始时间</td>
								<td class="td2">
									<input class="easyui-datetimebox" style="width: 200px; height: 30px;" id="updateStartTime" name="updateStartTime"
									data-options="" value="${bean.updateStartTime}" required="required"/>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1" style="width:75px;"><span class="style1">*</span>&nbsp;修改结束时间</td>
								<td class="td2">
									<input class="easyui-datetimebox" style="width: 200px; height: 30px;" id="updateEndTime" name="updateEndTime"
									data-options="" value="${bean.updateEndTime}" required="required"/>
								</td>
							</tr> --%>
						</table>
					</div>
				</div>
			</div>
			<div class="window-left-bottom-div" style="margin-top: 10px;">
				<a href="javascript:void(0)" onclick="saveApply()">
				<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	</div>
</form>

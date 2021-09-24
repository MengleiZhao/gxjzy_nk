<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<form id="outside_check_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
<div class="win-div">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="easyAcc" style="width:662px;margin-left: 20px">
					<div title="基本信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable">
							<tr class="trbody">
								<td class="td1">操作人</td>

								<td class="td2"><input style="width: 200px;" id=""
									name="opUser" class="easyui-textbox"
									value="${bean.opUser}" readonly="readonly"></input>
								</td>
								
								<td class="td4">
									<!-- 隐藏域 --> 
									<input type="hidden" name="aId" value="${bean.aId}" />
									<input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="outsideFlowStauts"/>
									<input type="hidden" name="stauts" value="${bean.stauts}" id="outsideStauts"/>
									<input type="hidden" name="accountStauts" value="${bean.accountStauts}" />
									<input type="hidden" name="userName" value="${bean.fuserName}" />
									<input type="hidden" name="userId" value="${bean.fuserId}" />
									<input type="hidden" name="nCode" value="${bean.nCode}" />
									<input type="hidden" name="deptCode" value="${bean.deptCode}" />
									<!-- 审批结果 -->
						    		<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
						    		<!-- 审批意见 -->
								    <input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
								</td>

								<td class="td1">调整时间</td>
								<td class="td2"><input style="width: 200px;"
									id="outsideOpTime" name="opTime" class="easyui-datebox"
									value="${bean.opTime}" readonly="readonly"></input>
								</td>
							</tr>


							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px">调整说明</p></td>
								<td colspan="4">
									<input class="easyui-textbox" data-options="multiline:true" name="exteDesc" style="width:555px;height:70px" value="${bean.exteDesc}" readonly="readonly"/>
								</td>
							</tr>
						</table>
					</div>
					
					<div title="指标调整" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="outside/zbtz.jsp"/>
					</div>
				</div>
			
		
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="openCheckWin('审批意见','1')">
					<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="openCheckWin('审批意见','0')">
					<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<%-- <a href="javascript:void(0)" onclick="check()">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp; --%>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div>
	</div>
</div>	
</form>
<script type="text/javascript">
$(document).ready(function() {
	//设值调整时间
	if ($("#outsideOpTime").textbox().textbox('getValue') == "") {
		$("#outsideOpTime").textbox().textbox('setValue', 'date');
	}
});

//寻找相关制度
function findSystemFile(id) {
	$.ajax({ 
		url: base+"/cheter/systemFind?id="+id, 
		success: function(data){
			data=data.replace('\"','');
			data=data.replace('\"','');
			window.open(data);
    }});
}

//审批
function check() {
	$('#outside_check_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}
			return flag;
		},
		url : base + '/outsideCheck/checkResult',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$('#outside_check_form').form('clear');
				$('#outsideCheckTab').datagrid('reload'); 
				$("#indexdb").datagrid('reload');
			} else {
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#outside_check_form').form('clear');
			}
		}
	});
}

</script>
</body>


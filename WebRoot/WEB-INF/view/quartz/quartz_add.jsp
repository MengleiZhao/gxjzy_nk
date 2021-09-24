<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="quartz_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="" style="width:662px;margin-left: 20px">
					<!-- 第一个div -->
					<div title="任务信息"   id="gjsxxdiv" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>任务名称</td>
								<td colspan="4">
									<input class="easyui-textbox" id="add_jobdetailname"  name="jobdetailname"  style="width:555px;" data-options="validType:'length[1,100]'" value="${bean.jobdetailname}"/>
									<input type="hidden" name="id" id="add_id" value="${bean.id}"/><!--隐藏域  -->
									<input type="hidden" name="triggername" id="add_triggername" value="${bean.triggername}"/><!--隐藏域  -->
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>表达式</td>
								<td colspan="4">
									<input class="easyui-textbox" type="text" id="add_cronexpression"  name="cronexpression"  required="required" data-options="validType:'length[1,100]'" style="width:555px;" value="${bean.cronexpression}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>任务类名</td>
								<td colspan="4">
										<input class="easyui-textbox" type="text" id="add_targetobject"  name="targetobject"  required="required"  style="width: 555px" value="${bean.targetobject}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>类名对应的方法名</td>
								<td colspan="4">
									<input class="easyui-textbox" type="text" id="add_methodname"  name="methodname"  required="required"  style="width: 555px" value="${bean.methodname}"/>
								</td>
							</tr>
							<tr>
								<td class="td1">参数</td>
								<td colspan="4">
									<input class="easyui-textbox" type="text" id="add_arguments"  name="arguments"  style="width: 300px" value="${bean.arguments}"/>
									<span class="style1">多个参数使用逗号分隔</span>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>是否并发启动</td>
								<td class="td2">
									<span>
										<c:if test="${empty bean.id}">
             								<input type="radio" name="concurrent" checked="checked" value="1">是
             								<input type="radio"  name="concurrent"  value="0">否
										</c:if>
										<c:if test="${!empty bean.id}">
             									<input type="radio" name="concurrent" <c:if test="${bean.concurrent=='1'}">checked="checked"</c:if> value="1">是
             									<input type="radio"  name="concurrent" <c:if test="${bean.concurrent=='0'}">checked="checked"</c:if> value="0">否
										</c:if>	
        							</span>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>任务状态</td>
								<td class="td2">
									<span>
										<c:if test="${empty bean.id}">
											<input type="radio"  name="state" checked="checked" value="1">运行
	         								<input type="radio" name="state"  value="0">停止
										</c:if>
										<c:if test="${!empty bean.id}">
											<input type="radio"  name="state" <c:if test="${bean.state=='1'}">checked="checked"</c:if> value="1">运行
         									<input type="radio" name="state" <c:if test="${bean.state=='0'}">checked="checked"</c:if> value="0">停止
										</c:if>	
										
    								</span>
								</td>
							</tr>
							<tr>
								<td class="td1">任务描述</td>
								<td class="td2">
									<textarea name="readme"  id="add_readme"  class="textbox-text"  oninput="textareaNum(this,'textareaNum1')" autocomplete="off"   style="width:555px;height:70px;resize:none">${bean.readme}</textarea>
									<%-- <input class="easyui-textbox" type="text" id="add_readme"  name="readme"  data-options="validType:'length[1,100]',multiline:true"   style="width:555px;height:70px;" value="${bean.readme}"/>
								 --%>
								</td>
							</tr>
							<tr>
								<td align="right" colspan="5" style="padding-right: 0px;">
								可输入剩余数：<span id="textareaNum1" class="200">
									<c:if test="${empty bean.readme}">200</c:if>
									<c:if test="${!empty bean.readme}">${200-bean.readme.length()}</c:if>
								</span>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveQuartz()">
					<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		<div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="cron.jsp" />
		</div>
	</div>
</form>
</div>
	<script type="text/javascript">
	//保存
	function saveQuartz() {
		 //提交
		$('#quartz_save_form').form('submit', {
			onSubmit : function() {
				flag = $(this).form('enableValidation').form('validate');
				if (flag) {
					$.messager.progress();
				}else{
					//校验不通过，就打开第一个校验失败的手风琴
					openAccordion();
				}
				return flag;
			},
			url : base + '/quartzController/save',
			success : function(data) {
				if (flag) {
					$.messager.progress('close');
				}
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					 $("#Quzrtz_tab").datagrid("reload");
				} else {
					$.messager.alert('系统提示', data.info, 'error');
					closeWindow();
					$('#quartz_save_form').form('clear');
				}
			}
		}); 	
	}
		
	</script>
</body>
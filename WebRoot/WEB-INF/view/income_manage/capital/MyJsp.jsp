<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="re_capital_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="easyAcc" style="width:555px;margin-left: 20px;">
												<!-- 第一个div -->
								<div title="资金垫支信息(填写)" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
									<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
										<tr>
											<td class="td1"><span class="style1">*</span>借款/报销单号</td>
											<td class="td2">
												<input id="F_fcoCode" class="easyui-textbox" type="text" readonly="readonly" required="required" name="fcoCode" data-options="validType:'length[1,30]'" style="width: 150px" value="${bean.fcoCode}"/>
												<!-- 隐藏域 --> 
											    <input type="hidden" name="fpayforId" id="F_fpayforId" value="${bean.fpayforId}"/><!-- 主键ID -->
											    <input type="hidden" name="fproCode" id="F_fproCode" value="${bean.fproCode}"/><!--借方项目编号  -->
											    <input type="hidden" name="fproCode2" id="F_fproCode2" value="${bean.fproCode2}"/><!-- 贷方项目编号 -->
											</td>
											
											<td style="width: 0px"></td>
											
											<td class="td1"><span class="style1">*</span>类别</td>
											<td class="td2">
												<input id="F_ftype" name="ftype"  class="easyui-textbox" style="width: 150px" data-options="validType:'length[1,30]'" style="width: 150px" value="${bean.ftype}" />
											</td>
										</tr>
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>借方项目</td>
											<td colspan="4">
												<c:if test="${empty bean.fpayforId}">
													<a href="javascript:void(0)" onclick="checkCode1()">
														<input class="easyui-textbox" id="F_fproName"  name="fproName"  readonly="readonly"  style="width: 430px" data-options="prompt: '请选择' ,icons: [{iconCls:'icon-sousuo',handler: function(){checkCode()}}]" value="${bean.fproName}"/>
													</a>
												</c:if>
												<c:if test="${!empty bean.fpayforId}">
													<input class="easyui-textbox" id="F_fproName" readonly="readonly" name="fproName"  style="width: 430px" value="${bean.fproName}"/>
												</c:if>
											</td>
										</tr>
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>贷方项目</td>
											<td colspan="4">
												<c:if test="${empty bean.fpayforId}">
													<a href="javascript:void(0)" onclick="checkCode2()">
														<input class="easyui-textbox" id="F_fproName2"  name="fproName2"  readonly="readonly"  style="width: 430px" data-options="prompt: '请选择' ,icons: [{iconCls:'icon-sousuo',handler: function(){checkCode()}}]" value="${bean.fproName2}"/>
													</a>
												</c:if>
												<c:if test="${!empty bean.fpayforId}">
													<input class="easyui-textbox" id="F_fproName2" readonly="readonly" name="fproName2"  style="width: 430px" data-options="validType:'length[1,20]'" value="${bean.fproName2}"/>
												</c:if>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>贷方账户</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_faccount"  name="faccount"  required="required"  data-options="validType:'length[1,20]'" style="width: 150px" value="${bean.faccount}"/>
											</td>
											
											<td style="width: 0px"></td>
											
											<td class="td1"><span class="style1">*</span>归垫/调整金额</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_famount"  name="famount"  required="required" data-options="validType:'length[1,20]',iconWidth: 22,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]" style="width: 150px" value="${bean.famount}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>登记人</td>
											<td class="td2">
												<input id="F_foperateUser" class="easyui-textbox" type="text" readonly="readonly" required="required" name="foperateUser" data-options="validType:'length[1,30]'" style="width: 150px" value="${bean.foperateUser}"/>
											</td>
											
											<td style="width: 0px"></td>
											
											<td class="td1"><span class="style1">*</span>登记时间</td>
											<td class="td2">
												<input id="F_foperateTime" class="easyui-datebox" type="text" required="required" name="foperateTime" data-options="validType:'length[1,30]'" style="width: 150px" value="${bean.foperateTime}"/>
											</td>
										</tr>
									</table>
								</div>
						</div>
			
		
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveApply()">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div>
	</div>
</form>
</div>
<script type="text/javascript">	

	//弹出借方项目的选择页面
	function checkCode1() {
		var win = creatFirstWin('招标信息', 840, 450, 'icon-search','/srcapital/proinfoa');
		win.window('open');
	}
	//弹出贷方项目的选择页面
	function checkCode2() {
		var win = creatFirstWin('招标信息', 840, 450, 'icon-search','/srcapital/proinfob');
		win.window('open');
	}

	
	//保存
	function saveApply() {		
		var code1=$("#F_fproCode").val();
		var code2=$("#F_fproCode2").val();

		if(code1==code2){
            alert("借方和贷方不能相同!");
            return false;
        }else{
		//提交
		$('#re_capital_form').form('submit', {
			onSubmit : function() {
				flag = $(this).form('enableValidation').form('validate');
				if (flag) {
					$.messager.progress();
				}
				return flag;
			},
			url : base + '/srcapital/save',
			success : function(data) {
				if (flag) {
					$.messager.progress('close');
				}
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					//$("#re_capital_form").form("clear"); 带着新增完毕不能查询
					 $("#capitalTab").datagrid("reload");
				} else {
					$.messager.alert('系统提示', data.info, 'error');
					closeWindow();
					$('#re_capital_form').form('clear');
				}
			}
		}); 	
	}
}
	
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
</script>
</body>
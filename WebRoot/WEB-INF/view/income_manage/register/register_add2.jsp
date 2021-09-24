<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
</head>
  <body>
	<style type="text/css">
	</style>

	<div class="easyui-layout" fit="true">
		<form id="re_arrive_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
						<!--  左侧div基本信息-->
			<div data-options="region:'west',split:true" style="width:600px;border-color: #dce5e9" id="westDiv">
				<table>					
					<tr>
						<td>
							<div class="easyui-accordion" data-options="" id="easyAcc" style="width:555px;margin-left: 20px;">
												<!-- 第一个div -->
								<div title="基本信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
									<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>登记单号</td>
											<td colspan="4">
												<input id="F_fincomeNum" class="easyui-textbox" type="text" readonly="readonly" required="required" name="fincomeNum" data-options="validType:'length[1,30]'" style="width: 430px" value="${bean.fincomeNum}"/>
												<!-- 隐藏域 --> 
											    <input type="hidden" name="fincomeId" id="F_fincomeId" value="${bean.fincomeId}"/>
												<!-- 收入科目类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="arriveIndexType"/>
												<!-- 收入科目id --><input type="hidden" name="fecCode" value="${bean.fecCode}" id="arriveIndexId"/>
												<!-- 到账项目名称 --><input type="hidden" name="fproName" value="${bean.fproName}" id="F_fproName"/>
											</td>
											
											</td>
										</tr>
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>到账项目</td>
											<td colspan="4">
												<c:if test="${empty bean.fincomeId}">
													<a href="javascript:void(0)" onclick="checkCode()">
														<input class="easyui-textbox" id="F_fproCode"  name="fproCode"  readonly="readonly"  style="width: 430px" data-options="prompt: '请选择' ,icons: [{iconCls:'icon-sousuo',handler: function(){checkCode()}}]" value="${bean.fproCode}"/>
													</a>
												</c:if>
												<c:if test="${!empty bean.fincomeId}">
													<input class="easyui-textbox" id="F_fproCode" readonly="readonly" name="fproCode"  style="width: 430px" value="${bean.fproCode}"/>
												</c:if>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>收入科目</td>
											<td class="td2">
											<a href="javascript:void(0)" onclick="openIndex()">
												<input class="easyui-textbox" type="text" id="F_indexName"  name="indexName" readonly="readonly" required="required" data-options="prompt: '选择科目' ,icons: [{iconCls:'icon-sousuo',handler: function(){openIndex()}}]" style="width: 150px" value="${bean.indexName}"/>
											</a>
											</td>
											
											<td style="width: 0px"></td>
											
											<td class="td1"><span class="style1">*</span>收入金额</td>
											<td class="td2">
													<input class="easyui-textbox" type="text" id="F_fregisterAmount"  name="fregisterAmount"  required="required" data-options="validType:'length[1,20]',iconWidth: 22,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]"  style="width: 150px" value="${bean.fregisterAmount}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>登记日期</td>
											<td class="td2">
												<input id="F_fregisterTime" class="easyui-datebox" type="text" required="required" name="fregisterTime" data-options="validType:'length[1,30]'" style="width: 150px" value="${bean.fregisterTime}"/>
											</td>
											
											<td style="width: 0px"></td>
											
											<td class="td1"><span class="style1">*</span>登记部门</td>
											<td class="td2">
												<c:if test="${empty bean.fincomeId}">
													<input id="F_fregisterDepart" name="fregisterDepart.code"  class="easyui-combobox" style="width: 150px" data-options="url:'${base}/lookup/lookupsJson?parentCode=REGIST_DEP',method:'get',valueField:'code',textField:'text',editable:false" />
												</c:if>
												<c:if test="${!empty bean.fincomeId}">
													<input id="F_fregisterDepart" name="fregisterDepart.code"  class="easyui-combobox" style="width: 150px" data-options="url:'${base}/lookup/lookupsJson?parentCode=REGIST_DEP&selected=${bean.fregisterDepart.code}',method:'get',valueField:'code',textField:'text',editable:false" />
												</c:if>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>到账类型</td>
											<td class="td2">
												<c:if test="${empty bean.fincomeId}">
													<input id="F_faccountType" name="faccountType.code"   class="easyui-combobox" style="width: 150px" data-options="url:'${base}/lookup/lookupsJson?parentCode=ARRIVE_TYPE',method:'get',valueField:'code',textField:'text',editable:false"  />
												</c:if>
												<c:if test="${!empty bean.fincomeId}">
													<input id="F_faccountType" name="faccountType.code"   class="easyui-combobox" style="width: 150px" data-options="url:'${base}/lookup/lookupsJson?parentCode=ARRIVE_TYPE&selected=${bean.faccountType.code}',method:'get',valueField:'code',textField:'text',editable:false"  />
												</c:if>
											</td>
											
											<td style="width: 0px"></td>
											
											<td class="td1"><span class="style1">*</span>到账方式</td>
											<td class="td2">
												<c:if test="${empty bean.fincomeId}">
													<input id="F_faccountWay" name="faccountWay.code"   class="easyui-combobox" style="width: 150px" data-options="url:'${base}/lookup/lookupsJson?parentCode=ARRIVE_METHOD',method:'get',valueField:'code',textField:'text',editable:false" />
												</c:if>
												<c:if test="${!empty bean.fincomeId}">
													<input id="F_faccountType" name="faccountWay.code"   class="easyui-combobox" style="width: 150px" data-options="url:'${base}/lookup/lookupsJson?parentCode=ARRIVE_METHOD&selected=${bean.faccountWay.code}',method:'get',valueField:'code',textField:'text',editable:false"  />
												</c:if>
											</td>
										</tr>
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>到账账号</td>
											<td colspan="4">
												<c:if test="${empty bean.fincomeId}">
												<input id="F_faccount" name="faccount.code"  class="easyui-combobox" style="width: 430px" data-options="url:'${base}/lookup/lookupsJson?parentCode=ARRIVE_ACCOUNT',method:'get',valueField:'code',textField:'text',editable:false"  />
												</c:if>
												<c:if test="${!empty bean.fincomeId}">
													<input id="F_faccountType" name="faccount.code"   class="easyui-combobox" style="width: 430px" data-options="url:'${base}/lookup/lookupsJson?parentCode=ARRIVE_ACCOUNT&selected=${bean.faccount.code}',method:'get',valueField:'code',textField:'text',editable:false"  />
												</c:if>
											</td>
										</tr>
									</table>
								</div>
						</div>
					</td>
				</tr>
		</table>
	</div>
	
	<div data-options="region:'center',split:true" style="width: 8xp;height: 100%;background-color: #f0f5f7;border-color: #f0f5f7">
			</div>
					<!--右侧div  相关制度  -->
			<div data-options="region:'east',split:true" style="width:190px;border-color: #dce5e9">
				<table class="ourtable2" style="width: 150px;margin-left: 20px;" cellpadding="0" cellspacing="0">
					<tr>
						<td style="height: 28px;"><span style="color: ff6800">相关制度</span></td>
					</tr>
					<tr>
					<td valign="top">
						<img src="${base}/resource-modality/${themenurl}/skin_/hengxian.png" style="width: 150px">
					</td>
					</tr>
					<tr>
						<td style="height: 31px;">
							<input class="easyui-textbox" style="width:150px;"
							data-options="prompt: '搜索' ,icons: [{iconCls:'icon-sousuo',handler: function(){}}]">
						</td>
					</tr>
					<c:forEach items="${cheterInfo}" var="li">
						<tr style="height: 30px;">
							<td>
								<a style="color: #666666" id="file${li.systemId}" href="#" onclick="findSystemFile(${li.systemId})">${li.fileName}</a>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div> 
		
		
			<div data-options="region:'south'" style="height: 51px;width: 100%; border: 0px;">
					<div style="width:598px;height: 50px;text-align: center;float: left;border:1px solid #dce5e9;border-top: 0px">
						<a href="javascript:void(0)" onclick="saveApply()">
							<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="closeWindow()">
							<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</div>
			</div>
		</form>


	</div>
<script type="text/javascript">	

	//弹出到账项目的选择页面
	function checkCode() {
		var win = creatFirstWin('招标信息', 840, 450, 'icon-search','/srregister/registerinfo');
		win.window('open');
	}
	//打开科目选择页面
	function openIndex() {
		var win = creatFirstWin('科目选择', 840, 450, 'icon-search', '/srregister/index');
		win.window('open');
	}
	
	//保存
	function saveApply() {	
		/* alert($("#F_indexName").val());
		alert($("#arriveIndexId").val());
		alert($("#arriveIndexType").val());
		alert($("#F_fproCode").val());
		alert($("#F_fproName").val());
		alert($("#F_fregisterDepart").val());
		alert($("#F_faccountType").val());
		alert($("#F_faccountWay").val());
		alert($("#F_faccount").val()); */
		
		
		//提交
		$('#re_arrive_form').form('submit', {
			onSubmit : function() {
				flag = $(this).form('enableValidation').form('validate');
				if (flag) {
					$.messager.progress();
				}
				return flag;
			},
			url : base + '/srregister/save',
			success : function(data) {
				if (flag) {
					$.messager.progress('close');
				}
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					//$("#re_arrive_form").form("clear");  带着新增完毕不能查询
					//$('#registerTab').datagrid('reload');
					 $("#registerTab").datagrid("reload");

					// window.location.reload();
				} else {
					$.messager.alert('系统提示', data.info, 'error');
					closeWindow();
					$('#re_arrive_form').form('clear');
				}
			}
		}); 	
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
<script type="text/javascript">
//显示详情tab
</script>
</html>


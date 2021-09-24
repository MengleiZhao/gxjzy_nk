<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>



</head>
<body>
		<style type="text/css">
input{
	width:120px;
}
select{
	width:150px;
}
.td-leap{
	width:20px;
}
.style_must{
	color:red
}

.a_table td{font-size: 12px;}
.textbox-text:read-only{background-color: #f6f6f6;color: #999999} 
.textbox-readonly{background-color: #f6f6f6;color: #999999}
.textbox-text{color:#666666;height: 25px; line-height: 25px}

.textbox-text:read-only{background-color: #f6f6f6;color: #999999} 
.textbox-readonly{background-color: #f6f6f6;color: #999999}
.textbox-text{color:#666666;height: 25px; line-height: 25px}
.style1{color: red;}
.numberbox .textbox-text {text-align: left;}
.tabDiv{padding:10px;}
.ourtable{font-size: 12px;width: 550px;color: #666666;font-family: "微软雅黑"}
.ourtable2{font-size: 12px;color: #666666;font-family: "微软雅黑"}
.trtop{height: 10px;}
.trbody{height: 30px;}
.td1{width: 100px;}
.td2{height: 30px;width: 150px;} 
.tdnum2{height: 30px;width: 50px;} 
.tdnum1{height: 30px;width: 130px; text-align: right;} 
</style>
	<form id="control_edit_form" method="post" enctype="multipart/form-data">
		<!-- hidden -->
		<input type="hidden" name="fCId" value="${bean.fCId }" />


		<div class="easyui-layout" fit="true" style="width: 100%;height:800px;">
			<div data-options="region:'west',spilt:true" 
				style="border-color: dce5e9; width:800px;" id="westDiv">
			<div class="easyui-layout" fit="true">
			<div data-options="region:'north'" style="height:120px;border-color: dce5e9;padding-left: 20px;border: 0" >
				<table style="width:100%" class="a_table">
							<tr>
								<td class="tdnum1" style="text-align: right;">年度：</td>
								<td class="tdnum2" colspan="3">
		     						<input id="control_add_year" style=" height:25px;" readonly="readonly" class="easyui-numberbox"
									 value="${bean.fBudgetYear }" />
								</td>
							</tr>
							<tr>
								<td class="tdnum1"><span class="style_must" >*</span>收入预算总额（万元）：</td>
								<td class="tdnum2">
									<input style="height:25px;" class="easyui-textbox"
									 id="control_detail_srysze" name="fAllAmount" value="${bean.fAllAmount }" />
								</td>
								<td class="tdnum1">剩余预算总额（万元）：</td>
								<td class="tdnum2">
									<input style="height:25px;" class="easyui-textbox"  readonly="readonly"
									id="control_detail_syysze"  />
								</td>
							</tr>
							<tr>
								<td class="tdnum1">基本支出总额（万元）：</td>
								<td class="tdnum2" id="td_jbzcze">
									<input style="height:25px;" class="easyui-textbox" name ="fBasicExpAmount" value="${bean.fBasicExpAmount }" readonly="readonly"
									id="control_detail_jbczze" />
									<a href="#" onclick="openquota()" ><span style="color: red">查看明细</span></a>
								</td>
								<td class="tdnum1" style="text-align: right;">项目支出总额（万元）：</td>
								<td class="tdnum2" id="td_syyse">
									<input style="height:25px;" class="easyui-textbox" name="fProExpAmount" value="${bean.fProExpAmount }"  readonly="readonly"
									id="control_detail_xmzcze" />
								</td>
							</tr>
				</table>
			</div>

			<div data-options="region:'center'" style="border-color: dce5e9">
				<div class="easyui-accordion" style="width:98%;" fit="true"
					border="false">
					<%-- <div title="基本支出-人员支出" style="padding:10px">
						<%@ include file="control-edit-person.jsp"%>
					</div>
					<div title="基本支出-公用支出" style="padding:10px">
						<%@ include file="control-edit-comm.jsp"%>
					</div> --%>
					<div title="本年度项目支出" style="padding:10px">
						<%@ include file="control-edit-year.jsp"%>
					</div>
					<%-- <div title="往年结转项目支出" style="padding:10px">
						<%@ include file="control-edit-least.jsp"%>
					</div> --%>

				</div>

			</div>
			<div region="south" border="false"
				style="text-align: center;padding: 2px 2px 2px 2px;">
				<a
					href="javascript:void(0)" class="easyui-linkbutton"
					iconcls="icon-cancel" onclick="closeWindow()">关闭</a>
			</div>
		</div>
		</div>
		<div data-options="region:'center',split:true"
				style="width: 8px;height: 100%;background-color: #f0f5f7;border-color: #f0f5f7"></div>
				
			<div data-options="region:'east',split:true" style="width:190px;border-color: #dce5e9">
				<%@ include file="control-raws.jsp" %>
			</div>
		</div>
	</form>
	<script type="text/javascript">
	function openquota(){
		var win=creatFirstWin('查看-基本支出',1300,500,'icon-search','/control/quotalist');
		win.window('open');
	}
		$(function(){
			//初始化numberbox-onchange事件
			 /*  $("#control_detail_srysze").numberbox({
				    onChange: function(value) {
				    	total_syysze();
				    	total_jbczze();
				    }
			  }); */
			//收入预算总额
			var m1=$('#control_detail_srysze').textbox().textbox('getValue');
			//基本支出
			var m2=$('#control_detail_jbczze').textbox().textbox('getValue');
			//项目支出
			var m3=$('#control_detail_xmzcze').textbox().textbox('getValue');
			
			var other=m1-m2-m3;
			//设置余额
			$('#control_detail_syysze').textbox().textbox('setValue',other);
		});
		function validateControlAdd() {
			return true;
		}
		function saveEditControl() {
			if (validateControlAdd() == false) {
				return;
			}
			var personOut = getpersonOut();//人员支出
			var commOut = getCommOut();//公用支出
			var yearOut = getYearOut();//本年项目支出
			var leastOut = getLeaveOut();//往年项目支出
			//return;
			$('#control_edit_form').form('submit', {
				onSubmit : function(param) {
					param.personOutJson = personOut;
					param.commOutJson = commOut;
					param.yearOutJson = yearOut;
					param.leastOutJson = leastOut;
					flag = $(this).form('enableValidation').form('validate');
					if (flag) {
						$.messager.progress();
					}
					return flag;
				},
				url : base + '/control/editSave',
				success : function(data) {
					if (flag) {
						$.messager.progress('close');
					}
					data = eval("(" + data + ")");
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						closeWindow();
						$('#control_edit_form').form('clear');
						$("#control_dg").datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
						/* closeWindow();
						$('#control_edit_form').form('clear'); */
					}
				}
			});
		}
	</script>

</body>
</html>


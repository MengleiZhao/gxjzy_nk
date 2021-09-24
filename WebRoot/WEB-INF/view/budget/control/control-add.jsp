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

</style>

	<form id="control_add_form" method="post" enctype="multipart/form-data">
		<!-- hidden -->
		<input type="hidden" name="FBudgetYear" value="${currentYear }" />


		<div class="easyui-layout" fit="true" style="color: #333333;height: 550px" id="div-control-add">
			
			<div data-options="region:'west',spilt:true" 
				style="border-color: dce5e9; width:900px;" id="westDiv">
				
				<div class="easyui-layout" fit="true">
					<div data-options="region:'north'" style="height:120px;border-color: dce5e9;padding-left: 20px;border: 0" >
						<table style="width:100%" class="a_table">
							<tr>
								<td class="tdnum1" style="text-align: right;">年
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								度：</td>
								<td class="tdnum2" colspan="3">
		     						<input id="control_add_year" name="fBudgetYear" style=" height:25px;width:150px" readonly="readonly" class="easyui-numberbox" value="${currentYear }" />
								</td>
							</tr>
							<tr>
								<td class="tdnum1"><span class="style_must" >*</span>收入预算总额：</td>
								<td class="tdnum2">
									<input style="height:25px;width:150px"  class="easyui-numberbox"
									 data-options="iconWidth: 30,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]"
									 precision="2"
									 id="control_add_srysze" name="fAllAmount" value="${bean.fAllAmount }" prompt="请输入收入总额"/>
								</td>
								<td class="tdnum1">剩余预算总额：</td>
								<td class="tdnum2" >
									<input style="height:25px;width:150px" class="easyui-numberbox"  readonly="readonly"
									data-options="iconWidth: 30,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]"
									precision="2"
									id="control_add_syysze" />
								</td>
							</tr>
							<tr>
								<td class="tdnum1">基本支出总额：</td>
								<td class="tdnum2" id="td_jbzcze">
									<input style="height:25px;width:150px" class="easyui-numberbox" name ="fBasicExpAmount" readonly="readonly"
									data-options="iconWidth: 30,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]"
									precision="2" value="${syysze }",
									id="control_add_jbczze" />
									<a href="#" onclick="openquota()" ><span style="color: red">查看明细</span></a>
								</td>
								<td class="tdnum1" style="text-align: right;">项目支出总额：</td>
								<td class="tdnum2" id="td_syyse">
									<input style="height:25px;width:150px" class="easyui-numberbox"  readonly="readonly"
									data-options="iconWidth: 30,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]"
									precision="2" 
									id="control_add_xmzcze" name="fProExpAmount" value="${bean.fProExpAmount }"/>
								</td>
							</tr>
						</table>
					</div>
					<div data-options="region:'center'" style="border-color: dce5e9" >
		
						<div class="easyui-accordion" style="width:100%" fit="true" id="accordion_control_add"
							border="false" >
							<%-- <div title="基本支出-人员支出" style="padding:10px">
								<%@ include file="control-add-person.jsp"%>
							</div>
							<div title="基本支出-公用支出" style="padding:10px">
								<%@ include file="control-add-comm.jsp"%>
							</div> --%>
							<div title="本年度项目支出" style="padding:10px;width:100%"">
								<%@ include file="control-add-year.jsp"%>
							</div>
							<%-- <div title="往年结转项目支出" style="padding:10px">
								<%@ include file="control-add-least.jsp"%>
							</div> --%>
						</div>
		
					</div>
					<div data-options="region:'south'" style="height: 51px;width: 100%; border: 0px; 
						padding-left: 260px;padding-top:15px;">
						<a href="javascript:void(0)" 
							 onclick="saveControl()">
								<img src="${base}/resource-modality/${themenurl}/button/baocun1.png"
									onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/baocun2.png')"
									onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/baocun1.png')"
								/>
						</a> 
						&nbsp;&nbsp;
							<a
							href="javascript:void(0)" onclick="closeWindow()">
								<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png"
									onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/guanbi2.png')"
									onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/guanbi1.png')"
								/>
							</a>
					</div>
				</div>
				
			</div>
			
			<div data-options="region:'center',split:true"
				style="width: 8px;height: 100%;background-color: #f0f5f7;border-color: #f0f5f7";></div>
				
			<div data-options="region:'east',split:true" style="width:260px;border-color: #dce5e9;height: 398px">
				<%-- <%@ include file="control-raws.jsp" %> --%>
				<%@ include file="../../check_system.jsp" %>
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
			  $("#control_add_srysze").numberbox({
				    onChange: function(value) {
				    	total_syysze();
				    }
			  });
		});
		
		function total_syysze(){//剩余预算总额
			//control_add_syysze
			var total = $('#control_add_srysze').numberbox('getValue');
			var num1 = $('#control_add_jbczze').numberbox('getValue');
			var num2 = total_xmzcze();
			//total = total - num2;
			total = total - num1 - num2;
			$('#control_add_syysze').numberbox('setValue',total);
			return total;
		}
		function total_jbczze(){//基本支出总额
			
			var total = $('#control_add_jbczze').numberbox('getValue');
			/* var num1 = total_ryzc();
			var num2 = total_gyzc();
			total = num1 + num2; */
			$('#control_add_jbczze').numberbox('setValue',total);
			return total;
		}
		function total_xmzcze(){//项目支出总额
			
			var total = $('#control_add_srysze').numberbox('getValue');
			var num1 = total_year();
			//var num2 = total_least();
			total = num1;
			//total = num1 + num2;
			$('#control_add_xmzcze').numberbox('setValue',total);
			return total;
		}
	
		function validateControlAdd() {
			if($('#control_add_srysze').numberbox('getValue') == ''){
				alert('请输入收入预算总额');
				return false;
			}
			var least = total_syysze();
			if (least < 0) {
				alert('支出总额大于收入总额，请确认金额！');
				return false;
			}
			return true;
		}

		function saveControl() {
			if (confirm("确认保存么？")) {
			if (validateControlAdd() == false) {
				return;
			}
			/* var personOut = getpersonOut();//人员支出
			var commOut = getCommOut();//公用支出 */
			var yearOut = getYearOut();//本年项目支出
			//var leastOut = getLeaveOut();//往年项目支出
//			return; 
			$('#control_add_form').form('submit', {
				onSubmit : function(param) {
					/* param.personOutJson = personOut;
					param.commOutJson = commOut; */
					param.yearOutJson = yearOut;
					//param.leastOutJson = leastOut;
					flag = $(this).form('enableValidation').form('validate');
					if (flag) {
						$.messager.progress();
					}
					return flag;
				},
				url : base + '/control/save',
				success : function(data) {
					if (flag) {
						$.messager.progress('close');
					}
					data = eval("(" + data + ")");
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						closeWindow();
						$('#control_add_form').form('clear');
						$("#control_dg").datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
						/* closeWindow();
						$('#control_add_form').form('clear'); */
					}
				}
			});
			}
		}
	</script>

</body>
</html>


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


		<form id="control_add_form" method="post" enctype="multipart/form-data">
		<!-- hidden -->
		<input type="hidden" name="FBudgetYear" value="${currentYear }" />


		<div class="easyui-layout" fit="true" style="color: #333333;height: 800px" >
			
			<div data-options="region:'west',spilt:true" 
				style="border-color: dce5e9; width:800px;" id="westDiv">
				
				<div class="easyui-layout" fit="true">
					<div data-options="region:'north'" style="height:120px;border-color: dce5e9;padding-left: 20px;border: 0" >
						<table style="width:100%" class="a_table">
							<tr>
								<td class="tdnum1"><span class="style_must" >*</span>收入预算总额（万元）：</td>
								<td class="tdnum2">
									<input style="height:25px;" class="easyui-numberbox"
									 id="control_edit_srysze" name="fAllAmount" value="${bean.fAllAmount }" prompt="请输入收入总额"/>
								</td>
								<td class="tdnum1">剩余预算总额（万元）：</td>
								<td class="tdnum2">
									<input style="height:25px;" class="easyui-numberbox"  readonly="readonly"
									id="control_edit_syysze"  />
								</td>
							</tr>
							<tr>
								<td class="tdnum1">基本支出总额（万元）：</td>
								<td class="tdnum2" id="td_jbzcze">
									<input style="height:25px;" class="easyui-numberbox" name ="fBasicExpAmount" value="${bean.fBasicExpAmount } readonly="readonly"
									id="control_edit_jbczze" />
								</td>
								<td class="tdnum1" style="text-align: right;">项目支出总额（万元）：</td>
								<td class="tdnum2" id="td_syyse">
									<input style="height:25px;" class="easyui-numberbox" name="fProExpAmount" value="${bean.fProExpAmount }"  readonly="readonly"
									id="control_edit_xmzcze" />
								</td>
							</tr>
							<tr>
								<td class="tdnum1" style="text-align: right;">年度：</td>
								<td class="tdnum2" colspan="3">
		     						<input id="control_add_year" style=" height:25px;" readonly="readonly" class="easyui-numberbox"
									 value="${bean.fBudgetYear }" />
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
					<div data-options="region:'south'" style="height: 51px;width: 100%; border: 0px; 
						padding-left: 180px;padding-top:15px;">
						<a href="javascript:void(0)" 
							 onclick="saveEditControl()">
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
				style="width: 8px;height: 100%;background-color: #f0f5f7;border-color: #f0f5f7"></div>
				
			<div data-options="region:'east',split:true" style="width:190px;border-color: #dce5e9">
				<%@ include file="control-raws.jsp" %>
			</div>
		</div>
		
		
				
		
		


	</form>
	</form>
	<script type="text/javascript">
	$(function(){
		//初始化numberbox-onchange事件
		  $("#control_edit_srysze").numberbox({
			    onChange: function(value) {
			    	total_syysze();
			    	total_jbczze();
			    }
		  });
		//收入预算总额
		var m1=$('#control_edit_srysze').numberbox().numberbox('getValue');
		//基本支出
		var m2=$('#control_edit_jbczze').numberbox().numberbox('getValue');
		//项目支出
		var m3=$('#control_edit_xmzcze').numberbox().numberbox('getValue');
		
		var other=m1-m2-m3;
		//设置余额
		$('#control_edit_syysze').numberbox().numberbox('setValue',other);
	});
		function validateControlAdd() {
			return true;
		}

		function saveEditControl() {
			if (validateControlAdd() == false) {
				return;
			}
			/* var personOut = getpersonOut();//人员支出
			var commOut = getCommOut();//公用支出 */
			var yearOut = getYearOut();//本年项目支出
			//var leastOut = getLeaveOut();//往年项目支出
			//return;
			$('#control_edit_form').form('submit', {
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
		function total_syysze(){//剩余预算总额
			//control_edit_syysze
			var total = $('#control_edit_srysze').numberbox('getValue');
			var num1 =$('#control_edit_jbczze').numberbox('getValue');
			var num2 = total_xmzcze();
			total = total - num2 - num1;
			$('#control_edit_syysze').numberbox('setValue',total);
			return total;
		}
		function total_jbczze(){//基本支出总额
			
			var total = $('#control_edit_jbczze').numberbox('getValue');
			//var num1 = total_ryzc();
			//var num2 = total_gyzc();
			//total = num1 + num2;
			$('#control_edit_jbczze').numberbox('setValue',total);
			return total;
		}
		function total_xmzcze(){//项目支出总额
			
			var total = $('#control_edit_srysze').numberbox('getValue');
			var num1 = total_year();
			//var num2 = total_least();
			total = num1;
			//total = num1 + num2;
			$('#control_edit_xmzcze').numberbox('setValue',total);
			return total;
		}
	</script>

</body>
</html>


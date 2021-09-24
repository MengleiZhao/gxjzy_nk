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
input {
	width: 250px;
}
select {
	width: 240px;
}
.style_must{color:red}
.textbox-text:read-only{background-color: #f6f6f6;color: #999999} 
.textbox-readonly{background-color: #f6f6f6;color: #999999}
.br{font-size: 12px;color: #666666;font-family: "微软雅黑"}
</style>

	<form id="arrange_add_jbzc" method="post" enctype="multipart/form-data">
		<!-- hidden 
			保存类型
			部门指标总表id
		-->
		<input type="hidden" name="saveType" value="add"/>
		<input type="hidden" name="infoId" value="${infoId}"/>

		<div class="easyui-layout" fit="true" style="width: 100%;height:500px;margin-top: 10px">

			<div data-options="region:'north'" border="false"
				style="margin-bottom: 5px;">
				<table style="width:100%" class="a_table">
					<tr>
						<th style="text-align: right;width:80px;">年度：</th>
						<td colspan="3">
     						<input style="width:150px; height:25px;" readonly="readonly" class="easyui-textbox"
     						 name="yaers"
							 value="${currentYear }" />
						</td>
					</tr>
				</table>
			</div>
			<div data-options="region:'center'" border="false"
				style="margin-bottom: 5px;margin-left: 20px;">

				<div class="easyui-accordion" style="width:98%;height:400px"
					border="false">
					<div title="基本支出-人员支出" style="padding:10px">
						<%@ include file="release-add-person.jsp"%>
					</div>
					<div title="基本支出-公用支出" style="padding:10px">
						<%@ include file="release-add-comm.jsp"%>
					</div>
					<div title="项目支出-年度项目支出" style="padding:10px">
						<%@ include file="release-add-year.jsp"%>
					</div>
					<div title="项目支出-历年项目支出" style="padding:10px">
						<%@ include file="release-add-least.jsp"%>
					</div>
				</div>

			</div>
			<div region="south" border="false"
				style="text-align: center;padding: 2px 2px 2px 2px;">
				<a href="javascript:void(0)" 
					 onclick="saveRelease()">
						<img src="${base}/resource-modality/${themenurl}/button/baocun1.png"
							onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/baocun2.png')"
							onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/baocun1.png')"
						/>
				</a> 
				&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png"
						onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/guanbi2.png')"
						onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/guanbi1.png')"
					/>
				</a>
			</div>
		</div>
	</form>
	<script type="text/javascript">
		function total_syysze(){//剩余预算总额
			//control_add_syysze
			var total = $('#control_add_srysze').numberbox('getValue');
			var num1 = total_jbczze();
			var num2 = total_xmzcze();
			total = total - num1 - num2;
			$('#control_add_syysze').numberbox('setValue',total);
			return total;
		}
		function total_jbczze(){//基本支出总额
			
			var total = $('#control_add_srysze').numberbox('getValue');
			var num1 = total_ryzc();
			var num2 = total_gyzc();
			total = num1 + num2;
			$('#control_add_jbczze').numberbox('setValue',total);
			return total;
		}
		function total_xmzcze(){//项目支出总额
			
			var total = $('#control_add_srysze').numberbox('getValue');
			var num1 = total_year();
			var num2 = total_least();
			total = num1 + num2;
			$('#control_add_xmzcze').numberbox('setValue',total);
			return total;
		}
	
		function validateJbzcAdd() {
			return true;
		}

		//saveType 
		function saveRelease() {
			if (validateJbzcAdd() == false) {
				return;
			}
			var personOut = getpersonOut();//人员支出
			var commOut = getCommOut();//公用支出
			var yearOut = getYearOut();//本年项目支出
			var leastOut = getLeaveOut();//往年项目支出
			//历年项目支出leastJson
			$('#arrange_add_jbzc').form('submit', {
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
				url : base + '/release/save',
				success : function(data) {
					if (flag) {
						$.messager.progress('close');
					}
					data = eval("(" + data + ")");
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						closeWindow();
						$('#arrange_add_jbzc').form('clear');
						$("#jbzb_dg").datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
						/* closeWindow();
						$('#arrange_add_jbzc').form('clear'); */
					}
				}
			});
		}
	</script>

</body>
</html>


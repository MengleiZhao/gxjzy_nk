<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>

<style type="text/css">
.tabletop{margin: 0 10px 10px 10px;background-color: #fff;font-family: "微软雅黑"}
.queryth{text-align: right;}
/* 边框 */
.datagrid-header td, .datagrid-body td, .datagrid-footer td{
	border-right: 1px;
	border-bottom: 1px;
	border-style: inset;
	border-color: black;
}
</style>

</head>
<body style="background-color: #f0f5f7;text-align: center;">

		<div style="height: 10px;background-color:#f0f5f7 ">
		</div>	
		
		<div class="tabletop" >
		<table style="width: 100%;font-size: 12px;height:40px;">
				<!-- 所属库 -->
				<input id="project_list_FProLibType" value="${proLibType }" type="hidden"/>
				<input id="project_list_sbkLx" value="${sbkLx }" type="hidden"/>
				<tr>
					<td width="90px" height="25px" class="queryth">
						支出科目：
					</td> 
					<td width="140px">
						<input id="controltz_query_zckm" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					</td>
					<td width="90px" class="queryth">
						归口部门：
					</td> 
					<td width="140px">
						<input id="controltz_query_gkbm"  style="width: 150px; height:25px;" class="easyui-textbox"></input>
					</td>
					<td width="90px" class="queryth">
						年度：
					</td> 
					<td width="140px">
						<input id="controltz_query_nd"  style="width: 150px; height:25px;" class="easyui-textbox"></input>
					</td>
					<td style="width: 24px;">
						<a href="javascript:void(0)" onclick="queryControlTz();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png"
								onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"
							/>
						</a>
					</td>
					<td>
						<a href="#" onclick="clearControlQuery();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" 
								onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"
							/>
						</a>
					</td>
					<td>
						<a href="#" onclick="exportControlTz();">
							<img src="${base}/resource-modality/${themenurl}/button/daochu1.png" 
								onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu1.png')"
							/>
						</a>
					</td>
					
				</tr>
			</table>           
		</div>
		
		
		
		<div style="margin: 0 10px 0 10px;height: 420px;" >
			
			<div class="easyui-tabs" style="width:100%;height:420px"
					border="false">
					<div title="各支出科目控制数" style="padding:10px">
						<%@ include file="control-tzlist-subject.jsp"%>
					</div>
					<div title="各部门控制数" style="padding:10px">
						<%@ include file="control-tzlist-depart.jsp"%>
					</div>

				</div>
		</div>
	


<script type="text/javascript">
function exportControlTz(){
	alert("导出台账信息！");
}
function clearControlQuery(){
	$('#controltz_query_zckm').textbox('setValue','');
	$('#controltz_query_gkbm').textbox('setValue','');
	$('#controltz_query_nd').textbox('setValue','');
	queryControlTz();
}
function queryControlTz(){  
	$('#control_subject_dg').datagrid('reload',{
		subject:$('#controltz_query_zckm').textbox('getValue'),
		depart:$('#controltz_query_gkbm').textbox('getValue'),
		year:$('#controltz_query_nd').textbox('getValue')
	});
	/* $('#control_subject_dg').datagrid({
		url:'${base}/basicExpent/dataSubject',
		method:'post',
		queryParams:{
			subject:$('#controltz_query_zckm').textbox('getValue'),
			depart:$('#controltz_query_gkbm').textbox('getValue'),
			year:$('#controltz_query_nd').textbox('getText')
		}
	}); */
	$('#control_depart_dg').datagrid({
		url:'${base}/basicExpent/dataDepart',
		method:'post',
		queryParams:{
			subject:$('#controltz_query_zckm').textbox('getValue'),
			depart:$('#controltz_query_gkbm').textbox('getValue'),
			year:$('#controltz_query_nd').textbox('getText')
		}
	});
}
</script>
</body>
</html>


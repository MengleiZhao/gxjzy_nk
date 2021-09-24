<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
<style type="text/css">
.blueFont{
	font-size:12px;
	color:#0099ff;
	font-weight:bold;
}
</style>
</head>
<body>
	<div class="easyui-layout" fit="true">		
		<form  id="lawHelp_exportList_from" action="" method="post" data-options="novalidate:true" class="easyui-form">
			<div region="center" border="false" style="background: #fff; border-bottom: 1px solid #ccc;">
				<table class="a_search_table" width="100%">		         
		          <tr height="35">
		             <th class="br"  width="25%">日期：</th>
		             <td class="br" width="65%">
		                <input class="Wdate" type="text" id="lawHelp_exportList_start" value="${startTime}" onClick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly" style="width: 95px;"></input>
		                --
		                <input class="Wdate" type="text" id="lawHelp_exportList_end" value="${nowTime}" onClick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly" style="width: 95px;"></input>
		             </td>
		           </tr>
		     </table>													    
		    </div>
		    <div region="south" border="false" style="text-align: center;padding: 2px 2px 2px 2px;">
				 <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-ok" onclick="lawHelpexportExcel()">确定</a>
				 <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" onclick="closeWindow()">关闭</a>
		    </div>				
		</form>	
		
	</div>
	<script type="text/javascript">
	
	//确定导出
	function lawHelpexportExcel(){		
		var start=$("#lawHelp_exportList_start").val();
		var end=$("#lawHelp_exportList_end").val();
		if (confirm("按当前查询条件导出？")) {
			var queryForm = document.getElementById("lawHelp_exportList_form");
			queryForm.setAttribute("action",
					"${base}/lawHelp/expList?startTime="
							+ start
							+ "&endTime="
							+ end);
			queryForm.submit();
			closeWindow();
		}
	}
	</script>
</body>
</html>


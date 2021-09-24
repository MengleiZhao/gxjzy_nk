<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"></meta>
<title>
</title>
<script src="${base}/resource/highcharts/highcharts.js"></script>
<script src="${base}/resource/highcharts/modules/exporting.js"></script>
</head>
  <body>
  <div class="easyui-layout" fit="true">		
		<div region="center" border="false">
		    <table cellpadding="5" cellspacing="1" class="a_table" 
		    style="width: 70%;margin: auto;border-top: 1px solid #95B8E7;border-left: 1px solid #95B8E7;margin-top: 10px;" >
		    	<tr>
			        <th class="br" colspan="6" style="text-align: center;font-size: 28px;">各居委使用情况统计表</th>
			    </tr>
			    <tr>
			    	<td class="br" colspan="6" style="text-align: center;">
			    		统计时间：
			    		<input id="operations_dates" class="easyui-datebox" value="${dates }"/> - 
			    		<input id="operations_datee" class="easyui-datebox" value="${datee }"/>
			    		<a href="javascript:void(0)" style="margin-left:10px;" class="easyui-linkbutton" 
			    		data-options="iconCls:'icon-search32',size:'large',iconAlign:'left'" 
			    		onclick="queryOperations()">查询</a>
			    	</td>
			    </tr>
		    	<tr>
		    		<th class="br" style="width: 80px; text-align: center;"><strong>居委会名称</strong></th>
		    		<th class="br" style="width: 100px; text-align: center;"><strong>社区走访量</strong></th>
		    		<th class="br" style="width: 100px; text-align: center;"><strong>安全检查量</strong></th>
		    		<th class="br" style="width: 100px; text-align: center;"><strong>实有人口更新量</strong></th>
		    		<th class="br" style="width: 100px; text-align: center;"><strong>社情民意上报量</strong></th>
		    		<th class="br" style="width: 90px; text-align: center;"><strong>用户登录次数</strong></th>
		    	</tr>
		    	<c:forEach items="${listResult}" var="bean" varStatus="vs">
		    		<tr>
		    			
		    			<th class="br" style="text-align: left; <c:if test="${vs.last }">font-weight: bold; text-align: center;</c:if>">
		    				${bean.jwhName }
		    			</th>
		    			<td class="br" style="text-align: right; padding-right: 43px;">
		    				<a href="javascript:void(0);" style="color: blue;text-decoration: underline;"
		    					onclick="javascript:addTabs('社区走访情况','${base}/zfjl/list?jwhIdStr=${bean.jwhId }');">
		    					${bean.num_dzzf }
		    				</a>
		    			</td>
		    			<td class="br" style="text-align: right; padding-right: 43px;">
		    				<a href="javascript:void(0);" style="color: blue;text-decoration: underline;"
		    					onclick="javascript:addTabs('安全检查记录','${base}/inspect/query/list?searchJwhCode=${bean.jwhCode }');">
		    					${bean.num_dzxc }
		    				</a>
		    			</td>
		    			<td class="br" style="text-align: right; padding-right: 43px;">
		    				<a href="javascript:void(0);" style="color: blue;text-decoration: underline;"
		    					onclick="javascript:addTabs('实有人口管理','${base}/person/list?jwhId=${bean.jwhId }');">
		    					${bean.num_syrk }
		    				</a>
		    			</td>
		    			<td class="br" style="text-align: right; padding-right: 43px;">
		    				<a href="javascript:void(0);" style="color: blue;text-decoration: underline;"
		    					onclick="javascript:addTabs('社情民意上报','${base}/opinionsReport/list?jwhIdStr=${bean.jwhId }');">
		    					${bean.num_sqmy }
		    				</a>
		    			</td>
		    			<td class="br" style="text-align: right; padding-right: 43px;">
		    				<a href="javascript:void(0);" style="color: blue;text-decoration: underline;"
		    					onclick="javascript:addTabs('操作日志','${base}/log/list?jwhId=${bean.jwhId}&operateContent=登录');">
		    					${bean.num_yhdl }
		    				</a>
		    			</td>
		    		</tr>
		    	</c:forEach>
		    </table>
		</div>
	</div>
	
	<script type="text/javascript">
	function queryOperations(){
		var dates = $('#operations_dates').datebox('getValue');
		var datee = $('#operations_datee').datebox('getValue');
		addTabs('居委使用情况统计','${base}/operations/list?dateStart='+dates+'&dateEnd='+datee);
	}
	</script>
  </body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="top-table-search-td">
&nbsp;&nbsp;预算年度&nbsp;
<input id="pro_list_query_planStartYear" style="width: 150px;height:25px;" class="easyui-numberbox"/>
&nbsp;&nbsp;支出类型&nbsp;
<select id="pro_list_query_FProOrBasic" class="easyui-combobox" data-options="required:true,editable:false" name="FProOrBasic" style="height:25px; width: 150px;">
	<option value="">-请选择-</option>
	<option value="0">基本支出</option>
	<option value="1">项目支出</option>
</select>

&nbsp;&nbsp;项目名称&nbsp;
<input id="pro_list_query_FProName"  style="width: 150px;height:25px;" class="easyui-textbox"/>
</br>
</div>

<div id='othersearchtd' class="top-table-search-td" hidden="hidden" style="margin-bottom: 10px;">
&nbsp;&nbsp;项目编码&nbsp;
<input id="pro_list_query_FProCode" style="width: 150px;height:25px;" class="easyui-textbox"/>
&nbsp;&nbsp;申报部门&nbsp;
<input id="pro_list_query_FProAppliDepart" style="width: 150px;height:25px;" class="easyui-textbox"/>
&nbsp;&nbsp;申报人&nbsp;&nbsp;&nbsp;&nbsp;
<input id="pro_list_query_FProAppliPeople" style="width: 150px;height:25px;" class="easyui-textbox"/>
</div>

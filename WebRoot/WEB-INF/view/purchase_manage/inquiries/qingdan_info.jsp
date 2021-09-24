<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="dg" 
class="easyui-datagrid"  style="width:660px;height:auto"
data-options="
url: '${base}/cginquiries/findIndex?mainid='+${mainid},
method: 'get'
">
<thead>

</thead>
</table>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@include file="/includes/links.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<script type="text/javascript">
$(document).ready(function(){
  $(".click").click(function(){
  $(".tip").fadeIn(200);
  });
  
  $(".tiptop a").click(function(){
  $(".tip").fadeOut(200);
});

  $(".sure").click(function(){
  $(".tip").fadeOut(100);
});

  $(".cancel").click(function(){
  $(".tip").fadeOut(100);
});
});
</script>


</head>


<body>

	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">数据表</a></li>
    <li><a href="#">基本内容</a></li>
    </ul>
    </div>
    
    
    
    <div class="rightinfo">
	    <table id="searchTable" class="bsgrid tablelist" width="100%">
			<thead>
			    <tr>
			        <th w_index="XH" width="5%;">No</th>
			        <th w_index="ID"  w_sort="ID" width="5%;">ID</th>
			        <th w_index="CHAR" w_sort="CHAR" w_align="left" w_tip="true" width="15%;">CHAR</th>
			        <th w_index="TEXT" w_sort="TEXT" w_align="left" w_length="50" width="30%;">文本</th>
			        <th w_render="operate" width="10%;">操作</th>
			    </tr>
		    </thead>
		</table>
		<script type="text/javascript">
		    var gridObj;
		    $(function () {
		        gridObj = $.fn.bsgrid.init('searchTable', {
		            url: '${base}/view/data/json.jsp',
		            // autoLoad: false,
		            pageSizeSelect: true,
		            pageSize: 20
		        });
		    });
		
		    function operate(record, rowIndex, colIndex, options) {
		        return '<a href="#" onclick="alert(\'ID=' + gridObj.getRecordIndexValue(record, 'ID') + '\');">查看</a>';
		    }
		</script>
    </div>
</body>

</html>

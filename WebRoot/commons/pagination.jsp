<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<script type="text/javascript">
function goToPage(page){
	document.getElementById("page").value=page;
	document.getElementById("pageForm").submit();
}
function changeRows(rows){
	document.getElementById("rows").value=rows;
	document.getElementById("pageForm").submit();
}
</script>
<!--tab-yeshu start-->
   <div class="tab-yeshu .pb-20">
             共${pagination.totalCount}条记录，当前第${page}/${pagination.totalPage}页，每页
    <select style="width:40px;" onchange="changeRows(this.value);">
    	<option value="10" <c:if test="${rows==10}">selected="selected"</c:if>>10</option>
    	<option value="20" <c:if test="${rows==20}">selected="selected"</c:if>>20</option>
    	<option value="50" <c:if test="${rows==50}">selected="selected"</c:if>>50</option>
    </select>
              条 &nbsp;
     <c:if test="${pagination.firstPage}">
     	<a href="javascript:void(0);" class="first">首页</a>
     	<a href="javascript:void(0);" class="first">上一页</a>
     </c:if>
     <c:if test="${!pagination.firstPage}">
     	<a href="javascript:void(0);" class="last" onclick="goToPage('1');">首页</a>
     	<a href="javascript:void(0);" class="last" onclick="goToPage('${pagination.prePage}');">上一页</a>
     </c:if>
     <c:if test="${pagination.lastPage}">
     	<a href="javascript:void(0);" class="first">下一页</a>
     	<a href="javascript:void(0);" class="first">末页</a>
     </c:if> 
     <c:if test="${!pagination.lastPage}">
     	<a href="javascript:void(0);" class="last" onclick="goToPage('${pagination.nextPage}');">下一页</a>
     	<a href="javascript:void(0);" class="last" onclick="goToPage('${pagination.totalPage}');">末页</a> &nbsp;
     </c:if> 
   </div>
<!--tab-yeshu end-->
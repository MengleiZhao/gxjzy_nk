<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
<input type="button" value="默认主题" onclick="changeTheme(1)"/><br/>
<input type="button" value="春季主题" onclick="changeTheme(2)"/><br/>
选择成功后重新登录即可生效
</div>

<script type="text/javascript">
function changeTheme(id) {
	$.ajax({
		type:"post",
		url:base+"/systemthemes/changeTheme",
		data:{id:id},
		success:function(data){
			if(data=="true"){
				alert('选择成功后重新登录即可生效');
			}
		}
	});
}
</script>

</body>
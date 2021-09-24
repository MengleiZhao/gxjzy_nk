<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<body>


<table id="tb_clf" style="width:100%; color: #7efff7; border: #2791eb solid 1px; padding: 0; margin: 0" >
	
<!-- 7efff7 -->
	<tr style="background-color: #2791eb; font-weight: bold; font-size: 12px; height:30px;">
		<td style="text-align: center; color:#7efff7; border-right: #2791eb solid 1px; width:40%;">
			部门名称
		</td>
		<td style="text-align: center; color:#7efff7; width:40%;">
			<span onclick="changeTravelOrd()" style="cursor: pointer;">支出金额（元）</span>
		</td>
		
	</tr>

</table>

<script type="text/javascript">
var year = $('#select_cockpit_year').val();
var departId = '${defaultDepartId}';
loadTravel(year,departId);
var orderType= 'proper';

function loadTravel(year,departId){
	$.ajax({
		url : base + '/cockpit/travelFunds?orderType=proper&year='+year+'&departId='+departId,
		type : 'post',
		dataType : 'json',
		success : function(res){
			$(".tb_clf_tr").remove();	//清除元素
			// 遍历 tr
			$.each(res,function(i,val){
				if(i%2!=0){
					$("#tb_clf").append(
							'<tr class="tb_clf_tr" style="height:22px; font-size: 12px; background-color:#025590 ">'
								 +'<td style="text-align: center; border-right: #2791eb solid 1px; color: #7efff7;  width: 70%;" >'
									+'<span style="cursor: pointer;" onclick="openInner4(\''+val[0]+'\')" onmousemove="bigText(this)" onmouseout="normalText(this)">'+val[0]+'</span>'
								+'</td>'
								+'<td style="text-align: center; color:7efff7;">'
									+'<span id="da1" style="cursor: pointer;" onclick="openInner4(\''+val[0]+'\')" onmousemove="bigText(this)" onmouseout="normalText(this)">'+val[1]+'</span>'
								+'</td>'
							+'</tr> ');
				}else{
					$("#tb_clf").append(
							'<tr class="tb_clf_tr" style="height:22px; font-size: 12px; background-color:#0c6ea2 ">'
								 +'<td style="text-align: center; border-right: #2791eb solid 1px; color: #7efff7;  width: 70%;" >'
									+'<span style="cursor: pointer;" onclick="openInner4(\''+val[0]+'\')" onmousemove="bigText(this)" onmouseout="normalText(this)">'+val[0]+'</span>'
								+'</td>'
								+'<td style="text-align: center; color:7efff7;">'
									+'<span id="da1" style="cursor: pointer;" onclick="openInner4(\''+val[0]+'\')" onmousemove="bigText(this)" onmouseout="normalText(this)">'+val[1]+'</span>'
								+'</td>'
							+'</tr> ');
				}
				
			});
		}
	});
}

//鼠标悬浮样式
function bigText63(t){
	t.style.color="#fff";
	t.style.fontSize="14px";
}
function normalText63(t){
	t.style.color="#7efff7";
	t.style.fontSize="12px";
}
</script>

</body>
</html>

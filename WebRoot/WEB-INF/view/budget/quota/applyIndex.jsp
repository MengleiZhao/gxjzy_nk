<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
	



	<div style="width:190px;border-color: #dce5e9">
		<table class="ourtable2" style="width: 150px;margin-left: 20px;" cellpadding="0" cellspacing="0">
			<tr>
				<td style="height: 28px;"><span style="color: ff6800">指标使用情况</span></td>
			</tr>
			<tr>
				<td valign="top">
					<img src="${base}/resource-modality/${themenurl}/skin_/hengxian.png" style="width: 150px">
				</td>
			</tr>
			<tr>
				<td style="height: 31px;" id="bfb">
					<table>
						<tr style="height: 23px"><td><div id="p1" class="easyui-progressbar" data-options="value:0"  style="width:150px;height: 14px;"></div></td></tr>
						<tr><td>指标总额：500000 万元</td></tr>
						<tr><td>剩余金额：500000 万元</td></tr>
						<tr><td>冻结金额：0 万元</td></tr>
						<tr><td>
							<img src="${base}/resource-modality/${themenurl}/skin_/hengxian.png" style="width: 150px">
						</td></tr>
						<tr><td>预算不够啦？请调整指标预算！&nbsp;<a href="#" style="color: red">指标预算调整</a></td></tr>
					</table>
				</td>
			</tr>
			<c:forEach items="${cheterInfo}" var="li">
				<tr style="height: 30px;">
					<td>
						<a style="color: #666666" id="file${li.systemId}" href="#" onclick="findSystemFile(${li.systemId})">${li.fileName}</a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
			

<script type="text/javascript">

	function start() {
		 var value1 = $('#p1').progressbar().progressbar('getValue');  
	        if (value1 < 100){  
	           value1 += Math.floor(Math.random() * 2);  
	            $('#p1').progressbar('setValue', value1);  
	                if(value1<=30){  
	                    $(".progressbar-value .progressbar-text").css("background-color","#DF4134");  
	                }else if (value1<=70){  
	                    $(".progressbar-value .progressbar-text").css("background-color","#EABA0A");  
	                }else if (value1>70){  
	                    $(".progressbar-value .progressbar-text").css("background-color","#53CA22");  
	                }
	              
	            setTimeout(arguments.callee, 30);  
	        }  
	}
	
	$(document).ready(function(){
		start();
	});
</script>
	